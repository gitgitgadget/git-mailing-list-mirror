Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_C,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF49C433E8
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 20:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13C0220B1F
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 20:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="drrsRbI8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgGWUWC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:22:02 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53613 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgGWUWB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 16:22:01 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BAC82D4482;
        Thu, 23 Jul 2020 16:21:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=Bw/U8EyjXxVJKOoJ81SC5jRXhJc=; b=drrsRbI8GG2Y6mKFm7dl
        V892EU7Yf2N2kzp5dTWJHkSqEwI3MyG+vgMrF/KS+gwLnYQSfwoxVyFtoYRJQCsY
        fYQX53KiVUpWvOBfdxfDQLxd00ATxPcVa5Q15SLAcCpNi90W1vcfo85RMLV0yhnn
        l701IOQ5ShanARKRtZL9/fk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=rLPt8gp3LYYjllP5koDs4nBq4t5bubc3S/PKDUo8cKN0pQ
        PENgmdZuOF6rgfhRJVX9oPriJJGObUp1q/ckOtCHFKw+cEkfVba99MVmi7f/dlUw
        GlN7JCQyu+ZIqVcaKjWSGHLz8M5o+lTp7G3ovJC/2JKmsn3POvKZY64yz94mo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B3862D4481;
        Thu, 23 Jul 2020 16:21:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 035E4D4480;
        Thu, 23 Jul 2020 16:21:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 03/18] maintenance: replace run_auto_gc()
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
        <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
        <f164d1a0b4363eb6eb174e90e88211829f8a1d55.1595527000.git.gitgitgadget@gmail.com>
Date:   Thu, 23 Jul 2020 13:21:55 -0700
Message-ID: <xmqqblk6q8ws.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 27E7F7A4-CD22-11EA-A31C-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +--[no-]maintenance::
>  --[no-]auto-gc::
> -	Run `git gc --auto` at the end to perform garbage collection
> -	if needed. This is enabled by default.
> +	Run `git maintenance run --auto` at the end to perform garbage
> +	collection if needed. This is enabled by default.

Shouldn't the new synonym be called --auto-maintenance or an
abbreviation thereof?  It is not like we will run the full
maintenance suite when "--no-maintenance" is omitted, which
certainly is not the impression we want to give our readers.

>  These objects may be removed by normal Git operations (such as `git commit`)
> -which automatically call `git gc --auto`. (See linkgit:git-gc[1].)
> -If these objects are removed and were referenced by the cloned repository,
> -then the cloned repository will become corrupt.
> +which automatically call `git maintenance run --auto` and `git gc --auto`.

Hmph.  Perhaps the picture may change in the end of the series but I
got an impression that "gc --auto" would eventually become just part
of "maintenance --auto" and the users won't have to be even aware of
its existence?  Wouldn't we rather want to say something like

	--[no-]auto-maintenance::
	--[no-]auto-gc::
                Run `git maintenance run --auto` at the end to perform
                garbage collection if needed (`--[no-]auto-gc` is a
                synonym).  This is enabled by default.
	
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 82ac4be8a5..49a4d727d4 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -196,8 +196,10 @@ static struct option builtin_fetch_options[] = {
>  	OPT_STRING_LIST(0, "negotiation-tip", &negotiation_tip, N_("revision"),
>  			N_("report that we have only objects reachable from this object")),
>  	OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),

> +	OPT_BOOL(0, "maintenance", &enable_auto_gc,
> +		 N_("run 'maintenance --auto' after fetching")),
>  	OPT_BOOL(0, "auto-gc", &enable_auto_gc,
> +		 N_("run 'maintenance --auto' after fetching")),

OK, so this is truly a backward-compatible synonym at this point.

> diff --git a/run-command.c b/run-command.c
> index 9b3a57d1e3..82ad241638 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1865,14 +1865,17 @@ int run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
>  	return result;
>  }
>  
> -int run_auto_gc(int quiet)
> +int run_auto_maintenance(int quiet)
>  {
>  	struct argv_array argv_gc_auto = ARGV_ARRAY_INIT;
>  	int status;
>  
> -	argv_array_pushl(&argv_gc_auto, "gc", "--auto", NULL);
> +	argv_array_pushl(&argv_gc_auto, "maintenance", "run", "--auto", NULL);
>  	if (quiet)
>  		argv_array_push(&argv_gc_auto, "--quiet");
> +	else
> +		argv_array_push(&argv_gc_auto, "--no-quiet");
> +
>  	status = run_command_v_opt(argv_gc_auto.argv, RUN_GIT_CMD);
>  	argv_array_clear(&argv_gc_auto);
>  	return status;

Don't we want to replace all _gc_ with _maintenance_ in this
function?  I think the first business before we can do so would be
to rethink if spelling out "maintenance" fully in code is a good
idea in the first space.  It would make names for variables,
structures and fields unnecessarily long without contributing to
ease of understanding an iota, and a easy-to-remember short-form or
an abbreviation may be needed.  Using a short-form/abbreviation
wouldn't worsen the end-user experience, and not the developer
experience for that matter.

If we choose "gc" as the short-hand, most of the change in this step
would become unnecessary.  I also do not mind if we some other words
or word-fragment (perhaps "maint"???) is chosen.

> diff --git a/run-command.h b/run-command.h
> index 191dfcdafe..d9a800e700 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -221,7 +221,7 @@ int run_hook_ve(const char *const *env, const char *name, va_list args);
>  /*
>   * Trigger an auto-gc
>   */
> -int run_auto_gc(int quiet);
> +int run_auto_maintenance(int quiet);
>  
>  #define RUN_COMMAND_NO_STDIN 1
>  #define RUN_GIT_CMD	     2	/*If this is to be git sub-command */
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index a66dbe0bde..9850ecde5d 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -919,7 +919,7 @@ test_expect_success 'fetching with auto-gc does not lock up' '
>  		git config fetch.unpackLimit 1 &&
>  		git config gc.autoPackLimit 1 &&
>  		git config gc.autoDetach false &&
> -		GIT_ASK_YESNO="$D/askyesno" git fetch >fetch.out 2>&1 &&
> +		GIT_ASK_YESNO="$D/askyesno" git fetch --verbose >fetch.out 2>&1 &&
>  		test_i18ngrep "Auto packing the repository" fetch.out &&
>  		! grep "Should I try again" fetch.out
>  	)
