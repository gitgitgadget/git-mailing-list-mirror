Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCD4C433FE
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 19:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238368AbiBGTba (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 14:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239239AbiBGT0s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 14:26:48 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0AFC0401DA
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 11:26:46 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id h6so7946716wrb.9
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 11:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=mime-version:content-transfer-encoding:date:message-id:subject:from
         :to:cc:references:in-reply-to;
        bh=UgfsaAFGI1RDm8k/WjGTB7IQIXOKl/Cncng+iMYNHQA=;
        b=bIynEOFGdWQI4VHzfHlAm6rI4e6SIcpCVWcMe9AxcGr31eU5FNMPoWwmnNixlN93db
         KXGURIltbmBsASJmX59BH7RSdhnHewOQxnuusNLm0ezaemp+UHimDWM0aTw6ktMoxzy/
         eVCMaCtVqu+fCI30GpFzAAVqz7mPQ7FkEqRpDuc9eKriDZEoK/u8jFNkIiLKbX6IYOL7
         2jZJKcscYMgUOY6fZQYhsWOmTneB4i+YMXBtTFmcR0q8XJOmR0AOZHGhqYLZjV5Q4SVI
         pkvcNVqM3C0CynkstOUpTlOlpMGy318WYw3qLpWagRjmirziyE+2f/R1+O/lE83Jv3Pr
         myrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:subject:from:to:cc:references:in-reply-to;
        bh=UgfsaAFGI1RDm8k/WjGTB7IQIXOKl/Cncng+iMYNHQA=;
        b=S6GankNYeiDBAsgIRQVQFQxIdOQndc6XbWKua0ZsqYpzJ7ghPVS8oxTvkrZxHo2Vaw
         Z+qMeQ99sfDQ8qsSlM3y3qmTr3oMPqDsvVLwR9Q48jcMLBjCYyyW8km2mdh3A3ntvLpT
         vg01dHr5Ia+zzxJsQYngQgCq/zo2b/FcY6Mm9tcdXMv3egq4fOuKGer59zw2pz7pEp5X
         iJ6GHkD1rW6QKt0k5WX/TUSe56pSbHqWrb1pe8GBgZgBTWhsL27DUW9k4b8/8HQ9BSBz
         BkDPGWN6X5zADZ+HphZxhC2h3uwlFZXS3HQ6IHfKsdRj+8MRkpgWLe9VevPXHUbAxl+J
         khLg==
X-Gm-Message-State: AOAM530a+pMxcke3UlotCCY6pwxzv95u70rK6S4ksXRv63qpROl0Xxo0
        KEGgLuQ2qBvdBRlIHZMZswMrgg==
X-Google-Smtp-Source: ABdhPJxLl388/An2+OaU+gnVRlDR6/ADjom3MV0y1Ps4EJzwpaEYSoZKSKPW7DZ5iIjFWsLiPxQjqQ==
X-Received: by 2002:adf:ea8f:: with SMTP id s15mr701558wrm.547.1644262004979;
        Mon, 07 Feb 2022 11:26:44 -0800 (PST)
Received: from localhost (2a01cb000f483e00814f27a5cf098ce2.ipv6.abo.wanadoo.fr. [2a01:cb00:f48:3e00:814f:27a5:cf09:8ce2])
        by smtp.gmail.com with ESMTPSA id x5sm655797wrv.63.2022.02.07.11.26.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 11:26:44 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 07 Feb 2022 20:26:43 +0100
Message-Id: <CHQ28GCKBVQQ.1EGKW3Y5N4IMM@ringo>
Subject: Re: [PATCH v4] receive-pack: check if client is alive before
 completing the push
From:   "Robin Jarry" <robin.jarry@6wind.com>
To:     =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Cc:     "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>,
        "Emily Shaffer" <emilyshaffer@google.com>,
        "Nicolas Dichtel" <nicolas.dichtel@6wind.com>,
        "Patryk Obara" <patryk.obara@gmail.com>,
        "Jiang Xin" <zhiyou.jx@alibaba-inc.com>
X-Mailer: aerc/0.7.1-46-g744be002ad57-dirty
References: <20220127215553.1386024-1-robin.jarry@6wind.com>
 <20220128194811.3396281-1-robin.jarry@6wind.com>
 <220204.864k5e4yvf.gmgdl@evledraar.gmail.com>
In-Reply-To: <220204.864k5e4yvf.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi =C3=86var,

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason, Feb 04, 2022 at 12:37:
> I've read the upthread, but I still don't quite get why it's a must to
> unconditionally abort the push because the pusher went away.
>
> At this point we've passed the pre-receive hook, are about to migrate
> the objects, still have proc-receive left to run, and finally will
> update the refs.
>
> Is the motivation purely a UX change where it's considered that the user
> *must* be shown the output, or are we doing the wrong thing and not
> continuing at all if we run into SIGPIPE here (then presumably only for
> hooks that produce output?).
>
> I admit this is somewhat contrived, but aren't we now doing worse for
> users where the pre-receive hook takes 10s, but they already asked for
> their push to be performed. Then they disconnect from WiFi unexpectedly,
> and find that that it didn't go through?

This *is* purely motivated by UX.

pre-receive hooks may that perform various verifications. They may
require connecting to a bug tracker to validate that the referenced
tickets are in the proper state and associated with the proper git
repository. They may also run patch validation scripts such as
[checkpatch.pl][1].

[1]: https://www.kernel.org/doc/html/latest/dev-tools/checkpatch.html

When pushing large series of commits, these checks can take
a significant amount of time. While the checks are running, some users
may change their mind and hit ctrl-c because they forgot something.

On their point of view, the operation seems to have been aborted.
Whereas if the pre-receive hook completes without errors, the push will
be completed. This may be confusing to some.

> Anyway, I see you made this opt-in configurable in earlier iterations. I
> wonder if that's still something worth doing, or if we should just take
> this change as-is.

The earlier iterations were a lot more complex and actually messed with
SIGPIPE forwarding to the pre-receive hook itself. This last version is
much simpler so I did not think about adding an option. I could make
this behaviour opt-in, I don't mind.

> What I don't get is *if* we're doing this for the UX reason why are we
> singling out the pre-receive hook in particular, and not covering
> proc-receive? I.e. we'll also produce output the user might see there,
> as you can see with this ad-hoc testing change (showhing changed "git
> push" output when I add to the hook output):
>
> 	diff --git a/t/helper/test-proc-receive.c b/t/helper/test-proc-receive.c
> 	index cc08506cf0b..933f0599497 100644
> 	--- a/t/helper/test-proc-receive.c
> 	+++ b/t/helper/test-proc-receive.c
> 	@@ -188,6 +188,7 @@ int cmd__proc_receive(int argc, const char **argv)
> 	                if (returns.nr)
> 	                        for_each_string_list_item(item, &returns)
> 	                                fprintf(stderr, "proc-receive> %s\n", it=
em->string);
> 	+               fprintf(stderr, "showing a custom message\n");
> 	        }
> 	=20
> 	        if (die_write_report)
>
> 	$ ./t5411-proc-receive-hook.sh --run=3D1-3,5-42 -vixd
> 	[...]
> 	+ diff -u expect actual
> 	--- expect      2022-02-04 11:53:52.006413296 +0000
> 	+++ actual      2022-02-04 11:53:52.006413296 +0000
> 	@@ -3,6 +3,7 @@
> 	 remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic       =
=20
> 	 remote: # proc-receive hook       =20
> 	 remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic       =
=20
> 	+remote: showing a custom message       =20
> 	 remote: # post-receive hook       =20
> 	 remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next       =20
> 	 To <URL/of/upstream.git>
> 	error: last command exited with $?=3D1
>
> Is the unstated reason that we consider the tmp_objdir_migrate() more of
> a a point of no return?

I have almost zero experience with proc-receive. I had understood that
tmp_objdir_migrate() meant that the push operation was "complete" in the
sense that commits, tags, branches had been updated (regardless of
proc-receive status). Maybe I am completely wrong.

> IOW I'm wondering why it doesn't look more like this (the object
> migration could probably be dropped, it should be near-ish instant, but
> proc-receive can take a long time):
>
> 	diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> 	index f8b9a931273..33bbafbc9e2 100644
> 	--- a/builtin/receive-pack.c
> 	+++ b/builtin/receive-pack.c
> 	@@ -1907,6 +1907,26 @@ static void execute_commands_atomic(struct comman=
d *commands,
> 	 	strbuf_release(&err);
> 	 }
> 	=20
> 	+static int pusher_went_away(struct command *commands, const char *msg)
> 	+{
> 	+	struct command *cmd;
> 	+	static const char buf[] =3D "0005\2";
> 	+
> 	+	/*
> 	+	 * Send a keepalive packet on sideband 2 (progress info) to notice
> 	+	 * a client that has disconnected (e.g. killed with ^C) while
> 	+	 * pre-receive was running.
> 	+	 */
> 	+	if (write_in_full(1, buf, sizeof(buf) - 1) < 0) {
> 	+		for (cmd =3D commands; cmd; cmd =3D cmd->next) {
> 	+			if (!cmd->error_string)
> 	+				cmd->error_string =3D msg;
> 	+		}
> 	+		return 1;
> 	+	}
> 	+	return 0;
> 	+}
> 	+
> 	 static void execute_commands(struct command *commands,
> 	 			     const char *unpacker_error,
> 	 			     struct shallow_info *si,
> 	@@ -1971,21 +1991,9 @@ static void execute_commands(struct command *comm=
ands,
> 	 		return;
> 	 	}
> 	=20
> 	-	/*
> 	-	 * Send a keepalive packet on sideband 2 (progress info) to notice
> 	-	 * a client that has disconnected (e.g. killed with ^C) while
> 	-	 * pre-receive was running.
> 	-	 */
> 	-	if (use_sideband) {
> 	-		static const char buf[] =3D "0005\2";
> 	-		if (write_in_full(1, buf, sizeof(buf) - 1) < 0) {
> 	-			for (cmd =3D commands; cmd; cmd =3D cmd->next) {
> 	-				if (!cmd->error_string)
> 	-					cmd->error_string =3D "pusher went away";
> 	-			}
> 	-			return;
> 	-		}
> 	-	}
> 	+	if (use_sideband && pusher_went_away(commands,
> 	+					     "pusher can't be contacted post-pre-receive"))
> 	+		return;
> 	=20
> 	 	/*
> 	 	 * Now we'll start writing out refs, which means the objects need
> 	@@ -2000,6 +2008,10 @@ static void execute_commands(struct command *comm=
ands,
> 	 	}
> 	 	tmp_objdir =3D NULL;
> 	=20
> 	+	if (use_sideband && pusher_went_away(commands,
> 	+					     "pusher can't be contacted post-object migration"))
> 	+		return;
> 	+
> 	 	check_aliased_updates(commands);
> 	=20
> 	 	free(head_name_to_free);
> 	@@ -2013,6 +2025,10 @@ static void execute_commands(struct command *comm=
ands,
> 	 			    (cmd->run_proc_receive || use_atomic))
> 	 				cmd->error_string =3D "fail to run proc-receive hook";
> 	=20
> 	+	if (use_sideband && pusher_went_away(commands,
> 	+					     "pusher can't be contacted post-proc-receive"))
> 	+		return;
> 	+
> 	 	if (use_atomic)
> 	 		execute_commands_atomic(commands, si);
> 	 	else
>
> But also, this whole thing is "if the pre-receive hook etc. etc.", but
> we do in fact run this when there's no hook at all. See how this
> interacts with run_and_feed_hook() and the "!hook_path" check.
>
> So isn't this unnecessary if there's no such hook, and we should unfold
> the find_hook() etc. from that codepath (or pass up a "I ran the hook"
> state)?

You're right, maybe this keepalive packet should only be sent if there
is a pre-receive hook.

Also, if proc-receive can indeed reject the push operation, there should
be multiple "checkpoints" as you said.

To sum up, I can send a v5 with multiple "checkpoints" and only via an
opt-in config option. Would that be OK?

Cheers
