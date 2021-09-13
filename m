Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59596C433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 11:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3809160F46
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 11:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239421AbhIMLIS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 07:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239377AbhIMLIR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 07:08:17 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298E3C061760
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 04:07:02 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id e26so6352017wmk.2
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 04:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=azNqtC40u9DK73h/iiUhgq6LLRr5tg+pMaNA62OOgQQ=;
        b=MeR/0fZkcN0TaW8zOqjmShVgyOKyA8qQ+Idlvvr29Sdh2McFR/K+Fi45xaghlMpJW+
         t2nzATviNdvvEl2bdpPNVTQgljzp3v3Wf1zNEQyANc1MWDtzwrHBChVc/DNPnWQCGgAi
         5De55y2xySs9ED/m4GKOZ1SyDEz8p9ZZWcp3XRiFZyJ9odjXqd29FpDJ5enTitkCWXWh
         vK8bYI8/rGrBkZM9qLa0EWq5ulIUJJWqSkC/KEALuYcpKVlSOSuiqsAuMw07TpsROgXv
         q/hHx5FJzOI9AwK9IrMx+hItBjoYaRNzorqS98XBx5dr2rR3lzThG2SvqzgkHWAQM64u
         rPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=azNqtC40u9DK73h/iiUhgq6LLRr5tg+pMaNA62OOgQQ=;
        b=6RCRyzJJbOSuf0Devy58//Nx66uOiNpdELBpNE5RPfCUP5b3DdNISkA6rclZ/zqCrT
         8IldkwgAUOvNuAVNQtqSbInntOx8TcnxY37/YLHo7uV+4QhYvSRxBDuzBChEP2mC1yvp
         awssUmgEFIZHpE9Qmex5Gk5kJ4yUr1/s5mZBxr8f8IkmLmnVJABXAyRwQ3ToQB65yd5s
         14RA2WQ+Y9k9hSOj9b1LtoSEqaHM36OmLQc8CZFsznrN2ntxOetEVDin3pW2VMDGlki7
         uW0cfMtxH79r6Re5+j6MNli92f3LG4XPmpQ1UTQtfzvqFh04yLoJFfu0FU0siTndD3KR
         Jlmw==
X-Gm-Message-State: AOAM531b56lnzT1zn+aoIFU5tc1jcrcFEzJZ9zMnQWv92GAQXEMUFxmm
        5Al6nB8DVTCMlKaS+6PM+SN9mv+QMDU=
X-Google-Smtp-Source: ABdhPJxi0mDlq6bzEfWx/JS9uXc6Y+aGcS9d9pl4WYCXNV8IjVG+Ib0SJw3tMUzymLi6USa8CV1qSg==
X-Received: by 2002:a7b:c5d2:: with SMTP id n18mr10504677wmk.97.1631531220756;
        Mon, 13 Sep 2021 04:07:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v20sm7242456wra.73.2021.09.13.04.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 04:07:00 -0700 (PDT)
Message-Id: <8674d67a439a23425133fa005e519ebb6ac19c42.1631531219.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1038.git.1631531218.gitgitgadget@gmail.com>
References: <pull.1038.git.1631531218.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Matthias=20A=C3=9Fhauer?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 13 Sep 2021 11:06:57 +0000
Subject: [PATCH 1/2] help: make sure local html page exists before calling
 external processes
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
        =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>

We already check that git.html exists, regardless of the page the user wants
to open. Additionally checking wether the requested page exists gives us a
smoother user experience when it doesn't.

When calling a git command and there is an error, most users reasonably expect
git to produce an error message on the standard error stream, but in this case
we pass the filepath to git web--browse wich passes it on to a browser (or a
helper programm like xdg-open or start that should in turn open a browser)
without any error and many GUI based browsers or helpers won't output such a
message onto the standard error stream.

Especialy the helper programs tend to show the corresponding error message in
a message box and wait for user input before exiting. This leaves users in
interactive console sessions without an error message in their console,
without a console prompt and without the help page they expected.

The performance cost of the additional stat should be negliggible compared to
the two or more pocesses that we spawn after the checks.

Signed-off-by: Matthias Aßhauer <mha1993@live.de>
---
 builtin/help.c  | 9 ++++++++-
 t/t0012-help.sh | 7 +++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/builtin/help.c b/builtin/help.c
index b7eec06c3de..77b1b926f60 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -467,11 +467,18 @@ static void get_html_page_path(struct strbuf *page_path, const char *page)
 	if (!html_path)
 		html_path = to_free = system_path(GIT_HTML_PATH);
 
-	/* Check that we have a git documentation directory. */
+	/*
+	 * Check that we have a git documentation directory and the page we're
+	 * looking for exists.
+	 */
 	if (!strstr(html_path, "://")) {
 		if (stat(mkpath("%s/git.html", html_path), &st)
 		    || !S_ISREG(st.st_mode))
 			die("'%s': not a documentation directory.", html_path);
+		if (stat(mkpath("%s/%s.html", html_path, page), &st)
+		    || !S_ISREG(st.st_mode))
+			die("'%s/%s.html': documentation file not found.",
+				html_path, page);
 	}
 
 	strbuf_init(page_path, 0);
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 5679e29c624..a83a59d44d9 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -77,6 +77,13 @@ test_expect_success 'generate builtin list' '
 	git --list-cmds=builtins >builtins
 '
 
+test_expect_success 'git help fails for non-existing html pages' '
+	configure_help &&
+	mkdir html-doc &&
+	touch html-doc/git.html &&
+	test_must_fail git -c help.htmlpath=html-doc help status
+'
+
 while read builtin
 do
 	test_expect_success "$builtin can handle -h" '
-- 
gitgitgadget

