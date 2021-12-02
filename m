Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70462C433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 03:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344893AbhLBD6f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 22:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344898AbhLBD6d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 22:58:33 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D541AC06174A
        for <git@vger.kernel.org>; Wed,  1 Dec 2021 19:55:11 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id p4so33400928qkm.7
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 19:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LjiJx955ZP2V7dqt5u7thbYPtiTiaCYCRLRS/UYIR28=;
        b=qCq554BeWNnQOB9IaD4dDM6/sZtt+cVN3OoBGhPIN3KUm92U+bqRCk7CB8HSso69nH
         DDMIkKkp6oIy6KkZLAxNjGAeCakInmLcfC8U092P/a1E2bd7gyhM0haKToPD4ouYT/nS
         pTetUtK0ipZ2eoHkHMC4cG64CJYCuXf71jydowLBRjApAoRfz8SyWVHsVNdsEPAVc13h
         dyf/nR0mRhZrEAubU046+mRNR8VNdZnD/TJ7dJuqAiEFeIyf4LPSYCPaMSO+oKttadsz
         K9+D7Ay3Z2etadK0ofZxgAlEIkc/ys131NanNMdsiiD7mpMQjlp1UIwkncI4E5GCnFZw
         hP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LjiJx955ZP2V7dqt5u7thbYPtiTiaCYCRLRS/UYIR28=;
        b=NMyy5vyBxVPGptSAON1YFN74N+ult/5w7qAae/u7UIn2BlWRrMxx5yfDQpap9EB7W1
         b6W/FlJBf0Zxuw2wsw77wTztpFjr4o+naaBq7JX++33LH3+3BRrqG2V2VzDyf7ZuUFke
         O4PgKdov8V1Z8Rd973TFBDHBv2FjHzelIM2Q1Y+gcIWOUPQbORImRBUvCGC2ARUZopNo
         CE5ZGOFxSzw0AmAidbtN3x8r9yyefMzFleyo4zokw1x9pxcLccykojvOz3oshQ6L193A
         8CA5jAF+ZlEsFFA/aRbwmJNk3N8st5V+FUJk3bHj/4+oIIENCVgN4/PpFsz3HdKKsJRE
         udSA==
X-Gm-Message-State: AOAM533Me/3XmZpD9MRyeF6FL8RZEAm++hMn/2vD4jFS+dSaww6x53Sz
        GHaf7M0xDAw+UNeJoEvg0RAJeI4Qtao=
X-Google-Smtp-Source: ABdhPJxxEke+RRIcjhuxfzirXfIe8O983R8iJ1WD53MrcfYF4AzUSN6OWItL0cTuDYCI2p4MgiOrtQ==
X-Received: by 2002:a37:8d86:: with SMTP id p128mr10331727qkd.706.1638417310952;
        Wed, 01 Dec 2021 19:55:10 -0800 (PST)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id q20sm881949qkl.53.2021.12.01.19.55.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Dec 2021 19:55:10 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, chris.torek@gmail.com,
        phillip.wood@dunelm.org.uk, Johannes.Schindelin@gmx.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [RFC PATCH 3/3] fixup! editor: allow for saving/restoring terminal state
Date:   Wed,  1 Dec 2021 19:54:46 -0800
Message-Id: <20211202035446.1154-4-carenas@gmail.com>
X-Mailer: git-send-email 2.34.1.460.g364565cfab
In-Reply-To: <20211202035446.1154-1-carenas@gmail.com>
References: <20211202035446.1154-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use DEFAULT_EDITOR instead of another hardcoding of "vi".

Do a minor refactoring to avoid having to call isatty(2) twice,
and while at it, a related reformatting that avoids an overlong
line.

Only check if we should enable saving/restoring the terminal if
the session is interactive.

Add documentation for the configuration variable.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
All of the commit message is meant to be thrown away once/if
this is squashed into the previous commit.

Signed-off-by could be transformed into a Helped-by if anything
could be of use here otherwise.

 Documentation/config.txt        |  2 ++
 Documentation/config/editor.txt |  8 ++++++++
 editor.c                        | 10 ++++++----
 3 files changed, 16 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/config/editor.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1167e88e34..342f3cc183 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -361,6 +361,8 @@ include::config/diff.txt[]
 
 include::config/difftool.txt[]
 
+include::config/editor.txt[]
+
 include::config/extensions.txt[]
 
 include::config/fastimport.txt[]
diff --git a/Documentation/config/editor.txt b/Documentation/config/editor.txt
new file mode 100644
index 0000000000..b65c2810fa
--- /dev/null
+++ b/Documentation/config/editor.txt
@@ -0,0 +1,8 @@
+editor.stty::
+	A boolean variable that tells git to save and restore its
+	terminal settings when the editor is invoked, to avoid
+	being affected by garbled input/output, if it misbehaves.
++
+It defaults to 'true' if your editor is "vi" (which is
+also the default if there is no `core.editor`), or to
+'false' otherwise.
diff --git a/editor.c b/editor.c
index 70d3f80966..12180039d2 100644
--- a/editor.c
+++ b/editor.c
@@ -50,7 +50,7 @@ const char *git_sequence_editor(void)
 
 static int prepare_term(const char *editor)
 {
-	int need_saverestore = !strcmp(editor, "vi");
+	int need_saverestore = !strcmp(editor, DEFAULT_EDITOR);
 
 	git_config_get_bool("editor.stty", &need_saverestore);
 	if (need_saverestore)
@@ -68,8 +68,10 @@ static int launch_specified_editor(const char *editor, const char *path,
 		struct strbuf realpath = STRBUF_INIT;
 		const char *args[] = { editor, NULL, NULL };
 		struct child_process p = CHILD_PROCESS_INIT;
-		int ret, sig, need_restore = 0;
-		int print_waiting_for_editor = advice_enabled(ADVICE_WAITING_FOR_EDITOR) && isatty(2);
+		int ret, sig, need_restore;
+		int is_interactive = isatty(2);
+		int print_waiting_for_editor = advice_enabled(ADVICE_WAITING_FOR_EDITOR) &&
+						is_interactive;
 
 		if (print_waiting_for_editor) {
 			/*
@@ -94,7 +96,7 @@ static int launch_specified_editor(const char *editor, const char *path,
 		p.env = env;
 		p.use_shell = 1;
 		p.trace2_child_class = "editor";
-		need_restore = prepare_term(editor);
+		need_restore = is_interactive ? prepare_term(editor) : 0;
 		if (start_command(&p) < 0) {
 			if (need_restore)
 				restore_term();
-- 
2.34.1.460.g364565cfab

