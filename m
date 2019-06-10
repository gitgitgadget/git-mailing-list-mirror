Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10A4C1F462
	for <e@80x24.org>; Mon, 10 Jun 2019 23:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390707AbfFJXuC (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 19:50:02 -0400
Received: from resqmta-po-06v.sys.comcast.net ([96.114.154.165]:60466 "EHLO
        resqmta-po-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390561AbfFJXuB (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 10 Jun 2019 19:50:01 -0400
Received: from resomta-po-14v.sys.comcast.net ([96.114.154.238])
        by resqmta-po-06v.sys.comcast.net with ESMTP
        id aTHOhBBhWZsECaU36hwjXg; Mon, 10 Jun 2019 23:50:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1560210600;
        bh=iMcMCA3jLq67Dp+ujcr2GS9Nc6OwK+uvKemXSuBhimQ=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=bjF0g8ESpyrrAe0uICSEJIcFKAGGLyUSiwfhwyEEnzqZgPU6nPux89PMLMBXYxgWB
         kdqytpb+C3ybDbOaoS84uV/lklCyqpNEOXcWyfvOuXTngLbqHCD4/A2DTuUdOD1lnq
         faU7OpwUvmOqqidu62X0rFMB1V5IqOnNeU8iUdv/jhEbZo0i/bx5kPHNzR6D1LeOwC
         MD7+afn9Pe5RSO7EUeVFA1muR3NriXo4Q+D9i2/DaYkKi0tIFEjf5ayD3TJlv2TicK
         z+PI08vPlmbvGMolz6NpJQ3nfRuNtCEPKc1VbZaRYhZzycQZwv8Ar/Ud8EA+jpbiKb
         IRyOwBS3nVDVA==
Received: from comcast.net ([IPv6:2620:15c:2ce:200:f026:8f18:533c:4f74])
        by resomta-po-14v.sys.comcast.net with ESMTPSA
        id aU2QhOYVjaUYaaU2ahksXr; Mon, 10 Jun 2019 23:49:57 +0000
X-Xfinity-VMeta: sc=-100;st=legit
Date:   Mon, 10 Jun 2019 16:49:18 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Matthew DeVore <matvore@google.com>, git@vger.kernel.org,
        avarab@gmail.com, git@matthieu-moy.fr, olyatelezhnaya@gmail.com,
        samuel.maftoul@gmail.com, gitster@pobox.com, karthik.188@gmail.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        emilyshaffer@google.com, jrn@google.com
Subject: Re: [RFC PATCH] ref-filter: sort detached HEAD lines firstly
Message-ID: <20190610234918.GA10396@comcast.net>
References: <faaa9a3d6ba66d77cc2a8eab438d1bfc8f762fa1.1559857032.git.matvore@google.com>
 <nycvar.QRO.7.76.6.1906090954510.789@QRFXGBC-DHN364S.ybpnyqbznva>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1906090954510.789@QRFXGBC-DHN364S.ybpnyqbznva>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 09, 2019 at 10:17:19AM +0200, Johannes Schindelin wrote:
> >  	if (get_ref_atom_value(a, s->atom, &va, &err))
> >  		die("%s", err.buf);
> >  	if (get_ref_atom_value(b, s->atom, &vb, &err))
> >  		die("%s", err.buf);
> >  	strbuf_release(&err);
> >  	cmp_fn = s->ignore_case ? strcasecmp : strcmp;
> > -	if (s->version)
> > +	if (s->version) {
> >  		cmp = versioncmp(va->s, vb->s);
> > -	else if (cmp_type == FIELD_STR)
> > +	} else if (cmp_type == FIELD_STR) {
> 
> I find that it makes sense in general to suppress one's urges regarding
> introducing `{ ... }` around one-liners when the patch does not actually
> require it.
> 
> For example, I found this patch harder than necessary to read because of
> it.

I understand the desire to make the patch itself clean, and I sometimes try to
do that to a fault, but the style as I understand it is to put { } around all
if branches if only one branch requires it. Since I'm already modifying the
"else if (cmp_type == FIELD_STR)" line, I decided to put the } at the start of
the line and modify the if (s->version) line as well. So only one line was
modified "in excess." I think the temporary cost of the verbose patch is
justified to keep the style consistent in narrow code fragments.

> 
> > +		if ((a->kind & FILTER_REFS_DETACHED_HEAD) !=
> > +				(b->kind & FILTER_REFS_DETACHED_HEAD)) {
> 
> So in case that both are detached...
> 
> > +			return (a->kind & FILTER_REFS_DETACHED_HEAD) ? -1 : 1;
> > +		}
> >  		cmp = cmp_fn(va->s, vb->s);
> 
> ... we compare their commit hashes, is that right? Might be worth a code
> comment.
> 

It should not be possible to have two detached head lines, so adding a comment
about that may be distracting.

> > -	else {
> > +	} else {
> 
> FWIW it would have been a much more obvious patch if it had done
> 
>  	if (s->version)
> 		[...]
> +	else if (cmp_type == FIELD_STR &&
> +		 (a->kind & FILTER_REFS_DETACHED_HEAD ||
> +		  b->kind & FILTER_REFS_DETACHED_HEAD))
> +		return (a->kind & FILTER_REFS_DETACHED_HEAD) ? -1 : 1;

But that means that if a is detached, it is always a < b, even if both are
detached? That's probably right in practice, since there should only be one
detached head, but it's jarring to read a brittle cmp function.

>  	else if (cmp_type == FIELD_STR)
> 		[...]
> 
> Maybe still worth doing.
> 
> FWIW I was *so* tempted to write
> 
> 	((a->kind ^ b->kind) & FILTER_REFS_DETACHED_HEAD)
> 
> to make this code DRYer, but then, readers not intimately familiar with
> Boolean arithmetic might not even know about the `^` operator, making the
> code harder to read than necessary, too.

I think I found a readable way to DRY:

	} else if (cmp_type == FIELD_STR) {
		const int a_detached = a->kind & FILTER_REFS_DETACHED_HEAD;

		/*
		 * When sorting by name, we should put "detached" head lines,
		 * which are all the lines in parenthesis, before all others.
		 * This usually is automatic, since "(" is before "refs/" and
		 * "remotes/", but this does not hold for zh_CN, which uses
		 * full-width parenthesis, so make the ordering explicit.
		 */
		if (a_detached != (b->kind & FILTER_REFS_DETACHED_HEAD))
			cmp = a_detached ? -1 : 1;
		else
			cmp = cmp_fn(va->s, vb->s);
	} ...

> >
> >  	if test -n "$is_IS_locale" &&
> >  		test $GIT_INTERNAL_GETTEXT_SH_SCHEME != "fallthrough"
> >  	then
> >  		# Some of the tests need the reference Icelandic locale
> >  		test_set_prereq GETTEXT_LOCALE
> >
> >  		# Exporting for t0202/test.pl
> >  		GETTEXT_LOCALE=1
> >  		export GETTEXT_LOCALE
> > @@ -53,11 +59,15 @@ then
> >  	if test -n "$is_IS_iso_locale" &&
> >  		test $GIT_INTERNAL_GETTEXT_SH_SCHEME != "fallthrough"
> >  	then
> >  		# Some of the tests need the reference Icelandic locale
> >  		test_set_prereq GETTEXT_ISO_LOCALE
> >
> >  		say "# lib-gettext: Found '$is_IS_iso_locale' as an is_IS ISO-8859-1 locale"
> >  	else
> >  		say "# lib-gettext: No is_IS ISO-8859-1 locale available"
> >  	fi
> > +
> > +	if test -z "$zh_CN_locale"; then
> > +		say "# lib-gettext: No zh_CN UTF-8 locale available"
> > +	fi
> 
> I wonder why this hunk, unlike the previous one, does not imitate the
> is_IS handling closely.

It was because I didn't have gettext set up properly and it was causing
GIT_INTERNAL_GETTEXT_SH_SCHEME to be "fallthrough", despite the actual Git
output being translated. My set-up was quite broken so I don't think our intl
utility and test code needs any fixing. I've handled this and the next version
of the patch will have that fixed. (incidentally, this was why I originally
marked my patch RFC. Also incidentally, I'm using a Mac for development since
the most powerful machine I have access to is a Mac, so I've been jumping
through some hoops to make that work.)

> 
> > diff --git a/t/t3207-branch-intl.sh b/t/t3207-branch-intl.sh
> > new file mode 100755
> > index 0000000000..9f6fcc7481
> > --- /dev/null
> > +++ b/t/t3207-branch-intl.sh
> > @@ -0,0 +1,38 @@
> > +#!/bin/sh
> > +
> > +test_description='git branch internationalization tests'
> > +
> > +. ./lib-gettext.sh
> > +
> > +test_expect_success 'init repo' '
> > +	git init r1 &&
> 
> Why?

You mean why make a test repo?

> 
> > +	touch r1/foo &&
> > +	git -C r1 add foo &&
> > +	git -C r1 commit -m foo
> > +'
> 
> Why not simply `test_commit foo`?

Good idea, I'll use that.

> 
> > +test_expect_success 'detached head sorts before other branches' '
> > +	# Ref sorting logic should put detached heads before the other
> > +	# branches, but this is not automatic when a branch name sorts
> > +	# lexically before "(" or the full-width "(" (Unicode codepoint FF08).
> > +	# The latter case is nearly guaranteed for the Chinese locale.
> > +
> > +	git -C r1 checkout HEAD^{} -- &&
> > +	git -C r1 branch !should_be_after_detached HEAD &&
> 
> I am not sure that `!` is a wise choice, as it might not be a legal file
> name character everywhere. A `.` or `-` might make more sense.

The ! is actually meaningless, as I have come to observed, since the actual ref
name used for comparison is not "!should_be_after_detached" but
"refs/heads/!should_be_after_detached". So I'll remove it.

> 
> > +	LC_ALL=$zh_CN_locale LC_MESSAGES=$zh_CN_locale \
> > +		git -C r1 branch >actual &&
> > +	git -C r1 checkout - &&
> 
> Why call `checkout` after `branch`? That's unnecessary, we do not verify
> anything after that call.

It's to get the repo into a neutral state in case an additional testcase is
added in the future.

> 
> > +	awk "
> > +	# We need full-width or half-width parens on the first line.
> > +	NR == 1 && (/[(].*[)]/ || /\xef\xbc\x88.*\xef\xbc\x89/) {
> > +		found_head = 1;
> > +	}
> > +	/!should_be_after_detached/ {
> > +		found_control_branch = 1;
> > +	}
> > +	END { exit !found_head || !found_control_branch }
> > +	" actual
> 
> This might look beautiful for a fan of `awk`. For the vast majority of us,
> this is not a good idea.
> 
> Remember, you do *not* write those tests for your own pleasure, you do
> *not* write those tests in order to help you catch problems while you
> develop your patches, you do *not* develop these tests in order to just
> catch future breakages.
> 
> You *do* write those tests for *other* developers who you try to help in
> preventing introducing regressions.
> 
> As such, you *want* the tests to be
> 
> - easy to understand for as wide a range of developers as you can make,
> 
> - quick,
> 
> - covering regressions, and *only* regressions,
> 
> - helping diagnose *and* fix regressions.
> 
> In the ideal case you won't even hear when developers found your test
> helpful, and you will never, ever learn about regressions that have been
> prevented.
> 
> You most frequently will hear about your tests when they did not do their
> job well.
> 
> In this instance, I would have expected something like
> 
> 	test_expect_lines = 3 actual &&
> 
> 	head -n 1 <actual >first &&
> 	test_i18ngrep "detached HEAD" first &&

Tangential to your point, but the test_i18ngrep actually won't work since all
it does is *not* grep when the text is translated. But I want the text to use
the genuine zh_CN translation.

> 
> 	tail -n 1 <actual >last &&
> 	grep should_be_after last
> 
> instead of the "awk-ward" code above.

All fair points, and I may have been carried away when I wrote the awk code. I
liked using awk since it matched my mental model at the time, which was
procedural, as opposed to your proposed pure sh implementation, which is more
declarative.

Here is the new version of the test:

test_expect_success GETTEXT_ZH_LOCALE 'detached head sorts before branches' '
	# Ref sorting logic should put detached heads before the other
	# branches, but this is not automatic when a branch name sorts
	# lexically before "(" or the full-width "(" (Unicode codepoint FF08).
	# The latter case is nearly guaranteed for the Chinese locale.

	git -C r1 checkout HEAD^{} -- &&
	LC_ALL=$zh_CN_locale LC_MESSAGES=$zh_CN_locale \
		git -C r1 branch >actual &&
	git -C r1 checkout - &&

	head -n 1 actual >first &&
	# The first line should be enclosed by full-width parenthesis.
	grep '$'\xef\xbc\x88.*\xef\xbc\x89'' first &&
	grep master actual
'

> 
> Ciao,
> Johannes
>

Thank you for the thoughtful feedback.
