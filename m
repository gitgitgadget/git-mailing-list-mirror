Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB08C433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 15:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242879AbhLJPfM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 10:35:12 -0500
Received: from mail-co1nam11on2060.outbound.protection.outlook.com ([40.107.220.60]:47009
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242871AbhLJPfL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 10:35:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coGyPdAjWSvs+Hoj83WKtcRLFhPUyR51G8R0iEdk80f3lEmY7T8f4iEDusOOluNBl9QmLItbBzuvpvU59sDbSsJ+VzZBWZr/8cT8xoWGXly3i5zG3+V5mJb79T66R/BbRGCyw0B2OPZ2vpDuXfrCELLNKzqo2x5L6S7zgaKXxoQdZc41LVFEauD0Lq3uNNJH/sGgVokw/E2fes0QzZlhCV7yFSOFkmHkxliqnOo1lh/ClOxRpPo+aDAOkYUD91BjXHqTUjbWo9EDfr5+5BzwMzN1hsHca3PhuC0TSe2zXNhImIiYLGes7tmDqVffhMptd6vtI6xDxiuw5aKMskQvjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vkeIArfKG8KpIOXRIrRZCdwUXqhxFNdZfVjNshTXlg=;
 b=DoPuxPZ06d8T/03yppFQplnj7sx0XSs5NogAn66opkyAtFOCMBfOTWZgyvQUOZMOEkd3mV7rqsMY746nsmvjatNwEYi426rTx59c7+jgvUPz+ecldsHfJ5gLChIFuXhqASeNrTW2OL4PB6ylkZdPBCUFrRTxVR6v+1gE/nTaAT5+nZh5vdv8G72VGepis75G+VIZ7cfDZcJ2XT8Rr2I1CxER8wFHpsOtbvaOTRGq8HeiiWQ4KK7SVeX9Danc/+Yf9Ue3pknH5DXlrzT7DG9HOtwWJf8aiHeUtKD6fJqumtIDxcTet4Yf5FBoyBNjQOzsRBbsMPolqspIH597PYoLIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vkeIArfKG8KpIOXRIrRZCdwUXqhxFNdZfVjNshTXlg=;
 b=rBAsg2xf0eD+1ITAzYZo2nMmbH9v1Eda3zv0fuYxqR54q8N28ObBnknoNSPBSjEqshXeZ1k96YHV2rvoHVIBhjvkD4jBSyuqbfCGuhr+Yj9nYMiidRINoMypIRZ32vp1SJuHGa5y2mVZ0xgSq6Nc+DBRiHABBmnqNS/v0bEOorHsqZ9ExOYdQT54cwTmmYhZ6X6899rj8RZCNhb4YA5nSUw4ltBrjwWzS3xguStzhcCL6upfqYXo2tsWgMvhtc13VXBhua95umKoxDv92t4FzzqbyVRfUNL+5Ez0ZQlyez/7+RowcPYWTvkctQvBvc7a0Wmpm6SCw0vOdkY46XlwVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN6PR1201MB0018.namprd12.prod.outlook.com (2603:10b6:405:54::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Fri, 10 Dec
 2021 15:31:33 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4755.025; Fri, 10 Dec 2021
 15:31:33 +0000
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
Subject: [PATCH v2 1/3] git-p4: remove support for Python 2
Date:   Fri, 10 Dec 2021 15:30:59 +0000
Message-Id: <20211210153101.35433-2-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211210153101.35433-1-jholdsworth@nvidia.com>
References: <20211210153101.35433-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0128.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::7) To BN8PR12MB3361.namprd12.prod.outlook.com
 (2603:10b6:408:67::19)
MIME-Version: 1.0
Received: from red.nvidia.com (195.110.77.193) by LO4P123CA0128.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:193::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend Transport; Fri, 10 Dec 2021 15:31:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fee86fd5-514f-40fe-f42e-08d9bbf224b7
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0018:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB001878CD7A1A68D804683AAFC8719@BN6PR1201MB0018.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lGUwvu8jEfVAwVQhGs7z44bqiNRVPjY06bhUvetE2D3SJ4+/vcvBrPLNj/XL8ISEuk1S5iIsTz2wrzn8khkOfGEcTqH+7wE9CDxO/zR5uCipawOy1GuGQabg0LaDIQTuzZtGyaA8GQYuYmsRpGFpEDQIdohL57gmEPnNDVQ0SmiM6vZ5BUa7LO7nQQDM1XELh1wId7+2UUK7j5ZkRpjHjC/MuOSA2l4xtlPdNeTtKF42wb+dYNvTiOWrMtlFQFfhraCktQmckhLS94jUsF3Hai8Fnb9acJ/jQHRiW7cPig8oEHaYK+B60A91TFKPvPHWd8ILW9sY+/95k/OEE0ExWPRqb/fQQvDaDa4Wt1/Don2sJrO+H1Oyai80W0huD63FFbiYXExHxVZf9LCcq4p1MHbyj21k4iDR+MhKE1Pg8pdts6kQI8vPvvh5FhfAD99v+rsEIZ6VfsZTL/Mi7g9XZ97ZdNJc6nO6owQFojolWD26ioLMeJsMo24/oD5hJ9RldlfiUnqxEq9U8OUn9prfnIFwKWE+Q4EkQAfWCZj7Z/33yTP3AGTlctSa0EcGWYtgtqnTWr/yEuxiMA87+cEBNFQ05Ub74PX3yD1tAQawYau3ET+dS71mAxqgphkPXRZShDg7nUhHgpMTRub9gMm/2o43I/FT7LimXC4ZG48KItivjaF0vIEx5iEsERZkh/9anyfJl911AIAF6n6Gtu+5JQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(66946007)(8676002)(38350700002)(316002)(186003)(26005)(6666004)(52116002)(38100700002)(83380400001)(7696005)(4326008)(107886003)(55236004)(6486002)(66556008)(1076003)(6916009)(36756003)(66476007)(956004)(54906003)(5660300002)(508600001)(8936002)(2616005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5ebxe4NbtLwWwU5wq1zmNW6VFQcIh1RE+EpiDt7iGoVcPPg3WBW59VH5It4N?=
 =?us-ascii?Q?ev8yuMU4rpDg+bXN1nRUzfglEQZEfELALSpa+MBjrVIluXEX84kVgqwNiwY7?=
 =?us-ascii?Q?wzYLkD8AN4GT9rBgbVJiafRf+FkBV9Z3JS0DidjZVTx+zOLOE0Ajv7K2f7QS?=
 =?us-ascii?Q?64XyUSjlN3Rsb5AoxC7MML1StzsAMjFVJ0eoFTf14PB56YehCwzESk5UV3FV?=
 =?us-ascii?Q?6On6MN0hZu0Woa0Z+xQj1VQfuUB9TTjodjW3OEAThg70c6V/kbLnLvO/9xma?=
 =?us-ascii?Q?dU2iaM9Gkv8va/QSWDzLVwyV5mxJFHeWToKDsXIpPIMCyJn42wfPnliv6tYZ?=
 =?us-ascii?Q?8CxC90VeDZoQBltsgPhLvfCd9FOUbI6ZLNPSiN0wc1I99/Uv45m8zGaxfvkC?=
 =?us-ascii?Q?Ex78AJMtL47gvOd5eRG7cbwzUaHfajuvqvZOM8W6rl86K4wjY3EyvJHjxH44?=
 =?us-ascii?Q?KUgXVTiixxZ/W/12kN4kBp+DOq+XeyREyN9lYJHSnY/tXKt8RJsq5dc9ukBs?=
 =?us-ascii?Q?ZM1TNK0OjQSxNx2YzChaZ3rUsN0LDZulA6Ong1PTmHpK9C2te7xhehNzkeZr?=
 =?us-ascii?Q?PXRBvrwOb2OzvgCbrmnddMFlN0Ba4KUj+dYgWobjsFF7Ar23yerzy4Y9Vuhc?=
 =?us-ascii?Q?6YLn+wzf4uFN+si+QquSNvwHgMZ2eYxBRPYzaD2EN8VmMnCfs959YQEGrXV4?=
 =?us-ascii?Q?l8d+5nGUD4IYbBkv6JdKaRLzP0/SZa20Gb5X8OOvuzTzLXvaWTk4nPmz7n7m?=
 =?us-ascii?Q?qAiZkc8MfBlfliszJ+7D/Ah/gz0dc+mVHO8IarlBfKOgDcbWEThwcXOcWNFG?=
 =?us-ascii?Q?9h08u4zguvuy8fdgrlxh2TXqGpLxOmRR0XhYSEKJblDAS5thBvsp4vK7wfPm?=
 =?us-ascii?Q?ExcdXaINDRaaxK3j1+zwuUyDjHZcdIAPGjtM2tQ5pd8bzoD4HIQQ6tG7HiiQ?=
 =?us-ascii?Q?TNqMUmJplsVPGhju6lt1GhV2Oy3fjrWPamsgthKhtz94uPvu0AYfidIgdqd9?=
 =?us-ascii?Q?8PLEqYqmV4TP3xxN/qbeMFqUijsDfNmuYZ+bQXF8vj9/9XrFg5hHGqgMiXdl?=
 =?us-ascii?Q?8pA0b2LmAAEuUVwMjNqeb63fKnEqKBaU1H4djKcjYb1aH1tyHzXJtQ5151hl?=
 =?us-ascii?Q?g5p1EJ2puQh1CGd/jfxmCJu0qwLO2XatmDpyjkdv4t5SlNfNwTS3+AlNR0dR?=
 =?us-ascii?Q?7DwKzTpzDuNYBXqkVorXSChO1dhbvk5I+0dV61u9y3ZJJKvkxAno9QixfRcq?=
 =?us-ascii?Q?3kTmVHra2clCu2sO210LD5zEff4wYx/OxOILBeN0nPXK9uAdxThevQOdGOV3?=
 =?us-ascii?Q?2WbiNADJtrtP7AxCinMgpy88T2JPaRWBi8SG2ukSAosVB/ItIA2k58NhU00J?=
 =?us-ascii?Q?JRDPeZl3l5rGzJwO//Y0wRmT4KcuVaHkBt87kAe+kbfS2eUoYHGocZ8u3gKd?=
 =?us-ascii?Q?9RGLKBCZRXcZoZxwReeYHcxjxe9+FBMZ4VOj/UZPbu+xR7/tj9XAheUCno5W?=
 =?us-ascii?Q?Rx1JoGaM6N6E6mhh7vgIYgbGwc9kyAs4lgfMAoAGRLdPNsCkk8Uv8NmZhwrV?=
 =?us-ascii?Q?th7wt3j8Moj5NsJKgvsIdsrutyxLC1CPvdUtxfiQRedCabnrj1ngo6K8mTmS?=
 =?us-ascii?Q?N4eTAYaQB2aPezBBcaUvnYo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fee86fd5-514f-40fe-f42e-08d9bbf224b7
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:31:33.0546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1WtCYeEiC9VwpNvyNcpBODwZI2cdeA6Q/iyAvNt3ARtjoTlt4IYqge+QvX6f7vbvY8SJX5PPruog7cgApN294g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0018
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-p4 previously contained seperate code-paths for Python 2 and 3 to
abstract away the differences in string handling behaviour between the
two platforms.

This patch removes the Python 2 code-paths within this abstraction
without removing the abstractions themselves. These will be removed in
later patches to further modernise the script.

The motivation for this change is that there is a family of issues with
git-p4's handling of incoming text data when it contains bytes which
cannot be decoded into UTF-8 characters. For text files created in
Windows, CP1252 Smart Quote Characters (0x93 and 0x94) are seen fairly
frequently. These codes are invalid in UTF-8, so if the script
encounters any file or file name containing them, on Python 2 the
symbols will be corrupted, and on Python 3 the script will fail with an
exception.

In order to address these issues it will be necessary to overhaul
git-p4's handling of incoming data. Keeping a clean separation between
encoded bytes and decoded text is much easier to do in Python 3. If
Python 2 support must be maintained, this will require careful testing
of the separate code paths for each platform, which is unreasonable
given that Python 2 is now thoroughly deprecated.

The minimum supported Python version has been set to 3.6. This version
is no longer supported by the Python project, however at the current
time it is still available for use in RHEL 8. No features from newer
versions of Python are currently required.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 90 ++++++++++++++++++-------------------------------------
 1 file changed, 29 insertions(+), 61 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 2b4500226a..e3fe86e4f2 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # git-p4.py -- A tool for bidirectional operation between a Perforce depot and git.
 #
@@ -16,8 +16,9 @@
 # pylint: disable=too-many-branches,too-many-nested-blocks
 #
 import sys
-if sys.version_info.major < 3 and sys.version_info.minor < 7:
-    sys.stderr.write("git-p4: requires Python 2.7 or later.\n")
+if (sys.version_info.major < 3 or
+    (sys.version_info.major == 3 and sys.version_info.minor < 6)):
+    sys.stderr.write("git-p4: requires Python 3.6 or later.\n")
     sys.exit(1)
 import os
 import optparse
@@ -36,16 +37,6 @@
 import errno
 import glob
 
-# On python2.7 where raw_input() and input() are both availble,
-# we want raw_input's semantics, but aliased to input for python3
-# compatibility
-# support basestring in python3
-try:
-    if raw_input and input:
-        input = raw_input
-except:
-    pass
-
 verbose = False
 
 # Only labels/tags matching this will be imported/exported
@@ -176,35 +167,16 @@ def prompt(prompt_text):
         if response in choices:
             return response
 
-# We need different encoding/decoding strategies for text data being passed
-# around in pipes depending on python version
-if bytes is not str:
-    # For python3, always encode and decode as appropriate
-    def decode_text_stream(s):
-        return s.decode() if isinstance(s, bytes) else s
-    def encode_text_stream(s):
-        return s.encode() if isinstance(s, str) else s
-else:
-    # For python2.7, pass read strings as-is, but also allow writing unicode
-    def decode_text_stream(s):
-        return s
-    def encode_text_stream(s):
-        return s.encode('utf_8') if isinstance(s, unicode) else s
+def decode_text_stream(s):
+    return s.decode() if isinstance(s, bytes) else s
+def encode_text_stream(s):
+    return s.encode() if isinstance(s, str) else s
 
 def decode_path(path):
     """Decode a given string (bytes or otherwise) using configured path encoding options
     """
     encoding = gitConfig('git-p4.pathEncoding') or 'utf_8'
-    if bytes is not str:
-        return path.decode(encoding, errors='replace') if isinstance(path, bytes) else path
-    else:
-        try:
-            path.decode('ascii')
-        except:
-            path = path.decode(encoding, errors='replace')
-            if verbose:
-                print('Path with non-ASCII characters detected. Used {} to decode: {}'.format(encoding, path))
-        return path
+    return path.decode(encoding, errors='replace') if isinstance(path, bytes) else path
 
 def run_git_hook(cmd, param=[]):
     """Execute a hook if the hook exists."""
@@ -289,8 +261,8 @@ def write_pipe(c, stdin):
 
 def p4_write_pipe(c, stdin):
     real_cmd = p4_build_cmd(c)
-    if bytes is not str and isinstance(stdin, str):
-        stdin = encode_text_stream(stdin)
+    if isinstance(stdin, str):
+        stdin = stdin.encode()
     return write_pipe(real_cmd, stdin)
 
 def read_pipe_full(c):
@@ -762,21 +734,18 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
     result = []
     try:
         while True:
-            entry = marshal.load(p4.stdout)
-            if bytes is not str:
-                # Decode unmarshalled dict to use str keys and values, except for:
-                #   - `data` which may contain arbitrary binary data
-                #   - `depotFile[0-9]*`, `path`, or `clientFile` which may contain non-UTF8 encoded text
-                decoded_entry = {}
-                for key, value in entry.items():
-                    key = key.decode()
-                    if isinstance(value, bytes) and not (key in ('data', 'path', 'clientFile') or key.startswith('depotFile')):
-                        value = value.decode()
-                    decoded_entry[key] = value
-                # Parse out data if it's an error response
-                if decoded_entry.get('code') == 'error' and 'data' in decoded_entry:
-                    decoded_entry['data'] = decoded_entry['data'].decode()
-                entry = decoded_entry
+            # Decode unmarshalled dict to use str keys and values, except for:
+            #   - `data` which may contain arbitrary binary data
+            #   - `depotFile[0-9]*`, `path`, or `clientFile` which may contain non-UTF8 encoded text
+            entry = {}
+            for key, value in marshal.load(p4.stdout).items():
+                key = key.decode()
+                if isinstance(value, bytes) and not (key in ('data', 'path', 'clientFile') or key.startswith('depotFile')):
+                    value = value.decode()
+                entry[key] = value
+            # Parse out data if it's an error response
+            if entry.get('code') == 'error' and 'data' in entry:
+                entry['data'] = entry['data'].decode()
             if skip_info:
                 if 'code' in entry and entry['code'] == 'info':
                     continue
@@ -3840,14 +3809,13 @@ def openStreams(self):
         self.gitStream = self.importProcess.stdin
         self.gitError = self.importProcess.stderr
 
-        if bytes is not str:
-            # Wrap gitStream.write() so that it can be called using `str` arguments
-            def make_encoded_write(write):
-                def encoded_write(s):
-                    return write(s.encode() if isinstance(s, str) else s)
-                return encoded_write
+        # Wrap gitStream.write() so that it can be called using `str` arguments
+        def make_encoded_write(write):
+            def encoded_write(s):
+                return write(s.encode() if isinstance(s, str) else s)
+            return encoded_write
 
-            self.gitStream.write = make_encoded_write(self.gitStream.write)
+        self.gitStream.write = make_encoded_write(self.gitStream.write)
 
     def closeStreams(self):
         if self.gitStream is None:
-- 
2.33.0

