Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C95C433DB
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 22:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE40F224B0
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 22:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730485AbhAQWXO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jan 2021 17:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730486AbhAQWWk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jan 2021 17:22:40 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFB3C061574
        for <git@vger.kernel.org>; Sun, 17 Jan 2021 14:21:54 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id gx5so1838529ejb.7
        for <git@vger.kernel.org>; Sun, 17 Jan 2021 14:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J89HG4OL5mfoaQtSDqRTx6Q5HxcitzZPyz1N4vtL+wc=;
        b=IzEhHBkwCx4QK2tCTJMgaHi35kPPYuEgtEAYgxTWKmrgzHQFqHsiNpXw0gOsb24yW0
         rFbF/5SvmbDGN8fJDmIuVpTz1durB+13DKxpsX+E7tVSWh875vRtN3Yv0BO3/8mZn0mD
         yA7o63sDGGONWxrV7/dQZQwymZritTgOcIEptJep+PVhP6SeXKmrtTMNHAeUJsWfCOAE
         J4d2GfA6228IAlZ9DBf1ifut8rsdZxwU5fBPqJJqwwcjoYJ6JQWDuA8q2xXegyKK8GZz
         Kd5O3a404G2Vh4kZVeTjetTd4TNjSnLPOCW5ss5XTlUGdUsD2rUPcncPSHZEdjaDn/hf
         mqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J89HG4OL5mfoaQtSDqRTx6Q5HxcitzZPyz1N4vtL+wc=;
        b=fMp2XsZ8EmWYuHCK+2bOmrI67/cd/WagxXKvcZg3l2hZs5hMGo9WX1JConYKcZwx5F
         pRj66bF8d0rBJCl67vSHBtg5/by5nYCITquQaosz/5lGSVXb8zumlayI3Vhw2CUTaClT
         9KyN5jz8yEEoRBJaz65sH5hagOBAXPdbGPfOb9lrls/dk+C3riVu5Yi+N89j3tneBC3+
         ZfMT0FQXyOblos16TqA/YfZmUQu5TZqdIvKKsvJZPpPv78YtzmTRjPbgoDu6BUk2dl7g
         10mbB70R1au/4EfcHjwD1a2XdCgKciBZGMinp+hNIrYT7mObRHtjj2ceWI/tJGUQWg6C
         j7xg==
X-Gm-Message-State: AOAM533BJnyOpxg4jp0WPIfq6A3CN7sbjEChpQgtLNCftjF02sAfNZL1
        JtZLyat0dea0299OrAZOQ+Q=
X-Google-Smtp-Source: ABdhPJzzrdthq0Cj8RZ9rbbBhr5foydd+e5w0R2iy+BzF5XrkfWxgO+Ys0MH+vkJW8WDKZ7zIcjakw==
X-Received: by 2002:a17:906:eb1b:: with SMTP id mb27mr8084909ejb.332.1610922113393;
        Sun, 17 Jan 2021 14:21:53 -0800 (PST)
Received: from szeder.dev (92-249-246-25.pool.digikabel.hu. [92.249.246.25])
        by smtp.gmail.com with ESMTPSA id cn25sm9819701edb.63.2021.01.17.14.21.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2021 14:21:52 -0800 (PST)
Date:   Sun, 17 Jan 2021 23:21:51 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v19 03/10] receive-pack: add new proc-receive hook
Message-ID: <20210117222151.GY8396@szeder.dev>
References: <20200824174202.11710-1-worldhello.net@gmail.com>
 <20200827154551.5966-4-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200827154551.5966-4-worldhello.net@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


This patch added a whole lot of test cases, and two of them '86 -
proc-receive: not support push options (builtin protocol)' and '95 -
proc-receive: not support push options (builtin protocol/porcelain)'
are prone to rare failures.

On Thu, Aug 27, 2020 at 11:45:44AM -0400, Jiang Xin wrote:
> diff --git a/t/t5411/test-0026-push-options.sh b/t/t5411/test-0026-push-options.sh
> new file mode 100644
> index 0000000000..d0c4da8b23
> --- /dev/null
> +++ b/t/t5411/test-0026-push-options.sh

> +# Refs of upstream : master(A)
> +# Refs of workbench: master(A)  tags/v123
> +# git push -o ...  :                       refs/for/master/topic
> +test_expect_success "proc-receive: not support push options ($PROTOCOL)" '
> +	test_must_fail git -C workbench push \
> +		-o issue=123 \
> +		-o reviewer=user1 \
> +		origin \
> +		HEAD:refs/for/master/topic \
> +		>out 2>&1 &&

Three relevant things are happening here:

  - 'git push' is executed with its standard output and error
    redirected to the file 'out'.

  - 'git push' executes 'git receive-pack' internally, which inherits
    the open file descriptors, so its output and error goes into that
    same 'out' file.

  - 'git push' is expected to fail when it finds out that the other
    side doesn't support push options, but it does so with a simple
    die() right away, without waiting for its child 'git receive-pack'
    process to finish.

