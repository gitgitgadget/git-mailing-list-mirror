Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CC6C4363D
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 23:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4C31223C6
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 23:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jVnNYflp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410668AbgJTXjn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 19:39:43 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50134 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410643AbgJTXjm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 19:39:42 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3DEA3FBC6B;
        Tue, 20 Oct 2020 19:39:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kba0P778wJWi1Gs21YbmoHOSSCI=; b=jVnNYf
        lpppVfublNI+qCNuoODc85/+Q5hL+BBQfaHCExQLrl3HjmIqY8vVl4r4qH+wKtfa
        FytzklSNljyQuMQTxv5VevMDFiZCzeaG3Pq8l3lDXwrdii2TbDWCsvHk7CKPPuE/
        lDNlCMJ8p0ZHJ1MQ+7vXchAEHK8wtGLM+g0ag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GjOuA3ALmqJpzARRzL4Yk78oYdSTqU5L
        4/NDSRNHy5mBMS7EQA+LQYsWw6LOZNMZZwmeK+izL3U4UsGpqPy/rHbn1W/LJvTO
        nrpNt4Oxv4SbbNW2As++N9FUGCFrpY65OQImJrQgDLTWl+7H2yhd3oz/486WJIKk
        41F0bVrCFyc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3672DFBC6A;
        Tue, 20 Oct 2020 19:39:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 81DAFFBC69;
        Tue, 20 Oct 2020 19:39:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victor Engmark <victor@engmark.name>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] userdiff: support Bash
References: <373640ea4d95f3b279b9d460d9a8889b4030b4e9.camel@engmark.name>
Date:   Tue, 20 Oct 2020 16:39:35 -0700
In-Reply-To: <373640ea4d95f3b279b9d460d9a8889b4030b4e9.camel@engmark.name>
        (Victor Engmark's message of "Tue, 20 Oct 2020 20:10:49 +1300")
Message-ID: <xmqqk0vk8o20.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 84169CAA-132D-11EB-B6E5-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victor Engmark <victor@engmark.name> writes:

It's a bit troubling not to see the most basic form, i.e.

	RIGHT () {
		: ChangeMe
	}

in the set of tests.

> diff --git a/t/t4018/bash-trailing-comment b/t/t4018/bash-trailing-comment
> new file mode 100644
> index 0000000000..f1edbeda31
> --- /dev/null
> +++ b/t/t4018/bash-trailing-comment
> @@ -0,0 +1,4 @@
> +RIGHT() { # Comment
> +
> +    ChangeMe
> +}

This is the closest, but it tests "# with comment" at the same time.

> diff --git a/userdiff.c b/userdiff.c
> index fde02f225b..9de0497007 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -23,6 +23,12 @@ IPATTERN("ada",
>  	 "[a-zA-Z][a-zA-Z0-9_]*"
>  	 "|[-+]?[0-9][0-9#_.aAbBcCdDeEfF]*([eE][+-]?[0-9_]+)?"
>  	 "|=>|\\.\\.|\\*\\*|:=|/=|>=|<=|<<|>>|<>"),
> +PATTERNS("bash",
> +	 /* POSIX & bashism form; all four compound command types */
> +	 "^[ \t]*((function[ \t]*)?[a-zA-Z_][a-zA-Z0-9_]*(\\(\\))?[ \t]*(\\{|\\(\\(?|\\[\\[))",

We allow an optional leading indent, an optional noiseword
"function" plus a run of whitespaces, and then an identifier
followed by "line noise".

The pattern makes the run of whitespaces after "function" entirely
optional, which makes "functionabc" be taken as a single identifier
without noiseword "function", but it's not like we are parsing and
painting only the identifer in a color different from the keyword,
so it is OK.  Using [ \t]+ instead of [ \t]* after "function" would
probably make the result more clear, even though it does not make a
practical difference.

Then the "line noise" part.  I am not sure if I follow this part
correctly:

	"(\\(\\))?[ \t]*(\\{|\\(\\(?|\\[\\[)"

is what follows the identifier that is the function name.  We may
have 0 or 1 "()", followed by an optional run of whitespaces.  And
then one of '{', '(', '((', '[[' would come.

Did I read it correctly?

Even though it may be unusual to write open and close parentheses
not directly next to each other, or with a space after the name of
the function, i.e.

	RIGHT ( ) {

would also be a valid header, no?  The way I read the pattern in the
above, it should not hit, as the pattern does not allow anything but
"()" as the "the previous identifier is the name of the function we
are defining" sign, and it does not allow any whitespace between the
identifier and "()".

But it does, and the reason why this most basic form happens to work
is because it relies on the support for "bash-ism" forms.  Even if
the "()" after identifier is missing, you'll match as long as the
identifier is followed by an optional run of whitespace and then an
open paren, brace or bracket:

	"[ \t]*(\\{|\\(\\(?|\\[\\[)"

And I do not like code or pattern that happens to appear to work by
accident.  Can we tighten it a bit?

	"^[ \t]*"		     /* (op) leading indent */
	"("			     /* here comes the whole thing */
	"(function[ \t]+)?"	     /* (op) noiseword "function" */
	"[a-zA-Z_][a-zA-Z0-9_]*"     /* identifier - function name */
	"[ \t]*(\\([ \t]*\\))?"      /* (op) start of func () */
	"[ \t]*(\\{|\\(\\(?|\\[\\[)" /* various "opening" of body */
	")",

is my attempt to break it down to make it readable and more correct.

> +	 /* -- */
> +	 /* Characters not in the default $IFS value */
> +	 "[^ \t]+"),
>  PATTERNS("dts",
>  	 "!;\n"
>  	 "!=\n"

Thanks.
