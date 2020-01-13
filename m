Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623B2C33CA9
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 17:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160032084D
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 17:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXeu7psE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgAMREY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 12:04:24 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53315 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728621AbgAMREX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jan 2020 12:04:23 -0500
Received: by mail-wm1-f68.google.com with SMTP id m24so10547825wmc.3
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 09:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=KWlJ5GimEcRIUgzqB7IDTK7iAnsDzHi1viybNsAuUk4=;
        b=UXeu7psENHVdDy2ANyXucbcdZLwGeNOJjDrS3jM3dRcSY+Av/QxLgEkG701530MAc1
         xxK6RKXSy84YSuIv+BIyE4VSKhjw3KK2x1hzmVNXvyj2fwT6wLZ8HrdRTjBs6tXL1P8F
         REnsTQfZNt5raEYLi/Hi1EGC5TuI9MCJdCd25NQZbcc97ZnvR/k+ClR3NkKKXcNsZiAF
         tXOM6J0KAqppeowL9dv9VNDOajnMMbBMjYIsd5Dz/ZuKBzCvLUx+2asYITa++KA2npTg
         nMmGI+5fSO0Bzku8xPkyISoEAGF9g+z3pIc9zhlpbHguEG7efZh6X71Y46LyZUThi9SV
         pX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KWlJ5GimEcRIUgzqB7IDTK7iAnsDzHi1viybNsAuUk4=;
        b=S42MId3iLgyTX3IfQKHR/7AwO6NGbZ8Czkj4H/giQEnRMpyrDluJhRmG1ba1XAQHfi
         VGRPs4KYWdToQ4NG4UMJn4NMiYjVOwk/eQo7H6Nfd2b3jqcbDKgnH+bNGWzN5y+4f+7J
         EOeds2RlEhrqe/5fgPUf3/RqpJShKrVlCHet/mOZ1zVIAu2t2n/mOrQTC/zUmWk7iY0g
         5x38cTsMgByEoJXJzSdRcxCTSOsvrDAB89xmKD1R0TrlvjG171ITwsX7Svyp9nimBKVZ
         hEXgGYCGbuwvhLqtaEXrsu8aBzY01FzsCNCSRS2Z/mGFWaxMbliuAngPPyuR0yjd1FLP
         idnw==
X-Gm-Message-State: APjAAAUooGO6K0rwT2rcOqpzPxWcJE3XK0HImRavZNw10iVg4LZsRCup
        dKm5hyi6YmD03WHuNZNdv1E=
X-Google-Smtp-Source: APXvYqwFGaIhk+RSfri8BP6fDIkhhwSJHmT7jq3/Q3FaKk52iPVRl8EbCSlgCFxKb+UtKCZNMNco8A==
X-Received: by 2002:a1c:541b:: with SMTP id i27mr22355579wmb.137.1578935060562;
        Mon, 13 Jan 2020 09:04:20 -0800 (PST)
Received: from szeder.dev (x4d0c05b5.dyn.telefonica.de. [77.12.5.181])
        by smtp.gmail.com with ESMTPSA id e16sm15873967wrs.73.2020.01.13.09.04.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jan 2020 09:04:19 -0800 (PST)
Date:   Mon, 13 Jan 2020 18:04:17 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 01/10] built-in add -i/-p: treat SIGPIPE as EOF
Message-ID: <20200113170417.GK32750@szeder.dev>
References: <pull.175.v2.git.1577275020.gitgitgadget@gmail.com>
 <pull.175.v3.git.1578904171.gitgitgadget@gmail.com>
 <5e258a8d2bb271433902b2e44c3a30a988bbf512.1578904171.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e258a8d2bb271433902b2e44c3a30a988bbf512.1578904171.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 13, 2020 at 08:29:22AM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> As noticed by Gábor Szeder, if we want to run `git add -p` with
> redirected input through `test_must_fail` in the test suite, we must
> expect that a SIGPIPE can happen due to `stdin` coming to its end.

I don't think this issue is related to the redirected input: I
modified that flaky test to send "unlimited" data to 'git add's stdin,
i.e.:

  /usr/bin/yes | test_must_fail force_color git add -p

and the test with --stress still failed with SIGPIPE all the same and
just as fast.

After looking into it, the issue seems to be sending data to the
broken diffFilter process.  So in that test the diff is "filtered"
through 'echo too-short', which exits real fast, and doesn't read its
standard input at all (well, apart from e.g. the usual kernel
buffering that might happen on a pipe between the two processes).
Making sure that the diffFilter process reads all the data before
exiting, i.e. changing it to:

  test_config interactive.diffFilter "cat >/dev/null ; echo too-short" &&

