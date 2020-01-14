Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7FDC33CB2
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 14:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7090C2072B
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 14:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="iMfrQK16"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgANOCX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 09:02:23 -0500
Received: from mail-eopbgr80113.outbound.protection.outlook.com ([40.107.8.113]:33860
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726038AbgANOCX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 09:02:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6eYbXxA8zSgkAaO6uio/0RlMJamfIcJVVSb89N7voXp4z1ah89MlZ/H2myvnv7pvd2UFAtZKR2X7vRx9o/JqqVc8NNebb7UdFaErk7g45kPfKTTTbuBe/YgkcTy77NhR+mLFDqo+pe/fDqZ8GAdiwJ/v7gIZvI+ttcg3zzDXgc3O9vctw5Wa2wNBnrWcZcMPm3EDvoxfxG4Z9l7O8i+0QzbAc7bIDCsE5OR6hlsV9iAu+4/Syx4YjNKL18VMi61Jt79gsw0V3SYEZAniWvF5S+YOaEBNaFtBJHq6uZX3Pd3U6bOOZQVk+NG3MEPib1ZE9DKgBWtetOFNgwaTjZS6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8zXTVsvOEWTOAZqN6m+fdiyEF0rJ4Y+uosNtfru45Q=;
 b=BwccIqd8qDWluBbJwjN2zrl/Dza78f7YaNNg5xnare8JLq9SgIJwBZ7KSH2f008VCf5BlQseseV7dhi4HTp/GbUGUDzWrFk1afcAkTuOzD5INcQW231ZvXvprnvhmR0gfbefvy3IuCVo6xPob3Lm1CJJc/LfQuUbKsMJDILFOWdea9Q1KTkT4MaqRxqeqjwk90ZMabAqzc4sQLgKun0WWjUgZQCzljP0qXl0Dtg5hj9rUgTf1ByFqUqN3PUlSaq6j1ig4+a0KombSAotGN4jiqJgteWvDZoRruYgLPUd/8IYSNMewFE2i2NiqX07pImvum7on/sVRI/ZbcTpsHpzoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8zXTVsvOEWTOAZqN6m+fdiyEF0rJ4Y+uosNtfru45Q=;
 b=iMfrQK16WqYFAkx2oCNPLIhl2SYGEZAg53cX9lsVaGzeZEd8P2DWivM6uSqZ9r0FnJVbo6g0af1oQxy7kmI+TNDKEDIb00JoiEv6JGFdah+bDYphx5uxwYZ9i4/hqU1z4EZINyX7GBahRPpnTj8KDCEZzJFyKNQ321XSJPdd49Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peter.kaestle@nokia.com; 
Received: from AM0PR07MB6179.eurprd07.prod.outlook.com (20.178.20.93) by
 AM0PR07MB5809.eurprd07.prod.outlook.com (20.178.112.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.12; Tue, 14 Jan 2020 14:02:19 +0000
Received: from AM0PR07MB6179.eurprd07.prod.outlook.com
 ([fe80::e818:5bc2:2658:be1f]) by AM0PR07MB6179.eurprd07.prod.outlook.com
 ([fe80::e818:5bc2:2658:be1f%7]) with mapi id 15.20.2644.015; Tue, 14 Jan 2020
 14:02:19 +0000
Subject: [PATCH] Fix submodule status of dirs initialized but empty
To:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Peter_K=c3=a4stle?= <peter.kaestle@nokia.com>
X-Forwarded-Message-Id: 
Message-ID: <23e3d410-5271-a919-aa03-9e776cf72f7c@nokia.com>
Date:   Tue, 14 Jan 2020 15:02:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0301.eurprd05.prod.outlook.com
 (2603:10a6:7:93::32) To AM0PR07MB6179.eurprd07.prod.outlook.com
 (2603:10a6:208:f8::29)
MIME-Version: 1.0
Received: from [10.151.80.182] (131.228.32.182) by HE1PR05CA0301.eurprd05.prod.outlook.com (2603:10a6:7:93::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.10 via Frontend Transport; Tue, 14 Jan 2020 14:02:19 +0000
X-Forwarded-Message-Id: 
X-Originating-IP: [131.228.32.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8c0cfbfb-ce91-41dc-1ca5-08d798fa5ed9
X-MS-TrafficTypeDiagnostic: AM0PR07MB5809:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR07MB580906B4636C45032A5A1055EE340@AM0PR07MB5809.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:597;
X-Forefront-PRVS: 028256169F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(2906002)(6666004)(956004)(2616005)(8936002)(26005)(81156014)(8676002)(31696002)(81166006)(52116002)(6486002)(5660300002)(110136005)(16576012)(66476007)(66556008)(31686004)(66946007)(16526019)(36756003)(478600001)(316002)(186003)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR07MB5809;H:AM0PR07MB6179.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E3WdzxrNfiWM+HiuP9IgprJQecICflvfoU5fHx07PV+550FLubMR/3UMdJuzZnYVZYTt+nJcfhVU9rT+gMOYQ+a9n9yAlsSGzUMeU2rcm97vyMA6bkWtvVVV6anUSzdxk6KKCmItRYfYUZzkon/SUum3CSTm6fTXKOlpJJyD58FsnBsTuYaaBcVD3EBet2qGIJORMFT47ticXZmt5KHlpsXVp3LhnBoApZAhLqjqjAW5bbEwIXD20snvz/X9wkdUl4OAwip8ignIzQiHNH5boId2Epr5XjsqGiAA1gZSlkRLkvc2tnU3UCubVKmIL60ZKNaKElk2N+nezECx0sJ1NqB/kmtCVAHnnWo6Zw6pDQ3GIcOtMDl8qooE5mH3Bm1KAmyXqiLfGLh9auIhYUv/TAPls9EoG8yCPelqrp3ZADXPrq3O4QTKyZYnPaGtEOn0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c0cfbfb-ce91-41dc-1ca5-08d798fa5ed9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 14:02:19.7696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cIHDhmxLslgvNQCQkGHkwPoHEvIBoQ5L3HUgqSHbMOMGT7BG8Tc/vmZ85O0ssJiGrA9aXP7mGuaHTJLML/cULw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB5809
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix submodule status of dirs initialized but empty

Original bash helper for "submodule status" was doing a check for
initialized but not cloned submodules and prefixed them with "-" in case 
.git
was missing inside the submodule directory.
This check was skipped when originally porting the functionality
from bash to C.

Signed-off-by: Peter Kaestle <peter.kaestle@nokia.com>
---
  builtin/submodule--helper.c |   15 +++++++++++++--
  1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c72931e..50bb692 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -782,6 +782,9 @@ static void status_submodule(const char *path, const 
struct object_id *ce_oid,
  	struct argv_array diff_files_args = ARGV_ARRAY_INIT;
  	struct rev_info rev;
  	int diff_files_result;
+	struct strbuf buf = STRBUF_INIT;
+	const char *git_dir;
+
   	if (!submodule_from_path(the_repository, &null_oid, path))
  		die(_("no submodule mapping found in .gitmodules for path '%s'"),
@@ -793,11 +796,19 @@ static void status_submodule(const char *path, 
const struct object_id *ce_oid,
  		print_status(flags, 'U', path, &null_oid, displaypath);
  		goto cleanup;
  	}
-
-	if (!is_submodule_active(the_repository, path)) {
+	
+	strbuf_addf(&buf, "%s/.git", path);
+	git_dir = read_gitfile(buf.buf);
+	if (!git_dir)
+		git_dir = buf.buf;
+
+	if (!is_submodule_active(the_repository, path) ||
+			!is_git_directory(git_dir)) {
  		print_status(flags, '-', path, ce_oid, displaypath);
+		strbuf_release(&buf);
  		goto cleanup;
  	}
+	strbuf_release(&buf);
   	argv_array_pushl(&diff_files_args, "diff-files",
  			 "--ignore-submodules=dirty", "--quiet", "--",
-- 
1.7.1

