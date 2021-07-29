Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D51DC4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 09:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A71760F6F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 09:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbhG2JMf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 05:12:35 -0400
Received: from mail-eopbgr60056.outbound.protection.outlook.com ([40.107.6.56]:60993
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235086AbhG2JMe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 05:12:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYgRYHSP4L/N1cRxZkr7qiZC+1bQ98p5M5sFR92X2kPAuTEwEe7xqn3rTyaFgghkmKhsgc7l3/sBNYCG1PQ3wOlrI35i3xKsCREb4O3EEaTa3q1Ed9swi09wBIY8SAC7QOarG5FmGy6AZx9sAtyHmZ0R6ZhKDkBtLMQh9nhvs1jxDJdNJwZulNNlM5E+CMIaZUt0OnQmYVa4OxQrENvC/ym8Tgy0QrfWAj4+J0DDM3iboqSl68ciInvmQXOalbSc8LAfnJkHBqfLXdJv9WFM2ZLOxHeSYun9frACOEhepek+Rdncd7eW5erxsof+NXY51AntOe5WV9F7OrHp3Dfk+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpGEqXKU09PEwgHwcLmQjLZDyVwCKndKvjOxGms3zME=;
 b=maYXfpcEsOnQZUqCY3Nfivoizh8Ay6WVu5a2oio8OiaF134rDgqaDpqjY8pgpc7mRkQBzOu+xerreA+p9dpP/kTsho/Jz/wfFNUsNjMZnEunts0Eg0FNnJt50IkfM2nDZpxBLK5pcYt9CSCkbyA6X35Ror0HKUwSB3jqH7/wT4OhjN3lnEXMJ8hm3o2UHsHOIJIu15k71d1s8+AclYKRUgWCQnhiDbEV7cYFng6giNoFj2W8ps5KGETtW13XhwLNjgvxIHuHOSjw3Cd38S/i6/fRGn8Zia7MIQFvywrfoewcfZ3InU5IQD3qw+fkOA5ptOenZ2pSCsGv9pD1DxHfSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpGEqXKU09PEwgHwcLmQjLZDyVwCKndKvjOxGms3zME=;
 b=kX3x3oS6z+34Y/p7Hp6fqgHTYTPqkTA38Amh/Z8ImdveYvH81kFLo6KZtJV3n86UmV8fbifHSE22stHGDReKRf8tG7K/uCri8MDbSnzYPxPoljuEw7VEmULsbS9PX/JFQbUgyWEYdUnDGE4v8ooJnr0y1+sxRMPOUH3LSXrR1w4=
Authentication-Results: tilde.club; dkim=none (message not signed)
 header.d=none;tilde.club; dmarc=none action=none header.from=gigacodes.de;
Received: from DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:259::19)
 by DB7PR10MB2251.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Thu, 29 Jul
 2021 09:12:29 +0000
Received: from DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d980:59ba:f8fd:6178]) by DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d980:59ba:f8fd:6178%5]) with mapi id 15.20.4373.021; Thu, 29 Jul 2021
 09:12:29 +0000
Subject: Re: [PATCH v6 5/9] ssh signing: parse ssh-keygen output and verify
 signatures
To:     Junio C Hamano <gitster@pobox.com>,
        Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>
References: <pull.1041.v5.git.git.1627391744.gitgitgadget@gmail.com>
 <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
 <725764018ceb5bcecc748cc5169d4305ea9d7d23.1627501009.git.gitgitgadget@gmail.com>
 <xmqq35ry85or.fsf@gitster.g>
