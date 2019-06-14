Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C3371F462
	for <e@80x24.org>; Fri, 14 Jun 2019 15:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbfFNP7q (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 11:59:46 -0400
Received: from siwi.pair.com ([209.68.5.199]:51828 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbfFNP7p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 11:59:45 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 67C4C3F48AA;
        Fri, 14 Jun 2019 11:59:44 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:31f7:1de2:546:4d13] (unknown [IPv6:2001:4898:a800:1012:e32a:1de2:546:4d13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 2AD6A3F48A8;
        Fri, 14 Jun 2019 11:59:44 -0400 (EDT)
Subject: Re: [RFC PATCH 2/3] trace2: Add a JSON schema for trace2 events
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
References: <cover.1560295286.git.steadmon@google.com>
 <8dd0277222efa265f1e911c8476305feb3c2c3fb.1560295286.git.steadmon@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <c624600c-42d6-d68f-28c1-916efc6b38b6@jeffhostetler.com>
Date:   Fri, 14 Jun 2019 11:59:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <8dd0277222efa265f1e911c8476305feb3c2c3fb.1560295286.git.steadmon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/11/2019 7:31 PM, Josh Steadmon wrote:
> Define a JSON schema[1] that can be used to validate trace2 event
> objects. This can be used to add regression tests to verify that the
> event output format does not change unexpectedly.
> 
> Two versions of the schema are provided:
> * event_schema.json is more permissive. It verifies that all expected
>    fields are present in each trace event, but it allows traces to have
>    unexpected additional fields. This allows the schema to be specified
>    more concisely by factoring out the common fields into a reusable
>    sub-schema.
> * strict_schema.json is more restrictive. It verifies that all expected
>    fields are present and no unexpected fields are present in each trace
>    event. Due to this additional restriction, the common fields cannot be
>    factored out into a re-usable subschema (at least as-of draft-07) [2],
>    and must be repeated for each event definition.
> 
[...]
> +
> +		"data-json_event": {
> +			"allOf": [
> +				{ "$ref": "#/definitions/event_common_fields" },
> +				{
> +					"properties": {
> +						"event": { "const": "data-json" },
> +						"repo": { "type": "integer" },
> +						"t_abs": { "type": "number" },
> +						"t_rel": { "type": "number" },
> +						"nesting": { "type": "integer" },
> +						"category": { "type": "string" },
> +						"key": { "type": "string" },
> +						"value": true
> +					},
> +					"required": [
> +						"event", "t_abs", "t_rel", "nesting", "category", "key",
> +						"value"
> +					]
> +				}
> +			]
> +		}
> +	},
[...]

Here you have "value" as just a boolean rather than a sub-object.
Is that a limitation of the schema tools?  I guess this is reasonable
since the contents of the sub-object are variable and you wouldn't be
able to verify it anyway.

Jeff

