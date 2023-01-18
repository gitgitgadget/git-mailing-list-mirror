Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151DEC004D4
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 09:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjARJSJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 04:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjARJOm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 04:14:42 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2043.outbound.protection.outlook.com [40.107.96.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E185F34C2C
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 00:31:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2YXkZyRimqW6J+evUOcYD0e2gkq1qsjI73YnOn41I1biCaZ0jh8C+9dglrR7HKha89q09Aijb12PQ6gXXuLpKg5m7TKl6jETvqqPSwK9Zgdf3PWjVseOccBP1MeUVca6Z+7oHP6XvMU6/AsNbN+DOD/MlSRvO+fZFW5jHCJ8SOIkffyFlKjjzldB0izF83FOaBaBXkrFKwSxTRWWKze2EB/qFKhkSK+LezecMzHKV1yy//MRhjvKE65txH+PTgFI5enMiAeYoiDb7G+8TlpqK7y0pzLqO9M29bohdiyT2LL3WV+VIXNRRsqguuKKk+yjNTVIdMDO749P2g2yTSbKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eO/Ya0xrzdTMngJ45zz9bNt2MGmxkK9ez+b/JOoMqmM=;
 b=WjAzwBqa9nnRWpz/fJW5QTMnG2yXkv+EnqFHEBSc9KhfYZ4ubuHYwiBC1cc/UOQFXflXK4kZxqQ9ImYFxPbpIgUlTkfmnyeV2Yi02VatK6g0gvizTtYCohnPCY5/n3BwK08FCIh9eY5KVC4fU55hWVNiUKSnGqkjQsv4tZKOdoMps3/r2CP6HF1X0Bcn7get6IacZGAzOcoB+bQkTe3214k9i/AeHALKtyAKKOYpUE8He0fLFp+uDt+RIZQCYLG4Ckw1B07Kci+iV5j4T/C2w4kdkRavYERJFokfD8EIhcKdacL9kuOW67Ie2JEXhPzlO7vjBrloyWRKnEDx74iXTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eO/Ya0xrzdTMngJ45zz9bNt2MGmxkK9ez+b/JOoMqmM=;
 b=kzpnV4EjxHWxOFAWVUoFE8CzijCgkG7JQeUUVQ7ljzxqow7e4PE63r6YPvP0mCZsVbngpGw0xvS7bzFoPn204Cbt1xWzuevTnlY+Fx05Myh4utvqrxHEUDr863gPZkTz+JHVXolX8A8IR9D5oJQf0Y3OCI8OrhFJXmjh86fTtvQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 DS0PR12MB8042.namprd12.prod.outlook.com (2603:10b6:8:141::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13; Wed, 18 Jan 2023 08:31:42 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::4df2:b32a:e628:c57e]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::4df2:b32a:e628:c57e%7]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 08:31:42 +0000
Message-ID: <71623e1d-805d-cdc7-d872-224821c1383c@amd.com>
Date:   Wed, 18 Jan 2023 03:31:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-CA
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <20230117013932.47570-1-michael.strawbridge@amd.com>
 <20230117013932.47570-3-michael.strawbridge@amd.com>
 <3a2d4559-fce2-80f3-bafd-5eb8ac1a7eff@amd.com> <xmqqbkmxbort.fsf@gitster.g>
