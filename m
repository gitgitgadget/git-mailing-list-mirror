Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83526C433F5
	for <git@archiver.kernel.org>; Sun, 16 Jan 2022 16:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235605AbiAPQIL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jan 2022 11:08:11 -0500
Received: from mail-mw2nam12on2064.outbound.protection.outlook.com ([40.107.244.64]:61889
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235553AbiAPQIG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jan 2022 11:08:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNe26Oj/zoRLwRfONTXBh0B23zgCswan2jDYD2RJpkaBcsePB+4RG+ygVPBOeDS7tel39VQgoIGyUy4Kt4mRCeWGQybepKGXJcWwvb/hftgt0rixqRHrax4jxNG77PI0TNr7khgbGJXD5r+OpQi0ujDy5iUEcgd+TaVMYFgrmh6nmSPf5umKRocJw7UZ8ZIY3ITbYhLX1WNg2LYpzaRMu+AaOQbyS55ZwvWZKPYh0D5mS6KzAIxx7UArju+sISKgnkabq/KY5goSMdqP+Db+4xhXWMX5UrfSPmRHd4fOdQQ7WL8phmd7zuPveEoRJY23bkXbkxoiDcmIhl1nxyA/YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8s538nXUvrwuv3ukNJTuQkO+1RFp2TdThRqRDO2JPQ=;
 b=LbO5rRVPNlRnNRBhsMqoN3Yt5VIUYaOwW8z8G2GWX55gXatRfhRQm+IctzCJ4bYlIF3Tlz0/cK2wLamcCj6ZmT9DcL7MzdxFEp0cDIqNvhuM5ThHQTRrVRLDfg0oFD/T+yN8zD/m5J9ji/VGJPk6X92TFm0dkzFXM4aEu4SJpXyPpGO5hxCLulOVoSBCNfAAqXUk4+XwWmNgAvipNOwnkxAa2A8BAE8B7fiIYofS/lIPQjhQRvTalQLVmybVBy1FboRzNkY18ROB7e+ewjW69Y9Zt2OP2spp0o8L136C8V6cu5hYGHv7ihN2BQjh6zLwQeSbHsZDx+1+Ka/CpNQkKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8s538nXUvrwuv3ukNJTuQkO+1RFp2TdThRqRDO2JPQ=;
 b=s9wa8AQoG4e6ivy3niY+MfXfVXcDMlCG5OvARNtv3DOMi2asTZ1VcZwapROa+8XOzo41h0v7YQdv1/Xgx/TrIxoRoP4WOkzN8aOt6gLeu5FyyD3meP70O6OzQ/hJiECKh2z0wrDqzVXQ0sGH9pzLcS6A4jYXilg5MzzEIbl8qfAVOFX1zwpn1Kk30ykUrHMq/iU2546XxNHJArEhRpuxihhTb28E7XPrchG06pTJm5vFRpRMCGq7WkWzSl3fou+nfzHneoRQz+VOHRC/VhGfFAFot1RKi45mBH4JX57PyvTfSnUzP2E9gBffDEO0IFmDz+oauW/rLcHfWXRmIvvXvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by BYAPR12MB2597.namprd12.prod.outlook.com (2603:10b6:a03:6e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Sun, 16 Jan
 2022 16:07:48 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.013; Sun, 16 Jan 2022
 16:07:48 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>,
        Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH v3 18/21] git-p4: compare to singletons with "is" and "is not"
Date:   Sun, 16 Jan 2022 16:05:47 +0000
Message-Id: <20220116160550.514637-19-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220116160550.514637-1-jholdsworth@nvidia.com>
References: <20220116160550.514637-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR08CA0019.eurprd08.prod.outlook.com
 (2603:10a6:20b:b2::31) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ff8249a-8b54-4703-8c01-08d9d90a56d3
X-MS-TrafficTypeDiagnostic: BYAPR12MB2597:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2597BD9F893177EB6514B8B3C8569@BYAPR12MB2597.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KJdL4URVjpH8150rqvOmjILEzjD/NZK//7fPARJVV6e0/87j3W+LWF5lEdtc7OdmRKtGgessOI+2ZsocyFGq7INpj8d5TZEuugfzCYmRuOgEk3ubCpjy5C6EAwfQp0EFkyMv7+Y0bioLkPcHZuaGpYNcGia7qshmVJUcI5g+pjt5kHoMfuYOWNvgbP/f9OzztRYVxsbM02kvtqBPM/Ht+V2bPHq/GMMl5VcqRFbwR29PDwI4XWOkVS8ZIdNrG493HSdBKmJI2rIksLcAQjLN4zSd53CsY3oAzpcH+rQG3mYvgBhoguSlusV9OAAuq7sGNP+MbCvqfCfFIxOvDK3Rom/yWt3rQrDkDKw+A2bJIdzAj+90ynf3y1OtX7pXcq9hg1SYDEEfzpnhmGUVQzKVWNX34lsfS+r+UPZMD8D77WnKkJwmqOL917Z1IHkV6412rUyncSwFI8F+MnHaSnxSsMxMlkOGXU+JnKRRiU4Bk6EPPPh3SJ9OJrcYs31n3F+1jj9SB8HwGKt/2OZd9Z9VHFeqwPVsuWje6VVyazGpq/TuxFVZWeRYNs0XCJir57fpV8qnr0Zet0T7pMFvgDLD0n6f2F0hf24XyZENmab6qyIsvjWPnw1YFhun5+tYHM9Ak5Ux/2iNHN/L0G0IzGB0m5bvt4XCjFitjAMvPx6XyzJzKcfw/1OyLG8JFPTOtqgvE2+bTRAgsQyP/OaDy4F43WQXWmWQ/iGOsiz31aMeoz0XVbnb8aQ8Ih8Oo2KHEWd9fgGQflLpQwvHD0QlkK56dVtou/bUuEvZrDzEtzhvllA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(38350700002)(38100700002)(8936002)(4326008)(83380400001)(186003)(1076003)(6512007)(110136005)(54906003)(107886003)(8676002)(5660300002)(316002)(66556008)(66476007)(55236004)(6506007)(52116002)(86362001)(36756003)(508600001)(66946007)(2906002)(26005)(7416002)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tkte+tv/FL5qVUYum/uH9xBDz9Svd+S0m+hRqh26pw1Rx8kAMyLa3iOpU2VQ?=
 =?us-ascii?Q?hUqIOG+dPr0snjOxIVVk1TtWDDR0TeI5YVtOhS3PivRLLsIVNWQZLv0XHruh?=
 =?us-ascii?Q?/aljr6ZQ8EkP3jqvopyHrt99qk5xiQb2CeIKIQJ9Thl/I95BNz0gUdqc1zXV?=
 =?us-ascii?Q?mZmTjfiHKy9kO4Z0fCk7+d/zKpMl0csAb0nzjaRqtsGEdPiJ064XByesVhFp?=
 =?us-ascii?Q?SPiRNSpd6v7shu2KdJ5Z+4xgUDLpICjRS3Vd4dQsfWU9kWtWVPEMZblfNvRD?=
 =?us-ascii?Q?dqFBKXTHwT1rTObsH3Xf3f7BZVxeeaDea58ZzDzIBuFlr5vn3Q7b/vuVey4D?=
 =?us-ascii?Q?bh9U7gBMde2i+/9f2wsXz8E1IXxymXahQ0fPEPlyJVLG6uHlkW1fDbvRPjx6?=
 =?us-ascii?Q?4Ws/xtUynrvx9JdzBEdx0ZvMcJWJ7KDrFax1HrpkF1uQgjE8FfO3Hh5TUUQA?=
 =?us-ascii?Q?aO610kMB6WgOo+MgqPphZObTXMRYaQh7hN0gApVEl3pBockN/Tnq2XfNLypE?=
 =?us-ascii?Q?bTh4hyOl5or0uB1N0U+3jOmF3oP5/zNLbWQO7x2R10bEtYQwr8XjS4rAUjUL?=
 =?us-ascii?Q?0RUEUFkVNiOxJoT2rzQ8QtPbU/Gl/BAjphl518swgsudWXUrzAeOUOjPN9c5?=
 =?us-ascii?Q?0JL7i5tUKyDP3yh3yyQ25OeRLHmf2w4RZYJt1TLA+6MZ/7A3enltGNtSIfjW?=
 =?us-ascii?Q?pIV33zazo8JLnmMSyahSZE10BBsTOdWQzlWX+HghgB6JILEqm8vjbPBN+TQV?=
 =?us-ascii?Q?KXyfvUTv7J91cTTAU3ad81rkXEqZ4O9xaxaj93AZ9B36J0X0qo7t+Q4hOzqi?=
 =?us-ascii?Q?5p2fnSlpqQofhX7xjo+jDyV89GMIDDkc2phGVeUjQWrvZ746XVhiTxDPnlKw?=
 =?us-ascii?Q?VkNKh6DkNMHlQjvb7tOY/3B50OTTm8KGotMSjR0KaaRt2KQBKwUFdGwYaips?=
 =?us-ascii?Q?RXuvGvMgMnsdqZS56l9Alb7IunlFK1eLI0OmAdXME5TgA0/iRSs3LEiNBdgJ?=
 =?us-ascii?Q?QzX3jcgs1hjNHP9xfVknXplzSHKRsHVycozPZ1NOvKV/YtmHBWmSeUgFoCMK?=
 =?us-ascii?Q?Pbmb+4uFkdlyOGDVDMN/bh4SHHbCEbiNyotVNkQ6Emy/Lpr2Edvl8oVz/UWJ?=
 =?us-ascii?Q?xEn0KL9MtJR+vrc6Rj16RKu9JNMkum7hLphPbg8BM+IG/TK61LLLvlFbDmSa?=
 =?us-ascii?Q?0XMJaXeV8AjT195NCnJPwZQJ0BqJ1tn8ekVkvUSIGNUK+ZMK+m51X93awoYn?=
 =?us-ascii?Q?P9O1gI6RSxhjfLtAsvMvnIBRoKfFcwLAIT22JATdYiME2lIXJH0ITXAoASr9?=
 =?us-ascii?Q?us1a1dRVe2yYHhG0PvZCJ4UDWcUTAH0rGPpdQ3qxjPcg9hSmdWJDJ7gfrcDR?=
 =?us-ascii?Q?eb2KSFIy+ChCs72iO1WKBVtz/k95FPm/emQofIe1gX8mfc43FDiJ79v4RON3?=
 =?us-ascii?Q?Q0OIvGWOvP1dJzo9AE16GeQ8UAc/T6tLiOmHfS6BV8n7jBILATcP/2ETu6mj?=
 =?us-ascii?Q?DK6sbBEe6nUUHjdzQk/QkFb9JpJTdSfpruxBPCC4FTksyJtFdRqcWQEkA0Jk?=
 =?us-ascii?Q?cIIPaXL9uBX4fy7bVBCDsJA28foCqYdv031zioZ9A5ogx+et/wkec8TIZ31B?=
 =?us-ascii?Q?LWv8nuFJ3Eza2Xo6eU+FqpU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff8249a-8b54-4703-8c01-08d9d90a56d3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2022 16:07:48.0177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UNYfRwHIjd9K9WQAomJDDvnP43gC3+Uxd3/U7haC3iRker7rHFqmaVBJsxcin8Qhs0wzm9Ocxho/Qa5cC51CYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2597
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 recommends that comparisons with singletons such as None should be
done with "is" and "is not", and never equality operators.

This guideline is described here:
https://www.python.org/dev/peps/pep-0008/#programming-recommendations

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index d71bb7acff..d98ed09f84 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -915,7 +915,7 @@ def p4Where(depotPath):
             if data[:space] == depotPath:
                 output = entry
                 break
-    if output == None:
+    if output is None:
         return ""
     if output["code"] == "error":
         return ""
@@ -937,7 +937,7 @@ def currentGitBranch():
 
 
 def isValidGitDir(path):
-    return git_dir(path) != None
+    return git_dir(path) is not None
 
 
 def parseRevision(ref):
@@ -4483,7 +4483,7 @@ def main():
     global verbose
     verbose = cmd.verbose
     if cmd.needsGit:
-        if cmd.gitdir == None:
+        if cmd.gitdir is None:
             cmd.gitdir = os.path.abspath(".git")
             if not isValidGitDir(cmd.gitdir):
                 # "rev-parse --git-dir" without arguments will try $PWD/.git
-- 
2.34.1

