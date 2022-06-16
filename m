Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFE9C43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 23:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379431AbiFPXpD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 19:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379421AbiFPXo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 19:44:56 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2036.outbound.protection.outlook.com [40.92.42.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D2762A34
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 16:44:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/03H6SAqE6FpGMcoHkeXGFhIzesLUQRO9BxhDFfonU66O4bHun3rPeiNR7IiRGkyANp5Lh9di762Zxa3cQXlmyhAaEmq0jPTcK4WYzwMS1DTVEpkZY/avaToU6JNWeKAXmZBt1xYRrGqFkWmSM2V0TUuyXm1ByThE1pXuzpwFz1jk2aGsPwWbApvs5lu0u4CR07f/BgJu9OkBamodo5LEvEr784/bLNV1PzTluSc/3lmjg2ZvCvjlUdBoo+qgufL4qYRypdVlnGT8x1g3NCRWqolfFsWJy7pAUbeIGJEo6DNjxytlmpyz9qyxnQfBHDClwLO2RiryH4VKS0wK8Lmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYLgvGHCOTDQdLuwPKyCEhurcLvhWcG0ULmXROflYZ0=;
 b=OaYHgcJfxM/8a/djRmXGqK5CRQkZyHa1rcF23frboMH3bcnek4B3Plxi6nRG8eeUPDdSAwYMBa41eKXYGMdlTt1GdvdmqkopFlqOcpUuobfC+1NTxSrYrtmz38MKGT07Ajadi5UjB3b/9dP1uUNezvQvjWPuzdlX4od/tI+naD8Txcbc4ef2P9D7tzhDrqFGvDETPMBFqjHkJeRhc0+P3m7UylX5sA39OC7z+MRPrBt0dtAQOgISCMBR/PTc2sqlqKs9yeViUEXw0j/obyKzUAcdlm9mXtaQKIie2G6e75kIHhhU/ACT95jeZFE4TzDLFdwfBlD/ax3prKhUmUW2aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYLgvGHCOTDQdLuwPKyCEhurcLvhWcG0ULmXROflYZ0=;
 b=FLslQ12xVwUfzAoT1OZtkyYhdnBat7JiagyshOXsv9vuKaKsQV6fVEdSBnIsjkMJFuu2JoNzYDSf/8jt3qu3IEYl48h1wDaDAlrHUV7G6+CYg9gpsXxR+mJeeHdgFC63znGU3t2AE8Qjf74MXG98VyZi+Wi47+vtuDrXfJjnbfKN+WocvPqqzrC2JBkQzFR4BwZVmtZ4EfgcWlXTf0ubfTmDc9TG/KXn8MC4Q/QLnr6MXGoDwhj09Rh8fH2Y4j1I/CdiZtGYl2Vwsg3THPZ4hzCM5jTGiw0gGiMJ8UoAn+7xAauHWRUmU3Jsy/aFsKxTbSlbXvwhNV0T+X+Ku4qdlg==
Received: from DM6PR13MB2987.namprd13.prod.outlook.com (2603:10b6:5:6::24) by
 DM6PR13MB2521.namprd13.prod.outlook.com (2603:10b6:5:c1::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.6; Thu, 16 Jun 2022 23:44:51 +0000
Received: from DM6PR13MB2987.namprd13.prod.outlook.com
 ([fe80::6cd3:208a:c0e9:df97]) by DM6PR13MB2987.namprd13.prod.outlook.com
 ([fe80::6cd3:208a:c0e9:df97%4]) with mapi id 15.20.5373.009; Thu, 16 Jun 2022
 23:44:50 +0000
From:   Goss Geppert <gg.oss@outlook.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        christian w <usebees@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH v4 2/2] dir: minor refactoring / clean-up
Date:   Thu, 16 Jun 2022 23:44:33 +0000
Message-ID: <DM6PR13MB29871C3B675679262F9960389DAC9@DM6PR13MB2987.namprd13.prod.outlook.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220616234433.225-1-gg.oss@outlook.com>
References: <20220505203234.21586-1-ggossdev@gmail.com>
 <20220616234433.225-1-gg.oss@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [mWl+QMvvKgqUA7pI7cCuZnXn5+YUo9MX]
X-ClientProxiedBy: MN2PR20CA0025.namprd20.prod.outlook.com
 (2603:10b6:208:e8::38) To DM6PR13MB2987.namprd13.prod.outlook.com
 (2603:10b6:5:6::24)
X-Microsoft-Original-Message-ID: <20220616234433.225-3-gg.oss@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf31185e-f9b1-4d80-d5e0-08da4ff23391
X-MS-TrafficTypeDiagnostic: DM6PR13MB2521:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3S3QabA4vu7pF0xhYEdqgNeUWR2SdZjf8ez8wzklBYDp+L5fBmHbwDWiLLaQg9pMTLqNI2xwigDOYZkwZgG+iwr75RkJ/iQHR809W0ZhMa7GCAORAM/iDzpEqDS/k6QJdCCesAYlLnJn9sZrMrBrGXIyxMoywVD535iREQeEWdR4zlCh7zd46Scsn68lpgwEwp+XlcQsTlLS9TQC9AmDMc+wAN5KHF1WoImyYLGNFyspbZIWsAWFrJl5+FvJy1FFtYG9QVGGZfygoNWbf5EuRQ/n3qU3MGTYlrpQdopivAntXYhDJnrhmKRC2hCA/695AsfTy3/v1hqnhxmd/Tkxhrcu18P0FLg1JX87WbDyCK/QFzM3cNrf9quYnb7HsjnoXmBQ/fkbGIuDLEImDjI9PtDDB3BDNVjS94tyNgzEyQGnjmB+Vv5cxfhJpn6pAAkGMpPWRSHGwijR0GVIG/AJAsLZajqMLhOkmOJ4ZtLZ+UPXKWjiGK1WEvLJ4+Vc6c55b15Toa81NRgSwC9QJS9HMHN+a1CsvnxJeaFHN7Tu3NsURS9ZpdUDcLth4nqaTjAXuQ1+r7PKpcULMGmfPUNHYQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EC8rt9ppdZdUsk6sKeIVKIx0y+0sJ8zz++85URo8tA7jcFUOfZC3/RruTfjK?=
 =?us-ascii?Q?mA2O7yXZaM5O60vC4FTOVod0oK/yvCFCYR1o+OOyANdxBVYdcjy+rjwJe0YD?=
 =?us-ascii?Q?NpRNN3BAe4oR09DlDNvbPX5vhvB9M4dpv0PUvLvvs1Yp1Ly+aJHmI6z7SYX4?=
 =?us-ascii?Q?cuW4aqV4rNfM6ZXEfSOH/66MfRsrQR9MQAlxxe0fNr6Z+pWHqDcGnfCuV038?=
 =?us-ascii?Q?q9pPaUoxh+GX0vIhSHLX0JCeHKydrLmp7pZBRrBwhRivszMVIxxxlFVUybl7?=
 =?us-ascii?Q?qztfLTZDVjYGX1pKEieWG0JIUzzUqynLrYwdu8l8C+2oWJX0R6iqK3XkUu9q?=
 =?us-ascii?Q?0o7JRSiVzdDc+VsJZdlLOprYNPmz2Kq9VzoY1tu2ZgYp+Y5PcLxJm8PekJ6D?=
 =?us-ascii?Q?mqInKUU/lwWB7mnaFI56EE6mXvrMx1Np9NWNwnAbv2ybtETYLqWoGYimHOgq?=
 =?us-ascii?Q?aQqHRfwJhSkBARJlqnGNHAUJE0Zdi5eS2bMip/L2+djw4bd9Tow5CZ26Ety2?=
 =?us-ascii?Q?yIH/WrOiHyAq9+SdHp4WKra+sMKTXgvxuu2cUWa5jDL/zy9FgdnxQzPy/M+N?=
 =?us-ascii?Q?hpx1KQ9yEeE/WDB1BV1L2UFwCg2jgASQd8AnLGFMQzoTs3+suGJDU2jzljjl?=
 =?us-ascii?Q?5ZyX1VZZAD2NnT87Wn5n5inqwUXc5Ss+zVGR5FR6/uoV7AK+iy9flNOg0TTS?=
 =?us-ascii?Q?rbVxh0dcygxsF3XNpyovN3QEICg+cqQ0sKn2TTtmk7ZQbFiIZ4bi2o7lie3j?=
 =?us-ascii?Q?UKX36EW7SB2rGERvigP7LiMYYp2cwq07dl0Hmim909q/0CK2WK9pJRkbh8ch?=
 =?us-ascii?Q?jYrV0aym14oOOUL43FWfJhnC2PUGXGoILw2FkpctYWRDiq3GT3/bC3xPTvh/?=
 =?us-ascii?Q?m2nsnujhML3c3kxsG2KpL7/80rNnP7m+M+PGCGt75OUl7tNp+DQePzCIRsWy?=
 =?us-ascii?Q?wf21SStx39X2/0LTpFpeW3KhKRdcAdLi+4VJc1wb+hw+uXgihxltb6GfG1T3?=
 =?us-ascii?Q?Y4DmcR7oWX7T9ZyD/Vg2HoC6LICYckR0G72NOjbsDmgr05qd7WL8UseR8fPe?=
 =?us-ascii?Q?M3i5J2RyhRmkUFWDfHpQk0Ang3hIEleP7Z6hrc5sE7QQGK+DlI4SG/KxW74/?=
 =?us-ascii?Q?9cG1yAXspkNF+FWE0R8jMKiBKCR0WQOGC1UWbB0pR8Dz/+x5n8d2BmoBu5NF?=
 =?us-ascii?Q?p4+Z3t+MUoO2tapP2WZ0DtK2SQ+ZdkVBYKdVL7ShYqdjknJymhegLLXYlR9D?=
 =?us-ascii?Q?oaNTgA0MSt6gSrVSweFgx3/SljZWrevWanm/X25Qh7sUff0ee31bfuqdMzPl?=
 =?us-ascii?Q?nc63Gm96SWUzLzFbJ6bg4agLMIdKSKusEDxxCep9WoXFXT+22mgkZrXLkyW0?=
 =?us-ascii?Q?MWNscv5QsnFXdQ94gCVsWuLowm6zatBrcEwE4n7hG+Zhz827iWBXS40fT4jm?=
 =?us-ascii?Q?xDk3CzYwhoA=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf31185e-f9b1-4d80-d5e0-08da4ff23391
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB2987.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 23:44:49.4409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB2521
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Goss Geppert <ggossdev@gmail.com>

Narrow the scope of the `nested_repo` variable and conditional return
statement to the block where the variable is set.

Signed-off-by: Goss Geppert <ggossdev@gmail.com>
---
 dir.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/dir.c b/dir.c
index c4f41247e0..d7cfb08e44 100644
--- a/dir.c
+++ b/dir.c
@@ -1861,7 +1861,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	 */
 	enum path_treatment state;
 	int matches_how = 0;
-	int nested_repo = 0, check_only, stop_early;
+	int check_only, stop_early;
 	int old_ignored_nr, old_untracked_nr;
 	/* The "len-1" is to strip the final '/' */
 	enum exist_status status = directory_exists_in_index(istate, dirname, len-1);
@@ -1901,6 +1901,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 		 *    manually configured by the user; see t2205 testcases 1-3 for
 		 *    examples where this matters
 		 */
+		int nested_repo;
 		struct strbuf sb = STRBUF_INIT;
 		strbuf_addstr(&sb, dirname);
 		nested_repo = is_nonbare_repository_dir(&sb);
@@ -1916,12 +1917,13 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 			free(real_dirname);
 		}
 		strbuf_release(&sb);
-	}
-	if (nested_repo) {
-		if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
-		    (matches_how == MATCHED_RECURSIVELY_LEADING_PATHSPEC))
-			return path_none;
-		return excluded ? path_excluded : path_untracked;
+
+		if (nested_repo) {
+			if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
+				(matches_how == MATCHED_RECURSIVELY_LEADING_PATHSPEC))
+				return path_none;
+			return excluded ? path_excluded : path_untracked;
+		}
 	}
 
 	if (!(dir->flags & DIR_SHOW_OTHER_DIRECTORIES)) {
-- 
2.36.0

