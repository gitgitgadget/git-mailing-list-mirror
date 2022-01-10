Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA19C433EF
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 13:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbiAJNAl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 08:00:41 -0500
Received: from mail-db8eur05on2068.outbound.protection.outlook.com ([40.107.20.68]:3617
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235574AbiAJM7G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 07:59:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S69GkqFdNDeJ6Kn643vC6eGS9EJrIHT2wvR14jQ2i8Xomm213YX3CBRgpvATIQJ5ez66g50Ud8d0ldaGZ3TxDViOkESuo8Y0AtdJNzZTcTzpMeg0s6uxakEEt6BzMr+FMHKmuckgPJjH6M350PIGs6CWML6WcKw/lglz316jkUYKqrh+HLVePuyhHH6HSCW0D9MpstQgn15QAG1zOJM5ZbexBn+C4H8nsAeXRqrpyVwtkyK0W7EBftAsBOk3Xc3AFU54Jm+FRGINODXBIcm04hG+oaQBC7PZI2BgCeTt/5VIOit/fKoDodej87NACL9Dz9L/IQTj7UDGvXQozZ+WjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dteQX4rkiOgVg8ATkjTY/naxPX78l6tINhERc2rPW64=;
 b=cxUQkZLLw+Alp1ZMUXwG9x9WwF3eTU5tq0jr1CrT4B1LLavsjKku9A5cGDfctS5sws4+eGp/PjxNT6n2MwTfHwR0OvKGn/VyTZ1cKUiYUTMfWZETi17rxH/Atr7lth/Qib/GrM1s5EmArK8JIOZm8f2/QjSwB0IRrNMOu9WKe92mo++MKkb7OrI7zrrKVGmrO6Xibl5GBq+w491lP8yA5vo4xgHoR1Ivl2f4uyZCCSAX/c4+v3ICxlxwJiGo/ilZiKbOhHViZvomSszy1lK5yHJCL+lAHuhdtUvR7ftwucqtWZvPf6VMfmOJwdItutv8yuerrOp/pWMLkgQZcBzkgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dteQX4rkiOgVg8ATkjTY/naxPX78l6tINhERc2rPW64=;
 b=NAYYqnW9jewidZRdLD/LIAF8UHdq6f1bxPVdCjiqgqQMhxhhYsB/jAjfncRzrpyDuRTeN15Idi/wnZGjycVJA5LMvLa/Z7jLdwlwoeVj1jo6f/n1Uu4Z7T7S0PuRX4kddMUiRpPw5IRUJIdmtNQACFj7usBWXR7/Ytobrja8Cus=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4255.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Mon, 10 Jan
 2022 12:59:02 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9%6]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 12:59:02 +0000
Date:   Mon, 10 Jan 2022 13:59:01 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Pedro Martelletto <pedro@yubico.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3] gpg-interface: trim CR from ssh-keygen
Message-ID: <20220110125901.apxqy7tzrc3edjwa@fs>
References: <20220103095337.600536-1-fs@gigacodes.de>
 <20220107090735.580225-1-fs@gigacodes.de>
 <YdtVrT4gBvnXfNr6@flurp.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <YdtVrT4gBvnXfNr6@flurp.local>
X-ClientProxiedBy: AS9PR05CA0031.eurprd05.prod.outlook.com
 (2603:10a6:20b:489::18) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36a2a0c3-db30-4834-08d6-08d9d438f9f1
