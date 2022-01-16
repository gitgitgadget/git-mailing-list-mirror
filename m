Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B1BC433EF
	for <git@archiver.kernel.org>; Sun, 16 Jan 2022 16:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiAPQIC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jan 2022 11:08:02 -0500
Received: from mail-dm6nam11on2054.outbound.protection.outlook.com ([40.107.223.54]:56160
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235586AbiAPQHz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jan 2022 11:07:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdKSDe7VqcgA2Mgtf2ke/40GZoTt9B9JezpYEiEXUvfXrz2b51hM7u57JXunaFAn5dE11xG52Z9ZD7ZAB8r/eSgYFlP90OamcmgoGI/edcxO4LNw562M5k4RBF5ZNF+lHQPJZkITu3mLLzH/Mvii0u+DcwWL+9VuY6g0gWQgbGsYj5j7qaT/VonwXwvyKNy+CuIQvvIq19fZeZfS7kcpuL8Cjg++ABvM/M1mbcce3tNVjGk1f6IYVdPK6RXnCPhQQks4dpNyKRWlpoPj2Yg5TSOGnAwGi8ug8d65wJoC1l8sv0Dv9/1WNELAcX/73Xlfjlhy/SpGjvN4eS7nmeqkXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJ7tm2s/uMybPu8Cz+ux36EARmYEuVplgf4w/SBazJs=;
 b=RckcXsJM/qbrkcIW+C8mxSsEY08Ui+GIIIVogwHpHQZlmowYIrDxJrJbBbcKLPtQIVYxaYhgJguhVT0G84nsMmOZZBiyrqyRRrz0+lYxJGA1YlXR2TIdsuEYOcQ3n7eKzvDrZ63ahBnn97nRtVo7Io1irOtocqJg0EIAYnehXAOVqY56l/lUBh2imArpNc8C3DluzkKnA/FvNZWALkmRxxZfGlf/X+9PobKKaVyO9t1w2ZZT/Ure9UaLckJPNFl9tudDIzXZJjfQGgMs5I9IxLHvN7Qu3MR0KpU9is2dg/mhDwxOwhlDc/FVPUZtPxN2iTI5HNSLeoDWs9UUKSiWeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJ7tm2s/uMybPu8Cz+ux36EARmYEuVplgf4w/SBazJs=;
 b=HFXwDrGdK1H1lQIJx3bNb6poblcOw6Hiv3zxwKVkIIJ57BIi3ejVdGGp8hIhOadHsZ5Upjp6WUQC0Sftapz0yyRTDyT1dXl6E93LBkfw+OkVk+mz9Vjpk+sMKmMa8qiuYfzjGqXUxpYDYMGDPnpRcgMm+Lj8EwZkgh/FZW5udGmQCiskWMP+pwxVhv3JT48cTiQGo+AIPnPgiMZl8GBr8Ps5tHvOvt7UmhIxc1NgqyYVV5guSVQc3bC/TMIhVi7vWMiqLRV5YH7iopR5AMdiE2wuzWV2RxMYRhxIsmOttpbfXrlVLGnClo5vozkOBvxVyfCp4xi163AAk74Tf/6G/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by BYAPR12MB2597.namprd12.prod.outlook.com (2603:10b6:a03:6e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Sun, 16 Jan
 2022 16:07:38 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.013; Sun, 16 Jan 2022
 16:07:38 +0000
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
Subject: [PATCH v3 13/21] git-p4: remove redundant backslash-continuations inside brackets
Date:   Sun, 16 Jan 2022 16:05:42 +0000
Message-Id: <20220116160550.514637-14-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: cf7c87df-f6b5-4f87-bb28-08d9d90a5145
X-MS-TrafficTypeDiagnostic: BYAPR12MB2597:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2597A9B81D65EB913EB2C8C7C8569@BYAPR12MB2597.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:126;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tV9DX1ilRrUna1yWTlhvVZcWjStGw3qr+rPTCeDPY8EtjbkzF/fg8nXT/s9v0Pq3r08DIJjAFAJd8P153dvR4tHzFitoLUmCqPB/2F4AhYD+pIwcIwiXhkaUT/GUBQzOlkhUhZTt6d7Jy2XhyB8i7uKdPUFafgjL2vAgwfrXIrgFoky/eAGiBlaKdv+Uu+GZHmOZHWE9lWGRYR/JiK/71Prn+3FKWO7AuuGSTYLsnms0wccuZn2b0NtFFqG9u0mi3P3d/BwxzakCtTYWr243YBQ64o5JK30Caum8bDiC/pjhjOv7ZaKAI+qWs0QsgI1Rxqair8FFEK6jva4T5EU+7CMVFx/tK+3zoMDsZsplzYB1q1zC/SRpxEFqiM4+wGXeVQ0EZHqa1b+YXrl6bWgK7r+MFspyUJwE2rNAK9fzMcnv4UfZAfN9PXNzvzT+2Yw+eclcuB4VGK95QmZ5i0tf9FBFkajEMTttu12G2P/5J4RID4llm23f+301GlsYZz76nz0wqK0uXwhTuBsrmksdwVrkNSv1DlBN9sGnf9BAfc+PhhG0JVpV+qealHqadNrZywFW3ombZlmStKDTXQhTRjZNb1gi+5skSpCTxIhtzREM2XwOULyKwcAjRHHXPppGsbWlkdZ/66vBQLovBup6x4iwNg845Bbq+kB/0QlBb9WgUeftJXaKGaYxUFdqrZ0o/2ipjIjPol7JGqM72jNcY2LWrd47SHdMYpeDgKZdZqdldzEZCPRwnOiM6fzmox1DoemHnI3VyOIpbyngKgL2BI8my+7nHEaDcQb/oT8jRzM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6666004)(966005)(38350700002)(38100700002)(8936002)(4326008)(83380400001)(186003)(1076003)(6512007)(110136005)(54906003)(107886003)(8676002)(5660300002)(316002)(66556008)(66476007)(55236004)(6506007)(52116002)(86362001)(36756003)(508600001)(66946007)(2906002)(26005)(7416002)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wqR5lIhuxrbCpjujgwNRFEhEg1aDyzbtqAboiUVJuPQRsRxBznaHNuJuo9m3?=
 =?us-ascii?Q?81DSRJa4ykWf6tnqVMXIHZSuRWa6oLzURY9g8tIZ5URqkLSG2OaKJkPcBrqr?=
 =?us-ascii?Q?znZeVVlrKx+Gl0FpasQvUcUClo2EDRmomaRoIkpww3V2c8DkGy0ac8hztuNb?=
 =?us-ascii?Q?53GvVYBpDvzvId7cNJloHcx1F17DJQXJR3ArTGeZDUtJe6AKFqKbnszBFkaP?=
 =?us-ascii?Q?jmjPJykKbkQLa/nUgpxxb+tYla8kkTv/PDgjju8DM6pvGvSYjRlQcjz3k3+i?=
 =?us-ascii?Q?GWjr5ctNI+DEQ7Zvae97rwQwLRFWfArTtrao/wtl8CfTxYNPpFOhErSpVE4q?=
 =?us-ascii?Q?qn9/gM2jtQSFwdqZ9xcu8fPK3lsIMyFeln5sUtFFIuNVem9Ocb2jLBl3Bdne?=
 =?us-ascii?Q?erd3GNcjmX5DEfSLRxQsnk5z3H2m7Zrk/w/q8zWx225NhpeAeYkM+ZkowotK?=
 =?us-ascii?Q?Rpi/c9iz8DlHXnGkPr31fVHC+fjAQseAZfKYiTLeW2vsMEtizxkcSpFVd+L0?=
 =?us-ascii?Q?I6FEqMJ8Yrorf32s1o6j+LVC/EAorR30wMrAwX/Hj+aPCEP7lfLpxES+Rjwl?=
 =?us-ascii?Q?ECRbMImIbJlk/qLlclr2zaOGM1KP3CeaaBwiOvXAhsEG4yUwaKAHFzVhgsKQ?=
 =?us-ascii?Q?XSAVz6wmwtC0TODuSDK2XJ2TGx9QtqsoJ47r4BNI4RKAJpN/+PT59gl++CEo?=
 =?us-ascii?Q?bR/9FdZGujz81+ooLfa81wHrGZ+hzBsoQQGD7diK8ugHrlnrL5zcijjJ54RT?=
 =?us-ascii?Q?mHs4nlX32R4c4ELEk6v1OU9R5RkHqbZ6Efl+yKjKdJNy6WP4CbpTXl2IyIt+?=
 =?us-ascii?Q?60I/LSgPHH5agvOU1+JvvdDFQB/kIA8x/YyIeJhBkgeHQcz8q7omDe9o+9RB?=
 =?us-ascii?Q?rFhMpkgbgP1lGv2TMEb82gOth86ocW1R932BaF9kaZdGUYftz7zrl9AbxlbE?=
 =?us-ascii?Q?ak8kPQITz4hbhAjSwwgcTQjBbKF3YG0VoDo9Ls/OHHLwqEjUWVNZGx/kBad6?=
 =?us-ascii?Q?I3SsWyCz3ykdLTgdqPgDZ0MtzUq2f3IXrSNyDSQnZoEhuZBNxmkYFHG0UufW?=
 =?us-ascii?Q?hOKQksmpHaO5rf2UnOzvFLCf/nIZEWTjBBCClZGPcPeof7JwPuSmNqHldMRy?=
 =?us-ascii?Q?vfcgCOg9ECjrMXoFfWebRSVEjrvk6nwvlgI7i+MSMbXZWNwwLG2OQX4EkTfK?=
 =?us-ascii?Q?GqgG1SmmszlUJvPdYoUC8olY+dDeO75VbSCA1/cR7tF/WuD4buSUVtM8yhNl?=
 =?us-ascii?Q?PxMjdVEqVpWW22fectf7HJV/pk6EHugfi7TDQxn1+9UUwWomGX8KANllWB1V?=
 =?us-ascii?Q?RamOhh6UgRTmEr7AuJ2e9yPYaovMFEOkDMwzGpLzJqqgomYoG9sAlzXVCRed?=
 =?us-ascii?Q?fl6f2/YllkBjoTU2MHJcAVR2O5UyH8VZodrG4IZ12sxY6Dd4qwe9Kd7zE5mE?=
 =?us-ascii?Q?BCb8KNI44IlL5Vo982OfPYM1FTDmd29EInDTV8RX0BurWhjBcsKH107usdIc?=
 =?us-ascii?Q?h4hInrP7NCknO+wbjgVFoSiPX+sY0vL8hdkF0OBDh/08LT8Rxq/w40axRcYi?=
 =?us-ascii?Q?a4dMTr/0e/xVHn+9M1EqjfddFVwrnYlJV5KXUNg6HvyA4D7vZhAGGnS3UCmF?=
 =?us-ascii?Q?YKRV+akjt0U3yaAU4jWNdXo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7c87df-f6b5-4f87-bb28-08d9d90a5145
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2022 16:07:38.7935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jde8w8aSL3C59rLzKrfd871PBIZN8Hr/fqw490gsHn50aVFpkZymNU2wROGypd0dd36v3K1dSyLbLqStfodY6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2597
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 recommends that backslash line continuations should only be used
for line-breaks outside parentheses.

This recommendation is described in the "Maximum Line Length" section:

https://www.python.org/dev/peps/pep-0008/#maximum-line-length

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index c28edd9e85..971ee52197 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2259,13 +2259,13 @@ def applyCommit(self, id):
                 print("  " + self.clientPath)
                 print("")
                 print("To submit, use \"p4 submit\" to write a new description,")
-                print("or \"p4 submit -i <%s\" to use the one prepared by" \
+                print("or \"p4 submit -i <%s\" to use the one prepared by"
                       " \"git p4\"." % fileName)
                 print("You can delete the file \"%s\" when finished." % fileName)
 
                 if self.preserveUser and p4User and not self.p4UserIsMe(p4User):
-                    print("To preserve change ownership by user %s, you must\n" \
-                          "do \"p4 change -f <change>\" after submitting and\n" \
+                    print("To preserve change ownership by user %s, you must\n"
+                          "do \"p4 change -f <change>\" after submitting and\n"
                           "edit the User field.")
                 if pureRenameCopy:
                     print("After submitting, renamed files must be re-synced.")
@@ -2408,7 +2408,7 @@ def exportGitTags(self, gitTags):
             if self.dry_run:
                 print("Would create p4 label %s for tag" % name)
             elif self.prepare_p4_only:
-                print("Not creating p4 label %s for tag due to option" \
+                print("Not creating p4 label %s for tag due to option"
                       " --prepare-p4-only" % name)
             else:
                 p4_write_pipe(["label", "-i"], labelTemplate)
@@ -2573,12 +2573,12 @@ def run(self, args):
         if not self.no_verify:
             try:
                 if not run_git_hook("p4-pre-submit"):
-                    print("\nThe p4-pre-submit hook failed, aborting the submit.\n\nYou can skip " \
-                        "this pre-submission check by adding\nthe command line option '--no-verify', " \
+                    print("\nThe p4-pre-submit hook failed, aborting the submit.\n\nYou can skip "
+                        "this pre-submission check by adding\nthe command line option '--no-verify', "
                         "however,\nthis will also skip the p4-changelist hook as well.")
                     sys.exit(1)
             except Exception as e:
-                print("\nThe p4-pre-submit hook failed, aborting the submit.\n\nThe hook failed "\
+                print("\nThe p4-pre-submit hook failed, aborting the submit.\n\nThe hook failed "
                     "with the error '{0}'".format(e.message))
                 sys.exit(1)
 
@@ -2601,7 +2601,7 @@ def run(self, args):
                 applied.append(commit)
                 if self.prepare_p4_only:
                     if i < last:
-                        print("Processing only the first commit due to option" \
+                        print("Processing only the first commit due to option"
                                 " --prepare-p4-only")
                     break
             else:
@@ -4264,7 +4264,7 @@ def run(self, args):
             if not self.cloneBare:
                 system(["git", "checkout", "-f"])
         else:
-            print('Not checking out any branch, use ' \
+            print('Not checking out any branch, use '
                   '"git checkout -q -b master <branch>"')
 
         # auto-set this variable if invoked with --use-client-spec
-- 
2.34.1

