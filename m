Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D668C433EF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 08:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C8FC60EE9
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 08:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhJYIb1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 04:31:27 -0400
Received: from mail-eopbgr150044.outbound.protection.outlook.com ([40.107.15.44]:36322
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230019AbhJYIb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 04:31:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRZwMS1oHxmNYMtfD09GGcXb1hD+VfWpvEtyfVLYpaE8gN3BuMpFS15TVRrHO/xJmlpxeczdeHhPnSFiQ2RJqJ86oe3HRwdHSpZItpCF+AHTtl0k0HPBXPMPWyjfiy47e607lD5i/9nWicJI0kJ2Xaqk5f3ugNj0gqXBuIgrN66DnH2K0g720aXF/6/vj0J+hFDi+fq8Hj8QDDzp86Zxo/BNLk1DOWxf9eUSzmJ54NbRdUqcWFoZqh5NgPZNKGR4MHRyM0FDQ2GVA2G8g0JUSXoeyuZUbjJjF6f2+L2D6zpcVBzgXpf+sRS7GTLghy3wa3pnvh4kjsh80ivjfFEnag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSf6Dsi4X9+JKc9VFxUtWhJxhPfWMo9gOSDmvLwkEac=;
 b=Z3e/wix+O7tXGAQsWkZK1i8Ye3VuHDZ9jLAOOZES2Mc/XzB7ykIi5myW1CPw9vlamQm4zk3HbkVuwDxa+kk8BEdnghIh5t6OrnY8LMyqxdHKuFgX212jz/e8UexOBssK/8SNaJejrru4IGnZLOOk527HX1IVLPSDmjvhvMbzmVaeQqfji+43gyq2BN383QMUm4ujanFMGifLAgkSK9f8rOtS7Ylb65ZxKe5Zs3T3F6PpfEylswaw4AX2ogpQDkp122RhV6JNWZ2vclmL+uSM7b4J8NfyYX6bEaFk0POksfDIVXNEyJmh6DAPsWr3g+AbRMeoC88x1Y55c3vHw4EbaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSf6Dsi4X9+JKc9VFxUtWhJxhPfWMo9gOSDmvLwkEac=;
 b=qRSFlzhX5fL50h0eeV9sD1zFgmeg1u2CiN7N5o173YYVGK7iA0ddk9E7wPMRizq+uK/nPohvUSEyohTOX7c+uh0ePe2jkQ+Vpa8dB5LgphuZyAjCodzRqmKd8XTmkw43FBWb36Kx5xIA6mneijf1vWYXJuMyXUaCsQqc9fHWfpU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4109.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 08:29:02 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%6]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 08:29:02 +0000
Message-ID: <02fff111-865d-a2a0-ba06-d0166edfb9dd@gigacodes.de>
Date:   Mon, 25 Oct 2021 10:28:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 1/6] ssh signing: extend check_signature to accept payload
 metadata
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>
References: <20211022150949.1754477-1-fs@gigacodes.de>
 <20211022150949.1754477-2-fs@gigacodes.de> <xmqqfssr8hd5.fsf@gitster.g>
