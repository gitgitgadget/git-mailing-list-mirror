Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70B59203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 20:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790AbcGYUXz (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 16:23:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55215 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752646AbcGYUXx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 16:23:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 77FF42EB62;
	Mon, 25 Jul 2016 16:23:52 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y4img0f2/BXMT7qYTyTX6LMq9V0=; b=EPhaOq
	8STftu5VWBKNtUCdBPV7PS0bGcV1hp9iInFkuj3Hn8OQ9ZKw8grUfaR+4s2Wed08
	SwmulwAZDxJ4PP8M8xuQaj7N8Chc2nGjsPtQoAc8lYWtr2qSITnXwQgDQ4Ooh2hD
	9DHoYrTwhndfrzlZr3hJu2aClchoV8oUsRWmg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xcoadKfXbyJ+X3Ha07rtxPyLlfKI/n/j
	5qcrUp+EGT5V4BFai6+S7rQVYfROIMgdbaHHKj+LjBWYk01JnODiqeBQrSi8GNyv
	PkSsWnvnbZWp1/IGtWVmbrnSLX7zpb4XMaVzVs1tHQisFTtjyWcX9vvDdoeTZIEC
	g8L88BJox1Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6F61C2EB61;
	Mon, 25 Jul 2016 16:23:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E89F22EB60;
	Mon, 25 Jul 2016 16:23:51 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff Hostetler <jeffhost@microsoft.com>
Cc:	git@vger.kernel.org, git@jeffhostetler.com, peff@peff.net,
	Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v2 5/8] status: print per-file porcelain v2 status data
References: <1469474750-49075-1-git-send-email-jeffhost@microsoft.com>
	<1469474750-49075-6-git-send-email-jeffhost@microsoft.com>
Date:	Mon, 25 Jul 2016 13:23:49 -0700
In-Reply-To: <1469474750-49075-6-git-send-email-jeffhost@microsoft.com> (Jeff
	Hostetler's message of "Mon, 25 Jul 2016 15:25:47 -0400")
Message-ID: <xmqqwpk94gbu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B3C1F906-52A5-11E6-8A38-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff Hostetler <jeffhost@microsoft.com> writes:

> +static void wt_porcelain_v2_print(struct wt_status *s);
> +

There is no point in this forward declaration, if you just place the
implementation of these functions here, no?

> +/*
> + * Print porcelain v2 info for tracked entries with changes.
> + */
> +static void wt_porcelain_v2_print_changed_entry(
> +	struct string_list_item *it,
> +	struct wt_status *s)
> +{
> +...
> +	fprintf(s->fp, "%c %s %s %06o %06o %06o %s %s R%d %s",

It is misleading to always say R in the output when there is no
rename, isn't it?

> +	 * Note that this is a last-one-wins for each the individual
> +	 * stage [123] columns in the event of multiple cache rows
> +	 * for a stage.

Just FYI, the usual lingo we use for that is "multiple cache entries
for the same stage", I would think.

> +	 */
> +	memset(stages, 0, sizeof(stages));
> +	sum = 0;
> +	pos = cache_name_pos(it->string, strlen(it->string));
> +	assert(pos < 0);
> +	pos = -pos-1;
> +	while (pos < active_nr) {
> +		ce = active_cache[pos++];
> +		stage = ce_stage(ce);
> +		if (strcmp(ce->name, it->string) || !stage)
> +			break;
> +		stages[stage - 1].mode = ce->ce_mode;
> +		hashcpy(stages[stage - 1].oid.hash, ce->sha1);
> +		sum++;
> +	}
> +	if (!sum)
> +		die("BUG: unmerged entry without any stages");

Hmm, we seem to already have d->stagemask; if you call that variable
"sum" anyway, perhaps its computation can be more like

	sum |= 1 << (stage - 1);

so that you can compare it with d->stagemask for this sanity check?

