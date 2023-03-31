Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BE9C6FD18
	for <git@archiver.kernel.org>; Fri, 31 Mar 2023 08:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjCaIcu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 04:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjCaIcs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 04:32:48 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB271CBA9
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 01:32:36 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id c9so17499448lfb.1
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 01:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680251554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbmyYILUzvfwvdxw+jZJsgP08tEtF3v8Ui6s0LZxFos=;
        b=TinB7PP7b7g6u2PhUVohpdD94M8d21y1e6uQdzk809al1fajcX0TUPtve+SJ+YW/HV
         mm21yoU+pLJFARWhZP3xNWmYz28eLNrt14IrnGKcqKWTQM0FoOQic8/gZgBHPLHXUpNZ
         3a2AQ44gM6YVSeUZz7GuDykLAAvjabgZhsqdQasnAvtNrzqbNW6NzKpCjWZbFw9shZrI
         9gZoj8kElr6AIAGEL65zk8YKrb0XE4Rb0CK6qqSANt2xsXPx63yR8A0uTtm86eUyPiBs
         wiXk0RoFxOw9T4cDDn7EvXPZ79fSTJdw6AM0MzQ25qUUexoNpMgjlRPKAxcpk+wjwDbH
         sYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680251554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bbmyYILUzvfwvdxw+jZJsgP08tEtF3v8Ui6s0LZxFos=;
        b=PSTT+bhYZUet6NCYWJ/PoMdymMrYCmf0+wsPIuKKOg61xV43Lrzf8mqPAD7jepy/TJ
         BB/EToRoRaqbntnAQsVhu+DVnRqFfdpioighqtMaltWRU9ts5z25dSS+4vcMmCzKRwW2
         4IZkE6OJokKp3JE7h+KLOxQRmTlQS94PgZNtfWLwWgIqslUnajBLjXocuyu3LpLyqWE4
         rhouBLd7cVvja8MJXOF/C6icy7VvdYuR9OsklepZvZ+sWY7x6Ch4AhvMDiASSAWJx2HY
         30BOqYv7tRzPeb5JR75HNocRisPZIi3e2tSp83E/alts8l8LLhQeKNTey/FnjnE1oO5C
         jSDQ==
X-Gm-Message-State: AAQBX9cGZrrKoJ2vdgD7SRfKmrC/YZHW3/IRf7moQ+G0zcluhopH5iNd
        9eNEq79DPlDQ/CvhYAFJthA=
X-Google-Smtp-Source: AKy350aFIKgAOMq/pL5mZv0GrW/t3KKQg6eN7HthLFN7OUPAUZ4O1IYjAIs7rZaDgK2QqLpHV9niTg==
X-Received: by 2002:ac2:5fc2:0:b0:4ea:f4f4:dccd with SMTP id q2-20020ac25fc2000000b004eaf4f4dccdmr8050402lfg.68.1680251554096;
        Fri, 31 Mar 2023 01:32:34 -0700 (PDT)
Received: from localhost.localdomain ([2001:4641:9d1:0:9c74:f016:4c88:53bb])
        by smtp.gmail.com with ESMTPSA id w3-20020ac254a3000000b004eacd90e0c7sm286651lfk.81.2023.03.31.01.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 01:32:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, oystwa@gmail.com
Subject: Re: [PATCH 2/2] branch, for-each-ref: add option to omit empty lines
Date:   Fri, 31 Mar 2023 10:32:13 +0200
Message-Id: <20230331083213.12013-1-oystwa@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <xmqqilei1bgk.fsf@gitster.g>
References: <xmqqilei1bgk.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 30 Mar 2023 at 17:54, Junio C Hamano <gitster@pobox.com> wrote:

> While I can see the utility of the new feature, it is unclear if its
> merit is so clear that it deserves a short-and-sweet single letter
> option from the get go.  Especially, don't we want to give this to
> "git branch" and "git tag" in their listing modes for consistency,
> but it means stealing "-n" also from them.

I had this in mind, but I wanted to add a short option because
"--omit-empty-lines" is already longer than "| sed '/^$/d' |" :D Which
is the workaround I've used in the past. I see that later in your reply
you write "--omit-empty". (Perhaps instinctively?) The "line" part is
already implied so I'd be equally happy with "--omit-empty". I realize
that the parser already allows this implicitly, but the full name of the
option should be spelt out in the docs, I assume.

