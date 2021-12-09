Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3504EC433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 20:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhLIUOg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 15:14:36 -0500
Received: from mail-mw2nam10on2045.outbound.protection.outlook.com ([40.107.94.45]:56417
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231637AbhLIUOa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 15:14:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AursLabSDobqPcTVwhZCebHf0aVfH0hx2CIcAkEnesgcrvGx/umbwqgfjxznN+AsBI7QFq7LnoGaDHgwyBp69rkPcGVX9dCxsF7c/hZ44e5rYDJBebRgt/BlWeY1YJXg95Ls9n9H03YPiy2vvoMwsZTynSzc4tz5khGFdDSBEq3BIe2MTdq1Hpdw5LNm1bf/qEk/jSAucT+1IpwNh//lbQ/1Mh5JcnganLvvMAdQ3rglOrmPGg7zR9H3zfyisEFu3yGPGIch8lqFfOL0mGTyjJOLXHlC3Q5cyzVMERgeJ0OkVLHc6B5HJx3muaQcG9AKQ7dijjWwwS0qJ6bzhbiURA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gcFpi2ckyYb4wIDBTvZXUPbStNQFihn/bp/bTarIQbk=;
 b=AKA4+mTXr8N/1elYIv50iWUN1f/kzOXQXNuEikGGBwypUJ57+sriBcztUk1eiuTaW2Oc/ML/eZtWh59WEKyzQL+EDQvV8BXtJiFJJ1v180X9ajnKxKX8O4r77g4WPJg4SnN/55Y1dMxxqiUNGrs50IiQHs4+RQTrQXQSiQiO1OgQzQhoJ8liXKF83cLE9fgh1RISFHw8ggcZcOgZiHdHs6IkvVyCpsLK6Li3qEGRXMO2EMYH3fetSfDYRe14TBcqk7qoGrbnCRHfSd/9Ekr2SO3NAkBYWrMOVvyaW1mHivJMgeCN4PRiHGXuamPWm97zNFFmR9ePtjUVpPbc56woBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcFpi2ckyYb4wIDBTvZXUPbStNQFihn/bp/bTarIQbk=;
 b=G37nEXrk06SheoSQEMBIRNSIEOk5+PAhmoMqsXMrjHmiHzD5lG1Jl2APiBw6Iq5WGbK0oNdu8bHyboVEPKUlLQw+UUozV7bQ4oIvqacT+EIJtWOiDd7F9LNtEULIsQ1bKhRldKTAUQN4UJHSYqZB7DHznqb8c/FEKWgPvzp+IiuhisTMuaJsikym4nAZYtICbq8DjoKC9lqLcg5KLQWK+JgLtWn4wVGyVPWxjM7kZp3o/LRfE4oLv3nMcHTbpHWhxNw+uTCyfImHkikxa7/BQrQX6feCeuVQpPQxmLqt30usNHcDanCuZPKOK/r0rA0c7nG5LWjDFvq5B0OOuvF81g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN8PR12MB3282.namprd12.prod.outlook.com (2603:10b6:408:9e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 20:10:54 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4755.025; Thu, 9 Dec 2021
 20:10:54 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org
Cc:     Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH 5/6] git-p4: Eliminate decode_stream and encode_stream
Date:   Thu,  9 Dec 2021 20:10:28 +0000
Message-Id: <20211209201029.136886-6-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211209201029.136886-1-jholdsworth@nvidia.com>
References: <20211209201029.136886-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P195CA0012.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::17) To BN8PR12MB3361.namprd12.prod.outlook.com
 (2603:10b6:408:67::19)
