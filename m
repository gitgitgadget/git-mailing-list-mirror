Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC33C636CC
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 22:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjBPW3i (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 17:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBPW3h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 17:29:37 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04olkn2049.outbound.protection.outlook.com [40.92.75.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF27A32523
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 14:29:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYR5okHN3eUERTRQOP4xCQYz8DgvuUXhbhQ8HGIaDdYw8w6H9axIaOzLifY2GJWgzoY6/nEDUpW2u2m5oF0+xlPRrlhhq648bMknrvjOZ68p2NJhbkxw+yZ3vI7hgGENqFjol6zng9E6grK0T+2tB+529WjKb3/HqyDF50oGB0CdQ5jaKd58X3MET7CZRZ74VcRGtYENs0CMnnR0Xo9XxDLeiJQQn+M71fB3Rk1mSAGXH/jmWiMt889Oi8XO/g2Paheyy+0TqNpYrOxGrnM2V/VP17e+kGHNj8TztstuWT5PuwKyA78woQJzAqfJ9OUZf+jNYusL3E9WiTK+OhRUUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=esossI+ZiDc9t+cR7CHvly0bbVgfvwFPlUPOf67CCyQ=;
 b=DU6xQ/eDijgTQejkQ/XsweQUkyOJNM2bRgtPHWMqb81LQUMGIcCKfBoc7QuMqK4Ns0Pv4Bx0h2jqZl3AIoNgxWoI2W5XO+Fjepn1dbC3GFM7JtFv6LIYU2jiiEyN/lnsbCKNXhnItqmUqoS36vXqFuNjNo/EpDA73MjGtlABjgY6ejYOQh2fB0Oqlwe+QXkgzF4cP06cf+4I+phHA/5H3u07JxqWGeGGQnWW/YkWfxn4P9h1al7gChFqzLEHpn3SRItAd3AXea83WT3RhJtLoyBRWBBvkkNlfVsM9s/YoV3CJ9ebTHFidu9gw21LjDeChaNq4P/icY/E05/sCdbYrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esossI+ZiDc9t+cR7CHvly0bbVgfvwFPlUPOf67CCyQ=;
 b=RBcOW1ryAD1vwGXWVw50icyHve/3cfFak4ouMmMLoMfeP4371mnMDT/I05FpLZ4FTdTYG4sbA3CAf7v82WUnJtndPhysKVsJ/uwcSHpDrZnZUwE1/hPc+noSsX8efyTOHN1FSvE4tJdO8J0qyciuqzy+BBCjVf026I+IAiX+wVID+Z6TQChN46tjdhvgBLlHsaEnoT8Mao+93TnzS7P+k42QW18Hcy9LNsWVrLz10EXqjEdEg212CasMpRfQWSreZNqdbk8DjMZW8uZWrlJIX157+WVxxR0c4OBk4LE4Eev/S9Yr0jz2iSXp9YP1gF6fL6Nqy575ATaIfq+8Mp9Hqw==
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com (2603:10a6:20b:609::16)
 by AS4PR03MB8231.eurprd03.prod.outlook.com (2603:10a6:20b:4fd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Thu, 16 Feb
 2023 22:29:32 +0000
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::7674:1fe5:785:a469]) by AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::7674:1fe5:785:a469%8]) with mapi id 15.20.6086.023; Thu, 16 Feb 2023
 22:29:32 +0000
Message-ID: <AS2PR03MB981587537C03857C389BF6F4C0A09@AS2PR03MB9815.eurprd03.prod.outlook.com>
Date:   Thu, 16 Feb 2023 14:29:25 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v9 2/3] http: read HTTP WWW-Authenticate response headers
To:     Junio C Hamano <gitster@pobox.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.1352.v8.git.1675711789.gitgitgadget@gmail.com>
 <pull.1352.v9.git.1676496846.gitgitgadget@gmail.com>
 <f3f28e508c1792cbc8f8d3bd56099c659743ed3e.1676496846.git.gitgitgadget@gmail.com>
 <xmqqy1oyv7ck.fsf@gitster.g>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <xmqqy1oyv7ck.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [+ihaLOFTL8s1WvevjOR9I4N5aDQpptgMt1GUl0YfhYD0P31pQs+3lFuQLr0SSaoB]
X-ClientProxiedBy: SJ0PR03CA0349.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::24) To AS2PR03MB9815.eurprd03.prod.outlook.com
 (2603:10a6:20b:609::16)
