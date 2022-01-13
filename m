Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD23C433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 13:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbiAMNsy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 08:48:54 -0500
Received: from mail-dm6nam10on2081.outbound.protection.outlook.com ([40.107.93.81]:50574
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235581AbiAMNsl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 08:48:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFZfepdQN0EoszC3KoldhNewKDkC4fTPggKXRdwCiQ6QolFqJvc9R8mUqNZim7YYD7i/wdSi/6ljysy+LO4Ga131ByupsYxr0rCP6cms5U+igea9VvEIZG9cROjfT97yfa1ORqb5/ZrKvnZFtnXM4DAWxzimS/jfERo5S2LhrQM1mzGKFZhu5u6uU/xE9khWUzK7hJNtnPGOywHe7kRmkymYHbdpmlrP9RIavpFmQVLA0LO8hvTWJZ9Ym+2ZbQm1F7GZsX1EtdzS3cxRzQQ8mJ+yImIoQoLsbJ37ng0hXO0Bw2P0ZtgtVZcWyZFWLVD+aW0tn/Z/1QE3dZYA3mFfYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5WUUZPa3pPikEc6Ie8QGyBBntIwSx4gaqKrcQtlhOyw=;
 b=aTakf+G0KzufkONsJ1F2Dc+qpYFG/nfXwSwy2HnlLIgApHjkC5fOXebrByTcXDs6hSZJ9Aq0a0gODpK0nGXDGPRyES77ghjcn57Q0i29p7Hwo5ZP+U/t+gJpsJoto1xcu0exQacp9BKpodwpsLGGzPxID5ohip+huy5lHQNGP0APeoPr5Nw4mPIU74eCSYW0z0joVMExz7yObzZeVedSkKJ7ERuTJc2+YDtbRHOtjGBW2EcmoGyl+K7BO63A5JWp+bL7iZ8EW9PWe3DDAykh/kNxkz8ZX3v5dwlqwa+7k3XXMpKQiD8fWyEtFEwXGOiNWOKenMrIxPu71ljFQn4pLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WUUZPa3pPikEc6Ie8QGyBBntIwSx4gaqKrcQtlhOyw=;
 b=IRw9hNUlZDD/sWI4JsyT42AVUP4KWRdj4KK3psy8J/ZEUwLI8+5lCkgFZt06k4irElWQUIJQf7IeTYVCK6S2fuGM8PR/NpP3i1Gw8yApmsBjS0OHdVJgmIbPzWsTaDPzlyyFf17B3rsRz2rZhEDB4Jz+oYlOLQv5QiltuYJA3PHqjz+Oc4cuV/v9FaXczoDWxoTSqu42J0aGx5uI8MMYZdMsvPIEKrNn+XT4VuH9q3aJky1FsW3Z8lWGJgQFukCQq7JydYcyWrepcG/7zmvYNxe4syYFAzNcGyTRvwGeYGSyt0kvr2duqVgLGxuLMO3Ev5UJuBkbtGmIz/MwGoaesQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by CH2PR12MB3944.namprd12.prod.outlook.com (2603:10b6:610:21::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Thu, 13 Jan
 2022 13:48:29 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 13:48:29 +0000
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
Subject: [PATCH v2 16/21] git-p4: ensure there is a single space around all operators
Date:   Thu, 13 Jan 2022 13:47:23 +0000
Message-Id: <20220113134728.23192-17-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: c4200e52-e248-4275-a750-08d9d69b614d
X-MS-TrafficTypeDiagnostic: CH2PR12MB3944:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3944EE6E79134842EA6FA705C8539@CH2PR12MB3944.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:159;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2YarFw//9fygn8vNvSoq6dGXdEgwYBmmofQhg07LusjwNv4ZAywH9nNp3Br4AoX6hFGiVvff+RUTRyPafWpsxDikbaltb4xHDk9uSNKW5qGqt+Ksdc3mT4M6Nxfo/zgh72G6WGF27LMSQCBuyVIpndXm0HKqSlUR0VhXtNIrJTgm6oK1rm7ZAq+F8vJovzBNzbBmSfFA3dwla2Rv+QyUczhGJZBC96b/ypBpR+SC4eKnpwiRvJ1lpO/tCcRt61/lWKJcoLy2ipkB7CzYkunnH/aH+ucu7xgJEtyiWbQr1okeWPGT/1h9aj7h1od7bs3SZTL5TqGtqIYUb7C2Nxc6dWQ7m8tsuSy1rARAW57V0FYOM6VdrXk1fEswY3P8QEaOeldj5e1vG4lVmnL4dBzncDXUF6eGbgnufij/2oUA5chmFBu+Unsq6RZ1ZJAQD2NWDo+FNR5hz74ONJZ4hbQd0PSouMH95rcMT/PVtd2fAXzda+9wEQuj384Dl4Ec2fp8u2VEqKVhfIb8l11hsYgSebszJhAyzP+t35/xaKv9e/piL7fLNKlefapxzXz+tfRUw6h6q1ZTYvwlrZtkVFeCFAqxGdwnvebNjSOrVb40Rqwyw/IpuWI4cjOssnrVs54VUjdTUFyEpzkli41nIa022LPkSt1DNgsvJnCKlaAe20Vv3f5lnYxY2NsVisPl+bE7xCgpaAI0PwACYKrx0taPm31mKq4DrZyxu9ejeO/vnK5WfRr1wOAn7dAniSfpSrRkvvGxjRzIZA99kTLrONrsDyTw5jJp+aYAjXybw4LOveU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(66946007)(186003)(66476007)(55236004)(86362001)(316002)(6506007)(26005)(36756003)(7416002)(38350700002)(4326008)(6486002)(8676002)(2906002)(107886003)(8936002)(110136005)(508600001)(2616005)(66556008)(54906003)(38100700002)(6666004)(1076003)(83380400001)(5660300002)(6512007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FabEPBsKQB8U0cbVVciSNpPf+XZSTUQOsnQo+RBTQxCg3FzOzBBMb1QwpyRZ?=
 =?us-ascii?Q?KfMhMbNJcDMKUigiCf2mVhmjr9h/qzzAxneiJSyzVTJEFL/9b+ev+uPtAUYU?=
 =?us-ascii?Q?CZLuh803moqQCm9RwxCxdoPZo1OF+U/W/jNQd3TWqKWmsCgKIIY2JUIiHdaQ?=
 =?us-ascii?Q?azavvnqzisT1S/a0iakTYkn2AMAsAmVWr8XB1TmqOGntMTpqiXLIZ0zS0pxN?=
 =?us-ascii?Q?CKa1qTM9R4BlTqbUlpiNEK2oWVMyNWq6hda9yEE+e6VkgehMUCxe5SEFAQve?=
 =?us-ascii?Q?Qi8z4qfU4doj53slqSK2pE9GoVQRu5N/dt7BL10Q9Zvsw2UL4rAF4wNyxir1?=
 =?us-ascii?Q?8SOZruYKL7IbS495Y2dmc7vzxE4SbxzrYqzkcHoBq1dbvWNUvXDq8i4BEBh+?=
 =?us-ascii?Q?fC1PW0W2zR4LtAIldTLPrA6Sy2OqiG3oCoh9ljP+m77vS3GcBn8zQEfjAEQB?=
 =?us-ascii?Q?LE8v2nN8OHHWTplAiA7g5LRw277Wgpfy478AOLaj69YkQDvonPes4wYSAmQr?=
 =?us-ascii?Q?8AbIrD4TC1kuTfTDOdzFf+r8TOOhz9xa6RMHyuqWEp7w13BekLIbesfyfv/v?=
 =?us-ascii?Q?8sOpp5ouczFujj9hvUy+fXe+aA+EfC8B3Lt9dAh8lwYXld1dfS6OYoSR1CqA?=
 =?us-ascii?Q?Jbg1trj8wKugPAaG4GMJcKzgNQUM9IctEYB3d19fzILnEQaHhmP+CooNz6kf?=
 =?us-ascii?Q?Tg9/BVXVIo0hbpdWBWkCpznxG4uWNNn716FQAnZxFndsrdaArQbT3Byfd2hS?=
 =?us-ascii?Q?atHEPbi67nIrONi1HBFD2q127Ot0BcQ6PbahaO1IEtXudOxY7KBtTlMLex2F?=
 =?us-ascii?Q?Lan+vG+TXaxc7Rm+hx4ZL92ToYGOgT/4tnHdJXoEBv2xAzbl/FKNj9j7NamQ?=
 =?us-ascii?Q?9DV3FEGFCpAHMoe7u+t/0B8JOLb1bgzMkJ04CUmzLCOr1flfcVpccPWxTPvf?=
 =?us-ascii?Q?7VPzhe5GFlvwKX2y5nCthk49gXXtUQesGBnj1rtJnKP0SLVayQxKGcQBR+eR?=
 =?us-ascii?Q?JwUsbIzXcVrO+8X5WRLmQe4oAA066gQOpUfIvsd9wJHB8ahCrqhGKHMITg0k?=
 =?us-ascii?Q?StueeaSw+JmzWjBzx6jskcLZjJJl+lDm/P+hBMJ9iu3dzYLs36/nZNEznCAl?=
 =?us-ascii?Q?4p3MuFMBFeeNio0fP1o0dNiygobp8ug8yQ7iPyxaOePXcIomjwMEHsWsaRRJ?=
 =?us-ascii?Q?UKbI+NnVhFo37j5Iq2d2M8+I+2Cs5eE6D7X8X0hV7K1g9vN4ZrnDFp2+3cCO?=
 =?us-ascii?Q?u9guaegaaw+ufkQ+Eh1+PKnWlPrIl69oj8WdbBHH9WQnWJ1N/PRRniIsuaoX?=
 =?us-ascii?Q?kBZKDxIIuCgyQxrLpiEIeL/4VAUmLv6qAVlo17oCY+Ml45kcdl/Grb3CRLRd?=
 =?us-ascii?Q?RpN7BYw+n1zfc3SPtjZhOORD340qJeM9pJKwvLpCidcqYnDLDpVUv3w3VYb7?=
 =?us-ascii?Q?m+wSlpBy0V72nrSz5V5NS5KgEnwtTLmV3ixWtYx0tksVYlmdHWT84LTA1MKZ?=
 =?us-ascii?Q?MYmnsFlZpPoutMjn6ZNYDm5nuSSWFaNJI/R5dUezBWXBdcbeq03R5fOCFwq7?=
 =?us-ascii?Q?mC3yyJCGc3CQpb02bwcZSVjW6KqgVhNy6R0r9UY1NOqAbSfWdk6q2PWh03Ng?=
 =?us-ascii?Q?REcn3Rhb45FKMTPB7hHtBAc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4200e52-e248-4275-a750-08d9d69b614d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 13:48:29.1796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q2SmWJHHEU71d4aCR0D9Kv2bIHY24B4Zz1b5O36npa+y8eVHvLhqjC8QPH2wcKQ9831c44Qe7b0ax+bQO6/KKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3944
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 requires that binary operators such as assignment and comparison
operators should always be surrounded by a pair of single spaces, and
recommends that all other binary operators should typically be surround
by single spaces.

The recommendation is given here in the "Other Recommendations"
section

https://www.python.org/dev/peps/pep-0008/#other-recommendations

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 5c2f2145d7..08b7f0697a 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -67,7 +67,7 @@
 defaultLabelRegexp = r'[a-zA-Z0-9_\-.]+$'
 
 # The block size is reduced automatically if required
-defaultBlockSize = 1<<20
+defaultBlockSize = 1 << 20
 
 p4_access_checked = False
 
@@ -204,7 +204,7 @@ def prompt(prompt_text):
         sys.stderr.flush()
         sys.stdout.write(prompt_text)
         sys.stdout.flush()
-        response=sys.stdin.readline().strip().lower()
+        response = sys.stdin.readline().strip().lower()
         if not response:
             continue
         response = response[0]
@@ -259,7 +259,7 @@ def run_git_hook(cmd, param=[]):
         hooks_path = os.path.join(os.environ["GIT_DIR"], "hooks")
 
     if not isinstance(param, list):
-        param=[param]
+        param = [param]
 
     # resolve hook file name, OS depdenent
     hook_file = os.path.join(hooks_path, cmd)
@@ -2411,7 +2411,7 @@ def exportGitTags(self, gitTags):
             # Create the label - use the same view as the client spec we are using
             clientSpec = getClientSpec()
 
-            labelTemplate  = "Label: %s\n" % name
+            labelTemplate = "Label: %s\n" % name
             labelTemplate += "Description:\n"
             for b in body:
                 labelTemplate += "\t" + b + "\n"
@@ -2914,7 +2914,7 @@ def extractFilesFromCommit(self, commit, shelved=False, shelved_cl=0):
         files = []
         fnum = 0
         while "depotFile%s" % fnum in commit:
-            path =  commit["depotFile%s" % fnum]
+            path = commit["depotFile%s" % fnum]
             found = self.isPathWanted(decode_path(path))
             if not found:
                 fnum = fnum + 1
@@ -3998,7 +3998,7 @@ def run(self, args):
 
             p4Change = 0
             for branch in self.p4BranchesInGit:
-                logMsg =  extractLogMessageFromGitCommit(self.refPrefix + branch)
+                logMsg = extractLogMessageFromGitCommit(self.refPrefix + branch)
 
                 settings = extractSettingsGitLog(logMsg)
 
-- 
2.34.1

