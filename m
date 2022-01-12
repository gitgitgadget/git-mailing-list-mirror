Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BB4C433F5
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 13:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239874AbiALNt1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 08:49:27 -0500
Received: from mail-dm6nam12on2043.outbound.protection.outlook.com ([40.107.243.43]:61056
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1353747AbiALNsB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 08:48:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=deihxwTIVP3HuyxmwQBklHXJvYb84l8d04JaBWd7HnJlrkJLOAO6q5v4/PAK0kooML8aXsR3tiximCWhYZnsps82bLXwJidrdEZSY9XqcSX5t8I0/MHZLNSbpUdx1gUX1WRT2SiAQL7gWqQ5sCbQznTjE9EYcv0FLcoIAC+wb1pDznVYMA95Hl6tJ7izoLkJSUGcO97b/HxtdWMLUWDl7SgupBIBHDvq/k67i7+K3NWu8Hxzw9eY9rgrOaMxQaQhP6FAwvFaKTMbez23Z9W0rLa8crEbv4pxkzTeF6SB2RVf/6xhxXlgDSnY2cE4QfW3LdruuRpKDN7dKAGOznIwVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNsDq7q8r4PSKe1WkaYlFiim6R+V1ZBXIW4Zq4vWJBc=;
 b=FQvcuPSUR58sl4fMoeHd5uJwsy4qCqM22Z0gVRsdXEgQlB77zQWg5ref+d1Ta80r3naZfdyD62NkkPOl3qE8QK5PG0Rs3oaumNZTzOaNFGXFBD9HNq+wNV8zvQWe/uxrScoSo+h/0hay86jEhtT5qdisnUzrTk1O9QcaGXs4Kj2YpczRhINv5I8sYKD7z1YFeiq9J7sIs9MUqWn6q3qQIR97q4d/v6t4ggLcwE/cJ+KKDxTMF63NYHU+r/g4J8l+dT4X0e7XOb2lB574Y1tpwkbJJym6uY2DYh0QCewsFEMozoiNhcq0MHG95/jlqM1Xs6EqbQTVb9CIoaNUS7TqvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNsDq7q8r4PSKe1WkaYlFiim6R+V1ZBXIW4Zq4vWJBc=;
 b=S9K6OlmJO6EUXYj9rctelvI2E1xN5PudqaoNHMylCBJmQwbhatgW8T2kZaoaJORcvcjjt1dyuxoufxsWQYItmPp4Joq1ASF67EP26yyjWMWqIcNOwA8iqWCy+9ccqD48jLlHxveLtNS7SFU6siaZ/7v679lbeGIdHPUb3NrPNQ1rfy626SOo4mKGoAzrzUKvtUGUuBdA3OfKazdCOF8LSc8m0Ll7BAjZe4m23b2r+1JNtJ4kkcR1NzkTLI6A5I/Va57ryZ8ef+M4rVf8J2Afq0HjA7Go9cYTSG9+kOCIGPwDOW3zupKwR4Iab16SptVttOeCBBa4V7rPJvbLKC9xQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by DM5PR12MB1594.namprd12.prod.outlook.com (2603:10b6:4:e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.11; Wed, 12 Jan 2022 13:47:32 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.010; Wed, 12 Jan 2022
 13:47:32 +0000
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
Subject: [PATCH 12/20] git-p4: remove redundant backslash-continuations inside brackets
Date:   Wed, 12 Jan 2022 13:46:27 +0000
Message-Id: <20220112134635.177877-13-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112134635.177877-1-jholdsworth@nvidia.com>
References: <20220112134635.177877-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR04CA0137.eurprd04.prod.outlook.com (2603:10a6:207::21)
 To BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87192d55-f9f0-4c99-a10f-08d9d5d21503
X-MS-TrafficTypeDiagnostic: DM5PR12MB1594:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB15945B6CC79F3CBEC3E58C1FC8529@DM5PR12MB1594.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:126;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9EH+KpygaUqjXJqykAy1Nwt2lWztT7QRQgQu/o9oMpZcCoZ6So09ShZzssZtTYkkeAA1zLp0qvW9iWxRKQSLDkujR5hpOOmFTc+Nu9I5GFXRAiwEbVkCsHfaI81ZZua8M/fgICUKtGzMinIvRC9P59Pvp3/axJsurOTcakluEnNjSj1DKHeVBo89rVfXaD43Vx/EE/73tlV5SfOj+AczVTCW8cnWViQRFiuAdPtrle9X+vmdkt3AQoMv/79gkeCAxdmm+0bbqWqoBh/6GosgL9hBemUKW84PPUrtomfvbkQhT5XYojbNGBI3LquTE9QiNNfbotr9+UGHQLgKvYK0y4ENdCNHN+449dyLOB1zD56l6ADaJlimRS11u91ujLYre2uajkY6yDyu8vQbRQcpEF8uAskGx/gPaYn4R87TIDlRBSl/94AI2PSqyA19hDMDUWNAxhI6SaK4btaiAwtsdSb4zoVwWERTVcTJeIsU+Ka202nshblWzRpnCW3/agXeXwxnxSlRDzJn4ZoCXQ7r8nEEfjw/3qw4bYMvgT5ZaDg4Wi2Wpk/3wltrlN8GSruf8lUoRH85r3ltWXVQpmzOpOi8P31jaLHKfYdF+NX+tfJUcYFHYREggR5MUhXmyNJGpWOudp8Nf3EAlWC1suB8uXJjFDz+aROkLtpwmE4DD2hpDUKvfqt+QR8Z/k/gz5Q/zaRPAQ6+DfjgNLOHXUNCe9BCSn6ydK6s5M7tiJQHR63fyej4o0ivAqfGVzxusryYhZE8iiURKmgXq/LIS10FOKIpdJ3bk/3w9yJUSrhOi4s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(5660300002)(1076003)(26005)(38350700002)(2616005)(55236004)(186003)(54906003)(66946007)(52116002)(38100700002)(6666004)(8936002)(7416002)(83380400001)(8676002)(107886003)(66476007)(6512007)(508600001)(36756003)(316002)(86362001)(6506007)(2906002)(4326008)(110136005)(66556008)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XCoOx+PLUGHiuQtd/HEq96ae5o9ReakAjRnHPZo8TUQw5xNYMk9K8SdTIm2a?=
 =?us-ascii?Q?0YE0p+ll0HTqMMGSvz14O302VjRcrJzKU2lMTW6x7HArkJPgknRKbsxi2iCP?=
 =?us-ascii?Q?jEcxi3YwwLhPmbx14SZDyPNiYtnU3gImpnJk1diXCrcHTcILdpOQvdUekYEn?=
 =?us-ascii?Q?Xf7+pP09HxU2HAvp43APhpkshkpGl5yRnwsuCvwquGffwaQcOqZVkKYbb3N9?=
 =?us-ascii?Q?aRzlC9xx4JriUloP2yJziP/K+wMEbB7n3Qh7W+INC7VILPs+W4rtSKGooRvD?=
 =?us-ascii?Q?w2cXPmlGOanK4FU8yAkHHuiRXg/rHJbwba35SjQAr6Z4cyBFMkUsoXHk8EGj?=
 =?us-ascii?Q?vJRg/5XORAiXa40/CMdOXQCB4r3zjAa/v8p4Hbd1SNVKETLScLwkhXUSZfQg?=
 =?us-ascii?Q?TOhAX/PC2tD3vjiZ4uK+e96/IkZ3ugOChSlAtYKgKI1n4Ps8wDJ9KjxaQ3+Y?=
 =?us-ascii?Q?DtjH+PeQ+/LlL9KWD+TntLvFsawsI0Qv63DnJWhb9agZEJaynHuUKqqTPcmv?=
 =?us-ascii?Q?SPWjjooGlmjJspGwcwauM0OWMAX8Y/fzUuLFCxsJd7XL2LMP1JJJaq2xeKma?=
 =?us-ascii?Q?idzzEs0lpMdlvwoSZiYSM51gorrnFhI6FXE1re/svVOBEEBn33a7NOgBYYfA?=
 =?us-ascii?Q?zCc61uFUa4aYelaB1rdkBsXl6bYvgop4q5k2bJ6ef5GaMYy1cVMSQaJN+Rfp?=
 =?us-ascii?Q?yR1LHMXogv8gVMYon45wv5a4JcVAmkkzUTv9CuURP7UFqyT0Y6EkSI6cwiiF?=
 =?us-ascii?Q?wb4eLD9ybJMnGygrHWhF5hzviSQoNC7jv79y4JA74g2DtJ0rD3iJb4Z+NHtw?=
 =?us-ascii?Q?Fp7yKHF9lbLdqcM1uO7IWpivwG5lGcNZyti2YWSdIjBvvNQf/QAbkTAdUtrR?=
 =?us-ascii?Q?m6fgljlCzqvagNGj+a8UWXDi975c3/6NCS966YZ7AOz1IzdAHXnX/vyg+IZ7?=
 =?us-ascii?Q?i4fcus5m53GGwjWqSoue1YIbU58qaHA9KDa9LocAYcAepF/ITc9y0fShABNV?=
 =?us-ascii?Q?SctD2B1/E0EuyihokyzjAX4Ru3teYNXP0t0SRNITXfIxalnDjT7wQDydcShL?=
 =?us-ascii?Q?x7pOYm2jJSXW7scluaTEgRF4bFBpNNz6e2fSf35jDnkE1mrhd7dEyekqCKmA?=
 =?us-ascii?Q?vzjbJgNDckrJqnurGaTl1DiepATcP4DrwkpNtBgOl9m5YNEYzQyyXstDBUDX?=
 =?us-ascii?Q?AhYprJNJaQB0i23oVnVn8gf4RFWSsNQeg4CK//Rl0rJO5KnwK5ZcwBfaFXxZ?=
 =?us-ascii?Q?q6w2Q4pLs/Frsy5iJ61RMwYu+ieZLa6wvJ7FgfAVDYT2zhvwPlRhYmAu7DJv?=
 =?us-ascii?Q?WYOoHhNuiZ3FIN62qFRFHAEBXyFwiPO6eDqWJ7ZGsnVSOTLQgjyTfKpklsrN?=
 =?us-ascii?Q?85vwGCxaVti8Eclp1HOTabp6QuctGBTkPo07dMvCoA5sDLt0AI3ds/mjmtk2?=
 =?us-ascii?Q?iKbnuBzGV1PoJqfBobOXXHR9MpCOcA3QoFcZUdnW+zaq+GaQEsYMdAxMb+qX?=
 =?us-ascii?Q?D+5C1lXY1LwhuYu92cnq2BKVDuwYo5Bqk+A88mmswLkuOIygCE9Nn9K4sDIq?=
 =?us-ascii?Q?Sde1ql9Pt/QJLg6CVvpULTVG36357CPgcnngsmCTu6AAdIW3irtMKbKg5e1C?=
 =?us-ascii?Q?hz6ijjk/DxirJEgJFTuxxDc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87192d55-f9f0-4c99-a10f-08d9d5d21503
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 13:47:32.3762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oZgAf6FTLpXn2bHNKd/wHwZ0TYzSHVM1jSWkkigOCam5CXau3hGm5OWfSRbNnEsIakzebhOAapI6JCphlj0/qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1594
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
index f7b6df104f..80101e02a1 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2273,13 +2273,13 @@ def applyCommit(self, id):
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
@@ -2422,7 +2422,7 @@ def exportGitTags(self, gitTags):
             if self.dry_run:
                 print("Would create p4 label %s for tag" % name)
             elif self.prepare_p4_only:
-                print("Not creating p4 label %s for tag due to option" \
+                print("Not creating p4 label %s for tag due to option"
                       " --prepare-p4-only" % name)
             else:
                 p4_write_pipe(["label", "-i"], labelTemplate)
@@ -2587,12 +2587,12 @@ def run(self, args):
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
 
@@ -2615,7 +2615,7 @@ def run(self, args):
                 applied.append(commit)
                 if self.prepare_p4_only:
                     if i < last:
-                        print("Processing only the first commit due to option" \
+                        print("Processing only the first commit due to option"
                                 " --prepare-p4-only")
                     break
             else:
@@ -4275,7 +4275,7 @@ def run(self, args):
             if not self.cloneBare:
                 system(["git", "checkout", "-f"])
         else:
-            print('Not checking out any branch, use ' \
+            print('Not checking out any branch, use '
                   '"git checkout -q -b master <branch>"')
 
         # auto-set this variable if invoked with --use-client-spec
-- 
2.34.1

