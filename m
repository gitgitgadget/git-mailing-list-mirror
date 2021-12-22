Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271A0C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 06:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242776AbhLVGlX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 01:41:23 -0500
Received: from mail-os0jpn01on2117.outbound.protection.outlook.com ([40.107.113.117]:52869
        "EHLO JPN01-OS0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242773AbhLVGlW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 01:41:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sb1OD0jx4flyfRN3LcBc0px1MMWNxX8c9n36POu2FdZ34ImB+HD0A8pVbXPvxh9fcelxKIm9auCapS3vL8A8f3oRnOYl7Kx1f8q0MyjyhDXmRG9Q+OBVk6pNID1HHP4diO0mpodmkgmwl1EhYFU8myn5LLPR4e7/VcUllsTmX8gOr/VUmEcfmvnho+uXuFYvygSrINrz/7DjMEqyKAor+cPsZ6zv4J4IRuFMMpBEgY0osPqHQMCUfV5Wo8vNRotxGVaka61jY+/xQldm0OZbG/owDPG/W3nmA86y0/s2GwloweLzCCpUzTpD0QGVtWiVkm51MeNDiLv+NLSmxGi7jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PspOh+MP5MBKnb3Uq/Mg5bzMORdtAiAPaTj1cf5nzcE=;
 b=P1c3o+zWjTCnNbdj7o7ADuL03yNTc5pUDg1ps5OvVXYepoKqRm1V9uR+6ifC8qaCInx57+5vNAhrnd3ERQVtJm37oBdY64TPxIrEhfXl9JPQevaJJXjqOi9FnYVkFnRiSLqKxCXq7ddMr+JdsK9f3ECBTM5m8WIHPMUCC2NnN3eS8MS2sphs27EQpfUcjnDWOdsAVdTX60StOYjwLcn1uZC0GIUg6Q1nMo7yNDkFgfTDiVtAs30enDGWFy/81K2SQaMUhY65txs12A3ZanAGGDFWl7u4/GwTak1uzCRBtik7UTn/5g1aUe8cKYSa/OUnRwWA3+sDRLk7XkG2sY8SMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PspOh+MP5MBKnb3Uq/Mg5bzMORdtAiAPaTj1cf5nzcE=;
 b=pU+/GdD2puAj9uvg7vZgJSTUwg9SnvsoNy9Fq3426U2Tk7n8H72sqPY2NcL42uRuH4P2CBJpgahD7Fq7RhjLfL2FTSKZyZd4wugICfIB720tfl8rMBhX9zB5P0clRP2XykIwwvYsGucDLwpBNDDKWmM/tpAK4kk9F1H59OsEbJg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6) by
 TYYP286MB1129.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:cc::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.17; Wed, 22 Dec 2021 06:41:20 +0000
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::5cf9:8c86:9001:90d9]) by TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::5cf9:8c86:9001:90d9%7]) with mapi id 15.20.4823.018; Wed, 22 Dec 2021
 06:41:20 +0000
Date:   Wed, 22 Dec 2021 14:41:17 +0800
From:   Zenithal <i@zenithal.me>
To:     Jerry Zhang <jerry@skydio.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH V4] git-apply: skip threeway in add / rename cases
Message-ID: <YcLIjXBdNmMvbqCj@Sun>
References: <20211217224328.7646-1-jerry@skydio.com>
 <20211217232902.7604-1-jerry@skydio.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217232902.7604-1-jerry@skydio.com>
X-Operating-System: Linux Sun 5.10.81 
X-Mailer: Mutt 2.1.3 (2021-09-10)
X-ClientProxiedBy: HK2PR04CA0049.apcprd04.prod.outlook.com
 (2603:1096:202:14::17) To TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:c0::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e33bbec-00d1-4cab-8b8f-08d9c5161019
