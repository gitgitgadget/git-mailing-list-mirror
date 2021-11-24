Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E0FC433EF
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 05:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbhKXFsH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 00:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbhKXFsG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 00:48:06 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AF5C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 21:44:57 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id y16so1708454ioc.8
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 21:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YMwbTfbQz++3amTNUmFV0WRKnE9khcvEaDO1Y2BGdio=;
        b=ST95IwLS6JmJN/MKkr1Qnm6tKsEl0GAiRm/RhFyC7mLSsz92WP+POj8oVUsEBVUBqU
         5xeQdmF6W+DWq75hqQPDttvjo3E+QUfpJSffiO3SO8IkXAlLgGxMMf2SSgPC8tQFJWxp
         J0G+z/IpT/q4CHow4QRyLXUqX87R0D0xkF3WA51+iRNt/UBMYOcZftxsmbUohJ8qwR/M
         vhHePDGEVIYjM1/pusJwwPqZnI83ys6FJpmqOcoSAS4RqNiisWtPC3cYKZhBCLOdbBpc
         k4RX4dxxfVcL58suF+SsvLJeOXeFU5pj4+oKAOC9o2x8RtkAGOc6g/xH163NUeUPMLIC
         aPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=YMwbTfbQz++3amTNUmFV0WRKnE9khcvEaDO1Y2BGdio=;
        b=g+vhx8GCzuMJUg7/7kdUxmEgqvNgMLnfC4cZzDx+3EKSoi6vt+5Lcjxm7CI4KCYzET
         EQ+hjW7/tJ5r+4Dkt0F1OVDbLluCDdoYUG5NnBnnUCzYZ3AEG/i5fAJjDuxz9zO+4Dn4
         unVMhi1BkGg5UlLbVc4CxXnWyiyIZaNkjqFUkjF2HySbEDcTPPdaJurN7eDueVAfZgkn
         20z5JMJ7RCw1dymJSo3XWBZ86KcdMiOSQ8wqrqRoRaEQZ98iwrcOn36tFaU2uQ6Ytfyl
         PaQtqw0mRAz03FWV4yhxACyV+8eVagiqs1lSyNLB6PUy718F2Wcw7stsB1n3Udpj84wv
         Kv6A==
X-Gm-Message-State: AOAM532BQYGRc3hWj4y58EYr/3ldCfHk3jXNiqSsxpkXt5fcVF0GaYwe
        HoUyBBjcCXWc49Ns22nGcBU=
X-Google-Smtp-Source: ABdhPJzymckZYCgWTEawTmgiL8hHKSva+1fQ0t6cD1h8zxpYQXuZf2kAqf9DqJPZHuJUPb+DgnFciQ==
X-Received: by 2002:a05:6602:13c4:: with SMTP id o4mr11849576iov.152.1637732697015;
        Tue, 23 Nov 2021 21:44:57 -0800 (PST)
Received: from flurp.local (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id f16sm9017715iov.33.2021.11.23.21.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 21:44:56 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
Date:   Wed, 24 Nov 2021 00:44:50 -0500
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Enzo Matsumiya <ematsumiya@suse.de>
Subject: Re: [PATCH v2 1/9] worktree: remove redundant NULL-ing of "cp.argv
Message-ID: <YZ3RUkGpixYAREcI@flurp.local>
References: <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com>
 <cover-v2-0.9-00000000000-20211123T115551Z-avarab@gmail.com>
 <patch-v2-1.9-9cc220ce5a3-20211123T115551Z-avarab@gmail.com>
 <CAPig+cStZp=AOPHW8i7AqwDOV6djYzHC6GmcVeb=4PUj5bjvAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cStZp=AOPHW8i7AqwDOV6djYzHC6GmcVeb=4PUj5bjvAw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 23, 2021 at 10:26:56AM -0500, Eric Sunshine wrote:
> I think perhaps the simplest thing to do is merely to squash this
> patch into the patch which ultimately removes the child_process::argv
> member (and the removal of these lines from worktree.c probably
> doesn't even need mention in the commit message -- or maybe just a
> minor mention).

On second thought, squashing this patch into the patch which
ultimately retires child_process::argv is probably not necessary. If
the patch is instead rewritten as below, then it prepares
builtin/worktree.c for eventual retirement of child_process::argv
without breaking git-worktree functionality.

(You could also extend this patch so it prepares for removal of
child_process::env, as well, or keep it minimal as I did here.)

-- >8 --
From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] worktree: stop being overly intimate with run_command()
 internals

add_worktree() reuses a `child_process` for three run_command()
invocations, but to do so, it has overly-intimate knowledge of
run-command.c internals. In particular, it knows that it must reset
child_process::argv to NULL for each subsequent invocation[*] in order
for start_command() to latch the newly-populated child_process::args for
each invocation, even though this behavior is not a part of the
documented API. Beyond having overly-intimate knowledge of run-command.c
internals, the reuse of one `child_process` for three run_command()
invocations smells like an unnecessary micro-optimization. Therefore,
stop sharing one `child_process` and instead use a new one for each
run_command() call.

[*] If child_process::argv is not reset to NULL, then subsequent
run_command() invocations will instead incorrectly access a dangling
pointer to freed memory which had been allocated by child_process::args
on the previous run. This is due to the following code in
start_command():

    if (!cmd->argv)
        cmd->argv = cmd->args.v;

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/worktree.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index d22ece93e1..9edd3e2829 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -355,8 +355,8 @@ static int add_worktree(const char *path, const char *refname,
 		goto done;
 
 	if (opts->checkout) {
-		cp.argv = NULL;
-		strvec_clear(&cp.args);
+		struct child_process cp = CHILD_PROCESS_INIT;
+		cp.git_cmd = 1;
 		strvec_pushl(&cp.args, "reset", "--hard", "--no-recurse-submodules", NULL);
 		if (opts->quiet)
 			strvec_push(&cp.args, "--quiet");
@@ -385,12 +385,11 @@ static int add_worktree(const char *path, const char *refname,
 		const char *hook = find_hook("post-checkout");
 		if (hook) {
 			const char *env[] = { "GIT_DIR", "GIT_WORK_TREE", NULL };
-			cp.git_cmd = 0;
+			struct child_process cp = CHILD_PROCESS_INIT;
 			cp.no_stdin = 1;
 			cp.stdout_to_stderr = 1;
 			cp.dir = path;
 			cp.env = env;
-			cp.argv = NULL;
 			cp.trace2_hook_name = "post-checkout";
 			strvec_pushl(&cp.args, absolute_path(hook),
 				     oid_to_hex(null_oid()),
-- 
2.34.0.399.gdf2c515fd2

-- >8 --
