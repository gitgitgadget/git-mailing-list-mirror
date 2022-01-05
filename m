Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B0FC433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 14:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240591AbiAEOOp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 09:14:45 -0500
Received: from mail-dm6nam10on2040.outbound.protection.outlook.com ([40.107.93.40]:31201
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237013AbiAEOOp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 09:14:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KtUN7a0vXLIOmbTZaNhU/JarcwTm1DxuZ7zJ0YVo30WvUUcq1Yds0Sw502UGTTHN4brSVamw+UiYkkSx38rng2JJcUW73O0jSfl70Q4/S6rT0Jj2AHUhDg2GGg2ZIJxxzoWkj4QwCLXk68NsFJqSK0Yoc6r5CugGoQnqFN6N0vj07gGRHP5gYu6B1k8eQP1FTWsIigERVyp7s+dsPNBlBkKM7Km7oYX/zvFAeLyyuZ6Z4DGiaqO0UUhQ1+UTQOcfwoknttwqde9czRtBrrtaJotPlTEvXmFPDi0B8LZfTg6AhMEEvyqh+tY71DNyF7xd0rnuRpnTqeeQliuTD66zIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QkJFjkn5gljmp3at5a+XADuKEjouC5JVK/JWSegjTXU=;
 b=eH5FedOHHV6ltVnE7sul/YPSesxkmPiv0teyQ43e/3G0Ibv0Y4am8e5d32K+1S79P6tJSimPUzJe4W9rU8r3qb/Jz3w3jvTMy9MJMI2IdzGENrdk4Edk6MpYqfSunHwTY0whJ/hTcGK2Z3sKGQODixHrz8a5CHSvxN46rvgFouu+zj3jjaybFvxZPvespwdkCGuFPrB5FqWbhmA6hgmLnVLQlR4DwzV2HPQr+2rJsvFbL05uqVRYfzx1eLrzVzoXXZvpDKC7nMFzv6g6rO7TqDEr3f+C1bIbC63qOQUIE38i4JxVpb0mJ7Ff3Y16B81yxluhe+7h+u8m/YQEzBh7+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkJFjkn5gljmp3at5a+XADuKEjouC5JVK/JWSegjTXU=;
 b=LEd3LwfBVBU2bXItoEbs1gYXi8ymuTD8d2Nzjt4CD3VVGwbXUvpsF4iJFtEqR5KqqtIVxkJu50Dyl95RtL2xT8XpnrU3HWNygJArKz+NoYh/cvRVhesUdFpemU2r5NZgJY2//dp9v8vpmSRYdaftXgzWyGNoLqJ8wsxKht3sn/EsRcwNaxY+hwtO7+FrHwOwtjVrHWvJXOtTthcAJanEeW+yknImEnSbA+sN/5tMXqoyR5nOtMH623C8cxeZgMPdEyKux9tOCS4igSjSMVkgowCawDC2wRCidFqPmbI8HhsM5jyMRK3tOC/4TGte1wi3x5GZXTPDN1U2s3DlnyLlEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by MN2PR12MB4437.namprd12.prod.outlook.com (2603:10b6:208:26f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 5 Jan
 2022 14:14:43 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::516f:3a1f:4951:ebd6]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::516f:3a1f:4951:ebd6%5]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 14:14:43 +0000
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
Subject: [PATCH] git-p4: fixed instantiation of CalledProcessError
Date:   Wed,  5 Jan 2022 14:14:27 +0000
Message-Id: <20220105141427.48861-1-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR07CA0036.eurprd07.prod.outlook.com
 (2603:10a6:20b:459::14) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa82b7a3-0e00-45d9-006a-08d9d055b864
