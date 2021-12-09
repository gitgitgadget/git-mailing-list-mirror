Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF8DC433FE
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 20:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbhLIUOh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 15:14:37 -0500
Received: from mail-mw2nam10on2045.outbound.protection.outlook.com ([40.107.94.45]:56417
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231695AbhLIUOf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 15:14:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mk/csV7goV85rY3EsQcypoyauGjt/Q0SnyCyICLM91DdlTU+BRtP3iTDjH/oAgsQ5AKC5z3ik7V/eUXxspEa8vt5QXcErLfUm89lsR9u3AWIiD5ftaoH9fD5KGY+tt3ugjgNho6t3AezAF0Jb69JoXXzj6Yw3PX0KmI48+MsZd+mQJPFm7DOiGfZ+/I4o/QsLsvQsb707aIVMfkNXh3xWQbPNiSzjVKANKREthLIfKqR70+lUrQ2HvM1M/6K3JguX+uCu6+3kPABxBYNM8dqzkg+kxE7B6THKXo0iUtZaoBmSq3DuxVRCW+GhYDpKBzDUcW2y3CbbmzX2tczIJNvwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtz4sh85wbhUsmj3P/gl8o593oYlGacUQNKTMyo0H6Y=;
 b=QlqPAJs6Mxmu5jsT0o7zaQfWpiMeUdBzaldL35kxafQ4XyLTaJOSkf4tJiaPSClxxptRUWSMOseZAtyEMKmHaf1DTGRMAdIgYdOXERJ6OCX6QolT7W6NQqD0l4ZZOOZcrYEdfBC375k2KEId6dztGX+Y1Z0FvFH+CeU4sRaF3VDEvTL0VHJBoRAiQoPVquZCcDp0s9BwT6yUkQseZvVyuq4cpvCEovGb5KLW3mJS4NlwpmtJmtq3NFU0XaaO8HCMu/A7OkkMN3Xx+rpwN6Vh1olets7DLM6a/TKEKvHXb+kFKOXVMZpvcn6YcuBG7FoTArA4sa9B2meGWVmv0wertg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtz4sh85wbhUsmj3P/gl8o593oYlGacUQNKTMyo0H6Y=;
 b=Ywagr/7AmRitE/RrJsOzCnT+IgWxIMuYWRMfE563Up+ZD/bJDnIiARy8GQRPbN83iCFkEGkw1KHgUqUlu0KvPjMm03cdEP1HqRjun6m+EJPSFFbD+pS8VeBS298JvwLHsHH8BwR9hhJNK/du7SzZpZ8j/w+HxC/WxNWCA4+r5QIljkszQX+gr8T9zFxiauwN/moVzEu1IQ8Pxdc3X4J7btmvAIzN2DiLs/tZTm5zLfWkneHr49dq1Ku5/S4PZnICCPGlwVMC2qNBp2xJtu9cTl3gdLiaZ2qFjXTPoo8lPpcCtItkTOXc37oRv5Q5h2c8kxifHEEzBwKJ1O8LrGHZMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN8PR12MB3282.namprd12.prod.outlook.com (2603:10b6:408:9e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 20:10:55 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4755.025; Thu, 9 Dec 2021
 20:10:55 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org
Cc:     Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH 6/6] git-p4: Resolve RCS keywords in binary
Date:   Thu,  9 Dec 2021 20:10:29 +0000
Message-Id: <20211209201029.136886-7-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211209201029.136886-1-jholdsworth@nvidia.com>
References: <20211209201029.136886-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P195CA0012.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::17) To BN8PR12MB3361.namprd12.prod.outlook.com
 (2603:10b6:408:67::19)
