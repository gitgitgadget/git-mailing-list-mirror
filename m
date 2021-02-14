Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601EEC433DB
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 01:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11A3D64E3F
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 01:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhBNBml (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Feb 2021 20:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhBNBmk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Feb 2021 20:42:40 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61FAC061574
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 17:41:59 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id z22so4214373edb.9
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 17:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=MUil7B10hMZXqoW5K0pY/tmcJ37zd5dMPo7U3z8WUHo=;
        b=PB+CLzvXQNCKYRxAMaVECsy+OLrN/3zSQ/LTyYUzWbQ8B4bDERCsY/a6FsUSzwIlIK
         y32+sqU9opJGZoaAo+WTQo9j8ZbDIAkXKtgP+YliGgBNHPW6NaMmMBBK1ISDyd6J2k66
         r0XfCRN8t0/0e7bN54MCVn9m9U0j+6uMiYAo6gt5kNLiBj/MIlIKGKgp0Tk/BrBcLIQh
         RANiDTZURCEG4OxnzWNqOnNadE9nfkyI6h3WM4nOE1Zp589GqO6Yo9kCd9bEpkznl3ZU
         UiUaHt2sgZTn3YFt1mgywJ1kxWQ9dtYeZCF+UngL9/pTuyperbijfKoYX0gagtTRpVTN
         SPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=MUil7B10hMZXqoW5K0pY/tmcJ37zd5dMPo7U3z8WUHo=;
        b=nomw6KWwsjRaXfUc91ynQNxgwCa8NDwJsPE2M+0hKvBFDtJqxhuwS9p0nONwyiMn6G
         X6irrw6V0nY9F7+QYhjfuJD4EQ7o6Z4qpZ2lN7gbs9kx46QkqU3NxGMEahP53qPFOZVM
         25r+khqxikZkjvZzWrdbdIz5Xn+DvrxEQocuY2yxTNMxpl8mlMsNYKtbbLR8e69jFUe3
         a2gDT2pOCC30LFFgJIQgoUqavPvCd4MvzoazOrY30xCGvyQOgn1vcv9YHIE8sP3CtJ2F
         rcA7hui0UjIDkSpgchsWSaybs2dFBqdF9r8hZV+FLX5uh18o+YtMpKstO0fGq7yMgn0C
         pvrQ==
X-Gm-Message-State: AOAM531dIYbzrY0PBraBE4w9wmpI5f1UO85sDnNo7DmCb2YQlNWnoibK
        Mlx5fhpE+zJGMwH8DC2ykhQDV8abLOcGyQ==
X-Google-Smtp-Source: ABdhPJySMJXJStwA0Kt7sh8E9YMO4Q73xa+oHSoaB3hyjVcbpuOq9QMj/pplMQLv01fHKaausFnB2w==
X-Received: by 2002:a50:e14d:: with SMTP id i13mr9608728edl.106.1613266918321;
        Sat, 13 Feb 2021 17:41:58 -0800 (PST)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id f22sm8483849eje.34.2021.02.13.17.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 17:41:57 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Adam Spiers <git@adamspiers.org>
Cc:     git list <git@vger.kernel.org>,
        Protesilaos Stavrou <info@protesilaos.com>
Subject: Re: [PATCH] userdiff: add support for Emacs Lisp
References: <20210213192447.6114-1-git@adamspiers.org>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210213192447.6114-1-git@adamspiers.org>
Date:   Sun, 14 Feb 2021 02:41:57 +0100
Message-ID: <87wnvbbf2y.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Feb 13 2021, Adam Spiers wrote:

> Add a diff driver which recognises Elisp top-level forms and outline
> headings for display in hunk headers, and which correctly renders word
> diffs.

Neat, I for one would find this useful.

> This approach was previously discussed on the emacs-devel mailing list:
>
>    https://lists.gnu.org/archive/html/emacs-devel/2021-02/msg00705.html
>
> * userdiff.c (builtin_drivers): Provide regexen for Elisp top level
>   forms and outline headings, and for word diffs.
> * t/t4018-diff-funcname.sh (diffpatterns): Add test for elisp driver
> * t/t4018/elisp-outline-heading: Test fixture for outline headings
> * t/t4018/elisp-top-level-form: Test fixture for top level forms
> * t/t4034-diff-words.sh: Add test for elisp driver
> * t/t4034/elisp/*: Test fixtures for word diffs

Please no on the overly verbose emacs.git convention of per-file
changelogs in commit messages :)

> diff --git a/t/t4018/elisp-outline-heading b/t/t4018/elisp-outline-heading
> new file mode 100644
> index 0000000000..c13bdafafe
> --- /dev/null
> +++ b/t/t4018/elisp-outline-heading
> @@ -0,0 +1,6 @@
> +;;; A top-level outline heading
> +;;;; A second-level outline heading RIGHT
> +
> +;; This is a ChangeMe comment outside top-level forms
> +(defun foo ()
> +  (bar 1 2 3)
> diff --git a/t/t4018/elisp-top-level-form b/t/t4018/elisp-top-level-form
> new file mode 100644
> index 0000000000..683f7ffcf1
> --- /dev/null
> +++ b/t/t4018/elisp-top-level-form
> @@ -0,0 +1,7 @@
> +;;; Outline heading
> +
> +;; This is a comment
> +(RIGHT
> +  (list 1 2 3)
> +  ChangeMe
> +  (list a b c))
> diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
> index 0c8fb39ced..a546ee831a 100755
> --- a/t/t4034-diff-words.sh
> +++ b/t/t4034-diff-words.sh
> @@ -315,6 +315,7 @@ test_language_driver cpp
>  test_language_driver csharp
>  test_language_driver css
>  test_language_driver dts
> +test_language_driver elisp
>  test_language_driver fortran
>  test_language_driver html
>  test_language_driver java
> diff --git a/t/t4034/elisp/expect b/t/t4034/elisp/expect
> new file mode 100644
> index 0000000000..29a6ef2520
> --- /dev/null
> +++ b/t/t4034/elisp/expect
> @@ -0,0 +1,9 @@
> +<BOLD>diff --git a/pre b/post<RESET>
> +<BOLD>index 4a39df8..6619e96 100644<RESET>
> +<BOLD>--- a/pre<RESET>
> +<BOLD>+++ b/post<RESET>
> +<CYAN>@@ -1,4 +1,4 @@<RESET>
> +(defun <RED>myfunc<RESET><GREEN>my-func<RESET> (<RED>a b<RESET><GREEN>first second<RESET>)
> +  "This is a <RED>really<RESET><GREEN>(moderately)<RESET> cool function."
> +  (let ((c (<RED>+ a b<RESET><GREEN>1+ first<RESET>)))
> +    (format "one more than the total is %d" (<RED>1+<RESET><GREEN>+<RESET> c <GREEN>second<RESET>))))
> diff --git a/t/t4034/elisp/post b/t/t4034/elisp/post
> new file mode 100644
> index 0000000000..6619e96657
> --- /dev/null
> +++ b/t/t4034/elisp/post
> @@ -0,0 +1,4 @@
> +(defun my-func (first second)
> +  "This is a (moderately) cool function."
> +  (let ((c (1+ first)))
> +    (format "one more than the total is %d" (+ c second))))
> diff --git a/t/t4034/elisp/pre b/t/t4034/elisp/pre
> new file mode 100644
> index 0000000000..4a39df8ffb
> --- /dev/null
> +++ b/t/t4034/elisp/pre
> @@ -0,0 +1,4 @@
> +(defun myfunc (a b)
> +  "This is a really cool function."
> +  (let ((c (+ a b)))
> +    (format "one more than the total is %d" (1+ c))))
> diff --git a/userdiff.c b/userdiff.c
> index 3f81a2261c..292e51674a 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -53,6 +53,15 @@ PATTERNS("dts",
>  	 /* Property names and math operators */
>  	 "[a-zA-Z0-9,._+?#-]+"
>  	 "|[-+*/%&^|!~]|>>|<<|&&|\\|\\|"),
> +PATTERNS("elisp",
> +	 /* Top level forms and outline headings */
> +	 "^((\\(|;;;+ +).+)",
> +	 /*
> +	  * Emacs Lisp allows symbol names containing any characters.
> +	  * However spaces within the symbol must be escaped.
> +	  */
> +	 "(\\.|[^ ()])+"
> +	 ),
>  PATTERNS("elixir",
>  	 "^[ \t]*((def(macro|module|impl|protocol|p)?|test)[ \t].*)$",
>  	 /* -- */

I think this patch would benefit from first being dogfooded in the
emacs-devel community. There's an existing regex in emacs.git's
autoconf.sh which anyone developing emacs.git is using.

If you run:

    diff -u <(git -c diff.elisp.xfuncname='^\(def[^[:space:]]+[[:space:]]+([^()[:space:]]+)' log -p -- lisp | grep -m 100 @@) \
	    <(git -c diff.elisp.xfuncname='^((\(|;;;+ +).*)$' log -p -- lisp | grep -m 100 @@) \
    | less

You can see how it differs from yours, and that also neatly answers the
question[1] you had in the linked thread about why these patterns tend
to be explicitly scoped to how you define a function/package/whatever in
the language in question.

Just a cursory "git log -p -- lisp" in emacs.git with your patch shows
e.g. lisp/thingatpt.el where forms in a "defun" aren't indented (before
it selects the "defun", after with yours it's a "put" in the middle of
the function).

Yours also changes it from e.g.:

    @@ -61,7 +61,7 @@ forward-thing

to:

    @@ -61,7 +61,7 @@ (defun forward-thing (thing &optional n)

Is this really desired in elisp? I also note how our tests in
t4018-diff-funcname.sh are really bad in not testing for this at
all. I.e. we just test that we match the right line, not how we extract
a match from it.

1. https://lists.gnu.org/archive/html/emacs-devel/2021-02/msg00739.html
