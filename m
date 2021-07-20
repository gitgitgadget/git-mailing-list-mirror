Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1892C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 20:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C56A861004
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 20:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhGTUCu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 16:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237295AbhGTTs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 15:48:56 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7CBC061762
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 13:29:34 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id l1so29987678edr.11
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 13:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=fR5XAESD0T4Sb4aC+A2hy7Eo09I0pKFuNWmmJDsFlNc=;
        b=aR0Nd83lee2eFQenZD/xRgBRFZwiLnlBbYrcRacb+nGyimt5iProl4BX+NcH9V11/o
         9KJ6nR71djMQTcZJEfFOjae1PZKmARSDiLqyB3YjD4ebfHBpw+jVG4hgk5ZNKIsVqV2P
         4OaubFaRd/Un0+O9QLC/f/RAtn89dHdhkIw7I9OHbXd01LiojfyZny0UnhoiorC3yny+
         FE2TRfn7YpqtOkPrz5wbSo5Eh2yef7sAmY3a670SjnYCSbdbrdAtn87z+Rt4qSpGJ5ai
         6M6pRHN/ugbBcaV79RWpmGh5f6zEMOyYAURF83bODUxkGFz/t1ieEOsrRUXP1rsY8tDJ
         95Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=fR5XAESD0T4Sb4aC+A2hy7Eo09I0pKFuNWmmJDsFlNc=;
        b=KHAmF8pJrdjm2YdBXjqPAuLC7Q1zxo3/GjTL2T9kgCUSXyRLpdb3XUJ4ybevnxEXV7
         ZmuTcY2F2aEFq+A0ujL3BCqgsuBeMmMyWhTyZhc8ijW2A8k5x0047Xp9JqF9+oGFNXDd
         a1DyX1fcwZhnFCUgUecY51MYFHSOIKjVLsq0s3lHWSHjJxGt5KqImHQgdosLeRohe18Z
         dKIGsWT5WNM7RQ/Yw9wxirKRiohXjoM+T9WZi/ly5YAlG3XWOHX5qFOq0n5X8Xm9tD5K
         GI3C5Gd2g6T5k68xCuoZy+Tip9aPPTRDWefqzqXrcN9wEHkPRBZHFcbm3NivtTv5iruc
         Zk+A==
X-Gm-Message-State: AOAM530A4W70SpaIpTiMPYaO2js2l21dcbhUftgn6l+dBtIVoNYI6gFk
        EzZx3OFJScGBbEgqtfwBCUA=
X-Google-Smtp-Source: ABdhPJz8Rhk3pouoZh1Ji7ZgebD2wQoE//6gekABB86L2HCnSdTDDeaEJZ0ioaJgnoJM/RxvDDh9VQ==
X-Received: by 2002:aa7:c808:: with SMTP id a8mr43922891edt.245.1626812972392;
        Tue, 20 Jul 2021 13:29:32 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id f22sm9654927edr.16.2021.07.20.13.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 13:29:31 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 14/34] fsmonitor--daemon: implement 'start' command
Date:   Tue, 20 Jul 2021 21:38:33 +0200
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <9fe902aad87f1192705fb69ea212a2d066d0286d.1625150864.git.gitgitgadget@gmail.com>
 <87a6n5d600.fsf@evledraar.gmail.com>
 <80fb703d-0f88-110e-5a5c-e8e9a90bbc17@jeffhostetler.com>
 <87sg0i2iid.fsf@evledraar.gmail.com>
 <55e15a7a-b15e-78bd-b3c3-4adff3363edd@jeffhostetler.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <55e15a7a-b15e-78bd-b3c3-4adff3363edd@jeffhostetler.com>
Message-ID: <87tukovidd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 13 2021, Jeff Hostetler wrote:

