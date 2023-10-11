Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550B8CDB47E
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 20:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbjJKUZn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 16:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbjJKUZl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 16:25:41 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48CF91
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 13:25:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMHPEwkF5H34QUhcYr0NjMU0SeK691LevRBPL5g2dCTnGMA8X/zRseJlLvJh1BrWQ3D454jOxDbUwFkBt8EmmtY+C+PTkjpMY8vfFhGNPpTvK7gluvoMOJh3nQLtTjKXF0YuwbIqQ3SOZ2Ve2LxLLB+lA8HSjOdCEM2u6TxPbIWrAQPc1EDoZjT6uYIxoWmuRFqBTlSBmc6nsQ9VUDJvwQxI6UJSu7jETAnNmF7iQMJXDfyHEtWCK2J0BCSupoGPj2pzM/mAXXGOHIiXnez8aNkGsvL7bJI2AVO3BtX5ib+ZygzBrjzqHaRTLqelcQ5ZiXMR5IxGn+vu3nUfQMLSZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ex6UyP4P4wHVeLqiKyci4kEcqlgGkAWU3Vv0/QYX6Q=;
 b=D4VtSjR3AT1j3SfdA92nPHP1mScG7ZA3+E9GfrXiJp1hGVCHGcvot9X4aU4qs5CkQdSRy8bgQ3NkUr7lDS40FaNCVCnVO7Zd9tLAF5ZaVXwUTW7go8eRs61NF6/aCxni5CxT1MXAS3qioZm+8HBUHpxbYGrF2f9ytldObQumm4rV6ImfGwlVMKf8r8OklzuUE9RPwgRakn104ocAfKVtTKCusTEIf9tpzfC5kuFuTqec2IWSHVN8Go0YPGNms03dMzNJ8Aj7opRKlJ5vVDdareAjQqV7Dl7hcIsIQJjP2mvdSa0mhMDiAMNs9LtT/wntGgAUEWDyBnrlC0MUs2BQug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ex6UyP4P4wHVeLqiKyci4kEcqlgGkAWU3Vv0/QYX6Q=;
 b=XLV3o0/47G+st5YL+eI8xen0ekzEf+s83xSi42rXpnVT+/dM1k9DJT/1PUQnJJpu7hrBXwRtHU0o74P/qGV7rlMwzfbeP2Kfz6Fk9Oal6dkjBEyuRoiiT5hnTDcnF/iQ762SrMlVtJu5ALXbMj9eNS/7K+8Ulb9klJ2GOJp9yVc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 CH2PR12MB4149.namprd12.prod.outlook.com (2603:10b6:610:7c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.37; Wed, 11 Oct 2023 20:25:34 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::1cfd:3535:273a:8097]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::1cfd:3535:273a:8097%7]) with mapi id 15.20.6863.040; Wed, 11 Oct 2023
 20:25:34 +0000
Message-ID: <a62743b2-d50a-4138-bbd5-d70653dfaf09@amd.com>
Date:   Wed, 11 Oct 2023 16:25:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] send-email: move process_address_list earlier to avoid,
 uninitialized address error
Content-Language: en-US
From:   Michael Strawbridge <michael.strawbridge@amd.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>,
        Todd Zullinger <tmz@pobox.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>
References: <ZQ1eGzqfyoeeTBUq@debian.me>
 <20230924033625.GA1492190@coredump.intra.peff.net>
 <ZRE6q8dHPFRIQezX@debian.me>
 <20230925080010.GA1534025@coredump.intra.peff.net>
 <ZRGdvRQuj4zllGnm@pobox.com>
 <20230925161748.GA2149383@coredump.intra.peff.net>
 <ZSal-mQIZAUBaq6g@debian.me> <95b9e5d5-ab07-48a6-b972-af5348f653be@amd.com>
 <7e2c92ff-b42c-4b3f-a509-9d0785448262@amd.com>
