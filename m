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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8AAC433E9
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 15:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0567B23131
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 15:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391498AbhALPc5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 10:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391414AbhALPc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 10:32:56 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B816DC0617A4
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 07:31:41 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id y17so2898428wrr.10
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 07:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YenO7yqnHXBLLCYIiSPYtExaFyt9ZYpIIXNpSVZKIXA=;
        b=HojPQCOe1SzoR71JAoS4Z6Oh9A17zACQUZqc5ueqCf4b/9MUySLcaeY+QYGzgpY7TB
         ExTC5Bg6Knil4xNyMEVvoJzBLNv6WE3+z5/ZLQaSgob+vixLnb8Q+bg7Ts00ZuspYeX4
         zjpVB8WuOaBGvH9Sp+aG1Ydj9Cfw8oTMsBa4OohX7iihCzt1AyDtLG0jsyW5g+KS8ISK
         sv6MtYAa0lUc6GkkxAm3pV60U3+mqUh1c/L4JvXTGLCnxyWCNLm6ksDRMvldf39uq5xt
         8siWvQp08SAy6hIvcPGIoF6I5tzDN7e/MEihMgfl2uO8LxNyMoLwzS+aXWzXawoUENN+
         EBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YenO7yqnHXBLLCYIiSPYtExaFyt9ZYpIIXNpSVZKIXA=;
        b=l4qpLBIUlGzJPwt26jhhRaaPM24iiwO67krvoiwx4xdfhWTl95eeL0PlndmTmvD1SP
         u3Rydp5w+MY/fyJAdnFm8TIZJ59AjkV+GAZXr9rbiTqCoP9LaZ7HVs9hZpKJCHApJGfx
         Tf5wvjchU0TM3e71zLNIm4hQMq0lZhlksB/GS3JEtACGDmFRo/cEvGpkVOhTm6KozldG
         9X2zy7+WZr/77rket4TMNF+3xcLIMnJzUk6N6vTKQ2MFERB35TdXT597NzdAUHqXCG6x
         9LJCXs35OM2aqcWuQ3YgJdnbBX2j42Z159o5eelhtmzDetRJkplW/nUWPfYRTuCpLFp1
         lgMw==
X-Gm-Message-State: AOAM532cUdWjf5J7WvwY4enSy9b4sZofYGsTtC0ot9w+CRGNs7AkdMNu
        /wKGNjS7Q6PIuYdqAZPotV+QWuGY84E=
X-Google-Smtp-Source: ABdhPJwo7JjR86xo6DkeQ1+hEVInuKcMOg2u3Ybspd0pIbGC5glLf3fx8Q5+QMPDAjfVz+q4fLc3Rg==
X-Received: by 2002:a5d:660c:: with SMTP id n12mr4979258wru.291.1610465500247;
        Tue, 12 Jan 2021 07:31:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l7sm4359677wme.4.2021.01.12.07.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 07:31:39 -0800 (PST)
Message-Id: <96268351ac66371a0998d189db619f357d2b71fa.1610465493.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.git.1610465492.gitgitgadget@gmail.com>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 Jan 2021 15:31:29 +0000
Subject: [PATCH 07/10] unix-socket: create gentle version of
 unix_stream_listen()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create a gentle version of `unix_stream_listen()`.  This version does
not call `die()` if a socket-fd cannot be created and does not assume
that it is safe to `unlink()` an existing socket-inode.

`unix_stream_listen()` uses `unix_stream_socket()` helper function to
create the socket-fd.  Avoid that helper because it calls `die()` on
errors.

`unix_stream_listen()` always tries to `unlink()` the socket-path before
calling `bind()`.  If there is an existing server/daemon already bound
and listening on that socket-path, our `unlink()` would have the effect
of disassociating the existing server's bound-socket-fd from the socket-path
without notifying the existing server.  The existing server could continue
to service existing connections (accepted-socket-fd's), but would not
receive any futher new connections (since clients rendezvous via the
socket-path).  The existing server would effectively be offline but yet
appear to be active.

Furthermore, `unix_stream_listen()` creates an opportunity for a brief
race condition for connecting clients if they try to connect in the
interval between the forced `unlink()` and the subsequent `bind()` (which
recreates the socket-path that is bound to a new socket-fd in the current
process).

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 unix-socket.c | 39 +++++++++++++++++++++++++++++++++++++++
 unix-socket.h |  8 ++++++++
 2 files changed, 47 insertions(+)

diff --git a/unix-socket.c b/unix-socket.c
index 19ed48be990..3a9ffc32268 100644
--- a/unix-socket.c
+++ b/unix-socket.c
@@ -121,3 +121,42 @@ int unix_stream_listen(const char *path)
 	errno = saved_errno;
 	return -1;
 }
+
+int unix_stream_listen_gently(const char *path,
+			      const struct unix_stream_listen_opts *opts)
+{
+	int fd = -1;
+	int bind_successful = 0;
+	int saved_errno;
+	struct sockaddr_un sa;
+	struct unix_sockaddr_context ctx;
+
+	if (unix_sockaddr_init(&sa, path, &ctx) < 0)
+		goto fail;
+
+	fd = socket(AF_UNIX, SOCK_STREAM, 0);
+	if (fd < 0)
+		goto fail;
+
+	if (opts->force_unlink_before_bind)
+		unlink(path);
+
+	if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0)
+		goto fail;
+	bind_successful = 1;
+
+	if (listen(fd, opts->listen_backlog_size) < 0)
+		goto fail;
+
+	unix_sockaddr_cleanup(&ctx);
+	return fd;
+
+fail:
+	saved_errno = errno;
+	unix_sockaddr_cleanup(&ctx);
+	close(fd);
+	if (bind_successful)
+		unlink(path);
+	errno = saved_errno;
+	return -1;
+}
diff --git a/unix-socket.h b/unix-socket.h
index e271aeec5a0..253f579f087 100644
--- a/unix-socket.h
+++ b/unix-socket.h
@@ -4,4 +4,12 @@
 int unix_stream_connect(const char *path);
 int unix_stream_listen(const char *path);
 
+struct unix_stream_listen_opts {
+	int listen_backlog_size;
+	unsigned int force_unlink_before_bind:1;
+};
+
+int unix_stream_listen_gently(const char *path,
+			      const struct unix_stream_listen_opts *opts);
+
 #endif /* UNIX_SOCKET_H */
-- 
gitgitgadget

