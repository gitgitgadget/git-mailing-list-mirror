Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51793C433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 11:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A32E64DF0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 11:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhBPLOp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 06:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhBPLO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 06:14:29 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD9EC061574
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:13:47 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id i23so9613529ejg.10
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=dQ3jGZ1fAGqyafxINj+eTu6SHfiJ7zE6Si5KfTA2efM=;
        b=K76gHLizWnIggWTYmaMojDK0d1VBZpq4UY98DWl8O9jTb7MdD8xT+xuX8EU7dXFZCf
         FPlwjV/cuIPz5f1Bchwp28Ly0Xh3I8drH5OKL9tjB11p6iknECRKTG4vQBvIIhOCAjIj
         Sm/jD7BkFiiYDyVIeEWv90sKLD9C2o7z1zxvWeInrfNcHO4kbhy65kDashkrC5cc1pIP
         0k6kfWH05MaFwnKUwNdeY8Iz/e0jJT0WSuUU24niyITruhoc7KZgEQywyBIPowpyukLZ
         Emk6bue77b/7+FwNLtcLWEB/RnI41s86wB9iljqHMcrFLllmFctiqM4odONRfsfHphCe
         EgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=dQ3jGZ1fAGqyafxINj+eTu6SHfiJ7zE6Si5KfTA2efM=;
        b=JaFpQR0OD/eauNKsnFPaiY3vyFvQsqpXGa0JtdhcCzqFkhjcYUI0ROpenJfV5odN2Q
         L4FbA/1XoZVP8ViaNm91JFEk7XYqS7qcJ7/rAKl49PfaAVJQ6Qxxbpl7G0U2b1fe+GaR
         TeswverD9iINB7RhRzuaAeMS48ofNv9U+TaXcBTeem3d4vuVOqn7utsKoAbzSK5WpE5W
         fSIxw5SaQrUf0iy96mr+9d/YOR6MnJbEEjGI34bGyVZKR2HzQphGmlNz/WkMC8YnaQqg
         J8I0szIhADPr3fbeFg4d2h1K8RuWElTKkv5cexIzUZsYY7Jj2vV2NSruJneFrz4bW/YO
         O4jg==
X-Gm-Message-State: AOAM5323wS0MRyn2lKEL/2SFpm0nH9cjqukeW1xW2Llf+KqBuMPEZaTv
        YN6jeEeMMNlHL7woCnaGky9l4a2xqwAIrA==
X-Google-Smtp-Source: ABdhPJykkT7rAQK1x42xeJ360Rql06z5NNXSbXb4AO5YXxg3vniL7IFIDTxcoWBjhFkB+OO4VoVGig==
X-Received: by 2002:a17:906:1a0c:: with SMTP id i12mr19371237ejf.276.1613474026238;
        Tue, 16 Feb 2021 03:13:46 -0800 (PST)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id g3sm13845102edk.75.2021.02.16.03.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 03:13:45 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Protesilaos Stavrou <info@protesilaos.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Adam Spiers <git@adamspiers.org>,
        "git list" <git@vger.kernel.org>
Subject: Re: [PATCH] userdiff: add support for Emacs Lisp
References: <20210213192447.6114-1-git@adamspiers.org>
        <87wnvbbf2y.fsf@evledraar.gmail.com>
        <aab77ef2-c619-ed87-6c3b-9a1b5ec36f41@kdbg.org>
        <87tuqebj6m.fsf@evledraar.gmail.com> <87lfbo5sg8.fsf@protesilaos.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <87lfbo5sg8.fsf@protesilaos.com>
Date:   Tue, 16 Feb 2021 12:13:45 +0100
Message-ID: <87v9as9seu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 16 2021, Protesilaos Stavrou wrote:

> On 2021-02-14, 19:25 +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avara=
b@gmail.com> wrote:
>
>> On Sun, Feb 14 2021, Johannes Sixt wrote:
>>
>>> Am 14.02.21 um 02:41 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>>> Just a cursory "git log -p -- lisp" in emacs.git with your patch shows
>>>> e.g. lisp/thingatpt.el where forms in a "defun" aren't indented (before
>>>> it selects the "defun", after with yours it's a "put" in the middle of
>>>> the function).
>>>
>>> Note that negative matches can be specified. We use the feature in the
>>> cpp case to exclude public:/protected:/private: and label: that happen=
=20
>>> to be not indented. Perhaps that can be useful here?
>>>
>>> Oh, and BTW, what the patterns treat as "function" must not match what
>>> the language treats as function. The purpose of the hunk header is to=20
>>> spot a place in the source file easily. So, it does not hurt if
>>> eval-and-compile forms are captured (as was mentioned in the linked=20
>>> thread) if desired.
>>
>> Right, so having lots of test-case is helpful, e.g. for elisp maybe you
>> have a top-level defun, maybe not, maybe the top-level is a "(progn" so
>> you'd like a second-level more meaningful context, or maybe not...
>>
>> Obviously these userdiff patterns aren't a general parser and will
>> always be hit-and-miss, it's just useful to at least eyeball them
>> against in-the-wild test data to check their sanity & add some tests.
>
> Our intent with this patch is to rely on a heuristic that works for most
> cases.  There will always be some case that is not covered.  This point
> was made explicit in the relevant emacs-devel thread.

