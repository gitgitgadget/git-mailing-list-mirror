Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D47FC433E2
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 19:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41A7C21D81
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 19:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vGT4kcfz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgIJTfJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:35:09 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51652 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731403AbgIJPpD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 11:45:03 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 72769FE224;
        Thu, 10 Sep 2020 11:04:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z+foi43K7wJ3tZbSha/FvSQHuNg=; b=vGT4kc
        fzuyDet/LQ34eEIVpSnbMyDZYeMdh4POIpaBmbopjEPmJyr1+3RYhMsxV7iVYSSx
        GWHjA4pfhavsU30IWS0+3SbT/i33m23OJjo0+Hu9zLn26T1H5mknYlJnzlQAysLz
        fP4NKJt/rgvA8V3Tq06CvGetM2bfmr8w9EFNU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bLKRHRgwHhVSOjqkxIKa3Uxi1hstTBIE
        fWjUz42Mn1KJK6qCC33EjhxVeuZ2T+s5u90qigWnXwDdpkoTTsgCo/flXY0TsRLQ
        7FxJLzui7Gs/5NKCEMjTAiiv01+1GLjQaWZpqkM6hOQEouOV8cq0Or1TPEhxb/W2
        uWSF6c8HxJg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6A650FE223;
        Thu, 10 Sep 2020 11:04:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5BB2FFE222;
        Thu, 10 Sep 2020 11:04:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/6] quote_path: give flags parameter to quote_path()
References: <20200908013013.1099937-1-sandals@crustytoothpaste.net>
        <20200908205224.4126551-1-gitster@pobox.com>
        <20200908205224.4126551-3-gitster@pobox.com>
        <20200910122111.GA57925@coredump.intra.peff.net>
Date:   Thu, 10 Sep 2020 08:04:05 -0700
In-Reply-To: <20200910122111.GA57925@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 10 Sep 2020 08:21:11 -0400")
Message-ID: <xmqqo8mdr7ve.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DFC1680E-F376-11EA-A75C-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Sep 08, 2020 at 01:52:20PM -0700, Junio C Hamano wrote:
>
>> -char *quote_path(const char *in, const char *prefix, struct strbuf *out)
>> +char *quote_path(const char *in, const char *prefix, struct strbuf *out, unsigned flags)
>>  {
>>  	struct strbuf sb = STRBUF_INIT;
>>  	const char *rel = relative_path(in, prefix, &sb);
>>  	strbuf_reset(out);
>> -	quote_c_style_counted(rel, strlen(rel), out, NULL, 0);
>> +	quote_c_style_counted(rel, strlen(rel), out, NULL, flags);
>>  	strbuf_release(&sb);
>
> Here we take "flags", but then we pass it along in place of
> quote_c_style_counted()'s "no_dq" parameter. That seems unlikely to be
> the right thing (and indeed, it's reverted in the next commit).

You are seeing a rebase artifact.  It needs to be corrected.  Thanks
for noticing.

As you seem to have guessed correctly, the initial plan was to have
the new logic in quote-c-style-counted and make anything at higher
level of the callchain just relay the "SP must be quoted" bit, and
the final two patches that are no longer necessary in the current
series were placed much earlier in an earlier draft of the series
as preparatory steps for that endgame.

But it turned out that the main loop of quote-c-style-counted needs
a surgery that is a bit larger than I would have liked, so the final
series consumes the "SP must be quoted" bit in quote_path() without
telling quote-c-style-counted about it.

The problem with the main loop of quote-style-counted I saw was that
the next_quote_pos() is designed to return the position of the byte
that must be prefixed with a backslash, and the machinery to help it
(namely, cq_must_quote() and cq_lookup[]) are written with that in
mind quite firmly.  The handling of SP we would be optionally adding
to the mix is somewhat different---it forces the end result to be
enclosed within a dq-pair, but it byitself does not need backslash
quoting.  Which means cq_lookup[] table needs to somehow encode a
bit per byte that says "byte with this value itself does not need to
be backslash-quoted, but the entire thing needs to be placed in a
dq-pair", and/or next_quote_pos() needs be able to say "here is a
byte to cause us to enclose the whole thing in a dq-pair, but the
byte itself need not be backslash-quoted".

Of course none of the above becomes unnecessary if we scan the whole
string for SP before the main loop in quote-c-style-counted, but the
function was written to process the input in a single pass and such
a change defeats its design.  If we need to do it in two passes, we
can have the caller do so anyway, at least for now.  That thinking
lead to the final organization of the series, with two steps that
used to be preparatory for passing the flag down thru to the bottom
layer rebased out as a discardable appendix at the end.

Thanks.