MIME-Version: 1.0
Received: from red.nvidia.com (195.110.77.193) by AM9P195CA0012.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend Transport; Thu, 9 Dec 2021 20:10:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cb5ed96-f057-4a07-973e-08d9bb5001c9
X-MS-TrafficTypeDiagnostic: BN8PR12MB3282:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB328252CB341299A0A8EA459DC8709@BN8PR12MB3282.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FtfhjTScKhsgkJYrTJiDYKB2idKO5zp53B71jO9t/451moexYcDM3e8shMEv5VVSy9YrSdljO5LDavlseyvgNnEKfN4fTesKOjpIxS06SkJawqnpKtT3NVlv5fAvZ8+meJe3aGdpNG+66vBTDLiCaDD23F9naIA0ePkID7umYySEgpDxxtUC9Un/vKnPgAu3dgCRCYGbY2ShCcyh+oqIFcHHxtwSSZ1oCFnHuWxS9rcKMb9+41N2fY2SVIG+xyzXoI81KndEFvbmwMW9qWFY0WkMSQvfIMODTxSqfKOoGy+Ue2t/0MLcZMigS8+//D3orKQLHnvL8q9c3S8O0jGmq6RTn8EDMHcH87meZ8eHJqbCj8xyAVpKrsYn5CNVPWYBISxqDf7spbKqtwScfGIkWX6h5ppG1nZtxXbYa1dibtK5z9pEoBgWXZ5WukT9vGEKtRth/zU+03p4PD3lXSZI79u7hpfyXCXThsf6WqqmUNk7KhGWhepkJn3OrHniZafAoauCArPrr8q/I/GfL2T/LPBPHGb4DaX/6SaOaEC6CoI1v2RvPP5TbrwGiHNdliDi9Ma2Lh/x3lwNshNCskbugjt0Qwyv0nREGkuPyQwEz1732CfxUeh/GZHkSEDgcWsH5niEIYWj9DEOGatg1bzt4YnO5qWgxHZIDYFiFaIbNp6kRaeGQt2Q+Q6nvNZnBvFBn308VKquS82pGr4IlLz1+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(2906002)(83380400001)(26005)(316002)(6666004)(38350700002)(956004)(508600001)(5660300002)(38100700002)(6486002)(4326008)(52116002)(2616005)(8936002)(36756003)(66476007)(7696005)(55236004)(1076003)(66946007)(86362001)(107886003)(6916009)(66556008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sVhvzQNwz02cQdScTa3pA1EZNqyMGJfWIKMZqWGz7tvFiRFvKyp251BZhBes?=
 =?us-ascii?Q?1vCBnN6/QTtwDPRHtanoRWXir7Rls2AtjQ6VUCKWiJtfgVMctQhX0f2Q7+1y?=
 =?us-ascii?Q?z8LldOQq++KQivee6joziONVcr5rW2HzFvwW4w+Shy0/XO+Vg1UlQ0vfZ/CV?=
 =?us-ascii?Q?VS9fcRPHBRvaNoHsc2R48V5//09/2DtwDLea499PH98gt80xsOGVhNjCL4U/?=
 =?us-ascii?Q?BAKnIHyqvwaipYAABjVu6EOGSWP+L7c2akt+i6CZGc/Uzc9e6GzAl9bAQteT?=
 =?us-ascii?Q?nu/UfYxS4O6erBr+vwKZDyAiw2jC18lTeIC7D1hu6lgkc1F0tFjkPvoxTgw4?=
 =?us-ascii?Q?KEFWpGvRLjL3yDynyaq1bbnOuwxrq61q9IWTDmdhiC9A6XvKTB204dKXYqSX?=
 =?us-ascii?Q?xKeWwUqIUUH7DYYM092agWJcZsOEm6kcGrQLsoJSEAyvjcNUA9YfNxdM0Cgy?=
 =?us-ascii?Q?p7jZD3OmIPZnXyx4HDqY6fO7E5JOQ0128TptulOu6zdMgZWOABpCqEiLeIb8?=
 =?us-ascii?Q?MTlRTanQgFO6st9aoI68qHg5HzuIqcs0TR+0YSQtu51poRLJC0L3Zo4y578u?=
 =?us-ascii?Q?7P8kT4ZaaPoCsvebKueMp+qmMdSvsTN4yO8xShIhWhMJGtsuEON23Qv8u8Sw?=
 =?us-ascii?Q?+eOE3iWNE7T2vjkTDIZiWqzrw47DvjWyuiXvjJM6QVHrwYVR1spNssHth6h2?=
 =?us-ascii?Q?ynkWwpKQUnntv8Yy4AEQ0LykMZZd6s6Cszwa9fjBxtmdy4AI+U4kWwgzq1qx?=
 =?us-ascii?Q?IEwxPTWS4vEe+5YE11X8XLuysE5oKbPJaqgCaAHBFYoqC9nzj6iSr+79HkuV?=
 =?us-ascii?Q?qrBnbPpU/LKMywy5LoegUoX+YEu3yr7c1sZcUBNYriJZRcT7ERRE4/eK4TCB?=
 =?us-ascii?Q?G4/tQ1roGCnr4QDvNkB2RLwnqn2ID/KwHmc2eAYX/TI+DN/wlWGoHMdzoJxp?=
 =?us-ascii?Q?41/7gbeeHA4mlUZ5lb6+FExn7tqyobOB8xcAjHEoxxxvmHAkltUq25P9uv2v?=
 =?us-ascii?Q?/ukOXIQqFJYDFnOjtvLEQdqa8+tODsD44wW7NeHHUmvzMMTqbARfTV7o67c3?=
 =?us-ascii?Q?Y6jh0GqgdDuV2c2i/dJ5aUIcU8ZcX79cN4BTEg++xavs0XtxUh2Sixo5YvBX?=
 =?us-ascii?Q?GKXRk+XQpuhIbfIbsc6MPrOdIvMzwmqW5eCp9I6bzueuCqt/lKCqXxwfZMUr?=
 =?us-ascii?Q?TjdpSya9BUmMm7kJRZewSW66Ld4qsyWOvVKezkdYT+jxt5VgRkWvnTc9gUgZ?=
 =?us-ascii?Q?xEdzkQe7ZiV0nTsr/KGcEhfX7lZ8kEYaR+/GwsB7ofZwPmvh2vZAU5O1Qb4p?=
 =?us-ascii?Q?jb2hRDTyVnepgHHq5uO8M1O8k4caEr3XESxsgezkdwIBAPOrk5eh5POkYP3T?=
 =?us-ascii?Q?oHw3eQ8NRdFGKQs6jhrots7HP5yrzPJpZvY2tYIUlTt2OPWyyi3bde8JDoqP?=
 =?us-ascii?Q?JyVd8f3IaKLNUuESD389ezvEEsd36TOszutVZea4NUBEUOaCMvJDxDoAWU6C?=
 =?us-ascii?Q?XpAIAPIRtRGuhQQFhV3mFbXHJO9P0pDz/ldXvglC9eOogmceN+cQrOBvvqDJ?=
 =?us-ascii?Q?XPhgKFecoRBCjR6UcgGS0wFv3WGJ2IfpXw1Ou4XNlyr6yRqyAESp5jhJCQTW?=
 =?us-ascii?Q?SdmM2ma5+U92jrjFkcEALj0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb5ed96-f057-4a07-973e-08d9bb5001c9
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 20:10:55.3601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hrg3sqDe9jh2G3NOpYj6zsrQ1FPs3Y06KvdvGZV6SaTWRLkReFz7O1TGOLqvyJIte+c362pk84qVcSOBX+6G6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3282
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index c362a5fa38..87e6685eb6 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -46,6 +46,9 @@
 
 p4_access_checked = False
 
