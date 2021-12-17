Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235DBC433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 15:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237741AbhLQPAR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 10:00:17 -0500
Received: from mail-dm6nam12on2078.outbound.protection.outlook.com ([40.107.243.78]:5824
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237726AbhLQPAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 10:00:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GntmM8z49mAy00nNJ8yHlxgNLTuaQbOC/YpZpngeKnb6HWsnoodJIOeLlnmzJ3F+h4wBNnQ1089FVeeP8HnMBzycvr+3vwRwl1K39CIv5vw2QhZRlvYCXCcEJ5a9F62Pa3qQQFUPiFp/2aLfs5sMxDxoXcCV3NsDU3+njxznrLQ0ogMo/y/Wdu7eASCDkqZicvweAad0rvS8anFqpoR/pkp0jct0tpeydI6Tc4ktApkg7XoVIvKkWr2objxGqZAwTYdaKo6floupHT3qKv1SF/hoNObqpk9sbXOJ0G9pQM/XaPkg6T5C+iMh4AzyjXVLMVF11yLFefDUEdbAHflwDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0BOSZZzM//2saGgWqN5T4OV4HWCci0/nCWhbltBwbc=;
 b=bPA6Ft7iKbMruNhkvGnj6CiWoyrRWHNijteMv1Feeko1JOYUk2kmG5Q7iaGvqAIfsEQamB1Vxx6OnTW7xvEfptkpzM0WqEAEfL3UAnD9nmXHfyk1d7OC4cDue45KfE131t4Lc+X2pr4fxGxqE3ulA1b/bo+x8T3qQ3ZKQI9jA4Gy/72YfgFNMFn8a7m6WY2gNrFdsjYKRLXc3Iaxf64nuTj9+72wusAqAEDzdnHW3ZKHcUkFCmEhMZlNZOz+N4d23dIaRP8dpEPbRE9YS9rnz+xZrcWjLtrJ/xuidl/+F9vHpwzFyDYs+pdBuxzjjrJE+ajS9lcrpLMdcmG7bOjaaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0BOSZZzM//2saGgWqN5T4OV4HWCci0/nCWhbltBwbc=;
 b=T7+WksF/0EYEX76SMFrnWw5KpiHC0r3RVDVakU2iBHO8E0DKMT1Mfu1kOgj4eBLqsil4sh/IeDHFSmkArJIuy6vv/nSbKfDsdYLmD6Akxojs95YWUvKZGbmDHMe9kzBM80mcOt9DIxmRSIamo3aU23DXX0P6X2MFTV2sgpTb73NcA38mEklsSAYunJFMxdK9Dpd9xTaUN//ix2HjSrjSv+ZLcj/95FlHFBBr+GiFFv5YleFnfYEbvJxdUbGw8TD1GbSG5EDRYGZ1Hjbdwbt0aJEOA9Ncy/Frc9Hm9Gu74zy4DgM0LTDyygam+3MpLilhlWbhwj9pDlWWaJTzGcIreg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN6PR1201MB0211.namprd12.prod.outlook.com (2603:10b6:405:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.16; Fri, 17 Dec
 2021 15:00:07 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4778.018; Fri, 17 Dec 2021
 15:00:07 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>,
        Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH 1/2] git-p4: print size values in appropriate units
