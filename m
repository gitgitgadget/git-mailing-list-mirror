Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F64CC4332F
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 20:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhLIUO3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 15:14:29 -0500
Received: from mail-mw2nam10on2076.outbound.protection.outlook.com ([40.107.94.76]:37985
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229478AbhLIUO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 15:14:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJykdnfvpPkjO2OsnF5lIe1qCRJTjuqjSXymPA8S9ZKTAyXtUvT3kPxlaRKTf3/VgRr3ob7/EKRcWD7sWOCxasUpgCYh9GC+C1tewylhBgzgtMwUB9sro+6JDSyrpTlzMHTdXKJa/wRemZ6bQLn6Z4L2OPX0I46o7aN0GwA6JU0mkbN2h0KDdJXIkxM4M/vdJkvri9Tb2WaLpG/R8hT54L46XJcn7F5g3PvSgpq9glsJjtIfaEBQsD178PwslqAYx/IwkK4RdJA+pvkAw286OrhHr7ft2XG6tFDcZZOUgYJPFF33JEUUt0UKMUWAblTkVQgU7bczR8sngxC/VTdR3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Di4ipmYczjfLM8WmvU6C5bbHcIcLSUscTJgkY5fqXqA=;
 b=lkvAuF7tUNRhu9sjIeEAYx0Ed0+dfeKi6LH/SeJfNeMCQfv8BvQpldnlfzVYAAYHGolNZG4DBVZftZWjiqZQnzu0JFIUF3oaKkMQ2KT66fbKs0FP66J6R1ciA+EYVxSIYNTAGtyuSU3SvAUD+jSMe6yx2dQEVW5Lq1DKQvdLEaWZqFXs4XPnEnBb3HwHHX8LSJVE1H/QevQeQ2tTOOJGCr4l04XN9s2oojxRw4EQwDSMgwXVo9aEsVQkYgibalmMD3mocpKBkHDtFdpdH8/BdvdgvR2AmP0CoQw8zke3ko9k19vfJxLI/ws4QwaPCSwTrK2u+/s6WS0ZGaTfdJteUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Di4ipmYczjfLM8WmvU6C5bbHcIcLSUscTJgkY5fqXqA=;
 b=ouA+IQWT1DsOaze3Pn2mgiredlG6kmbcPhWACm9HEqY7DaGTkW5jFrdLL7iZ5QHqgw5EAAcoZoOW9gByBg8y9dYp6FlxtXCMGjf0o79b63+Ii3mdzSw2R8GpLaSeFe02hZgXWXIT755xOD5sVqAPemjOKtQKRji4nu8pgW5Ep1cqgGQxY4ZAPL5tVtGzQaYhaR859Yww7x8aTtRmgzunWrLCzZLTRmRxI2cCBP74h25Hcda+8Inoot4oKeXr6RpY++GXhOmE+DMBI7VDqfsPBV+FFowQpvzqZa6MNI2Xd2fC7MQNnP+XC0X3lli+vK5BxlsYSbIAONd3e+va8Bd7yA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN8PR12MB3282.namprd12.prod.outlook.com (2603:10b6:408:9e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 20:10:52 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4755.025; Thu, 9 Dec 2021
 20:10:52 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org
Cc:     Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH 3/6] git-p4: Removed support for Python 2
Date:   Thu,  9 Dec 2021 20:10:26 +0000
Message-Id: <20211209201029.136886-4-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211209201029.136886-1-jholdsworth@nvidia.com>
References: <20211209201029.136886-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P195CA0012.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::17) To BN8PR12MB3361.namprd12.prod.outlook.com
 (2603:10b6:408:67::19)
