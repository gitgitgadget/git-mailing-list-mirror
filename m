Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF46C433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 12:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356841AbiBDMJa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 07:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358537AbiBDMJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 07:09:28 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1299C061714
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 04:09:27 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id o12so18717273eju.13
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 04:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=BpTHi4Sqn1qxc+JzagIpXLf3e07AnwfRSs7FI3ZZIrI=;
        b=eRwEA6V7DxgilXFrfF1ldYbLndfNKDdM+9wF707UAEbs2mpcvLRcsHGONdsf1LPV9z
         uJoGvkNuONgEdUUykw3iBnhDFZlEfynSU96AZlsasu9nsUM3pf6bHKXvoZaGBN4xHA5F
         EQPTFVRqSe9J9HM3onn+F890SzNMcMsrWJ0PxORgefT/reSyDztL2HNc7pUS/kmYHCll
         yfu55o5dEwSHm7UZ/Ji9r12cM5PrT1MiTiVXimHLsPXuMJ1KZ7bifavBNOCnoZRHjcQ7
         aetJ3c6iksfJrhPWP+z6Mj+KYvHS6RK8pn4sN82lZcaT1oUIoSWXwm7CTdhpTwneoTe7
         VgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=BpTHi4Sqn1qxc+JzagIpXLf3e07AnwfRSs7FI3ZZIrI=;
        b=hNbgKcKSPvxvgVe9FPAuE9k110MdP6lSbGrm3SgXbxqFbfVg5JzJlmdREH2M1IB6bU
         P+5v7m/aU7I4P4Xy0bRZxHLTncao0rKvvYYhQyTg3eB1ZJ1jCVzc6rAMwRPhZuNBCIgJ
         /+iMzwAU3x5cRDzUFE5GVvagzBFPPBm6GuxhWwC4PChEjIQUc9MYTE5hQv9uzA7BBmIW
         +EZABsZTY7RmZcv8iELxiMXRc9OZYCFMr1IhzEI7jrOnrhjNEB7eBQoih67exdO7YML/
         QmlITL+1pP5cKidXuY7fXun+PlZtk/EDhlxNa99p58yAPTlkTIg2ZGNAxRcDLPtQNerZ
         HoGg==
X-Gm-Message-State: AOAM5309plYVDaLeb09KCioRujgfSgNkeUU/9CNcJ+EHjgKE9K9DRMTF
        1pOh+g6BGWLuuqCz76D39lI=
X-Google-Smtp-Source: ABdhPJyFbD1aqJY+8yqhD0yINHPePmbw0Csfw5WsytwStaLrfAyzc/mWVCHMg618NkwmxYLQLkecYQ==
X-Received: by 2002:a17:907:1c90:: with SMTP id nb16mr2225011ejc.413.1643976566042;
        Fri, 04 Feb 2022 04:09:26 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k7sm589608eje.162.2022.02.04.04.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 04:09:25 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nFxP2-0063UQ-R4;
        Fri, 04 Feb 2022 13:09:24 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Robin Jarry <robin.jarry@6wind.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Patryk Obara <patryk.obara@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v4] receive-pack: check if client is alive before
 completing the push
Date:   Fri, 04 Feb 2022 12:37:23 +0100
References: <20220127215553.1386024-1-robin.jarry@6wind.com>
 <20220128194811.3396281-1-robin.jarry@6wind.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220128194811.3396281-1-robin.jarry@6wind.com>
Message-ID: <220204.864k5e4yvf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 28 2022, Robin Jarry wrote:

> Abort the push operation (i.e. do not migrate the objects from temporary
> to permanent storage) if the client has disconnected while the
> pre-receive hook was running.
>
> This reduces the risk of inconsistencies on network errors or if the
> user hits ctrl-c while the pre-receive hook is running.
>
> Send a keepalive packet (empty) on sideband 2 (the one to report
> progress). If the client has exited the write() operation should fail
> and the push will be aborted. This only works when sideband*
> capabilities are advertised by the client.
>
> Note: if the write() operation fails, receive-pack will likely be killed
> via SIGPIPE and even so, since the client is likely gone already, the
> error strings will go nowhere. I only added them for code consistency.
>
> Signed-off-by: Robin Jarry <robin.jarry@6wind.com>
> ---
> v3 -> v4:
>   - reworded the comment block s/ensure/notice/
>   - used write_in_full() instead of write_or_die()
>   - set error_string fields for code consistency
>
>  builtin/receive-pack.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 9f4a0b816cf9..f8b9a9312733 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1971,6 +1971,22 @@ static void execute_commands(struct command *commands,
>  		return;
>  	}
>  
> +	/*
> +	 * Send a keepalive packet on sideband 2 (progress info) to notice
> +	 * a client that has disconnected (e.g. killed with ^C) while
> +	 * pre-receive was running.
> +	 */
> +	if (use_sideband) {
> +		static const char buf[] = "0005\2";
> +		if (write_in_full(1, buf, sizeof(buf) - 1) < 0) {
> +			for (cmd = commands; cmd; cmd = cmd->next) {
> +				if (!cmd->error_string)
> +					cmd->error_string = "pusher went away";
> +			}
> +			return;
> +		}
> +	}
> +
>  	/*
>  	 * Now we'll start writing out refs, which means the objects need
>  	 * to be in their final positions so that other processes can see them.

I've read the upthread, but I still don't quite get why it's a must to
unconditionally abort the push because the pusher went away.

At this point we've passed the pre-receive hook, are about to migrate
the objects, still have proc-receive left to run, and finally will
update the refs.

Is the motivation purely a UX change where it's considered that the user
*must* be shown the output, or are we doing the wrong thing and not
continuing at all if we run into SIGPIPE here (then presumably only for
hooks that produce output?).

I admit this is somewhat contrived, but aren't we now doing worse for
users where the pre-receive hook takes 10s, but they already asked for
their push to be performed. Then they disconnect from WiFi unexpectedly,
and find that that it didn't go through?

Anyway, I see you made this opt-in configurable in earlier iterations. I
wonder if that's still something worth doing, or if we should just take
this change as-is.

What I don't get is *if* we're doing this for the UX reason why are we
singling out the pre-receive hook in particular, and not covering
proc-receive? I.e. we'll also produce output the user might see there,
as you can see with this ad-hoc testing change (showhing changed "git
push" output when I add to the hook output):

	diff --git a/t/helper/test-proc-receive.c b/t/helper/test-proc-receive.c
	index cc08506cf0b..933f0599497 100644
	--- a/t/helper/test-proc-receive.c
	+++ b/t/helper/test-proc-receive.c
	@@ -188,6 +188,7 @@ int cmd__proc_receive(int argc, const char **argv)
	                if (returns.nr)
	                        for_each_string_list_item(item, &returns)
	                                fprintf(stderr, "proc-receive> %s\n", item->string);
	+               fprintf(stderr, "showing a custom message\n");
	        }
	 
	        if (die_write_report)

	$ ./t5411-proc-receive-hook.sh --run=1-3,5-42 -vixd
	[...]
	+ diff -u expect actual
	--- expect      2022-02-04 11:53:52.006413296 +0000
	+++ actual      2022-02-04 11:53:52.006413296 +0000
	@@ -3,6 +3,7 @@
	 remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        
	 remote: # proc-receive hook        
	 remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic        
	+remote: showing a custom message        
	 remote: # post-receive hook        
	 remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next        
	 To <URL/of/upstream.git>
	error: last command exited with $?=1

Is the unstated reason that we consider the tmp_objdir_migrate() more of
a a point of no return?

IOW I'm wondering why it doesn't look more like this (the object
migration could probably be dropped, it should be near-ish instant, but
proc-receive can take a long time):

	diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
	index f8b9a931273..33bbafbc9e2 100644
	--- a/builtin/receive-pack.c
	+++ b/builtin/receive-pack.c
	@@ -1907,6 +1907,26 @@ static void execute_commands_atomic(struct command *commands,
	 	strbuf_release(&err);
	 }
	 
	+static int pusher_went_away(struct command *commands, const char *msg)
	+{
	+	struct command *cmd;
	+	static const char buf[] = "0005\2";
	+
	+	/*
	+	 * Send a keepalive packet on sideband 2 (progress info) to notice
	+	 * a client that has disconnected (e.g. killed with ^C) while
	+	 * pre-receive was running.
	+	 */
	+	if (write_in_full(1, buf, sizeof(buf) - 1) < 0) {
	+		for (cmd = commands; cmd; cmd = cmd->next) {
	+			if (!cmd->error_string)
	+				cmd->error_string = msg;
	+		}
	+		return 1;
	+	}
	+	return 0;
	+}
	+
	 static void execute_commands(struct command *commands,
	 			     const char *unpacker_error,
	 			     struct shallow_info *si,
	@@ -1971,21 +1991,9 @@ static void execute_commands(struct command *commands,
	 		return;
	 	}
	 
	-	/*
	-	 * Send a keepalive packet on sideband 2 (progress info) to notice
	-	 * a client that has disconnected (e.g. killed with ^C) while
	-	 * pre-receive was running.
	-	 */
	-	if (use_sideband) {
	-		static const char buf[] = "0005\2";
	-		if (write_in_full(1, buf, sizeof(buf) - 1) < 0) {
	-			for (cmd = commands; cmd; cmd = cmd->next) {
	-				if (!cmd->error_string)
	-					cmd->error_string = "pusher went away";
	-			}
	-			return;
	-		}
	-	}
	+	if (use_sideband && pusher_went_away(commands,
	+					     "pusher can't be contacted post-pre-receive"))
	+		return;
	 
	 	/*
	 	 * Now we'll start writing out refs, which means the objects need
	@@ -2000,6 +2008,10 @@ static void execute_commands(struct command *commands,
	 	}
	 	tmp_objdir = NULL;
	 
	+	if (use_sideband && pusher_went_away(commands,
	+					     "pusher can't be contacted post-object migration"))
	+		return;
	+
	 	check_aliased_updates(commands);
	 
	 	free(head_name_to_free);
	@@ -2013,6 +2025,10 @@ static void execute_commands(struct command *commands,
	 			    (cmd->run_proc_receive || use_atomic))
	 				cmd->error_string = "fail to run proc-receive hook";
	 
	+	if (use_sideband && pusher_went_away(commands,
	+					     "pusher can't be contacted post-proc-receive"))
	+		return;
	+
	 	if (use_atomic)
	 		execute_commands_atomic(commands, si);
	 	else

But also, this whole thing is "if the pre-receive hook etc. etc.", but
we do in fact run this when there's no hook at all. See how this
interacts with run_and_feed_hook() and the "!hook_path" check.

So isn't this unnecessary if there's no such hook, and we should unfold
the find_hook() etc. from that codepath (or pass up a "I ran the hook"
state)?
