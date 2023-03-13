Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C25EC6FD1C
	for <git@archiver.kernel.org>; Mon, 13 Mar 2023 23:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjCMXLs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 19:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCMXLq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 19:11:46 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A71525C
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 16:11:45 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so3750391pjz.1
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 16:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678749105;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8pNZhL0JhYSdkc0SZa5XqxrgWQryf6a76NXxaolKCYE=;
        b=F/xEiO4yaQcWv6bIrCDDq8tfPPAJ+7Y1A52fBJqNM5HoHNkoKTzQhEgvzsYzgfxD4c
         W7eTAqGpyVh2Io6+RxaK5b1ZzZFXxEqeWPT0aFecfIo/hqtVaWfzwFe3ejqVE2yMRfIN
         t5RksafrbbOsUAoeoMgliZ6NrPwFKG9V5I5YLY1EqG88wHr2J8mi/dlnC+gRgWRfFRh+
         MvKExVftImQmxpnIQxsmcA51H8jyNtj4SnuQwy1S8Z6yfxDYKbEOmXoolKJoa0JG8tqY
         5CDDVo5JaFFKjpCOxFfthIefm2XG19UvinkMvWdgx6gXITaHP1C1LSnNnfW/Zhkvgu1/
         Wn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678749105;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8pNZhL0JhYSdkc0SZa5XqxrgWQryf6a76NXxaolKCYE=;
        b=B9ZiI7TXiPkCHDlXH6EvKw4sbI9zvhjPfSTEWOne+SZUBuShVg1JQ1EfLss5U9jvB4
         XkgO5+vA/Etx2z/7o+P20EHsQ3622NIXa8n0z9IzaxklR9Sluz6KJTCOB+IMF+67XgT+
         KaaK6z7Lx470AfLgkDV968lCHWz3LeA7zrr/zYfFZrd7Lj3LucA7JF8TiiBtzZ/QoiMD
         GQaZ/2CM7ZAbIGJLJp5jY48iFzIqqPpDG1wLn62LW9HIp4VHMmmVr/CuM9saNAQvn9cn
         JIcivV4Cwi5izv7uMue/3m5gsQotlmJjSt5eCm0oTnZg2s6R30Ku1VA38AydH7JOuov4
         3Oqw==
X-Gm-Message-State: AO0yUKVb9YiGqatVVKopVoxG1ulKEZQaOL3sguEQLyMc9aRHrS7fLSgY
        zWoJ+rwLjeN5TzvFj/Ow2gI=
X-Google-Smtp-Source: AK7set93KrpfUS9CvUVqKKD8MvIwpaLDebF+CHLg0wnylaioGKrjqSNGb0jJq05hjoS+MmPgny3nmQ==
X-Received: by 2002:a05:6a20:cf5e:b0:cd:ed5c:4be with SMTP id hz30-20020a056a20cf5e00b000cded5c04bemr28691928pzb.25.1678749104883;
        Mon, 13 Mar 2023 16:11:44 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id c19-20020aa78813000000b005907716bf8bsm243675pfo.60.2023.03.13.16.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 16:11:44 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Hugo Sales via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Hugo Sales <hugo@hsal.es>
Subject: Re: [PATCH] Add `restore.defaultLocation` option
References: <pull.1467.git.git.1678578153640.gitgitgadget@gmail.com>
Date:   Mon, 13 Mar 2023 16:11:44 -0700
Message-ID: <xmqq1qlss0un.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Hugo Sales via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Subject: Re: [PATCH] Add `restore.defaultLocation` option

As to the form, perhaps

	Subject: [PATCH] restore: make it configurable what gets updated

cf. Documentation/SubmittingPatches[[describe-changes]]

Also on substance,

 * "option" usually refers to the --option given on the command
   line; when you mean "configuration variable", it is a misleading
   word to use.

 * "restore" command deals with two quite conceptually different
   locations.  Where it gets the contents from (i.e. the source
   location), and where the contents are used to update (i.e. the
   destination location).  The ".defaultLocation" is a poor name for
   a configuration variable because it does not convey which one is
   meant.

