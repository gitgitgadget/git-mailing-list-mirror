Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626CCC433EF
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 18:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 387E26115C
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 18:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244561AbhJPShp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Oct 2021 14:37:45 -0400
Received: from mail-eopbgr1410132.outbound.protection.outlook.com ([40.107.141.132]:13872
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240331AbhJPSho (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Oct 2021 14:37:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3/gcYckon3iZ8IulmG1qT9pAxoffrRVGR8DCA6vBaHwduX5jsar7U29KU3sTqXzS27wHgsVB/qpFGzJi6SsF9QIg3vHeRFy58ifiVHBO+BinaWeDRhH9xogJ+re+bvPt14IMQfRhR+qBLX1dzdX2E7hUIrWIxAmmkAWfyGhd11hH8ABE/4YtnJn0RUIJsLY/rL3yU3Hk3x9rAwjMsqKeyIcEqKwbEW+MoHGr/DTuZQeyMkoe37P+f8VLj8MrM3SbWedPL32T8OwZKB64AsKLA1JXDFQ/USRMp6ZsTxSudo6kwnqDP+3D23C5sZG+JQvCKwWmbKH/FsYDpRLZTd6lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWBvX9XVL/J06Xyk6y50CsUG1Oxz6n1FwluwzcG6DyA=;
 b=jHWbjfZiSqFCX6ai/LgN7e55lSZM9MDBWOrqMKRwarrOJvDVjAf17utoHBY/2DvhcxmoE4KeWPLxpS5OH+NcgIVPIUM6Azrnlw7846qMX9st9ZzDP1GO4R1E6m0icpNFX8bA18MBtUxCViwKzHBKO+uMDhkoKeLzPZ4Zfxuvl2CqJVV7xtEsxPwCTyT+sKrDzTAUAckvs0AimageQ6aUpaQcTUGGd6bCNPz1Lx7aIiCtxZ2ouLinvypxvcyBEj6s6fK/lPF/8RGspwoNJkJ3YeA2KUsUz4UNwBDyQMTkYi/ojH6LJRy3PdKddVSGI80E0ihslH6DELOKnIH9NMg68Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWBvX9XVL/J06Xyk6y50CsUG1Oxz6n1FwluwzcG6DyA=;
 b=hAttYEWZcglSm2VWjRLkD2/p5+wgorYo0J28ClwjI4yPT9RWw3NL9I0Q0Sc1PE+u7bl0F2snvrgDLgTxGsNVRGRl5q1kF0anHfHMNXXM8ocwGBejDtexOF7yLjxl/TteBG/xpLvG1a1OQ5W8V9g24ip/baewh9DacNhDxwOS6kI=
Authentication-Results: pobox.com; dkim=none (message not signed)
 header.d=none;pobox.com; dmarc=none action=none header.from=zenithal.me;
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6) by
 TYAP286MB0876.JPNP286.PROD.OUTLOOK.COM (2603:1096:402:3a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.16; Sat, 16 Oct 2021 18:35:32 +0000
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b4b2:45a5:5cf4:d52a]) by TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b4b2:45a5:5cf4:d52a%3]) with mapi id 15.20.4608.018; Sat, 16 Oct 2021
 18:35:31 +0000
Date:   Sun, 17 Oct 2021 02:35:29 +0800
From:   "Hongren (Zenithal) Zheng" <i@zenithal.me>
To:     Junio C Hamano <gitster@pobox.com>, Jerry Zhang <jerry@skydio.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] apply: fix delete-then-new patch fail with 3way
Message-ID: <YWsbcbASLG3QNPyZ@Sun>
References: <YVmTKWlOFr+IwzzI@Sun>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVmTKWlOFr+IwzzI@Sun>
X-Operating-System: Linux Sun 5.10.63 
X-Mailer: Mutt 2.1.2 (2021-08-24)
X-ClientProxiedBy: HKAPR03CA0017.apcprd03.prod.outlook.com
 (2603:1096:203:c8::22) To TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:c0::6)
