Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF3CC4363C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 06:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0FA320B1F
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 06:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BWixOkKA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbgJGGK1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 02:10:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53366 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgJGGK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 02:10:27 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6DA82885EF;
        Wed,  7 Oct 2020 02:10:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yr5bENm+BUlr7lwrm/6KqSLLo0E=; b=BWixOk
        KA8yRasdMUf6ozaJYrkEBZzLznrLftAZwnV09YjwrP9J+l5Uox8ioD3swoQbFKQY
        gm9PtKND3tqCxklB/YUhdV2C6WWqZ0ydwiQRi0J925C6LKJM1es7HMsY8XWVg4t1
        Y0kOiLudmiH4uvTsDSjhPtG2tmW72o+lUqw8k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=C3L+1jkEzDh1HMGwtr3LZhiptqrHe8s6
        MzxHs+I22DcUDNsaBK/jebv0pQglKkbi0iaOoS64OtQoyeqaI3MT1fHTBdnjewNG
        axbNaMtD4N7oqUJohkSwchoZ+/hpBtd6eFD7nsodp4eBm7DbNPAowaTRVyy3K2GG
        UYPET2lNbI4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6589A885EE;
        Wed,  7 Oct 2020 02:10:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DF19C885ED;
        Wed,  7 Oct 2020 02:10:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Konrad Borowski via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Konrad Borowski <github@borowski.pw>,
        Konrad Borowski <konrad@borowski.pw>
Subject: Re: [PATCH v2] userdiff: permit Rust's macro_rules! keyword in hunk
 headers
References: <pull.865.git.git.1601986430388.gitgitgadget@gmail.com>
        <pull.865.v2.git.git.1602048429067.gitgitgadget@gmail.com>
Date:   Tue, 06 Oct 2020 23:10:24 -0700
In-Reply-To: <pull.865.v2.git.git.1602048429067.gitgitgadget@gmail.com>
        (Konrad Borowski via GitGitGadget's message of "Wed, 07 Oct 2020
        05:27:08 +0000")
Message-ID: <xmqqimbm4ldb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CA094DF4-0863-11EB-B856-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Konrad Borowski via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Konrad Borowski <konrad@borowski.pw>
>
> Changes since v1:
> - Changed macro_rules! to be considered to use the same
>   rule as rest of keywords to reduce the size of a change
>   as suggested by Phillip Wood. This means that
>   'pub macro_rules!` (a syntax error) is considered to be
>   a hunk header.
>
> - Written commit message in imperative mood as suggested by
>   Johannes Sixt.

The above is where you write the proposed log message, not where you
write the differences between v1 and v2 (which, if exists, would be
below the three-dash line after your sign off).  After all, people
who are reading the final history of the project in "git log" will
not even know or care that what they are reading is the second
iteration and/or there was a first iteration that was different from
the final version.

> Subject: [PATCH v2] userdiff: permit Rust's macro_rules! keyword in hunk headers

Somehow I find the "permit" a bit odd---it is not like we are
disallowing Rust programs written in certain way.

     userdiff: recognize 'macro_rules!' as starting a Rust function block

or something?

> Signed-off-by: Konrad Borowski <konrad@borowski.pw>
> ---
> ...

As to the simplified rule that matches 'pub macro_rules!'.

We assume what is written by the end-user, in which these patterns
are used to find function headers, is a syntactically correct
program.  This allows us to write a pattern that may match with a
syntactic nonsense (i.e. false positive is perfectly fine).  What
we care about is to avoid false negatives---if our pattern does not
recognize what users would consider a valid and common function
header line, that is a problem.

So, from that point of view, you do not have to worry too much about
'pub macro_rules!'  matching your pattern.

> diff --git a/t/t4018/rust-macro-rules b/t/t4018/rust-macro-rules
> new file mode 100644
> index 0000000000..ec610c5b62
> --- /dev/null
> +++ b/t/t4018/rust-macro-rules
> @@ -0,0 +1,6 @@
> +macro_rules! RIGHT {
> +    () => {
> +        // a comment
> +        let x = ChangeMe;
> +    };
> +}
> diff --git a/userdiff.c b/userdiff.c
> index fde02f225b..c0f63c57b2 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -165,7 +165,7 @@ PATTERNS("ruby", "^[ \t]*((class|module|def)[ \t].*)$",
>  	 "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+|\\?(\\\\C-)?(\\\\M-)?."
>  	 "|//=?|[-+*/<>%&^|=!]=|<<=?|>>=?|===|\\.{1,3}|::|[!=]~"),
>  PATTERNS("rust",
> -	 "^[\t ]*((pub(\\([^\\)]+\\))?[\t ]+)?((async|const|unsafe|extern([\t ]+\"[^\"]+\"))[\t ]+)?(struct|enum|union|mod|trait|fn|impl)[< \t]+[^;]*)$",
> +	 "^[\t ]*((pub(\\([^\\)]+\\))?[\t ]+)?((async|const|unsafe|extern([\t ]+\"[^\"]+\"))[\t ]+)?(struct|enum|union|mod|trait|fn|impl|macro_rules[\t ]*!)[< \t]+[^;]*)$",

I notice that you still allow "macro_rules    !" as Phillip pointed
out.  Is that intended?

Thanks.