X-MS-TrafficTypeDiagnostic: PR3PR10MB4255:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB4255BC599D6689C0E9CEC0DFB6509@PR3PR10MB4255.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lyVgN8tbvaeqp62xQBpS9lD8lqdnbS7e9oJEPlA2Z7HM1NkbO6EZz8DJhkO399f4ecdx2COrWae4SJXtQgLXfK491AdvcPnSPOXo2YqaWreOj0wUPQwofQ86FVHU+ZfIrkHH5NUVG4tY+p3c33ODIHYOFrfwuX1eTD5sMaber55BqWTuAOTTG+ugTmCFNuMlRdeG5G5HqZ4UbkQHh1fbop9NT/ep0uWFq6rWxuzcmvwgnhjFBcpow0SdCAR6DUbX8G54Kf6KCGf3UPlrOnRA3bkP8q1eAYEJdrQ5Plpb/lg6t/amKY7CGynMdt3YlMrzEk+Z8fHgLuBtkIlFR3LtPevOyzgexIwhKFBvWgrHjjNslgtIVrmuJ4eeKgU9QYVgNNG9XrFhCuvnFdPjHuVqomPODCGbqtpaOm7RdCv/DZ9SsZH0rkFtDKR2DrBCeCroKD+30l1Pw3gxT000Q9+yM5PESqx/HrvVd6i5BhRcdutUfNQqZ0aDZkEi8VpiK0iYGVF+E3RYiyoqzg8IGPMKzZSp1X00LT+Ai0eXWQqeNvDqxiHuWACkzvaCMjgnXXwy9y8KCJczHU+VfWlF5pkHUcsqvi0gSDUWUvaDHA4eIlTUTjObwuT7rJm2TsBurSR/pqJuNku4fTgqcGY6p8NxrcpL81uTDa7gd83mqFmSlOuWQhjS++BUwofLCQs0xbgexMq5dPMlsI1VvXXEnQvOLMBljEFUzRCl9jOHOulaC0w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(396003)(136003)(39840400004)(376002)(366004)(346002)(8936002)(5660300002)(4326008)(26005)(9686003)(1076003)(8676002)(6512007)(966005)(33716001)(316002)(508600001)(6486002)(66946007)(66476007)(66556008)(83380400001)(54906003)(2906002)(6916009)(186003)(38100700002)(86362001)(6506007)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVZzS2xRWWtXUWNCOVVzSytOTEVHQTR3WEVzcUZpMS9XSkxmcmJRdFFUaE1M?=
 =?utf-8?B?T3E5OUNNR3FjZm00TEV3M21pcG9IM2QwbVk4c0hRenFDa0hWQ2R6SXU0YVQx?=
 =?utf-8?B?cUo1MU1kSmRYbDZGSXZZUkpiSjRBK0JHQm55SXliM0NNS3lUb2F4b0twOTIz?=
 =?utf-8?B?TTVuZHBOM2Z3cnVPMldZS3M4ODlObnJGazQxWGY3TXlLcnpwajJPTkpIVVdI?=
 =?utf-8?B?WnVyQXpqRlcxNFlUMDh6YWVUazNPaEYrQkFNM3ZObWNjQXRqMmtmZlFmTmlJ?=
 =?utf-8?B?UEpNRlRQM2tadmN1OXUxTllaaXdPNk5HVStUa0NIOWdIZm9abG1MckNKY3RG?=
 =?utf-8?B?Mk1ScjRPdHhucXFEU01yMnJ4cHZNRE93cCtaWkNXRS82V1p4d3VHaUZIbHhF?=
 =?utf-8?B?bVNoRzgvMDlBZFkrMFVKRHEwNWtKTmdyRGRTWFBvVzFNZkQrSlV3ckdqTjBh?=
 =?utf-8?B?NDVnNHR6d09RZXFFc2tMd3I0cGZXZHQ5aVptR0ZFcGNFQWtLcXBnY2VHK3Z3?=
 =?utf-8?B?SE1INzNycWdleG9JY3cxTXBsZEdLcXBtT1RvOXdudzJ4NDIvbUZtUCtwS05w?=
 =?utf-8?B?SFVUOGFMTTJEYkxOb0NhRENWUDRZejk0SGFvb05ySFhlWCtmQURZWkdLdThj?=
 =?utf-8?B?NTcyQUk5d1lGeXcvV0VDQ3JQVGlBVEtVdGd1UDBwT2lLVVN0QkRUZnV0RE9J?=
 =?utf-8?B?OGxNMVZzWXRoQTB6WHpoUXRldDBCRWNEVS9aNFVBcXN6YjhRVERCVlRQRVMz?=
 =?utf-8?B?N2V2UTJrcVVpYklDOGZTM3NMMVdNN0pMMVlNNzYzMGdxT2RmNUNVVXpzeVEz?=
 =?utf-8?B?YkpNZ1laY3RIUHRSOGhkdC93dCtsRG9McFVmaEpydE4vdFI3dDlSSm56czV5?=
 =?utf-8?B?RVJ6b0JpNWRmeS9ORDJwVEpSTWVkSkg0MDZROXVCUnBLK29MUU4yMG9xVVc3?=
 =?utf-8?B?aFVaNHJqdjhnQ2FpelpldXBSMndVZlpUV2RlSnZJcVY0UGU2bnVHQzRkNkxi?=
 =?utf-8?B?enJkZGVLVG1YODRENFBha0dad1BENGwvUml4blBqcEovSkFpbjByalYzaEtm?=
 =?utf-8?B?S2dRWTZHV2xkdzFpL2pseUo1NHh5L1NKSlJ2aFlqNlJXU3JVcmlEQzIzeG1N?=
 =?utf-8?B?N0dGTHJOQmZJbnJIUFo5WGthWDFZN3A1R2pPWkQ3bi90d2RNeEZIODJrckhu?=
 =?utf-8?B?Zm9TNDhyWjc0c0xuWjdWOHloS0UzOHNmaGR5ellhQnFjcjRPWU01UFNYYkZB?=
 =?utf-8?B?TWQ4bUZZVDlSMy91SnA0bHVCR3FqR1M1Ym9QazZjd1pMZWhKUjNCZGNiTjNu?=
 =?utf-8?B?U1NXY215bU0wTVFmYlMvNW5aNFVsTDd2Yi83WXB3Y2taSERucGZUSlVqY2RK?=
 =?utf-8?B?b0hUOXlWRk56aUZpL3RMZHZoclpJZzFWVHRwYmh3QU9HcXhBK0tQdjc2QzEr?=
 =?utf-8?B?c3VqYXRMV3RuUXpUY2lQS2xua3QxYkhmMjB4VFJ4bGpVMVpxZ0M5cno5RnAr?=
 =?utf-8?B?cEtQdElCNysrN2lFNG5VQy9hYXFLSG1xV0dySHZLUXo1ZzBhamZSblA0VHJP?=
 =?utf-8?B?WlV4NHJpMXJNNkN2OWRjYjZKeC9rdVpMUzdsODhvVHZ4NU9RcWduQzF0OHI5?=
 =?utf-8?B?QkdmWVBad1o1L3U3Rzcwa2laSVIrV252UWwxd0F5dytmd3RRMzZZUlBLK1J1?=
 =?utf-8?B?OCtITE5GQ3VZREdpSHFUKzl5QTJPN05od0lELzljc0lRVERHOEc3VjFNRFNu?=
 =?utf-8?B?N0laVWp3ZEZFcVU0TEtoUXJ4ZTJ5a2R4TGhCc05ubzRGaGxpSjBqM1NLWFpK?=
 =?utf-8?B?SE1TSVhsV2JHUWQwazFhYUJxaUQ3TVMzV2Z5Rk95Sy9RdWpnVEs3QTNVWTFP?=
 =?utf-8?B?MlBlWktyTmJjZXRtUERueXYyeExnWnFJc3pKN2xjbEljRkFQeXlLL1ZpMHlW?=
 =?utf-8?B?d0U3K3Z4WFFaMHBjVDh4MnJSdzkvUUZGcXlZTGw1M0hDWXR6OSsrUmpMejFK?=
 =?utf-8?B?TDhUTmZFUmtSelNaMnQvTHZhV2NuWk9lNjM1SkFuUHNtUERtdzdqbmdLZjhZ?=
 =?utf-8?B?UnRSbTVWMHhySVBZclg5MWYzb05yS3JBTW9VSllaQzNEaVZHRlgvRHcwL3A5?=
 =?utf-8?B?TGFSNWVTYnQ2dTZKQzlWSFhhandqd1lvc052TEplMkNzMGNweEFZSzhLSFFk?=
 =?utf-8?B?VGZPbU5GRFE2RjBzeVZMYXdWQkZUL1BxaG50QzMwcExQcEJYNy9QNWYyVlc4?=
 =?utf-8?Q?r8Bysdh3oxQgG+SYYfmMDh/ezvSfKdj/XrwKpn/1VA=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a2a0c3-db30-4834-08d6-08d9d438f9f1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 12:59:02.7778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W5PmtlbTivaSrpiUgKWO5Zu5s4TXk9gqw129xQx8Kv/d6wA6ZKlgdTIj6zfahD4+o/XpOOBLpoD7Hsyuu2yrFg5c6D22fNm9+hupm5BdK9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4255
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09.01.2022 16:37, Eric Sunshine wrote:
>On Fri, Jan 07, 2022 at 10:07:35AM +0100, Fabian Stelzer wrote:
>> We need to trim \r from the output of 'ssh-keygen -Y find-principals' on
>> Windows, or we end up calling 'ssh-keygen -Y verify' with a bogus signer
>> identity. ssh-keygen.c:2841 contains a call to puts(3), which confirms
>> this hypothesis. Signature verification passes with the fix.
>>
>> Helped-by: Pedro Martelletto <pedro@yubico.com>
>> Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
>
>Should this also have a "Helped-by: Junio" since this code was heavily
>inspired by his suggestion[1]?