X-MS-TrafficTypeDiagnostic: TYYP286MB1129:EE_
X-Microsoft-Antispam-PRVS: <TYYP286MB1129D9AB4F970D8BF1879BEABC7D9@TYYP286MB1129.JPNP286.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eKCwBhOB19GXNnJmcy4JkCYFYM2t+8fZXjHd/FeD/uonfLnpmWdfjIevTeGnRdS7SEfB8C/7IX+cyoPQDHxeZ5QU/yKuYjqQzD6FbFAg22Ez/8GctQ6BMMo7MpfMi7JzdKwakt9bnc4l+dWwI2u15zZsWI+BE+/hVCDdMVysQsreCdm0Vv8BRP/3ixRuyznZ57Y+BiubQ9+kcrLTO+eHgvtSwDxNolB1g+BSKWAioRkz1Mix5Bi0SdeUX29xu3RQgVEVX/IvPxtiKGio/uzLCiAPmEwwCrkAziMT7ju8GhEWgSFdd94Q4p3wKDOnhLgKcUwEXvA9B0LUPP+dfbkBM2aVK1QKRWL871N/R0GAE5m9b5skC9E1lstaSM9Ax9RGk9Q41ZSkj+xobIHX8i9lzWfe1cn249/nFh/Wozm0CZyVJiMCp+tUOyTtvXBdPCR/eJZkR/9q4TmlG3QRPCWopFL0vbam/SxCSFWCoQcx74UzU9DF9IoB152F3GlZTMiSxXwHQMkfg09rTGKQQbu2yBfn2DL8FmVJMhZ0tRrp/KVwtqPMHgJXlFbBUg4YnfVtAxkxLK+3v2AUUAO15oUZMfe/TVDwb7DzPfKGuGmOg02Mb4dpQE6dAEGGkq8eWnFTGHo+FPgvJ22RbT1/+sblSTl32mF28p4vpujCzV3+S6qLAY7IfhU8CnTMA7CUxHcVA8leE3IhDj6cHDNxVFHWuiYoV8i/w5kCQbyEwpUpjzUJeqzI8PLOqj8R6IuYypCNL8IeWJQOQfmRRfW65F59MQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(7916004)(366004)(346002)(396003)(39830400003)(376002)(136003)(786003)(6916009)(186003)(8676002)(86362001)(6666004)(316002)(8936002)(6486002)(52116002)(9686003)(83380400001)(966005)(66946007)(6512007)(66476007)(66556008)(2906002)(508600001)(33716001)(38100700002)(5660300002)(6506007)(4326008)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8pgnuJJ/eD52qxZERpEmIZFqjCqtV3rpiPKy6r7/EsmAo84QHjM6hOoTyIpZ?=
 =?us-ascii?Q?Z0rs5AnvJkTpCDkBsqdn4fQ5loIfwFCsrEdj1JGVbTRe9QaukFAoqNoLW/eU?=
 =?us-ascii?Q?4EXLggJhwoHB8b+OpPt8elO7Wd65EPy/yZOxDKwk8/uyK3j692JyB7XgVi8N?=
 =?us-ascii?Q?PnIA7If7EWowMEN6yqkwhOgWPreqt5y1OtpMXqx39FLYAt/E2Hi0wSo5hyyy?=
 =?us-ascii?Q?cjAWyTjyNL/ttqkEQaFKieKTYMh+yTPOeFYY0jEsUdLJF1aA8gz+WurBhrMu?=
 =?us-ascii?Q?OOfl1iWzw/sd+e5iAwmOBjv7R0xg43gG2Bzc5t7VRQ/O5ktst9+BMCQv0+Wg?=
 =?us-ascii?Q?sDH83GgaCM3/KcKU2ARvKjNX8+7WXRMG786u38+j3O4g+qB/rSKW/8bJKmCD?=
 =?us-ascii?Q?uzYmAW0Ix3sgckccR5scn9O6R0rTr4K/1H5/fps3gLsJrBTdd4dGmHMnuj1C?=
 =?us-ascii?Q?dHlK7Azx6TQmvxrscARoGIymOKTtIjEnMUIAY1lqqTnaW+8bPGe/nCVY97Sp?=
 =?us-ascii?Q?rqCwLnPw65iCibiEaMAcpcAr0Yl1KJsFgsQasLVK3Js92sl63+auTK7tbOzb?=
 =?us-ascii?Q?fPdR4y7wIyfXe9O5W/TK0Oj6iNnu2PlubNmPu+3oyJt0iNbcRN9PPF2BJi8+?=
 =?us-ascii?Q?VqcbCMHjYxoSrPBJja6uVFx95KAC3DEd82s+U9uqYk0gN5g0vZh5KaLPPuyb?=
 =?us-ascii?Q?w9k943jXj8qOTbR6ItMgp+REmq0L4qEySMTdwYmgdx14eysI6FkAmZBw2YlA?=
 =?us-ascii?Q?JxTODqFbkIdjfZQV6Cyx/IsmOJDh5mN8/0tTw/xpm3fX+L9hEySlt9rv1DD9?=
 =?us-ascii?Q?1V7n5XkopOOpOBK/6Zl3E2pqVvuzXjRM/iz+9xa7twzvM/rJ5VYjPVxcwlIl?=
 =?us-ascii?Q?lqt3D+K4eUv/3LBvuzR9m+wQvJxZoPEzPD2SUkHO2nZHjGN7c0SgQP3ODS86?=
 =?us-ascii?Q?+5rOlStSc1yuZI+w+W8RskVd3KlGOZ2cGERBOfCv2mi2evqEPm8SldCp6A01?=
 =?us-ascii?Q?fu7wO/x9Kt1aQKiUbSn/FbxGWzcSr88PeyM7zDiLbmf1lGh2x4/NhZBGQWkd?=
 =?us-ascii?Q?57Qf57bFrfRD1HtU++2sM1KBR6z7pqLOcNerk0XQDHW8bTr4FrGwNuKHKNDn?=
 =?us-ascii?Q?K8JVNnyMtq5vjUIWlns3YEIyvJDiaNZg0CuqL06Db097rn7Qvj4zkuXyLAVi?=
 =?us-ascii?Q?zzIDrdrcPgy7TSEJwETajpBqTAg6UfKwTCM4yXBpjbsweEzfkG4F9SZIFa5k?=
 =?us-ascii?Q?o9LuBTTZVckp98ixPtBb/sX03QN8ndeWa+3pR5I2ArsY4uWXE9SU4vO4s1SR?=
 =?us-ascii?Q?WOaIixhBbnAdloQnin8Nc3KPmslTDJMSuGx8XWT/ByQo+8Bc5ou9HuqzdQga?=
 =?us-ascii?Q?oCYsH4iq/p1l2wntwZowdUa2FEuH10DkcFlVOqGHh+Icpvmbp34Qhx3pIEC5?=
 =?us-ascii?Q?qsuwJd/cyMwVEbAAyFRoggzLthb6zGnbcHWljS19uhkPrKU256K1HP1sBk+E?=
 =?us-ascii?Q?K4gJRNGc++HU1M3htSawSZ0vUPJeOWv6wODlewFABSoDmPKkKx3DMefZKgkU?=
 =?us-ascii?Q?lnX4X1y0mcXlPja8WAmRJ7ga6xcTzMyonDIwMKfv?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e33bbec-00d1-4cab-8b8f-08d9c5161019
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 06:41:20.2197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0rVjXPchtKjaFFiFSwyd/XRvIWt79UOAe5i3jH3layaRP2mBw7RgXjFuX0zCRGkF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB1129
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 17, 2021 at 03:29:02PM -0800, Jerry Zhang wrote:
> Certain invocations of "git apply --3way"
> will attempt threeway and fail due to
> missing objects, even though git is able
> to fall back on apply_fragments and
> apply the patch successfully with a return
> value of 0. To fix, return early from
> try_threeway() in the following cases:
> 
> When the patch is a rename and no lines have
> changed. In this case, "git diff" doesn't
> record the blob info, so 3way is neither
> possible nor necessary.
> 
> When the patch is an addition and there is
> no add/add conflict, i.e. direct_to_threeway
> is false. In this case, threeway will fail
> since the preimage is not in cache, but isn't
> necessary anyway since there is no conflict.
> 
> This fixes a few unecessary error prints
> when applying these kinds of patches with
> --3way.
> 
> It also fixes a reported issue where applying
> a concatenation of several git produced patches
> will fail when those patches involve a deletion
> followed by creation of the same file. Added a
> test for this case too.
> (test provided by <i@zenithal.me>)
> 
> Signed-off-by: Jerry Zhang <jerry@skydio.com>
> ---
> V3->V4:
> - Fix test bug where it wasn't actually
> exercising the correct failure mode.
> 
>  apply.c                   |  4 +++-
>  t/t4108-apply-threeway.sh | 18 ++++++++++++++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/apply.c b/apply.c
> index fed195250b..afc1c6510e 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -3580,11 +3580,13 @@ static int try_threeway(struct apply_state *state,
>  	char *img;
>  	struct image tmp_image;
>  
>  	/* No point falling back to 3-way merge in these cases */
>  	if (patch->is_delete ||
> -	    S_ISGITLINK(patch->old_mode) || S_ISGITLINK(patch->new_mode))
> +	    S_ISGITLINK(patch->old_mode) || S_ISGITLINK(patch->new_mode) ||
> +	    (patch->is_new && !patch->direct_to_threeway) ||
> +	    (patch->is_rename && !patch->lines_added && !patch->lines_deleted))
>  		return -1;
>  
>  	/* Preimage the patch was prepared for */
>  	if (patch->is_new)
>  		write_object_file("", 0, blob_type, &pre_oid);
> diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
> index cc3aa3314a..c558282bc0 100755
> --- a/t/t4108-apply-threeway.sh
> +++ b/t/t4108-apply-threeway.sh
> @@ -273,6 +273,24 @@ test_expect_success 'apply full-index patch with 3way' '
>  
>  	# Apply must succeed.
>  	git apply --3way --index bin.diff
>  '
>  
> +test_expect_success 'apply delete then new patch with 3way' '
> +	git reset --hard main &&
> +	test_write_lines 2 > delnew &&
> +	git add delnew &&
> +	git diff --cached >> new.patch &&
> +	git reset --hard &&
> +	test_write_lines 1 > delnew &&
> +	git add delnew &&
> +	git commit -m "delnew" &&
> +	rm delnew &&
> +	git diff >> delete-then-new.patch &&
> +	cat new.patch >> delete-then-new.patch &&
> +
> +	git checkout -- . &&
> +	# Apply must succeed.
> +	git apply --3way delete-then-new.patch
> +'
> +
>  test_done
> -- 
> 2.32.0.1314.g6ed4fcc4cc
>

This fully resolved the issue I mentioned in
https://lore.kernel.org/git/YVmTKWlOFr+IwzzI@Sun/

Tested-by: Hongren (Zenithal) Zheng <i@zenithal.me>

Also, I would prefer a
Reported-by: Hongren (Zenithal) Zheng <i@zenithal.me>
tag or even
Co-authored-by: Hongren (Zenithal) Zheng <i@zenithal.me>
if you deem it appropriate.
