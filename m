Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB7CC433EF
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 10:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237932AbiAFK0I (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 05:26:08 -0500
Received: from mail-am6eur05on2054.outbound.protection.outlook.com ([40.107.22.54]:26689
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237668AbiAFK0H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 05:26:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+Jz4fncKnItb4EZk9frtTFSGw4gLfw5SIRaDQmGeBbPiYJXyKqj0+o75K73xt95Mi/9af3azjaCTHnYbK3sXFmGUPNkgULyKE1uqCS/S57ObAjYj3FrPgbqmFgP5b4LXNQX/vhkuQ1a9M4jNMg1euzU7t9ANOoJeuBEFVkIFk2x+ratZ9YEwVRv1zM5MmX4v3gXOX5gNLisizfOozJ0EhihmtnX4NNnFMjJ8pf3tP6510h/9wBssXGwbptWjE00VVOmnZXe5J5BffdT8cJlDutq4AS1a4l50iylf3gt+5K7zfSYwSRNASvqGHAGTIvjMNiTSTX/DOvyJIxCljbFnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6ixQp2H6vmI31pEXMyZPltx0QqcB1BRunE1kFGDapY=;
 b=ZUQdJHNQrs04hSZAzFoB1fz8j/XEUpqG0rmQ9LBY+D57hAFNq5nKY/ie0QzH0VUxqr8AWvq/aPhaLl7HyDDexeWKFZCG9s9D/HN3YvU/CIqjyZC28AAnRjHNI4VvUrl8njGkM54jHcL0gzOv2LoQBIH93Wd+CzLN4C8W3OCyuJ9c0/Z5APn47K2TnGeyhGeZzOzB/gIi5ZfJy3zs8FqVXUd2c5DEzPvnH4ffy/J/xSewCw1UnbKlcqixlF2U73WoQVW+BGNTn1hd7YV69AnPYi2z/RmCXz6Adf/Nu7fY4CXMXvzFoDFsNcisVutxq65UjZHjRtsaVJnuEwRscM79Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6ixQp2H6vmI31pEXMyZPltx0QqcB1BRunE1kFGDapY=;
 b=hlu/P8E6uK3Jw+cwfiK6LBMVxz7iYXAZ/jzSWwucRjGo+k1aSd4EAlBjGGkqAdYF2ve8xd5S4xuI9qBtfcDIg5YkEjV7F0b6fld/P/mGa+xJVITXFmJOL+jtVvgfpCGp6mfbM8kDiphdrMJFdA30BW5xkLUwxg6xfzZcTo3MMpk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PA4PR10MB4351.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:bd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Thu, 6 Jan
 2022 10:26:04 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9%6]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 10:26:04 +0000
Date:   Thu, 6 Jan 2022 11:26:03 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Pedro Martelletto <pedro@yubico.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] gpg-interface: trim CR from ssh-keygen
Message-ID: <20220106102603.cmb3rf4whd4hmfbb@fs>
References: <CAPig+cS6h6o2_dJAZC1M1Ace29bN2mhPgaEtTWtj3oXfcHq9cA@mail.gmail.com>
 <xmqqee5oieb2.fsf@gitster.g>
 <CAPig+cTM3wZz4NXjxYeBuFv0CVNS-T+pBFeVkfMQ-25pL1kBzw@mail.gmail.com>
 <xmqqmtkcguvm.fsf@gitster.g>
 <CAPig+cR93GyN53JoZbaiROrNtzGjiet7eTPQOk-26G+mB0KaCA@mail.gmail.com>
 <20220104125534.wznwbkyxfcmyfqhb@fs>
 <xmqqo84rcn3j.fsf@gitster.g>
 <CAPig+cQinNZp_2=eo7nokMCZ9gc-tAKO1V_jejL2Ei9J63tSDQ@mail.gmail.com>
 <20220105103611.upfmcrudw6n3ymx6@fs>
 <xmqqsfu1hq6x.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqsfu1hq6x.fsf@gitster.g>
X-ClientProxiedBy: AS9PR04CA0066.eurprd04.prod.outlook.com
 (2603:10a6:20b:48b::19) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 104443b5-46ea-4b7c-9a1b-08d9d0fef1b6