MIME-Version: 1.0
Received: from red.nvidia.com (195.110.77.193) by AM9P195CA0012.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend Transport; Thu, 9 Dec 2021 20:10:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 688dc137-a9e1-4ff3-a182-08d9bb500033
X-MS-TrafficTypeDiagnostic: BN8PR12MB3282:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3282B65538D2A93E80062C12C8709@BN8PR12MB3282.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vz/H9fYgMgVvucStb306HRfL/vY6L33PodE8oNgJSvPHB+gPaw/9jltkUxB7yYwLNaAajtQCmt2PtR9VQxdJ9lc1vaWvOjAofnPRjxA3FlWTA+yZO7b8smiYvWxqwg59dUOQBlz4BZ0OODIw4vYUf2+TANqQ9Qxe6iXgC6EIil8MPxZQ/Kmnx6wwo5GXRPNunMbuIrMasEjZZzIpCRRyHG9CTzQMQBh4oNFaOHkSuFSU5E+AB+wpdB+OB/Mj3OfiWjNIxCo6VMUiolhrLoJHySZMoHzlBfD7NY/0APvn7SQrnrQ5ONC3RZpohzwvzC7yVnJZ2wON8B1UQeEbs1iMRCsJbGL2J0zQWGkhCJ4Dv1REyzqkpd+U/ffsQG5xD2YSKE8unoprhJd4Mj06m8E9wj+9sLzemv7wy1lfgCMq3m2woEP7147MXg2GF09vinHQ5co9RANx14QY/7X0KfLvyhDk0Op65L/fssQm9kqPnM3Um+eITDn7YNSRRUNtTmK7r1T0e5iBbzW5G0mfUFCOZ9Dzo/zQCt2tU4QaY3IsSMTGRrTPLWO714OZM1FwpStKP3iJ0978YCJW/HYEoTsMT6sbsGdww89wKZubQzJB0dCz81xSRqiBfJHhfi7qM8XTSS5hFnc22s9pqOLuJaBDxU2TqY2WYqP+DUN3jpmnHYC/9d+g9kLyQlonPRIBNauA0i+cVLcpICk4YFkKjD1JXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(2906002)(83380400001)(26005)(316002)(6666004)(38350700002)(956004)(508600001)(5660300002)(38100700002)(6486002)(4326008)(52116002)(2616005)(8936002)(36756003)(66476007)(7696005)(55236004)(1076003)(66946007)(86362001)(107886003)(6916009)(66556008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N1KupLMKZ4j5DBgFPLThi/yGLkdDdkEITHGjkN5FjMB13VNziPk5d/uGaIQ0?=
 =?us-ascii?Q?cBMN7LfqzVh5dILvZLSb/B2hYfalQGSweK62Y+wognua/5f2gECARvh2Uq6S?=
 =?us-ascii?Q?5jM8fadJwpn6jaGxx6NvcJzuy0th9QomheZ8ZFlR8pBOkWIdeaSh8wsMbCzo?=
 =?us-ascii?Q?+orRHmLwJ1Zm13jbUOdpP/+VjkxfUUgzru4zixN/ZoGdvXPH+W+kVqj0bzyo?=
 =?us-ascii?Q?vNpzbSWXSjXHzTJCCLTlAWBeHpHTfxrOGu9OzfDZvt7U30yqCldn+PzUofGj?=
 =?us-ascii?Q?vIPj1MJU7zeUZUZlc1v6BPOpMF/WAO5n0xDrmY2jpuvXo6p6vY+rRhHZA7Sm?=
 =?us-ascii?Q?inyymcWJ45Znp9a/uS8ULVH79SiVM/Tr1Lbv4ynyiudwKMlJnDi7xO7GSK8l?=
 =?us-ascii?Q?t0YXAK6WjIvnWt7YrwI0CW/jmv9E9IlDmUNSnmg74prz4GcuTlmGn1ue1/ey?=
 =?us-ascii?Q?uu6u4cn85VstCEt673riw8kVBgsjzXIURM3xOZqBLZ4pqWy9zgwlcX7VxaBB?=
 =?us-ascii?Q?V51L2qjYgusNJfme1UGnTrtnU42K2upzt31pe+yfl37yrmCpsrSlXDfzMJqh?=
 =?us-ascii?Q?njpY4I1RvS7sAy3d66TEBKhwzXBe1jljlo3YoHh2gQXH4nN/eCp8MeVR9roo?=
 =?us-ascii?Q?P1pUw78Jd1VDFe1YR6roaWJusYSn1GYD9hgeCayO4CTAQHMi06RHuM7hAgJN?=
 =?us-ascii?Q?fXgY+wAdGr3VxvaXDO/xVj/LflbCHnaFej/pGfkmZHqqJjRpDTNOVQMmWHhA?=
 =?us-ascii?Q?cUASs5XYCBu1xEtDqMZKxgG1jOwYJN/wUoRWlFdYSoBIEBHM0Pv0NfKq/Chi?=
 =?us-ascii?Q?rMupDlJv01c86/B2kT2wskXzoQjjshZNdm51FROg9wqjngk10sXQF7Jy+UFv?=
 =?us-ascii?Q?5ugGsSqs/2Nsv8LRNbesuPn2aCbaK0eIVA18HuskMrFIQmJ9ZR+szVYHMUjy?=
 =?us-ascii?Q?1shVHuak3IGJwLbAWykeJxiJZ6s9BQo2Foc6a/pJz9knKoAFDAENC8Zn1PN7?=
 =?us-ascii?Q?C0CiOYCACyWnUpG3beZ5xsvT3EylT9VXy6b+095mMB9vAc2UzfV10tOQ9rKc?=
 =?us-ascii?Q?0i9v4DYOnaDcTfLdwufvoTXid7PTw/pzfNt4NJN1ZA6v/JWrzFC3LMTKIzio?=
 =?us-ascii?Q?WQUTXmGU4BlCCMrNYkbuBlkkkAQ6lu5LUpoWJpZdDtky5Zz7iillK06mh/U2?=
 =?us-ascii?Q?yCbND856k3etgXq5a2Vg1mvIjD1VGDTAHQ5xFafXYM/kWe0iESbCyNlZ5aNX?=
 =?us-ascii?Q?vqbnSaC7N3r2Ah6DgijjBo7e9YqF7vs0Uh3ZpKqOvIztFjqph4n9ZFHNXeXo?=
 =?us-ascii?Q?EU27Fsb/eXAkRwO5g62O7cNBosOmep3opWDhQqzhoZZ4PkNpY1WJRQ4QmEp+?=
 =?us-ascii?Q?NWwoseSZl0H62jjFUiyN8P6Kaukzd6pVg6rynGge7i8POlJiWxkD8xDUpAtt?=
 =?us-ascii?Q?eDk03rG5IXG+vVULksXkq57fRi8kKq5VFZGB07G7hLKcEIZZ9jx5a8Ii84iB?=
 =?us-ascii?Q?ngvdjObyNzb2sgaWR7utPOmUAxlYfg542gBFFt6Lr8SDVKtwcl80mMZE6VuW?=
 =?us-ascii?Q?BHpcfaqznTDeQZhlmbJkkYouQngzjqVnsjbto8xLlh3sRDpZa74I5jEwyEmj?=
 =?us-ascii?Q?VQI12pM0wyJFAr6B9xbgvw0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 688dc137-a9e1-4ff3-a182-08d9bb500033
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 20:10:52.6766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IUPjjGZZtJ4/4lfE6vnXgRwmocM0eQPn8hne8wJRrI8luKYkYvBkQizsrUp9W/xoXMon7psGalBYH5ysQBNJpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3282
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 89 +++++++++++++++++--------------------------------------
 1 file changed, 28 insertions(+), 61 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 32f30e5f9a..b5d4fc1176 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # git-p4.py -- A tool for bidirectional operation between a Perforce depot and git.
 #
@@ -16,8 +16,8 @@
 # pylint: disable=too-many-branches,too-many-nested-blocks
 #
 import sys
-if sys.version_info.major < 3 and sys.version_info.minor < 7:
-    sys.stderr.write("git-p4: requires Python 2.7 or later.\n")
+if sys.version_info.major < 3 or (sys.version_info.major == 3 and sys.version_info.minor < 7):
+    sys.stderr.write("git-p4: requires Python 3.7 or later.\n")
     sys.exit(1)
 import os
 import optparse
@@ -36,16 +36,6 @@
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
@@ -173,35 +163,16 @@ def prompt(prompt_text):
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
@@ -285,8 +256,8 @@ def write_pipe(c, stdin, *k, **kw):
 
 def p4_write_pipe(c, stdin):
     real_cmd = p4_build_cmd(c)
-    if bytes is not str and isinstance(stdin, str):
-        stdin = encode_text_stream(stdin)
+    if isinstance(stdin, str):
+        stdin = stdin.encode()
     return write_pipe(real_cmd, stdin)
 
 def read_pipe_full(c, *k, **kw):
@@ -745,21 +716,18 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
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
@@ -3822,14 +3790,13 @@ def openStreams(self):
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

