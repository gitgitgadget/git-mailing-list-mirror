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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BD8C433FE
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF06E60F45
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346617AbhIGVGv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 17:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346774AbhIGVGf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 17:06:35 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB63FC0613A3
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 14:05:21 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d6so15760807wrc.11
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 14:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZU06gQXdfdudnIoInZNAOlMb4q+9bsmuW+4ApOrgzD8=;
        b=Nz+ZdoauQ+JQs0DTCf/3CaJeY6TjrKSQipHKF2oC85+jsmALuc/i6DBIKAK4tZljQ4
         ujiLyyR0+XjWGf10vLuEYPs9mRqjsBOWDw1E1HJOGrFHz8QGlOn8pyz3EYdMyc0OKTeE
         Z1mDNaWM5AMy6VtEN9PUbvy3BkSSqQWaT7n3mSLi5x3XBuMGwBYIalGk8mOWGvalXfYd
         zbhMqOpEx2hOEy2hy72GEms0NLARJNd41IT7Nh509FKJ17RnaI4IXCKhd92USs1Ev+Y8
         aX6Ko5VZ1aozDKHKW2P3gei0OIFEsM8f0JJlF+tWug7QRgGozfndqF60m9Ogxp4+ZspR
         Poug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZU06gQXdfdudnIoInZNAOlMb4q+9bsmuW+4ApOrgzD8=;
        b=hxHRTKwkA3byKdmYuW8yyF/V/apyfS6H1pKruJQ079lNwCjPkjyxE65uXJqiTyeulQ
         4LyIs3LahH4EadMNiYVhOgwf9J83vi5GEWzuruXugAdR13F0C950gNeBW+jfczhiL7pi
         KIGfF0KRk9R6Lex4VlmVZgqlEe8s/kyKd3Jl1YHOFnVAOte46kfREXWbbXoilmkjNCZp
         U9U2eyPWfNGUX8UfsSXVUjGU26koiFPXzvtfHVGzY9hzTwTy5J1amslio4ypOxY9ClM8
         r9ziyzP5WJVudQnToOtO8VaBbtt0PqzNhnriJJl3EpXho3a6Wmmr79gQIkMVICvbg9GM
         iB4Q==
X-Gm-Message-State: AOAM531HcswNUdLHNm+Yn7w2OhnIXHXjOjacEK02uVvOYm/3ayON38mk
        9VBmClv0Rkcwex7G1kmod77Q+qrL5fA=
X-Google-Smtp-Source: ABdhPJxQdlX6YNTXrRQxy1nKi80HTuabmOVFeKoOiaeCpRQiFdGs80NX7Y1J15A3uaMYGC8JmdAvIg==
X-Received: by 2002:a5d:526a:: with SMTP id l10mr318141wrc.279.1631048720380;
        Tue, 07 Sep 2021 14:05:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j20sm115153wrb.5.2021.09.07.14.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 14:05:20 -0700 (PDT)
Message-Id: <5bb04ea3f6c02c611e197d966919de351981a25a.1631048713.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.195.v3.git.1631048712.gitgitgadget@gmail.com>
References: <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
        <pull.195.v3.git.1631048712.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Sep 2021 21:05:11 +0000
Subject: [PATCH v3 10/11] rebase: remove a no-longer-used function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Wong <e@80x24.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

With the `--preserve-merges` option going away, we no longer need this
function.

Helped-by: Alban Gruin <alban.gruin@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 rebase-interactive.c | 29 -----------------------------
 rebase-interactive.h |  2 --
 2 files changed, 31 deletions(-)

diff --git a/rebase-interactive.c b/rebase-interactive.c
index b6cbd16a17f..87649d0c016 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -226,32 +226,3 @@ int todo_list_check_against_backup(struct repository *r, struct todo_list *todo_
 	todo_list_release(&backup);
 	return res;
 }
-
-int check_todo_list_from_file(struct repository *r)
-{
-	struct todo_list old_todo = TODO_LIST_INIT, new_todo = TODO_LIST_INIT;
-	int res = 0;
-
-	if (strbuf_read_file(&new_todo.buf, rebase_path_todo(), 0) < 0) {
-		res = error(_("could not read '%s'."), rebase_path_todo());
-		goto out;
-	}
-
-	if (strbuf_read_file(&old_todo.buf, rebase_path_todo_backup(), 0) < 0) {
-		res = error(_("could not read '%s'."), rebase_path_todo_backup());
-		goto out;
-	}
-
-	res = todo_list_parse_insn_buffer(r, old_todo.buf.buf, &old_todo);
-	if (!res)
-		res = todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo);
-	if (res)
-		fprintf(stderr, _(edit_todo_list_advice));
-	if (!res)
-		res = todo_list_check(&old_todo, &new_todo);
-out:
-	todo_list_release(&old_todo);
-	todo_list_release(&new_todo);
-
-	return res;
-}
diff --git a/rebase-interactive.h b/rebase-interactive.h
index dc2cf0ee122..7239c60f791 100644
--- a/rebase-interactive.h
+++ b/rebase-interactive.h
@@ -16,6 +16,4 @@ int todo_list_check(struct todo_list *old_todo, struct todo_list *new_todo);
 int todo_list_check_against_backup(struct repository *r,
 				   struct todo_list *todo_list);
 
-int check_todo_list_from_file(struct repository *r);
-
 #endif
-- 
gitgitgadget