X-MS-TrafficTypeDiagnostic: PA4PR10MB4351:EE_
X-Microsoft-Antispam-PRVS: <PA4PR10MB4351345EB24F71A7A0058102B64C9@PA4PR10MB4351.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FaV9jamoz81xcAbfw4gGg2cezXTuvjPYLQ1zI28dCjW4knDbbO6p755ABg0R67FL8yCY+c84G+K2Pmr4uZQlFZTrHguooSADigp6KV3Fd6Vm4ROokWIVrXqN/n8UnO0DQzAItySpqQMIVFr05sT1cYWH1KOUzCApzy89Ww80EJnFhymdY7zO65WPiG79IZsd3szG+2WboiRSmUOUYHMGrfwwyk+vgB72mrTw4zLieMGa0Xtk2WF+BegcDvolKmqAipcMXHHYWcAVlQ6vrYJi3UL41h/VFTF1enIDU46KELqA5EP+fQDT5MSkyuLpY/oUv0SEd6GyM7OqVNPNsZyEoz7DdhZIXxIO4UvHMrVKLlX7BPlUo1Q8QnGi+Ctr3pcveZB3lm5XqdHfMrX2h8xJh6bqre4Tcd//J18xg2yRStj26ajY4sh/HI/od34PG7aNFGVWoKtXmG8mCDzTs6Yj8PhhQ2nuJZEqc8ACJ6MTWzDhdQRnLus24HfPZY/58WMaDVvLB16iorcya2H/mhDrIQXqk2Uw1UDGnR+FpnxXDW+0mQ2Q5B+NoGdkcxS9PQOwbFG3yXcZlUMciF8xaSFsHJcYK5PNTy2Bvp/T8B/oSkFJbYqQ1CLbuZwNiTxnNL/auOdKf1QOQggyoAk7+OVAYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(346002)(396003)(366004)(136003)(39840400004)(376002)(6486002)(86362001)(6512007)(66476007)(9686003)(53546011)(1076003)(66946007)(66556008)(316002)(38100700002)(6916009)(4326008)(5660300002)(8676002)(33716001)(54906003)(26005)(508600001)(186003)(8936002)(6506007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFhkSE1jZDdnNnh4SUVnTHE5RTVQR2ZsazVZNC8zNE0yMUEyODlNVGV1V0lI?=
 =?utf-8?B?Ukd3RU1leUNzTW9wNUdnTkVXWFRqUEk4ZUF4Q1p5Y1krMTJwTjhpbWdtYS91?=
 =?utf-8?B?N29GR0xldEJQaGI1c2pUeEJGekZLdTVWM2t1SjhiY2JodEtnYVo1VEpSZDJN?=
 =?utf-8?B?MW85VzBYR1JjSWp4cXF4d29Xa2tZZFVqclRHRDhreThjQTRiS2tJQmh4Wm4w?=
 =?utf-8?B?TERlMThNVWh5S2xBbGhSMkRwSk8rdHdMRHlUUFUzbGVlYWFsMmJzZDdVajlj?=
 =?utf-8?B?U1FaUmhpN1Z3cWQ3eHhNUlB3N3BHWG1naVlUUGU0dWphQ3ZMbnA2UlRBVmkw?=
 =?utf-8?B?RjcweWJjOFhMblRmamJXZzBOek1LcWt4dkpVczJHT0d5bzg4WmtxamFjdVhz?=
 =?utf-8?B?WHBqR29wM25pOFhQNmM0RXNaRmRwWGFpdWxvM0dxSTc3SW1wQWJvclo0NjB2?=
 =?utf-8?B?RHNud3RGVW00YzZqeHBhUWZXbEVxU1FCcnJkcXZrdm9zc29DZDlZdXpwQWgw?=
 =?utf-8?B?SUF4SlRRdVZqaklFQU9hUmw4bGV6bCtZTk5pc1Ewd1JaUmdWdVQyVm41SGpL?=
 =?utf-8?B?dzVGYUs3QkZXL2l6UXNRb2N2cHMwdEpITHMyN3JzVFlvYkxKNTRsSmQ5cTZl?=
 =?utf-8?B?MFQyMWgwTTRXb3pVb3Z4T21SUXluUm9Ec3Fmd2JjL2JsYzNVYVBwVjhSYkxL?=
 =?utf-8?B?ZnRBam0rNUVuRldqNzg5ekQ2dStEZkRxMlJaVU1RN0NGSGhLQTdTaXNWZE5u?=
 =?utf-8?B?YldyN3NjcVdxNmRydER5K1NWZStmT0xMdVBrcGZpYlB5d0lqUTRtSWMrVHZa?=
 =?utf-8?B?ZGVrMWRpaFBtQ1BBKzRqQzRWRkt6V3UrSzJqUjVINVplRFhraDZzdGVNNEIy?=
 =?utf-8?B?WVptZGRTQ0VxcnJYNTNnd2h6NDlQWGpBUzdNNHRyZytZd3RwZEFGUGVqTnJm?=
 =?utf-8?B?amJpblhETHBnRHBCd21kK0VldFNFa25GaGYzM1JqeWZYZnE0QkpaTlhmOW9Y?=
 =?utf-8?B?NUVBMklTSHR6Y3VOY0sxUTdaclNlbWkzdUo5VTBVdjFGOEtlMEIxZDNrYnpH?=
 =?utf-8?B?bGxFQVdFeFJqSFlwdy91eHJDaDFuUDVmRkdXM0xvaG45dnNXTWlQT1ZKSkdj?=
 =?utf-8?B?WjVLclI5UVAwNTB0aSt3Q2FpTndCWjU1amQ0VUlJU1daNjBGbTdmV0xXbFVz?=
 =?utf-8?B?YUtQaHpaR1ZpYnd3eWl5MEdwaktmZjFmdi9KT0FZODZtamVTOG5sYkF3MmRO?=
 =?utf-8?B?Uk81dHpUcW5DTDcySkVOak1rS1NvMnVLbjJDMUoxYkpmUmdGQ1dFYi9BL0lS?=
 =?utf-8?B?ZXBHYjN5TDlFaXRtcVc5cDNLU2NMd2w4N3FiMERSU0hUdGFEVlNNbGZIWTNt?=
 =?utf-8?B?dExzSjhoRlJmaS90ck9jTXUvMnhxS2dPTzIxL0JIUDJRN3ZVcWdGY2JJdlNG?=
 =?utf-8?B?eW5JdU5CV2NEbDYrbkd6YjRhbGtvbkNHOFJ4UmFOUmsxZlVZK2pMd0pwa04v?=
 =?utf-8?B?YVV2L240bkNwSUhrWjVZRmw4WldBKzcvKzBYZXpLN1ltcU9YdHBwRS83blJE?=
 =?utf-8?B?QmpGbVUzV2NFNU5LN2drWGtCWmhDamNCYTZ6cFBUU2kzblYrQTVhRExNdXA1?=
 =?utf-8?B?VVJLc3RHSFE4aWJXMUhrU1dVMmhSdUNBU1llUkZCQW1nbktIc0NUejIvcHBv?=
 =?utf-8?B?UFBUbDRGblp6TDcyM3VzREdIcmo4YmdaSmRBclMrNGp6bDlDaEZFdzduWi9r?=
 =?utf-8?B?bndHMDZJbmpvM05hUUo4cjA2RzRpSktXS3BvR2VWYjJoMjk2UlNKbitaRUl6?=
 =?utf-8?B?dEhDcEhIcnBNRitLYXdiSkthTE10cXg1Vy95U3lrMExDZElDc2hvRGxuaWtn?=
 =?utf-8?B?c2xoejV5KzdUWVZ4LzJWOTZtUDZKT2NsYVc4OUY0YTVVZVBPQU1mYlJ0aWlo?=
 =?utf-8?B?aFIzak5hOFNYYUliQU1BVU8vUDZaSTFjSThsVlg4bzllSnA5RmVjTlBKdkly?=
 =?utf-8?B?UHprUkRQcTcrQmQySmNIQTFWUGlSUHYxcFo4RU9xaGVPc25ZQkplQ1Z1cTVP?=
 =?utf-8?B?ak1TZllkWHlNRzEvMEZhUnRSQjhpQU1JVzBEQjN2QmZQbWJzNWVNczgyRDZL?=
 =?utf-8?B?WFZYWVVpK1BucEt1OWsyUS91TlA4WmdreVRQVkI3RGdJNnlNQVhyMFozaGlE?=
 =?utf-8?B?b3lydy9LR1hlSm9wNS96cGdDT3VMS1FjTVFzTE1VQ2FIdFhYeDNLVHcvdE1k?=
 =?utf-8?Q?Uw4H926H4MrFbX4fPi4QEoKUh+O8tuAfiUkx3f6wyQ=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 104443b5-46ea-4b7c-9a1b-08d9d0fef1b6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 10:26:04.6432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MyYiMibraorUmv7mrHH2wjaPXlUAi2KP78wKy2VHL/5ncaENB07xOWW9ZFRYdQBsKlsTg6XuzCQE5LZp1OP9AJaQDR/hGrwY+OquZCqOG3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4351
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05.01.2022 12:40, Junio C Hamano wrote:
>Fabian Stelzer <fs@gigacodes.de> writes:
>
>> How about something like this:
>>
>> int string_find_line(char **line, size_t *len) {
>> 	const char *eol = NULL;
>>
>> 	if (*len > 0) {
>> 		*line = *line + *len;
>> 		if (**line && **line == '\r')
>> 			(*line)++;
>> 		if (**line && **line == '\n')
>> 			(*line)++;
>> 	}
>>
>> 	if (!**line)
>> 		return 0;
>>
>> 	eol = strchrnul(*line, '\n');
>>
>> 	/* Trim trailing CR from length */
>> 	if (eol > *line && eol[-1] == '\r')
>> 		eol--;
>>
>> 	*len = eol - *line;
>> 	return 1;
>> }
>
>It is a confusing piece of "we handle one line at a time" helper.
>It is not obvious what the loop invariants are.
>
>It would be most natural to readers if *line points at the very
>beginning of the buffer, i.e. the beginning of the first line,
>and *len points at the very first character of that line, i.e. 0.
>
>But then the first thing this function worries about is a case where
>*len is not 0.  I obviously am biased, but sorry, I find what I gave
>you 100 times simpler to understand.
>

There are a few more places where the same thing happens and text is just 
split by LF, ignoring CR. The gpg parsing where this code originated being 
the most prominent example. However those just parse some parts from the 
output and the worst that seems to happen is a trailing CR in some log 
outputs.
If we are ok with this then your version is indeed the better one. If we 
want to correct the parsing at the other sites then I think a more 
generalized function would be better. Since the gpg stuff is in place for a 
long time and no one complained we can probably leave it as is. I'll prepare 
a new patch.

Thanks
