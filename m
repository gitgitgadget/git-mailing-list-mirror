Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA22C433FE
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 13:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbiAMNtM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 08:49:12 -0500
Received: from mail-dm6nam10on2081.outbound.protection.outlook.com ([40.107.93.81]:50574
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235578AbiAMNsy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 08:48:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnc8H6fF4lPqNQdCmk3yK2uBfQyJCcrsxToMhWAJ9sPyfYlsL0IY+85zf1d76BMYy3I7xXZyean6tNH+IpWsCQGAR8MNYIPYjmI7cb9hyeQEoUPIhiNmiupayrNMMeIh5FJnAYR/wikFRahTmsPm/41BlNIX2+/BJTHHcXpDFDZtvGiaZjwlSgY39XQCgEq27DE5oPNe55FWaHJCm3sfHSUZ1OXDAf704yZ8jXpwoVZqSPQvRtK2FJpQRMDFUo1sbk8oyW6V+O0emtgpA7b5Eaxv/ZR5OC3RRl/Q0bi9HK6x4GYtXT1LesX503svEVYhveGTKulNt9/+/mkd/TQJvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56hoHLslCAsLQKzwyW/lB9oZw8bIrLbjfM8fiqiSjg8=;
 b=SPx5iJUTUrmHkfvRbeBrUedrrkH/BMqRaLn1XrO3nDw9Yis0QfPcIQ1XkvWDQU+MmDZ0gjpMbveSuZo7PmgWJ9ZnWDgwQs6fvUMIyaCwcgUIsGOP86/g445AxwKvPTHCEy8m6dtql0s8OC6eLGK/kZPU8ZEJCE1HVCYYpLuU6irhikWi76EiaR5EUwxqKXlGdh3DiQ87kT15kwF8+AuPNN26tVLFGrqZ/KhUGfKJmJWZeg5abDV6ago/zW9W0li3VSGyIpaVtvpdA8046+fgFtTdmVsm8E0cqTzHlm53HJsYNhxaDJlVBv9vKzfDs4gwS4ThujDTW3ICayUVCkT61Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56hoHLslCAsLQKzwyW/lB9oZw8bIrLbjfM8fiqiSjg8=;
 b=sPeDiEl5bbUMPWx02jvU3aAbzZGvbFB8CebLo6Lbf+EW1XL4Lp+ss4i6lPE79h8Co/94o1uQ9UnFauPk2gdBuRUD93CJm1yTlqVDG5ajvXYJn6vzC9bggNPVLdT5SX1OVqzK0fUfQ/LhB4PZry6IHy8Iej5E3GaOQRJRhcuNTB7FNGWL93jhiNU0uYrWz5GR54UiUPXdGs4AbVNCC4+ZBp48jNsrvc0Zt/8Xd/s8n1NPX+Fl4wHsd3/o0wBjwvg+mZLD+u/ZO9rlh8c/0H+oUgtFUbDBAlE7l1f2jXkPuIpw9teDZw1pazpiiuO4SA3AhOCJFXCR/fIXOHzgN/iGww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by CH2PR12MB3944.namprd12.prod.outlook.com (2603:10b6:610:21::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Thu, 13 Jan
 2022 13:48:31 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 13:48:31 +0000
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
Subject: [PATCH v2 17/21] git-p4: normalize indentation of lines in conditionals
Date:   Thu, 13 Jan 2022 13:47:24 +0000
Message-Id: <20220113134728.23192-18-jholdsworth@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: c20b468c-d3ac-4c41-068b-08d9d69b625b
X-MS-TrafficTypeDiagnostic: CH2PR12MB3944:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB39447AFF3437ECCAC6BBAA06C8539@CH2PR12MB3944.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:209;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rQiJ3GwvlWlaUtN2RTcmDsV3gcJlX3EIHCYSHDJvXfjmDOXcfUFu7dpTxyIBkoT+Lna+IfDd7HvZJUDl69ayyc1d3/QimmTkvfHb9APLxG5hwY2TUmc/+DBEcu/pwRR3rSqzMm8lLtyzczFicV/slMBHbW1ZgApnPwYsuymyHXQ0DJQsXSoI2xhT0UQIRfms/gmod5MR9YuWLYq+4PUOoqhPENdYBQSwYEF8qwV2/yr2GtQSOykNSZBFsdC1r0lPgGBQNhoVFX73oyuAIFVuXA7iidkI080G7lJ4zBb4WSuwgWLhU7Ot6BXno7dMMtPzxYkzkGJUYaYTinfmBxByi8b8AdDPQXlrFfFcv0vl9eeSBmB8MXBrYiFHKTHAXYceKe537VzcC77lnY9y1gHjIH2DVZYfT5mQRjhqo6Vvlv4lKOcLuSK42MfejvLZF+4aquETYRoVUuyvzDqwVk73+NVlcjdibfvHRsuC3bwvyUAMI9iFVs4bGLonlz8HDmTfMxHJw4WVlqbR4ElKI6B0L1pEBCWyomczk9KXSLukJICxGafsdNF7pgoncqt3bz4TK9kSb886jUDo+vbad/G5X83QMJwXImwtayHgKmMYlqY00QuGoEDqg+H8jX0tpcDUGhkwoZImmQYg08dsPF7IxxF8D1KttUobaMMwCksb54WqD47+01T4zlOKUUpFmdwmb9Dw3Ylz7ildnQe4+TB+Sk3QN1v7w++CE3mB8DPav4Bo9Mxe6jozpJHmg8YMPCsnRhLh5uW1vOrE1JAptWnqcbD4x7wc/XBQM2F8RZVgWuU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(66946007)(186003)(66476007)(55236004)(86362001)(316002)(6506007)(26005)(36756003)(7416002)(38350700002)(4326008)(6486002)(8676002)(2906002)(107886003)(8936002)(110136005)(508600001)(2616005)(66556008)(54906003)(38100700002)(6666004)(1076003)(83380400001)(5660300002)(6512007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tADz1jw/Do8TrdlhRMFbi84WzmxMb2ngDvW6+wd7UC4yHo7stCsYdLveVFq5?=
 =?us-ascii?Q?iYn+s6YJzP0K9d9jVlvcS5SWZCNTrcrPp0dF2TQLOVuxap/Q1pt8xvCYI88V?=
 =?us-ascii?Q?4sXLzCn6exMWHtnSS1wzyd/EmZgA2kI3H1C4PrjdhbekGoGE2+2gnd07Rw8c?=
 =?us-ascii?Q?glK4thnN0zYaOPryKCpAqK3mCoZ3knrzEMhxRpWhNIEAHyvUw2gMz6MbdyeY?=
 =?us-ascii?Q?rg3AOxJ3VeDAxuW9qC7bYxAgC1yJQykXI09lkgrpP691g3RH6DYwroQ2GQH8?=
 =?us-ascii?Q?wCCemj1xfZS7bZxzEh+luexpiKlZOKgsvUiIDXx6DtTmStwx+r/eIMywQfMV?=
 =?us-ascii?Q?7aodYoOyeXiadG7C8aeICorjUbj5PBC5uoBJwSRovehRxnOwfDVKQT/0MxtL?=
 =?us-ascii?Q?FUNHkWgxJmOeI5BbSQa68+vX4CBd7GP/+jBK0km+39HyRa2K5SI5YOeoEZ6f?=
 =?us-ascii?Q?lfi/qz/LrFZeKhvtARvUQ9PpsnwovnR/EjFGkrtH9rB8FZHW0GnSQb50xZGH?=
 =?us-ascii?Q?bmYzVCfi/KJGxhwKmmC7FRsMKq04tv7dFppKAcwYS49eaMgrfYyz02QzF5U5?=
 =?us-ascii?Q?+rkqRVxWxITepbyx1KqwpTMuWbzAEbNBWn7/it2MEcQvLrEqHcnmSPzz4Hyv?=
 =?us-ascii?Q?VHpfFc4bpuD8AT4uhpZcaMzwKzQowkYBHRv/G4z5IoavmJnck4rpldtHYTjq?=
 =?us-ascii?Q?kOzDWEsGeHXqJJ+Qa4HQ7AK5uB8ogOeZDyy8ps9XgtKkO9ZWo/kz6XdbDeTI?=
 =?us-ascii?Q?+XrZr4xs/EmIUgWmUaxdYxoKGQwOyi1E7B2U4nR+AMUqvytymvqBGF/+kHPW?=
 =?us-ascii?Q?CWObe/+6sfeZ5nMC5dIlscwszLrLYAIDykH4pIwefgFYPmNqP+lj4FHBTFkr?=
 =?us-ascii?Q?ZGaVwQnMWjCsKgMalYixrx8v92srO6GkPcDYYmxK4flD+MRtCAHtvaBYz2gj?=
 =?us-ascii?Q?X3e6mL702HaRWaGA/d9KzVVk4+s1NadUyFdkcz9mRDv6tm3BXfrLTc14Oe0G?=
 =?us-ascii?Q?H7QASguPV42IRCGbDZZLTrf74A2DzC4PqdHKpbegttRbkw28gYOjzC1ixpEO?=
 =?us-ascii?Q?Sm/4nDDPnWr3bfE5TrWpF5csg8BrC0P5Uiy8abOWYqf+Pme4Kj3ik25bb2GS?=
 =?us-ascii?Q?oid2xd1T3KfX7rT1I4h4NZPK3JxQHY1Q6Mcrk6RhvntbgRYJHrAwXWGUMMtr?=
 =?us-ascii?Q?uRi3Wle992BdjtwV8nsHwn8Mc8VahyENLUaVm98/1E0SIak1uoqCKanjwCxC?=
 =?us-ascii?Q?fJqO6QHOSaxEPe1BZLKg/KDW7xRqXtZqIMaTfJdHlpPn68eFdzb2b6ksRXJX?=
 =?us-ascii?Q?DrSiLdsbxgDXOZyyRz11xZ9oT+PDHHWfjZMVPaEL8N417ZKqWGBDl9d1/pLa?=
 =?us-ascii?Q?/1CXUqItFeD52UX2tdNJJ7gWdlnR3AFvteuygK002FYrHvLYxC4v04ZocmhT?=
 =?us-ascii?Q?Rv53RoxagXSBST+LXP3bOv6/BCzB7+QHFM8CAbuDcPBRnu0rIYYslJ9k0bsy?=
 =?us-ascii?Q?RQUXUUy7/wYeEB2cB1Ck0MKL9rkKd5VNQJY6uD2K0LXnfqTgUh87bAJdKWLw?=
 =?us-ascii?Q?67RKol/ocGrkfNQgzj168enfH9XXlwC/eAYmMR3xuEVatVKs02YNMpAmtj2F?=
 =?us-ascii?Q?X5u8UPfUixXJu13KVbBq3A0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c20b468c-d3ac-4c41-068b-08d9d69b625b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 13:48:30.9617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AUMaz6F4qeqQcfaNme7nVBbM/i7YoX+czL6GGm09AENksKO7faUNKRg5YjbBE59yVXlZyza9jMX4t23b/4Bnlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3944
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 recommends that when wrapping the arguments of conditional
statements, an extra level of indentation should be added to distinguish
arguments from the body of the statement.

This guideline is described here:
https://www.python.org/dev/peps/pep-0008/#indentation

This patch either adds the indentation, or removes unnecessary wrapping.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
Improved commit message at Eric Sunshine's suggestion.

 git-p4.py | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 08b7f0697a..1de5b1c49d 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1158,8 +1158,7 @@ def createOrUpdateBranchesFromOrigin(localRefPrefix="refs/remotes/p4/", silent=T
         originHead = line
 
         original = extractSettingsGitLog(extractLogMessageFromGitCommit(originHead))
-        if ('depot-paths' not in original
-            or 'change' not in original):
+        if 'depot-paths' not in original or 'change' not in original:
             continue
 
         update = False
@@ -2170,8 +2169,8 @@ def applyCommit(self, id):
                     if regexp:
                         # this file is a possibility...look for RCS keywords.
                         for line in read_pipe_lines(
-                            ["git", "diff", "%s^..%s" % (id, id), file],
-                            raw=True):
+                                ["git", "diff", "%s^..%s" % (id, id), file],
+                                raw=True):
                             if regexp.search(line):
                                 if verbose:
                                     print("got keyword match on %s in %s in %s" % (regex.pattern, line, file))
@@ -3184,9 +3183,9 @@ def streamP4FilesCb(self, marshalled):
                 self.stream_file[k] = marshalled[k]
 
         if (verbose and
-            'streamContentSize' in self.stream_file and
-            'fileSize' in self.stream_file and
-            'depotFile' in self.stream_file):
+                'streamContentSize' in self.stream_file and
+                'fileSize' in self.stream_file and
+                'depotFile' in self.stream_file):
             size = int(self.stream_file["fileSize"])
             if size > 0:
                 progress = 100*self.stream_file['streamContentSize']/size
@@ -4003,8 +4002,7 @@ def run(self, args):
                 settings = extractSettingsGitLog(logMsg)
 
                 self.readOptions(settings)
-                if ('depot-paths' in settings
-                    and 'change' in settings):
+                if 'depot-paths' in settings and 'change' in settings:
                     change = int(settings['change']) + 1
                     p4Change = max(p4Change, change)
 
-- 
2.34.1

