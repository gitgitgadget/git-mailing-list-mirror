Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907C7C433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 09:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236421AbhLUJhV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 04:37:21 -0500
Received: from mail-eopbgr40058.outbound.protection.outlook.com ([40.107.4.58]:10318
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233216AbhLUJhU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 04:37:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTjTpuucertsnNgGFdUtMsZZSg85oRyH4BWo24ESCg4cJY07VWOSCbbeweHE3oAbyB2ShTlvPNjCf4HN0omHTYTZLOPubLKFtxOm7jcxOO/BjraMdAwDyFyHacXnhBYZYOIR9F/XtxOUpqnHQcLqVdsU22U5BMZa01cGqJhnz2gQahqiEQrVyP+Ocfi1Bg28HuEx6N9Pumacb3lTveH6xUKsg9cCuzUlqpyxri1p0CKftzO75zAH+SYopJKi4fmmRTFW6PiAUG/gpCncrCo154w0hoW1q0S98UpkMnMRxD+NLMJVjH8s6ukjVqMqnhMaSniNrPbfb9875Yfo5tur8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXi7e4z/worf3/rw32BVDXlz689GR3MantEpspnKEsI=;
 b=HA6yhl4hv7e24yCRyOH9wwsITnsMVU0spJjKaHxD/HAhLPOpiLy7qtQm5qYXxuFDN3SOQ++YL3Zric1YNYZxaLV5Y8FT/QgQLjFpGU5OrZceaApsHT+yHJjyeNIjB4g3tji2cqg4Y2BdDVmnTA5fyVZH0Xm5WkUo3ffvAjrw1Pl/armWwq8P8ct2ouTpRmy2zzaCbjFFqIACCdvWPqrMhas0QiGLWVN9FWiNNVMwkC0MvgG9NW9jqhy3WxTPMi9JLARh68pAXx7ToCWg1XoYhuU6yeTzu3jS79/XSM+LbJOdlluo/+1xjHSL+qHX+ddYVEmokwR24yLcfpXtQrLx5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXi7e4z/worf3/rw32BVDXlz689GR3MantEpspnKEsI=;
 b=oH7JBxcCMUsvypNzpAH86Ytnfxh9SqpQerPveBmGaFEYuIQPPRv9PZh8wOuTVli6qjoXa6dkSMA+Ikm/bjBYOOyQCaCCTGrPddZ7/RSW+YpmYGV8Z8CmoHK8NwC3dlcddQDNKMGVvtRUb0rnSg0LrZ+abt8Ft0psLShOQZ3I0PI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PA4PR10MB4336.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:100::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Tue, 21 Dec
 2021 09:37:18 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9%4]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 09:37:17 +0000
Date:   Tue, 21 Dec 2021 10:37:16 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC PATCH 1/2] crypto sign: add crypto-sign alias flag
Message-ID: <20211221093716.nalrgfsvl6ovjdqr@fs>
References: <20211220140928.1205586-1-fs@gigacodes.de>
 <20211220140928.1205586-2-fs@gigacodes.de>
 <xmqqr1a7t00y.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqr1a7t00y.fsf@gitster.g>
X-ClientProxiedBy: AS8PR04CA0001.eurprd04.prod.outlook.com
 (2603:10a6:20b:310::6) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b91c6c53-5432-4e5a-4338-08d9c4657a7e