X-Microsoft-Original-Message-ID: <e2646647-8016-1d73-671e-058e36e1996a@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR03MB9815:EE_|AS4PR03MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: ab9fd845-df79-4212-0424-08db106d4682
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gk6dYGqIb5w4jXc6CFWr3u8IUMxTRAorsM1e67j7p7EbZhaIN2w1ZlSSQIPpK8juLYLkdNdCEDqt/eGkTXinCgmHpyMGUWSicAF4bHZtN5VT0Pns+iRbkYJTFsOpWnWmxnntYOctOeMyO8I0wiaJbQrqz/zp2+gHatJaU6lB0QAN/nIWpwFT+obWvPF+JR+b2L82XA5ICn/WXsBfJcHlAkhBiWURf4D1t1U9U7+YgQuRavwiW496f96DwqED6WjoacFr60PcwY+KX2g27YVKbXNfIEhSkr9Wd3v1UtS8xA6VdZjta+7WIkNV3qjULGU6EYAh22leSGjGGZ2oCcniRpnSxIFhKfkx+wuYOnf0isrnZiRmVU/BUR+Z57TwmIAhP4/zDYCqinqNG5jMOGT38KM5xrJhAlQNr87JNUukHC5nW3RH+Osh7dZWnajy23ALs9OpZxBt3Lnoec50wwtk4a/uzfZDmHYmQOWKjaHjKo5qmV8v5HdoY5gRrGScA+HAVjePI855L6JpSUpXPpv/z3nAARKtcHuEoauUDZN/6EfUfiCbxDctw7tAATu9SNAVHZzgyepenp17qK9qZVLucdv27W+rO6h9NVEwGKfAnuxfwaVHL6NZHXLCXJ8AsloB735mro4JJQrdAF4QJQ1nAQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0pTcEFqMkdTTHFjaWVYY0FTT2NCUU9hZDliYmdlcUhva1dlMlV5dkdSN0w3?=
 =?utf-8?B?dXFqWGExYlpmTTBuYmVmbUJLeTd5dmorNlhLTitoSk5sb29RbEtnajA3NmhQ?=
 =?utf-8?B?SEovMkRqWlJDbXd5a3NrZDBQMHROZkFscUFiVy9iR05GcTVRNlpFL1pXSVlB?=
 =?utf-8?B?cTBxeDNYSlVERG9YV2poRXB5ZVJJS1ZyUy9MOXdmWmlWdm5GSGZwVjJNTk05?=
 =?utf-8?B?d0hZMXRCaEhsWnJXbEh5S20zaSsxS1VDc0YvRFErWW5OWGoveHFNT3BnSTh5?=
 =?utf-8?B?MlZyRUpXQXpFeWdueUVzbFNZUk40VUo5VTNOd25VVkdKYTZLQWRuQmduUXVa?=
 =?utf-8?B?MDlPVXcwa2hsVFovOE9NTzBpL2R6eHYwL0h1dHkwQy82UVVxQ0QzdytYdXpO?=
 =?utf-8?B?TUhRL1JMcHlpRzJrQ1o4MmpFQ29YNWFXbUh1UDlCMHE2aFZmVGFEODZyWlFJ?=
 =?utf-8?B?VDJ0cmI3M3BBYlF2N2FTVEx2OFhmOExwRzRySGVnaUQwa3lGeUtJMTB5Z2FE?=
 =?utf-8?B?Y2NiZGs2b2lWYmN1RlQvSWNWVFRXZmNVRjZ4aWJhRjVnOEEzaXVTSEJuUFJO?=
 =?utf-8?B?MXQrZU5aUUNFOUl2STBoVms2T2lCTmJQSExzMFBsaEpwZ1k2VUVnaG52L0lH?=
 =?utf-8?B?RW5LdlVHMlpKR0xqMEh1OWdPL2RqbW1pV3pSbkh6ZG5TdVJMckRsWWQrd05w?=
 =?utf-8?B?VXJJWlBYUWNSVjl2dTVJVWN2c1J3RTY3RUsvdWpMMkFCUld4cmhrUkptVWw3?=
 =?utf-8?B?VlVVR09wY3Rva3MySVpCNU1acFl0Mis3NVJGWnZlS2tWRkdMUHE2YnFTaVNX?=
 =?utf-8?B?YW9DaTk2U2VLVUc0V0lrYzg0RWFhNTdlUFBXTkZRaERkenBlUmJ0bDBUOUNv?=
 =?utf-8?B?eXhRN0Fma3VzQmEzVi92QmNZU2J1K2wxLzBJR3dFUWtTTEdXTHBVbkw1c3JV?=
 =?utf-8?B?WG5BNm0vRkp3cTg3WTFqMVMxckxkTEhlMDRrT3dpYmwzRDRtZklkTElQTkND?=
 =?utf-8?B?T3JHZjM5M2lTcSs3TkVHWkdzVlF4LzBnRVZ3NENra2l2WVJhYmlBSGRwOC9Y?=
 =?utf-8?B?cWxldzZrSHh1ZThYeitUMWR0SkU3SlpJNXFFWDBWeG9XdC9Fb1VNaElWTmJk?=
 =?utf-8?B?M0JHand1Uy81S1RvMG56NE5IOEptZEVIWEU5Um1ZcFFLZ25XcldmVS9MR1R6?=
 =?utf-8?B?TnJVVWxHWmo3S2FwVzQ5SnJZMUhaR0p0Q1BFck9ZcWhYTWdqLzdDV0tCVTVp?=
 =?utf-8?B?V0FpSStUYmtWTU5HckFVa1Q4dDB5VEhnWVBONThtbmhieVVYUzliMXVLTFln?=
 =?utf-8?B?SXIzZG85Snh5eU5SdzRTNmp5cUE5NjZua0RPVUhKZTNsMGdGbzd1Ty9TTG5m?=
 =?utf-8?B?b21jZUJiSWVYcS9aR3ZVc2N4QzNqeG42dmxTOGdWUE9scWVtVHhHdWM1cUE1?=
 =?utf-8?B?a1pmZ0pSTDk1L0xsenJVUUQ4ZHk2cGNGUDAyQ1g4UHlhV0ZIKzFQODB4bW4v?=
 =?utf-8?B?NVFvZEhkR3lBc1YrR1NvMTVxdzVJeXprTkdDSGkvcFpjZXpiK0VMcjZ1Y042?=
 =?utf-8?B?MHlyNUh0NGJITCtqTkxaSi9XUjkrWXNza2dZZ2tGMFBnQWJmOEdEcmtRNzhs?=
 =?utf-8?B?V1NHaVZDUFl6SFBUSjR5cTdkM3kwRzd0amc4cVYwd2ZQc3VIWXJwdGxqUzNs?=
 =?utf-8?B?aVBMQ2M4Zm9WMHBUR0ZnbXpiZHhhQ29uKzZWd2tSRXUwd2tkZlhRMjRmUHR3?=
 =?utf-8?B?N2c0VXFTQUZuRngvT3JmZkIvSmZnSEhhTk5DZXBlVGpDeXhXemt3Uko2NkVW?=
 =?utf-8?B?SmVkamhqR21zeFVrbFd6dz09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab9fd845-df79-4212-0424-08db106d4682
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB9815.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 22:29:32.7994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR03MB8231
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-02-15 15:26, Junio C Hamano wrote:

> "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
>> According to RFC2616 Section 4.2 [1], header field names are not
>> case-sensitive meaning when collecting multiple values for the same
>> field name, we can just use the case of the first observed instance of
>> each field name and no normalisation is required.
> 
> If the names are not case-sensitive, you can choose to first
> downcase the names you see, and use that consistently, and the
> result would still be valid.  IOW, "not case-sensitive" does not at
> all mean you have to use the first observed instance without
> normalization.  You are allowed to choose such an implementation,
> but "not case-sensitive" is not a justification to choose such an
> implementation among possible implementation that would be allowed
> under the rule.

Re-reading this paragraph, it doens't really need to even be here. This was
an artefact of a time when I was storing all headers, including keys and
values. Since we're only interested now in the WWW-Authenticate header
_values_, there's no need to call out this out. Will drop this paragraph.

>> The collection of all header values matching the WWW-Authenticate
>> header is complicated by the fact that it is legal for header fields to
>> be continued over multiple lines, but libcurl only gives us one line at
>> a time.
> 
> Saying "one physical line" at a time may make it clear what you are
> pointing out as a weak point in the interface libcURL gives us (I
> think you are getting at "if they handled header folding for us and
> fed us one logical line at a time, it would have been nicer").

Logical header fields vs physical header lines is useful and clearer
terminology - I will update the commit message to reflect in the next
iteration. Thanks!

>> @@ -22,6 +22,7 @@ void credential_clear(struct credential *c)
>>  	free(c->username);
>>  	free(c->password);
>>  	string_list_clear(&c->helpers, 0);
>> +	strvec_clear(&c->wwwauth_headers);
>>  
>>  	credential_init(c);
>>  }
>> diff --git a/credential.h b/credential.h
>> index f430e77fea4..6f2e5bc610b 100644
>> --- a/credential.h
>> +++ b/credential.h
>> @@ -2,6 +2,7 @@
>>  #define CREDENTIAL_H
>>  
>>  #include "string-list.h"
>> +#include "strvec.h"
>>  
>>  /**
>>   * The credentials API provides an abstracted way of gathering username and
>> @@ -115,6 +116,19 @@ struct credential {
>>  	 */
>>  	struct string_list helpers;
>>  
>> +	/**
>> +	 * A `strvec` of WWW-Authenticate header values. Each string
>> +	 * is the value of a WWW-Authenticate header in an HTTP response,
>> +	 * in the order they were received in the response.
>> +	 */
>> +	struct strvec wwwauth_headers;
>> +
>> +	/**
>> +	 * Internal use only. Used to keep track of split header fields
> 
> The technical term for what you call "split header" here seems to be
> "line folding" (RFC 7230, which deprecates it).
> 
>> +	 * in order to fold multiple lines into one value.
>> +	 */
>> +	unsigned header_is_last_match:1;
>> +
>>  	unsigned approved:1,
>>  		 configured:1,
>>  		 quit:1,
>> @@ -130,6 +144,7 @@ struct credential {
>>  
>>  #define CREDENTIAL_INIT { \
>>  	.helpers = STRING_LIST_INIT_DUP, \
>> +	.wwwauth_headers = STRVEC_INIT, \
>>  }
>>  
>>  /* Initialize a credential structure, setting all fields to empty. */
>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index a76d0526f79..a59230564e8 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -1266,6 +1266,29 @@ static inline int skip_iprefix(const char *str, const char *prefix,
>>  	return 0;
>>  }
>>  
>> +/*
>> + * Like skip_prefix_mem, but compare case-insensitively. Note that the
>> + * comparison is done via tolower(), so it is strictly ASCII (no multi-byte
>> + * characters or locale-specific conversions).
>> + */
>> +static inline int skip_iprefix_mem(const char *buf, size_t len,
>> +				   const char *prefix,
>> +				   const char **out, size_t *outlen)
>> +{
>> +	size_t prefix_len = strlen(prefix);
>> +
>> +	if (len < prefix_len)
>> +		return 0;
>> +
>> +	if (!strncasecmp(buf, prefix, prefix_len)) {
>> +		*out = buf + prefix_len;
>> +		*outlen = len - prefix_len;
>> +		return 1;
>> +	}
>> +
>> +	return 0;
>> +}
> 
> OK.
> 
>> diff --git a/http.c b/http.c
>> index 8a5ba3f4776..7a56a3db5f7 100644
>> --- a/http.c
>> +++ b/http.c
>> @@ -183,6 +183,124 @@ size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
>>  	return nmemb;
>>  }
>>  
>> +/*
>> + * A folded header continuation line starts with at least one single whitespace
>> + * character. It is not a continuation line if the line is *just* a newline.
>> + * The RFC for HTTP states that CRLF is the header field line ending, but some
>> + * servers may use LF only; we accept both.
>> + */
> 
> Nice.
> 
>> +static inline int is_hdr_continuation(const char *ptr, const size_t size)
>> +{
>> +	/* totally empty line or normal header */
>> +	if (!size || !isspace(*ptr))
>> +		return 0;
> 
> obs-fold (RFC7230) begins the next line with SP or HTAB, but
> isspace() allows not just SP and HT but also CR and LF.  So
> this is a bit pessimistic but rejects what is not a folded
> continuation line reliably.
> 
>> +	/* empty line with LF line ending */
>> +	if (size == 1 && ptr[0] == '\n')
>> +		return 0;
> 
> And this is a blank line after the headers, with LF (not conforming
> but is OK).
> 
>> +	/* empty line with CRLF line ending */
>> +	if (size == 2 && ptr[0] == '\r' && ptr[1] == '\n')
>> +		return 0;
> 
> And this is another form of a blank line after the headers, with
> CRLF.
> 
>> +	return 1;
>> +}
> 
> After rejecting the above two "blank", it is a folded continuation
> line.  OK.
> 
> I wonder if
> 
> 	static inline int ... () {
> 	  	return (size && (*ptr == ' ' || *ptr == '\t'));
> 	}
> 
> sufficient and easier to grok, though.

