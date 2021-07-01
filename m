Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73B4C11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 23:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91C3461410
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 23:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbhGAXeG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 19:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbhGAXeF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 19:34:05 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A28C061762
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 16:31:33 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id hp26so469173ejc.6
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 16:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=EwYLAqfubT/r6A67j32qmkV3mYLVGDcePfTbb8uRyVY=;
        b=AP1Vu68ruNkTDMTVNX3Ouv8GC1cQt1a0s8BWeG1c1oO1BsTMembGODetP7cGL2i6+R
         pAFpyBsVcaGbe6f07UV6wbCXahM9fEFzzlnLE8ZEQv5FQ5G7gmw4U4ZITa0YkBlYYHgp
         Xe70slwIcQr/4ko1uBlLa0UlQeNDsh7rDPSQqL/8HW+XiQTq1jv5fD1Fh5sMglstO/31
         SX/pob17V1WJZF1igdB3/teLXWUzFEaiwYhDV/jLLGCOtvdj1uAXb4VI1rSp/obRFGtw
         8GA8OSI49J7HmU11/I648N4GAnoiGOAXWg81O7VLaLpzWiFABI97JHAQ1LGQGAJH1PjG
         iBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=EwYLAqfubT/r6A67j32qmkV3mYLVGDcePfTbb8uRyVY=;
        b=oWOpwpcRIkXvERSTVF12PegPR48WPbOVvYGcmomguIsi+IFIsxCFYgmdsdHvO8dB8/
         TxcSbimMUqc1Y9rdhe6h+3fqTTekkUzgcOem71xRNrQFfMVxATNv1Ss+RTN3AX/dOEf6
         Wg8/cIE3PFoFEwya+4dYzQe/+T3U8bl212Zol4dD2dRBXhYEdZZVA17/uMNoga1qtG2B
         t3RWFItiSNeP6e3X8Wa2Ai2O+kYewuVRKlfGUSkTF9cZPuieNWvPVGMTO3Wmi4rbCkL5
         Sm6d0tHYl1OTLfh8jZ64uAOTuAFfUcUe9u/RX47yz5aEfSVgQafi1/jDChph7f4NDbJO
         wQrw==
X-Gm-Message-State: AOAM532/DzGt6LJMJhduKGucPXSyCSdaovGROWegIu10qpPmG3LMscEu
        8d7X2SAOvPO7JzH6tTdzF73cp27iUthHpA==
X-Google-Smtp-Source: ABdhPJxwuFcvkG9pRJVVpCb0Gm8gEjoi3x6yCRzIfRWoVz4cDkFtmdNhmmxf6qIDJJD2ccb8E1qo6Q==
X-Received: by 2002:a17:906:84c8:: with SMTP id f8mr2338694ejy.169.1625182291008;
        Thu, 01 Jul 2021 16:31:31 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id h24sm397379edw.45.2021.07.01.16.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:31:30 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 29/34] fsmonitor--daemon: use a cookie file to sync
 with file system
Date:   Fri, 02 Jul 2021 01:17:30 +0200
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <555caca2216dd3e459c118d76b46eb983a58e051.1625150864.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <555caca2216dd3e459c118d76b46eb983a58e051.1625150864.git.gitgitgadget@gmail.com>
Message-ID: <878s2pboha.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Teach fsmonitor--daemon client threads to create a cookie file
> inside the .git directory and then wait until FS events for the
> cookie are observed by the FS listener thread.
>
> This helps address the racy nature of file system events by
> blocking the client response until the kernel has drained any
> event backlog.
>
> This is especially important on MacOS where kernel events are
> only issued with a limited frequency.  See the `latency` argument
> of `FSeventStreamCreate()`.  The kernel only signals every `latency`
> seconds, but does not guarantee that the kernel queue is completely
> drained, so we may have to wait more than one interval.  If we
> increase the frequency, the system is more likely to drop events.
> We avoid these issues by having each client thread create a unique
> cookie file and then wait until it is seen in the event stream.

Is this a guaranteed property of any API fsmonitor might need to work
with (linux, darwin, Windows) that if I perform a bunch of FS operations
on my working tree, that if I finish up by touching this cookie file
that that'll happen last?

I'd think that wouldn't be the case, i.e. on POSIX filesystems unless
you run around fsyncing both files and directories you're not guaranteed
that they're on disk, and even then the kernel might decide to sync your
cookie earlier, won't it?

