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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D211DC433FE
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 13:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B309160F44
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 13:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbhINN2l (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 09:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbhINN2j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 09:28:39 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909FAC061574
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 06:27:21 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id x6so20198561wrv.13
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 06:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=cwnC9KcIg95vK9hGJ5jXYpOHKhAgQYm7iiObevvzdmM=;
        b=Z6yYwRW8MVmYU0v7RUsJDsjCyXoODQotedEKyI1Fx00zi5vjfI+9GwdX/+mjysewk+
         6W+YO4uYaMKc7Zje1iOCYMKQHaBppwViIlfCKiA2leh7oUXqQ0Ye68EN2+CPgoFT64NT
         YEppn9RxYQ225LIYmYP4iyCsGmo8grSLX2xjA8Kk/x5H5PeFrxHk6xHcMJPiWnftH/1t
         3+z0Qzwhlzf2VXeHcc6Ed+MSb4B1Gt7DALICmrwR0MUmPyGPCVkwJ4tKTKrh5nulpUk9
         EFLFmei4K0fDyrS2HRhqmwBU/KaNiey3OKQsR3UHQdBQfexDP76c3if86EDimkAanh+v
         74Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=cwnC9KcIg95vK9hGJ5jXYpOHKhAgQYm7iiObevvzdmM=;
        b=x9Pfv8cejpKOljQvQ5cOAKw0vfdirenmSGG54i5P3PXcOC1gOD4pFaH28MMTCbkhs+
         mM3zrT+ztMrf/hdyk8LUABQMMOAHQnO49T6b9W8NxWaFuboa/c/P7/HIuro/HtApvgHM
         GLEa3+VyBdtB/ADJw+y9CifdLO+cFIPYnThkPiJoMJOIXDSNx0qpLPNKasFCsFCY0Sur
         VSUl3pmanc6fc766OkuDQAmD7F5BVvg63y0OulM41MaftNPP3Y6Q8TCrnHRtVQfZwguV
         4X3lSt6ibWsRZixV9nMzZxduWm1ckUorifYW4QyTH2DeK2NfHqPNbrjv1KNHAjzeeG4g
         OOaw==
X-Gm-Message-State: AOAM530bRWYx26ErNUNHxAoWWN+pVCCOc6miSbFRVeLjiLPsGuzJafJM
        n9LQ2gzBNn2LflQ/qOfWUAa65YTdtPY=
X-Google-Smtp-Source: ABdhPJy1Ty98UiC2fCa3EibdWWyF3Rc/DDXGFbE6i9S3OXAl4bSKSVf1YTPk9H0ELFNVm0pXroa7/w==
X-Received: by 2002:a05:6000:236:: with SMTP id l22mr19229635wrz.386.1631626040156;
        Tue, 14 Sep 2021 06:27:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a72sm1227665wme.5.2021.09.14.06.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 06:27:19 -0700 (PDT)
Message-Id: <c55360272d581b0629e337186482fd5a2f13f4a3.1631626038.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1038.v2.git.1631626038.gitgitgadget@gmail.com>
References: <pull.1038.git.1631531218.gitgitgadget@gmail.com>
        <pull.1038.v2.git.1631626038.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Matthias=20A=C3=9Fhauer?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Tue, 14 Sep 2021 13:27:17 +0000
Subject: [PATCH v2 1/2] help: make sure local html page exists before calling
 external processes
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
        Junio C Hamano <gitster@pobox.com>,
        Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
        =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>

We check that git.html exists, regardless of the page the user wants to open.
Checking whether the requested page exists instead gives us a smoother user
experience in two use cases:

1) The requested page doesn't exist

When calling a git command and there is an error, most users reasonably expect
git to produce an error message on the standard error stream, but in this case
we pass the filepath to git web--browse which passes it on to a browser (or a
helper program like xdg-open or start that should in turn open a browser)
without any error and many GUI based browsers or helpers won't output such a
message onto the standard error stream.

Especially the helper programs tend to show the corresponding error message in
a message box and wait for user input before exiting. This leaves users in
interactive console sessions without an error message in their console,
without a console prompt and without the help page they expected.

2) git.html is missing for some reason, but the user asked for some other page

We currently refuse to show any local html help page when we can't find
git.html. Even if the requested help page exists. If we check for the requested
page instead, we can show the user all available pages and only error out on
those that don't exist.

Signed-off-by: Matthias Aßhauer <mha1993@live.de>
---
 builtin/help.c  |  9 ++++++---
 t/t0012-help.sh | 16 ++++++++++++++++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index b7eec06c3de..7731659765c 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -467,11 +467,14 @@ static void get_html_page_path(struct strbuf *page_path, const char *page)
 	if (!html_path)
 		html_path = to_free = system_path(GIT_HTML_PATH);
 
-	/* Check that we have a git documentation directory. */
+	/*
+	 * Check that the page we're looking for exists.
+	 */
 	if (!strstr(html_path, "://")) {
-		if (stat(mkpath("%s/git.html", html_path), &st)
+		if (stat(mkpath("%s/%s.html", html_path, page), &st)
 		    || !S_ISREG(st.st_mode))
-			die("'%s': not a documentation directory.", html_path);
+			die("'%s/%s.html': documentation file not found.",
+				html_path, page);
 	}
 
 	strbuf_init(page_path, 0);
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 5679e29c624..913f34c8e9d 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -73,6 +73,22 @@ test_expect_success 'git help -g' '
 	test_i18ngrep "^   tutorial   " help.output
 '
 
+test_expect_success 'git help fails for non-existing html pages' '
+	configure_help &&
+	mkdir html-empty &&
+	test_must_fail git -c help.htmlpath=html-empty help status &&
+	test_must_be_empty test-browser.log
+'
+
+test_expect_success 'git help succeeds without git.html' '
+	configure_help &&
+	mkdir html-with-docs &&
+	touch html-with-docs/git-status.html &&
+	git -c help.htmlpath=html-with-docs help status &&
+	echo "html-with-docs/git-status.html" >expect &&
+	test_cmp expect test-browser.log
+'
+
 test_expect_success 'generate builtin list' '
 	git --list-cmds=builtins >builtins
 '
-- 
gitgitgadget

