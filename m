Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B9EC2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 21:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CEA961075
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 21:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbhFNVpC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 17:45:02 -0400
Received: from mout.gmx.net ([212.227.17.22]:38075 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229499AbhFNVpC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 17:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623706973;
        bh=GdxNeq7uDFUmKMXzOLjksYzRXAnW5FzhM4Fy1NgN4iM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BOApkXMmVAyBfqi8EXnmv04LsUSJj/wnOeLTvPKsDF1vUq2xUWLXRl6CqEF5w6ReC
         cAmTYKQ6F8pCvA2Q+fQfggfemHjh6dJw0iRd8rdU7T4UnOIc+VNU3nWaYQpxzuaj0K
         Cxif1MdUdQcgXJip8TUU/w4nKGdYIW6BO2nO6DRE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.14.142] ([89.1.214.113]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUXtY-1lk4eT0qps-00QWTn; Mon, 14
 Jun 2021 23:42:53 +0200
Date:   Mon, 14 Jun 2021 23:42:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 22/28] fsmonitor--daemon: use a cookie file to sync
 with file system
In-Reply-To: <bb7b1912bb47331ac5fea0b4fd8259bb8964e807.1621691828.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2106142330000.57@tvgsbejvaqbjf.bet>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com> <pull.923.v2.git.1621691828.gitgitgadget@gmail.com> <bb7b1912bb47331ac5fea0b4fd8259bb8964e807.1621691828.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TOTmBnxYtNNZ9/vqS0jZEVeoFBj5jv7bEiF4M3b8FNMRopy7Npj
 4hiQBsYs+91/A3FUTMKv68WxQnRzYhdbf567YSh98QXOcYumwtiypmpT2X7BI0jA5Visi+z
 8EEVqRPrdnUNX5fsrRmJSmnDBYPVOgLp/ixbsphX+g41ZA0Cpf9PnAxkzoZR8nj+dpXXN5W
 nbrEiw1BeC6EpUw45pi6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HtsPRkJ384M=:3Z7SCzRb44NPyF/pdR+yuO
 YOgQUAkZr/bszeea8jfvvjctBjwyFcqIUN4JWDqvryMzOgQmxSuyh0jhqLQDTD6Pvcl8HjiTP
 1ktxL/HyIYPL3/aG7juJmPy04xAUILNXxpcy6hYhwj3ZSS8wveytk7nKQCgdeGpPX1B+B7uFX
 e8xBNqoPYO40jMPfioyFUKzp9Zjvp03EuizDUeOvfsUbOtseetr34RklECGhyRA2vcTNdAXMY
 up0rksHzc6JEyVLJKrqmRg8CnbYaJLL/sPt+Qwrz74rQ5figrM5dyVBU88l22voUecO974Bbb
 UpQjfg3GMXI905D9pj2bH5AV7HJZ3Cap/q5jZKU86WtdUYRHvRFFcafYHn71b0jGyuNKv+hi1
 +aeiVEAsgItTGhWF3t4yY0c0l4USgnLm/90NzhBmdtY4lN8uWKeBPbS9HpPH7slAP0Bp+PJUi
 dNJpqZeqP0tfb19q+PQI1IjIIm8WVMFEtUpwn1Xbs1RuVUrH/GXi9WgvPWYSMkGQ40pbJR8UY
 H4PNtJ9xLM9HnTlbcYFVHwimFr+UOTNHCmsaGyjHAw4rrH7LyjyogfMBqEfRsDXN13Up4qFp8
 tsSYCbgVX65DuTCCm+hdY2m4WKj87vYjeMt4U5UGPpfnmcAp9Sz6Ig6GCO5xzfXbHjSUqHJP2
 w85JzqEZ6irrEWz63ZuO5jhoXu6L+xJ9L0gNeSQfmswgyxAgFoeW5eO7oEhKgq2CmOvHgf2Ce
 J5niFk119HizMyRmRIepZZfUD5+exy1aekGWapKiTL4T8Y9NFokumLBrd5iKzsIMD86sTMy4R
 07yMqK0TGFy9cG4aYFz2llB8Qemghwlqznt76XM5ESzcYEJ6BFqFey6iz6xr801OAEncBxJkN
 z64cUgMAFr7KDz+hcu7M6dMuGNdssSoOskLFrVBw7pSU2IDji96IA4TDhoidf+8gPMsNtmxHQ
 4fa/jHU2/NW/t66UmFYgzNOyrAZyfzN2zOjwtSKyb6V6twRvQOOpYQLiLb2FlVhOEkZ5xS7x9
 cM7A2gXnomku1C3592y84ebSlVvcunx7MpPUmcvnKcvFPBJxlh/SsJ8ca2Mh3oxs8t5ed71IY
 s3zFj4KQEg+h7kMaBwD3PTf45f57gM7VXKH/ekrh9AQkuq/w1JYwUFXGw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