> On 7/13/21 1:54 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Tue, Jul 13 2021, Jeff Hostetler wrote:
>>=20
>>> My response here is in addition to Dscho's remarks on this topic.
>>> He makes excellent points that I'll just #include here.  I do want
>>> to add my own $0.02 here.
>>>
>>> On 7/1/21 6:18 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>> On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:
>>>>
>
>>>>> +/*
>>>>> + * This is adapted from `wait_or_whine()`.  Watch the child process =
and
>>>>> + * let it get started and begin listening for requests on the socket
>>>>> + * before reporting our success.
>>>>> + */
>>>>> +static int wait_for_background_startup(pid_t pid_child)
>>>>> +{
>>>>> +	int status;
>>>>> +	pid_t pid_seen;
>>>>> +	enum ipc_active_state s;
>>>>> +	time_t time_limit, now;
>>>>> +
>>>>> +	time(&time_limit);
>>>>> +	time_limit +=3D fsmonitor__start_timeout_sec;
>>>>> +
>>>>> +	for (;;) {
>>>>> +		pid_seen =3D waitpid(pid_child, &status, WNOHANG);
>>>>> +
>>>>> +		if (pid_seen =3D=3D -1)
>>>>> +			return error_errno(_("waitpid failed"));
>>>>> +		else if (pid_seen =3D=3D 0) {
>>>>> +			/*
>>>>> +			 * The child is still running (this should be
>>>>> +			 * the normal case).  Try to connect to it on
>>>>> +			 * the socket and see if it is ready for
>>>>> +			 * business.
>>>>> +			 *
>>>>> +			 * If there is another daemon already running,
>>>>> +			 * our child will fail to start (possibly
>>>>> +			 * after a timeout on the lock), but we don't
>>>>> +			 * care (who responds) if the socket is live.
>>>>> +			 */
>>>>> +			s =3D fsmonitor_ipc__get_state();
>>>>> +			if (s =3D=3D IPC_STATE__LISTENING)
>>>>> +				return 0;
>>>>> +
>>>>> +			time(&now);
>>>>> +			if (now > time_limit)
>>>>> +				return error(_("fsmonitor--daemon not online yet"));
>>>>> +		} else if (pid_seen =3D=3D pid_child) {
>>>>> +			/*
>>>>> +			 * The new child daemon process shutdown while
>>>>> +			 * it was starting up, so it is not listening
>>>>> +			 * on the socket.
>>>>> +			 *
>>>>> +			 * Try to ping the socket in the odd chance
>>>>> +			 * that another daemon started (or was already
>>>>> +			 * running) while our child was starting.
>>>>> +			 *
>>>>> +			 * Again, we don't care who services the socket.
>>>>> +			 */
>>>>> +			s =3D fsmonitor_ipc__get_state();
>>>>> +			if (s =3D=3D IPC_STATE__LISTENING)
>>>>> +				return 0;
>>>>> +
>>>>> +			/*
>>>>> +			 * We don't care about the WEXITSTATUS() nor
>>>>> +			 * any of the WIF*(status) values because
>>>>> +			 * `cmd_fsmonitor__daemon()` does the `!!result`
>>>>> +			 * trick on all function return values.
>>>>> +			 *
>>>>> +			 * So it is sufficient to just report the
>>>>> +			 * early shutdown as an error.
>>>>> +			 */
>>>>> +			return error(_("fsmonitor--daemon failed to start"));
>>>>> +		} else
>>>>> +			return error(_("waitpid is confused"));
>>>>> +	}
>>>>> +}
>>>> Ditto this. could we extend the wait_or_whine() function (or some
>>>> extended version thereof) to do what you need with callbacks?
>>>> It seems the main difference is just being able to pass down a flag
>>>> for
>>>> waitpid(), and the loop needing to check EINTR or not depending on
>>>> whether WNOHANG is passed.
>>>> For e.g. the "We don't care about the WEXITSTATUS()" you'd get that
>>>> behavior with an adjusted wait_or_whine(). Wouldn't it be better to
>>>> report what exit status it exits with e.g. if the top-level process is
>>>> signalled? We do so in trace2 for other things we spawn...
>>>>
>>>
>>> Again, I don't want to mix my usage here with the existing code
>>> and destabilize all existing callers.  Here we are spinning to give
>>> the child a chance to *start* and confirm that it is in a listening
>>> state and ready for connections.  We do not wait for the child to
>>> exit (unless it dies quickly without becoming ready).
>>>
>>> We want to end our wait as soon as we confirm that the child is
>>> ready and return.  All I really need from the system is `waitpid()`.
>> Will this code behave correctly if the daemon we start is signalled
>> per
>> the WIFSIGNALED() cases the code this is derived handles, but this does
>> not?
>
> We're only waiting until the child gets started and is able to receive
> requests -- what happens to it after we have confirmed that it is ready
> is not our concern (after all, the parent is about to exit anyway and
> the child is going to continue on).
>
> If waitpid() gives us a WIFSIGNALED (or any other WIF*() state) before
> we have spoken to it, we will return a "failed to start".

So in wait_or_whine() and finish_command() we capture all of that in
trace2 logs, we explicitly don't want that in this case? We do concern
ourselves with the exact exit status/signal status etc. of children we
start in most other scenarios for trace2 logging purposes.