MIME-Version: 1.0
Received: from localhost (2402:f000:6:600b::11) by HKAPR03CA0017.apcprd03.prod.outlook.com (2603:1096:203:c8::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.10 via Frontend Transport; Sat, 16 Oct 2021 18:35:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 370df2e8-ddfa-410c-430b-08d990d3bb91
X-MS-TrafficTypeDiagnostic: TYAP286MB0876:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <TYAP286MB08769C7A2CCD5702C4ABC409BCBA9@TYAP286MB0876.JPNP286.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U9xIYfnh/fF8ujJekH16KkVdjtg0QaGpn5201+Ear9nEPPflAvHNZzDbgWc8pilohco+cY4fQ2UtTH7y+vr718MSr+SskGQH3+e82Y2I3gNLp9korvJ2UtKVxex90C0NSLKbRvBr79U0InPTv4HFVXWen5MKh1EOihlAG9Opf5dGTuighKxlPZzhO9stCtSkfDOe+g+j4+XNkTJX+PbUjxvfKj4JD6w57qbDZM4zEZFI3PvmqQGGKV06yuQmCCl7kAf1SG9h9faGqFxIr5t8b6DmjQafTC34zZSdWFzgkHhE5yJh1wBRZi3vyVHx2p1Pr4EkEWB82hHd9jI40WjNIus9eQ3hypx4X/jKQDXi6k1brvWYY1xAcYcsVc+ygRULzKOyVCYYziiFrvBiWx43AFporl1TTQqBdr6VzHqoVMk5FvwYMHh08fvh9BotgP8Agb/FhHx6OuO1VTde66B3gQLgczJ1YZIy1wm+txfpdc7cbug5feQrfMBdgu7vZKTrkQGgc0Nl+0YFjutkZNOPMdxoBDiPm2FqRir3HNbZWwUSg8BaB6chXjrPp499zaobaSdS9x6H0supnsoThKhTGyapeCyg6W/qg4SqpUkqIEpIn76BfARopfADucIsMvO7SnVj2DCK2m8yZc5X/xBwpfmj33MYFf14W1QBxruhaiJSr4VmjbO1R/XADKgcZdJMBSvsm6YjeGFrSf80NyNNCKB3s0BLq3EcyKI2FsZdzzpbQTNpSKRZ180uY+bUAtyBcgEoY/3YjhV2J+e9+0geIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(7916004)(136003)(39830400003)(366004)(346002)(396003)(376002)(86362001)(9686003)(8936002)(786003)(966005)(8676002)(186003)(508600001)(6486002)(4326008)(52116002)(316002)(83380400001)(6496006)(2906002)(5660300002)(66946007)(66476007)(38100700002)(110136005)(33716001)(66556008)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1a4jbXp8m6ITgJxH07WouseOjqxlmZe6dNI7bmAhVM7WdZMGl4R+lqYTyM1U?=
 =?us-ascii?Q?DvX67FWcG89FGIeEanKUsozTQ5utiXQ/0NW2UH7z1tcuQcbrjjA/V0NrcfHp?=
 =?us-ascii?Q?LW4Ijni5PaL0141G2fAM//aeIVVHuVMAr/xPqi9lrCnqMmlkH2S/GNYbzYlZ?=
 =?us-ascii?Q?k8tSAPWbzjsO9pFXvBKxmgwJMgCsNd4gFsHQszKP+MqTpWJ6hmqpAwv4jLn8?=
 =?us-ascii?Q?MUYzEhOJ/u+y4gkQREPk6oxy7Vn+7xHhrd9Y4yOtFI+m8K5Cq/oMkwC3AJ0a?=
 =?us-ascii?Q?Hcg74fEBtjivM3WSQ4wLGtF8bj0VrM1669MfPonKIj1opjDmsfkzg1f6AW2Q?=
 =?us-ascii?Q?ehANtcnUlHsBVt32tWAxNKfFvDictqbmnvSk82pXlZyM/VGi0CvBgCQxIp5H?=
 =?us-ascii?Q?eKVxORrNl7LDkTvivPBdn9Ib7/eMLhGZ+fNnImX9PcahcM/BzTklZjYPL1O8?=
 =?us-ascii?Q?VXfn2stWDmG77npdHOrlUVx1MGN+6PfAFMCiiLGqk+APEvAd9cio56zM8ZIY?=
 =?us-ascii?Q?XM/jyDmGUx2yjRqL3PWVQyptnNPwObTH3QpVlnn7z8pAOu0zX5vHegR0gNQx?=
 =?us-ascii?Q?kxTqO/izJa59Gh+p9njDpV+0VLT77Z8dTOlW7GqPQ6Nze0FtZkIMT8PxDdRs?=
 =?us-ascii?Q?huaBbjH8KsQT3/u9/BbLN9zao6y96Z7UsG7kahsAixwHdy8B0j5hyGnUewZ1?=
 =?us-ascii?Q?17TQ0aBJNOxjacm7on33nRRiVnQdOQVxx5UGbyvIm5/tIDugYX3vOIcJi3S/?=
 =?us-ascii?Q?X/7qo3duV1imscE/2l8IUoU+z/CAEybfmT5alXD6tT2GUmfYW/BH7phFS9tP?=
 =?us-ascii?Q?RDbUC7dNkF8LztXfMrrvACJDCjAgMw7pVZFeAAglksNdZEa4wHdBBK0FfQQB?=
 =?us-ascii?Q?uF4bkbHOVaS7G0MQ0RoZ5QFTXy9YIQWByRLTqIHA3xQ+UhA3MDYwEeJxoY7O?=
 =?us-ascii?Q?IHVtoQYNwYwTc3V3Mf7T4XVJIGzBNA/6Ibm2tuK2EDyvXXm1aKQ16rPtUxoA?=
 =?us-ascii?Q?MVxny0VMhN+E2xyiWJHcfjbHoH8TdMhjGoFzuzZknPX+WU6crj5pYnVO6L32?=
 =?us-ascii?Q?eH6UW2XEFbUeLkq3boBJUCNeRjMv9WM/wVOKepW9pVOFr6+YWM2xFK3cVslU?=
 =?us-ascii?Q?DGFUtwJ6qv4nMe7au+VWpcShgCnx2kXDSsptal91PTVd7Eg/iTBkDNRKZ3fS?=
 =?us-ascii?Q?9FQnd/pEp3t2gpIWcSHOJvRbwUFKvdmWzrwmmgLU8pABxOutjtx8f8v0+h28?=
 =?us-ascii?Q?WVka8xo8vUKODgkkCxxAGUlPUnsbp82pTSuTVUtt8G3fccezKq8SbJBATA62?=
 =?us-ascii?Q?7mBTbppZTsJBA7J3838Q9iHbyPqCnTzxG5hQI6SmYI6thQ=3D=3D?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 370df2e8-ddfa-410c-430b-08d990d3bb91
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2021 18:35:31.1443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wNZ7GYfqPgl7AiWGED8E7BXhBENM+CBTBrjiiaZErMl9k2DZVRj2GbUPVB8SBl50
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAP286MB0876
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 03, 2021 at 07:25:29PM +0800, Hongren (Zenithal) Zheng wrote:
> For one single patch FILE containing both deletion and creation
> of the same file, applying with three way would fail, which should not.
> 
> When git-apply processes one single patch FILE, patches inside it
> would be applied before write_out_results(), thus it may occur
> that one file being deleted but it is still in the index when
> applying a new patch, in this case, try_threeway() would find
> an old file thus causing merge conflict.
> 
> To avoid this, git-apply should fall back to directly apply
> when it turns out to be such cases.
> 
> Signed-off-by: Hongren (Zenithal) Zheng <i@zenithal.me>
> ---
>  apply.c                   | 13 ++++++++++++-
>  t/t4108-apply-threeway.sh | 20 ++++++++++++++++++++
>  2 files changed, 32 insertions(+), 1 deletion(-)
> 
> More notes below:
> 
> This patch is a bugfix hence it is based on branch `maint`.
> 
> This bug is caused by a behavior change since 2.32 where
> git apply --3way would try 3-way first before directly apply.
> 
> Interestingly, if the deletion patch and the addition patch are in
> two patch files, applying with three way would go on cleanly.
> 
> As indicated in commit msg, if these two patches are in different
> patch files, write_out_results() would be called twice, unlike when
> they are in the same file, write_out_results() would be called altogether
> after all patches being applied.
> 
> One way to fix this is to check for this kind of conditions, which
> is presented in this patch.
> 
> A side note though, this kind of checks and fixes already exist
> as indicated by variable ok_if_exists in function check_patch().
> See the comment around this variable for more info.
> 
> This kind of fixes is really dark magic.
> 
> Another way, which I do not adopt because it requires major refactor
> but it is more clean and understandable, is to change the way
> write_out_resultes() is called, namely instead of calling it
> after all patches being applied in one patch FILE, after each patch
> being applied, we write_out_result immediately thus deleting one file
> would immediately delete the file from the index.
> 
> The man page of `patch` says: If the patch file contains more than
> one patch, patch tries to apply each of them as if they came
> from separate patch files. So I think this way is more standardized.
> 
> However, as also indicated by comments around variable
> ok_if_exists in function check_patch(), consequtive patches in one
> file have special meanings as endowed by diff.c::run_diff()
> 
> I do not know how to handle this, so I just send it as notes.
> 
> More comment: this problem or this kind of fix may be related to 
> https://lore.kernel.org/git/YR1OszUm08BMAE1N@host1.jankratochvil.net/
> 
> diff --git a/apply.c b/apply.c
> index 44bc31d6eb5b42d4077eff458246cde376cb6785..3fa96fcc781bdc27f66a35442f27972a0e84ea77 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -3558,8 +3558,19 @@ static int try_threeway(struct apply_state *state,
>  	char *img;
>  	struct image tmp_image;
>  
> -	/* No point falling back to 3-way merge in these cases */
> +	/*
> +	 * No point using 3-way merge in these cases
> +	 *
> +	 * For patch->is_new, if new_name does not exist in the index,
> +	 * we can directly apply; if new_name exists,
> +	 * according to ok_if_exists in check_patch(),
> +	 * there are cases where new_name gets deleted in previous patches
> +	 * BUT still exists in index, in this case, we can directly apply.
> +	 */
>  	if (patch->is_delete ||
> +	      (patch->is_new &&
> +	       (index_name_pos(state->repo->index, patch->new_name, strlen(patch->new_name)) < 0 ||
> +		was_deleted(in_fn_table(state, patch->new_name)))) ||
>  	    S_ISGITLINK(patch->old_mode) || S_ISGITLINK(patch->new_mode))
>  		return -1;
>  
> diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
> index 65147efdea9a00e30d156e6f4d5d72a3987f230d..14bbb393430ed57a236d25aa568a0fdc6d221a6d 100755
> --- a/t/t4108-apply-threeway.sh
> +++ b/t/t4108-apply-threeway.sh
> @@ -230,4 +230,24 @@ test_expect_success 'apply with --3way --cached and conflicts' '
>  	test_cmp expect.diff actual.diff
>  '
>  
> +test_expect_success 'apply delete then new patch with 3way' '
> +	git reset --hard main &&
> +	test_write_lines 1 > delnew &&
> +	git add delnew &&
> +	git commit -m "delnew" &&
> +	cat >delete-then-new.patch <<-\EOF &&
> +	--- a/delnew
> +	+++ /dev/null
> +	@@ -1 +0,0 @@
> +	-1
> +	--- /dev/null
> +	+++ b/delnew
> +	@@ -0,0 +1 @@
> +	+2
> +	EOF
> +
> +	# Apply must succeed.
> +	git apply --3way delete-then-new.patch
> +'
> +
>  test_done
> -- 
> 2.32.0
> 

Is there any updates regarding this patch?