X-MS-TrafficTypeDiagnostic: PA4PR10MB4336:EE_
X-Microsoft-Antispam-PRVS: <PA4PR10MB433610CCD8A94D53513E9753B67C9@PA4PR10MB4336.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m+kagiIfsE93UotvXIz1KttSX9Y6bftOo6mGKqEMFNSRGVgE641bvTQKcTPXQVIKWwuEkJLpvCCKIyIiZLaKNNGKM2gXFB0dLV6EyDv08mLzskpj6gGMhXxHJP+PH35H1i5wS/N2w8MgkD7YInvK6oBfsJ6jH/yqjWkKLeqn0gEEawT37XYApRdFaAVtJ0njyqnoibH5X6cL+7rxOR3cL6MBYm9hlCViEqga/LgG5pJ3esVg69vhFAUnUFNDN4kV0fKZVx16bFTRSeqscknlU/SqmucSKzkmCOi15s20di3X6u/0cr/X8zO6rlMAbjDwhYVAb1RxrtjaTj6FNsXuF0Z0BSGgwcGEuCGtz7cAe3qcof/wmtNvu4f5NmiW+d3WpXEz2JI+qiZ1YYtglPXUyJpbmls0uWklu8s11i5bcVV2cE6LVfYA+OriPzipTARsslRyp5KzKxtV6rYK5I2GRP6KtATdqaVMSgxnwBgPZG5iAAhOtgCufVaCgN5Q5QJlOHdPsdz47iPnf3DKpyXoQSSORtzF2zcgamZozfu5w5cdH9yigq1uyYHdLro2VvEpGco4+Cx4nT7if47XxOr5G+xyl+hwEUfx9iivLWaARXcE27uyydyvZ3Q3yEEZUTcK19Ikdj5WNHAKRJIcumHi2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(376002)(39840400004)(346002)(396003)(366004)(136003)(8936002)(5660300002)(316002)(54906003)(66556008)(66946007)(53546011)(6916009)(186003)(8676002)(508600001)(2906002)(66476007)(33716001)(6506007)(9686003)(4326008)(1076003)(83380400001)(86362001)(6512007)(6486002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTNrejY3QmdxV013OTZONmZwZUcrV2pDOUFOQmhtV2hOWTIweGJWOWg5WXhB?=
 =?utf-8?B?TlUzR1VvV2lmeFZRcSs4S2ZCT2k2Y1lUT2IzSlIrdXdRQ2MvQU5CMXBWN3lj?=
 =?utf-8?B?WG1hTzAyUkRWKzlHS2MwWGk0dUpneFVMSHdQUG5IQkgycU4xejhhd2c5T2xP?=
 =?utf-8?B?d0N2UHY2MWprTC9Ubld4SmtlbXJEZjhvYUI0RCtHMW9jS01IbnVNMjQ2MXdT?=
 =?utf-8?B?UEh6My9rYnFRSzNZRnU2UFRyWFVCcmk5V2t5UDFBeTNvUDFLRU9qeGt1b2o1?=
 =?utf-8?B?b2FMUWtGV2Q3d0FsK2NKaXc0eWVjUHh6OCtlcm5RRUtWRVJBeXU2dkV0cEJZ?=
 =?utf-8?B?L2lMWTBVOUo3dzlQbUx3U0RHeDljeHVqc25MdGVFUnVwMHdzZE5HRE5TNk8x?=
 =?utf-8?B?VVVWVkxaODNUTE0yZ29xWjl1RG1HVzVWT3ZQakJKK0UyTHJwS0tOOXFtNyt6?=
 =?utf-8?B?cUp2MkZ6NlR2dnljNm9kMTgvUTl0VnFyTGVRNVoxL1E0STdhZ1V5UDFEd1dx?=
 =?utf-8?B?VVZPa0oxenQrWWMyTXR2YlRSLzNiSm5JZG4xaG5LNEY4K2VWbnVLTUdOYmFT?=
 =?utf-8?B?eGo0ZzVLTmN0QUZjOTEvS0xidzB2aENhdVdNK0tMQ1M5UkY5SHJpaWFkd0Q3?=
 =?utf-8?B?Vll1KzBiRk13ZW50d1NYTkk3MFRoQmpxcUpzZDBzNXJTbzRma0pXUmRWU0lk?=
 =?utf-8?B?bmpQaDE3QmZhSzhWbkJ0ck9hbXVIZHExSkN4OHN1UE1OeU5tOHBlalJtN0Jh?=
 =?utf-8?B?UVdBcnpNdTVMa1hlU1B3NkRpd1hhWU4xTWlUd1ZSTjVxVW12UXZrWUFyZXJp?=
 =?utf-8?B?N1JQc0lnTnNWNFZLVFcrWkk4VjdPbzQ0eU5ZRlV6TmtONkMzNUNKcWRzdm83?=
 =?utf-8?B?WlU1KzQzRkJGclhtWEU5UFVKZFQwTkVWbDkzUStBNDJCbWtNdkMrZi9HWHAy?=
 =?utf-8?B?ZmRUTXJNNFNtL24yV29KOXlpOUVwZDdVc0srWExJWlZJZzJqbzBZYXUwaWRJ?=
 =?utf-8?B?RWhRa3Fld00waW5ETjVITVNucFNOTzVkV3d5TG5Fano3d1NpMmlzbkVMUVdm?=
 =?utf-8?B?VjhsKzhycDZXbHNDZDZnMjQ3UkJqK1dnR2ZNSVZuV0pVc2I5NjVONVZzdDgx?=
 =?utf-8?B?SFRHU241dkt2K0lCKytSem5mak1EV0lFdnJ2cDQwc3p2ZVNIcFpPa1oxOWFl?=
 =?utf-8?B?TytQUGFzSm1Vd280eld1NGdsLzRBTDc1dmUrM0JYUUhKUldCckE0bkFYb2hK?=
 =?utf-8?B?a254T1hzd1o5NDRSQ0ZEQ0Z0aXhXQXpqTEJOVjlVOUFFUmRTTUpJelN3ZXBh?=
 =?utf-8?B?MTdFb0lRWDlORENoRFJUZVhKRCtvdU5TdW1KeVJPc1AzZWMxQlkzK3VnbTV0?=
 =?utf-8?B?TkR6WG9xQ1FicmNtS1J1c3hydUZMemhzaXhaazVwbDVyMXZra09vc2s4SHps?=
 =?utf-8?B?Y0RtN0FxQUNLUHhUaHdoVEtyVU1uazk0UVFEeDVoWEdNSWtCNUtrOWxTMElr?=
 =?utf-8?B?eXorcnlFV2FSVUdjMjR3M3dLV0laN1hlcHY3WmU1bjNjMGhnTTZGNkRDakJh?=
 =?utf-8?B?OFljNW9vWTNaMmZYYTZwMVg3OGdGcmxkM2R6aFJvOFArNjAxWFZmRjlLT3Qr?=
 =?utf-8?B?NVRKNTFvcCszZnBZN1Z5djNKMCtYSWJJS2lsN1hoMThxT3N5YUVTVURNbDVS?=
 =?utf-8?B?eGNRWXR4YTl5Uy8wclI1K1FraWpGZDNKbGtQbnJVSW12a05nbmRmWEljZGdX?=
 =?utf-8?B?ZVpUL20yQjRJOVk5YkVsc1BsZVV3RGR3eVBSdjVOZ0JsRmNNckluQ3lYSGtt?=
 =?utf-8?B?REltWVBXTEtnZjgyclJVUkJNaFdMSU5rQ1hjM1cyR0sweE9TUVZhWlJEZXJm?=
 =?utf-8?B?MnZqdUFCTG9KbXpsNXhWcW40eE9QWGkzazZlUFVKQllsM0kxU2NjMlgwbS9K?=
 =?utf-8?B?dVhFTExoU0J4SGNxSy9TS1lUaG9MNi9jVlphOE11TmNCMXEyU1ZXTXlmektZ?=
 =?utf-8?B?TEpPS01rYXBFZ1czVmdOUlBmZDVjV2U4S1lySEx6ZVNoQ0hHeVIxUmRTdXZV?=
 =?utf-8?B?K0VvbnZFVmV3cERaYUZTL1NxdEhCWUE0Qmk4MUNmZUxDamI1dHFHdGp5dm9k?=
 =?utf-8?B?YkppT0VWbkp3NGdJTzV5bERiMzJEZXY4MnFhcHhtL0wwZllHZHpTaGtESktp?=
 =?utf-8?B?UUFiVEhHTmtMZkJyTTNnVHVxVytmMUlnZnhwdWN1MWNXT1Jid2k1UnNvVTZE?=
 =?utf-8?B?RnQ3YTllTDRVZ2FlRm9pYjNJcngyQ3FCUWFOeVVKeCtvOHBlODV3bzlqVUt1?=
 =?utf-8?B?dERENHlYb1kvaXE4MjB3SGpQbXFnSTI0T09IM0pXVitHSkwzMHFxZz09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b91c6c53-5432-4e5a-4338-08d9c4657a7e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 09:37:17.7502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Hi4C4Cr7oSkbDhEe47wU1BHU0PuxaEz+zxyX5C4wVO5KxZEkR8V5DZoZzkM9A8MaN4MAUjhJWnlyf/hIL0dLFF1UueTYZcR9qMJKsntIIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4336
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20.12.2021 13:54, Junio C Hamano wrote:
>Fabian Stelzer <fs@gigacodes.de> writes:
>
>> +--crypto-sign[=<keyid>]::
>> +--no-crypto-sign::
>>  --gpg-sign[=<keyid>]::
>>  --no-gpg-sign::
>> -	GPG-sign commits. The `keyid` argument is optional and
>> -	defaults to the committer identity; if specified, it must be
>> -	stuck to the option without a space. `--no-gpg-sign` is useful to
>> -	countermand both `commit.gpgSign` configuration variable, and
>> -	earlier `--gpg-sign`.
>> +	Cryptographically sign commits. The `keyid` argument is optional and
>> +	its default depends on the configured `cryptoSign.format`; if specified,
>> +	it must be stuck to the option without a space. `--no-crypto-sign` is
>> +	useful to countermand both `commit.gpgSign` configuration variable, and
>> +	earlier `--crypto-sign`.
>> +	`--(no-)gpg-sign` is a compatibility alias and has no effect on which
>> +	cryptographic format will be used. This is determined by the
>> +	configuration variable cryptoSign.format (see linkgit:git-config[1]).
>
>I'd make the last three lines into a separate paragraph and nudge
>users toward the new spelling if I were doing this change, e.g.
>
>	...
>	earlier `--crypto-sign`.
>+
>The option was originally called `--[no-]gpg-sign` and is still
>supported as a synonym, but it is encouraged to migrate to use
>the `--crypto-sign` option.

Will do.

>
>Not the problem with this patch, but can the format be inferred from
><keyid>?
>
>If so, `--crypt-sign=<keyid of format X>` can choose the format X
>and specify what exact key to use at the same time without the
>cryptosign.format configuration variable.  But if not, the interface
>leaves us in an awkward place by letting different keys easily
>specified from the command line while making it impossible to
>switch between GPG and SSH from the command line.
>

I thought about doing this when we added the key:: prefix to differentiate 
between literal keys and file paths for ssh. Something like 
ssh-key::/ssh-file::/gpg-key::
I decided against it since I think this could lead to different to 
understand behaviour for the user. It is quite clear that a flag takes 
precedence over a config var, but what if i set `format=gpg` and then 
`user.signingkey=ssh-key::...`?
If we would start this from a green field and did not have the format 
setting, then just inferring from the key would be ok. But with the backward 
compatibility I think this is too confusing.

>If --gpg-sign is not a mere synonym, but also implies GPG is
>preferred when cryptoSign.format is not specified, that is a
>different story, of course.  That makes it unnecessary to deprecate
>`--gpg-sign` and in addition we need to add `--ssh-sign` option that
>works similarly, which may not scale well but I do not expect we'd
>add many more next to GPG and SSH, hopefully?  I dunno.
>

This is indeed a path we could take. Here the flag would have precedence 
over the config. However it would not make sense to just specify --ssh-sign 
when `user.signingkey` is set to a gpg key id. So the user would always have 
to specify the key or we would need to move the signing key config into the 
format specific blocks leading to even more compatibility code paths :/

I'm going to make some bold assumptions here, so please correct me if I'm 
wrong.
Most users will not need to switch signing methods within repositories, if 
at all.  Corporate users will probably adopt ssh, if anything at all. I have 
never seen gpg consistently used in a corporate setup. Open source 
development is heavily leaning on gpg. So the most common case will probably 
be users having to switch between work (ssh) & oss (gpg) development which 
can either be configured per repository or by using `includeIf "gitdir:"` in 
your .gitconfig.

So I think the extra flags or extended key prefixes to infer the format are 
not needed and we can choose the simple option of only having the single 
cryptosign.format config.

>> diff --git a/builtin/commit.c b/builtin/commit.c
>> index 883c16256c..2c789ff6f9 100644
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -1639,8 +1639,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>>  		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
>>  		OPT_CLEANUP(&cleanup_arg),
>>  		OPT_BOOL(0, "status", &include_status, N_("include status in commit message template")),
>> -		{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
>> +		{ OPTION_STRING, 'S', "crypto-sign", &sign_commit, N_("key-id"),
>> +		  N_("cryptographically sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
>> +		{ OPTION_STRING, 0, "gpg-sign", &sign_commit, N_("key-id"),
>>  		  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
>
>Leaving this explained as "GPG sign commit" contradicts "it is a
>mere alias that does not even imply GPG is preferred when no
>preference is given by the cryptoSign.format variable".
>

True, will fix.

>> +
>
>Unwanted blank line before the "this is the last line of these
>options" marker?
>
>>  		/* end commit message options */
>>
>>  		OPT_GROUP(N_("Commit contents options")),