I've found an issue with this patch that I unfortunately failed to fix in
time for Git for Windows v2.32.0. It is a subtle issue, and it only reared
its head in the form of flakiness when running Scalar's Functional Tests
(which is the most comprehensive test suite we have in the absence of
proper integration tests for Git).

The issue is the change in behavior between the previous iteration and
this one when replying with the trivial response:

On Sat, 22 May 2021, Jeff Hostetler via GitGitGadget wrote:

> diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
> index e807aa8f6741..985a82cf39e0 100644
> --- a/builtin/fsmonitor--daemon.c
> +++ b/builtin/fsmonitor--daemon.c
> [...]
> @@ -522,6 +672,7 @@ static int do_handle_client(struct fsmonitor_daemon_=
state *state,
>  		 */
>  		do_flush =3D 1;
>  		do_trivial =3D 1;
> +		do_cookie =3D 1;
>
>  	} else if (!skip_prefix(command, "builtin:", &p)) {
>  		/* assume V1 timestamp or garbage */
> @@ -535,6 +686,7 @@ static int do_handle_client(struct fsmonitor_daemon_=
state *state,
>  				  "fsmonitor: unsupported V1 protocol '%s'"),
>  				 command);
>  		do_trivial =3D 1;
> +		do_cookie =3D 1;
>
>  	} else {
>  		/* We have "builtin:*" */
> @@ -544,12 +696,14 @@ static int do_handle_client(struct fsmonitor_daemo=
n_state *state,
>  					 "fsmonitor: invalid V2 protocol token '%s'",
>  					 command);
>  			do_trivial =3D 1;
> +			do_cookie =3D 1;

In the first iteration of this patch series, these three trivial responses
were sent without first writing a cookie file and then waiting for the
event to arrive.

The symptom of the issue here is that some of Scalar's Functional Test
hung, ostensibly waiting for a cookie file that never arrived.

I am not 100% clear on why this only happened in Scalar's Functional Tests
and not in the regression test in Git's test suite, but here are my
thoughts on this:

- I _suspect_ that the .git/ directory gets deleted on the client side
  after receiving a trivial response and finishing the test case, and
  _before_ the daemon can receive the event. As the directory already got
  deleted, the event never arrives.

- I _think_ that running the test cases in parallel (10 concurrent test
  cases, if memory serves) exacerbates this problem.

- Simply _not_ writing that cookie file (i.e. removing those three
  `do_cookie =3D 1` assignments above is sufficient to let Scalar's
  Functional Tests pass.

- Those trivial responses do not _actually_ need to be guarded behind that
  cookie file. The worst that could happen is for the FSMonitor daemon to
  over-report paths that need to be `lstat()`ed.

Therefore, I would like to suggest this diff to be squashed into this
patch in a re-roll:

=2D- snip --
diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 985a82cf39e..4afbb36fe61 100644
=2D-- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -672,7 +672,6 @@ static int do_handle_client(struct fsmonitor_daemon_st=
ate *state,
 		 */
 		do_flush =3D 1;
 		do_trivial =3D 1;
-		do_cookie =3D 1;

 	} else if (!skip_prefix(command, "builtin:", &p)) {
 		/* assume V1 timestamp or garbage */
@@ -686,7 +685,6 @@ static int do_handle_client(struct fsmonitor_daemon_st=
ate *state,
 				  "fsmonitor: unsupported V1 protocol '%s'"),
 				 command);
 		do_trivial =3D 1;
-		do_cookie =3D 1;

 	} else {
 		/* We have "builtin:*" */
@@ -696,7 +694,6 @@ static int do_handle_client(struct fsmonitor_daemon_st=
ate *state,
 					 "fsmonitor: invalid V2 protocol token '%s'",
 					 command);
 			do_trivial =3D 1;
-			do_cookie =3D 1;

 		} else {
 			/*
=2D- snap --

For the record, the Windows installer and macOS/Linux packages available
at https://github.com/microsoft/git/releases/tag/v2.32.0.vfs.0.1 do come
with this fix.

Thanks,
Dscho

>
>  		} else {
>  			/*
>  			 * We have a V2 valid token:
>  			 *     "builtin:<token_id>:<seq_nr>"
>  			 */
> +			do_cookie =3D 1;
>  		}
>  	}
>
> @@ -558,6 +712,30 @@ static int do_handle_client(struct fsmonitor_daemon=
_state *state,
>  	if (!state->current_token_data)
>  		BUG("fsmonitor state does not have a current token");
>
> +	/*
> +	 * Write a cookie file inside the directory being watched in
> +	 * an effort to flush out existing filesystem events that we
> +	 * actually care about.  Suspend this client thread until we
> +	 * see the filesystem events for this cookie file.
> +	 *
> +	 * Creating the cookie lets us guarantee that our FS listener
> +	 * thread has drained the kernel queue and we are caught up
> +	 * with the kernel.
> +	 *
> +	 * If we cannot create the cookie (or otherwise guarantee that
> +	 * we are caught up), we send a trivial response.  We have to
> +	 * assume that there might be some very, very recent activity
> +	 * on the FS still in flight.
> +	 */
> +	if (do_cookie) {
> +		cookie_result =3D with_lock__wait_for_cookie(state);
> +		if (cookie_result !=3D FCIR_SEEN) {
> +			error(_("fsmonitor: cookie_result '%d' !=3D SEEN"),
> +			      cookie_result);
> +			do_trivial =3D 1;
> +		}
> +	}
> +
>  	if (do_flush)
>  		with_lock__do_force_resync(state);
>
> @@ -769,7 +947,9 @@ static int handle_client(void *data,
>  	return result;
>  }
>
> -#define FSMONITOR_COOKIE_PREFIX ".fsmonitor-daemon-"
> +#define FSMONITOR_DIR           "fsmonitor--daemon"
> +#define FSMONITOR_COOKIE_DIR    "cookies"
> +#define FSMONITOR_COOKIE_PREFIX (FSMONITOR_DIR "/" FSMONITOR_COOKIE_DIR=
 "/")