In-Reply-To: <7e2c92ff-b42c-4b3f-a509-9d0785448262@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN8PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:408:70::18) To DM6PR12MB4356.namprd12.prod.outlook.com
 (2603:10b6:5:2aa::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4356:EE_|CH2PR12MB4149:EE_
X-MS-Office365-Filtering-Correlation-Id: 64386b0c-e97d-4d7f-8f9e-08dbca98391a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +jpjE5HrqV8rSygMZt734katr+tL1MpQw3cE0ZFutaXZZpjDJ2LDiMWWECZymhvNVmrwbs5C1+IGRm0+GwEUldzSyXH23hAiEshnoDlFbCWD3JFyUaAW/wUZAmGQYHjKujirt4fLgZmCLXeuWGmj6m9idnRrMAIbINfsVaxq88fYaAuzBpPXK3nrImNZM7d8KyCwt6ZqfeN82DRZySiPNzZHzPE+urWCnHwNBIw1JCRmjjcljVskie/cRvtGtArGBQbwDtDgWaAXyZKtpAkTBw9iSOGef2JvfdMXr1favrgcI+EQs71hud+C2fCVVTddipag27K4pb5LzSaiy/ntiMnBvRH7/jHCi1Mt+LuGw0lG1HiqcRbPKPmP99Ku1Fj7gco4b0FCZDV7sRTq3UN3AnVsnT8cMHhBw3envTB12sVB7bPQAq5TXW17sR2n0PTVosTyfUuPU7S6C7v0I7+JozLX0Px2N8zDtYOyetNlCwPjEKGXuDKAwm6JbjXvCtjehyOwI6iVVzPnSnDlvEPbDD5FpXn8XGMpETx6f3vnyOD2+la5yLL5eSSxNkxZWhIXmyMyKy9rSKZlk2AVk1FpoSjSJ84Tg1Kn2DcqHPYMQnCvxxTOaL9SkRanuAR+a3GnCQSWLCJoR835YJJ0xt5FHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(31686004)(6506007)(53546011)(2616005)(6666004)(6512007)(36756003)(31696002)(86362001)(38100700002)(316002)(2906002)(44832011)(41300700001)(478600001)(66946007)(26005)(83380400001)(8936002)(66556008)(4326008)(5660300002)(110136005)(8676002)(66476007)(54906003)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFlMMk9BcWlXS0xIcG8vZThVYnFBTlVTdm9wODBtS3M4UVBvTkZ6MVl5UGtW?=
 =?utf-8?B?TkExZjJ3SG1Ha3Y2b0cwVzM3WEg0VlRwMjVpZmRkbzBTY3JaOHQ5dXlRaHpY?=
 =?utf-8?B?SFF0bTVhY2VVejUya0ZWSUxsa1Q2WGNURTU4eFFDV2xCR3JOVkJmRHBEL2tL?=
 =?utf-8?B?anlrL2poVUViOVFsVGtWUm9td3ZITVpYNnhsSlR1N004SEU3WlFHb1NRV2Rk?=
 =?utf-8?B?c1RXMWZnV1JTeGFKMTV0VXU1enlVY3p0K3RjenhQOFk0K3N5THdyWmxhYXhG?=
 =?utf-8?B?NVhIK1BPWCttMG1CUldldjhpYXBqM2JlbkxUSGFneU53Q1UxNWkrM0k1ZCsv?=
 =?utf-8?B?SUxnSkR5MGl4M00xUTNOSk9CTk5mOU1FaDRRdWJqZUgreElURkNVOStlSDIv?=
 =?utf-8?B?Sm9VWC9FL1VmYUY2dUZWOVBCQjRtUTNHTzRXdkN0bnY2VkVTbjRFQXR4cWk3?=
 =?utf-8?B?Q2hwazNSTDJIWWIyMkJEVXZGM1Z5WHQxdkVNRExydHNuaHFCME5xYWc1cmo5?=
 =?utf-8?B?cHlwM09tb2toTTllNE94aG4zeTJlWUJpcTc5ZXlZTmhDSTlRL0hRaXJNeVhJ?=
 =?utf-8?B?a0VURHE3aFNyOGl4TEhRVjQ3U0dkb3pTZ2xlTTNLODJmK0g5QXJaZERLdTNj?=
 =?utf-8?B?Uk9KSlYwdGV2MEFxZnBIN2VLQ0IzTmFSbE53UXdUbUJSdWZibmV2blNnclNU?=
 =?utf-8?B?OWxZNno4S2NMb2Q0c3dQVDdmd291a3UrZ3VQcXdQRDdCY24ycUVjOVRaTE5Y?=
 =?utf-8?B?T2NLZkU4QXBtT3gxMzI5dThtcjlPQXNSRDA4Y2ZHOERKOGdiOGlhcE40WGgz?=
 =?utf-8?B?QmgzNlAwVktHbEVabVBVQzZDMURGY29qekUyNDM1VkNEWkZKU1E5ajRRbG5C?=
 =?utf-8?B?T1NWUVpJM1hwSUhxZEVhaHg4Q1JqK1RPQXBJVXlsdHV4WkVnVkZ6RGVUMWE1?=
 =?utf-8?B?blVKdi9xSTE2bWdzbHpLY3hiNTZsRXJETTlGQ2pSdmVaU29lRjZTM0dXaUhO?=
 =?utf-8?B?ZmpabUR5aGtDb1N3VDF3eGF6ZWRKWDdtTFh6MXF1MFF0enJ5dzhCbDJuemVy?=
 =?utf-8?B?enQ5cWtrR3hvMWlJK1JEY2d3NUE3ZEdFWSthQzBGdW50SHpnNTRxVytNQ25X?=
 =?utf-8?B?bkVDNWN5azB4WTUva2pRK1h2bXk2WTluNTNsTTNQa2lmdlUrODl3Vmh3WVAr?=
 =?utf-8?B?eG9VdUpDWjczWmpqWGFzUldaL3VCbnlOd1NUc0xhbUI0d1pzbzNpZUhQZDlT?=
 =?utf-8?B?d2VTWS9FUk1yR21XZXprSUk5OFcxa2lFWng4SzRHZHcyN3YxSWtULyt6dDNF?=
 =?utf-8?B?cmpiQ0RvODhCUVR1cElOZUprRHIveTBYMEhjK1Zmdm9wWFJDZXFvYjhoZ2lW?=
 =?utf-8?B?OXFpSlIrL0w4cEpHM1RydlBMbUp0U1pXM08yZWZTZnEwbmJHUmYzM09wTjVz?=
 =?utf-8?B?NlVSZFhvMERJV2l4Y0hGWkNVMDhVS3ozOHg3ZDVrQkk4QTZBZ0tTQjZ0YUxE?=
 =?utf-8?B?cGFCTnJkOXhsbm9ES2dUb3ZMcnlpRG1OQXc5WGloZ1NwQUhKUVdFTXdrajR4?=
 =?utf-8?B?RkI2T2FCa001U2E4WmVaZ1VmbGxJRkdjMWhFNzRJd3ZTWE50dnlpRVRLYVhh?=
 =?utf-8?B?cVJqTFkxU1FNTzZ6LzMrakF3emV5MFA0UkZwMWozR2VTWnN3VGtZdjJucEQ0?=
 =?utf-8?B?SU1sN1U2eWJQRWxqMXhwekMwYVlyQTZNa2taaXAvYnlDckwzM21RaFhCSmth?=
 =?utf-8?B?MEs2L1Z0N3hCcnU5cERnK0dSM254VEhqRUVVMnVQNkJZdnZEbm5TQkM3djRP?=
 =?utf-8?B?aVl3NlNQSXJaaEdiM3B5ZUZlN2dJcXFwaUEzalc1SGtRZ0dhQk1zcnpNSEY5?=
 =?utf-8?B?S2d4WVJLWGV6aG9pR0k5bGM1Rm81eFRXMHBRVVcxeDRMUjBQL0ozVUJqZG5n?=
 =?utf-8?B?aFdKcTExbGIzcGR3Vmk1SFlSQ0VmYUZ2aVBFZ0VjNlZnU0RKc1NLZ2FGSzJs?=
 =?utf-8?B?ZElnWnlxQmV3NysvaVptZmdLR3QvWGFBc0lDVjUyaTViMis2Z3NxNE9Ycy84?=
 =?utf-8?B?UXBCZUtWQlhISGNHdlBkL3NNRGhoTVBsVzhqUmZRaFVaUVhmWGRyWWttZ3lD?=
 =?utf-8?Q?Apd7XTIf5cQPkz6u4sFyoxyw9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64386b0c-e97d-4d7f-8f9e-08dbca98391a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 20:25:34.5981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y4KJyoN8IeowvBqOVZShHunK7gI1ejxTcDhqIK1HGULPDjWnFxlAlxNyaWjc0PZAUJ7RJ0oQW21y7hSN1yyxqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4149
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bagas,

If possible, please try the patch I just sent out and let me know if it works for your situation.

Thanks,

Michael

On 10/11/23 16:22, Michael Strawbridge wrote:
> Move processing of email address lists before the sendemail-validate
> hook code.  This fixes email address validation errors when the optional
> perl module Email::Valid is installed and multiple addresses are passed
> in on a single to/cc argument like --to=foo@example.com,bar@example.com.
> ---
>  git-send-email.perl | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 288ea1ae80..cfd80c9d8b 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -799,6 +799,10 @@ sub is_format_patch_arg {
>  
>  $time = time - scalar $#files;
>  
> +@initial_to = process_address_list(@initial_to);
> +@initial_cc = process_address_list(@initial_cc);
> +@initial_bcc = process_address_list(@initial_bcc);
> +
>  if ($validate) {
>         # FIFOs can only be read once, exclude them from validation.
>         my @real_files = ();
> @@ -1099,10 +1103,6 @@ sub expand_one_alias {
>         return $aliases{$alias} ? expand_aliases(@{$aliases{$alias}}) : $alias;
>  }
>  
> -@initial_to = process_address_list(@initial_to);
> -@initial_cc = process_address_list(@initial_cc);
> -@initial_bcc = process_address_list(@initial_bcc);
> -
>  if ($thread && !defined $initial_in_reply_to && $prompting) {
>         $initial_in_reply_to = ask(
>                 __("Message-ID to be used as In-Reply-To for the first email (if any)? "),
