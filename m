Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B47C433EF
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 15:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377241AbiFPPqN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 11:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377191AbiFPPqM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 11:46:12 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFCE39808
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 08:46:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDgnYlmRbqFILf85kxJV9ZmJNaUD2kXkA9WkNqb14pCbcd04LRAOBfCvfWYCFtu5v/kw64iJNlEM+qWy3Q0wbrE9skWmjbC1Kg+0w5Fbgx7sw5ElstsOqwGttgRRSxktQuQrb1tGwwljNF2BhMGLcsuWpT+R2e1smUILbHOCORyZNUjhCwWhSLN9PbDQ2Jp/oOkZqhq7a2ntPwxLcjfxAYJlaF0fUp2GI6zAg+qbDkBBsgE8xP7fmiMqz3xrOKf839OurDHo0TL48JV7h0Orq0mfrSfPf2M6JLSVjl1goU9VhZAEsVymgElxnzDM/xKidSECsZPh/7S2PlApLpoU/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEJXcMIC6yj7fZWIqeozpiRhCchsG6NMYzttGiO3ce0=;
 b=NQ/k2d3OBKineiRaRs6XzA3h5hg/Di23sddrFZ+EX1sIG4rH4ZAJZya7MdfksqK6F/mVAQpz+ILmRczMnK4liCCTPHqYi/pCs84mumx4EZgqHfKJotl/635xmvWT0Wz82gTVSmqn86rqAISfTl2Il0IyJ1Td3KjIIaqoyWZZaqQOvurCq6K7fdWn8ODIzCwRjpoUqSkJBSmZQxqHlGaWKCIctq6p7Y+8umdHKLEVe/yp9r6beulC3T7n1EhWRQn6doHWr0+nsFVlnnYxqURUf1fuEofiC4W0Nw4lwL1NtDr6OY9TD3zfnlJxXdOnijxLBhFljuXaPq85AnqZ6sCpgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=roku.com; dmarc=pass action=none header.from=roku.com;
 dkim=pass header.d=roku.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=roku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEJXcMIC6yj7fZWIqeozpiRhCchsG6NMYzttGiO3ce0=;
 b=uP+lk/hSuwrjjPwdBMIxVVsGqX4pmKtnkE1xjPah1kL3Lfn6eU56Ij896uiWDI9q3tYKsEWFFnsTjNd50HG1VMtNUKK5SvzkwypZXzRp57a9HTE7lgGz6OuIl4xuRbjdEJKYB/kM2y80EbtUI5GV6B1WwZZHyAKoQsdpvrVvzYFyRFYdhEW5SJ1gi33Jv+l5OWAGK3zMAH5JyV2/CY/Kgj798zMNllULT9aejLezl1HomYDIl7F+4Wh88kKAN3O1XRlzmtGJehGeWDBw/g4e0oz4HpYS64S97Kz7NueAybv5oi9Vh5Z2Svkd1mLm+EVkSsyzjy6vq+TCv4nB6l6BSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=roku.com;