made the test reliable, with over 2000 --stress repetitions, and that
with only a single "y" on 'git add's stdin.

Now, merely tweaking the test is clearly insufficient, because we not
only want the test to be realiable, but we want 'git add' to die
gracefully when users out there mess up their configuration.

Ignoring SIGPIPE can surely accomplish that, but I'm not sure about
the scope.  I mean your patch seems to ignore SIGPIPE basically for
almost the whole 'git add -(i|p)' process, but perhaps it should be
limited only to the surroundings of the pipe_command() call running
the diffFilter, and be done as part of the next patch adding the 'if
(diff_filter)' block.

Furthermore, I'm worried that by simply ignoring SIGPIPE we might just
ignore a more fundamental issue in pipe_command(): shouldn't that
function be smart enough not to write() to a fd that has no one on the
other side to read it in the first place?!

So, when the diffFilter process exits unexpectedly early, then the
poll() call in pipe_command() -> pump_io() -> pump_io_round() returns
with success and usually sets 'revents' for the child process' stdin
to 12 (i.e. 'POLLOUT | POLLERR'; gah, how I hate unnamed constants :).
Unfortunately, at that point we don't take any special action on
POLLERR, but call xwrite() to try to write to the dead fd anyway,
which then promptly triggers SIGPIPE.  (This is what usually happens
when stepping through the statements of those functions in a debugger,
and the diffFilter process has all the time in the world to exit.)

We could handle POLLERR with a patch like this:

  --- >8 ---

Subject: run-command: handle POLLERR in pump_io_round() to reduce risk of SIGPIPE