Yeah, this should have a "Written-by: Junio" ^^
I'm never sure when to add these headers (except the signed-off).

>
>[1]: https://lore.kernel.org/git/xmqqo84rcn3j.fsf@gitster.g/
>
>> ---
>> diff --git a/gpg-interface.c b/gpg-interface.c
>> @@ -502,15 +501,30 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
>> +		const char *next;
>> +		for (line = ssh_principals_out.buf;
>> +		     *line;
>> +		     line = next) {
>> +			const char *end_of_text;
>> +
>> +			next = end_of_text = strchrnul(line, '\n');
>> +
>> +			 /* Did we find a LF, and did we have CR before it? */
>> +			if (*end_of_text &&
>> +			    line < end_of_text &&
>> +			    end_of_text[-1] == '\r')
>> +				end_of_text--;
>> +
>> +			/* Unless we hit NUL, skip over the LF we found */
>> +			if (*next)
>> +				next++;
>> +
>> +			/* Not all lines are data.  Skip empty ones */
>> +			if (line == end_of_text)
>> +				continue;
>> +
>> +			/* We now know we have an non-empty line. Process it */
>> +			principal = xmemdupz(line, end_of_text - line);
>
>Considering that this code makes a copy of the line _anyhow_ which it
>assigns to `principal`, it still seems like it would be simpler and
>far easier to understand at-a-glance to instead take advantage of one
>of the existing string-splitting functions. For instance, something
>like this:
>
>    struct strbuf **line, **to_free;
>    line = to_free = strbuf_split(&ssh_principals_out, '\n');
>    for (; *line; line++) {
>        strbuf_trim_trailing_newline(*line);
>        if (!(*line)->len)
>            continue;
>        principal = (*line)->buf;
>
>keeping in mind that strbuf_trim_trailing_newline() takes care of
>CR/LF, and with appropriate cleanup at the end of the loop:
>
>        strbuf_list_free(to_free);
>
>(and removal of `FREE_AND_NULL(principal)` which is no longer needed).
>
>Something similar can be done with string_list_split(), as well.

I agree that this is the most readable of the variants (and it works just as 
well). Since in most cases there even will only ever be a single line of 
output the extra work/allocation we might be doing with it is quite minimal.

I have done something quite similar in get_default_ssh_signing_key() and got 
a bit of negative feedback for it (being overkill for retrieving a single 
line) but ended up using it anyway.