> From: Hugo Sales <hugo@hsal.es>
>
> This options allows control over which of `--worktree` or `--staged` is
> applied when `git restore` is invoked with neither
>
> This patch is intended to reduce lost work to accidental `git restore .`
> when `git restore --staged .` was intended.

We usually describe the status quo (what the current system does),
what bad things can happen with the current system, and then what
change is proposed to improve the situation, in this order.  So the
above is backwards.  Perhaps like

    "git restore" takes "--worktree" and/or "--staged" options to
    specify which one of the working tree files and/or the index
    entries are updated.  With neither options, the command by
    default updates the working tree files.

    A user who wanted to reset the index entries from HEAD may by
    mistake run "git restore" without the "--staged" option.  When
    such a mistake happens, the work made in the working tree files
    that are not yet added to the index will be forever lost.

    Introduce the restore.defaultDestination configuration variable,
    which can be set to one of "both", "index", or "worktree", to
    help those users who want to set it to "index" to avoid touching
    the working tree files by mistake.  They now force themselves to
    use the "--worktree" option explicitly when they want to restore
    the working tree files.

or something along that line would make it more like our log messages.

Note that even though I wrote the above by guessing what your
motivation behind this change is, I do not very much agree with the
third paragraph myself.  I think a better solution would be to teach
these users to use "git reset -- <path>" when they want to reset the
index entries, and not run the "git restore" command.


> +	This
> +	option can be used to prevent accidentally losing work by running `git
> +	restore .` when `git restore --staged .` was intended.

This is better left out, as it cuts both ways.  With it set to
'index', this option will clobber the index entries the user
carefully prepared so far with "git add -p" and friends, when the
user wanted to update the working tree files (either from the index
or from an existing commit) by running "git restore", which will
lose work.

If we wanted to advertise it as a feature, then the sentence should
say something like

	This variable can be set to 'index' to prevent accidentally
	losing work ...

"can be used" is too vague when you are talking about setting it to
a particular value.  IOW, setting it to any other value would *NOT*
prevent "git restore" from behaving differently from "git resetore --staged".

Again, I do not think it is a good idea to sell it as a feature in
the first place, as it cuts both ways.

> diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
> index 5964810caa4..28165861f55 100644
> --- a/Documentation/git-restore.txt
> +++ b/Documentation/git-restore.txt
> @@ -14,14 +14,18 @@ SYNOPSIS
>  
>  DESCRIPTION
>  -----------
> -Restore specified paths in the working tree with some contents from a
> +Restore specified paths in the working tree or index with some contents from a

Shouldn't it be "and/or"?

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index a5155cf55c1..5067753030b 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1942,6 +1966,7 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
>  	struct branch_info new_branch_info = { 0 };
>  
>  	memset(&opts, 0, sizeof(opts));
> +
>  	opts.accept_ref = 0;
>  	opts.accept_pathspec = 1;
>  	opts.empty_pathspec_ok = 0;

Why?


> diff --git a/t/t2070-restore.sh b/t/t2070-restore.sh
> index 7c43ddf1d99..6e9b06e0bf4 100755
> --- a/t/t2070-restore.sh
> +++ b/t/t2070-restore.sh
> @@ -137,4 +137,128 @@ test_expect_success 'restore --staged invalidates cache tree for deletions' '
>  	test_must_fail git rev-parse HEAD:new1
>  '
>  
> +test_expect_success 'restore with restore.defaultLocation unset works as if --worktree given' '
> +	test_when_finished git reset --hard HEAD^ &&
> +	test_commit root-unset-restore.defaultLocation &&
> +	test_commit unset-restore.defaultLocation one one &&
> +	> one &&

Lose SP between ">" and "one", its redirection target.

cf. Documentation/CodingGuidelines, look for "Redirection operators
should be written with space before, but no space after them." and
study the entire paragraph.

> +	git restore one &&
> +	test -z $(git status --porcelain --untracked-files=no) &&

This (together with many other uses of "git status" in the new
tests) will not catch a segfaulting "git status".

Thanks.
