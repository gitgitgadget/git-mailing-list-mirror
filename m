Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6B1820248
	for <e@80x24.org>; Mon, 25 Feb 2019 23:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbfBYXQ5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 18:16:57 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35318 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbfBYXQz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 18:16:55 -0500
Received: by mail-wm1-f66.google.com with SMTP id y15so576316wma.0
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 15:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JlD68eCgrUfwauFpzHbRnXcwN5b8qnBUaZwPTeb7llI=;
        b=FAXnub9rWXa4AYfPADm22S7DtdyU5ujFmgpEcOultojeF490fGXxqjsO73T4J4AXHK
         ZUfeh0Sg+07zt1314lstII1uWEY+04yxflZIkS9V7p9h3TAf/ovqmo1AUfwULEY1Oouu
         qpZj4BCZkr6hfGphw62OgmlteGH4H3BeNHPi/O7teuuHiD/LPwgcOBS/9xXHvFd+JEDf
         SVa+NxqwRXxRErQoNxClg+7yirOGTAvMsgsoMytyX44KMcDMjt/EMbuwAZiyUr/ig08z
         y82NIXqBnjVny9gCbmOnf5rwrdJMA9KsQ/PF+AQFfY3rNay0Yk1nYV4ubtGFq6YV8BOZ
         eHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JlD68eCgrUfwauFpzHbRnXcwN5b8qnBUaZwPTeb7llI=;
        b=mJfdF/90UvUAZ9rmLe3seaXdvFzehj602FulxBlKzI9GEEb1kouJkY+0p/suPx6kHQ
         SwkJYuiDjvKyQ1kUiU/3Jopw3PXMO9sL9psDe0fVxuUXeLCISBhKYaSY9iwXuTRJLQaX
         8Am/Tm6NLsY1/if7ODW0ooHQ1AgTKFo0H5djC2p0GIRk6uf59pANjtn4iHPMbVJ0OMxG
         dW7NzARNruSZX0QhUNeQkcpcyTr1gxHYvPJgi4/bDq4cvOAnH6jMp3IQCiYxan41Sh+J
         5S+V0Nxyl0sQZWVLn4ZJ5rIiFlLOHWrRV8swVR5i0PPDkYY3WubFbt5doAgyHisGqCMC
         7Qbg==
X-Gm-Message-State: AHQUAuYHzovovfQYAP7lt++7nBaM4H7lZpqN1Bgl+EJnsO4yWwWVquFV
        7LqlZHYW7AckGXMtM0w36JB/De8U
X-Google-Smtp-Source: AHgI3Ibw4Gbmd854a7Ww8MT/eaXlLiuIhKbDEGKal2fprZlMilDy4HyhdN9FEP62ALWbzoqpyo25Kw==
X-Received: by 2002:a1c:9aca:: with SMTP id c193mr668721wme.2.1551136612237;
        Mon, 25 Feb 2019 15:16:52 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id j13sm105876wrx.74.2019.02.25.15.16.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 15:16:51 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v13 04/27] ident: add the ability to provide a "fallback identity"
Date:   Mon, 25 Feb 2019 23:16:08 +0000
Message-Id: <20190225231631.30507-5-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.291.g17236886c5
In-Reply-To: <20190225231631.30507-1-t.gummerer@gmail.com>
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
 <20190225231631.30507-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 3bc2111fc2e9 (stash: tolerate missing user identity, 2018-11-18),
`git stash` learned to provide a fallback identity for the case that no
proper name/email was given (and `git stash` does not really care about
a correct identity anyway, but it does want to create a commit object).

In preparation for the same functionality in the upcoming built-in
version of `git stash`, let's offer the same functionality as an API
function.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
[tg: add docs; make it a bug to call the function before other
functions in the ident API]
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 cache.h |  5 +++++
 ident.c | 22 ++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/cache.h b/cache.h
index 7b6b89fc4c..611e554dea 100644
--- a/cache.h
+++ b/cache.h
@@ -1491,6 +1491,11 @@ extern const char *git_sequence_editor(void);
 extern const char *git_pager(int stdout_is_tty);
 extern int is_terminal_dumb(void);
 extern int git_ident_config(const char *, const char *, void *);
+/*
+ * Prepare an ident to fall back on if the user didn't configure it.
+ * Must be called before any other function from the ident API.
+ */
+void prepare_fallback_ident(const char *name, const char *email);
 extern void reset_ident_date(void);
 
 struct ident_split {
diff --git a/ident.c b/ident.c
index 33bcf40644..f30bd623f0 100644
--- a/ident.c
+++ b/ident.c
@@ -505,6 +505,28 @@ int git_ident_config(const char *var, const char *value, void *data)
 	return 0;
 }
 
+static void set_env_if(const char *key, const char *value, int *given, int bit)
+{
+	if (*given & bit)
+		BUG("%s was checked before prepare_fallback got called", key);
+	if (getenv(key))
+		return; /* nothing to do */
+	setenv(key, value, 0);
+	*given |= bit;
+}
+
+void prepare_fallback_ident(const char *name, const char *email)
+{
+	set_env_if("GIT_AUTHOR_NAME", name,
+		   &author_ident_explicitly_given, IDENT_NAME_GIVEN);
+	set_env_if("GIT_AUTHOR_EMAIL", email,
+		   &author_ident_explicitly_given, IDENT_MAIL_GIVEN);
+	set_env_if("GIT_COMMITTER_NAME", name,
+		   &committer_ident_explicitly_given, IDENT_NAME_GIVEN);
+	set_env_if("GIT_COMMITTER_EMAIL", email,
+		   &committer_ident_explicitly_given, IDENT_MAIL_GIVEN);
+}
+
 static int buf_cmp(const char *a_begin, const char *a_end,
 		   const char *b_begin, const char *b_end)
 {
-- 
2.21.0.rc2.291.g17236886c5

