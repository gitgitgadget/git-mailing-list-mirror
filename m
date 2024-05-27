Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607E961FC8
	for <git@vger.kernel.org>; Mon, 27 May 2024 18:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716833697; cv=none; b=pjWny+jssWLS/vgI/dfmykh06zAv9vnS8bfYMIE0NlIiVD8YL+qLJGql1RXVA5zTHJ4yAzfe7kNbFHZPqs9Y2XsKPz1Kgtt6NLexlxqEUORYiHF0ieWwEflNdtOO/dtt9hdeJ34y+OOjSMq0kp/9d8oLQBfck+0iz1AmlGUePMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716833697; c=relaxed/simple;
	bh=izymIlf9wm8obuVokQMyoUCapIsqy2JvtBB2dhou1Do=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uWGDygBoQko17KVNS6kRbiyFh1evAmom6330ZcFkUbKR0BLUfqbehs9P4TmmWjseG1cl4JwcssBlL222u3MH03DCrAYKrkyWOh0HdQo4gMTAfT4oih0aFZodyTSsXSbcWxhWpxkanDep13cmRnNVuB9rxapJiVjjrc8pmnDCCZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LABF7ezx; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LABF7ezx"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4454422702;
	Mon, 27 May 2024 14:14:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=izymIlf9wm8obuVokQMyoUCapIsqy2JvtBB2dh
	ou1Do=; b=LABF7ezxbGZhVOmhZLmw9/oJiyIV9ZyQ/hmr1sQQ/oJbxqnimoyNcc
	jAzjbHBoa3KY2jeKW67FwUfQn1PltXxhf67scQ5N5YAmD4GLKb4/3t+3wsglPpk/
	7NrpAIBaFw1a/M4F+1NsHLtIsWgB1SnFSUU+tfd/u/JBzeo8Ie7Cc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C3F722701;
	Mon, 27 May 2024 14:14:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A3B5022700;
	Mon, 27 May 2024 14:14:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Alexander Shopov <ash@kambanaria.org>
Cc: git@vger.kernel.org,  worldhello.net@gmail.com
Subject: Re: [PATCH 2 0/1] Allowing localized substitution hints in
 parse-options
In-Reply-To: <20240525122514.2608-1-ash@kambanaria.org> (Alexander Shopov's
	message of "Sat, 25 May 2024 14:24:37 +0200")
References: <xmqq5xwa1pfl.fsf@gitster.g>
	<20240525122514.2608-1-ash@kambanaria.org>
Date: Mon, 27 May 2024 11:14:53 -0700
Message-ID: <xmqqzfsb86le.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 049B5170-1C55-11EF-86E2-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Alexander Shopov <ash@kambanaria.org> writes:

> I hope this time patch submit is better.
> Requests for changes from previous review should be handled.
>
> parse-options.c contains functions and macros to print messages with
> terms optionally enclosed in chars promting substitution to users such as:
>
>   blah-blah-blah <TERM>
>
> Since languages using different alphabets or writing systems can translate
> the term in an obvious manner to prompt the user to substitute them, I expose
> these character to the translators so the messages can use the same style as
> elsewhere in git.

Most of the above explanation, starting from "parse-options.c
contains... " should replace the proposed log message of the main
patch [1/1], I would think.  Very clearly written.

The explanation after "such as:" needs improvement, though.  Are you
trying to highlight that an explanation is spelled with dashes
between words format?  Are you trying to highlight that the used
term is capitalized?  Are you trying to highlight that the term
comes after explanation?  The answer is none of the above, but it is
not easy for readers to guess.

One way to make it easier to follow would be to use a more realistic
example.  The whole proposed log message may become like so:

    parse-options.c API can show help text for an option that takes
    an argument.  For the "--author" option that takes a name, for
    example, the program may define the option like so:

	OPT_STRING(0, "author", &au, N_("author"), N_("override author")),

    When the command is run with "-h" (short help) option, the above
    definition is shown as:

        --[no-]author <author>    override author

    As the program does not accept translated option names, the
    first part of the above, "--[no-]author", is given as-is, but
    the string "author" in a pair of "<>", and the explanation
    "override author" may be translated into user's language.

    The user's language may use a convention to mark a replaceable
    part of the command line (called a "placeholder string")
    differently from enclosing it inside a pair of "<>", but the
    implementation in parse-options.c hardcodes "<%s>".

    Allow translators to specify the presentation of a placeholder
    string for their languages by overriding the "<%s>".

> Comments to the translators are shorter than before but hopefully they are
> not cryptic.

What is cryptic here is what "than before" refers to---compared
what?

  ... goes and looks ...

Ah, this is an updated patch for an earlier attempt

  https://lore.kernel.org/git/20240421191458.5411-1-ash@kambanaria.org/

Thanks for sticking with this topic.  Very much appreciated.


