Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E7AC433FE
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 16:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241891AbiAEQPi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 11:15:38 -0500
Received: from mail-dm6nam10on2068.outbound.protection.outlook.com ([40.107.93.68]:55777
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241895AbiAEQPg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 11:15:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVWXAnBCzKvjR0a3ySl48LGLE6flaCp578U1AQ/7FyVo9h4wtKAQNKsogVEPwFlQXiQ6v84+U92fRilfzFEerbvFaPabbOUykjPh5EsU6dDoLdR4H2bfJzJIR1jjRkV4AgFX1qLccv9OEmyHmPd0p2VNCsvpE8TT/PN/hoOHicqqP+7iHleFUC4CyWm2nTQwi1zKak77bmgLRyXKDCBTSQdvTwNOhCnPAujxY6uUyBTbpdhKOVQP42FrY1tJvzKzLEwRMU6XHdCjU57//t3gTbVelAhXXHNHgc8RylZXLbChVme25UhoQENL87HFTXgmSZY5wCG+hRESDS6W8N6YAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHajuZWCjdgHuLV1rKFLboTkUHd6Z+ML6dvgyJr7bIE=;
 b=HZeisnRw77mpk0vwkCA7KliVlmIxiRBEuUU6sOkFkp5w9eCrypUAazMUbJpyNr5n9dJkLq1qfQCRLNKwTte3k1OzvrZnooiiYSVWB+1YzitIb49pAUJxOOWyc9Avv6e1cU30mlUZdgPEx/F2ou0UpT/qvIoYA8Fbv7y8estcmp+W0BhHqVNwIBj/1mp9a6qe9qpBp0VHAdbrRk3D2hn9WUaamEh8jWOJQxmMBduB9XJ4aieRcAuHZ4PVTKklx9aPLbozd11qRjAUn3IV/NbFAGVxh5oJyn1xwT0OqaLwDmb6GzCKMGFtYyRcyn/wkx1F3n79357vH+upv9ICVI6lEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHajuZWCjdgHuLV1rKFLboTkUHd6Z+ML6dvgyJr7bIE=;
 b=DrQJ2yvBpNcJz27wfC37EEIx3MbA5M4HOVNwsILjn66Tm3dW80S3qgXfMkBg1WauEhIfDxYFUM89lrfqkipnYJSLOk1YWiuAfhI6LdoU7Y0M6PC8nq/v2JOApzrVxBc+XuB5ItJGbVcXHhmUPenv5EwsYWgrv7rhwqCPSJf9DeURgbZQ6yqnJILcf1NUKv1uNsqTBOdlTk6bAOS3dfuInLO/1QM2xVNjD9mj8Ue0XYjuMvD/K1l4Xq6gaZJVGZqcGYU3UD5QmAoJz+Z++OA2a/xMyWZLQSdoyoj9N0YE/2M827gia27jVlrymSct0HJ/hgG9DIer4l5D68PLjBPIww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by MN2PR12MB4423.namprd12.prod.outlook.com (2603:10b6:208:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Wed, 5 Jan
 2022 16:15:30 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::516f:3a1f:4951:ebd6]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::516f:3a1f:4951:ebd6%5]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 16:15:30 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>,
        Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH 3/3] git-p4: don't print shell commands as python lists
