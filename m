Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9525C433EF
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 21:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244338AbiAFVlK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 16:41:10 -0500
Received: from mail-bn8nam12on2066.outbound.protection.outlook.com ([40.107.237.66]:4961
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244184AbiAFVlF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 16:41:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mU1uHB09uRhhhEziVO48qlAagW4uz3inbdJvzeHxeOTOERGRodu1JFKp+uK3X2PNDFSqB6bnxnPe6I1ZSruG+DRZmlqdZFraww/rD6RkTDHpzCKPOBzhg7MXxLjuQ3YTXM5n5XxiMImyAjII8KCD6Fq9zjMtxkDvRyl/z55RRGixitQ4Tu5AuIa0QGBk7/A7Vdk/+oo2jE26uPHEupqY9zDgtZOui55PioK+GEpmoFrsqfvP4IOcFlyU1wXSNSXPwtMt97peG6EH6RoGDkd/vpgoKXi5NL1V2AZgVUuTYUwlU51i5/3AX//BlfgWhSF8g1MLgtsi9Wh0LtXpT6SyEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEhenfocq+zuQEaWBFZ05uLkfKy/efnxBvZbC4t7h9c=;
 b=bfgPFsHKDxIlHBoaE0cbmnAR1tgWlRJus3Aw6lDzkTt1B+HtvYyxmyr+UlDenf/zrD8KCVB1wK35rFhetihXjnrIQi7/L5172Q2x2ta8chLrzQIRn5T5S/nrwlI95VwRqCuf7IvIvtwhwYnd2JKadm5lGyWhnrq30V7t85xXSMNPOQBPt+RVqxx4q5gUbq1IkV5Tu8OEljcroBG5zxiqWgjo8kwZGYL9EcKY2V5n2HDDUQwGSNX4Ye38ZURjTPMaLQtSqgifOTg3U3GYIjq2Bdeve9j98dMjxqcrXEsf+APirzmBxRkcpUC9De5eob/Bl5a7B5Za2F7xHkPvz+LCyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEhenfocq+zuQEaWBFZ05uLkfKy/efnxBvZbC4t7h9c=;
 b=PqBXtXPw5iK0s908gTrLGoVUa+Mh+hZ8HcrjupgNXWGuj6w6rcdSrTfLy//Gp9dtvkyXD5LOJQJcKZa3TSAs6WJhPVKhtBgFKTvLsFpxcD/GwimrDa3ntwwqrOqAbrBKWJ89HQ83jJUctVI34sfWX2Y5ajlu1cUdRr5CWbWVL+FtaeDSa2tGe18ia832YH060DbkDwKcP5KJNyL9PNR+mlve+PwQTt0VxrX65LXLzeQyF5QFgnumhXvKzxN4kG2QmNA+p7Y+2Qic5l53fs7UVRi/lEv2iLSM9n5mF+7qT9bK7lFMPs5RTGOap/lt7u/yv1bIGJWjGzAZk6CL4k6Baw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by MN2PR12MB3854.namprd12.prod.outlook.com (2603:10b6:208:16a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10; Thu, 6 Jan
 2022 21:41:04 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 21:41:04 +0000
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
Subject: [PATCH v2 3/3] git-p4: don't print shell commands as python lists
Date:   Thu,  6 Jan 2022 21:40:35 +0000
Message-Id: <20220106214035.90725-4-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220106214035.90725-1-jholdsworth@nvidia.com>
References: <20220106214035.90725-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0030.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::35) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a4fbb28-d1cb-4a68-2687-08d9d15d3d74
X-MS-TrafficTypeDiagnostic: MN2PR12MB3854:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB385468A12765817B849E5B9EC84C9@MN2PR12MB3854.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wQCimdJbfNSyGo4OlxIZoCsmFbI69N+rRW9rUNDyIz5LW22hSnemkJgSanfaeMzX4eVeVPLpP1koBAPEpJT/SXcloOaQHuwqS+rt0QX9KPu4HybpshVYSNelPW71p/+yLYOuvcPs3qnD4bxbqtoZchRum7b+as85PTdPxO1ItUDjeS+vzz6PwHZqSpx3v7k7YUA1Vt/noQN1VbJgibmqXBnFYGBf2RLNDm52UHLk3i3DtRUl48ovxiwYjXsW3vdAxPR3GVxtmrGipTL/+1BZamnn/qBS41sc+dy7Zi9zFSWBBdi0dM8tgOt8Faddis5kUcFfY78TOxIwCb+/H4dg2Vax5YrhxPT4+ooNXnYdpiVlhw6xMEoB1Vg9BgmNglefEwniGlWMwfPRQCWkKjjrsFngfzBzYFealYNahZMNDmOoAiFXppm2pE5Ixi9aWgSmgpUB6AFt9+L/7kr5uQ3URVveSSr9TvJTpNmZ65uVdWTzE+feAtSUvI89kLJdYzQwdNYLTWW98eWJFTMFvbxkgfnjSECuuiYxdgR805DOFvANRXF/QRQIRbUcSO4nGcPvO53978p5fR+4m2ssmWJ5bmm/I48SZoJbBB+F7VAFq7bVurDDm2iV00CcI5XbD7E6Tw7MN3z71NmOTUV9//cLuewjd6xGw1ggFQPl3j4xfnkCHNpIDNUZ0W4rBplX0g/pt8yA9271O36ExQW53xD+iQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(508600001)(26005)(66556008)(66476007)(83380400001)(186003)(4326008)(38350700002)(8936002)(66946007)(8676002)(36756003)(2616005)(7416002)(54906003)(6512007)(6666004)(107886003)(52116002)(2906002)(6486002)(316002)(5660300002)(6506007)(110136005)(1076003)(55236004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZNAGhwOfRPpXsFpqTO49yyqaTwvfkegL8IKFex4wmSIYtECjjh4Qh38qvXew?=
 =?us-ascii?Q?1tno8uwFeg90HQFiZ2JQVqfFXr+XfCNtRbgQSx9l0T27oBn1Gda+NGWtkhfM?=
 =?us-ascii?Q?Q/jrCfyNb5JGDOEiAa/pRcBS/sK7RMd3L5hz2vkoTNm5GxYFvYBhA1aaXGHa?=
 =?us-ascii?Q?xnhb5L7iZmlvf7TO9JDNHtTioomKaFIEarpLSAtuKI7+ojlfKIpXUVO0rgiW?=
 =?us-ascii?Q?ZKVsGuNO1FgBHPEoZBnGEdYrh0HZpOhnChQbbntG8cYIeRrvnLN2CLM27/wq?=
 =?us-ascii?Q?Vkox0Fsc2n0sZOT8fty2u5G4XypWGu+1HCz529x7/QM9/CSuc264Rx8h8ANh?=
 =?us-ascii?Q?iZATKvN5wjU/ee5wFpOQPaFE30hRBz/KK0jmC/c79csZzKG3ETDEfCuzTiwq?=
 =?us-ascii?Q?thufu+QBm8MdGqdQ5f2yGd3q2zDyC9bn+TidrBEWduGEmjH/yPIo2YNbXyka?=
 =?us-ascii?Q?e0KZ7wq0qAXe5U3h+wGvofgDi5SH861gebbHvyut0VnrtnAwnB5n5OM2FQhZ?=
 =?us-ascii?Q?PeQ8YhaLpZJR9PYwyE2Lvc5cfttEdKDHWelIH7gJPocthvvZC9HhDJwiZAOc?=
 =?us-ascii?Q?4CHOED9Q8205P9EWjAgKAJ/EB4VOmAMhQBssx+IXG/OrIw/DuU7qb5Y4mHgs?=
 =?us-ascii?Q?bfe5yu+3TGEcLl0bn7Q2v/MnMaMm0I5fz9zWz/PtkHg9+uWuF1NFQCKyShJg?=
 =?us-ascii?Q?8pMEQqlizZhTb7OJBuwOJIfGdSumgHem/irJxGaimyeP2JgPjWYUwiH2k93k?=
 =?us-ascii?Q?CpEZws1YGf0LcQO5p3OAE2exH9oqKVZ2gfZe2wGSj3zyNBZwXIabTIhKUmcA?=
 =?us-ascii?Q?VE+6xWZvgDv5t9X69Umz91xSz0AAjTcCj2fHK4CIMIj6RuJXTpTVxUo9FIy4?=
 =?us-ascii?Q?+zcMuowOXDKRAeRRt6MdJuKrxZRDdcjy7Auv7gee+PGhTqRKF/IiXk2pDMbI?=
 =?us-ascii?Q?rlGQfaDIsWVc32tu4N3sHwTb6cFqfmrx/mwKDX+ZQ8skiMinDHh/9CB2lacm?=
 =?us-ascii?Q?6MGLNxoQ7sa6x7eWhV6GNRMJKLoteJb8dUPe0JiygaqbNOc0tIKnVFCJQ1jA?=
 =?us-ascii?Q?alm4ElWzQ4DEu8afMLbPF9Zl1l6KvbA/M5YREM8H9reD56nQGlFvcPlAxDMd?=
 =?us-ascii?Q?+6yEm0eJ81xrssfABiez3cZJDFa5/QC5JrEJaTlCelkUyzhirkmPFdOsy6W3?=
 =?us-ascii?Q?sk5FBdJDI/SzUx/R2xYLAAPKu3/wwsqdsIkScOi2cSyzUGdmB8oHU7950nGn?=
 =?us-ascii?Q?JK9+jbihhZKaWzPcpzLnFdNak9CUDUbE6fnX2N1syO/Lwa+SkLz1ITayL3Be?=
 =?us-ascii?Q?CCPs50Dx3x0U4a8UwMMgvsmDbsQi0uHOfWhKbYSowiIFXe602hTK942wQEZ0?=
 =?us-ascii?Q?JdzR7AG+XAavfvUnObVrMZbX5vIsfPliPN43mBWK4xrCtjTnt4kivm8GhoGz?=
 =?us-ascii?Q?n7wvKg70uPW59ZNg//r63ob1KjTqrCks6twtxyDLe4/UijuxGEdAO3A832aQ?=
 =?us-ascii?Q?FggBdtwN/2zLI+67PQuK4RzXXjwFkBq5QcZUoW97qKHfT9aMKSkd7vxaHkCf?=
 =?us-ascii?Q?70564zPyVRXjMmBCUXztAflQUyhxtSIQx1xBXkxoN47s8dffF2R1mEQ/swFh?=
 =?us-ascii?Q?NteYEMNujdDTYvP4DkUnaD8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a4fbb28-d1cb-4a68-2687-08d9d15d3d74
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 21:41:04.4866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nkxu/NgxBcLzNG8MLefwek+BoJY+DElHo5Px5jKJ0xnfFCnJUFmcdJ0/wMG03nxhRl41o9OUM4e8em8j4Ue/3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3854
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously the git-p4 script would log commands as stringified
representations of the command parameter, leading to output such as
this:

Reading pipe: ['git', 'config', '--bool', 'git-p4.useclientspec']

Now that all commands are list objects, this patch instead joins the
elements of the list into a single string so the output now looks more
readable:

Reading pipe: git config --bool git-p4.useclientspec

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
This corrects a typo in the commit message.

 git-p4.py | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 492eb5aa23..465ed16b25 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -275,14 +275,14 @@ def run_hook_command(cmd, param):
 
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
 
@@ -298,7 +298,7 @@ def read_pipe_full(c, *k, **kw):
         text.
     """
     if verbose:
-        sys.stderr.write('Reading pipe: %s\n' % str(c))
+        sys.stderr.write('Reading pipe: {}\n'.format(' '.join(c)))
 
     p = subprocess.Popen(
         c, stdout=subprocess.PIPE, stderr=subprocess.PIPE, *k, **kw)
@@ -317,7 +317,7 @@ def read_pipe(c, ignore_error=False, raw=False, *k, **kw):
         if ignore_error:
             out = ""
         else:
-            die('Command failed: %s\nError: %s' % (str(c), err))
+            die('Command failed: {}\nError: {}'.format(' '.join(c), err))
     if not raw:
         out = decode_text_stream(out)
     return out
@@ -338,7 +338,7 @@ def p4_read_pipe(c, ignore_error=False, raw=False, *k, **kw):
 
 def read_pipe_lines(c, raw=False, *k, **kw):
     if verbose:
-        sys.stderr.write('Reading pipe: %s\n' % str(c))
+        sys.stderr.write('Reading pipe: {}\n'.format(' '.join(c)))
 
     p = subprocess.Popen(c, stdout=subprocess.PIPE, *k, **kw)
     pipe = p.stdout
@@ -346,7 +346,7 @@ def read_pipe_lines(c, raw=False, *k, **kw):
     if not raw:
         lines = [decode_text_stream(line) for line in lines]
     if pipe.close() or p.wait():
-        die('Command failed: %s' % str(c))
+        die('Command failed: {}'.format(' '.join(c)))
     return lines
 
 def p4_read_pipe_lines(c, *k, **kw):
@@ -385,7 +385,8 @@ def p4_has_move_command():
 
 def system(cmd, ignore_error=False, *k, **kw):
     if verbose:
-        sys.stderr.write("executing %s\n" % str(cmd))
+        sys.stderr.write("executing {}\n".format(
+            ' '.join(cmd) if isinstance(cmd, list) else cmd))
     retcode = subprocess.call(cmd, *k, **kw)
     if retcode and not ignore_error:
         raise CalledProcessError(retcode, cmd)
@@ -720,7 +721,7 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
 
     cmd = p4_build_cmd(["-G"] + cmd)
     if verbose:
-        sys.stderr.write("Opening pipe: %s\n" % str(cmd))
+        sys.stderr.write("Opening pipe: {}\n".format(' '.join(cmd)))
 
     # Use a temporary file to avoid deadlocks without
     # subprocess.communicate(), which would put another copy
-- 
2.34.1