From:   Fabian Stelzer <fs@gigacodes.de>
Message-ID: <54671c83-4b1f-5e24-a6ad-226a4f45f952@gigacodes.de>
Date:   Thu, 29 Jul 2021 11:12:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <xmqq35ry85or.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0072.eurprd07.prod.outlook.com
 (2603:10a6:207:4::30) To DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:259::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8] (2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8) by AM3PR07CA0072.eurprd07.prod.outlook.com (2603:10a6:207:4::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.6 via Frontend Transport; Thu, 29 Jul 2021 09:12:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2edfdc9-8d24-42aa-ba61-08d95270fd49
X-MS-TrafficTypeDiagnostic: DB7PR10MB2251:
X-Microsoft-Antispam-PRVS: <DB7PR10MB2251F7466E84ADC65BB19625B6EB9@DB7PR10MB2251.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xx2f4ZsamRCVRPQ9BmTsCtzpW6Nc8s6IfoWfX9PLmHZA9TAphLcGRdVZqas42sYlTugt3OWRAkMCvsCvX/2ukt8CaFW69YrrjBU8VYEPWpzg6Hh76N3XAsfWafiLui+pzPC2CjkjngIKyN4kVdnfQgreEysZZIe+o88B6G91B3n1tUgN7+Z8SDfthBZgku+eX2V5fzCqCq1amMAExHlcM2KBaMhmZ+wwhkbg3ju5zVeEIo7TAs9Sb4SYAj9NPDL3yIRhRry6+7R2ZPcckdx7aTdcV6Wnvjtq8rFzRdZ8FQFbGjqxHSt922TjyBbvzDsUlKxencaa6kd+irzlUieovQwNec/Aq5aC4iUAqzwe3oyVg2YAQoVEDMHXBe0hZseQ+wEnEve9EFl/FLpE3gFS3BYdfJK16WB1SXVdc10wwqzrao5yLn0XwY/l9G33R2+NT6jjgm3WbEAhkfhHTncA05MQv+DLExXxCzqRMvUJMc5CRLXTZItxkHJO4l6DofneR3KYeHKb4ITUNvsVxEdbF0OhtBrwBOQVXWsBSbSZPHOhdTVOrz+ySZW9MHVKFfS7lzm0fAdtnfSkdhCVSuLC+Vn8rFroXSd/+ekWT4qUBgXmho2EH4x8yFX3bHi/nJKtBPKPr8QM7/K4xuSv8Q6e2Y25tnWI77rGkfyJ888m3HbGgvJ+hAcVe27sFbo8MU2qLvLcgsvfBJvwlrH4MKkmG25pyZCvXWGJ4UYWIwH0fLs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(39830400003)(366004)(396003)(53546011)(7416002)(6486002)(8676002)(52116002)(4326008)(83380400001)(31686004)(38100700002)(36756003)(31696002)(2616005)(86362001)(110136005)(54906003)(66476007)(15650500001)(66556008)(66946007)(2906002)(186003)(8936002)(316002)(478600001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dURKS1FXMGRWQTZDTDJvMVNaUTF4OG4rUTRPWEVRZjg4eHhWRWpmRVBKazNy?=
 =?utf-8?B?SG9KQ3ZUUERjc0FXWWR3L2dDZXpVOXdKUHFhUHJCblMwK0RFN2d3TVY5MXVs?=
 =?utf-8?B?NnFqR0d5R2YwV2IxMUZhQkpkZDFQMDB2OFhQQnQrem9Bd2xYMEtuV2NkVzk0?=
 =?utf-8?B?dUJ2M2ZPU3ljRHNjQ21CYmNUdXI1djcvbzVoNGhNVjdCMWw2NWJndklEbUJu?=
 =?utf-8?B?cy8wMTFoOGt4S29oUEpmZW5XQkJvdjRlc2l4N2ppN0dubmxsNnRUSWIvNEdh?=
 =?utf-8?B?SGlmOVFhdWZMZ29ZeFU2K0JzQldla2RxMmlOcmQzY1BPZTlKR04zODloZjZq?=
 =?utf-8?B?ZnNJZmxMZWQ2RG0xMFg3MWhvMUY0RHlhTFFCZU5oM04zM1VsUkZTSSt4K1VV?=
 =?utf-8?B?RkxyRVRDd1VrY1Y3UXdNOW9XNW5CMTZhVlpHajJlS0huTkoxMGg4MXNrS2JX?=
 =?utf-8?B?eHBTR3dheVhFa0dFaGVkK2NYMmxOcU56Smpqak1WaUx6VjhaSUFVNXJJWFcy?=
 =?utf-8?B?Y2dIemh4cmtNeXdhOEZmZnVYTUtYa2hvekJ2Qmw5SmtvYisyemJiZ013cWN3?=
 =?utf-8?B?c21oU3lqaWdjL2cyQkdEQS9DbmJLU3dJem9Jc01SaE00b2p6NTgyYkNoQ2ow?=
 =?utf-8?B?NGtHcEN4QWdDYmZZN0s5N1NFaFRoNzhDNVdWZUpld2xCSkllcGJNdDY0U1ZN?=
 =?utf-8?B?NDlaa3p4UWtMMjNzd1lYckM5VHBEd3BHV3NNVDBEMmlIMmc3cmRzRGhZbngv?=
 =?utf-8?B?eGJQNDlqWjhIV2hiSkJCNXNSeG9tQzkyOWUzc1J0YUtZamcyNzdiZXhHdVFu?=
 =?utf-8?B?M1J5RzhCdVo3aE9KOXhwYTVINHdZd0VKMDhuUFBSWjZ6dVdoQzZ4Z2s0Qm9H?=
 =?utf-8?B?TFp4WWtrRVJrdmhFdThTaFJDMmdlUHlKbWJDOGNFamxLMUtvNStvajJQcXg3?=
 =?utf-8?B?dTdOYlBMOHNtalpLWlQzSE5lYjlKRWIvWjlBQlRnZkw0ZWZBRmFmbkZBVm54?=
 =?utf-8?B?elQ4ajVRd2srZ0ttYlVrWDl5R1pIS0UvYnMyL0RvQkpiampsRzFnaEFlRG15?=
 =?utf-8?B?SVZZYWZZaGNLbDdGQzRhbjBvbldPZGZENjJyelAxR3RHZDVLSCtXU2NORjRK?=
 =?utf-8?B?bkRiL3Z1Q2kxZE1Ja3ZPOExLSDhqZFVPSVVZS3dYU0QxY2NzMmEzeUdQand0?=
 =?utf-8?B?dC9CT1NUN3BNM0k4MTRhL0dYYlp0aEZVTXA5eXp1YzBiUjBDbmhTaGRPZFFW?=
 =?utf-8?B?OE5BcytFOHY3UmhzL0tuRi93VkV3d0VYNlAxZGtoM0g2Nk94NDM5K2xrWU9Q?=
 =?utf-8?B?NnA5dzhMci9WSWFmRUgrL0t6Vi9TNFdITVBKVWtlZWZiT0VwQTQxRE9tQUtw?=
 =?utf-8?B?Tlp4NDRvYUNlQjlQdWJLZHJJNXNXbGI1cXFDWkppMnYyR1VEY2FpRzVzcURn?=
 =?utf-8?B?bjAxbmxEc1NkU1dSMzlhOW1MM0VqMkFYbUoxY2dlcy8rckJzYXB1OHZQbnk5?=
 =?utf-8?B?L1ZtWmxXL0d0VTlTSklWYVcwdE40dkhZSFdnQjgzZVZKWDhaV2I0cElsMys4?=
 =?utf-8?B?RlBvSDl4TDhSZk5WaHJDeTZkQWl6MmlHQkVFd1ZCUHV5U2NtcDh1VWlQRVNj?=
 =?utf-8?B?T1F5VHhURTZVeDdYckZnUk9pSGw4S1hHQzY5SHNQcy8wSXoyTnRkbGZ0d3Fl?=
 =?utf-8?B?Q09kaUo4eEovbjJwZzkxMTVhVVFhOFV3UDVCWUdQeUZTditVamlYUFFLbDRt?=
 =?utf-8?B?VlB5L1VwSWIyMFoza2Zka3F3d2Nmc3liTFNsMVFHK1c0Mkp0Nmk3RUxEOEN3?=
 =?utf-8?B?eG9QVWZYdVdtc2ZRbk9kQ2hoaUZFWWRYdnMyMUF0RXUycStCekt1NjRrOHBp?=
 =?utf-8?Q?cbFiqsnOThVda?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d2edfdc9-8d24-42aa-ba61-08d95270fd49
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 09:12:28.9963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DYFl3MccN4pXTNqfdMfucdVMYsz6kRXl6pwP3xpUjS8YC3gNTHqYR2dCcbmhQrrh68gnS3M6vNOvh/hf3+s+7i8o0Bj1Ahdki//cXQ4TRcM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2251
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28.07.21 23:55, Junio C Hamano wrote:
> "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Fabian Stelzer <fs@gigacodes.de>
>>
>> to verify a ssh signature we first call ssh-keygen -Y find-principal to
> 
> "to" -> "To".

fixed

[snip]

>> +	/*
>> +	 * ssh-keysign output should be:
>> +	 * Good "git" signature for PRINCIPAL with RSA key SHA256:FINGERPRINT
>> +	 * Good "git" signature for PRINCIPAL WITH WHITESPACE with RSA key SHA256:FINGERPRINT
> 
> A bit unfortunate line that is overly long.  These two are not
> mutually exclusive two different choices, but one is a special case
> of the other, no?  How about phrasing it like so instead?
> 
> 	/*
> 	 * ssh-keysign output should be:
> 	 * Good "git" signature for PRINCIPAL with RSA key SHA256:FINGERPRINT
>           *
> 	 * or for valid but unknown keys:
> 	 * Good "git" signature with RSA key SHA256:FINGERPRINT
>           *
> 	 * Note that "PRINCIPAL" can contain whitespace, "RSA" and
> 	 * "SHA256" part could be a different token that names of
> 	 * the algorithms used, and "FINGERPRINT" is a hexadecimal
>           * string.  By finding the last occurence of " with ", we can
>           * reliably parse out the PRINCIPAL.
> 	 */
> 

Yes, it's a special case that makes it a bit harder to parse. I will 
change the comment like you suggested. That makes it clear.

>> +		/* Search for the last "with" to get the full principal */
>> +		principal = line;
>> +		do {
>> +			search = strstr(line, " with ");
>> +			if (search)
>> +				line = search + 1;
>> +		} while (search != NULL);
>> +		sigc->signer = xmemdupz(principal, line - principal - 1);
>> +		sigc->fingerprint = xstrdup(strstr(line, "key") + 4);
> 
> OK.  This does not care the "RSA" part, which is future resistant.
> It assumes the <algo>:<fingerprint> comes after literal " key ",
> which I think is a reasonable thing to do.
> 
> However, we never checked if the line has "key" in it, so
> strstr(line, "key") + 4 may not be pointing at where this code
> expects.
> 

Hmm. What would i do if i don't find "key"? Still mark the signature as 
valid an just leave fingerprint & key empty?

>> +			/* We found principals - Try with each until we find a
>> +			 * match */
> 
>                          /*
>                           * Do not forget our multi-line comment
>                           * style, please.
>                           */
> 

fixed. clang-format wordwrapped those :/


>> +
>> +			ret &= starts_with(ssh_keygen_out.buf, "Good");
> 
> This is somewhat unusual construct in our codebase, I suspect.  And
> probably is even wrong.  Didn't you mean
> 
> 			if (!ret)
> 				ret = starts_with(...);
> 
> instead?  Surely, when pipe_command() failed, it is likely that
> ssh_keygen_out may not have anything useful, and checking what the
> first up-to-four bytes of it contain unconditionally may be cheap
> enough, but the person reading the code would expect you to peek
> into the result only when you actually got the result, no?

you are correct. we don't need to look at the output when the command fails.

> 
>> +			if (ret == 0)
>> +				break;
> 
> It's more common to do
> 
> 			if (!ret)
> 				break;
> 

changed.

Thanks
