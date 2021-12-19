Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21037C433FE
	for <git@archiver.kernel.org>; Sun, 19 Dec 2021 15:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbhLSPlA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Dec 2021 10:41:00 -0500
Received: from mail-mw2nam12on2052.outbound.protection.outlook.com ([40.107.244.52]:55520
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231898AbhLSPk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Dec 2021 10:40:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPPI/hzntaUoN7neAwgMNhOpUq5IR3dWTpr5QDCfXCBY7DvumDkcjOMUqx7OsgQ94JiUMMiZwuuXULTaWcKNP+S8/M4dW1zZW4FBiBwHmVnEtmBuMruIXz0djPidNshuIcT81/VqavCQDSsqcb77PuHNq56VQuxSvqzbpv2n2+iwT5REHJqUUp2Gza20IRLBtY71x/x5mKagStjQE+9zMwEQiGhr4DBQME0+YXPF3Bp1ADVLLkLImxEQV53bk1zdyDp5lCdA9aX1shoKGq19QJNgDvKFjJFh8MPI7xWU1UqCJU4oq/pLawljL+ocPu6ZvdMHaUPgwOPqRuMJciBrFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQZKRwdkIkWlojziOz/GugoWO/hCcWvvu5VwII1vfjA=;
 b=jHn2jbb404prA9gN1gcYT4DYIEBMLsV8HEmM/KgvR/DM9DBKhLGf1mXcYYxV+LbC/C1iChLno/yAgMGJeWpgXnVdJObFEP9mz3WHhGBgiXzrI7qxMLVBE5KsXGqOjiD1wLvH28fB6o9ouSEtISpKRMLuNCY9/oVUVs69HtSnDotCASmyTRdVfsh0hCQcjlqVQPXzHMTmWfWXv/znIN6vIo3PgoMWofY6UW5Pk2/ASDobWSbkj/Xgpw80xfh2Xsnnz8UPOkzQd6dzOJPBpwrnw3BySuT5j3DmP4DAHeoWzdHfqvxprkXk46QKd1BUS7jC/gH5/HPDJg1rs6nwSSG8Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQZKRwdkIkWlojziOz/GugoWO/hCcWvvu5VwII1vfjA=;
 b=L8yaS4a/q88aS7sYW9H5ezhiRrm/dnEEV4qx/ZcFgZwA8W0pUliz/U1rfiCcOmdtoIdouNGtil5MPgUnEnnNyEVPaXPf+xc27XjV19V2gViKgNq4qUnu/tFwNuJcWy9M+IomHG2OKRzlYxiHFaUfcKRhbf5maw9aY9uTa4BZQ2ZXKhrF6TcLjmfxJbCiV8O9QR3KYUOZsQOpbUSeedR55tx/hyaDmuefugt+zqwxdSexmwZh0kEUaQweMkpnJNImcN+vN5cQMvW5tGkYEBRe2OHCdkPqRScIEtoCgl4Phdm9A1j2RzTBOqG2NkFog3BMRc68UF7l9/Se3/whCXv+KA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN6PR12MB1186.namprd12.prod.outlook.com (2603:10b6:404:1c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Sun, 19 Dec
 2021 15:40:54 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4801.020; Sun, 19 Dec 2021
 15:40:54 +0000
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
Subject: [PATCH v3 1/2] git-p4: print size values in appropriate units
Date:   Sun, 19 Dec 2021 15:40:27 +0000
Message-Id: <20211219154028.3288756-2-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211219154028.3288756-1-jholdsworth@nvidia.com>
References: <20211219154028.3288756-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0098.eurprd04.prod.outlook.com
 (2603:10a6:208:be::39) To BN8PR12MB3361.namprd12.prod.outlook.com
 (2603:10b6:408:67::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5da3871-1783-40bc-0f70-08d9c305f13e
X-MS-TrafficTypeDiagnostic: BN6PR12MB1186:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1186BDDFF0FC5AD72E0E1A24C87A9@BN6PR12MB1186.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uoUWG1EQ6g9ur0yXsY/Ipu34RJMNVjWGCkRxYQ6yD0kdOFItAmI4YbmWEgOBdTEdUR2yXjhADi8nA2OkE2LcRNFssF/J/FkRQA7zW4rYoxtaRO9Fik+4uClUoJr6LTVXiNrQ4juuE0+VK7kQZ1jhF7Pbq/sf6j5Wl2qCZZJNyosElpa1oUU8maaoDkdW4xr+I8W1y7fxGeaQT0kFAXZfWD+jQgmt5i1h6zGL3aD3LfQazTAeDNyiSMEPQjaus8L7UkeE7PWQUZnQVQoh9nr+En+xzlParSa3LRhXk6rz3v1AGbVr9zmT+gSwqzYGsVC/2vKqEpwalhcEk1NGR2qmDS6eCZ+nUNpr1aL2JO+gP5mfENSxeQ5mK6AxX8oD3bhzvod1cW96cvE+8dmVe/SkB/kAatHkfU36NPGK0NRb8C8Ht7js4/4REOQIjoMIVVARtqK6ScmmZdGlQxa0oNBOKlsM+qabRMiFNn2T38WjO9fuAq3SqkqPsoed1b1FXlQUh2Egxkf/DWUMA4NF3Wr/7RYZzL9Ahti0k01NCDI2hVvFQLXB4/E9leCRgOGdEm/W8jjh1+86qzLofKsHUGsIvvEAlozvBn6NaVL85BbDDdT14QJlO7kHKU02vMSbclbaRfnGpbGiaZQ4ZauaA8IYaSuhhxFZ4iA1R0M192i/qi4u57VKFaudMDKBThaOKUyiYnFbhNYwiUGJJAA1ygRsPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(186003)(6512007)(26005)(6916009)(52116002)(8936002)(6506007)(66946007)(1076003)(8676002)(66556008)(6666004)(55236004)(66476007)(508600001)(6486002)(2906002)(54906003)(2616005)(38100700002)(38350700002)(107886003)(36756003)(4326008)(316002)(5660300002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dz8jcA9lrr612Srqjw+dw6hXZJWTSWpdk/ZJsdePvPUHDgACdCGFRWSvciWo?=
 =?us-ascii?Q?elOY6+qXEOiJXAjDmyGBmcYowljIN1j9hTtP/uPSoFWSJMN3nHFSLZ1JtBZJ?=
 =?us-ascii?Q?2FEEriJazdTCrWRTaMNdVbX9mqpTd9VWK+tsbYnbKDFhziX5R9WTCEqPkNrV?=
 =?us-ascii?Q?f2aAV6iuEwB777Lz8DNz4GC0nEoxU7yljry37CNTvH3ar1NQ9KtY9WBDKdCl?=
 =?us-ascii?Q?lzaDd7Lvqtcu+Z+q8+6Z0YjfyrknYyAKyZbO8AcjoT6ckBqyQpJMrvsmxvlx?=
 =?us-ascii?Q?EC6W2iUuk7IHB6cAoDpJJRKewWVp3sJpUpw0dR1IEZa8YRBojGGjEPzOSYwN?=
 =?us-ascii?Q?1cX1sZmFg/VuVNzURaKOc28tua5m5FCGjEQTMfZj7tDLxzUaOi0C2wzHsthh?=
 =?us-ascii?Q?i8hX8rErvglEPEzsWlaiyj1JRERXoWYTmuMMRyR2CLUa4PwoObk304E4jJ2+?=
 =?us-ascii?Q?aJ5VSgIsQE5UlBhgsDjQgSvQ3MiyasL1IfpAjlUAl+xsQ1J8R4O7MT7k6YML?=
 =?us-ascii?Q?/86M11dMuWslsOOpER4Wb1kOs4KQ9FLfuXM6Kg5uhyfkDpWHo3MctxEjd0Sg?=
 =?us-ascii?Q?3CunFxuob5a6IRmgnrDZn4Aq6F0mV2lnDHlmElynGTeU69A0gYaVUD1WblLu?=
 =?us-ascii?Q?cMfY2Vb2WpGMQ25nIe7nSVQIn+nFV32olu6DPkQJc9kfaI0Zrjg0+CV0QPr+?=
 =?us-ascii?Q?y99hJrK1JXsWwSaF/QzVoI0DcfFsGbp78ISo6u/U3qxq/VDpgY/86WOvJx57?=
 =?us-ascii?Q?J93mXEaf8qdBQhIhv2fbn5j4CB4aQirdb1ivGk6hgK6GFV3hJZv3cEFQCtlv?=
 =?us-ascii?Q?FA+xev5nVN6bE+99pqWZGLIoxSQqaM0Eh2LDyKw2CJTHHI4bZflmKeaZDO/P?=
 =?us-ascii?Q?fB3MUUxdwHRB23+RK1C2UoDn9wtCdRlYBkJK/5MWzoYLL5rZItAtOEx0TgGk?=
 =?us-ascii?Q?i4QF+jtkNao3wSG98nWU5xRnfn2Wlyk5I3GFNNkbNp1CmI4EM5d1WLTXlSSm?=
 =?us-ascii?Q?Uw9Ffq2oXgxM76vb/Bd0XnPLRrYeYM3ukXYXjJGt0MA5j9uN5PtblmV0p58W?=
 =?us-ascii?Q?FgtlJJGN2kWgjKcTV2FaDKJY2dgtkv66S37gCJsZMHOFY/xmua6i6LnqgC/6?=
 =?us-ascii?Q?Wfsf0D0kes2wZ/sb4O5JyjdQoYgWan1PXwhgJqvJOBJujlDL/1VTZ1eXIWoF?=
 =?us-ascii?Q?/9nQS3AeI/2rCmXQrUel1pEXEL3VG69Iynw2ZlXXwW3+8EUZaRSvD3GDpM70?=
 =?us-ascii?Q?VgglXrhx36cCUN+wGTQ8iBJHVMLSocLeeUcBQE8cLiHaWstuP6BksBs2hOfd?=
 =?us-ascii?Q?Hbq3FXLPGyrEgBBffrKw2wlFdkfBdZ/dEcvhuAj2y2UT1s5QCucqmyrO48gr?=
 =?us-ascii?Q?pwRmJlKqcCwZT0PzMD9W5RYCmEmFk0qxzjQIF1CI74j5XQv4dJO/IHCd/+TR?=
 =?us-ascii?Q?st2GUcVdEf28XkomUxG65BSDFtch0gWmAydzjQ/OS+c7QZErRLrqbYkgzRXu?=
 =?us-ascii?Q?hPmVKNKC778j2NcseRJDSKrFSZdUWTZLfttkFOnE4h7OK9RkZ+0HPIHGLCJd?=
 =?us-ascii?Q?1xBmjIsfqMvB0LHoCrOlL64Q6zV6QriqBjmKweefH2NBL1+fH5ld48v4Yj8/?=
 =?us-ascii?Q?nlYj28vfIuUAI1kDhP+gW2k=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5da3871-1783-40bc-0f70-08d9c305f13e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2021 15:40:54.1643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IlPVmOCyJFhssxKZwJP+KsqV2faQWGZtHGhCLiXFqP891GJBdEtT1ahqaZZf1qx27YVyRDWN60rVqIv3jVfrAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1186
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
The updated version of the patch removes the spurious braces when
printing YiB values, and prints sizes less than 1024 as an integer
number of bytes.

 git-p4.py | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 2b4500226a..74834736fa 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -56,6 +56,18 @@
 
 p4_access_checked = False
 
+def format_size_human_readable(num):
+    """ Returns a number of units (typically bytes) formatted as a human-readable
+        string.
+    """
+    if num < 1024:
+        return '{:d} B'.format(num)
+    for unit in ["Ki", "Mi", "Gi", "Ti", "Pi", "Ei", "Zi"]:
+        num /= 1024.0
+        if num < 1024.0:
+            return "{:3.1f} {}B".format(num, unit)
+    return "{:.1f} YiB".format(num)
+
 def p4_build_cmd(cmd):
     """Build a suitable p4 command line.
 
@@ -2966,7 +2978,8 @@ def streamOneP4File(self, file, contents):
                 size = int(self.stream_file['fileSize'])
             else:
                 size = 0 # deleted files don't get a fileSize apparently
-            sys.stdout.write('\r%s --> %s (%i MB)\n' % (file_path, relPath, size/1024/1024))
+            sys.stdout.write('\r%s --> %s (%s)\n' % (
+                file_path, relPath, format_size_human_readable(size)))
             sys.stdout.flush()
 
         (type_base, type_mods) = split_p4_type(file["type"])
@@ -3064,9 +3077,8 @@ def streamP4FilesCb(self, marshalled):
         if not err and 'fileSize' in self.stream_file:
             required_bytes = int((4 * int(self.stream_file["fileSize"])) - calcDiskFree())
             if required_bytes > 0:
-                err = 'Not enough space left on %s! Free at least %i MB.' % (
-                    os.getcwd(), required_bytes/1024/1024
-                )
+                err = 'Not enough space left on %s! Free at least %s.' % (
+                    os.getcwd(), format_size_human_readable(required_bytes))
 
         if err:
             f = None
@@ -3110,7 +3122,9 @@ def streamP4FilesCb(self, marshalled):
             size = int(self.stream_file["fileSize"])
             if size > 0:
                 progress = 100*self.stream_file['streamContentSize']/size
-                sys.stdout.write('\r%s %d%% (%i MB)' % (self.stream_file['depotFile'], progress, int(size/1024/1024)))
+                sys.stdout.write('\r%s %d%% (%s)' % (
+                    self.stream_file['depotFile'], progress,
+                    format_size_human_readable(size)))
                 sys.stdout.flush()
 
         self.stream_have_file_info = True
-- 
2.34.1

