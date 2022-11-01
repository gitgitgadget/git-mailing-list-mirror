Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7CAC433FE
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 13:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiKANzR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 09:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiKANzP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 09:55:15 -0400
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2115.outbound.protection.outlook.com [40.107.116.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD001929A
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 06:55:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnTv3+l/ljyPctEgi+w/NONOI0PCnQ1lMZ122cUEN5tb1fYsBSwPWDEklN+nBgw7v7fC8ikmTmzTNY53DvXEjwUIkrH+EsVS0+o5ySImkxGpFaLyPqH95p+/DjJ4IBtIMMP/6VlW0JU0RD861UxmumpHJJLYplSKDnKdLamyqs+VNEP7BcUa4cCd0NZEaWnxUkrh+KcTLxKNavLwZyWIrixv1oCIGKxPqPHlW8zw6n7YSMWazsflmeSSOll3R7aHT6oguJvZFn2q8SPSMk/2oZghp8Z9U10LjenLYOW2ZUOKLxv6eKX9iLGod0Dp9+v8TU9kTOi35e0+92dAeNNY7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v60RmpbHIVrseM8UjwSgU2j/ji75Lpm53RUx+Znif2U=;
 b=Ybjbe7M8bcvzP42m/WnGwYeAb3ttSveNZJ/xdvNwkvl/e/gSfR/9T4V63mhDWlExMaV4XLs4ZyD/wX0CsdtLjtqZvM1ZpVCRlO99lNpyPOhAZw+95ONeJ+5MGyiDlbauUXS9RPDK/vQjn9aFC/ADRbfzUzje4+0z4bLjN/Y0eHOwuSZLf8Sb5K3DNY6g8UlPxHYsfW5Nxuwc9ShiWgxmSdfa/kq8gWS1pEppG3hDkp9HLWv3PTVemS+/ly/nY8p0Vri1rAyvSQajGNwvmapX1Kcn4RdDLf43Elu1MZFRLlRdLSmHKZ7mfOPJuYpd+oGhwXNKncftayM2PL49CDuR9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v60RmpbHIVrseM8UjwSgU2j/ji75Lpm53RUx+Znif2U=;
 b=QCmvZtRz5LTGx1TzeewGgcewjUV+RkKSyBzcpCkpTc9kOVCMs9Qb2E7/RxH3mErQLUGXLD8GkqtVE6Ex441ArAeR9ISliA2+hW0Ew7lZF76boLMuYk0OQBk2v82x1Lk6p6y2ZRf+AOWrY1VR44RlsLjYQlZpzPv660kbtE5vwvDFDgZdpizjzuz+WnE5qAPdRnGiqbKooCbyn9aFTIfvJF6ht1ZeMHvEP9WfrJ3gKuBHinCPkB2Hjzwwyr+nSl2M6eZDtUllLEjs7xbEhhpYtx+Asphd0up9EGG+lgHJGs6ZaiHedJ2b99GY6LvC6ee2D36dSmsNhRlPPhj2Yek3NQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xiplink.com;
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:30::29)
 by YQXPR01MB5833.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:3a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Tue, 1 Nov
 2022 13:55:12 +0000
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::1400:5589:c949:bb7b]) by QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::1400:5589:c949:bb7b%4]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 13:55:12 +0000
Message-ID: <c060312e-0d35-8439-85dd-920b172c90be@xiplink.com>
Date:   Tue, 1 Nov 2022 09:55:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: Consist timestamps within a checkout/clone
Content-Language: en-US
To:     Mark Hills <mark@xwax.org>, git@vger.kernel.org
References: <2210311614160.25661@stax.localdomain>
From:   Marc Branchaud <marcnarc@xiplink.com>
In-Reply-To: <2210311614160.25661@stax.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0136.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::36) To QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:30::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: QB1PR01MB2451:EE_|YQXPR01MB5833:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e0c2784-a80a-45a6-0853-08dabc10b271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M37G/KaeHkkWThsUk0an9YbfkomsvySuEW3xaVPgEtXLL5THrDqFEQJi6NUyVMpq5mduTHKJ+wMn4TGW3vMajX6bHE3SETfGIE+4p6avmM0yo0j3jeAsh2m257UiSw+SVOnRW0024yFb3qE2Yr0c+mP7PPeJJMsDKBHnov3fDSW2c/IOz0oqASDm2MDS0Iyqh82GiNWVFuz8YzqOXinQ5CMaLKoT8sDOaJODn5OFehvMH3/o96gTB6ZLt2/NlVy+cbBKWG+hcaZwL5fnu4dhv/FqrFyX/fM5oWKl76tIckew8oj6n5Jwmju4cqr6IUnnjeyqsNGazbJ6Nas3WDqqN80LqXY/TfkSVMKgmjO/l9E8FAyV+tZfrQXNYIZqKqmN5D8yNRKBzP0VM7Rge87dzjWLvsK9CZ56cIweWiJ4EdizheqCZ0QIOIa0XkAnb2kDq36Gk/Cv6wLihfnypVULhF25oZQkw1QWWczx+jnogyJl/WhH/0bN/xEfUFEZ302IRiiwJYJ0qzsd/Nbd2X60DnlRd+3AtHCAyoMMHBbFkvYYrP7/QniQaFKOTzFwlMxJfQCB5xCb7S0ZtmnQkw78/o3CFOM7zycY1+cbLUILPKV/1PG7Ny2VSpWttVa6X6mgivkJxBFHmp6G4/XJkWYYdQk+WEszhWIS7iRwKn0KvpMzK0xi3EmmI0aAiEvpHPeoc/A4gsaQ+2PAOOBy6MyFdm9uy6SwFlOb0VrNY3SE00qA20Rmrcu790mcm75LEQa7sPTe2fc/zGaeyA6D6U6MRPsIK5WMFjIr7vPekLJnjS+2PyTe82JEXTYDo5QwDi9kMNDvvrGbg8rrZGa+1B0JNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(346002)(39840400004)(376002)(396003)(451199015)(83380400001)(86362001)(38100700002)(31696002)(5660300002)(2906002)(66556008)(6512007)(26005)(66476007)(66946007)(4001150100001)(41300700001)(8936002)(53546011)(6506007)(966005)(2616005)(186003)(6486002)(8676002)(316002)(478600001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0c5V2VUM0o5M09xMlhoeHh5N3E3WmNzbXFJaUtFMlV4U2tmOXdvQU5jRkEr?=
 =?utf-8?B?V1o5ckNNUG9ZcGJWckg4MW40YWtMUjl1emVXUk9iNko1VFRvV0t4MW1TMmg1?=
 =?utf-8?B?NUMwWUZuWjJKQXh0eE9NMVBJRzU3Uk5sK1BxcmFham4wRUVIdVdwUDBGdm5N?=
 =?utf-8?B?dDlscStOQ1FCODNCSjVEbDNGMTBlcUlobit6MkN2VHV3T0VkdVZScm8wdVQx?=
 =?utf-8?B?QWZTOU9pU3JGTWlBa2owRTZRYm0zY1lHaDh4SExWUnJGNFRvZXlXNXZIaHFn?=
 =?utf-8?B?eVlOV2tZVnpvNVFMeEw1b3AyUDhuamFneVNMc2dvTXFreDBBT29MKy9sSEVV?=
 =?utf-8?B?WHdhdCtSQWc2UXZZeWJWQW1ET05KZnJiM0R5cStXV3ZpNmJWWHlLdzEvcUx4?=
 =?utf-8?B?VHV1V25WQndLY0tKSTcrUXlVRlp0a2syYnZwNEhSazJtTXFvVEI2a05YYXpx?=
 =?utf-8?B?S2R0NXVtenYxWGxSZ290MmUrcWVHKzNTK2Q4bnBTSzdzQUI2b2QrLzgyc2Zq?=
 =?utf-8?B?QnBRa3JpZ0ptSTBDd1dVOHJuV1JIbEE1OG1oOTEvM3RMdm0wU0NrQ3JWWlFS?=
 =?utf-8?B?YmNwZG5Lc0RHQ1dKcktubGxqaVVud1RNajdycGVGSkRuS2o5b0hZb1QzOWFR?=
 =?utf-8?B?bksxYWt6R1pKWjdzcVFuei9HRlNaZzZYNTdDWGNuUVJML3NrWEthMFJqcnpw?=
 =?utf-8?B?aEt5Nnorck5HRmxBV3FSNkpYaDRYVXdUeFVMUXRLcGYycGphZVhnNzIrMmlT?=
 =?utf-8?B?QlVsa2hqQ1VNRnJaZHRWaFZVQUpNVHVyS3JNcnJQUXpIZGxwZldWdE4zd2lv?=
 =?utf-8?B?V1JsQjlLckVmS3FYRnpleVZmVmdSZUdZSHI0SFlkdHFOSmVjS09iVmVyNWFy?=
 =?utf-8?B?bkdPQnR6cmVGRU1HZ0N2UUQ1bDZqODRjNE5pQ0Zqb1hPa1hIdUN2YVE1WjB4?=
 =?utf-8?B?WUFuT25UNFRndU5UUk5pQlorK2FFYmtPS3h1b3hYYWdvdUtQU00vdUNzK09J?=
 =?utf-8?B?WVc2b1hHc21JYlBiSUlOSitvenJMc0Vhd3Q3a213alJlTzlEQ1dvZi9McjZU?=
 =?utf-8?B?em5TSHN4TU9iSDNwQkV3Uk55czVRWlM2K3Z2M2paUlJCRVZRZmVCWmQyeDdG?=
 =?utf-8?B?SFpXRzBGN3NaZThSaDUzRGw1ZFUrMW90MDE1UGxwQ1drbG1iVkVFVVcrcW1n?=
 =?utf-8?B?QXdkLzRhQlFnMzBsOFBlSTBZRW5RY2FoNkNwMWV2clE0cjdibnlUNW5mZkl4?=
 =?utf-8?B?dk55MSt3U3doNXNCWGtSd1dBV2JBUTdFY1ZNT1FqSDh0bS94WS9XSy9jeVA4?=
 =?utf-8?B?SnNaeDhhdzlDajk2R2I2UUxrMGhuN2xNYnBnbE85NkIwN1lXdWIzQktRcW9M?=
 =?utf-8?B?YzV4TUdiWnZQNW1xK2lnRUI5NHlUcHpXdmJPZlIrb1ZyQXlHRU4ySGlBOHRz?=
 =?utf-8?B?cUcxTXE5UDIzNWJocXcvN2VqNHBkVnJtTWZpeVpaN3lYL2NVc0x3NFZWOS9u?=
 =?utf-8?B?VW9JQjZyVTdSSlVjYzIvZUNJMFVvU1kyZi9SR2hzd2RsUVpoVXJpWDFNV1Fj?=
 =?utf-8?B?NGtreVZ3WWZqc2V5NDE2VG1JdU1sSmhveDRxSG5XUjE0V2UwbDZHUEh6REhV?=
 =?utf-8?B?T2lTenBNZ1c2RVIwVlpLbEtSaG8yWEs1RUh1MGVBUmwrQzJmbnJrMHo3ZlpO?=
 =?utf-8?B?TXNiNGg1ampGa1puaVkvQWQ1NmdtTEU1OE9sR1dLSVZFYjBsOXJ5YTRkV1Y1?=
 =?utf-8?B?SXNsUEJud0hHcEJoc1dhR2Q5WU9rVmpzZGxjWFdNaVZXRVlnUU5CL3lpazhK?=
 =?utf-8?B?S3kxdXE4VTRKbkljaUFFVVg1QnhMeVpET0dZWGZ6SDF4ZHBSdGxPaVRkdk1y?=
 =?utf-8?B?SXNWZFY2L1RLMTJUcmtuaHd2QlY0eHVuRFRRUTlTSi9HcHFvbEQ3TkJpVEIv?=
 =?utf-8?B?KzRNb1RSN29VM1dMcE15dENWSkRQRVFiQzZIeWFGdkNSUHpyOFFWMUVlWFB2?=
 =?utf-8?B?MHRtN2t2c3RwS2YxYTkwVFBuRnRVTVBRcUhHelRQVC9CK3VFcUloQjNNV2RE?=
 =?utf-8?B?cnZKNTZISE5qMnBxUVJia1hmay9GeWk1OERLUT09?=
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e0c2784-a80a-45a6-0853-08dabc10b271
X-MS-Exchange-CrossTenant-AuthSource: QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 13:55:12.7628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fuP0Ryh99U7dFedWYCDuCA0LKVxtMvYLGcn8mHO2Q/QM3B8Szv/WmAUdCVC4m32f5OwsY1KVEEEogsenFgLelQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB5833
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 2022-10-31 15:01, Mark Hills wrote:
> Our use case: we commit some compiled objects to the repo, where compiling
> is either slow or requires software which is not always available.
> 
> Since upgrading Git 2.26.3 -> 2.32.4 (as part of Alpine Linux OS upgrade)
> we are noticing a change in build behaviour.
> 
> Now, after a "git clone" we find the Makefile intermittently attempting
> (and failing) some builds that are not intended.
> 
> Indeed, Make is acting reasonably as the source file is sometimes
> marginally newer than the destination (both checked out by Git), example
> below.

A fix for this was proposed in 2018 and dismissed [1].

Back then, the problem was that as Git wrote files into a directory 
sometimes the clock would tick over at a bad time, and we'd end up with 
some files being "newer" than others.  This would sour Make runs as you 
describe.

Nominally this is caused by putting generated files in the repo, but 
many times that is unavoidable (e.g. you're forking an upstream that 
puts automake-generated stuff in the repo).

IMHO, dismissing the problem back then was a mistake.  At the time I 
advocated teaching Git to give all the files it touches (creates or 
modifies) in a directory the same mtime (e.g. the time at the start of 
the checkout operation).

Instead the decision was to do nothing in Git, and instead let people 
create their own post-checkout hooks to touch the files.  I (and others) 
argued this was inadequate, to no avail.

		M.

[1] https://public-inbox.org/git/20180413170129.15310-1-mgorny@gentoo.org/#r
