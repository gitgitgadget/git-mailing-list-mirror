Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A34C433F5
	for <git@archiver.kernel.org>; Sun, 16 Jan 2022 16:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbiAPQII (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jan 2022 11:08:08 -0500
Received: from mail-mw2nam12on2064.outbound.protection.outlook.com ([40.107.244.64]:61889
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231368AbiAPQIC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jan 2022 11:08:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwMSZGni8rttD1KURSZ13/mP8jxa6+YzcRuStiFMwX4aDRAaW4zTfhrstE65Knq0l/4GJxLj7sPe+NDzisJMTA1ish0yx4Fqt52G1KLhLMY4PxtMU6bdSD/XPpvxdUi/zRJHeXOZlVI7OodZNK9/x0WM/pimtseXX5EAi5xkYrHcvRSJQ7NtK5CRe1pJ9nHz8WUTw3ZdwuCpRslLmubgFq4SMlaHif0RlZumX2kJawkqqlbgc8pVjXMDwV2C/uwNqTAchJdC1AWRHS0gXcpRN5C3gQCXE4pkaqpbIaCHbilIZBmo+RJX/oPwvn6himfZDQ06LZLiOxifZF17rwmaew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/EzJf1Kw7efwCr+2/1ukMyhVDFn7ktlhLjet8LHwaw=;
 b=QiHxUC1rTtgMPKCwlaaqmBiERBuO0ctu3xrGrCxG4kO9hiVZuNj7YocDqV8n3fWv16YKlV6F2XYOXiWGb8uXX7tqxHI2XUKoHI/yIKjfgO7IzojXchVDVHsUFaYDiqBSox+Coa0jtfbHZb4SJTKhwIspo/B8jNdrqNpXxa5aTTBtti69S1UtNPO2Yoivz9RdxJZhrgyJgm3HQ44Jfjv8Bvkyo3Ys6zqMBBmrTC3QCUIjQc8PqIOpwEUTrPZipoiVE7E5kn75mbXr9dXozRIe1ZP3lbQnsrTfnuLK6dBeKriOKfWjpBEYscOEHGwXCevr1WiyQ0pQ3r24tVU13DF9Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/EzJf1Kw7efwCr+2/1ukMyhVDFn7ktlhLjet8LHwaw=;
 b=Y0ACnjYac1vJWSyWtQYzgOs36k+1v7+bOLcACkeoSQnElryimB1mu0/S/6N+pyElpqKxCggGGb7RlwO1JVXBk3+rjnf6PWfXTGm+7oqJA5vcRyID1g6Yz4G5TqqGK1U0y+QXxvPYeTe774eDsuu2vaWMiBVmk/fsJAWuJ2ZfaHkG5BNSREw5jZ2+IF1GgiQmksO/QAca93awJWZXBBzA//Dh2orDF2YlpvovnyeS5LjCxZpWkbhsWWofdhAJxtsCZICjP0K6JlPIDGz6J7M9zepZVQdOxKdDLZpPUB4yzDVxA9vvARWFX63faHyUMva6MeqZWw+qmXYXynUBBZzBxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by BYAPR12MB2597.namprd12.prod.outlook.com (2603:10b6:a03:6e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Sun, 16 Jan
 2022 16:07:44 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.013; Sun, 16 Jan 2022
 16:07:44 +0000
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
Subject: [PATCH v3 16/21] git-p4: ensure there is a single space around all operators
Date:   Sun, 16 Jan 2022 16:05:45 +0000
Message-Id: <20220116160550.514637-17-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 47b822fa-19f6-48b6-4516-08d9d90a5492
X-MS-TrafficTypeDiagnostic: BYAPR12MB2597:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB259709BF41DF50439695919CC8569@BYAPR12MB2597.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:159;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nZmvf7egM95O24LH2qh1snvoN/YSQ21HrpfK7rWV028vJ/dDP6YEjgX3jETFWUWUX1gSiEyehi558ik/1H/vUhFPmhJy1IYld+itI3mwgmXd7sUEAoH0OrK3agwClobSBYtWEf8MYNhu9neHAVE8yoMvOX7uUnm8Xdi2DYO5OHzXsePbQCB/oVrU0pjmwSl6dnN1zvRFDg/oCFqu2+vCDNbE0lVROpZIiBZjMItpTtCrCiWoJm0xs3im2GPDogV6DfksEVWDDa2Q7n9AR9eh3SELQdp/ll08wz92TXYYgr7wspxdBhEcTgIHhMW0Zp79/Z0AYmM+01jRP0g0qxSZQd5TUGCez5avLsIXXSnNqTIeGyqrd3c1uN/+wy3LmM7zyDnVZfBEj5yki8qHOWt0IjRI/2SrSEDWJ0rUluLlHmMBHnKjsHSryh8l3JYZ+vtdd+7u15eAQ90cOzQvkYt+TjdxKAX0pJXPCmF9MK4YRqoLD2gX8g3RqaQAte2ObYWO4qrFkj5f1VpzpLoRbqrArTRGnVdQV+6KlB+9jRKTHvvOlqRBNOY7Dt1Rl4DAQVRqB+7zgilp86gxi4zImE0RZqTbeUoALKWdsAgZIZU3a55PfgKRGkdSFgG9wYohMVkFq+3mLQ1QVInN7J8F3yZyzCfs2+OtPYqKseh9+HemCCmxV/NQhDCV8B1OeJkk5aH8UxsVgdQj8626DgnWOBs2s3DrqKuuHkqHBEwl2st7S9y0xMzAZhfS9Yh2qXcqgohlqmR2csf9u49IKXssZm1aq2KryfyyJgbRblWGQbNXT2o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(38350700002)(38100700002)(8936002)(4326008)(83380400001)(186003)(1076003)(6512007)(110136005)(54906003)(107886003)(8676002)(5660300002)(316002)(66556008)(66476007)(55236004)(6506007)(52116002)(86362001)(36756003)(508600001)(66946007)(2906002)(26005)(7416002)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wvia6z0oPK/b2oKuuNrk5qaEDC3qXor7k4N8OA0o51QgVdK5Opcywf/ASYjk?=
 =?us-ascii?Q?6Xx17Imy/+UFbYpN+OS/bkeznKvoG2/E265lurfYEcjQLehDi+F6RwnJko7r?=
 =?us-ascii?Q?pee3cqtng6aW5yAHhFMX6Ev21idcfyZAR1xGPzaFX04Nc49PObnz1LAMu+F8?=
 =?us-ascii?Q?l/KmyMDxBJitEha8H0Fn7TjFvfuXxZgyisP1nB+izXRJY20q8ltKeMfhfj1R?=
 =?us-ascii?Q?aPPdoOPU74I9dGdcfkaRPp5dJFAUwjgZv3jXWxX3T5J/yvSW3pTwV3N9GFoi?=
 =?us-ascii?Q?eV0cdUT664Wq5iZ3Ofml35S74HsjmkRIxUZBjvC9JfOfiFQwN74rEmBZu6Gc?=
 =?us-ascii?Q?9SCuF+KiCKBhc3kY0JrYXXz0sOz7oSGtLZeyJWAJyuq4LCiUZtIo2zTSDuNo?=
 =?us-ascii?Q?ERc0oo/biCZm7GZtd9zWzD5MG0i6BsTm9kInd9dfExwcg6VXzpDDNh9O+9r7?=
 =?us-ascii?Q?7CrCiQDA+dI4c9FePpYwJDNgDhWnaWwHvIQEt1mCAb1lVMtOJcsBPzzzJwsM?=
 =?us-ascii?Q?J6GmDsNe7bvKcuBmMNvkwvYlI3xxlMP8HoKutIluf5S3VIA9jZ1uLRcuZTfK?=
 =?us-ascii?Q?B0wqWasNtPWeoqqy+gQvA9K4KwuOd95elHMOdAG3e17XjTzBrHLOQEAYIh2+?=
 =?us-ascii?Q?YQaWxPrGG/hBTlRSU7iBKG43ytEnln1DcA3HGF9UQ9n/D1MsuSiIES3x5BE7?=
 =?us-ascii?Q?BHGp9kcpyIwhUosxFkQIZBv3VPxtystWpThBoH76/ofrnFeeTLoiWWXtCelS?=
 =?us-ascii?Q?k8kM1DfWjeIyg+is4hnsMk8LGR4qpDgdXhKhjwoIpAC0fIinS6+Vx2EbogJG?=
 =?us-ascii?Q?B8UDavso4yHX6pXyAAMQyI84CT8tZ6nn2k4VXd26ZOTw6SoRDUE7q6KWwcMA?=
 =?us-ascii?Q?ymEBf+vY8Ra8uQfsfiuat8YbWs9MB3R1n2mfjmnRvZhq/IHT7exbaQBeX2hd?=
 =?us-ascii?Q?zhz4b363KX6tvpLIuugRlbr8xeDi1tsYnuJ8reMUig9f2h/DgosLL/5UvrmT?=
 =?us-ascii?Q?ZQ5Ykcewgim5Xy1RY3PrtNmkSkWHa2y3D+PFckwwYHvxw8ix5B6msaM2wWr9?=
 =?us-ascii?Q?9kjnzB2AxET9jJDiB0QWq8wlQyOnyuWaRU2oel9T+eRbSVFU0uGiN/jEYKCN?=
 =?us-ascii?Q?uK7O8CBtt871K4qlSi2YGftmFpMAYPT93dlM0E+Qw6K3VGzRbysJlAWJrAe7?=
 =?us-ascii?Q?ySPhwEVZHT9w4rNrwwL9l5Dd0phtNetSprzi/2KuvNt01k8+lnqLRn7cZIcL?=
 =?us-ascii?Q?M+2VL9gxKcCCVIZ/v382DXPsQ5RpW9Le29m+boNM4f8PgOCI2CZ3bzGV37xH?=
 =?us-ascii?Q?SRJ1oK3hizCQZQDtBR7STcy8CdnsM98SBoQJN633fgwbH1gfl2PPCFvfSX+R?=
 =?us-ascii?Q?S9/9So7FBU7yipRjkNSMJ0HWscAX8zZqEr53EN58c4jE7TQgXYcwVDXwCIrN?=
 =?us-ascii?Q?YT/YNZaDriF59+5WViqIR+gP3NQ5l+FcVWefzGTUzbhgnBlNcAZwpC24JAz9?=
 =?us-ascii?Q?nAi6z9L53fJHmVpTo9wyIONGDvoml9EE2olOENBCxOpc53pMAhbvEs313/SS?=
 =?us-ascii?Q?/m8SizRQIZ4+UMon3MaigZP3HTh88dSYptOH55GoN8sHlGiSeqQGA2Uv14yg?=
 =?us-ascii?Q?zuRaBgJB3qIodxXXoW1oKDY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b822fa-19f6-48b6-4516-08d9d90a5492
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2022 16:07:44.3439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I7+dDbb62yUWYMnxTO0wDn+t1R+ibkrr92qZIJsQRXE6OV7rK0FfPRwLtAThIN5mMcq+H+JtmkOh939GKtT0uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2597
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
index a014bdc7a5..b5cda50af0 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -67,7 +67,7 @@
 defaultLabelRegexp = r'[a-zA-Z0-9_\-.]+$'
 
 # The block size is reduced automatically if required
-defaultBlockSize = 1<<20
+defaultBlockSize = 1 << 20
 
 p4_access_checked = False
 
@@ -201,7 +201,7 @@ def prompt(prompt_text):
         sys.stderr.flush()
         sys.stdout.write(prompt_text)
         sys.stdout.flush()
-        response=sys.stdin.readline().strip().lower()
+        response = sys.stdin.readline().strip().lower()
         if not response:
             continue
         response = response[0]
@@ -256,7 +256,7 @@ def run_git_hook(cmd, param=[]):
         hooks_path = os.path.join(os.environ["GIT_DIR"], "hooks")
 
     if not isinstance(param, list):
-        param=[param]
+        param = [param]
 
     # resolve hook file name, OS depdenent
     hook_file = os.path.join(hooks_path, cmd)
@@ -2397,7 +2397,7 @@ def exportGitTags(self, gitTags):
             # Create the label - use the same view as the client spec we are using
             clientSpec = getClientSpec()
 
-            labelTemplate  = "Label: %s\n" % name
+            labelTemplate = "Label: %s\n" % name
             labelTemplate += "Description:\n"
             for b in body:
                 labelTemplate += "\t" + b + "\n"
@@ -2900,7 +2900,7 @@ def extractFilesFromCommit(self, commit, shelved=False, shelved_cl=0):
         files = []
         fnum = 0
         while "depotFile%s" % fnum in commit:
-            path =  commit["depotFile%s" % fnum]
+            path = commit["depotFile%s" % fnum]
             found = self.isPathWanted(decode_path(path))
             if not found:
                 fnum = fnum + 1
@@ -3983,7 +3983,7 @@ def run(self, args):
 
             p4Change = 0
             for branch in self.p4BranchesInGit:
-                logMsg =  extractLogMessageFromGitCommit(self.refPrefix + branch)
+                logMsg = extractLogMessageFromGitCommit(self.refPrefix + branch)
 
                 settings = extractSettingsGitLog(logMsg)
 
-- 
2.34.1

