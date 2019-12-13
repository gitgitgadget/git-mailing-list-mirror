Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C10C2D0BF
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95DE32467A
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwMmoiaG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfLMIIM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 03:08:12 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37837 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfLMIIM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 03:08:12 -0500
Received: by mail-wr1-f67.google.com with SMTP id w15so5618194wru.4
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 00:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WjSHLmTjBYyz9S1qv/kniGfV3/zKvBryGHZwD207f6o=;
        b=GwMmoiaGx97oRXzgRmFykr4sfyXy8WNDYozs93M689hNZiT47bVa5ZyWjjdrkxeffw
         QL7fP1hoiCI9KHWRpY/mXx3IDyIWsTAv53TVBzMDr75AmVR3lN4MEwLB53NKhF+oF/TA
         3XWfOSqUluv7zxy05uApfFZFd1YLIa9+1szqycaFmo0rD8hxlGVOQ3dcU8PH8Jqe9+c9
         5MbwYArJs9BWPwi55h6qqmaPV5vT/5+D21l2c0yB4gyEt8F2RDfaAn8kFArRhC4sO2Gy
         nBGbZr7sTgODApFhpPt+VBksxxUzZgIFb5smjmW9tu8seoFL2DzuFXII3rkQwlqZc/NU
         xoXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WjSHLmTjBYyz9S1qv/kniGfV3/zKvBryGHZwD207f6o=;
        b=RK8c32EPH8IclfPuuz+Rkz1CnGVrrI3SIsQzNQTUah/Un/O/RAxSfR9c3DxFVMhTS0
         DtGjOhDza5HhpjDyNz0ogVkqOFp9Vbh7RqgwxsI7KKuMMAJy4Ee6YjI78lpBN18+9dCl
         riJ4lIxIZ5mJqYk45/KnTrnatgUrVCOLIjT2yqxecYFWH4LvUtGwao1TCnh3WoQekqW1
         zteofcLPKNsr/DKZGTvjfgQ4J7SIb45TPwOCifqj9XAfGMONaxfqhUN7+tsz7L2OrOPk
         5s1gMvctmzUviXBjPbL9PPVICjZy6rtaDhsPOwufGXAq7lVhCdiHuTQRkmO7PFFa8JDo
         MdWg==
X-Gm-Message-State: APjAAAV8zONaXU+PqiXBYfL6h3lhISDgcYh5SIogI7HKAuK6PWm1WAsf
        Dgkb6yjlwSKXio3z1h9d0EKrf1oq
X-Google-Smtp-Source: APXvYqwFt/SnN3l4XKiDWkq8Cmn0Y+QUHhEiXxuWLMZtY8a3EuE/6ozZqcI/F/PEBQDL/bx6RVVu8A==
X-Received: by 2002:adf:cd03:: with SMTP id w3mr10763641wrm.191.1576224489613;
        Fri, 13 Dec 2019 00:08:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i11sm9276339wrs.10.2019.12.13.00.08.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 00:08:09 -0800 (PST)
Message-Id: <03feb2f28bbfb4779afb4a26009cc30c939f0436.1576224486.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.173.git.1576224486.gitgitgadget@gmail.com>
References: <pull.173.git.1576224486.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Dec 2019 08:07:49 +0000
Subject: [PATCH 02/19] built-in add -i: wire up the new C code for the `patch`
 command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The code in `git-add--interactive.perl` that takes care of the `patch`
command can look quite intimidating. There are so many modes in which it
can be called, for example.

But for the `patch` command in `git add -i`, only one mode is relevant:
the `stage` mode. And we just implemented the beginnings of that mode in
C so far. So let's use it when `add.interactive.useBuiltin=true`.

Now, while the code in `add-patch.c` is far from reaching feature parity
with the code in `git-add--interactive.perl` (color is not implemented,
the diff algorithm cannot be configured, the colored diff cannot be
post-processed via `interactive.diffFilter`, many commands are
unimplemented yet, etc), hooking it all up with the part of `git add -i`
that is already converted to C makes it easier to test and develop it.

Note: at this stage, both the `add.interactive.useBuiltin` config
setting is still safely opt-in, and will probably be fore quite some
time, to allow for thorough testing "in the wild" without adversely
affecting existing users.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index f395d54c08..034c1dc02f 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -917,15 +917,18 @@ static int run_patch(struct add_i_state *s, const struct pathspec *ps,
 	count = list_and_choose(s, files, opts);
 	if (count >= 0) {
 		struct argv_array args = ARGV_ARRAY_INIT;
+		struct pathspec ps_selected = { 0 };
 
-		argv_array_pushl(&args, "git", "add--interactive", "--patch",
-				 "--", NULL);
 		for (i = 0; i < files->items.nr; i++)
 			if (files->selected[i])
 				argv_array_push(&args,
 						files->items.items[i].string);
-		res = run_command_v_opt(args.argv, 0);
+		parse_pathspec(&ps_selected,
+			       PATHSPEC_ALL_MAGIC & ~PATHSPEC_LITERAL,
+			       PATHSPEC_LITERAL_PATH, "", args.argv);
+		res = run_add_p(s->r, &ps_selected);
 		argv_array_clear(&args);
+		clear_pathspec(&ps_selected);
 	}
 
 	return res;
-- 
gitgitgadget

