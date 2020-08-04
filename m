Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE26C433E0
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 00:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CAA82076E
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 00:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yf0EoU+J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgHDAVF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 20:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728391AbgHDAVE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 20:21:04 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A954C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 17:21:04 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 184so1224438wmb.0
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 17:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4ym1IzoRp2NjrKCQfPSxjzCBmGas+7GV3dRMTATrHus=;
        b=Yf0EoU+JHgQESXCNmIxB39nCOh9hTpCpIfovU1fCJSuu0z5m5TKr4mMpiyhmrRMvY+
         T0b7xRj9gRUXh3XvFqotj+TAeWDl8299qx27zz/pnNn7VgfY+MCe/FG8cpO8E1SLJ7hf
         g5J1t3BYPjU/TeYe+x0YYNNXfrax0RgARRNcWli9475kz/D7ZV+fFCsKmRrMi4QNeC7G
         1HgQ0J/jGqIl65aewjKxPBfukKEPLpePiGOkHfHzXuEpWo3a1oY1+lQQVJq30rxrSuEu
         QVXijCmOnn0cU5B5DJSKs2LAcRi1E70Hgd4ElYR52fvdAaOtWLyq5lCe2Gg8wkjcN5R8
         GwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4ym1IzoRp2NjrKCQfPSxjzCBmGas+7GV3dRMTATrHus=;
        b=gkrzJLQwLIEug9G04EnRfxErkBciXIoVWNbdx5FBFRc0/PxVlr96UwHk/O/bwNI7D9
         TOfy+V0oZRfkyWcpyiAqzy4e/M/gcwYmCH/yj/B5RzucsETsBu7a2joOcPY4NsO+bCq7
         vWTXoEo7FgXV+1ChZhHy0QtSbXfYrKE4GF92m2fXpohYR5IfcESovVNtSy1zJr7aU/Cf
         DEy3QIwruTb6K89lTcl7W/Sa8Xy2bElXvmCp4DCDpJQOmSMhmEeurhLyiGJScdFlXQ+o
         uipOciePPjALM59Ve1ncnXbd1NZB2HallIRYpF0TN3Mck68cMKZHOJDLkpIOKbYq73L4
         ZkEw==
X-Gm-Message-State: AOAM531aw/4m6YNQrpneCM82P6TWTfkR6FwJzdur0gtY6WGEljy+wA5R
        o2Bkec6xv+QmM5ib+EGm33l+U+je
X-Google-Smtp-Source: ABdhPJzdkzVfSw4UW5qW0e50t7WsLoCi8eQ6jgscuRqvLuVk0yYj7Px8mUUlobBMlK8Rf1UToc+Vbw==
X-Received: by 2002:a1c:f70e:: with SMTP id v14mr1455603wmh.74.1596500462859;
        Mon, 03 Aug 2020 17:21:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k4sm30497062wrd.72.2020.08.03.17.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 17:21:02 -0700 (PDT)
Message-Id: <f49cf08f4f61d667633465903111675dd33e56e9.1596500460.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.691.v2.git.1596500459.gitgitgadget@gmail.com>
References: <pull.691.git.1596381647.gitgitgadget@gmail.com>
        <pull.691.v2.git.1596500459.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Aug 2020 00:20:58 +0000
Subject: [PATCH v2 2/3] help: drop usage of 'common' and 'useful' for guides
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>, Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Since 1b81d8cb19 (help: use command-list.txt for the source of guides,
2018-05-20), all man5/man7 guides listed in command-list.txt appear in
the output of 'git help -g'.

However, 'git help -g' still prefixes this list with "The common Git
guides are:", which makes one wonder if there are others!

In the same spirit, the man page for 'git help' describes the '--guides'
option as listing 'useful' guides, which is not false per se but can
also be taken to mean that there are other guides that exist but are not
useful.

Instead of 'common' and 'useful', use 'Git concept guides' in both
places. To keep the code in line with this change, rename
help.c::list_common_guides_help to list_guides_help.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/git-help.txt | 6 +++---
 builtin/help.c             | 2 +-
 help.c                     | 4 ++--
 help.h                     | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 69c0c5c34e..44fe8860b3 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -21,8 +21,8 @@ on the standard output.
 If the option `--all` or `-a` is given, all available commands are
 printed on the standard output.
 
-If the option `--guides` or `-g` is given, a list of the useful
-Git guides is also printed on the standard output.
+If the option `--guides` or `-g` is given, a list of the
+Git concept guides is also printed on the standard output.
 
 If a command, or a guide, is given, a manual page for that command or
 guide is brought up. The 'man' program is used by default for this
@@ -58,7 +58,7 @@ OPTIONS
 
 -g::
 --guides::
-	Prints a list of useful guides on the standard output. This
+	Prints a list of the Git concept guides on the standard output. This
 	option overrides any given command or guide name.
 
 -i::
diff --git a/builtin/help.c b/builtin/help.c
index 299206eb57..bb339f0fc8 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -579,7 +579,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	}
 
 	if (show_guides)
-		list_common_guides_help();
+		list_guides_help();
 
 	if (show_all || show_guides) {
 		printf("%s\n", _(git_more_info_string));
diff --git a/help.c b/help.c
index 44cee69c11..d478afb2af 100644
--- a/help.c
+++ b/help.c
@@ -397,10 +397,10 @@ void list_cmds_by_config(struct string_list *list)
 	}
 }
 
-void list_common_guides_help(void)
+void list_guides_help(void)
 {
 	struct category_description catdesc[] = {
-		{ CAT_guide, N_("The common Git guides are:") },
+		{ CAT_guide, N_("The Git concept guides are:") },
 		{ 0, NULL }
 	};
 	print_cmd_by_category(catdesc, NULL);
diff --git a/help.h b/help.h
index 500521b908..dc02458855 100644
--- a/help.h
+++ b/help.h
@@ -21,7 +21,7 @@ static inline void mput_char(char c, unsigned int num)
 
 void list_common_cmds_help(void);
 void list_all_cmds_help(void);
-void list_common_guides_help(void);
+void list_guides_help(void);
 
 void list_all_main_cmds(struct string_list *list);
 void list_all_other_cmds(struct string_list *list);
-- 
gitgitgadget