Date:   Wed,  5 Jan 2022 16:14:51 +0000
Message-Id: <20220105161451.56378-4-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220105161451.56378-1-jholdsworth@nvidia.com>
References: <20220105161451.56378-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6P192CA0025.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:83::38) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d02c0605-ccbd-4aaf-83bb-08d9d06697c3
X-MS-TrafficTypeDiagnostic: MN2PR12MB4423:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB44232C1591EA602A6EB36ACFC84B9@MN2PR12MB4423.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gj9P0O0IbXrkZkW8TjnrFWGWH/57tSqxOrM2/IyjXOL9XRFOarSDQchfiR7tkN7d3wJ5NDEDD0+WKSgcdvRGIUayF3jWahdwG9r7h5Pujfjx9f0aNK0awWl4suj96Cm0r72tnxGEIrJ+9f5P7cC/yfWU7ZpWNO/V/SyQFfCyYiUj4cErbjfIhSB7yDMwZ/W/z/vZXsfQVTXySws6BLjXC+g1h9jlMtsvMLZ5aY9s5/RVIZKD36tPhlvOSTPNHfZcNqUMndEYXqQnok4ZNwWQOJz5yA8KBoRNuOMIi/rrQfIXv8TyBJAkcqEE/Kz4WbPS1u7+myJ1d/Uz5KJ/0wAtnM0auAmCI2xV5V0LG1vibhXQF5RGGMqhNcLqVo9JRL7R5lNv5bxoFPQYLoUESKm54ycFUOIZ2WGuuTlXjyrlhuAXFoHSWQfnYpnYVBfHMQojeDKeceom8hifm5TDmR7CYTevaj1zFPCV/jzUffdEWUordk78YWK2U4G2or+OY0dkTEukdTEqFfbWxq7StwRnT19Y+KJLtjcGpw6JzANG3JGRvj4eAFc12AD/UkWCgnIeBqZo2Q6CC/N0ABALH12USm7D46z1dL3L3YRHVThZ7Xdo+hWxP5WOFiNV+G+1jEcQ/sSlQ3svQjqLZHShW5HtLdP4WkCVHBg+rnRNi28/sY6AyLf9EnQnnxm/b3c/qgqIhHm/j8X7kG4XEJeYgsGt1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(6666004)(66556008)(2616005)(1076003)(38100700002)(54906003)(4326008)(316002)(66946007)(110136005)(6486002)(186003)(66476007)(36756003)(38350700002)(7416002)(55236004)(6506007)(86362001)(52116002)(107886003)(8676002)(83380400001)(508600001)(26005)(2906002)(6512007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lQLTs+6c+aeFrsNaNivWLscaxBByK3/b1wpOUxcPySGP1g3aRiklQJ6b2iR0?=
 =?us-ascii?Q?k6po3TDuyh4LyktzuPdXDdl9h92lXv5E1fGZ6iVTlAriG3E0Oge1iclCfl7A?=
 =?us-ascii?Q?9Uzfy/w9TK6HneyA5pgV/sD2re3OsgfwX0yWYxDGP0Nezb5b5eXOtAy36Lf6?=
 =?us-ascii?Q?i3acz76g8VmI+m+HaZ0U/E+TSPqpBPxY3tPkYGlDUdGupCoh7jr/BnJ0gM90?=
 =?us-ascii?Q?+UU0TUh+RXwWBoyTmOhW4M1/kYozszNy/oZ5NHCihM2W7rUIFO8ovtM1/3Mw?=
 =?us-ascii?Q?HvpccrIZzOF5YVsmzdPCKIVQT1PO8s1TsvwYliCVEn9DZ0R3qEWzjYTtYW05?=
 =?us-ascii?Q?fkbIX6Sfbt3Vvaw07KixFDPiQx7cjRYIRh0+0wi4FNgWd56Z0vh9RkETPRB2?=
 =?us-ascii?Q?Qx+5w7zJ7xUj0Ihx7PKejts7fz1r3dDGoI0M21KRXUrEnRi8FneBUAi3QVg8?=
 =?us-ascii?Q?RAVPHj9HOlIj5Fr4eOmbWEwQuzNmp6p7emPzQvrl0PkORC8/g0/oPlev84ul?=
 =?us-ascii?Q?aRlszSd9RHDlUmXyAgr0WhEmoHZvwpzh6d9EjxXVI+TXm1YTrhQCeSggz6Xt?=
 =?us-ascii?Q?+uvWwOgq4HXVBx4a+y2THwwOX7TLu+NIpF4llgoxSMvwzoV8vn4VdiT9y/rF?=
 =?us-ascii?Q?cqfKE+BMqWBrXKjlczF/GZgLQ4RWAeShpLf44ZzV8rqulqCvjFnCp6LIvIU0?=
 =?us-ascii?Q?jHrjgWfp29Qm1tze683mgVEOLyjwnsKsMU20UKrW16lnRYH0FubaS2Gqaif1?=
 =?us-ascii?Q?ru6zgHMANLL7UmalrKojVMPzP754pEtqePJOPUrYaUSzKzd8dcvzCfxz3bKl?=
 =?us-ascii?Q?LClp1gyNDUWWUb9MqaaBamV7Tasu6Q37/6wjZd7HdaO5dndBu+Hd14Bk6A1D?=
 =?us-ascii?Q?GsPk5jlmpFhE8nQ6zX0tk9Cb0QaK4ROPd4M59A+HL+CO6B2b2IVWysFHxxGh?=
 =?us-ascii?Q?df9G6jIRhjdvsLqfOLyAZnLZYUh2qWTcD9DTrwjxuOAOGVslRaJlf9pUDH8g?=
 =?us-ascii?Q?SSi2bsoNJ1Lkbjx2kO9vg2cQUfLhoSW/N+/2tY7DumEMX9uDhASj12sddL+y?=
 =?us-ascii?Q?NGzTN8cM2r4lTbUNj+AZGdekElYJzUf07EKRpKV71ZA1hJNCozc+7HkT3sxZ?=
 =?us-ascii?Q?SpeNrZapWCPtM92HkUyl58UIp5dt4AAkOmiYx88e3/vNu5G9+Uwu7yolNagA?=
 =?us-ascii?Q?KPG2mTXPkfjHW5MXikCEw1AQgTwWQaGHjC8Gb8K9JOizb1JeKDIlKEWTbyjl?=
 =?us-ascii?Q?bPV/54C5YhjYZKP/aWg24i9c6oA2Z7pgCTmXEyL2P5K+3dJdxhOyKyu/z392?=
 =?us-ascii?Q?Waf08aOSMMXZv7oZSmt/6dcwSpudg8TTLsclYWeegacfjebfG8lBI5uuJBRw?=
 =?us-ascii?Q?RE45gpC+v97MLenP6jApdz1yImn75TnNmNSDhSAOvhzo+jW5TEUirE7TkEBs?=
 =?us-ascii?Q?N8Mc2alq6y0jxBk7XYYPleyDFKR6dCH0CmsIT7TFAPC6DBXo/8ZTIJZG9h0P?=
 =?us-ascii?Q?JK2rYzOCT+63M6PbFas4Y8gFiNij5lYLcyT8Qpt1RjT88h2mRtdbZjtz175O?=
 =?us-ascii?Q?91pQQ5gLMHGKIO/pkHmrDc7roN9NGpeQjXb2pIJ2qW8IkmaD9DjiyM3vN5r4?=
 =?us-ascii?Q?mqGPcpqBrw9Xsn0Yd7As8XI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d02c0605-ccbd-4aaf-83bb-08d9d06697c3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 16:15:30.3549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rd156GVj77kL8pITpWHnC6lZjSkRUQNZA7Zri3PAVlgnSkMl6kTnLhhyV33lBCJtRPS4mQhGtZiUgwvTepYBcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4423
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously the git-p4 script would log commands as stringified
representations of the command parameter, leading to output such as
this:

Reading pipe: ['git', 'config', '--bool', 'git-p4.useclientspec']

Now that all commands list objects, this patch instead joins the
elements of the list into a single string so the output now looks more
readable:

Reading pipe: git config --bool git-p4.useclientspec

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 7c1f238a56..27481b91de 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -287,14 +287,14 @@ def run_hook_command(cmd, param):
 
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
 
@@ -310,7 +310,7 @@ def read_pipe_full(c, *k, **kw):
         text.
     """
     if verbose:
-        sys.stderr.write('Reading pipe: %s\n' % str(c))
+        sys.stderr.write('Reading pipe: {}\n'.format(' '.join(c)))
 
     p = subprocess.Popen(
         c, stdout=subprocess.PIPE, stderr=subprocess.PIPE, *k, **kw)
@@ -329,7 +329,7 @@ def read_pipe(c, ignore_error=False, raw=False, *k, **kw):
         if ignore_error:
             out = ""
         else:
-            die('Command failed: %s\nError: %s' % (str(c), err))
+            die('Command failed: {}\nError: {}'.format(' '.join(c), err))
     if not raw:
         out = decode_text_stream(out)
     return out
@@ -350,7 +350,7 @@ def p4_read_pipe(c, ignore_error=False, raw=False, *k, **kw):
 
 def read_pipe_lines(c, raw=False, *k, **kw):
     if verbose:
-        sys.stderr.write('Reading pipe: %s\n' % str(c))
+        sys.stderr.write('Reading pipe: {}\n'.format(' '.join(c)))
 
     p = subprocess.Popen(c, stdout=subprocess.PIPE, *k, **kw)
     pipe = p.stdout
@@ -358,7 +358,7 @@ def read_pipe_lines(c, raw=False, *k, **kw):
     if not raw:
         lines = [decode_text_stream(line) for line in lines]
     if pipe.close() or p.wait():
-        die('Command failed: %s' % str(c))
+        die('Command failed: {}'.format(' '.join(c)))
     return lines
 
 def p4_read_pipe_lines(c, *k, **kw):
@@ -397,7 +397,8 @@ def p4_has_move_command():
 
 def system(cmd, ignore_error=False, *k, **kw):
     if verbose:
-        sys.stderr.write("executing %s\n" % str(cmd))
+        sys.stderr.write("executing {}\n".format(
+            ' '.join(cmd) if isinstance(cmd, list) else cmd))
     retcode = subprocess.call(cmd, *k, **kw)
     if retcode and not ignore_error:
         raise CalledProcessError(retcode, cmd)
@@ -732,7 +733,7 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
 
     cmd = p4_build_cmd(["-G"] + cmd)
     if verbose:
-        sys.stderr.write("Opening pipe: %s\n" % str(cmd))
+        sys.stderr.write("Opening pipe: {}\n".format(' '.join(cmd)))
 
     # Use a temporary file to avoid deadlocks without
     # subprocess.communicate(), which would put another copy
-- 
2.34.1

