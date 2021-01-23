Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF11AC433DB
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 10:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8528422D57
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 10:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbhAWKVC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 05:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbhAWKUz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 05:20:55 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85EBC0613D6
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 02:20:14 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 190so6367343wmz.0
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 02:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kPgsaWzV5sqEw1r+RZ/XT7NfFzjA8YUBmDw8xNE/MVk=;
        b=Kk1RWt1Jk2FRdXIVk6GP9hfOJ22YOKU6N5hKy1xCgSTEFt+e5bBgV9elFHq5Fp51Gf
         Kcjr7cQz6OQkjxboCFMQB9akunuwZ31g2F3MjJL5pYblHEX3DNtCWujiFq9gOWnf+T0j
         0JCxT8WMzPwpLXZ4BA+bCCm3MMfEGfk+Zdx0rbsLvPeLBb+WTQFOtMNdk40KMIT2MrDO
         73TGsxw0bXr99BURQuTlszvA2n0xjPE9feGf8JDYPPyhD5DtXnMTYdaM3zlc4Qk+Vnlw
         xzGXd2xAAa9/rrFW43EBpeBIlQbYJSFjw/T5jwLzk6+yGDDH+87ZLiSzalJCibOmWXbw
         P1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kPgsaWzV5sqEw1r+RZ/XT7NfFzjA8YUBmDw8xNE/MVk=;
        b=dM7orN1mOmgbI1zjPVjFqy4FKZhvjLrGFF7oWh98L/R3h0jqReajpF7P5b7A4aoKvg
         FWNVV4yTwsR5IDUKc/xKalZvsEyLR60tND2qlpA9pW4KmPVSm7NHQCqwcNNfQBNotIos
         xXYqsrwflm4kW7KmnjlXieO55myvpWsjkBS5OR9imMZ5InSRQnI+dZl6XG4gAbG7LpFn
         XipMahWSPkUshFj10V4b5+JrtLDVDaNDugNaOLqx5AYlU0pV7sGM+cR9KLyPwRjvafOs
         J1m196iDKkOM5AUcoT+tJAClAOfqrbXCGh0BvpF26d/n2y5WF+isa4LyUCoYToHornrz
         XnBw==
X-Gm-Message-State: AOAM533iGDB8pAHlkWej729UxLmA4gSzaTB2CaSdyeSm/yybdH6R6663
        74HkPoqy26z0FLWKVM5a5wjQZMv6d+Y=
X-Google-Smtp-Source: ABdhPJzJwOuvs/Bbtwq46um4SVSPs770ezAaYw4hmtJcIXI8fDRtbYMidI5XhNTw7yUrDxysH1dQdQ==
X-Received: by 2002:a1c:5a54:: with SMTP id o81mr7731866wmb.50.1611397213114;
        Sat, 23 Jan 2021 02:20:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g187sm14852615wmf.1.2021.01.23.02.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 02:20:12 -0800 (PST)
Message-Id: <fbc38ce9075d3d28187351b0fb6b34a27ec431fd.1611397210.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.832.v6.git.1611397210.gitgitgadget@gmail.com>
References: <pull.832.v5.git.1611037846.gitgitgadget@gmail.com>
        <pull.832.v6.git.1611397210.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 23 Jan 2021 10:20:08 +0000
Subject: [PATCH v6 1/3] ls_files.c: bugfix for --deleted and --modified
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=E8=83=A1=E5=93=B2=E5=AE=81?= <adlternative@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88?= <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

This situation may occur in the original code: lstat() failed
but we use `&st` to feed ie_modified() later.

Therefore, we can directly execute show_ce without the judgment of
ie_modified() when lstat() has failed.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/ls-files.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index c8eae899b82..1e264bd1329 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -335,7 +335,7 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 		for (i = 0; i < repo->index->cache_nr; i++) {
 			const struct cache_entry *ce = repo->index->cache[i];
 			struct stat st;
-			int err;
+			int stat_err;
 
 			construct_fullname(&fullname, repo, ce);
 
@@ -346,11 +346,14 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 				continue;
 			if (ce_skip_worktree(ce))
 				continue;
-			err = lstat(fullname.buf, &st);
-			if (show_deleted && err)
+			stat_err = lstat(fullname.buf, &st);
+			if (stat_err && (errno != ENOENT && errno != ENOTDIR))
+				error_errno("cannot lstat '%s'", fullname.buf);
+			if (stat_err && show_deleted)
 				show_ce(repo, dir, ce, fullname.buf, tag_removed);
-			if (show_modified && ie_modified(repo->index, ce, &st, 0))
-				show_ce(repo, dir, ce, fullname.buf, tag_modified);
+			if (show_modified &&
+				(stat_err || ie_modified(repo->index, ce, &st, 0)))
+					show_ce(repo, dir, ce, fullname.buf, tag_modified);
 		}
 	}
 
-- 
gitgitgadget