>
>  enum fsmonitor_path_type fsmonitor_classify_path_workdir_relative(
>  	const char *rel)
> @@ -922,6 +1102,9 @@ void fsmonitor_publish(struct fsmonitor_daemon_stat=
e *state,
>  		}
>  	}
>
> +	if (cookie_names->nr)
> +		with_lock__mark_cookies_seen(state, cookie_names);
> +
>  	pthread_mutex_unlock(&state->main_lock);
>  }
>
> @@ -1011,7 +1194,9 @@ static int fsmonitor_run_daemon(void)
>
>  	memset(&state, 0, sizeof(state));
>
> +	hashmap_init(&state.cookies, cookies_cmp, NULL, 0);
>  	pthread_mutex_init(&state.main_lock, NULL);
> +	pthread_cond_init(&state.cookies_cond, NULL);
>  	state.error_code =3D 0;
>  	state.current_token_data =3D fsmonitor_new_token_data();
>
> @@ -1035,6 +1220,23 @@ static int fsmonitor_run_daemon(void)
>  		state.nr_paths_watching =3D 2;
>  	}
>
> +	/*
> +	 * We will write filesystem syncing cookie files into
> +	 * <gitdir>/<fsmonitor-dir>/<cookie-dir>/<pid>-<seq>.
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
> +
>  	/*
>  	 * Confirm that we can create platform-specific resources for the
>  	 * filesystem listener before we bother starting all the threads.
> @@ -1047,6 +1249,7 @@ static int fsmonitor_run_daemon(void)
>  	err =3D fsmonitor_run_daemon_1(&state);
>
>  done:
> +	pthread_cond_destroy(&state.cookies_cond);
>  	pthread_mutex_destroy(&state.main_lock);
>  	fsmonitor_fs_listen__dtor(&state);
>
> @@ -1054,6 +1257,11 @@ static int fsmonitor_run_daemon(void)
>
>  	strbuf_release(&state.path_worktree_watch);
>  	strbuf_release(&state.path_gitdir_watch);
> +	strbuf_release(&state.path_cookie_prefix);
> +
> +	/*
> +	 * NEEDSWORK: Consider "rm -rf <gitdir>/<fsmonitor-dir>"
> +	 */
>
>  	return err;
>  }
> diff --git a/fsmonitor--daemon.h b/fsmonitor--daemon.h
> index 89a9ef20b24b..e9fc099bae9c 100644
> --- a/fsmonitor--daemon.h
> +++ b/fsmonitor--daemon.h
> @@ -45,6 +45,11 @@ struct fsmonitor_daemon_state {
>
>  	struct fsmonitor_token_data *current_token_data;
>
> +	struct strbuf path_cookie_prefix;
> +	pthread_cond_t cookies_cond;
> +	int cookie_seq;
> +	struct hashmap cookies;
> +
>  	int error_code;
>  	struct fsmonitor_daemon_backend_data *backend_data;
>
> --
> gitgitgadget
>
>
