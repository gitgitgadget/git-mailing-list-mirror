Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A965C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 20:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbhLIUO2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 15:14:28 -0500
Received: from mail-mw2nam10on2076.outbound.protection.outlook.com ([40.107.94.76]:37985
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230396AbhLIUO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 15:14:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ybu7cL8iFND3l/OdjkYEJn/wj94YilrurrnxL+2+8TVSXZl1YyPBxv/BfDr4NFH1lM2OG0VxxIbD8EHoBkHJhdyW52/vo70wmFv9LQh3DBMToCBKnWVdfcJcESQ+/D22PvuRj5JEvGFY2aaWtXc/LnsxA4XQU4wjbhQbDfBkcrFRyIv7gYF7FbalaqSjfx8fqyFqEPXyhdeHzKG+Go9Sno70pjovuRVLxyjj7HdBECMTUvsq+75Euv5XpzrWt1LGfe9TR4zUy+RDHVzmHZK5WLj6aRWUj0s57uM68O02xStp+yvvgu2TfKT8+KqY+gZr/iusHesBKhZry88PlWmcig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgUuzFzPDdMJpYsvlpIkr2q3EcLcJhsEvD2FQddP4Ds=;
 b=W8bt36fMqbYpDw34j4D4asSPUjkGeXY0ZWSYjloc029ZOdVZMlM0x9G8Z4FwynsMOplr5zF5dNL1xC18Y9ILrHieVmpUREJ7w7O4pbTuhamPCFBqRjBIxasdIYTVMtpp9nNokMFdcmApqxEiAanmoNVXdGMRmXhi2gP2eDyz8hIQwkpwvKvSxeWZQTsskMQXuorBbAvvmofY/RZot/Mdovvm97xGZMljcMQ5qyAiHSh5cGyTKnn05K0U85QxguHOjYZOYJuWxzTyNCG4qB4QzgzM78vZtQqCSFCP7GtiW+Hg1+hH1Rp/LVwoDfmCaLF+7JWu81fa4dtLyOavqtKUKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgUuzFzPDdMJpYsvlpIkr2q3EcLcJhsEvD2FQddP4Ds=;
 b=NoA9bdIKhMyWJnvGFgvCV7DraOYqzdGkTCB5S2FIwEaF+hWgjB9wVQRfMNU2MxzVi5CBX4w+Jvujkfu2PpBiVAXy3hPfPoM5epsjLL7PRJdTzsH7qrWf2Uv6zpLJS0L9mOVIFefJ+EScvbJht/Y7FOMojMgQ6A3rKl9xXU/b0Xg0auEh7DCMTXQKJhwDhGcfk8HkM9A4skQisL0aQTmQ0av/I5+tWGNweSCmX51tv7t0UImk/DmDnVWMO3x2kNfmX9lkh8QyCLUCqrBaBSoLIPQwhsmRGXhELwsaEoSih0oErvgRHWrDaKcwDqDx/9Q7OhBi0Hh2QIJ0aObpaZZJ3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN8PR12MB3282.namprd12.prod.outlook.com (2603:10b6:408:9e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 20:10:51 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4755.025; Thu, 9 Dec 2021
 20:10:51 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org
Cc:     Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH 2/6] git-p4: Don't print shell commands as python lists
Date:   Thu,  9 Dec 2021 20:10:25 +0000
Message-Id: <20211209201029.136886-3-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211209201029.136886-1-jholdsworth@nvidia.com>
References: <20211209201029.136886-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P195CA0012.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::17) To BN8PR12MB3361.namprd12.prod.outlook.com
 (2603:10b6:408:67::19)
