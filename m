Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57B4C433F5
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 05:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAF4060E9B
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 05:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbhKFFeh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 01:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbhKFFeg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 01:34:36 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91BDC061570
        for <git@vger.kernel.org>; Fri,  5 Nov 2021 22:31:55 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id j21so40050135edt.11
        for <git@vger.kernel.org>; Fri, 05 Nov 2021 22:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=LddS7sMXIc24cSC32H7OU79qsInBS9RL7eX8g911UGE=;
        b=BJTZOWoC/SsGnZEzbIsqG6oZdPDJicXnd6afEvGVIKZGBAmaeLlva/dzm/JfGItJqh
         nj50nTVTGiqLxkrYSNL3RXCbFxCIqVFIjPqEMbwReF88l0j3zLcldSQf3g3Gjun7tsYN
         m/+IzQTXNJ6PplnUWx5VaMZY8vviLdvUgqUQDJNPda7pRTMFq48+Ki5Wg/zudh17HpJa
         RL05Q04JFuzAXxyV3s65QtUTcivR/cIrHvcejsRgQwFGwofMGyRfMoVasyq2uvuHtXKq
         vINT4qvElEmeoa3AdMcJPGm/zbzaQkuuMiYvoogsGSyhxlTtPd0B2VACDJxWX1IpQsfZ
         07qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=LddS7sMXIc24cSC32H7OU79qsInBS9RL7eX8g911UGE=;
        b=1jIyY63Lo/LyI3uxXUifiVNQMMaDAcD+loBug4O8moxpuc61LjioxXg7q2WUOhaUvQ
         NwKfV+uJ//217tNicjlDVccG6Ygtg4YQErzh4eAK72N6Pu8aqInTqpbqG02GooZdRARq
         eg1/2JbEVR8aB84UFvxDRwN6x4SYBGzoVPkw2+tz9Z41LKkdWwwCSKra5d/bJF5PAI5c
         pNwcDW81ey9pdsiDzdS1aRBfsbcgSKQAvRPhySOwwjHmArNI5IkplSyNHeNiJsq7WCeI
         HP3Jpm9sXD4yUpm8l7RaZTOzZTy0OFDcFIOsSJBKSKq3N8wha+ZGOENEm+2xVfyDtekT
         ym5w==
X-Gm-Message-State: AOAM532ehMsWqwog60QDAybIF8fJwne1jGxJ8IVf4oHixNWzZs1PAhBn
        X8RiiYrxZFhjiK8PxLWhXChqwK6G0FiDVA==
X-Google-Smtp-Source: ABdhPJxhzsdWLR1Xep9Y1gQHh8J80ioJmL4whfr7BPN/1008autI9POn4H3bGyYGJM5uw693gazfWA==
X-Received: by 2002:a17:906:dc90:: with SMTP id cs16mr53294823ejc.432.1636176713801;
        Fri, 05 Nov 2021 22:31:53 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i4sm5369026edt.29.2021.11.05.22.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 22:31:53 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mjEIy-000b38-Up;
        Sat, 06 Nov 2021 06:31:52 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Robin Jarry <robin.jarry@6wind.com>
Cc:     git@vger.kernel.org, Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Jan Smets <jan.smets@nokia.com>,
        Stephen Morton <stephen.morton@nokia.com>,
        Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] receive-pack: run post-receive before reporting status
Date:   Sat, 06 Nov 2021 06:03:22 +0100
References: <20211104133546.1967308-1-robin.jarry@6wind.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <20211104133546.1967308-1-robin.jarry@6wind.com>
Message-ID: <211106.86y261g88n.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 04 2021, Robin Jarry wrote:

> When a remote client exits while the pre-receive hook is running,
> receive-pack is not killed by SIGPIPE because the signal is ignored.
> This is a side effect of commit ec7dbd145bd8 ("receive-pack: allow hooks
> to ignore its standard input stream").

FWIW we include the date when mentioning commits. E.g. ec7dbd145bd
(receive-pack: allow hooks to ignore its standard input stream,
2014-09-12).

> The pre-receive hook is not interrupted and does not receive any error
> since its stdout is a pipe which is read in an async thread and output
> back to the client socket in a side band channel. When writing the data
> in the socket, the async thread gets a SIGPIPE which also seems ignored.
> This may be a race between the main and the async threads. I do not know
> the code well enough to be sure.
>
> After the pre-receive has exited the SIGPIPE default handler is restored
> and if the hook did not report any error, objects are migrated from
> temporary to permanent storage.
>
> Before running the post-receive hook, status info is reported back to
> the client. Since the client has died, receive-pack is killed by SIGPIPE
> and post-receive is never executed.
>
> The post-receive hook is often used to send email notifications (see
> contrib/hooks/post-receive-email), update bug trackers, start automatic
> builds, etc. Not executing it after an interrupted yet "successful" push
> can lead to inconsistencies.
>
> Execute the post-receive hook before reporting status to the client to
> avoid this issue. This is not an ideal solution but I don't know if
> allowing hooks to be killed when a client exits is a good idea. Maybe
> for pre-receive but definitely not for post-receive.
>
> Signed-off-by: Robin Jarry <robin.jarry@6wind.com>
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> ---
>  builtin/receive-pack.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 49b846d96052..df8bedf71319 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -2564,14 +2564,14 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
>  		use_keepalive = KEEPALIVE_ALWAYS;
>  		execute_commands(commands, unpack_status, &si,
>  				 &push_options);
> +		run_receive_hook(commands, "post-receive", 1,
> +				 &push_options);
>  		if (pack_lockfile)
>  			unlink_or_warn(pack_lockfile);
>  		if (report_status_v2)
>  			report_v2(commands, unpack_status);
>  		else if (report_status)
>  			report(commands, unpack_status);
> -		run_receive_hook(commands, "post-receive", 1,
> -				 &push_options);
>  		run_update_post_hook(commands);
>  		string_list_clear(&push_options, 0);
>  		if (auto_gc) {

I think the discussion at [1] is current to everything you're seeing
here.

tl;dr: Even with this change you're not guaranteed to run your hook.

Personally I've implemented something (independent of) what Junio
suggested downthread[2] of that. I.e. to simply insert a DB record on
pre-receive/post-receive, and have all "real" work done async by a job
that's following that.

I used MySQL as a dumb queue, but this can also be done with a text
file. I'd end up with 3x records:

 A. pre-receive: what the client wants to push
 B. pre-receive (at the very end): what we accepted the client pushing (after running all checks)
 C. post-receive: logging the same rev range, hopefully

As you've found you won't always get a "C", so such a following job
currently needs to repair such records after the fact, i.e. be ready to
inspect the repo and see if the push actually happened. You also won't
get "C" if you OK'd a push, but had a race for the *.lock file, or other
similar push contention.

I think one objection some might have to this is that we'd like to not
wait for the post-receive hook, which I falsely recalled would be
impacted by this, but as Jeff King points out at [3] we'd do the same
either way, so this change won't impact that either way.

But I think one thing that will be negatively impacted is touched upon
by your:

    "Since the client has died[...]Not executing it after an interrupted
    yet "successful" push can lead to inconsistencies".

You don't know if it died, you just got killed by SIGPIPE. That can
happen for any number of reasons, the client might have gotten its data,
you just can't reach it anymore.

I think you're right that it's inconsistent, but wrong about this
"fixing" the inconsistency. I.e. the inconsistency is just being moved
from the server-side to the client-side.

I'd think that in this case we'd very much want to give the client the
benefit of the doubt, because the server can more easily work around
issues with its hook workflow.

But a client inherently can't work around not getting an "OK & flush"
while waiting for the hook to execute, and in the meantime the cat
unplugged the WiFi, so we won't be getting the "OK" at all.

I.e. if put a "sleep 30" in a post-receive hook, push, and in the middle
of that sleep have the client disconnect from the network the push will
have gone through.

But aren't we changing what gets shown to the client from being a
successful push to a non-successful one, since they never got the
report() (and therefore flush) they were expecting? *Goes and tests*

Yes, e.g. with this:

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 49b846d9605..fc273e7dc4d 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2567,9 +2567,9 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
                if (pack_lockfile)
                        unlink_or_warn(pack_lockfile);
                if (report_status_v2)
-                       report_v2(commands, unpack_status);
+                       exit(0);
                else if (report_status)
-                       report(commands, unpack_status);
+                       exit(0);
                run_receive_hook(commands, "post-receive", 1,
                                 &push_options);
                run_update_post_hook(commands);

I've made an attempt to emulate that, and running that we'll get various
test suite failures with e.g.:
    
    + git push dest HEAD
    Enumerating objects: 4, done.
    Counting objects: 100% (4/4), done.
    Delta compression using up to 8 threads
    Compressing objects: 100% (3/3), done.
    Writing objects: 100% (4/4), 1.25 KiB | 1.25 MiB/s, done.
    Total 4 (delta 0), reused 0 (delta 0), pack-reused 0
    send-pack: unexpected disconnect while reading sideband packet
    fatal: the remote end hung up unexpectedly
    error: last command exited with $?=128

Which is a race we'll definitely see now, but would increase in
frequency if we wait longer in sending the OK.

But as noted in [1] there's a way forward to having our cake & eating it
too. I.e. when we into that on the server-side we can try a little
harder not to die, and run post-receive anyway, and in either case it
would be nice if we'd run it after disconnecting from the client, so it
doesn't have to wait for it.

1. https://lore.kernel.org/git/5795EB1C.1080102@nokia.com/
2. https://lore.kernel.org/git/xmqqlh0d8w6v.fsf@gitster.mtv.corp.google.com/
3. https://lore.kernel.org/git/20160803193018.ydhmxntikhyowmjz@sigill.intra.peff.net/
