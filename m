Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB383C433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 15:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9C4620885
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 15:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jr0W3qh5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgHSPPw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbgHSPPl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 11:15:41 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C44C061757
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 08:15:40 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y3so21923485wrl.4
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 08:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8uRCAD9q+TM2zdKzW5N0kAF5kVOzr2yaYA41ahA4GQo=;
        b=jr0W3qh51ubzM+aaS2GdxmqxqRb6yTPJxRjOqJ9kO1zwNTa17kMqZZ2m05y6oGUOn4
         ZT6ABI6s6MKa66xX42aZiume6mNq2t1YZCTEP4p4aBJJwrYNHOk0EyOdz8Pdl6ajwiIB
         +GVvksxoYrj0upJUZWIiobl8munqtBEPjadUeRckPARnfkXvnlkQlLP4vtqBvrd+xWX8
         vl8f7Jz6p4MwNFSKoYaL3T7KF7WOJv3rI7Qrmpq649zuCryEbqxV5wSQloiX0+30mS5s
         SsNe5Y669qIk+NoYKR3TATjPjC6UUVKJ3/pFcdllTf/GgsZMxhshyY+NBOv09O9JKtCF
         Tukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8uRCAD9q+TM2zdKzW5N0kAF5kVOzr2yaYA41ahA4GQo=;
        b=ulpzNqQEntk504nBZYZqKi1yyFmxF0UV1pHK+x9wiY7qpjHXFDBloPq9sJr+p5JgWi
         yvAtguPCyynxrTiSAasZiRFITMSJTMmYfzNJgms1HlSOpdl/X9TgwQWKZk/gkmoxv9qs
         uTKUYcXVGyVfTjT5dK9c8F5gy4TrCLihXDWCxlGEcRIG80F+izqaDv5aDcy00qTlsR/f
         DX60XIMZvAtpEYrP8mII711bfPIXpgzd+DgeFr+Tk/sM7B2tXB/8kxqO4mXu72XAd92x
         HXCr6QtDm55xho/AbnM0fxF2QWXZfwtI9Zp5ji7Fro7iR6/iIE8b1PgQM7uBS3y46mJ6
         uQIg==
X-Gm-Message-State: AOAM531n2NLuGe/qAJEHoWMbTVjbM1lp5/3sYhAdeqknuDs3tYWHCEmZ
        90IMd+TzbdDe7WTeUbYcnw6gDiWnPHg=
X-Google-Smtp-Source: ABdhPJwQaCKUpyecL6/Y7R2f+AHcSoCqGDAgI1ErO2VBK6ULnZ96iJ0Q4ImCeG5iE1IjROIHeCJMSA==
X-Received: by 2002:adf:9ec1:: with SMTP id b1mr25253646wrf.171.1597850135686;
        Wed, 19 Aug 2020 08:15:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j11sm38688195wrq.69.2020.08.19.08.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 08:15:34 -0700 (PDT)
Message-Id: <2681638651debf267bbe7e45e41decca5852808b.1597850128.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.706.v2.git.1597850128.gitgitgadget@gmail.com>
References: <pull.706.git.1597753075.gitgitgadget@gmail.com>
        <pull.706.v2.git.1597850128.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 19 Aug 2020 15:15:26 +0000
Subject: [PATCH v2 3/4] builtin/commit: suggest update-ref for pseudoref
 removal
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

When pseudorefs move to a different ref storage mechanism, pseudorefs no longer
can be removed with 'rm'. Instead, suggest a "update-ref -d" command, which will
work regardless of ref storage backend.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 builtin/commit.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 69ac78d5e5..a4e5e395ba 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -844,24 +844,24 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		struct ident_split ci, ai;
 
 		if (whence != FROM_COMMIT) {
+			const char *pseudoref = (whence == FROM_MERGE) ?
+							      "MERGE_HEAD" :
+							      "CHERRY_PICK_HEAD";
+			const char *what = (whence == FROM_MERGE) ?
+							 "merge" :
+							 "cherry-pick";
+
 			if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS &&
 				!merge_contains_scissors)
 				wt_status_add_cut_line(s->fp);
-			status_printf_ln(s, GIT_COLOR_NORMAL,
-			    whence == FROM_MERGE
-				? _("\n"
-					"It looks like you may be committing a merge.\n"
-					"If this is not correct, please remove the file\n"
-					"	%s\n"
-					"and try again.\n")
-				: _("\n"
-					"It looks like you may be committing a cherry-pick.\n"
-					"If this is not correct, please remove the file\n"
-					"	%s\n"
-					"and try again.\n"),
-				whence == FROM_MERGE ?
-					git_path_merge_head(the_repository) :
-					git_path_cherry_pick_head(the_repository));
+			status_printf_ln(
+				s, GIT_COLOR_NORMAL,
+				_("\n"
+				  "It looks like you may be committing a %s.\n"
+				  "If this is not correct, please remove %s with\n"
+				  "	git update-ref -d %s\n"
+				  "and try again.\n"),
+				what, pseudoref, pseudoref);
 		}
 
 		fprintf(s->fp, "\n");
-- 
gitgitgadget

