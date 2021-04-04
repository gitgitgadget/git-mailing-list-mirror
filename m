Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA2BC433B4
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 07:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AE806137A
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 07:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhDDHT7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Apr 2021 03:19:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63501 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhDDHT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Apr 2021 03:19:57 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 44D19C44D8;
        Sun,  4 Apr 2021 03:19:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=cd0wF857DncMJNAuKtnUKFVLNpo=; b=tLHef3spYjw1LMMt4TXp
        aG3EfLe9GfYyOqjY6swDs1M1OSIH1iFmkfR5L4iY3pXswrgGI0QxDXjckxBrhXMd
        hX6nKL3Xz17NfN1kPxgW5MeFM1oM35ZJfVWMPfBGaLKdlAjj5P8Wua76rbNfI/Ob
        c1Tibsq8hZ4pCatDpP5GGGo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=hxqUfGkKg2Pw0Z7uT7k0Rc5DTgB8nUNxya5HT/WkRA++NK
        had/TrDV56Ygq9brW14q9AB10MHGFR79mETmskffk9WaHU8wGD9QXkJM9ALcGjMj
        WdIxe7zjK1xpSCA+ueSzhogPjb0EyzlFBb6jAImOD4BjNPY8akk/MRNaXWclY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 28080C44D6;
        Sun,  4 Apr 2021 03:19:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8DE54C44D5;
        Sun,  4 Apr 2021 03:19:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stavros Ntentos <stdedos@gmail.com>
Cc:     git@vger.kernel.org, stdedos+git@gmail.com, bagasdotme@gmail.com,
        peff@peff.net
Subject: Re: [PATCH v3] pathspec: advice: long and short forms are incompatible
References: <20210326024411.28615-1-stdedos+git@gmail.com>
        <20210403122604.19203-1-133706+stdedos@users.noreply.github.com>
X-Gnus-Delayed: Mon, 05 Apr 2021 00:26:48 -0700
Date:   Sun, 04 Apr 2021 00:19:51 -0700
Message-ID: <xmqqr1jq7bzc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 261A0BC6-9516-11EB-838B-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stavros Ntentos <stdedos@gmail.com> writes:

> It can be a "reasonable" mistake to mix short and long forms,
> e.g. `:!(glob)`, instead of the (correct) `:(exclude,glob)`.

The word "form" may be sufficient for today's us because we have
been so focused on this particular pathspec magic issue.  

But reviewers are not, and those who read the "git log" output later
are not, either.  Let's be friendly and helpful to them by saying
"form of pathspec magic" or somesuch.

The same comment applies to the patch title.

It also might be more friendly to readers what the mistaken form
would do, too.

Here is my attempt, taking all of the above into account.

    It is a hard-to-notice mistake to try mixing short and long
    forms of pathspec magic, e.g. instead of ':(exclude,glob)', it
    may be tempting to write ':!(glob)', which stops at ":!",
    i.e. the end of the short-form pathspec magic, and the "(glob)"
    is taken as the beginning part of the pathspec, wanting to match
    a file or a directory whose name begins with that literal string.

> Teach git to issue an advice when such a pathspec is given.
>         i.e.: While in short form parsing:
>         * if the string contains an open parenthesis [`(`], and
>         * without having explicitly terminated magic parsing (`:`)
>         issue an advice hinting to that fact.

OK.

> Based on "Junio C Hamano <gitster@pobox.com>"'s code suggestions:
> * https://lore.kernel.org/git/xmqqa6qoqw9n.fsf@gitster.g/
> * https://lore.kernel.org/git/xmqqo8f0cr9z.fsf@gitster.g/

It is sufficient to just write a single line

	Helped-by: Junio C Hamano <gitster@pobox.com>

immediately before your sign-off, I would think.

> Signed-off-by: Stavros Ntentos <133706+stdedos@users.noreply.github.com>

The sign-off name and address must match the name and address of the
patch author (i.e. "Stavros Ntentos <stdedos@gmail.com>").

> +	mixedPathspecMagic::
> +		Advice shown if a user tries to mix short- and
> +		longform pathspec magic.

Good.  Here the phrase "pathspec magic" is used.

> +/*
> + * Give hint for a common mistake of mixing short and long
> + * form of pathspec magic, as well as possible corrections
> + */
> +static void warn_mixed_magic(unsigned magic, const char *elem, const char *pos)
> +{
> +	struct strbuf longform = STRBUF_INIT;
> +	int i;
> +
> +	if (!advice_enabled(ADVICE_MIXED_PATHSPEC_MAGIC))
> +		return;
> +
> +	for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
> +		if (pathspec_magic[i].bit & magic) {
> +			if (longform.len)
> +				strbuf_addch(&longform, ',');
> +			strbuf_addstr(&longform, pathspec_magic[i].name);
> +		}
> +	}