Date:   Fri, 17 Dec 2021 14:59:48 +0000
Message-Id: <20211217145949.2229886-2-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217145949.2229886-1-jholdsworth@nvidia.com>
References: <20211217145949.2229886-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0082.eurprd04.prod.outlook.com
 (2603:10a6:20b:313::27) To BN8PR12MB3361.namprd12.prod.outlook.com
 (2603:10b6:408:67::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c20b419-ec43-4e53-0274-08d9c16de9fb
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0211:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0211F5B8F8EC2C241C9A689DC8789@BN6PR1201MB0211.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kgABffvuLnKYeOla9FzdxaT4lmxWlNzTULShugJ1d+KexEBjPe6FQyhPmrYCMLP0nngbFVRJhi4wkhZP7fgUDQOGIbXDlGG3oHpZe00cNQ3ia3EwY+2LlAkmb4+4S/7hRX2geL57PAZ28wWyGdCZoedYRRHFk/L+bMQW20atXFEIFtrTEpRtY37P5kCCZGU6SNdczB583JFaG+6+eWFVxZanIu3HD77JvvYVR+4wcTWQvM/8BpORtwqdqXsE/Aqz4PIE01IRvUN3+Hu9C60gZQ5VuyChGiDbDtJUZYLhkryMWBUB/y7w++Hq6e6+HF2b8Wo6i4jEVJ+dk399k0lx6bG4t4CjK8Qn//W8QROhAVzFwSMqMUjz6G9lPqL7akGQ29dGpiCTg80mfzF8i0auINX8QAkeLdj8rGUhduoFqw77A+TFNCvzELT+LtOe6jN4xU15JoE+Ki//L1jCj1xSRpR/B+r0fKREm94yV6otXDpMdNaERAT9rooX8Jk2QE+cgySP2i7cJG4GI66gpuagYaTiXh+qPmnL+TAnW/uz4rv4CwNnhIlmVZHXRU1Tj2cWWgTgQtiWl4a7yMjphAVBDN8HziJBwEdbQSyaLnQcPDMGQga4QCsiAtqVt5Dopzl/5TrYBxXqgTMyE6JVM+Xd0dwpSJAYqjtVzCGqyzxbrLakNYAPPnYBSEC8Iy+Kfg8pUtd+NvRfvfOx31s5I5HV9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(1076003)(8936002)(107886003)(4326008)(54906003)(8676002)(36756003)(2616005)(6512007)(5660300002)(83380400001)(186003)(6506007)(55236004)(86362001)(26005)(52116002)(66946007)(66556008)(2906002)(6666004)(66476007)(316002)(38100700002)(38350700002)(6916009)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wa5sbKKF+XUGzenQslKX6XkvI8BKY1YevUO3joPkV3Tf/AHC+5Tu2D60Ixpd?=
 =?us-ascii?Q?XcapaSR3gvh0pjpXJcFDl4wAggCV0ZYcQ3dmkwAU3yoZfM5h9hbDhk1r9frl?=
 =?us-ascii?Q?17w16fb7R+HmxXO5of5URplUmTF8pDFkcTOwWCR+x1ATpAtY7GdJb1IHKCMU?=
 =?us-ascii?Q?ohNiPbj3+EI6iPog4wF/UJ6hDhGzEwXo5gyZF6YJcRKsrogaZarjmFg+1bjr?=
 =?us-ascii?Q?ZkaOwvzRHG6GMeRtyBSxib5HxDmz5DOdu8asHP5dNl+xyz89IkVmkfKtbXUS?=
 =?us-ascii?Q?emrP2viLnG3gk12hKsivM6trz0s6f2bSmLf0+wkBPoovP0+dCq4PYJudvIzA?=
 =?us-ascii?Q?J520sMCZf5ShC5+IFXXy6NORNlTgGxAgC9XahKkMjOV7oyAF/MWHKXOdzoRQ?=
 =?us-ascii?Q?CYpJLccEAG7PzcBUwjgRBogKeGbiuzWoy6LImYOSy7d8I3J2tXxX4pJJVW6u?=
 =?us-ascii?Q?G4c1zxErdVvYsSIBsMoRHJiXfSh8xy9wZ6153RqYJ0cuIWTQ2L/cqmIFHjVH?=
 =?us-ascii?Q?csDMurk+j4KupWDiucqGSo5s7NZmzpJSq74QaIPy79fxuUOzP9tVT07tZmjh?=
 =?us-ascii?Q?N9AUrjGutdC29IMDMjntDj4LdRi+qcm8bTF2lOqafbSTtcXEqwofwY+0VJ9T?=
 =?us-ascii?Q?xjNz+GOfXtR2bPmrTrZ3doz8GFIL05VlKNOSqMALrwllVBb2VrK0e5AJ9aVT?=
 =?us-ascii?Q?6iUSve0I9zVzz6ZGLolz8TkNlh6YyJCncdItmHYFsJzsrSWG3DTNdSFHaW7r?=
 =?us-ascii?Q?5Ojnh1ZhQv1x/N1LUIh3KGw4bAMPSxXHAUjwBOhyntc7NcIRDLeNR/7G4L24?=
 =?us-ascii?Q?RtqtAODgFXzae/9ef2VmTbKFJHcPwA1MuCCps6Oj6KEAfvmtuEw75B5dC/O2?=
 =?us-ascii?Q?Qhc1GV77s2xK3cHONA903hc8gCWopaoV2BNLaq8zEPlnHEg1i2T/pWxnQ4xs?=
 =?us-ascii?Q?7w9Y7nk7XVltK0ZxLw+nmgUaTongkrg+CWd8VQjSoS7RtXCKsAT4TuGLzXFp?=
 =?us-ascii?Q?dmoZhtdZ2w6LMvTZPOOkByDW2MZccci9GdTmSntf4gAoONbLlvokq1Sa80RT?=
 =?us-ascii?Q?+qmoQ1I2NcVpxEhBNjoXktYlEjDV4i70QjDBCB06KbDOD+unmgtkvqzjDt3a?=
 =?us-ascii?Q?c0Dgsi+tj7uAvwRrdwOApTf/ziD5huVZl3eVQNWg3nATmjzIUPSgZvEY4ulP?=
 =?us-ascii?Q?2ANLzVeGGqok5SkqwU7XEHhCj1iDcZFM6ihdWE6tVi9liCTf5k5bZRtQlNs4?=
 =?us-ascii?Q?+j7dsTZlL+r2g4eJtFIv0RUmWrhituesqIl0cPoNU3tahSmX7MdoP+mANnmQ?=
 =?us-ascii?Q?CLUp/N8j6TuI4xq/02Gzo9y8KjzVqZZrmzHQVnV8I1Evv3Cfq6Ul4v0ac2J2?=
 =?us-ascii?Q?330y4YJmdbxg38d0rn9D0idLy/DD0O3KmGpvPRnshOQzjXdQxPrSrVxseq+B?=
 =?us-ascii?Q?nMbiVon66rse/gh33mA8Vn7G1GCws57I3PgotPdmkd6IIm5A6hjDqIt67/Bb?=
 =?us-ascii?Q?ZTZCqEEyM6S6KHZJ/7Zp74vF6dPQhfucRu6emRrwePBaVQSt0+a24hqvVmHo?=
 =?us-ascii?Q?IuQ79Y4AhS0pVyMujwtolUruhMGdshbOstgdPjQontZKHGXEB7qFlvk70LnW?=
 =?us-ascii?Q?8J2i57HCp6MHJ+10/iov/fw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c20b419-ec43-4e53-0274-08d9c16de9fb
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 15:00:07.1792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 907dJnWIlDw+51emoGIpMP7y8gk6zL4/RhXReC41bfxdhltvl/hukgxynpS4o/nT/YQcaHHfOr5T8x99IkLxHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0211
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git-p4 script reports file sizes in various log messages.
Previously, in each case the script would print them as the number of
bytes divided by 1048576 i.e. the size in mebibytes, rounded down to an
integer.  This resulted in small files being described as having a size
of "0 MB".

This patch replaces the existing behaviour with a new helper function:
format_size_human_readable, which takes a number of bytes (or any other
quantity), and computes the appropriate prefix to use: none, Ki, Mi, Gi,
Ti, Pi, Ei, Zi, Yi.

For example, a size of 123456 will now be printed as "120.6 KiB" greatly
improving the readability of the log output.

Large valued prefixes such as pebi, exbi, zebi and yobi are included for
completeness, though they not expected to appear in any real-world
Perforce repository!

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 2b4500226a..8c1130cb8f 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -56,6 +56,16 @@
 
 p4_access_checked = False
 
+def format_size_human_readable(num, suffix="B"):
+    """ Returns a number of units (typically bytes) formatted as a human-readable
+        string.
+    """
+    for unit in ["", "Ki", "Mi", "Gi", "Ti", "Pi", "Ei", "Zi"]:
+        if abs(num) < 1024.0:
+            return "{:3.1f} {}{}".format(num, unit, suffix)
+        num /= 1024.0
+    return "{:.1f} Yi{}".format(num, suffix)
+
 def p4_build_cmd(cmd):
     """Build a suitable p4 command line.
 
@@ -2966,7 +2976,8 @@ def streamOneP4File(self, file, contents):
                 size = int(self.stream_file['fileSize'])
             else:
                 size = 0 # deleted files don't get a fileSize apparently
-            sys.stdout.write('\r%s --> %s (%i MB)\n' % (file_path, relPath, size/1024/1024))
+            sys.stdout.write('\r%s --> %s (%s MB)\n' % (
+                file_path, relPath, format_size_human_readable(size)))
             sys.stdout.flush()
 
         (type_base, type_mods) = split_p4_type(file["type"])
@@ -3064,9 +3075,8 @@ def streamP4FilesCb(self, marshalled):
         if not err and 'fileSize' in self.stream_file:
             required_bytes = int((4 * int(self.stream_file["fileSize"])) - calcDiskFree())
             if required_bytes > 0:
-                err = 'Not enough space left on %s! Free at least %i MB.' % (
-                    os.getcwd(), required_bytes/1024/1024
-                )
+                err = 'Not enough space left on %s! Free at least %s MB.' % (
+                    os.getcwd(), format_size_human_readable(required_bytes))
 
         if err:
             f = None
@@ -3110,7 +3120,9 @@ def streamP4FilesCb(self, marshalled):
             size = int(self.stream_file["fileSize"])
             if size > 0:
                 progress = 100*self.stream_file['streamContentSize']/size
-                sys.stdout.write('\r%s %d%% (%i MB)' % (self.stream_file['depotFile'], progress, int(size/1024/1024)))
+                sys.stdout.write('\r%s %d%% (%s MB)' % (
+                    self.stream_file['depotFile'], progress,
+                    format_size_human_readable(required_bytes)))
                 sys.stdout.flush()
 
         self.stream_have_file_info = True
-- 
2.34.1

