Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7878B1F462
	for <e@80x24.org>; Thu, 25 Jul 2019 16:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387616AbfGYQzv (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 12:55:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59516 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387526AbfGYQzv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 12:55:51 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1371815D3EC;
        Thu, 25 Jul 2019 12:55:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b1IQ/u0uE4e7tQxU8xnpeL7dMiE=; b=GKr6k4
        e8VQztnoGGOk+bshEnG7RqS7JTHYS6I72+BPbLFBU+FQYFudbssQUZjTZRS/qXSQ
        7k9LnEoM6iLOzixTXlgzk8d1QNr8AmNMk6RAJkB6msBVGGexI8puCVfi7m5TVidX
        M2vwwpUWbh+s5Yv58gDMhXDgQ2Aic7tylfjlQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AbDMTVMPwGRACUBX4baeAxT03p1kCEx4
        +Z6SQjQin4w3qVXvJAWoUVg16HbhgioQDdbmJOOLtRzmxaoWbCn6tA/fdTXVv9tc
        7RdTDtCE6jOVo9oyCADSWVKV2/naN5/6D3pZ1HYvDnK7z9xh4HA0t4fOH6zpgG2U
        MWziam6eM+0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B78D15D3EA;
        Thu, 25 Jul 2019 12:55:49 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5732915D3E8;
        Thu, 25 Jul 2019 12:55:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, avarab@gmail.com,
        peff@peff.net, jnareb@gmail.com
Subject: Re: [PATCH v3 1/3] trace2: Add a JSON schema for trace2 events
References: <cover.1560295286.git.steadmon@google.com>
        <cover.1564009259.git.steadmon@google.com>
        <d4e82796bccacfbe9493b68f49368d4bb1e41e7b.1564009259.git.steadmon@google.com>
Date:   Thu, 25 Jul 2019 09:55:47 -0700
In-Reply-To: <d4e82796bccacfbe9493b68f49368d4bb1e41e7b.1564009259.git.steadmon@google.com>
        (Josh Steadmon's message of "Wed, 24 Jul 2019 16:06:51 -0700")
Message-ID: <xmqqlfwmoxyk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D3FC466-AEFD-11E9-B90E-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> diff --git a/t/trace_schema_validator/README b/t/trace_schema_validator/README
> new file mode 100644
> index 0000000000..45f0e6f0c4
> --- /dev/null
> +++ b/t/trace_schema_validator/README
> @@ -0,0 +1,23 @@
> +These JSON schemas[1] can be used to validate trace2 event objects. They
> +can be used to add regression tests to verify that the event output
> +format does not change unexpectedly.
> +
> +Four versions of the schema are provided:
> +* event_schema.json is more permissive. It verifies that all expected
> +  fields are present in a trace event, but it allows traces to have
> +  unexpected additional fields. This allows the schema to be specified
> +  more concisely by factoring out the common fields into a reusable
> +  sub-schema.
> +* strict_schema.json is more restrictive. It verifies that all expected
> +  fields are present and no unexpected fields are present in the trace
> +  event. Due to this additional restriction, the common fields cannot be
> +  factored out into a re-usable subschema (at least as-of draft-07) [2],
> +  and must be repeated for each event definition.
> +* list_schema.json is like event_schema.json above, but validates a JSON
> +  array of trace events, rather than a single event.
> +* strict_list_schema.json is like strict_schema.json above, but
> +  validates a JSON array of trace events, rather than a single event.
> +
> +[1]: https://json-schema.org/
> +[2]: https://json-schema.org/understanding-json-schema/reference/combining.html#allof
> +

Trailing blank line.

I am puzzled why my "git am --whitespace=warn -sc3" is not giving
me a warning on this patch...