X-MS-TrafficTypeDiagnostic: MN2PR12MB4437:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4437A235257D2563F425CA14C84B9@MN2PR12MB4437.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:82;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ldZaZFcIi1CbYNuvgYzmMPAPPCwrn+YXjpMndDBfNQjyyPfo7cZe4+yP8J117LqLxBUxIuPGbYJWxrrXr4k5tEQdAm+fP6zF+5lDjXY1ZwwevvLpl8kcwCBNQ+qzolcCE8zp8LV2UBwnqYCCaAdojTA9UEObjfK3qKpVt5Bfwz+W/WSvKhj/jYq2MeVdWJPJbAJZt4ZnpDAp+edoW3AWpoBvHWs7xNzOhBcW7PONgRehKQKfGf6DhzOqPOMP/XkYCuvu78H7Mz9PxvAUu2Tw68wo93Q/xkvHMHWq3x1yvD6lKqT5m3WZ1FgqwKrZgurn0YIARvEiR6Z1BW5j4SqplX3Fu1SdOii3+aMrQOY4GItF3L/PyUwkqkT75Cq307aimrQWhtKtDiaymF7cvO+65Ovcdr7r9hBwnuNdTFVSnBlyQjyEKaua0A1dSHqHUAj6mivKIJ5ADMcWSJXgM9BlpIZPWm6jooLMMmT+2ix3s5RNi9MEkVrhOrNtCVa/M/lfY/6x61fuYS1DKV/vlIbErWlyt6srt8T9msYxLdpPwQNREIiQ0RaND1WvsokxGUXWN7Cv3sgi13464Aej5jjnZqD1T50GJ8ydJBleCEsJHb5XYb3e7o79tvJlZlMY7BvaWo2JHfjjTmEVzPwCSTIlIwJJQrpwdxQHh5xi7V8njYT/GD6J2qC5uyRU0UnFVUv0xoufnHeJ6c4HYL7j2KmAIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(38100700002)(38350700002)(8936002)(55236004)(6506007)(6512007)(66946007)(2616005)(107886003)(66476007)(26005)(6486002)(86362001)(186003)(66556008)(4326008)(5660300002)(54906003)(2906002)(508600001)(7416002)(36756003)(83380400001)(6666004)(52116002)(1076003)(8676002)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hTvwC+Zn+g2ShHDPwcZTy2eXJXq00kEKP4XlGovNYOKiX+Cy2K5WNvZV0aco?=
 =?us-ascii?Q?5VLPQ4HHJ58zdMKNYne0PlTXefx5igsRfB5ougaFyhNYu5vru9n3lxXJFjFI?=
 =?us-ascii?Q?xQySnKNk4hTQIYIUSxxjzu2ajwbWYR3LpPE+8qP/XHznRnliC+Jwfnq5MCgs?=
 =?us-ascii?Q?CQv5/huEh3l3IWLReNZ1sz3D3/BxOI5nsFB2WRLjpJFUEZGMIpamMH4kvltp?=
 =?us-ascii?Q?FEFvad9pjJO9A5arQW41VN4oNeBxUdwLzufslsTZWuDm9I+7eCokhecqfOUJ?=
 =?us-ascii?Q?5ubuO2XcoJBC99Fma0G2/IZtP/mjMxVEVemZNSXe2l47yw9W5hMQ6OTRDy4i?=
 =?us-ascii?Q?2fRecmq8t1JWhmYNsIol5476uc2EhUThll/dLZqEqRjifjUd8W7K9DCu7FNJ?=
 =?us-ascii?Q?rfhKtlCImcLBA/AV5FUTJtWxNzzAuAV9Daug+HMw1QfC30OpN7+2KN0ZdUeF?=
 =?us-ascii?Q?Llel09/ivQzUtsr1V5Dn/j4G5NiFZ9b/PwrV6g0KIuiGUfHOYXoXT6NjtFK/?=
 =?us-ascii?Q?0x+VfrdxGqf8LLdnzHvLNyZ3Y8ZBoMr3uDCpO0gSCQuKa/ObdUF2+l21f6OB?=
 =?us-ascii?Q?Xf/zhIzjWD/9MBPN2k0Lj6wrKyOerSmDe/nTH6gffBAIy92KaCDAQl6xF71A?=
 =?us-ascii?Q?/tpGt8WVbA1PZX03YFUKTgV/PqmTAXIHBd/G9lOrpxcuNZwRKsj2sZ+F8TI8?=
 =?us-ascii?Q?3/eUbWS6a4V/AYzLUO6C4c0fym1To+cQC3NFXba1716AfEeAL5m0iAUFsAKO?=
 =?us-ascii?Q?PjwvVnaxKGtGfiAugEFYHIVTiiaFS5gKVNZi3F1G8GGZTwTIivFzveQzpFgS?=
 =?us-ascii?Q?kt3Hgcjhhl7CNgaMx6zs6q1P0npgf5ME4T7L3Dym+TviwcbdgcED4Qxm0WLS?=
 =?us-ascii?Q?sViZ++L1tvjuJyPSAew9Ta4s4Jwjle8JjLS+trmcASSRV3AAJjSpN2nHa6EI?=
 =?us-ascii?Q?dAywJq24UfQsElIb52VwlmLaGLwg3ZF7WjLLpWObpfVhyo8p7/Fi0gb0gBWn?=
 =?us-ascii?Q?ggNlrPsfKaRjUE1gLOXum5q1YsbrAseALGCXES2pqx8zS6tFhpIPGOpKcunR?=
 =?us-ascii?Q?eO2YCK4meUxhuW0Y85ZW6KNfdYqeG0515Gs37qeOPlfZflLVivSlLlKh/Rnk?=
 =?us-ascii?Q?H0C86N7lI4thyn5bfPMlK1x5tbGpSvoLUxJUQ/nLNEmWSnc2JiK2ewoWAQAF?=
 =?us-ascii?Q?gBrZb5AlZOf6OUmPJawTdeG1eLbTaQPjmUt4ZPJPb4U2hcCqs1AzdiZrqL9X?=
 =?us-ascii?Q?ejzieaUO4codSQbpHEDX7V2El9VHW+1WylUVDB+TqAkZTiotrBMWpu2eNAq5?=
 =?us-ascii?Q?SJ4TC9+dNJcog5gOJgCkp+cUtHymBQOb9RhyO6apIzOJNY0uuIYsdhusi7IE?=
 =?us-ascii?Q?LkMFqTUJG6rfE+ChXUdslB5MrOmVEsHEIWk4rg2VYcPczBYbyDJFOyB7BbSV?=
 =?us-ascii?Q?4upsaHDvIFULscK3lCsV/ngbnhqHXAIs9qzrjVt/4B1+EN3K+WQfkRE8gwcJ?=
 =?us-ascii?Q?p6Rrl+dh0JDtuudPjZieuE9JeE8p9hnEL9qDPA2xcriGCyb+Q+ty1+qiGx59?=
 =?us-ascii?Q?oHDudMVa/M2OIoXMTQaFzbbP/bkwFEIgUh0WeRhe7imSQ0akNPogBCxnCm26?=
 =?us-ascii?Q?AGMtSHNnF90pPDlEzWXuemU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa82b7a3-0e00-45d9-006a-08d9d055b864
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 14:14:43.7275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hQg42pZ3jPxPhix8S/Fn0+HGhlB6lsbfF+Z/14rPVQ+vY7nncX75RrHeUERF46zGAUgqdzIuql2L1/oOJpR12w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4437
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

