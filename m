Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE44C43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 19:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 578F521D81
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 19:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yEjTXJsR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgIJTmP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:42:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63634 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731342AbgIJPei (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 11:34:38 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D52FD74F21;
        Thu, 10 Sep 2020 11:17:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ars2pCcbeSWflmaUT8NrqAnDOi4=; b=yEjTXJ
        sRhX7czV4LhHaTA8wjZBn7Px51h5o4EyAo558/yEamqnvuY3wwJydAxuTKM4dLQn
        Fr2hMx2OeNkbhyGJG2Zzuv7ushNe2GBSCO48gSjFg4PMXBmevw6papeqSo4Ycrtk
        Hr5h0aQdSKC8ZxCXG6V4u0MuQZtfhsnwB7ewo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=e7aizu5R85ouRtQTQH/MXk0ARFFgBuli
        /3OUHvWRITQ7GeIEJ1/OKB7KytRbeTxckfcy6jvOM5hsrp4dCQ8yvIZJtFv7B/51
        ZTzOOJ2XMFElnwoiVfJrDuXTJeYuiCBIekaJUr/avFVmqw1S84G7E+wcVOY/ZIeV
        OxNPP2cdT7A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CAC4374F20;
        Thu, 10 Sep 2020 11:17:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4AF1F74F1E;
        Thu, 10 Sep 2020 11:17:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/6] quote_path: give flags parameter to quote_path()
References: <20200908013013.1099937-1-sandals@crustytoothpaste.net>
        <20200908205224.4126551-1-gitster@pobox.com>
        <20200908205224.4126551-3-gitster@pobox.com>
        <20200910122111.GA57925@coredump.intra.peff.net>
        <xmqqo8mdr7ve.fsf@gitster.c.googlers.com>
Date:   Thu, 10 Sep 2020 08:17:32 -0700
In-Reply-To: <xmqqo8mdr7ve.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 10 Sep 2020 08:04:05 -0700")
Message-ID: <xmqq7dt1r78z.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C0210372-F378-11EA-8891-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Of course none of the above becomes unnecessary if we scan the whole
> string for SP before the main loop in quote-c-style-counted, but the
> function was written to process the input in a single pass and such
> a change defeats its design.  If we need to do it in two passes, we
> can have the caller do so anyway, at least for now.  That thinking
> lead to the final organization of the series, with two steps that
> used to be preparatory for passing the flag down thru to the bottom
> layer rebased out as a discardable appendix at the end.

Actually, this made me realize that another variant is possible.
It might be easier to read, or it might not.  Since I cannot tell
without actually writing one, let's see ...

Instead of scanning the output from quote-c-style-counted for SP in
the caller, the caller can do something like this.

/* quote path as relative to the given prefix */
char *quote_path(const char *in, const char *prefix, struct strbuf *out, unsigned flags)
{
	struct strbuf sb = STRBUF_INIT;
	const char *rel = relative_path(in, prefix, &sb);
	int add_dq_ourselves = !!(flags & QUOTE_PATH_QUOTE_SP) && !!strchr(rel, ' ');

	strbuf_reset(out);
        if (add_dq_ourselves)
        	strbuf_addch(out, '"');
	quote_c_style_counted(rel, strlen(rel), out, NULL,
        		      add_dq_ourselves ? CQUOTE_NODQ : 0);
        if (add_dq_ourselves)
        	strbuf_addch(out, '"');
	strbuf_release(&sb);

	return out->buf;
}

That is, we tell quote-c-style-counted not to put dq-pair around its
output whether it needs to do the backslash quoting, if we know we
want the result inside dq-pair anyway (iow, when the caller wants us
to treat SP specially and we do see SP in the input).

I don't know if this is easier to follow or not.  I do think so
right now but that is only because it is still fresh in my brain.