You're correct. This implementation is 'more correct' and easier to grok.

>> +static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p)
>> +{
>> +	size_t size = eltsize * nmemb;
>> +	struct strvec *values = &http_auth.wwwauth_headers;
>> +	struct strbuf buf = STRBUF_INIT;
>> +	const char *val;
>> +	size_t val_len;
>> +
>> +	/*
>> +	 * Header lines may not come NULL-terminated from libcurl so we must
>> +	 * limit all scans to the maximum length of the header line, or leverage
>> +	 * strbufs for all operations.
>> +	 *
>> +	 * In addition, it is possible that header values can be split over
>> +	 * multiple lines as per RFC 2616 (even though this has since been
>> +	 * deprecated in RFC 7230). A continuation header field value is
>> +	 * identified as starting with a space or horizontal tab.
>> +	 *
>> +	 * The formal definition of a header field as given in RFC 2616 is:
>> +	 *
>> +	 *   message-header = field-name ":" [ field-value ]
>> +	 *   field-name     = token
>> +	 *   field-value    = *( field-content | LWS )
>> +	 *   field-content  = <the OCTETs making up the field-value
>> +	 *                    and consisting of either *TEXT or combinations
>> +	 *                    of token, separators, and quoted-string>
>> +	 */
>> +
>> +	/* Start of a new WWW-Authenticate header */
>> +	if (skip_iprefix_mem(ptr, size, "www-authenticate:", &val, &val_len)) {
>> +		strbuf_add(&buf, val, val_len);
>> +
>> +		/*
>> +		 * Strip the CRLF that should be present at the end of each
>> +		 * field as well as any trailing or leading whitespace from the
>> +		 * value.
>> +		 */
>> +		strbuf_trim(&buf);
>> +
>> +		strvec_push(values, buf.buf);
>> +		http_auth.header_is_last_match = 1;
>> +		goto exit;
> 
> OK.  We remember that we have seen the beginning of a header we are
> interested in (so that we can append if it is a continuation we see
> next).  Good.
> 
>> +	}
>> +
>> +	/*
>> +	 * This line could be a continuation of the previously matched header
>> +	 * field. If this is the case then we should append this value to the
>> +	 * end of the previously consumed value.
>> +	 */
>> +	if (http_auth.header_is_last_match && is_hdr_continuation(ptr, size)) {
>> +		/*
>> +		 * Trim the CRLF and any leading or trailing from this line.
>> +		 */
>> +		strbuf_add(&buf, ptr, size);
>> +		strbuf_trim(&buf);
>> +
>> +		/*
>> +		 * At this point we should always have at least one existing
>> +		 * value, even if it is empty. Do not bother appending the new
>> +		 * value if this continuation header is itself empty.
>> +		 */
>> +		if (!values->nr) {
>> +			BUG("should have at least one existing header value");
> 
> OK, we should set _is_last_match to true only after we recorded the
> header that might see a continuation, so it would be a bug if we
> didn't have anything there.  Good.
> 
>> +		} else if (buf.len) {
>> +			char *prev = xstrdup(values->v[values->nr - 1]);
>> +
>> +			/* Join two non-empty values with a single space. */
>> +			const char *const sp = *prev ? " " : "";
>> +
>> +			strvec_pop(values);
>> +			strvec_pushf(values, "%s%s%s", prev, sp, buf.buf);
>> +			free(prev);
>> +		}
>> +
>> +		goto exit;
> 
> Good that we are prepared to see a logical line split over more than
> two lines (i.e. by not toggling _is_last_match off prematurely here).
> 
>> +	}
>> +
>> +	/* This is the start of a new header we don't care about */
>> +	http_auth.header_is_last_match = 0;
> 
> Or what we just saw and ignored could be a continuation line of a
> header we ignored.  The comment is slightly misleading.

I'll try and reword this to make it more accurate - we have determined
this line is not a continuation of the previous WWW-Authenticate header.

> Other than that, looking good.
> 
> Thanks.