CalledProcessError is an exception class from the subprocess namespace.
When raising this exception, git-p4 would instantiate CalledProcessError
objects without properly referencing the subprocess namespace causing
the script to fail.

This patch resolves the issue by replacing CalledProcessError with
subprocess.CalledProcessError.
---
 git-p4.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index cb37545455..ab3822696c 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -406,7 +406,7 @@ def system(cmd, ignore_error=False):
         sys.stderr.write("executing %s\n" % str(cmd))
     retcode = subprocess.call(cmd, shell=expand)
     if retcode and not ignore_error:
-        raise CalledProcessError(retcode, cmd)
+        raise subprocess.CalledProcessError(retcode, cmd)
 
     return retcode
 
@@ -416,7 +416,7 @@ def p4_system(cmd):
     expand = not isinstance(real_cmd, list)
     retcode = subprocess.call(real_cmd, shell=expand)
     if retcode:
-        raise CalledProcessError(retcode, real_cmd)
+        raise subprocess.CalledProcessError(retcode, real_cmd)
 
 def die_bad_access(s):
     die("failure accessing depot: {0}".format(s.rstrip()))
@@ -4110,7 +4110,7 @@ def run(self, args):
             init_cmd.append("--bare")
         retcode = subprocess.call(init_cmd)
         if retcode:
-            raise CalledProcessError(retcode, init_cmd)
+            raise subprocess.CalledProcessError(retcode, init_cmd)
 
         if not P4Sync.run(self, depotPaths):
             return False
-- 
2.34.1

