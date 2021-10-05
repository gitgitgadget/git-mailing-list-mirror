Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607FEC433FE
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 07:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3533A610FC
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 07:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbhJEHsx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 03:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbhJEHsw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 03:48:52 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D895C061745
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 00:47:02 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id f130so18976349qke.6
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 00:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nOrp5ZTPPQdxtudpsovyCRa1xu2IRcZLByex6oagzQE=;
        b=i1DKWaBCw5DBbUaLNk4axqoa7ITpIxsH71MwCxiAjiec7OCoAgpriFf4U7fLLur+gi
         LJ1HZdeyt67eXgVNLG8RaOjix9s/3LIFu2oSKuIpkn+ROj3qaxoJXgQNTkbx0Xy6xTO5
         t8Mk/qLwnaaSywXpKjyYlz2ooEIZrp9FE8ZCeHeQH7IL5gJexfQtVdkJbRccEPB+DZBk
         yQCdcZPLqPkZH+bjd8WmnEVby6cCmQnIBj93SDjwsnXA1/rQARpodDJITwYTAfQJ33r6
         0YhNGyjD/EUrUkHcWusbayueiXhqyOs14W6d0kll2DtdgbyjJXqO9oY+0BgrAbPRyeIO
         6eWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nOrp5ZTPPQdxtudpsovyCRa1xu2IRcZLByex6oagzQE=;
        b=ELaZEDp07FHr/CHf4b8iTG7CtXRlOWFVvGl2YASSL9aLqG8VvH2v7lOp7cRS0k432v
         S+MKKZ8s9GYEXwIiUD3+z2e5LYUDFLExT6FrKsgdTsgVJQkM9hPPLWdyNquiRGm12uB2
         yE5t4awm/HDjhotvNw9NtibfTWY/+X8NlNWBxQ8w9nJpvEdH69Rdl/Npi+29dR9kuaqW
         ODLsMYiZF8udrBmef2tVZMBxjf8YaHNJbVrqcmmO2Tyrqk0ecKZx/I7NwKlQjkNQFyJ/
         sA30tWYiIJvQLMwgWNt69YyJP19kfY201L/U+1cQnomtU+YGsF7nz0gcXQoF/WtWuwfX
         ZN6g==
X-Gm-Message-State: AOAM533nBVm6xLS6CGBd+6h9+vFOrzdS01yu4cF5Wvhh+Oxjcr3I4twt
        uhZyQgkFUbSsFsfp5MEdZFMeIHPFgb7s0w==
X-Google-Smtp-Source: ABdhPJymX9EUzjR6JvAnfcQkTHy5XAYFe91ANoMJ1ODrOHDR1XxWw0g8+/ADJF/CnV5r1qo2T6Hneg==
X-Received: by 2002:a37:7d7:: with SMTP id 206mr13775072qkh.432.1633420021103;
        Tue, 05 Oct 2021 00:47:01 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id c16sm8779285qkk.113.2021.10.05.00.47.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Oct 2021 00:47:00 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2 2/2] editor: save and reset terminal after calling EDITOR
Date:   Tue,  5 Oct 2021 00:46:48 -0700
Message-Id: <20211005074648.86032-3-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.955.gee03ddbf0e
In-Reply-To: <20211005074648.86032-1-carenas@gmail.com>
References: <20211004072600.74241-1-carenas@gmail.com>
 <20211005074648.86032-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When EDITOR is invoked to modify a commit message, it will likely
change the terminal settings, and if it misbehaves will leave the
terminal output damaged as shown in a recent report from Windows
Terminal[1]

Instead use the functions provided by compat/terminal to save the
settings and recover safely.

[1] https://github.com/microsoft/terminal/issues/9359

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 editor.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/editor.c b/editor.c
index 6303ae0ab0..be7441e7e0 100644
--- a/editor.c
+++ b/editor.c
@@ -3,6 +3,7 @@
 #include "strbuf.h"
 #include "run-command.h"
 #include "sigchain.h"
+#include "compat/terminal.h"
 
 #ifndef DEFAULT_EDITOR
 #define DEFAULT_EDITOR "vi"
@@ -50,6 +51,8 @@ const char *git_sequence_editor(void)
 static int launch_specified_editor(const char *editor, const char *path,
 				   struct strbuf *buffer, const char *const *env)
 {
+	int term_fail;
+
 	if (!editor)
 		return error("Terminal is dumb, but EDITOR unset");
 
@@ -83,7 +86,10 @@ static int launch_specified_editor(const char *editor, const char *path,
 		p.env = env;
 		p.use_shell = 1;
 		p.trace2_child_class = "editor";
+		term_fail = save_term(1);
 		if (start_command(&p) < 0) {
+			if (!term_fail)
+				restore_term();
 			strbuf_release(&realpath);
 			return error("unable to start editor '%s'", editor);
 		}
@@ -91,6 +97,8 @@ static int launch_specified_editor(const char *editor, const char *path,
 		sigchain_push(SIGINT, SIG_IGN);
 		sigchain_push(SIGQUIT, SIG_IGN);
 		ret = finish_command(&p);
+		if (!term_fail)
+			restore_term();
 		strbuf_release(&realpath);
 		sig = ret - 128;
 		sigchain_pop(SIGINT);
-- 
2.33.0.955.gee03ddbf0e