MIME-Version: 1.0
Received: from red.nvidia.com (195.110.77.193) by AM9P195CA0012.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend Transport; Thu, 9 Dec 2021 20:10:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 948b2981-6faa-47f0-f8c4-08d9bb4fffac
X-MS-TrafficTypeDiagnostic: BN8PR12MB3282:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB32829979F7D26A0FD1E81D7AC8709@BN8PR12MB3282.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:298;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ybwepEn43zzFUXPZq5e7RLIhQbPkATKTBx59JGNuuFbsFaSatKbTH43LDKGoGuCvdlib/5W3Xy96cNknU9fT1vWkvXxS6aaz5Sk//mucnaqJxzYdvkVwgYSpWfkz4hbXnk4xmHkLQ9n0rPdFqBP55cN1hr22xpqxxbJqQ87IXtGgOnvvaLP/9uOrHcJwvm3qHYGKY8bS6sD4OQMsvMN1thLmfQqFKeYOav967etwUikR6fNa/UL7TCFNhE7+tMZE59V9OBSipNqjlHY7A0kaRFYsfWNXtsPFknpt8Uq5bJM0zBgLvpmK78mgX9ku4sZ/TZ0gnabw75Wi1A4dZ/pt+z5Uzh+mpv2thw5FLYFHm2YMJotizGBB4M52WnAoRkkhdmXB1dbWNecv/8RLL/NpZY6Z/Um5t/H6t7y7NENNplcpopEtCYi+R6DdOMWbW/6IBaco3xIaeZf/x1tkXCBwkdNfMhf8ocq0XE2GXDCq4haC6aN1AsvxC6t1BpsF0zc+1OrbTM/3uTdPy/48X+jKjjZWqveZ+Rk+4QLAjNa+oiGAsOK/h4q4oafr6V080IV5mjP6JSFr1U4X/HSoyIXP/fi1NoIzZjQDJFiPmsI/hhCyNXAJA2m7R5ZYgLrz4Vs7ZBzeMbax3vowm63SXb761XOBUH6Vo/lrHP/1P+3V0u15diia3pGd45IKm8OAKUrRF+0hghWT5w05+vjfSDy7oA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(2906002)(83380400001)(26005)(316002)(6666004)(38350700002)(956004)(508600001)(5660300002)(38100700002)(6486002)(4326008)(52116002)(2616005)(8936002)(36756003)(66476007)(7696005)(55236004)(1076003)(66946007)(86362001)(107886003)(6916009)(66556008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xxOZL7rRhGimd+kBTRcxodUcPyBXlFHiOGS/uxmj9n4piIYg4all+kXI5iGj?=
 =?us-ascii?Q?s0GE0mPadjuP9ZiovEtLBbmfpU31WM9TLX1PQVU+3zNq5rGtkAoNWw77tR73?=
 =?us-ascii?Q?5ntyFynQsBlsuQT1JL+/ldC1uWQdPdeILS8EQtvHYAGXAgLM9ZHzRu+P6J+e?=
 =?us-ascii?Q?e+lVRmwD9KGBXwsASfAlf2pBZIqbQ/Sw32JLv5FbjWotzlr7wz0DezzyAJs7?=
 =?us-ascii?Q?j1gRPgXihmHxrCcjPDZKeetGZByw3W16D086RZzIPbMvYuH4aDcb28SynRG9?=
 =?us-ascii?Q?tgnpius7TW/wqT+qBKiw+Cj2yU7mvitRn8HoXSuADtV7QHQFGGwPovsctUg7?=
 =?us-ascii?Q?oIDBAA37a4/zasw8hogLxZj53QHmVUc2ddYld6P4cfQBQ9bUk6jJ/YIvWNKJ?=
 =?us-ascii?Q?UYYOMqQk3azbhRXJLmJeE4bc5Mopb8jSoJ5FwQf6oIHPUgcrO6FlDNXebIJK?=
 =?us-ascii?Q?u6d9PtFTNrIlgLpgDraXcEP/FS5BQoC+fZTHI3u60xtUuCvf09zwLW6kGK0i?=
 =?us-ascii?Q?t1wIVPCzl75+Suv7oYS5vZFg+Qof1tWdUmtOIWDyN3fbEGCvKorMjMG45QnD?=
 =?us-ascii?Q?y8Aw4/CryNC1Weci5fpZOBy2bEPvtCBBsbudCZEky9WM5QGOBHytmDowx5lb?=
 =?us-ascii?Q?HGL6XCdEeSG5XbW4ulnEGT0BY6/LD+JlMLew5i6sGpPg5JArvVy6j2UXqM0J?=
 =?us-ascii?Q?uQeMH6zIpy29SiQp/4eNlC8aq4PMIYhj1S3ED882h9sQqOpihdomhkjDFlmH?=
 =?us-ascii?Q?+jwhgEyuIbfAFhGwwWMXYxJR2hA4cBBd8APGFxgcQ5EuWt5b1nq32iu7Qt0S?=
 =?us-ascii?Q?4t2OJuMINcVk2PoVBPq69CyI3v4TQ6lISUih8TNzEORrPm5hLSYtGR6Pr/oF?=
 =?us-ascii?Q?90WU+abyQXIMPsVDQOJo5I1lSCB9+u+jCmKn6agDEJTdOCmKRUZTusXMAyef?=
 =?us-ascii?Q?NLfPcxeXGamgtbce5+dtthQdjedP/jul5QyAPdFx0pUejL4nUtCXnEbwSP6R?=
 =?us-ascii?Q?mH7UJUcldXCQc39+QxAoc4+AHxOwYU9FKpRj/11FJu8Gn/rUMu9/98azGyhA?=
 =?us-ascii?Q?yShMZKYWZnEYZu+B1kgmWwqFV5YR/4dQWPplPb0yvHUnrM2+DUC3OyQeYyaG?=
 =?us-ascii?Q?pioTnHTzjErdsEyud0Hasm2L06+u8RcKHSPHFEe54vOFNMrq+KmurvbFczPK?=
 =?us-ascii?Q?nvOp+/j6/V2xfz3Ko/9ZBZ5ACrlUK7e8QoSgQeR864UXxrkmce1Vneh7v4EE?=
 =?us-ascii?Q?A72gxUKB/WCkCggU+DnvzwL+32nKYW31C4BFNd26jC5z1Zit4pvRuHTXGiOA?=
 =?us-ascii?Q?5odwTCkIVJcW6VK6k0Y4xg0+VMgtwjFpXEL4RKbNq1OGMLNxC29iOwFfwFVX?=
 =?us-ascii?Q?9H2w3cC2dWtfkJ9Fk0FqpkV8EpF0VJnsPkhi1y2xj25XYUYUT6pi6OVAht5q?=
 =?us-ascii?Q?vJdh5NQeUft6uDkVReB1EoGQh2Glhe10DnCU724pk9JXqtfUsdMxLW48HbnL?=
 =?us-ascii?Q?kV/I3WKAV/7MahMzNNV/dd9TLQ9GUWDBOa3jWLJGJ5ncuxHB+BTfYpPBF5wg?=
 =?us-ascii?Q?woomHlpEZeapjiR/voP5nW66IStu0enWev8qPeUDj7SF0oOXEgGqv4Oj3K85?=
 =?us-ascii?Q?fWp3cwEBw/Pe25XIaUymQLs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 948b2981-6faa-47f0-f8c4-08d9bb4fffac
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 20:10:51.7811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R0KWVpIK/AFrda7YmtrISIYA1jMP8BKf306YdJQFYcnkzJrP74OpbfG5rK+Eg1To0fBCxZZTUCJq3EGabEo1GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3282
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 1a4b7331d2..32f30e5f9a 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -272,14 +272,14 @@ def run_hook_command(cmd, param):
 
 def write_pipe(c, stdin, *k, **kw):
     if verbose:
-        sys.stderr.write('Writing pipe: %s\n' % str(c))
+        sys.stderr.write('Writing pipe: {}\n'.format(' '.join(c)))
 
     p = subprocess.Popen(c, stdin=subprocess.PIPE, *k, **kw)
     pipe = p.stdin
     val = pipe.write(stdin)
     pipe.close()
     if p.wait():
-        die('Command failed: %s' % str(c))
+        die('Command failed: {}'.format(' '.join(c)))
 
     return val
 
@@ -295,7 +295,7 @@ def read_pipe_full(c, *k, **kw):
         text.
     """
     if verbose:
-        sys.stderr.write('Reading pipe: %s\n' % str(c))
+        sys.stderr.write('Reading pipe: {}\n'.format(' '.join(c)))
 
     p = subprocess.Popen(
         c, stdout=subprocess.PIPE, stderr=subprocess.PIPE, *k, **kw)
@@ -314,7 +314,7 @@ def read_pipe(c, ignore_error=False, raw=False):
         if ignore_error:
             out = ""
         else:
-            die('Command failed: %s\nError: %s' % (str(c), err))
+            die('Command failed: {}\nError: {}'.format(' '.join(c), err))
     if not raw:
         out = decode_text_stream(out)
     return out
@@ -335,13 +335,13 @@ def p4_read_pipe(c, ignore_error=False, raw=False):
 
 def read_pipe_lines(c, *k, **kw):
     if verbose:
-        sys.stderr.write('Reading pipe: %s\n' % str(c))
+        sys.stderr.write('Reading pipe: {}\n'.format(' '.join(c)))
 
     p = subprocess.Popen(c, stdout=subprocess.PIPE, *k, **kw)
     pipe = p.stdout
     val = [decode_text_stream(line) for line in pipe.readlines()]
     if pipe.close() or p.wait():
-        die('Command failed: %s' % str(c))
+        die('Command failed: {}'.format(' '.join(c)))
     return val
 
 def p4_read_pipe_lines(c):
@@ -380,7 +380,8 @@ def p4_has_move_command():
 
 def system(cmd, ignore_error=False, *k, **kw):
     if verbose:
-        sys.stderr.write("executing %s\n" % str(cmd))
+        sys.stderr.write("executing {}\n".format(
+            ' '.join(cmd) if isinstance(cmd, list) else cmd))
     retcode = subprocess.call(cmd, *k, **kw)
     if retcode and not ignore_error:
         raise CalledProcessError(retcode, cmd)
@@ -723,7 +724,7 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
 
     cmd = p4_build_cmd(["-G"] + cmd)
     if verbose:
-        sys.stderr.write("Opening pipe: %s\n" % str(cmd))
+        sys.stderr.write("Opening pipe: {}\n".format(' '.join(cmd)))
 
     # Use a temporary file to avoid deadlocks without
     # subprocess.communicate(), which would put another copy
-- 
2.33.0