Received: from CO1PR01MB7225.prod.exchangelabs.com (2603:10b6:303:160::21) by
 BN6PR01MB2676.prod.exchangelabs.com (2603:10b6:404:d7::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.17; Thu, 16 Jun 2022 15:46:07 +0000
Received: from CO1PR01MB7225.prod.exchangelabs.com
 ([fe80::1062:158b:2993:5535]) by CO1PR01MB7225.prod.exchangelabs.com
 ([fe80::1062:158b:2993:5535%6]) with mapi id 15.20.5353.015; Thu, 16 Jun 2022
 15:46:07 +0000
Message-ID: <1566aed1-a38f-a9ca-241c-21b56d732328@roku.com>
Date:   Thu, 16 Jun 2022 16:46:00 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: [PATCH] mktree: Make '--missing' behave as documented
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        jonathantanmy@google.com
References: <77035a0f-c42e-5cb3-f422-03fe81093adb@roku.com>
 <0067c46a-7bfd-db9c-5156-16f032814464@github.com>
 <797af8c8-229f-538b-d122-8ea48067cc19@roku.com>
 <574dc4a9-b3c7-1fd3-8c0e-39071117c7f0@github.com>
 <YqkpRE8nykqVv8cn@nand.local> <YqlZb3Ycc71+dPu4@coredump.intra.peff.net>
 <ad9b5ec9-14fd-cd66-be87-2fe1eb24296a@roku.com> <xmqqa6adzln6.fsf@gitster.g>
From:   Richard Oliver <roliver@roku.com>
In-Reply-To: <xmqqa6adzln6.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0502CA0015.eurprd05.prod.outlook.com
 (2603:10a6:203:91::25) To CO1PR01MB7225.prod.exchangelabs.com
 (2603:10b6:303:160::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 074bfd3f-ebf7-4af9-31c1-08da4faf53b6
X-MS-TrafficTypeDiagnostic: BN6PR01MB2676:EE_
X-Microsoft-Antispam-PRVS: <BN6PR01MB26763DFB812738D34D9CF9B5CFAC9@BN6PR01MB2676.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L9PykeroIi59cGxPiho2G/jkt6MOiTOyQAuUXRH6Lu5oXRzxeen26djrBJjn0jsrgFK0X04hN+zOtFg+RlGXAocXzwOZRDPVaMfHZMcoq+XKqKArc4ZZHsFv8V4J5trllALWAQTzSAldTvDKHMhdENDM6lE9NPG5HeEkdyxE6cgBZLedDjLujQKypcjMPiX7trncC0L1hAC32x6tYXI8nQ/yg/7LOx8DQLbr192YxinVba8y4WtGGqyAyQJt4xvUPd6S9aAHwsAHuKVPmnGk+CET8+tU16nnEzRD2uNKOWsNxMfW1xa8UkgSubgZbArmtng+5mpYqnK54knXWi7km2WH6RIkdNh9pI14ZIjvSsbWk9NB1b8YcP+aJqCyARq5PgH0SqNwS2fikng1HhDMwHX4aMxZ2+KEABQ8ACI4SwIl1Gq5dCa7urpr6fgFDhqyiPp9nPAD2xB6Inp6kU5eNsqjMok8+e7e5gVitbwc8bN0ONZQjN9DjvnlRjaZ+LExcTZHKGG98cOcs264/AF5ZIY3gh+qZZcHVTJExz4HlKIIT7Lc2A75XxtpKGYKL+ogXfQyCUSRxpOAZh4EendZ2bP4gVgxnu93ssiXCT4Jur5JCyNrCfGk0BqKhJZcTy9YL/7DIvyxE1trupUjQKXmvjxHBm2AN4OtxTX8E/LcGLeuFnd5voK50387Phlqp9aY8L1N7gwTmIJXZkUXqVyjtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR01MB7225.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(66476007)(66556008)(5660300002)(8676002)(36756003)(6506007)(186003)(4326008)(2616005)(53546011)(6916009)(83380400001)(6666004)(54906003)(31696002)(66946007)(316002)(38100700002)(2906002)(6486002)(31686004)(6512007)(508600001)(26005)(8936002)(86362001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1FiK0lmaWVHWGVnWlFOVmdMQk9Md09mYUw5ZlBQRk5RM0xuVHZxWjJwN0Fu?=
 =?utf-8?B?RGgzclBHMzUxQXZlSmdnTXdDOWpZYVQvY1RRemYxK0sxOXBhRVdSKzMrRm05?=
 =?utf-8?B?bS80ZjMvQ0JscUR2L2tENXZuUy9oVW1Zdk82UlBGU212NHYxdW04a2luT0tt?=
 =?utf-8?B?OWk5TjFSNHlOZHhRUUxJUmxUcFJ6SWFha3ordUZOYjB1Wlc5dC9lRWpoY2x3?=
 =?utf-8?B?U3RpOWx6RTFFN1NMUWIvdmR6WTlyUFZLb1UzSnBTZnVtdWZ2S2FpVUlsKzZJ?=
 =?utf-8?B?cnk0RkJhT0N0TFcwOUE4dUdEdG9tNWJTNGpRU284dTlTOVluVSsrMHV1ZGZI?=
 =?utf-8?B?UkwrQ25nb1dMcHZidm1RYjVGcUJGM2g0L0RZNlBrZFhRb2ZiME1ITmVLaVo2?=
 =?utf-8?B?OHVUZlVoa3JzQ3FJb1FNZWpnajJ5VVRYbVA2VmVGUWp3azZvRlFNN0tnMGJq?=
 =?utf-8?B?VW9ZVG5FSkV3c0Y2VDg2SnhEdTZOZlNLSmhVUmNwNXN5dE9XTXdkQTh1Q1Nn?=
 =?utf-8?B?TEc2cm1DYWlhQjZyQ2ZQeXZRbUlOMXp3emJ1Uk1pelUzSnc3T1hZVGttaXRu?=
 =?utf-8?B?L09sOEZ1QXpWbWRIdk5MNTE5MFBoZFRndWM4aFZQQVBOTXE3UDh3T1V5SWFu?=
 =?utf-8?B?Q1VoUW5QdHlINlJzSkRwRm1xQ0ZCejdLUHVwMmFJQnNFMHhvb3h2SUt2MVRi?=
 =?utf-8?B?Q3dDTTcxVUUvRytjWXFaRytwZDRkUCtFSzdRNzRuOXdSc1RuQU8xR1haZGxG?=
 =?utf-8?B?L0VvYW4xTnludnFOY2Z0dHR6MCtNYWw2S1FDalNHdFcxem5qTWhWbGdlcFF5?=
 =?utf-8?B?dFJMRy94ZGx2ZUExTEZSd3didzhtdy9TM3dIanFEc1htcEFTWnJ6aFptMHlu?=
 =?utf-8?B?RnJCSmlCY05VK3RvQkpvWEhUMUIzVVBtcU4rSGk0bUVJdWhOQWduVE9jY2tx?=
 =?utf-8?B?eWkrV2p3c1RpOVRvSEpDRS96WFZDdlBOVEswQTFFbmRIYlRxYmFjZUhsMjNw?=
 =?utf-8?B?MnEyQ1BiOWFnb1JIY2NqbzQ5Wkw5VkRVRUo1SFRFYzJ4OUVrK1FwemRwZStO?=
 =?utf-8?B?OFRhZzJCR080U0FkME4zZ09ubktOYXhIeXB0TS9kdFVUYzc4ZVNldi8xS21r?=
 =?utf-8?B?dDlMRkNZUXo4a0hLNWFjNFJZNXRab2tReCtQWFhWOU9semg4OWlEQThITXFW?=
 =?utf-8?B?R2FTVkRMNDlzS3ZQMitlQUtCd2FLOFVrbnI3WEMydFNVc3lyWmJMUUxpU2gz?=
 =?utf-8?B?ZTBDcGhJNkpVangydnlrdUhNeUY1TjllK2ViMUloYnh1VzYyeWlXdG4wM0RH?=
 =?utf-8?B?WnVIK2w1QzgvNGllNEFwc2dPakZRU056L0xJS0FHNmhPQnAzdGZUeEVKSUFi?=
 =?utf-8?B?Q1pJdmc4TDVHUkxHSnNNa2lXbVVWOG9BcXcvaE5vSFFwYnlhV3dNekpOVlUv?=
 =?utf-8?B?QWtWSnovaUc0WUc1cDhKZWxSZWgwTkZ4TytBbWlTQVZYNVd3QkR2VlpyQU1t?=
 =?utf-8?B?MDU3eHIreElLYUpNTzBMV3ZoYU43bXZuNVF4S3dRSkRmZmdPME5hUEQrOWt0?=
 =?utf-8?B?MTVab3JXWXpnRTZOSnNaa2VTZEM3TTJvQysvS09iZHNCVjRodGVpTlcvZ2tM?=
 =?utf-8?B?aFJVUExiSU5MaFY0elREaC9TTFkwUXNHaXZ0RmlsU1dLQ2hvdG9LT1AvYm5S?=
 =?utf-8?B?TFh3RHhaWUd3U2FRTXFXZ21pRlREaHd6OVRXVzBOOWJTSkp2cWVpMnVIaXZk?=
 =?utf-8?B?ZkdPMG1SQk5iYlc3ZmV6d1dpcnNTb2Ura0dod0hHY0s5WVRxRGx1dEFSNDRm?=
 =?utf-8?B?WmE2QkJTWEN4bEZERkk1Y084cTliMzRmVlJFK2hBbjlJL2FQSzJsa3gxR2hS?=
 =?utf-8?B?UlZabVgySE55N1U3Kzdzc2NhQzhzRVNiSWtheWgxNkl3Nk5JN2hIZ05FbWFY?=
 =?utf-8?B?MDhwYTNxOVdZVWhmVWVTWFJjaVpFZnYvWktSRmdFR0pMRC93c3ZndUNvQVZH?=
 =?utf-8?B?RmhpVGpZRlBKWExBU1p3Njgwa3hRRnJrRFpjYlBkbzNDU2YxVmFkVG5MVVhC?=
 =?utf-8?B?RW5xQnhFaUltMG92bVpySVU4NzNtQUNseHR2Y0lHWk4vM0ZaMXNHbGVpLzlm?=
 =?utf-8?B?SEdGMzVSdUdNVUY3UWFqT1daMm0zUTBqdHZNZVZaNXVidDE2bXl4OXljTnBs?=
 =?utf-8?B?WUR0QmdlVUVqL0I4bTJMWHBvK3UvUTFYdklhQ3BaenZiUk5ZdUhpTWg0SUMx?=
 =?utf-8?B?cWNTRDFxUnhnTnVsdFpFaGJZcFAyTWk5WXpRQmFmaHZtT3duKzR5NEdlWW5q?=
 =?utf-8?B?RUFBZmJDZW1lZW14WDBsUTFncHVob3UzYUZHVFhKSHo4V3EzaFdrdz09?=
X-OriginatorOrg: roku.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 074bfd3f-ebf7-4af9-31c1-08da4faf53b6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR01MB7225.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 15:46:07.3665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00fc7e42-ad65-4c4c-ab54-848ba124a5b7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OQc4BxIgd7iqR5zOpm4utQ/8FcZlo0DkitOsDlk5DoZLrh4FUpCwZSBqBkGWskrPvhjfSavz1w0HPSKjbfDUEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR01MB2676
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/06/2022 22:01, Junio C Hamano wrote:
> We by grave mistake at 31c8221a (mktree: validate entry type in
> input, 2009-05-14) started insisting on inspecting objects even when
> allow-mising was given.  I do not think it was sensible, given why
> we had "--missing" as an option to allow users to say "you do not
> have to be too paranoid".
> 
> The codebase is so distant but I think we should probably do a moral
> revert/reconstruct of that commit so that the extra paranoia of the
> said commit applies only when "--missing" is not in effect, or
> something like that.

-- >8 --
Subject: [PATCH] mktree: Make '--missing' behave as documented

Do not make use of the object store to verify object type for
'allow_missing' objects in mktree_line(). GIT-MKTREE(1) documents
'--missing' as disabling "verif[ication] that each tree entry's sha1
identifies an existing object".

This change retains the check for '<mode>' and '<type>' for
'allow_missing' objects as this check is merely input validation that
avoids interrogating the object store.

Signed-off-by: Richard Oliver <roliver@roku.com>
---
 builtin/mktree.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index 902edba6d2..f41fda6e7d 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -116,15 +116,12 @@ static void mktree_line(char *buf, int nul_term_line, int allow_missing)
 			path, ptr, type_name(mode_type));
 	}
 
-	/* Check the type of object identified by sha1 */
-	obj_type = oid_object_info(the_repository, &oid, NULL);
-	if (obj_type < 0) {
-		if (allow_missing) {
-			; /* no problem - missing objects are presumed to be of the right type */
-		} else {
+	if (!allow_missing) {
+		/* Check the type of object identified by sha1 */
+		obj_type = oid_object_info(the_repository, &oid, NULL);
+		if (obj_type < 0) {
 			die("entry '%s' object %s is unavailable", path, oid_to_hex(&oid));
 		}
-	} else {
 		if (obj_type != mode_type) {
 			/*
 			 * The object exists but is of the wrong type.
-- 
2.36.1.467.g4f6db706e6.dirty