From:   Fabian Stelzer <fs@gigacodes.de>
In-Reply-To: <xmqqfssr8hd5.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0701CA0055.eurprd07.prod.outlook.com
 (2603:10a6:203:2::17) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from [IPV6:2003:ea:5820:600:c042:75a0:fd5e:1472] (2003:ea:5820:600:c042:75a0:fd5e:1472) by AM5PR0701CA0055.eurprd07.prod.outlook.com (2603:10a6:203:2::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.10 via Frontend Transport; Mon, 25 Oct 2021 08:29:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75809b8f-f896-46d0-7b0d-08d997917ff2
X-MS-TrafficTypeDiagnostic: PR3PR10MB4109:
X-Microsoft-Antispam-PRVS: <PR3PR10MB4109C4ED198E9413E8B1BE11B6839@PR3PR10MB4109.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WmCNZ9F9FK1ZmQhyIfVaxiMNeB8lUicGYupOXs34DUS9OT7j9xlxQM4EJTZfpL8zGO1UIZqA4becyPNGvURCQtFBZ4Y0U2Pno1FZCEuFqzUYyG7djLCxv4q48aFU5LZrzXThjoCFCsIpgIHLDdfHFRRwmhglmtibat3oExZPXxvdL0p+yDuOBBHva2SAF5lzfr2a617o5CEu1mou15NZhgMfhYVpmM+57Rw4ce1oQh6A5ZE6y9sS7Y76WshV2NRjxdcqR5zgByQ5HfN7jS5tj8UT3WBI+cjHskmL2nBtJyukgXZL60iv6+v2w8rU25CtDgTgU328V35r5+Uj1BY77bXO9Kfh3VasOi0dml+IEvmykE/1A5BQ/AV/c5spGYnLrVmRMYDkLIvrUz9lcEGwkk7ZhEAfLdZIQsEU5ljLzzJ9TQKQ0O+8IWCoHAVF50n+t+FYLxan2L3VyYEzCwE8zwxBETV/cr7h079qq62kYR+kQImXEx1HkjNgB5xOcRgc1apNHJsWVZY9UZ76OCclKduBoob3vGn/hDTZr+M5itmTM27EGFCsSanJUcN6UurGBZwC/umY5R2+KzbJ4x2Ludn0r2KOnth3XEFF4Yg1vGKNLfEF4csq4qtHRnDiBln0rD339uGOb4MTzyi4u2vgUkQ3dHr34Mr83iIhDg2X+xU1xXFW0t2yjjyat+jjTqg8fGoGfEMozhy4uOkqdRPaf5crEbo5mLZBnqVLZHZZYmdOQOJmEm5Q89dQTk+0zqcArM43W9Xj97YMGNcHdjj+IA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(346002)(396003)(366004)(376002)(136003)(6916009)(508600001)(31686004)(52116002)(8936002)(66946007)(54906003)(8676002)(53546011)(316002)(83380400001)(36756003)(5660300002)(6666004)(86362001)(66556008)(66476007)(38100700002)(6486002)(31696002)(186003)(4326008)(2906002)(7416002)(2616005)(3454003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2VDWHJwR3RVZER3Q0RmYjRPSlVvNTkySDJxbFdxbFFrVm1pZWNsR3AzbGxG?=
 =?utf-8?B?ZWN6WXlsL3plaDN1c1V6bWVJb2x0dkhycHpuWStrMnRHZVJZMzVNTUkzWXpv?=
 =?utf-8?B?dVk3TFR5MVJNYUN1VHIrYzNWcjk3ZVNFVWRoKytwQ2ZoUXljRW9qc1RkUmh4?=
 =?utf-8?B?ZGFZWmN6NllDeU5pYlF3UXBEWlg4aWZnaG1nV2Z5Ly9VY0FBTU9WS0xDdFBy?=
 =?utf-8?B?MWZyWVRXektvWmpselFRQUcvZnlURGhSK1QvWE5YRVFpaWZiT3NVMFFMTlRD?=
 =?utf-8?B?NDNnRzl5Skl2cFlUT0Zwd3kzRGt2UHpUUml5TnBQWmVPWTluNS9rUWVzMFRR?=
 =?utf-8?B?SWRpcGJjYXpSWmkwT1NJd0luS2dYQTVtTzRUMldYa2gydUU0U2xBTmVQZE1x?=
 =?utf-8?B?eDJabjlsUEpFdjJ6QWxpbFhWVmcvbGcyNlVrell1czE5YjdYNnRwNDNjNlBM?=
 =?utf-8?B?ZHd2YnJXZTNDR3E4elRSeEp4K0xNOTJlR3gxMTRzVHlaS2ozVWdKYTROeHha?=
 =?utf-8?B?eUxHUjg4RllsajBPUVJIZThXVjlEaE9OajV1cVhsVE4xVzJGbHNSc3kxdUhB?=
 =?utf-8?B?NnRablh6WXJLT0M1WTlkam9kU3pZVUVXOUFzSGlLekNFd0NUR2pzam03ZllP?=
 =?utf-8?B?V0hyTmw0RTlhaFJjYTZWNTlKMk53WkV4OUVUemNweWVNbC9tWGlZVU9JaFZh?=
 =?utf-8?B?Q1A0enJFWEY2YWVnSnliZkVDa1NMNndONVZISUpsTEkyNm0zSUsvejNab2JW?=
 =?utf-8?B?L29YNkJGS2dNM293aE1vaHg4dkl4UFBNdGozWmg2VTR3UUY1Y2FTZHNFR1lh?=
 =?utf-8?B?K1JKd2Q2Y21ZOUI0Y1pjU2xQWTlMQnFab09qSUl0dGtRUTNWek1YTVRrRTZV?=
 =?utf-8?B?WkZ4VTRkaUJCT3lRNFpPaXhMRE5EeE1Dc242Y1lCUkFwNFp1elYwdHM2YWRJ?=
 =?utf-8?B?TnBTNWRIZUVscytnQURLMmdrT3RsaitSdDNCOHNCdWdHMUFsMjhrK1VUYWx1?=
 =?utf-8?B?QlVvQWY0U3lzeXFNNUlmOExyZVRLZ29GTVcwNkx6aWhGWGRwY0pTNUhzM2J6?=
 =?utf-8?B?aWV3MHJNMnVieEEvVTZCRXlZVlUzSWZNVHQzRHdiU3FzOU0yTGp6OFhOOXha?=
 =?utf-8?B?Mk1kRm9hbjFhOUJDVUZZQmxxU2pROFBNenhDSjEwUGlpU0lpVWNUTDNBaEtX?=
 =?utf-8?B?cm50ZWNHT0tXZUJJK2JyeVg0Zm5PKzJnODdKMnVvelhGSTdpNlMrNU5TR0VH?=
 =?utf-8?B?MU9DZE9pQW1zL2M1OTV0eHhZaVd1N1ltUFJYU1hLYnVrYSsyaUZzK201K0tX?=
 =?utf-8?B?NnMxMGVpd05KQzZnRTdzLzNqQWtRQlNMdklESGF0ZlBELzlLVVMvd2diSisy?=
 =?utf-8?B?MklvdWFnQmFZcTdQYzkyRTRnVUIzc25HOWlUTzZxN3l3V3BqbGZKYmM5Rkw3?=
 =?utf-8?B?L2RiSXZNUSs3WDRIWTFTQzkyR0h2b20yUG5Rd0d2UlJOck1vaHdKUVNFY0d4?=
 =?utf-8?B?aGFmTTN4bEE1Z1dhd0djdFcyUWF1OUJUQXFLWGpUcHhYY0MvREk5WnRhODV0?=
 =?utf-8?B?MlhPd0JOem1IdmtKdVg1QXJtWERScTltNVVTZjNPQUhQeENPWUJwM3h5cXox?=
 =?utf-8?B?dU5rdVhmME1ab25obTRvMEdsbkh1NTNzcTloYTAvV0ZFQWRKS3VwM2Q4S3VQ?=
 =?utf-8?B?RUVCSXYwb3BSL1hFTHVCcTRySjM3MFNSSmk3aUoxbGhmdlc4MERKYnh6UXRV?=
 =?utf-8?B?S2ZwbTVYMVFzQXdqV1pmUzN2M3R6bFVYd011dGUxUTNzZ29VZ05UWmY5enZM?=
 =?utf-8?B?cFliR3hINDBkWm8yZ2lMUEM0RGtraUFROXJCcHo1M2RYcVRSM1N0Rmx1UWYw?=
 =?utf-8?B?bjZjdkRHYTVSRHVudndXZzA2MjhwNEVCZXRhaDYzM3UvcVZJZVgwN2drN3pl?=
 =?utf-8?B?NVBSUmVsVzUyLzVJWkIrK1lPVG8xYTZ2T2RVMmQ0SFNsS2hPcmhsT3NvYkdw?=
 =?utf-8?B?MEtGUndTdUc5bWFUejVXMlptaVZDdkxhVWtJWnVQY1h1MzJZc0M5RTVMeHA5?=
 =?utf-8?B?Vzg4ZHdCaXhhUGdvVm5KVEpFQjdZazJ3VUF3NCs5Qi8zdmk2TkZ5cDBNekJY?=
 =?utf-8?B?VXlraVFBVTMwdTdzbFl6ekM3S3FRd3JScW02elJpdDkyOUl4K09RMTRYZ0FX?=
 =?utf-8?B?Tm1FNURVbTE5NS9RZ1dQNVVGaW82VTVhRTFjZzkwRUZlWW44TFJrSCtRQWJy?=
 =?utf-8?B?NmszU21oVWFodTk3dGc5UzdVRDgzSDJ1RW41YU5icWtaemxBN3dWSm1QN0dU?=
 =?utf-8?B?Vzk4M1hOd1h2TzBodlhSSnovRXFWU2wvYVlGNTVReENJOENCUkJLdz09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 75809b8f-f896-46d0-7b0d-08d997917ff2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 08:29:02.3679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0EGrok+nobqiRPYdsL/mKRGoT1d4I1+4RZEANBOp95pJfNfcHBspZODNIEd3yPZblP+30lkdIX9qkkcGfmHfg9L4TX4k70GCuIbhn9M5jA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4109
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24.10.21 01:13, Junio C Hamano wrote:
> Fabian Stelzer <fs@gigacodes.de> writes:
> 
> It would flow better in our "git log" stream if you explain upfront
> what problem you are trying to solve, before starting to give orders
> to the codebase to pass these pieces of information.  Something
> like:
> 
>     In order to implement the "trust on the first use of a key"
>     behaviour in later steps, allow callers to optionally pass the
>     timestamp of the payload and the identity of the signer to
>     check_signature().

Thanks, you're right. I will update the commit message.

> 
> It is unclear what "payload timestamp" is without actually seeing
> how it is used, so if you cannot explain it in easy terms in the log
> message for this step, it may be an indication that it is not a such
> good idea to add these parameters in a separate step.
> 
>>  int check_signature(const char *payload, size_t plen,
>> -		    const char *signature, size_t slen,
>> -		    struct signature_check *sigc);
>> +		    timestamp_t payload_timestamp,
>> +		    struct strbuf *payload_signer, const char *signature,
>> +		    size_t slen, struct signature_check *sigc);
> 
> Funny line wrapping.  Just like payload and plen form a pair (hence
> they sit next to each other on the same line), signature and slen
> should sit next to each other on the same line.

clang-format enforced the 80 char limit here i think :/
i think we will change this function anyway (see below) and i will keep
it in mind then.

> 
> What's the reason why payload-signer MUST come in a strbuf?  A
> caller that has only ptr and len must invent a new strbuf that is
> otherwise unused to call this function because of that calling
> convention, which looks suboptimal.

It does not necessarily need to be. I just like the convenience of the
strbuf_ functions for working with strings. Also i think it makes it
very specific and easy to grasp in the calling function to STRBUF_INIT
and then release it at the end. When working with char* it can often be
not immediately clear (at least not t ome) if i need to provide an
existing buffer or just a pointer and if need to free what was returned.
char*/const char* usually indicates this, but this is not always the
case. Maybe my "C foo" is just not strong enough and i like the higher
level api :D
If my change proposed below is acceptable this problem solves itself as
well.

> 
> 
> What's the driving principle that decided where in the list of
> parameters these two new ones are added?
> 
> I would explain one possible order I may find "logical" using the
> level of detail I expect from an answer to "what's the guiding
> principle?" as an example here:
> 
>  - we should move 'sigc' to the beginning, because the convention
>    used by many of our API functions that have some central
>    structure to work with is to have such a structure as the first
>    thing in the list of parameters;
> 
>  - we should then append 'payload_timestamp', 'payload_signer', and
>    'payload_signer_len' at the end, as the function is about
>    "validate <signature, slen> is valid for <payload, plen> and
>    leave the result in <sigc>", and anything we add is auxiliary
>    input to the process, which are of less significance than the
>    existing ones.
> 
> Another possible direction to go might be to add these auxiliary
> input to the process to the signature_check structure.  Then this
> step can disappear, or just flip the order of the parameter to move
> sigc to the beginning, and then the later stemp that does the "first
> use" thing can add the necessary members to the structure *and* use
> the members to do its thing, which helps readers better understand
> what is going >
> One possible downside is that sigc has been mostly output-only
> structure, and turning it into a structure that also has some input
> members might make it too confusing.  I dunno.

When starting this series my plan was indeed to add these parameters to
the signature_check struct. As you correctly mentioned it is "output
only" at the moment. That's why i chose to add the extra parameters. I
added them in the middle of the parameter list next to the payload
itself since i consider them to be part of to the payload. And since
sigc is output only i would put it at the end (not sure if any
convention for things like this exist for git).

To put it in words:
check_signature uses payload/plen with timestamp & ident to check
signature/slen and return the result via sigc.

Or maybe alternatively:
check_signature checks payload/plen to check signature/slen, constrained
by timestamp & ident and return the result via sigc.

However if everyone is ok with changing the struct to be used for input
as well then i would adjust the function to have it as the first parameter.

The sigc struct already has a payload member (only used for verbose
output) which is populated by the check function with a xmemdupz. I
would then change it to a const char, add the length var and use it to
pass the payload into the function as well. This way we also avoid the
unnecessary mem copy.

The function would just become:
check_signature(struct signature_check *sigc, const char *signature,
size_t slen)

> 
> Thanks.
> 

Thanks for your review.
