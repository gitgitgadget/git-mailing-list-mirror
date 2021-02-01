Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2EFC4332B
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 19:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FED764ECC
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 19:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbhBATsh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 14:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbhBATq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 14:46:59 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5425C0617A7
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 11:46:02 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id u14so333861wml.4
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 11:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Y+Es2quZG2VS0gOz4BAlFxwPGwEi91IxliFZiSxgf+w=;
        b=s9K4ZcZxnBviCAklJTI5hfY6PNtZMHSueQ8vbZ/+n23ysLG8ItQE6XdkH1ZUBSs0CB
         cpNkx5sGh+1bga5ejSwrIK0ZtUJIcFIwtVGPnsQmWGlwzvZROHRWFBGBAsXi4b+I/36h
         Jt29l6K8fTvBEHpYw0txi+R1xRY7uVS9XUDFBvrML/NifR+HD6pQzQe4iTkSZiYtYrPD
         YW9Nf524A5rPeutG6PcnG4074Pn18oFPZalZn8TLByQ3uCqmOCYsC7WYkTEVGQ/LMWpv
         Ny8xXu70QyaYA8dq8wCorVy6NTJaylYLhMx+HGXoMwJJv7HJoybPAw+lEJub2ZCjx0yg
         E0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Y+Es2quZG2VS0gOz4BAlFxwPGwEi91IxliFZiSxgf+w=;
        b=ZxaVEx4LpCO5nMqrirnBxzpLdqPs9lVSBdVFzyGlAjy3fPTu8clzyxiTRwwSPfVkd0
         fBwv/Qh0a3sWgG1yxA8lG5kVRhDA5TK8FnAtU50B74chEIA8UDHo15VCs/1nmXHUgvej
         aSUuyMJK3J1bPxuIg9g2I0JRfjjXIJ9wJer3KX5vPGa9/GTML+qynDsiBd6Oy4hC2hnb
         1wUKwr4poQKLZnetWZs5GPtV/7wa1YAZOQiuofpI71UTcu7fyB5qfB8jsuKTIaFM5QKv
         6GiqQuWGb94PdJQDz9FH3bOsMlPAwPhjuX4WFiLt8RbbAfYbOIEDlA45yHb4QtaCMe9m
         zWUg==
X-Gm-Message-State: AOAM531iCFAD/SzNN4RFumOGz0gIP1bh3kxTRhB02NGDtrP5s1DKG+aR
        /goMj8RIedNVS5UcXUmU7W8Q+zJzQSI=
X-Google-Smtp-Source: ABdhPJyK8D0ncy5mwjUHrwvQrCAB2joFQpetA5eKkjxD5TLiyWusvlba1GbbJIvInWIo4Ey2f1HvVw==
X-Received: by 2002:a7b:cd06:: with SMTP id f6mr392089wmj.125.1612208761538;
        Mon, 01 Feb 2021 11:46:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d9sm29167484wrq.74.2021.02.01.11.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 11:46:01 -0800 (PST)
Message-Id: <2cca15a10ecec321731bf628e1317ff8d244dfd0.1612208747.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
        <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 19:45:46 +0000
Subject: [PATCH v2 13/14] unix-socket: do not call die in
 unix_stream_connect()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach `unix_stream_connect()` to return error rather than calling `die()`
when a socket cannot be created.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 unix-socket.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/unix-socket.c b/unix-socket.c
index 9726992f276..c7573df56a6 100644
--- a/unix-socket.c
+++ b/unix-socket.c
@@ -76,15 +76,17 @@ static int unix_sockaddr_init(struct sockaddr_un *sa, const char *path,
 
 int unix_stream_connect(const char *path)
 {
-	int fd, saved_errno;
+	int fd = -1;
+	int saved_errno;
 	struct sockaddr_un sa;
 	struct unix_sockaddr_context ctx = UNIX_SOCKADDR_CONTEXT_INIT;
 
 	if (unix_sockaddr_init(&sa, path, &ctx) < 0)
 		return -1;
+
 	fd = socket(AF_UNIX, SOCK_STREAM, 0);
 	if (fd < 0)
-		die_errno("unable to create socket");
+		goto fail;
 
 	if (connect(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0)
 		goto fail;
@@ -94,7 +96,8 @@ int unix_stream_connect(const char *path)
 fail:
 	saved_errno = errno;
 	unix_sockaddr_cleanup(&ctx);
-	close(fd);
+	if (fd != -1)
+		close(fd);
 	errno = saved_errno;
 	return -1;
 }
-- 
gitgitgadget