Yes these heuristics will always be bad in some cases. I'm just
encouraging you to find some of the more common cases, make test-cases
out of them, to say "this is what I want".

The most common difference I've seen is that by finding comments it
means for changes like this:
=20=20=20=20
    (def foo ()
         "..."
         (some-code)
    ;; comments inside functions are often not indented
       (blah))
=20=20=20=20
    (def bar ()
         "..."
         CHANGE_ME)

Before we'd find "foo" as the context, now we find ";; comments inside
functions are often not indented".

There's other cases where that comment rule does the right
thing. E.g. finding the description of the file at the top, but we could
also capture that with:

    ^(;;; [^.]+\.el ---.*)'

Then you'd get things like:

    ;;; button.el --- clickable buttons

Without overmatching any and all comments. Or maybe it isn't
overmatching and is better in the common case. I don't know.

Another example is now we'll match "(progn", sometimes that's "right",
sometimes "wrong". Perhaps even in cases where that's "right" the common
"(progn" pattern doesn't provide much/any extra information, and we'd be
better to skip past it with a negative rule to the next "(def" ?

I'm typing this in mu4e, but I wouldn't call myself deeply familiar with
Elisp. My reading of the linked thread / blog posts it links to is that
some other people came up with more narrow matching rules, presumably
because they found some of these cases.

So all I'm suggesting is maybe pro-actively find those cases & loop
those people in.

>> My cursory glance at the emacs.git version v.s. what's being submitted
>> here is that this one does a worse job in *very common* cases.
>>
>>>> Yours also changes it from e.g.:
>>>>      @@ -61,7 +61,7 @@ forward-thing
>>>> to:
>>>>      @@ -61,7 +61,7 @@ (defun forward-thing (thing &optional n)
>>>> Is this really desired in elisp?
>
> I think this is a matter of perspective and indeed a valid reason for
> doing this in emacs.git first.
>
> For my part, I find the verbose style more informative, especially when
> it captures the previous form instead of the one directly around the
> diffed lines.
>
> Perhaps one could add to that Emacs' ability to use the same name for
> different things, e.g. a function and a variable, where verbosity of
> this sort can help with disambiguation.  Granted, we should not really
> on such a heading style to aid us in that task, though it may be
> something to consider.

I'm not saying it needs to be done in emacs.git first, just maybe
coordinate with people who wrote/use that rule.

I think matching the whole line makes sense (sans leading whitespace),
we do it for the rest of the git.git rules.

>>> It's common practice to extract the entire line (sans indentation if
>>> applicable), not just the function name. Why would somebody want the=20
>>> latter? It doesn't carry as much information as could be possible.
>>
>> Because I'm familiar with the codebase I'm editing and I just need to
>> know that the diff I'm viewing is on the "main" function, not that it's
>> "main()", "int main(int argv, char **argv)", "int main(const int argv,
>> const char *argv[])", or to either have a " {" or not at the end
>> depending on the project's coding style.
>
> Oftentimes we produce/read patches for projects that we are not
> necessarily acquainted with.  This includes emacs.git and the multitude
> of Elisp packages in that milieu.  An extra element of contextuality can
> do us good.
>
> It is true that familiarity with the code base will always benefit from
> succinct headings, though I feel that whenever we are in doubt we should
> err on the side of caution: which means that we must not introduce such
> an assumption to the workings of this piece of functionality.
>
>> I know our own userdiff builtin patterns don't do this, but it would be
>> very useful to retrofit this capability / maybe make it a configurable
>> feature, i.e. have them capture the meaningful part of the line, and you
>> could either print it all, or just that part.
>
> It would be nice to have an option that toggles verbosity.  Though I
> guess this lies outside the scope of the patch in question.

Yes I agree that this is completely outside the scope of adding elisp
support to userdiff.

I was just replying generally to Johaness on the topic of why someone
would want a pattern to match $1 over $0, as most of our git.git
patterns do (or if it's $1, it's the whole line anyway, sans leading
whitespace).

> In conclusion, I think we should decide on the next step forward: if you
> think this should be applied to emacs.git before making its way to git
> itself, then we can move the discussion there.

I think just applying a version to this to git.git is fine, and it
should not wait for whatever 20-some patches test mechanism rewrite I
started. I can rebase on top of this.

B.t.w. emacs.git also has a rule for *.texi, perhaps you'd be interested
in hacking that up too? :)