MIME-Version: 1.0
Received: from red.nvidia.com (195.110.77.193) by AM9P195CA0012.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend Transport; Thu, 9 Dec 2021 20:10:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 042adeeb-f776-4bb6-cfd0-08d9bb500147
X-MS-TrafficTypeDiagnostic: BN8PR12MB3282:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB32823DB4C6543016D4D877A0C8709@BN8PR12MB3282.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:163;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m/q/PEW5dcqni359INo6prT058GAF68YQtMkXAbPp/50OFnBUYWooQEXkeGMb/qONZ+QbJ3WMsfG75sAXP+CE2XK4PZX53Ge+JRqt8IFxRgXod5NXB0DPprQDvqyKfFHwwzdZ1tleIzMQCJqsaUnW10vZKVmA1G+VlWg1x8jJCoBnDAygSu3Flpstg5MewBk1mpbdcdmOwEyZE2QH6YDJs/lcHOWPoiwnR+naR400FY8uqqd5GQTNvZ7BuTZ9vH7xzTkZ1kiD3yykE1unALeiBHAxJTsRyeYBicdY7M2Q/YRoMRht9ftP6SojXMc+KXEWIAAwTfHC99PPkaZDS3vw3TCROuM72MoX1e/vE7DC7FzdqkXtsjDYrpcdsn1/BNkM2SFay0CHi7H0Iah4UIfV2vnJGjaOStu8mUja6zTIqPA5JV8iyMPGa04RtveIiFEIU4uLrfhYcFr+htOs1FGJ4/SfH8VkwdptxGXVHe8NGXm3In3EpWr0D5v6ON/Tdh6AjhkQJE2YirgFfOL/uflujj1j7SbTJGcTZ2miNJh1DGZpkfElqsX0OmTc4fb9L2G+2sBeDcf7kKcaYNR6sXfeoO9xKKhv8K/J3ymhz/mM4qT4+3E8VOZ2euuIifEjg1+RNNeJ/m7B3LBRHUjo8AxU9zJhqfWy9thTxUUpFUBlBf4qrW/QzvgzYJb/B1lPnjoERO1BL2VFRzlb6t9MIIRqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(2906002)(83380400001)(26005)(316002)(6666004)(38350700002)(956004)(508600001)(5660300002)(38100700002)(6486002)(4326008)(52116002)(2616005)(8936002)(36756003)(66476007)(7696005)(55236004)(1076003)(66946007)(86362001)(107886003)(6916009)(66556008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HFwBFeAn4/B/sbyns6K0uIyvjrgdGUSKDT9mW/RODxdR94CxcwVl65xW5/re?=
 =?us-ascii?Q?8zlJ6gzSjYh+/lkolXXTyfW120nyr50JCnggcbr9Ksg0lpztLM3kAwgYrO2M?=
 =?us-ascii?Q?KZpBJFSLKaxH8J7ScWyTr83LSkmGzkqLm/nwknqFsc5cGD+Yciwhm2T0aBwT?=
 =?us-ascii?Q?DoH7scbeViOEBvqN4PMBJN0dvGNiMX8wFFFiY25XU21aDPhgJO7S9g/vNuuo?=
 =?us-ascii?Q?Q9pSBM5Vq01T1udEZruIWZ/XRNjKBrWmccVFgGHzeMnr3vVHzg4899A+SGv3?=
 =?us-ascii?Q?3XiYI2etS57VFwGyjYtkfqOP6q7nUZMofCv33s4rIk57+1aMdeAiAe5gLPnX?=
 =?us-ascii?Q?JzZU7WUK5ueGTlB/peNn/pDoqp1OWKH4K2k7hvPR9k6gJdj0Qfi6vU78pFbf?=
 =?us-ascii?Q?oGmCe4dyyMyNKpnM71mJNicLUDsQCcT7O+5FrjKl03kI2RMj2AH2PWJIg9tC?=
 =?us-ascii?Q?2fRXUAAfvmrs05Dwc1gWi8clvcOtAMnP7bAzgRxjGF2Kvoos1qeOVSjG6UDC?=
 =?us-ascii?Q?71MmM7Q/aRa1yENx21fO6mQTuASUOy0A3Pvm+VNOiTyGbVbs/l6D6+FyLMcN?=
 =?us-ascii?Q?5VpdI2TwcRh7nUFfkIWZ3R19YdD7j+41YS0X9kTz7HSOiBCAFBFXK2JP5bdZ?=
 =?us-ascii?Q?fwKb3R8V0tTICp1Bw8vwKAo3HTuLFHBzDVYfkDij4nx02F2FvodoDb8gWj7H?=
 =?us-ascii?Q?VRDav6DTu57uVzmIgJlLWph7GUDdy5W6GqskH2t/CVZ5bObtBFYLGQ2l4B6O?=
 =?us-ascii?Q?y57BKDif8FVbOFBdAcXqgnTIJSV+iUvIkxlT1YDYew4ASbs7fjRzTt8EYOhN?=
 =?us-ascii?Q?lv4wCbJ2WMa0Rww+1e+eb5bsb4GN1x6NWxTBCvCZ67m7lcYwKIeIyT+1XqIz?=
 =?us-ascii?Q?OwmrvpyFaRNgz6GGi0hEt+QqqDUKAvLGbzU+vCGDQOlZ563V1SnEuSbnpxN1?=
 =?us-ascii?Q?uUNfqqEqdQ2t8N0UdtMKEU5hBiRrBE4z+JkvDmH4B29ASM8KWlXgVnWBE5Ye?=
 =?us-ascii?Q?bdUlzrh3JgY4pCmX4Z0ZcyfEhuoSlHMwHXveE9h1xOwapCn5hj99PRbTfCHN?=
 =?us-ascii?Q?QEnFYXa3bXXsJyVIRwuDaSLrcmF4tcqrRM9NUoJXXh2qHiJz/lDmRkDi1Psh?=
 =?us-ascii?Q?16ygNKp7DqdZvQ8Mht+/ItY4fAMgsQpW98lL8nr8ybZPAh71+b8CMkl4M9Rw?=
 =?us-ascii?Q?Ub/SgIDFaF3LK7oVQGxNAGIaG2RZg+TWVqdR2URHwOGS1LXcLT0ADBftIDT6?=
 =?us-ascii?Q?EqGjocGkzvuaFnG35lbGpYcE39fe9NmZ3nyIG1E3k9qaNpRXgq0GhUXtbDGA?=
 =?us-ascii?Q?LljQPmBcLoEvZM9mpK0o9vqbPqMi28Hhmhz2gnKawN7vAhDIke/h9S5bR8VB?=
 =?us-ascii?Q?grUzsiBKCAiDgNuMc8nW9tF8qeg8jqAY7kWarB8/dfxne0uxfkRJKcIqnsUy?=
 =?us-ascii?Q?NZWohBvfTmKZ+ada5hbqAWgjldgmszwfwFlMIsHy8Hv9nDwf8gzu76zsUg/F?=
 =?us-ascii?Q?IHs9ueTBl26KrdepvxjXwO6XNYUsv3lkDZTpk+a3n4tBPFHWN/C0yrspJ7c9?=
 =?us-ascii?Q?GhZ7oiw2+WI2CPUn/ChGpJLsXx8KjhyxG7XWWuq9E0+Uo/eYbooArOTT5Tu3?=
 =?us-ascii?Q?yHQWXfpBkokCf+s0u/BctGM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 042adeeb-f776-4bb6-cfd0-08d9bb500147
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 20:10:54.4756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /k93Y2BhAcaXu3djVY5Irq7jX3/aLNsuEkxkA2KUnolst6zhvezUosTbNf9q6cBHEaGKMAeZRdph3Y7mSMp61w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3282
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 50 ++++++++++++++++++++------------------------------
 1 file changed, 20 insertions(+), 30 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index b5945a0306..c362a5fa38 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -163,11 +163,6 @@ def prompt(prompt_text):
         if response in choices:
             return response
 
-def decode_text_stream(s):
-    return s.decode() if isinstance(s, bytes) else s
-def encode_text_stream(s):
-    return s.encode() if isinstance(s, str) else s
-
 def decode_path(path):
     """Decode a given string (bytes or otherwise) using configured path encoding options
     """
@@ -271,7 +266,7 @@ def read_pipe_full(c, *k, **kw):
     p = subprocess.Popen(
         c, stdout=subprocess.PIPE, stderr=subprocess.PIPE, *k, **kw)
     (out, err) = p.communicate()
-    return (p.returncode, out, decode_text_stream(err))
+    return (p.returncode, out, err.decode())
 
 def read_pipe(c, ignore_error=False, raw=False):
     """ Read output from  command. Returns the output text on
@@ -283,22 +278,17 @@ def read_pipe(c, ignore_error=False, raw=False):
     (retcode, out, err) = read_pipe_full(c)
     if retcode != 0:
         if ignore_error:
-            out = ""
+            out = b""
         else:
             die('Command failed: {}\nError: {}'.format(' '.join(c), err))
-    if not raw:
-        out = decode_text_stream(out)
-    return out
+    return out if raw else out.decode()
 
 def read_pipe_text(c):
     """ Read output from a command with trailing whitespace stripped.
         On error, returns None.
     """
     (retcode, out, err) = read_pipe_full(c)
-    if retcode != 0:
-        return None
-    else:
-        return decode_text_stream(out).rstrip()
+    return out.decode().rstrip() if retcode == 0 else None
 
 def p4_read_pipe(c, ignore_error=False, raw=False):
     real_cmd = p4_build_cmd(c)
@@ -310,7 +300,7 @@ def read_pipe_lines(c, *k, **kw):
 
     p = subprocess.Popen(c, stdout=subprocess.PIPE, *k, **kw)
     pipe = p.stdout
-    val = [decode_text_stream(line) for line in pipe.readlines()]
+    val = [line.decode() for line in pipe.readlines()]
     if pipe.close() or p.wait():
         die('Command failed: {}'.format(' '.join(c)))
     return val
@@ -340,7 +330,7 @@ def p4_has_move_command():
     cmd = p4_build_cmd(["move", "-k", "@from", "@to"])
     p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
     (out, err) = p.communicate()
-    err = decode_text_stream(err)
+    err = err.decode()
     # return code will be 1 in either case
     if err.find("Invalid option") >= 0:
         return False
@@ -704,7 +694,7 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
     if stdin is not None:
         stdin_file = tempfile.TemporaryFile(prefix='p4-stdin', mode=stdin_mode)
         for i in stdin:
-            stdin_file.write(encode_text_stream(i))
+            stdin_file.write(i.encode())
             stdin_file.write(b'\n')
         stdin_file.flush()
         stdin_file.seek(0)
@@ -945,8 +935,7 @@ def branch_exists(branch):
 
     cmd = [ "git", "rev-parse", "--symbolic", "--verify", branch ]
     p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
-    out, _ = p.communicate()
-    out = decode_text_stream(out)
+    out = p.communicate()[0].decode()
     if p.returncode:
         return False
     # expect exactly one line of output: the branch name
@@ -1331,7 +1320,7 @@ def generatePointer(self, contentFile):
             ['git', 'lfs', 'pointer', '--file=' + contentFile],
             stdout=subprocess.PIPE
         )
-        pointerFile = decode_text_stream(pointerProcess.stdout.read())
+        pointerFile = pointerProcess.stdout.read().decode()
         if pointerProcess.wait():
             os.remove(contentFile)
             die('git-lfs pointer command failed. Did you install the extension?')
@@ -2130,7 +2119,7 @@ def applyCommit(self, id):
         tmpFile = os.fdopen(handle, "w+b")
         if self.isWindows:
             submitTemplate = submitTemplate.replace("\n", "\r\n")
-        tmpFile.write(encode_text_stream(submitTemplate))
+        tmpFile.write(submitTemplate.encode())
         tmpFile.close()
 
         submitted = False
@@ -2186,8 +2175,8 @@ def applyCommit(self, id):
                         return False
 
                 # read the edited message and submit
-                tmpFile = open(fileName, "rb")
-                message = decode_text_stream(tmpFile.read())
+                with open(fileName, "r") as tmpFile:
+                    message = tmpFile.read()
                 tmpFile.close()
                 if self.isWindows:
                     message = message.replace("\r\n", "\n")
@@ -2887,7 +2876,7 @@ def splitFilesIntoBranches(self, commit):
         return branches
 
     def writeToGitStream(self, gitMode, relPath, contents):
-        self.gitStream.write(encode_text_stream(u'M {} inline {}\n'.format(gitMode, relPath)))
+        self.gitStream.write('M {} inline {}\n'.format(gitMode, relPath))
         self.gitStream.write('data %d\n' % sum(len(d) for d in contents))
         for d in contents:
             self.gitStream.write(d)
@@ -2930,7 +2919,7 @@ def streamOneP4File(self, file, contents):
             git_mode = "120000"
             # p4 print on a symlink sometimes contains "target\n";
             # if it does, remove the newline
-            data = ''.join(decode_text_stream(c) for c in contents)
+            data = ''.join(c.decode() for c in contents)
             if not data:
                 # Some version of p4 allowed creating a symlink that pointed
                 # to nothing.  This causes p4 errors when checking out such
@@ -2984,9 +2973,9 @@ def streamOneP4File(self, file, contents):
         pattern = p4_keywords_regexp_for_type(type_base, type_mods)
         if pattern:
             regexp = re.compile(pattern, re.VERBOSE)
-            text = ''.join(decode_text_stream(c) for c in contents)
+            text = ''.join(c.decode() for c in contents)
             text = regexp.sub(r'$\1$', text)
-            contents = [ encode_text_stream(text) ]
+            contents = [text.encode()]
 
         if self.largeFileSystem:
             (git_mode, contents) = self.largeFileSystem.processContent(git_mode, relPath, contents)
@@ -2998,7 +2987,7 @@ def streamOneP4Deletion(self, file):
         if verbose:
             sys.stdout.write("delete %s\n" % relPath)
             sys.stdout.flush()
-        self.gitStream.write(encode_text_stream(u'D {}\n'.format(relPath)))
+        self.gitStream.write('D {}\n'.format(relPath))
 
         if self.largeFileSystem and self.largeFileSystem.isLargeFile(relPath):
             self.largeFileSystem.removeLargeFile(relPath)
@@ -3096,12 +3085,13 @@ def streamP4FilesCbSelf(entry):
 
             fileArgs = []
             for f in filesToRead:
+                fileArg = f['path'].decode()
                 if 'shelved_cl' in f:
                     # Handle shelved CLs using the "p4 print file@=N" syntax to print
                     # the contents
-                    fileArg = f['path'] + encode_text_stream('@={}'.format(f['shelved_cl']))
+                    fileArg += '@={}'.format(f['shelved_cl'])
                 else:
-                    fileArg = f['path'] + encode_text_stream('#{}'.format(f['rev']))
+                    fileArg += '#{}'.format(f['rev'])
 
                 fileArgs.append(fileArg)
 
-- 
2.33.0