> But again, that signal would have to arrive immediately after we spawned
> it and *before* we could talk to it.  If the child is signaled after we
> confirmed it was ready, we don't care because the parent process will be
> gone.
>
> (If the child is signaled or is killed (or crashes or whatever), the
> next Git command (like "status") that tries to talk to it will re-start
> it implicitly -- the `git fsmonitor--daemon start` command here is an
> explicit start.)
>
>
>> But sure, I just meant to point out that the flip side to
>> "destabilize
>> all existing callers" is reviewing new code that may be subtly buggy,
>> and those subtle bugs (if any) would be smoked out if we were forced to
>> extend run-command.c, i.e. to use whatever feature(s) this needs for all
>> existing callers.
>>=20
>
> That would/could have a massive footprint.  And I've already established
> that my usage here is sufficiently different from existing uses that the
> result would be a mess. IMHO.

I hadn't see this before but it seems pretty much exactly the same code
was already added (by you) in 36a7eb68760 (t0052: add simple-ipc tests
and t/helper/test-simple-ipc tool, 2021-03-22), perhaps splitting it
into a utility function for the two to use with a callback mechanism
would reduce the footprint?

What I was suggesting was some continuation of the below.

(I stopped once I noticed the changes I was making to
builtin/fsmonitor--daemon.c didn't even compile (almost the entire file
is hidden behind a macro), but I've commented on that aspect
elsewhere. I.e. it's nice to be able to do tree-wide refactoring without
tripping over code hidden by ifdefs)

It passes all current tests for whatever that's worth, obviously not a
pretty API, and I'm not claiming it's correct.

But I think it's clear how the trace2/error handling part of it could be
further extracted into some utility, so this would just be a mode of
run-command.

Not saying you need to do it, but the comments about us explicitly not
caring at all about the exit state make me wonder if there's some reason
for why someone else would be tripping over some landmine if they did
that refactoring.

Anyway, just a thought. I see from other feedback that you seem to be
getting pretty exasperated with me.

I'm just trying to help this along, usually being able to piggy-back on
existing in-tree code and proving the correctness by passing all in-tree
tests with that piggy-backing helps more than hinders.

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 25f18f2726b..7365fff95f4 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -8,6 +8,7 @@
 #include "simple-ipc.h"
 #include "khash.h"
 #include "pkt-line.h"
+#include "run-command.h"
=20
 static const char * const builtin_fsmonitor__daemon_usage[] =3D {
 	N_("git fsmonitor--daemon start [<options>]"),
@@ -1403,11 +1404,12 @@ static int wait_for_background_startup(pid_t pid_ch=
ild)
 	time_limit +=3D fsmonitor__start_timeout_sec;
=20
 	for (;;) {
+		int saved_errno =3D 0;
+		code =3D wait_or_whine_extended(pid_child, &pid_seen, "TODO",
+					      0, WNOHANG, &saved_errno);
 		pid_seen =3D waitpid(pid_child, &status, WNOHANG);
=20
-		if (pid_seen =3D=3D -1)
-			return error_errno(_("waitpid failed"));
-		else if (pid_seen =3D=3D 0) {
+		if (pid_seen =3D=3D 0) {
 			/*
 			 * The child is still running (this should be
 			 * the normal case).  Try to connect to it on
@@ -1452,8 +1454,7 @@ static int wait_for_background_startup(pid_t pid_chil=
d)
 			 * early shutdown as an error.
 			 */
 			return error(_("fsmonitor--daemon failed to start"));
-		} else
-			return error(_("waitpid is confused"));
+		}
 	}
 }
=20
diff --git a/run-command.c b/run-command.c
index aacc336f951..856e7d87c40 100644
--- a/run-command.c
+++ b/run-command.c
@@ -543,24 +543,28 @@ static inline void set_cloexec(int fd)
 		fcntl(fd, F_SETFD, flags | FD_CLOEXEC);
 }
