Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE8DC433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 16:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244710AbiBJQr1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 11:47:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244735AbiBJQrY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 11:47:24 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2087.outbound.protection.outlook.com [40.107.96.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6BCC26
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 08:47:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxAMQMswIGmRgc3zIrIar2muU8nD0SiR45+VSEz9uWk/3CDH3Gg4YDY53e0NsCHaBjPvQ5coNOZSGClMwmO4Ypb6rFSoZe6apRZTcz2R+lVJUBJgU3ylxFuVbmbfTHI2f0BTM24dlGgSLYIP8ammtucjaCwj4BL0T5A3w/+kw9z1ekjleQWB5lrdOswRJxSwqp6WXfeWz6LT4THEP+MkdWoYh5Ared21h+vLMo9Fdq6lx8XkuTwmTaPpGl90nLgQe82rqS8aNPIWuvTiDHsXOy78w8AyJfhkFqCZR5dWdoD1zEeJ6yubgiH1o3UZWeqbTf9dOAspwOFgPAaAz/G+ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwnA2uUnY/ZX/c5Oi5eGpOO5C+bZyvtKUz6Kqb4o+Uo=;
 b=JvBhJmwTCp5jBdPgS7B1KKHojg5Pe4yvSeyZKd83nLv+TsOPbXwv43FtthBeLsicCCGIedRr2GM0p5e6KtkVET4f6A2IKtP9XulLADl3xVPUI+hSSZmJVkunGHwCnqjjdGwEMmdATztpJcHO8/3X5qpGKs4XcuC1snjAy9mUKHT1wLDa4uwblOBctJh1e7uNf8kDe2JbECYmZ2EQHfb5XbcHRTxkrR0YCmF2AEcrr/gMJWKdUb9CSYXCJ8eAQT3v0+bO36xzDK8NK/a1MsINprpDjGQmssDUMKOO9euqacA92cQJw+L6mmL3RF3cS7nufEMsNMAqH4qGr8QdU/WRrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwnA2uUnY/ZX/c5Oi5eGpOO5C+bZyvtKUz6Kqb4o+Uo=;
 b=fWKBZaItgpKH44EaZFLtiR7QUQB51Kec4xqT3HBDR9KYM504jWqrqP/XiaJyRUaa/Jp05idWFtskSjg31OIhwWpqveb8QvmfUNStA/R42CwJfCcofXbruepRcUB9eBh0Yh8ucdvR6BYZBtAykcHw+5zUQ53bvd45fsAqcSBL3aWPyvlrtzXo8jY0368yiTwTBTfY5+npywZYSolbJ+n1YdW3BIw6DsIhnA2rC9Ts1T5QZs15NtlFMvj0/UnMGne4BLKYr3lis7nl7KLy30vGft9IzyY35CUAxcjHxqQWD9l8NhoY1fpXtQoh+6lAA1O4oSKyOAGNHufcjbpxls/MjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by BN6PR12MB1362.namprd12.prod.outlook.com (2603:10b6:404:1a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 16:47:20 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10%2]) with mapi id 15.20.4951.021; Thu, 10 Feb 2022
 16:47:19 +0000
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
Subject: [PATCH v4 13/22] git-p4: remove redundant backslash-continuations inside brackets
Date:   Thu, 10 Feb 2022 16:46:18 +0000
Message-Id: <20220210164627.279520-14-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.35.GIT
In-Reply-To: <20220210164627.279520-1-jholdsworth@nvidia.com>
References: <20220210164627.279520-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0069.eurprd04.prod.outlook.com
 (2603:10a6:208:1::46) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27a56a08-ef28-46a0-0984-08d9ecb500d0