> Move that opening brace at the end of the previous line, i.e.
>
> -       if (list)
> +       if (list) {

Of course, my bad. Old habits and so on. But I may not need to change
this at all in the first place because...

> > +             if (omit_empty_lines && !format.format) {
> > +                     error("--omit-empty-lines without --format does not make sense");
> > +                     usage_with_options(builtin_branch_usage, options);
> > +             }
>
> Does it not make sense?  With the default format, it may happen that
> there will be no empty line so there is nothing to omit, but I do
> not see a strong reason to forbid the request like this.

... it's perfectly fine by me to allow --omit-empty when the user has
not specified their own format. I added this merely as guidance for the
user. For example, Git will bail out with a similar message if the user
tries to unshallow a repository that is already complete, which I assume
is technically not a problem.

> >               setup_auto_pager("branch", 1);
> > +     }
> >
> >       if (delete) {
> >               if (!argc)
> > diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> > index 6f62f40d12..349c4d4ef8 100644
> > --- a/builtin/for-each-ref.c
> > +++ b/builtin/for-each-ref.c
> > @@ -19,7 +19,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
> >       int i;
> >       struct ref_sorting *sorting;
> >       struct string_list sorting_options = STRING_LIST_INIT_DUP;
> > -     int maxcount = 0, icase = 0;
> > +     int maxcount = 0, icase = 0, omit_empty_lines = 0;
> >       struct ref_array array;
> >       struct ref_filter filter;
> >       struct ref_format format = REF_FORMAT_INIT;
> > @@ -35,6 +35,8 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
> >                       N_("quote placeholders suitably for python"), QUOTE_PYTHON),
> >               OPT_BIT(0 , "tcl",  &format.quote_style,
> >                       N_("quote placeholders suitably for Tcl"), QUOTE_TCL),
> > +             OPT_BOOL('n' , "omit-empty-lines",  &omit_empty_lines,
> > +                     N_("do not output a newline after empty formatted refs")),
> >
> >               OPT_GROUP(""),
> >               OPT_INTEGER( 0 , "count", &maxcount, N_("show only <n> matched refs")),
> > @@ -55,8 +57,6 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
> >       memset(&array, 0, sizeof(array));
> >       memset(&filter, 0, sizeof(filter));
> >
> > -     format.format = "%(objectname) %(objecttype)\t%(refname)";
> > -
> >       git_config(git_default_config, NULL);
> >       parse_options(argc, argv, prefix, opts, for_each_ref_usage, 0);
>
> This smells fishy.  We establish the hardcoded built-in default, let
> the config machinery override, and then finally let command line
> options to further override.  You may be able to reach the same end
> result by leaving the value unset, fill with the configured value,
> override with the command line, and then if the value is still
> unset, fall back to a hardcoded built-in default, but I do not see
> why such a change logically belongs to a patch to add "--omit-empty"
> feature.

This is what I did. I moved the assignment of the default value of
format.format to after parse_options() so that I could use its (lack of)
value to determine whether --format had been specified by the user,
instead of e.g. "int format_was_given = 0;". But then I of course have
to check whether parse_options() already has assigned it before maybe
assigning the default value.

But I only did all of that to be able to die with the error. If we just
allow --omit-empty then all of this can be left alone, making the code,
and the patch, simpler.

> > @@ -68,6 +68,12 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
> >               error("more than one quoting style?");
> >               usage_with_options(for_each_ref_usage, opts);
> >       }
> > +     if (omit_empty_lines && !format.format) {
> > +             error("--omit-empty-lines without --format does not make sense");
> > +             usage_with_options(for_each_ref_usage, opts);
> > +     }
>
> I wouldn't do this, for the same reason as for "git branch".
>
> > +     if (!format.format)
> > +             format.format = "%(objectname) %(objecttype)\t%(refname)";
>
> This is the other half of the earlier change I called "fishy".  It
> may be benign, but it is distracting, especially when done without
> explanation, in a change to add a feature that is not related.

It *was* related, because of the error I wanted to provide. But maybe it
isn't anymore :P

>  * do not compare output.len with 0; it is sufficient to just write
>
>         if (!omit_empty || output.len)
>

Sure, will change. Peff addressed your second point already. But perhaps
move fwrite() (or whatever other printing function) inside the if() too?

> It is hard to see that there is an empty line expected when the
> expectation is prepared like this.  Why not something like
>
>         cat >expect.full <<-\EOF &&
>         one
>         two
>
>         four (three is missing)
>         EOF
>         sed -e "/^$/d" expect.full >expect.stripped &&
>
>         git branch $args >actual &&
>         test_cmp expect.full actual &&
>
>         git branch --omit-empty $args >actual &&
>         test_cmp expect.stripped actual &&
>
> that highlights the fact that there is a missing line for one
> expectation, and that the only difference in two expectations is the
> lack of empty line(s)?

I wholeheartedly agree. I only wrote it this way because actually having
an empty line there lead to a whitespace error in the patch. But that
was because I mistakenly assumed that empty lines in an indented heredoc
also had to be prefixed by a TAB and I didn't investigate. Will fix.

> > diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> > index c466fd989f..eec9d45513 100755
> > --- a/t/t6300-for-each-ref.sh
> > +++ b/t/t6300-for-each-ref.sh
> > @@ -1374,6 +1374,14 @@ test_expect_success 'for-each-ref --ignore-case ignores case' '
> >       test_cmp expect actual
> >  '
> >
> > +test_expect_success 'for-each-ref --omit-empty-lines works' '
> > +     git for-each-ref --format="%(refname)" > actual &&
> > +     test_line_count -gt 1 actual &&
>
> The next test depends on that a branch 'main' exists, so perhaps
> that should be tested here, at least?  And then if there is no other
> branches and tags, we cannot tell if seeing only the 'main' branch
> is due to --omit-empty correctly working, or due to the repository
> having only that branch, so it is also good to check if there is
> branches or tags other than 'main' in the output.

In general I find it very hard to write meaningful tests because of
stuff like this this. In my (admittedly very limited) experience there
are usually big dependencies on prior tests in a particular test case,
and I just assumed that was okay. I often find it hard to discover what
the state of the repository is at the point in the test script where I
want to add a test, or modify an existing one.

In this particular case I know from the test case right above that main
exists. What is not immediately obvious is that at least one other ref
exists. But if that ever changes then at least 'test_line_count -gt 1
actual' will fail.

> By the way, lose SP between redirection operator '>' and its target,
> i.e. write them like so:
>
>         echo refs/heads/main >expect

Will fix.

> This feature makes %(if)...%(else)...%(end) construct complete and
> is a very good addition.
>
> Thanks for working on it.
>

Thanks for the review!

Øsse