=20
-static int wait_or_whine(pid_t pid, const char *argv0, int in_signal)
+int wait_or_whine_extended(pid_t pid, pid_t *waiting, const char *argv0,
+			   int in_signal, int waitpid_options, int *failed_errno)
 {
 	int status, code =3D -1;
-	pid_t waiting;
-	int failed_errno =3D 0;
=20
-	while ((waiting =3D waitpid(pid, &status, 0)) < 0 && errno =3D=3D EINTR)
+	if (waitpid_options & WNOHANG)
+		*waiting =3D waitpid(pid, &status, waitpid_options);
+	else
+		while ((*waiting =3D waitpid(pid, &status, waitpid_options)) < 0 &&
+		       errno =3D=3D EINTR)
 		;	/* nothing */
+
 	if (in_signal) {
 		if (WIFEXITED(status))
 			code =3D WEXITSTATUS(status);
 		return code;
 	}
=20
-	if (waiting < 0) {
-		failed_errno =3D errno;
+	if (*waiting < 0) {
+		*failed_errno =3D errno;
 		error_errno("waitpid for %s failed", argv0);
-	} else if (waiting !=3D pid) {
+	} else if (*waiting !=3D pid) {
 		error("waitpid is confused (%s)", argv0);
 	} else if (WIFSIGNALED(status)) {
 		code =3D WTERMSIG(status);
@@ -574,14 +578,23 @@ static int wait_or_whine(pid_t pid, const char *argv0=
, int in_signal)
 		code +=3D 128;
 	} else if (WIFEXITED(status)) {
 		code =3D WEXITSTATUS(status);
+	} else if (waitpid_options & WNOHANG && *waiting =3D=3D 0) {
+		code =3D 0;
 	} else {
 		error("waitpid is confused (%s)", argv0);
 	}
=20
-	clear_child_for_cleanup(pid);
+	return code;
+}
=20
+static int wait_or_whine(pid_t pid, const char *argv0, int in_signal)
+{
+	pid_t ignore;
+	int failed_errno =3D 0;
+	int ret =3D wait_or_whine_extended(pid, &ignore, argv0, in_signal, 0, &fa=
iled_errno);
+	clear_child_for_cleanup(pid);
 	errno =3D failed_errno;
-	return code;
+	return ret;
 }
=20
 static void trace_add_env(struct strbuf *dst, const char *const *deltaenv)
diff --git a/run-command.h b/run-command.h
index e321d23bbd2..fe39730f87a 100644
--- a/run-command.h
+++ b/run-command.h
@@ -182,6 +182,9 @@ void child_process_clear(struct child_process *);
=20
 int is_executable(const char *name);
=20
+int wait_or_whine_extended(pid_t pid, pid_t *waiting, const char *argv0,
+			   int in_signal, int waitpid_options, int *failed_errno);
+
 /**
  * Start a sub-process. Takes a pointer to a `struct child_process`
  * that specifies the details and returns pipe FDs (if requested).
diff --git a/t/helper/test-simple-ipc.c b/t/helper/test-simple-ipc.c
index 91345180750..44658a46713 100644
--- a/t/helper/test-simple-ipc.c
+++ b/t/helper/test-simple-ipc.c
@@ -9,6 +9,7 @@
 #include "parse-options.h"
 #include "thread-utils.h"
 #include "strvec.h"
+#include "run-command.h"
=20
 #ifndef SUPPORTS_SIMPLE_IPC
 int cmd__simple_ipc(int argc, const char **argv)
@@ -349,7 +350,7 @@ static int spawn_server(pid_t *pid)
  */
 static int wait_for_server_startup(pid_t pid_child)
 {
-	int status;
+	int code;
 	pid_t pid_seen;
 	enum ipc_active_state s;
 	time_t time_limit, now;
@@ -358,12 +359,10 @@ static int wait_for_server_startup(pid_t pid_child)
 	time_limit +=3D cl_args.max_wait_sec;
=20
 	for (;;) {
-		pid_seen =3D waitpid(pid_child, &status, WNOHANG);
-
-		if (pid_seen =3D=3D -1)
-			return error_errno(_("waitpid failed"));
-
-		else if (pid_seen =3D=3D 0) {
+		int saved_errno =3D 0;
+		code =3D wait_or_whine_extended(pid_child, &pid_seen, "TODO",
+					      0, WNOHANG, &saved_errno);
+		if (pid_seen =3D=3D 0) {
 			/*
 			 * The child is still running (this should be
 			 * the normal case).  Try to connect to it on
@@ -384,9 +383,7 @@ static int wait_for_server_startup(pid_t pid_child)
 				return error(_("daemon not online yet"));
=20
 			continue;
-		}
-
-		else if (pid_seen =3D=3D pid_child) {
+		} else if (pid_seen =3D=3D pid_child) {
 			/*
 			 * The new child daemon process shutdown while
 			 * it was starting up, so it is not listening
@@ -412,10 +409,9 @@ static int wait_for_server_startup(pid_t pid_child)
 			 * early shutdown as an error.
 			 */
 			return error(_("daemon failed to start"));
+		} else if (code) {
+			BUG("??");
 		}
-
-		else
-			return error(_("waitpid is confused"));
 	}
 }
=20