> +	make_user_friendly_and_stable_output <out >actual &&
> +	test_i18ngrep "fatal: the receiving end does not support push options" \
> +		actual &&
> +	git -C "$upstream" show-ref >out &&

Here the shell opens and truncates the file 'out' to write 'git
show-ref's output, i.e. it is still the same 'out' file that was used
earlier.

Consequently, it is possible that 'git receive-pack' is still running,
its open file descriptors to 'out' are still valid, and its "fatal:
the remote end hung up unexpectedly" error message about the suddenly
disappeared 'git push' can partially overwrite the output from 'git
show-ref'.

> +	make_user_friendly_and_stable_output <out >actual &&
> +	cat >expect <<-EOF &&
> +	<COMMIT-A> refs/heads/master
> +	EOF
> +	test_cmp expect actual
> +'

The supposedly stable output can then unexpectedly include that error
message, and the test fails with something like this:

  + test_cmp expect actual
  --- expect      2021-01-17 21:55:23.430750004 +0000
  +++ actual      2021-01-17 21:55:23.430750004 +0000
  @@ -1 +1 @@
  -<COMMIT-A> refs/heads/main
  +<COMMIT-A> refs/heads/maifatal: the remote end hung up unexpectedly
  error: last command exited with $?=1
  not ok 86 - proc-receive: not support push options (builtin protocol)

> diff --git a/t/t5411/test-0027-push-options--porcelain.sh b/t/t5411/test-0027-push-options--porcelain.sh
> new file mode 100644
> index 0000000000..c89a1e7c57
> --- /dev/null
> +++ b/t/t5411/test-0027-push-options--porcelain.sh

> +test_expect_success "proc-receive: not support push options ($PROTOCOL/porcelain)" '
> +	test_must_fail git -C workbench push \
> +		--porcelain \
> +		-o issue=123 \
> +		-o reviewer=user1 \
> +		origin \
> +		HEAD:refs/for/master/topic \
> +		>out 2>&1 &&
> +	make_user_friendly_and_stable_output <out >actual &&
> +	test_i18ngrep "fatal: the receiving end does not support push options" \
> +		actual &&
> +	git -C "$upstream" show-ref >out &&
> +	make_user_friendly_and_stable_output <out >actual &&
> +	cat >expect <<-EOF &&
> +	<COMMIT-A> refs/heads/master
> +	EOF
> +	test_cmp expect actual
> +'

This test is almost identical to the one above, and the same sequence
of events leads to a similar failure.


I saw these tests fail in Travis CI's s390x environment a couple of
times, and, alas, that is the only environment where I was able to
reproduce the failure with '--stress' with an unmodified Git.

The diff below adds a couple of strategically-placed delays to
reliably demonstrate these failures:

  ---  >8  ---

diff --git a/pkt-line.c b/pkt-line.c
index d633005ef7..3b26631948 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -307,6 +307,7 @@ static int get_packet_data(int fd, char **src_buf, size_t *src_size,
 		if (options & PACKET_READ_GENTLE_ON_EOF)
 			return -1;
 
+		sleep(1);
 		die(_("the remote end hung up unexpectedly"));
 	}
 
diff --git a/t/t5411/test-0026-push-options.sh b/t/t5411/test-0026-push-options.sh
index e88edb16a4..a1e896f404 100644
--- a/t/t5411/test-0026-push-options.sh
+++ b/t/t5411/test-0026-push-options.sh
@@ -21,6 +21,7 @@ test_expect_success "proc-receive: not support push options ($PROTOCOL)" '
 	test_i18ngrep "fatal: the receiving end does not support push options" \
 		actual &&
 	git -C "$upstream" show-ref >out &&
+	sleep 2 &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
 	<COMMIT-A> refs/heads/main
diff --git a/t/t5411/test-0027-push-options--porcelain.sh b/t/t5411/test-0027-push-options--porcelain.sh
index 3a6561b5ea..f97cef440f 100644
--- a/t/t5411/test-0027-push-options--porcelain.sh
+++ b/t/t5411/test-0027-push-options--porcelain.sh
@@ -22,6 +22,7 @@ test_expect_success "proc-receive: not support push options ($PROTOCOL/porcelain
 	test_i18ngrep "fatal: the receiving end does not support push options" \
 		actual &&
 	git -C "$upstream" show-ref >out &&
+	sleep 2 &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
 	<COMMIT-A> refs/heads/main

  ---  8<  ---

I think these are the only two tests that can cause this racy
behavior: by instrumenting finish_command() I found that in all other
tests where 'git push' is expected to fail it errors out gracefully
and waits for its 'git receive-pack' child process.