From:   Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH v6 2/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
In-Reply-To: <xmqqbkmxbort.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0064.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::33) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|DS0PR12MB8042:EE_
X-MS-Office365-Filtering-Correlation-Id: 5332f525-ad7e-466e-99c4-08daf92e6cf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U2oAu4HTQddYxWXwyYslfnGIAaOxyZwJuq7guh0SjfRhHVbVQCm8UTH9wBfKNtk/o8NbBtiB9By/XwBeb4vmhcZUfrJjOyPPLXh5emVJKLFm909xVcB/YDnUeEMW2fF/RWSJNpy4vzXfgdSvHOr+TyfjomwG/nHvlK053e1UidKKk1H/GOKRcUj+2eh6IZivJ9xF+Hm+c00VvLXZLCBR4Is1EgW6Vcsc7VG/rUyS3jp6fe+cxUzLaMsRGnE0BpbRWa9hbfP/Meh90jSEGTNX8pYrke8f4PrMRMgewfq4BN+TpvFilQLifWehTdnFuGQSlNzalupJSHuTRrDfg+pjnv9U7tcobTLDXktX30JITX+Ot5/dNFJBf/54CUwcmqJfsX/Gfb+Ew0Az3TlBW/QMxT4BZz/LJUZD9/oCUdpIpk9f3+NoSeIFj1+b9k54jFjYpTnGlNdVM8y4vDHycgidV6GEOWacis+LNYrgZjdi6I256HrrErQXZsjNb4LhHgBBstrCnWK/Kxqrex1BrGPFB0BFlriVrPAKycx1zR+eLGp1WHmZAdEyGgWiAlMgMNvVvhOHnEYozOfiO8jY8cvBl/suQROzeyPhul+rHdha79/vyH2p8VVS8s6BuDDDS4J+rdOg3YLj4y+/IGnt/ZmaLLgEKKSaLoM90Srk1HGDPAxLMvqbhtIswpgMnj3wiv++GNFxMxHzni+bDxmdp0mbjKLUqyjZEIfMdN0OyQ6HnM0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(451199015)(4326008)(6486002)(41300700001)(38100700002)(478600001)(86362001)(2616005)(54906003)(316002)(31696002)(66946007)(26005)(186003)(5660300002)(8676002)(53546011)(66476007)(6666004)(6916009)(6506007)(2906002)(15650500001)(31686004)(83380400001)(44832011)(66556008)(36756003)(6512007)(8936002)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHFwaWl4ckJiUmVNOEFpeVFwNWtVbE5mVkFWNUdRd0NFVnhLOXZHQnhEUnpJ?=
 =?utf-8?B?MXNMTTRXbWJYWWVzWGp5bEJsQ3Y2SXVCWnFkOU1ES3pwbklvdFZrb29NWUN4?=
 =?utf-8?B?ZjBnU2VHOXZ2U2w5ZjVVMWZTL0ZHQytrU3laR2hKaWtJNU9qdEJTc2c2TjRK?=
 =?utf-8?B?REttU2hQR0dFUGRaMFBweHJyeXlzeFdPekVjWDQ4SXlyNWlWQnQxU3d6Ym9h?=
 =?utf-8?B?OW95N0lOQ1ZRSHBlRjZ2MjBucy9RZGxvZlhjQTdFeENiYmw3b1NqVjZYRjdN?=
 =?utf-8?B?QXJkSXFiMmlpeGROb3RVNjk0ZEpMM1o1YzQ4UGx4andTNGRqajdNeXlWUUJz?=
 =?utf-8?B?RG1FbXE5NDdYUUVqQUh1aTAyZlZjMVRzTDZmSnFJWE55ODRLcmhCd2Fnem1R?=
 =?utf-8?B?TERCU3J0YXdQanU0RzkrRkJPaWZ3M2cwOE5GdGVqL0FGa0crWlJWZ2IyZ2Vw?=
 =?utf-8?B?d2gvVkZhMVd2ZUhLSmpjTVhjUER4aUMwdnlHQjBrVXEwVzhFQUJZZk9obzJT?=
 =?utf-8?B?SFBNbjdTTUxyRXIzNEpnUm5hN0svWmFEQXRWaTBmWHF4K21pZ0d4QnR5Nzlj?=
 =?utf-8?B?NlRJN2tPRFZjVWp6UFJwUm96RHJ2bHdPdjhPYVF0T3c4ckZJWlBqUVl0T3lH?=
 =?utf-8?B?NEVvNVovR3lzUGtrNzlTaUl0MVZSdEVmQjUreXQvZi9HOTFOZmJFbEpzVHRw?=
 =?utf-8?B?VGF2bmRQQTNDZ2paVWNOazRCQVRWWUxGRTJNNm0wdFhEaGNrczM5aXZwelhL?=
 =?utf-8?B?NjZUNWFGdTUyMW9yNTB0bUFPcjdMeDJTZTdJa2JmYmsxRlZIS2k2Rk5BSDB5?=
 =?utf-8?B?VExpUUE4eWJrVkwwdzVRdURUemNxLzdjVmlFdmRKQjN6ajcxeHNzMXFoUHlO?=
 =?utf-8?B?RFZ4NWJ4WTU3TUVoWFdZTG10SU41Zzd5YTZhSkpCRzVuMGJKazJwTTNGV3k4?=
 =?utf-8?B?a3Fnd3kvdGdKRjRLL01iM2ZRWnY2NUg2Wm1HMHYya2lLWWN6SnB5dVpRbVVh?=
 =?utf-8?B?aXdjWnBWaVh3WGtVcDUwSHhsWTBPa0FLa0hhR3VWMVFEYi83WHdQVU1zR29n?=
 =?utf-8?B?cThwc1pJb05iOHNyY0pwYU1EMW4zNXRJZVBJblprUzUxRVg2Mkl1Q2JtNC9R?=
 =?utf-8?B?b2VLK25NRTFTSnRITWhrTDFZVmQvcmhweWt2SjUycVI2ZVFIcUJaSlZGRFpv?=
 =?utf-8?B?NjZmcGVaNVpDYnYrclVTemNPMjllT0ZYd1F5MHQ5Wnp2aXNDeGg4K0NJaVVT?=
 =?utf-8?B?ZjNVbzFKcnNNVU9oWGlyZU9SRFFVaUZ2R2NKUXVPd2kzaFdUdEJEckN3ODU2?=
 =?utf-8?B?TW5BRnV0dXEzMnYwTFcwOFJmam90NEhBcllqWkdjZXlKNFhHM0F5d3ZqZkVx?=
 =?utf-8?B?ekxoRmJJSHdKLzE2bmJEQy9SUkxZOG1nYUxiVFF0SDJvTUZiOXBUYTZMaTl2?=
 =?utf-8?B?b2t2QzFGUXYvYWZtNzV1K2pML05PRzdkamZZSXF1ekI3Vll0d0ZFbjI2YzQ4?=
 =?utf-8?B?bnVuUk9neTgyV2hHakViNUhSanVSU0pyTldoVFc4S28vbEdTaXE5dTlUNmFE?=
 =?utf-8?B?UnNaSW15amkweThzOFZlRHRPZ3NKenV1WmJWazZWdmRRSkZBeVN3dU5vOGtU?=
 =?utf-8?B?cEpzRVBKYjNqeVNpd1Z4UWswM29MUnVrSkFIU0NzaGFjelBPbnhUWEpGd1V2?=
 =?utf-8?B?dlVkVU9YMytHMlpRbGxFOEtyY3ZSeGRnOU41ekVGMzFPU3dSRU9zYXhVaVd1?=
 =?utf-8?B?Wk9lT01tNmF1NGc2L1JIK1pZUUtvU2Q2MFN5NzRpUjdIS25pVjF3QjErZlYw?=
 =?utf-8?B?eXZWZEhDR0Y1TzJqRjgxbUlYb0EwZ3ZEN2xXem5TTXJ3NFA1cExBc25CT3Qv?=
 =?utf-8?B?aWVvQkY4WEpWMjlUU25LTFgydW5ZemRib2JhekJVZ25XTkJUYzJDNDR1RjZT?=
 =?utf-8?B?TlFPdjk2MEZxaEd4V1llNVk3ZmdBYWtoUUpCZU1CaXRzTVRjL2lEbU8zajdY?=
 =?utf-8?B?Tzk2K0V2YUl3MThpSWMwU05nMEU1YWwyZUd5SDN5bkI2TFJpcTZYTmgwcVhO?=
 =?utf-8?B?U1cyUittdWxLRExwK1RQV2s5MllNSjhwSWFSZ0tSRGEvUERFOFpVd0xiZkR5?=
 =?utf-8?Q?zJrbj0g6zAUfB0NIT/B0v5kI0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5332f525-ad7e-466e-99c4-08daf92e6cf6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 08:31:41.9821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XSPtp4LY1mZOgAHKELoiUxct/f3i3O6vG0s4HzhJxCBxGI7FSOIoqn9kAUFJOQbc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8042
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-01-17 02:31, Junio C Hamano wrote:
> Luben Tuikov <luben.tuikov@amd.com> writes:
> 
>>> +test_expect_success $PREREQ "--validate hook supports header argument" '
>>> +	write_script my-hooks/sendemail-validate <<-\EOF &&
>>> +	if test -s "$2"
>>> +	then
>>> +		cat "$2" >actual
>>> +		exit 1
>>> +	fi
>>> +	EOF
> 
> If "$2" is not given, or an empty "$2" is given, is that an error?
> I am wondering if the lack of "else" clause (and the hook exits with
> success when "$2" is an empty file) here is intentional.

I think we'll always have a $2, since it is the SMTP envelope and headers.

For the rest of the comments, I'll let Michael address them.
-- 
Regards,
Luben