X-MS-TrafficTypeDiagnostic: BN6PR12MB1362:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1362D5BD95B4824553AFFB12C82F9@BN6PR12MB1362.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:126;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c2vB9hDVdmmRbe5xKnv68tMHRHdxbv0ffFJkIN59XZEvLnn5eOBuwTgp+dO/e7sxSn8ElXSSUOdceaxfesBdedvfnkCC5gNm2156xMYgpIUSyx1MGu4RvVBoRK/s4zT+sjVZ6U1wVO6zpgksHGE/3sFVF/8SsRvfNj37Qqaqnq79egmZNdcQ9KMSDtfZWOd9h80ZGRi6QqdkuHUTNM7WOLyCkgxhEAET1HvviHDn5n66GORKECCxh6qUyqHmX27xvva0NbogZzpzQn4jWtkg6DiGjoanxaudcaWazM/V4gox+n2oj8XZtSrK0G9ygOT04464TbFYrsJKtbJvWZFlW0YP4ShqW2/SGE4WaDBW9Ah7qNxOWPnKpHai78g0QTtj8EVPyh62QKq9xrMy+8Er/chClqr9eQzPAyv8zaaZjPtubQsJaNcrqzP/9hNRpRG4wiBK9WaE4TNUNNcII6Nja4K/PA11igSJdzZfOqPupv9d9m76J/m/R69VLqglKhsDAsAlNLNMQCn745CODkg7c2Z0A7I/uEGqGe2DTP1KpNyCCxNIIRIXm8tSEIh3T4Zz2vx/4h0Tb4XIFvu1GYob2I7QHUvKKJ1Kbm0hu8f+xnQQhS6/fgR4I1e5PGUuc5HW67CIOWUAjzHfiyFnUYUiSsXjZyby68X3/fWFfQD6qS1D7UHzchgU96VCb5nnQxE+etQ0ZGsaTb2O0cYcM/t8/iEqlL7P6bZ5fMeI9yGrOkEBmTjtMJkixW8Xl2x+VucBeCkRmK/5AaoZRmSdecYn5+wFpos10N/XdBJOk58buhk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(6486002)(966005)(7416002)(2906002)(8676002)(66946007)(52116002)(6506007)(8936002)(83380400001)(2616005)(38100700002)(38350700002)(4326008)(1076003)(107886003)(508600001)(66556008)(66476007)(5660300002)(6512007)(36756003)(55236004)(316002)(110136005)(54906003)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C80wLtmmJGBZ+vrK1wXRjY6//NBTciTnesswHx1nrqfodVwIcXrwQ/dnPAmi?=
 =?us-ascii?Q?aryARF81sNa2UFoB/9QPdIYCTFuBkFmQn0aEE4MsmnmIdEY5MW6qROO1r27S?=
 =?us-ascii?Q?HYn8mKU/2clYbbynvAwh8+/jI4PMZJLkp1RQhP8jpxSwjvzpRdGfMQR4u0ht?=
 =?us-ascii?Q?AgG/QfhQJaYm+2tdUkkiCCjXGHGMHQTH9RG+wL6mmtnEghJe8pc4vFX+Z7+U?=
 =?us-ascii?Q?UM0IWssgOgGWQwO+Znp9GewzC+svKVKytyUI/cGOg2DUUa51PAOn+02m6KWZ?=
 =?us-ascii?Q?32958XbrWkIeJCSy5WDOEAxBFmMmS9bHNpGgtD3Zyra2Rj5CyPfSnMkHn30j?=
 =?us-ascii?Q?g0y8FSlkmHCj82mKh7oh/z9N1fKyt6mLLym7NcqIZsTjqh/VcghLLB9hLS5G?=
 =?us-ascii?Q?TyT5ASWvFMuoTeEKePZ3SaYl3OgJC0/SSQsdXMb7B+ljJAuxlo7vutHMBeOX?=
 =?us-ascii?Q?HDoBurXfYrrOiwGXxXVL7XJmkxPIl8H7sVhFg+pBArkbvuCGELqS/BTamBKl?=
 =?us-ascii?Q?671vXqRWRh42eITFEwL5xr84202VKYlFd50x05J8q9Cbn8qUWRwrV+cNjfMx?=
 =?us-ascii?Q?cFq0iS+phtol5J2rOkUf5xfeKRPox+CAsYl8UMddsD3nelJ+r/oCafrQjyHL?=
 =?us-ascii?Q?xKpH2PBIxFdCV+b0Y8m7kWK7UNik3qZ0ZoBgw0hXl959xWTbnfCMgyUBdAYm?=
 =?us-ascii?Q?tLdz1dyLLigVg66znNrutyUJuuNW9QqOy6ukZ2wv61qnDY/JpNZsr+j3D3pt?=
 =?us-ascii?Q?ubz8myBfxuIHLr0tOscxfVsP1rPsv0c5gvgZuxX8nwtw2wWfn4K5HVrqoHMR?=
 =?us-ascii?Q?31fOhTRbc3RvFJmWOChW3qr5vPpenwY04dhughWDw75nBEzGNTI4+xkIEIX5?=
 =?us-ascii?Q?kbMEYq4ZkGuIirnnSlxJAxM4ZwDtJ+vuirEir4tX8ymIP32MOqyPBWCdxx13?=
 =?us-ascii?Q?bSFTCvq7XYmYre0CV3KXqpW1sQUf2qrJtNqfL5PjXkK6bP40vT1RUPqUmMfG?=
 =?us-ascii?Q?LGNjOd2TxVLbG+NOwSBjb76BMygEapXLgsbE85G+jZTsvW6FdUWPuxDXneCW?=
 =?us-ascii?Q?RqwQup2j3hxKMFpQSWXPYXZnIIAtKmaILGplSDRoQ1Oug4FOth9RlDi7quZ3?=
 =?us-ascii?Q?EapsEuDWakvrvND2FvwMdcNSc7hriFW+xjjq4mBxgx+LyiDYn7yQqE9LFAN4?=
 =?us-ascii?Q?r3ZtnKO89xONI5Gdsvbvg89QqAYfmH7xHLLDTN69pxaCKEDF+UBJ9mE8d2h1?=
 =?us-ascii?Q?ZJU3u5EfuTqMxm3KnHgyv2Yzt6Ar+qoAY0rpZ7jII2v3fM0HuXCCcZCPIeUD?=
 =?us-ascii?Q?QsjZKHMFbMOzSNNhNshGqG8A5NiBRGwAEEdHv+KD/dJY0Arx+pPaXpCfavsY?=
 =?us-ascii?Q?vlc65cYkn8v4AwRQXpMA69T0LHUE4ib1Yd0CyloH+JCoMpKogwHbmPuWiTlk?=
 =?us-ascii?Q?+/fdXzYTK2gwnHK4uU//SMFv+DH1IFrODMYRH7ZI19QMMklJdwO1kyOTMySp?=
 =?us-ascii?Q?sdROokUdZuF1M/OO0fgiaMNbmimJHm5xQSY8V1j7I4wGAsbEIJf6BmsCuExE?=
 =?us-ascii?Q?b9iSBYVUK2zOS4UhlSR092OR+mH54uxwSULlpXFi/P3xWj3EDw6B/ELNjcyD?=
 =?us-ascii?Q?R/kybDT7bx9GiQ5wnEBxqdQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a56a08-ef28-46a0-0984-08d9ecb500d0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 16:47:19.8692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: thmut9cG1fSrjhDcutbUXlZiaBlTOnFqdCQLYXjmDni+ztqXrhrmytJ5BWO5sVg/lfZCjLSs51Tk8EzCrSafWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1362
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
index 862dc4ca00..471a26744a 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2201,13 +2201,13 @@ def applyCommit(self, id):
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
@@ -2350,7 +2350,7 @@ def exportGitTags(self, gitTags):
             if self.dry_run:
                 print("Would create p4 label %s for tag" % name)
             elif self.prepare_p4_only:
-                print("Not creating p4 label %s for tag due to option" \
+                print("Not creating p4 label %s for tag due to option"
                       " --prepare-p4-only" % name)
             else:
                 p4_write_pipe(["label", "-i"], labelTemplate)
@@ -2515,12 +2515,12 @@ def run(self, args):
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
 
@@ -2543,7 +2543,7 @@ def run(self, args):
                 applied.append(commit)
                 if self.prepare_p4_only:
                     if i < last:
-                        print("Processing only the first commit due to option" \
+                        print("Processing only the first commit due to option"
                                 " --prepare-p4-only")
                     break
             else:
@@ -4206,7 +4206,7 @@ def run(self, args):
             if not self.cloneBare:
                 system(["git", "checkout", "-f"])
         else:
-            print('Not checking out any branch, use ' \
+            print('Not checking out any branch, use '
                   '"git checkout -q -b master <branch>"')
 
         # auto-set this variable if invoked with --use-client-spec
-- 
2.35.GIT

