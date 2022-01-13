Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE15C433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 13:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbiAMNsb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 08:48:31 -0500
Received: from mail-dm6nam10on2062.outbound.protection.outlook.com ([40.107.93.62]:19253
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235504AbiAMNsZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 08:48:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HC/5ES3hZY6EmY1FyI1qN7DlyvDnn2eY5daPqhZSYsh+BY5h3X1lJEhdDBmHxA6Tw9aPeqE6z5z/yKvRD2My8LL0Nff43eYhzWZ8Fim8ivvfPwl4+UfU+T/3QVXBgq/Yb2w8E0IFt/lRDrQuIHyHKrdDG+6pxhdR6i6YW5wJK4VR3FWVwm3gF1DXgc2HfA73x2HA8ERvqN8ETJPTFbT86xRkPqtkSXAYbpf5BPq/gS7Immnl8lIJSkl897O7Jhz9QiIE+n1Pvf6/Ech5Z+TeA3bQqYypG2kuac97lgpua4kfO4kHR6AGkkCmXJODr5ANtm+tNRbCLQwRmmuHzfNGPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yC41IGU+3kTbLvYknoJJOyPIAtSuBIqip/VyCfEBavs=;
 b=dCAZwG1pR5EadJfDnPZieJ489zReHQmiu2nEXm8s35PS/Q4U2unUwlyIa8YnkprmbCTLO5siz3HrUwT+GI60/n1AM8uAR7pdjpKpfSf/8fMv5ab0cvx0l2oMpwi4XuB50edCINmMcekzybRt1GIj1d94Kf0P9lR/FqIzWzXwX3XcyThYdVOwsP4bj4MlUvzVjd3idMDeQvVcwA+nZeeYFAmPIFpcrSet7Si8g6bYBGFfUB7YeNaNqOoHzcmB0ho+rIRvIIWu5hN72V93G+JYok56R5ly3IDxh+3iXrcVIYtlpkr1BW8HY/kUmG3+Udjx5FBhGnlAV98uivVK36ih+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yC41IGU+3kTbLvYknoJJOyPIAtSuBIqip/VyCfEBavs=;
 b=ieq9ntY1fVHZKtGeymqh3q0OPSGzm04pZe73us+394Yx9KGzBMNI3RNggbGGaPi6gV7EORQEJA4vkC8E6lyHSJ4L/nNvTlyL4gxp7+p/dMepG1O34Gvh8b/8EbgNPpQKqYaWCFa/E3Hfgs98n71g4bq1XWUJxSwQYCJnPdTp7rqTU+8+aIFMhf67wqLWQlGeGUj8ldN0RiDyEVRad/+BrLqEF3/6S0uM5wcb9tu2DwJ+t7MP1EmFGsatMjFzfFFJAWfm8oElDb41gmiDBjnYGXbaF0eA1qRQ/UFc81acgvx+ScTeLnUFjNLMmPEszKVzufYnt/lLDuJcBy215mwKbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by CH2PR12MB3944.namprd12.prod.outlook.com (2603:10b6:610:21::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Thu, 13 Jan
 2022 13:48:23 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 13:48:23 +0000
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
Subject: [PATCH v2 13/21] git-p4: remove redundant backslash-continuations inside brackets
Date:   Thu, 13 Jan 2022 13:47:20 +0000
Message-Id: <20220113134728.23192-14-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220113134728.23192-1-jholdsworth@nvidia.com>
References: <20220113134728.23192-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0101.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::42) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c3292d2-3516-49c8-8d19-08d9d69b5e05
X-MS-TrafficTypeDiagnostic: CH2PR12MB3944:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3944D73EC0D17E777DE3ABF5C8539@CH2PR12MB3944.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:126;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jJv0UkjM/KXYDd5+jo0a9qXaFIwxz/lCwhtdTqNA94Mkqu6IzQ+stD43HPBgjnIJBRORVyZYOvJWFybYICMS18PqFOcT6lA3jhOqBWSFagkIg9PT9mLPAedWSXLdTkcjOCctXOcFnjjsHRbkP75C/lddEISMkeeCQ6qNyo4sgYHyoxWNBAyjwh/1s8NIP9CRE/ragRi43eembqFj3L5O+JlkayAxWouW1DLrcwPZRxoHuMWK0J87WFaIoO/hg85QDJtW8qMh0Pc1iyhl/lOkOTDJMzrDK3vRIWaSlrKRo+yJoqXEpdjDIN5JBVLp+LOowC98hoH9CDoVV2euS20IXIwD809gfszYZF+Hbe9GkVZAPmzJ9g3s3T9oePsq+hn7cpvadiUDJfrgn+Cywczh09ZR87DMAPON1yB4gjdewwwIuN4a7uFT/QZPYFqmGUv6GO/UzDMNqwlcAGYWLa9eINEzJtCr/IwbCQSLftvnX5bW8jgRRIjFdhIh+C9YM8Cj03d/bA6ea4uW8VcymLDtd6NPVJWEhTWRREgmJGXlMwvyL60NZZawDOq0PJO7pnX0FaP9wVuE2hLHXpRoM+5lC1ww2PcQ4qkIPsBRK/NzZiLey6xKU9cx2P2a0F+r3CV8PJdsUl/rnzI/iCdhe0e+Fj9Qd1ApHITebr16TPTTsIvu+7zEf/fQSbvuGtszX1/6O3JKyVF5XFk5lWmgRich0OEuB9U9yEZYANFWg1AJ9EqbhHQtlMe6J0y+uG+AJ6QtfsHXsyV0LOVI3bO9l1QY43GkogOIalk2bhU5BsyrpYE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(66946007)(186003)(66476007)(55236004)(86362001)(316002)(6506007)(26005)(36756003)(7416002)(38350700002)(4326008)(6486002)(8676002)(2906002)(107886003)(8936002)(110136005)(508600001)(2616005)(66556008)(54906003)(38100700002)(1076003)(83380400001)(5660300002)(6512007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RCjk+UkBNea+a+ptfj/PUcABu+nSvOPnr5BQHNg9ZluakMPcMyz9x994gfus?=
 =?us-ascii?Q?G1N08NgK+0mDXVO7Bd24kwTRxwxBRK1/HwJu+fnNGMIPV5Rg7WetPH3xMWCN?=
 =?us-ascii?Q?xQauWPzJ2TPfFdh97WR9vzYJjQirxN2judsmsD2PL4ocOYH36901TbCHcYdH?=
 =?us-ascii?Q?+SKihOOdjNb6RrtI1xl1FRf+kqQ1imvHvujZwXB2843wt66eXzt/CCHUWR8L?=
 =?us-ascii?Q?3aTDVPPdEoeNJMf4pgmG4wM0JfoZR35FNtZ3v4xuiCqftmrTr/ZGKGH+N+3R?=
 =?us-ascii?Q?T7SEoKiLO97z14Or7vIJLUQ4YhEprUoq7mNbzFyrPjCHAsa+LFgRZgdvspsy?=
 =?us-ascii?Q?8dbKlgP2Vq5capAohV9KOoQxlv85Ekp4R36TON9Yk8+IyV5C5sIWfgcyyxuw?=
 =?us-ascii?Q?d+YHA8Mh5pmahuGw5ZAh054MSy3ofBaM01snSYWSJoWHgjyEeOgSLQkF/UQh?=
 =?us-ascii?Q?XZv1v5YX5yvzf+myiAlZztxfDpynggMNAtIXlwJMGJKFcPc+nx69v+HhzJOl?=
 =?us-ascii?Q?DLnytZ+jd3cScRAIU31VHscrXMNZKzquoKaYaySMOajI9K5b1EIqvFaaj7uM?=
 =?us-ascii?Q?/RJ/hzGC9S8qG60wCEuFPOfonZV8bRcdjf3LHH5pIA1bptZQKwHYhqMiutUj?=
 =?us-ascii?Q?dU4cblB3jesrXAIKfgbu31C9VOXtBbBtrxd+4KUNZ/qlLhlvdjef331arQBl?=
 =?us-ascii?Q?95Sqdu8n4HFLK7oAS+MBnuG5o4/qAJAkYUtnjqA8U7rUS3VN6VdcHjadpAET?=
 =?us-ascii?Q?73wZx0NRCqcpnIwYHY9Yfj0WflkV+rIf2s5fG/M69Ia2IrzErzcCwI7MUCco?=
 =?us-ascii?Q?vmpGmT5697JJ9+e41tXY+E7//BHOzEoqTUpPpx0pQYyH08cHktOgIl+vXJKX?=
 =?us-ascii?Q?01ZjIILrN04EmHJ1+H0lhiT2CgjadlJ5JfdHCWdGsdMZKp+4yyqL31CSepin?=
 =?us-ascii?Q?bt+HGa/g2SrYQfZDjLBOw4rMegTEAZxbB+gTCdgg2jzat4eOWdI45iFLErxv?=
 =?us-ascii?Q?FJ76IgwsARIxRGUilriNPEvPu6VCxlcHNRI09wlI+QEBiKtZjptEKMiCEGky?=
 =?us-ascii?Q?5eOMTwp4MsNvN9b1Ypvw1zSt/m8kzpX7Pop6twrW7rDKZHhyufJCfJb3XRvw?=
 =?us-ascii?Q?OARs29CHzUV3Bub+h/L50RJSp5k9dslm1HwGzSoFUu499mvz3xYefbglOcaB?=
 =?us-ascii?Q?+yvax0tQIWbTOLjRB9GlNzJY0LU/UTXH8ipTID2ot2cNKXJ7jwDJbR23tQHv?=
 =?us-ascii?Q?CR8cNayhTxyedpfMXwP/78FIZgVfLfdE3YIGV1rvhewPoaY5xEIfJTMH5j82?=
 =?us-ascii?Q?B201LSOpSoS6A0AUs5uZDaHNvQsvWDjNbexPabJg/mU70GatRTGIuVwB//or?=
 =?us-ascii?Q?WHzyiqW2WmeBSuCaKhFT8d31Rcoas/zPpFV3h8B5Yz6HdWjN7EsaUxFShhxI?=
 =?us-ascii?Q?jIN24ho3MV0EQGmkXpewI74URnQ9Na9dueGz53SwUiSxnTj3V2C6IsVMUKu2?=
 =?us-ascii?Q?fct8LhiETPikhUQjfI066sOx+MZbR5pn5X5RUXu2lAUJbK+ml1x/CBe11MyN?=
 =?us-ascii?Q?6DPcfh4+ZbYGLzIT5SS+X365jOJ+YWanxm0AQJNP/ki0f8ZPEb/4/GuEu8up?=
 =?us-ascii?Q?dlJ2NscibwSFjKRRybp280U=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3292d2-3516-49c8-8d19-08d9d69b5e05
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 13:48:23.6738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yOenldrcjnZMlsSYp7az096ojjPkTt9hE3Tzy0KLnGXjRWTuYUgKJBqE1cIFM9zseo03j+vjYeET2qFheI5+/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3944
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
index 41735181ce..df9fd2195d 100755
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
@@ -4278,7 +4278,7 @@ def run(self, args):
             if not self.cloneBare:
                 system(["git", "checkout", "-f"])
         else:
-            print('Not checking out any branch, use ' \
+            print('Not checking out any branch, use '
                   '"git checkout -q -b master <branch>"')
 
         # auto-set this variable if invoked with --use-client-spec
-- 
2.34.1

