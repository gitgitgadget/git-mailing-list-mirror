Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B96EF1F461
	for <e@80x24.org>; Tue, 25 Jun 2019 20:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbfFYUBA (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 16:01:00 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58807 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfFYUBA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 16:01:00 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9F9C483959;
        Tue, 25 Jun 2019 16:00:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=68z2g6WgnbMstsB7IjTC3SBnE/4=; b=WDF8ru
        bCmSVrOC3H6RbvLL35rHOCsjybHdNY2r59ozFg1FBtDmSYAeSKERivKNhp98M9zs
        t7HKedkoDScKEqlbmiB5aJ+Gxb+W59+cU6dN9YilpwOLtlVB1L3sU7lomA0NGb0s
        Q+ehnLULeycRkCOroDu1J/e1oL7NF8P434hUY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=R1fS1twJBkZWS5quT5BRjydLiUpNBPTN
        nFMGy/Id2k/t3qaxyCRAduLsfdycUSWWJ2CFJvims2qATGGCN7xOCNhj2EQn8JyL
        c+cBVScF9RxcZXs8oBU0Pf6vnD4yJoTEi4F08Bj/qq2f5SDr/0ojIuw9HXVuhOzJ
        /XVIo0INEOE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 89FF783958;
        Tue, 25 Jun 2019 16:00:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BD84683957;
        Tue, 25 Jun 2019 16:00:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v5] l10n: localizable upload progress messages
References: <20190625062540.88973-2-dimitriy.ryazantcev@gmail.com>
Date:   Tue, 25 Jun 2019 13:00:50 -0700
In-Reply-To: <20190625062540.88973-2-dimitriy.ryazantcev@gmail.com> (Dimitriy
        Ryazantcev's message of "Tue, 25 Jun 2019 09:25:40 +0300")
Message-ID: <xmqqzhm5e8p9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EF9AD472-9783-11E9-8DC9-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com> writes:

> Currenly the data rate in throughput_string(...) method is
> output by simple strbuf_humanise_bytes(...) call and '/s' append.
> But for proper translation of such string the translator needs
> full context.
>
> Add strbuf_humanise_rate(...) method to properly print out
> localizable version of data rate ('3.5 MiB/s' etc) with full context.

Hmph, so idea is that appending translation of "/s" to translation
of "1.4MiB" may not be a good enough translation of "1.4MiB/s"?

That does sounds like a good idea, but looking at the heavy
duplication of implementation, I would have to say "Yuck" to it.

I wonder if an approach like the following illustration would work
better?  I am not sure how well Q_() and N_() would interact with
each other, though.

-- >8 --

struct human_format {
	const char *giga;
	const char *mega;
	const char *kilo;
	const char *byte;
	const char *bytes;
};

static void strbuf_humanise(struct strbuf *buf, off_t bytes, struct human_format *fmt)
{
	if (bytes > 1 << 30) {
		strbuf_addf(buf, _(fmt->giga), 
			    (unsigned)(bytes >> 30),
			    (unsigned)(bytes & ((1 << 30) - 1)) / 10737419);
	} else if (bytes > 1 << 20) {
		unsigned x = bytes + 5243;  /* for rounding */
		strbuf_addf(buf, _(fmt->mega),
			    x >> 20, ((x & ((1 << 20) - 1)) * 100) >> 20);
		strbuf_addstr(buf, _(""));
	} else if (bytes > 1 << 10) {
		unsigned x = bytes + 5;  /* for rounding */
		strbuf_addf(buf, _(fmt->kilo),
			    x >> 10, ((x & ((1 << 10) - 1)) * 100) >> 10);
	} else {
		strbuf_addf(buf, Q_(fmt->byte, fmt->bytes,
				    (unsigned)bytes), (unsigned)bytes);
	}
}

void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes)
{
	struct human_format bytes_fmt = {
		.giga = N_("%u.%2.2u GiB"),
		.mega = N_("%u.%2.2u MiB"),
		.kilo = N_("%u.%2.2u KiB"),
		.byte = N_("%u byte"),
		.bytes = N_("%u bytes"),
	};
	strbuf_humanise(buf, bytes, &bytes_fmt);
}

void strbuf_humanise_rate(struct strbuf *buf, off_t bytes)
{
	struct human_format rate_fmt = {
		.giga = N_("%u.%2.2u GiB/s"),
		.mega = N_("%u.%2.2u MiB/s"),
		.kilo = N_("%u.%2.2u KiB/s"),
		.byte = N_("%u byte/s"),
		.bytes = N_("%u bytes/s"),
	};
	strbuf_humanise(buf, bytes, &rate_fmt);
}