OK, so we are collecting the ones given by the short form so far.
For e.g. ":!(glob)", we write "exclude" in the longform buffer.  If
we had more than one, then before adding the second one, we add a
comma, so we may see "top,exclude" for ":/!(glob)".  Good.

> +	advise_if_enabled(ADVICE_MIXED_PATHSPEC_MAGIC,
> +	                  _("'%.*s(...': cannot mix short- and longform pathspec magic!\n"

Do we need to "shout!"?  I think a normal full-stop would be sufficient.

'elem' is pointing at ':', 'pos' is where we read '(' from, so
the above gives us "':/!(...': cannot..." for "':/!(glob)".  OK.

> +	                    "Either spell the shortform magic '%.*s' as ':(%s,...'\n"

Here, the shortform %.*s excludes the ':' that introduced the magic,
so we would see "shortform magic '/!' as ':(top,exclude,...'".  Good.

> +	                    "or end magic pathspec matching with '%.*s:'."),

This one I am not sure about.  Something like

    $ git add -- ":!(0) preface.txt" \*.txt

may be plausible, albeit rare, and it may be a good advice to
explicitly terminate the shortform pathspec magic before the '(' in
such a case.

But presumably it is much rarer for '(' to be a part of a pathspec
element than an attempt to introduce a longform magic, it might be
worth spending an extra line to explain in what narrow cases the
latter choice may make sense.  Here is my attempt.

    or if '(...' is indeed the beginning of a pathname, end the shortform
    magic sequence explicitly with another ':' before it, e.g. '%.*s:(...'


> +	                  (int)(pos - elem), elem,
> +	                  (int)(pos - (elem + 1)), elem + 1,
> +	                  longform.buf,
> +	                  (int)(pos - elem), elem);
> +}
>  /*
>   * Parse the pathspec element looking for short magic
>   *
> @@ -356,6 +386,9 @@ static const char *parse_short_magic(unsigned *magic, const char *elem)
>  			continue;
>  		}
>  
> +		if (ch == '(')
> +			warn_mixed_magic(*magic, elem, pos);
> +
>  		if (!is_pathspec_magic(ch))
>  			break;
>  
> diff --git a/t/t6132-pathspec-exclude.sh b/t/t6132-pathspec-exclude.sh
> index 30328b87f0..8b9d543e1e 100755
> --- a/t/t6132-pathspec-exclude.sh
> +++ b/t/t6132-pathspec-exclude.sh
> @@ -244,4 +244,42 @@ test_expect_success 'grep --untracked PATTERN :(exclude)*FILE' '
>  	test_cmp expect-grep actual-grep
>  '
>  
> +cat > expected_warn <<"EOF"
> +hint: ':!(...': cannot mix short- and longform pathspec magic!
> +hint: Either spell the shortform magic '!' as ':(exclude,...'
> +hint: or end magic pathspec matching with ':!:'.
> +hint: Disable this message with "git config advice.mixedPathspecMagic false"
> +EOF
> +test_expect_success 'warn pathspec not matching longform magic in :!(...)' '
> +	git log --oneline --format=%s -- '"'"':!(glob)**/file'"'"' >actual 2>warn &&
> +	cat <<EOF >expect &&
> +sub2/file
> +sub/sub/sub/file
> +sub/file2
> +sub/sub/file
> +sub/file
> +file
> +EOF
> +	cat actual &&
> +	cat warn &&

Are these leftover debugging aid?

> +	test_cmp expect actual &&
> +	test_cmp expected_warn warn
> +'
> +
> +test_expect_success 'do not warn pathspec not matching longform magic in :!:(...) (i.e. if magic parsing is explicitly stopped)' '
> +	git log --oneline --format=%s -- '"'"':!:(glob)**/file'"'"' >actual 2>warn &&
> +	cat <<EOF >expect &&
> +sub2/file
> +sub/sub/sub/file
> +sub/file2
> +sub/sub/file
> +sub/file
> +file
> +EOF
> +	cat actual &&
> +	cat warn &&

Are these leftover debugging aid?

> +	test_cmp expect actual &&
> +	! test_cmp expected_warn warn
> +'
> +
>  test_done


Thanks.