diff --git a/run-command.c b/run-command.c
index 3449db319b..57093f0acc 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1416,25 +1416,31 @@ static int pump_io_round(struct io_pump *slots, int nr, struct pollfd *pfd)
 	if (poll(pfd, pollsize, -1) < 0) {
 		if (errno == EINTR)
 			return 1;
 		die_errno("poll failed");
 	}
 
 	for (i = 0; i < nr; i++) {
 		struct io_pump *io = &slots[i];
 
 		if (io->fd < 0)
 			continue;
 
-		if (!(io->pfd->revents & (POLLOUT|POLLIN|POLLHUP|POLLERR|POLLNVAL)))
+		if (io->pfd->revents & POLLERR) {
+			io->error = ECONNRESET;  /* What should we report to the caller? */
+			close(io->fd);
+			io->fd = -1;
+			continue;
+		}
+		if (!(io->pfd->revents & (POLLOUT|POLLIN|POLLHUP|POLLNVAL)))
 			continue;
 
 		if (io->type == POLLOUT) {
 			ssize_t len = xwrite(io->fd,
 					     io->u.out.buf, io->u.out.len);
 			if (len < 0) {
 				io->error = errno;
 				close(io->fd);
 				io->fd = -1;
 			} else {
 				io->u.out.buf += len;
 				io->u.out.len -= len;

  --- >8 ---

Unfortunately #1, this changes the error 'git add -p' dies with from:

  error: mismatched output from interactive.diffFilter

to:

  error: failed to run 'echo too-short'

It might affect other commands as well, but FWIW the test suite
doesn't catch any.


Unfortunately #2, the above patch doesn't completely eliminates the
SIGPIPE, but only (greatly) reduces its probability.  It is possible
that:

  - poll() returns with success and indicating a writable fd without
    any error, i.e. 'revents = 4'.

  - the bogus diffFilter exits, closing its stdin.

  - 'git add' attempts to xwrite() to the now closed fd, and triggers
    a SIGPIPE right away.

This happens much rarer, 'GIT_TEST_ADD_I_USE_BUILTIN=1
./t3701-add-interactive.sh -r 39,49 --stress-jobs=<4*nr-of-cores>
--stress' tends to take over 200 repetitions.  The patch below
reproduces it fairly reliably by adding two strategically-placed
sleep()s, with a bit of extra debug output:

  --- >8 ---

diff --git a/add-patch.c b/add-patch.c
index d8dafa8168..0fd017bbd3 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -421,6 +421,7 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 			filter_cp.git_cmd = 0;
 			filter_cp.use_shell = 1;
 			strbuf_reset(&s->buf);
+			fprintf(stderr, "about to run diffFilter\n");
 			if (pipe_command(&filter_cp,
 					 colored->buf, colored->len,
 					 &s->buf, colored->len,
diff --git a/run-command.c b/run-command.c
index 57093f0acc..49ae88a922 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1419,6 +1419,7 @@ static int pump_io_round(struct io_pump *slots, int nr, struct pollfd *pfd)
 		die_errno("poll failed");
 	}
 
+	sleep(2);
 	for (i = 0; i < nr; i++) {
 		struct io_pump *io = &slots[i];
 
@@ -1435,8 +1436,11 @@ static int pump_io_round(struct io_pump *slots, int nr, struct pollfd *pfd)
 			continue;
 
 		if (io->type == POLLOUT) {
-			ssize_t len = xwrite(io->fd,
+			ssize_t len;
+			fprintf(stderr, "attempting to xwrite() %lu bytes to a fd with revents flags 0x%hx\n", io->u.out.len, io->pfd->revents);
+			len = xwrite(io->fd,
 					     io->u.out.buf, io->u.out.len);
+			fprintf(stderr, "after xwrite()\n");
 			if (len < 0) {
 				io->error = errno;
 				close(io->fd);
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 12ee321707..acffc9af37 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -561,7 +561,7 @@ test_expect_success 'detect bogus diffFilter output' '
 	git reset --hard &&
 
 	echo content >test &&
-	test_config interactive.diffFilter "echo too-short" &&
+	test_config interactive.diffFilter "sleep 1 ; echo too-short" &&
 	printf y >y &&
 	test_must_fail force_color git add -p <y
 '

  --- >8 ---

and 'GIT_TEST_ADD_I_USE_BUILTIN=1 ./t3701-add-interactive.sh -r 39,49'
fails with:

  + test_must_fail force_color git add -p
  about to run diffFilter
  attempting to xwrite() 224 bytes to a fd with revents flags 0x4
  test_must_fail: died by signal 13: force_color git add -p

I don't understand why we get SIGPIPE right away instead of some error
that we can act upon (ECONNRESET?).  FWIW, it fails the same way not
only on my box, but on Travis CI's Linux and OSX images as well.

  https://travis-ci.org/szeder/git/jobs/636446843#L2937


Cc'ing Peff for all things SIGPIPE :) who also happens to be the
author of both pipe_command() and that now flaky test.


> The appropriate action here is to ignore that signal and treat it as a
> regular end-of-file, otherwise the test will fail. In preparation for
> such a test, introduce precisely this handling of SIGPIPE into the
> built-in version of `git add -p`.
> 
> For good measure, teach the built-in `git add -i` the same trick: it
> _also_ runs a loop waiting for input, and can receive a SIGPIPE just the
> same (and wants to treat it as end-of-file, too).
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  add-interactive.c | 3 +++
>  add-patch.c       | 4 ++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/add-interactive.c b/add-interactive.c
> index a5bb14f2f4..3ff8400ea4 100644
> --- a/add-interactive.c
> +++ b/add-interactive.c
> @@ -9,6 +9,7 @@
>  #include "lockfile.h"
>  #include "dir.h"
>  #include "run-command.h"
> +#include "sigchain.h"
>  
>  static void init_color(struct repository *r, struct add_i_state *s,
>  		       const char *slot_name, char *dst,
> @@ -1097,6 +1098,7 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
>  			->util = util;
>  	}
>  
> +	sigchain_push(SIGPIPE, SIG_IGN);
>  	init_add_i_state(&s, r);
>  
>  	/*
> @@ -1149,6 +1151,7 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
>  	strbuf_release(&print_file_item_data.worktree);
>  	strbuf_release(&header);
>  	prefix_item_list_clear(&commands);
> +	sigchain_pop(SIGPIPE);
>  
>  	return res;
>  }
> diff --git a/add-patch.c b/add-patch.c
> index 46c6c183d5..9a3beed72e 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -6,6 +6,7 @@
>  #include "pathspec.h"
>  #include "color.h"
>  #include "diff.h"
> +#include "sigchain.h"
>  
>  enum prompt_mode_type {
>  	PROMPT_MODE_CHANGE = 0, PROMPT_DELETION, PROMPT_HUNK,
> @@ -1578,6 +1579,7 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
>  	};
>  	size_t i, binary_count = 0;
>  
> +	sigchain_push(SIGPIPE, SIG_IGN);
>  	init_add_i_state(&s.s, r);
>  
>  	if (mode == ADD_P_STASH)
> @@ -1612,6 +1614,7 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
>  	    parse_diff(&s, ps) < 0) {
>  		strbuf_release(&s.plain);
>  		strbuf_release(&s.colored);
> +		sigchain_pop(SIGPIPE);
>  		return -1;
>  	}
>  
> @@ -1630,5 +1633,6 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
>  	strbuf_release(&s.buf);
>  	strbuf_release(&s.plain);
>  	strbuf_release(&s.colored);
> +	sigchain_pop(SIGPIPE);
>  	return 0;
>  }
> -- 
> gitgitgadget
> 
