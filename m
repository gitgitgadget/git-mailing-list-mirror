Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A6AC433B4
	for <git@archiver.kernel.org>; Fri, 21 May 2021 05:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDD9B61074
	for <git@archiver.kernel.org>; Fri, 21 May 2021 05:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239374AbhEUFIQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 01:08:16 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63536 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239361AbhEUFIP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 01:08:15 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EF8C912078B;
        Fri, 21 May 2021 01:06:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nndC/7ALJglafZdlhzloedBf+PjVMU/30TG7aL
        hI6aw=; b=JN/fso3btl4P1JwY5cgfhGgiCi1ThSF5wPiBZmpa4RgTziV4aB7hFj
        sV6GkPWu2aVcTMIqkzY9+6oT+fnKb+xegJmb0jqH/fGVT35QtMr9LLEoianF7nhG
        ynjJiFWLhBtroWltgfxlsPsDbXVoEuMJQDsUgbKii1mCAOuW9x0x8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E8B7412078A;
        Fri, 21 May 2021 01:06:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3A27F120789;
        Fri, 21 May 2021 01:06:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Leah Neukirchen <leah@vuxu.org>, Jeff King <peff@peff.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v4] help: colorize man pages
References: <20210520040725.133848-1-felipe.contreras@gmail.com>
        <842221d6-51c4-e08a-4299-c4efb8bf1dcb@gmail.com>
Date:   Fri, 21 May 2021 14:06:48 +0900
In-Reply-To: <842221d6-51c4-e08a-4299-c4efb8bf1dcb@gmail.com> (Phillip Wood's
        message of "Thu, 20 May 2021 10:26:03 +0100")
Message-ID: <xmqqbl94smjb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 59AB203C-B9F2-11EB-A834-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 20/05/2021 05:07, Felipe Contreras wrote:
>> We already colorize tools traditionally not colorized by default, like
>> diff and grep. Let's do the same for man.
>
> I think there is a distinction between 'diff' and 'grep' where we are
> generating the content and help where we are running man - I would 
> expect a man page to look the same whether it is displayed by 'man git
> foo' or 'git help foo'

... as long as the user chooses "man" backend, that is.  And I tend
to agree, but that is our expectation.

If we added this new mode of driving the same "man" but with
different environment variables exported to tweak how "less"
behaves, and taught it to builtin/help.c::exec_viewer() and
builtin/help.c::man_viewer_list, that might become more palatable in
the sense that we can view it as feeding the same manual page to
this another "man" that behaves differently from the plain "man",
just like we can feed it to "woman" or "konqueror" to get a different
view.  So those (like you and I) who expect a man page to look the
same in "man git foo" and "git help -m foo" can keep using our current
configuration, while those who want yet another variant of "man" output
in addition to the current "man", "woman", and "konqueror" can choose
it and get "colorized" output.

By the way, this new round mentions NO_COLOR, and while I think it
is good idea to teach git to honor it, I think it does it at a wrong
level.  Each ui driver that is optionally capable of coloring its
output shouldn't have to care, and the right level is either inside
want_color() or its helper function check_auto_color(), both in
color.c, to say "the user hasn't configured the output of this
subcommand for coloring, and by default we use color under certain
conditions (i.e. "auto"), but we decide not to use color because
NO_COLOR environment is set before even checking these "auto"
conditions.