E.g. on Linux you can even have cross-FS watches, and mix & match
different FS types. I'd expect to get events in whatever
implementation-defined order the VFS layer + FS decided to sync them to
disk in & get to firing off an event for me.

Or do these APIs all guarantee that a linear view of the world is
presented to the API consumer?


> Co-authored-by: Kevin Willford <Kevin.Willford@microsoft.com>
> Co-authored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  builtin/fsmonitor--daemon.c | 228 +++++++++++++++++++++++++++++++++++-
>  fsmonitor--daemon.h         |   5 +
>  2 files changed, 232 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
> index 8249420ba18..25f18f2726b 100644
> --- a/builtin/fsmonitor--daemon.c
> +++ b/builtin/fsmonitor--daemon.c
> @@ -94,6 +94,149 @@ static int do_as_client__status(void)
>  	}
>  }
>  
> +enum fsmonitor_cookie_item_result {
> +	FCIR_ERROR = -1, /* could not create cookie file ? */
> +	FCIR_INIT = 0,
> +	FCIR_SEEN,
> +	FCIR_ABORT,
> +};
> +
> +struct fsmonitor_cookie_item {
> +	struct hashmap_entry entry;
> +	const char *name;
> +	enum fsmonitor_cookie_item_result result;
> +};
> +
> +static int cookies_cmp(const void *data, const struct hashmap_entry *he1,
> +		     const struct hashmap_entry *he2, const void *keydata)
> +{
> +	const struct fsmonitor_cookie_item *a =
> +		container_of(he1, const struct fsmonitor_cookie_item, entry);
> +	const struct fsmonitor_cookie_item *b =
> +		container_of(he2, const struct fsmonitor_cookie_item, entry);

Re earlier comments about verbose names, these are just enums in a
builtin/*.c file, so a name like "cookie_item" is fine, and then the
whole thing might even fit on one line.. :)

> [...]
> +	/*
> +	 * We will write filesystem syncing cookie files into
> +	 * <gitdir>/<fsmonitor-dir>/<cookie-dir>/<pid>-<seq>.
> +	 *
> +	 * The extra layers of subdirectories here keep us from
> +	 * changing the mtime on ".git/" or ".git/foo/" when we create
> +	 * or delete cookie files.
> +	 *
> +	 * There have been problems with some IDEs that do a
> +	 * non-recursive watch of the ".git/" directory and run a
> +	 * series of commands any time something happens.
> +	 *
> +	 * For example, if we place our cookie files directly in
> +	 * ".git/" or ".git/foo/" then a `git status` (or similar
> +	 * command) from the IDE will cause a cookie file to be
> +	 * created in one of those dirs.  This causes the mtime of
> +	 * those dirs to change.  This triggers the IDE's watch
> +	 * notification.  This triggers the IDE to run those commands
> +	 * again.  And the process repeats and the machine never goes
> +	 * idle.
> +	 *
> +	 * Adding the extra layers of subdirectories prevents the
> +	 * mtime of ".git/" and ".git/foo" from changing when a
> +	 * cookie file is created.
> +	 */
> +	strbuf_init(&state.path_cookie_prefix, 0);
> +	strbuf_addbuf(&state.path_cookie_prefix, &state.path_gitdir_watch);
> +
> +	strbuf_addch(&state.path_cookie_prefix, '/');
> +	strbuf_addstr(&state.path_cookie_prefix, FSMONITOR_DIR);
> +	mkdir(state.path_cookie_prefix.buf, 0777);
> +
> +	strbuf_addch(&state.path_cookie_prefix, '/');
> +	strbuf_addstr(&state.path_cookie_prefix, FSMONITOR_COOKIE_DIR);
> +	mkdir(state.path_cookie_prefix.buf, 0777);
> +
> +	strbuf_addch(&state.path_cookie_prefix, '/');

So, on some stupid IDEs (would be nice to have specifics in the commit
message, which ones/versions?) this avoids causing infinite activity,
but on slightly more industrious stupid IDEs that would do their own
recursive watch we'll have the same problem?

Perhaps we should just consider creating it at the top-level and those
IDEs will eventually sort out their bugs, sooner than later if this
feature ships...

> +	strbuf_release(&state.path_cookie_prefix);
> +
> +	/*
> +	 * NEEDSWORK: Consider "rm -rf <gitdir>/<fsmonitor-dir>"
> +	 */

That would also make this trivial, presumably it's a "needswork" since
you have this recursive structure, but if it's at the top-level we
already did the unlink() above, so NEEDSWORK solved then?