+re_ko_keywords = re.compile(rb'\$(Id|Header)(:[^$\n]+)?\$')
+re_k_keywords = re.compile(rb'\$(Id|Header|Author|Date|DateTime|Change|File|Revision)(:[^$\n]+)?\$')
+
 def p4_build_cmd(cmd):
     """Build a suitable p4 command line.
 
@@ -532,20 +535,12 @@ def p4_type(f):
 #
 def p4_keywords_regexp_for_type(base, type_mods):
     if base in ("text", "unicode", "binary"):
-        kwords = None
         if "ko" in type_mods:
-            kwords = 'Id|Header'
+            return re_ko_keywords
         elif "k" in type_mods:
-            kwords = 'Id|Header|Author|Date|DateTime|Change|File|Revision'
+            return re_k_keywords
         else:
             return None
-        pattern = r"""
-            \$              # Starts with a dollar, followed by...
-            (%s)            # one of the keywords, followed by...
-            (:[^$\n]+)?     # possibly an old expansion, followed by...
-            \$              # another dollar
-            """ % kwords
-        return pattern
     else:
         return None
 
@@ -2035,11 +2030,10 @@ def applyCommit(self, id):
                 kwfiles = {}
                 for file in editedFiles | filesToDelete:
                     # did this file's delta contain RCS keywords?
-                    pattern = p4_keywords_regexp_for_file(file)
+                    regexp = p4_keywords_regexp_for_file(file)
 
-                    if pattern:
+                    if regexp:
                         # this file is a possibility...look for RCS keywords.
-                        regexp = re.compile(pattern, re.VERBOSE)
                         for line in read_pipe_lines(["git", "diff", "%s^..%s" % (id, id), file]):
                             if regexp.search(line):
                                 if verbose:
@@ -2968,14 +2962,9 @@ def streamOneP4File(self, file, contents):
             print("\nIgnoring apple filetype file %s" % file['depotFile'])
             return
 
-        # Note that we do not try to de-mangle keywords on utf16 files,
-        # even though in theory somebody may want that.
-        pattern = p4_keywords_regexp_for_type(type_base, type_mods)
-        if pattern:
-            regexp = re.compile(pattern, re.VERBOSE)
-            text = ''.join(c.decode() for c in contents)
-            text = regexp.sub(r'$\1$', text)
-            contents = [text.encode()]
+        regexp = p4_keywords_regexp_for_type(type_base, type_mods)
+        if regexp:
+            contents = [regexp.sub(rb'$\1$', c) for c in contents]
 
         if self.largeFileSystem:
             (git_mode, contents) = self.largeFileSystem.processContent(git_mode, relPath, contents)
-- 
2.33.0

