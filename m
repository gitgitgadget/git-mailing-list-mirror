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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D028C433E0
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 19:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4133E23110
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 19:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732192AbhAST60 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 14:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392258AbhASTz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 14:55:58 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB87C06179C
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 11:54:10 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id c127so821678wmf.5
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 11:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LB6DzRWwHf8U2p9Xh6RTlRrxoQr9tHmDu0eu+IFcF/0=;
        b=dSn9V4bZ5ct5gZcLppuEjpWfyrvpQ0NQa/PZtNEPS9nfbP+qdvH2xxZCAAzTENgB3m
         EUXWZ6CswlCv3+L0gyskHsscB2NMGvYyVFZQnAcuwTL0dpXmucTEWDhfbnh8/IenDKG+
         lLuq2/Reb5QLI8bC0V0ElOsP9Z04ro082nrE2S6RjCGm1lwEbVnf2uXZOa/UkpE3hC3L
         n/N6dnC653Ruv+5xD4tJNfnTGePls5YgceGiMGJkf0eyQf39g6Z6JLBmx9Lne41BcZn8
         VuL3i52oUd33x5tZoxTR3Nkjai6W7nSB7WxvCPBTj3CgC7JZ9802RJSiCsnCKiI9tN7V
         ESNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LB6DzRWwHf8U2p9Xh6RTlRrxoQr9tHmDu0eu+IFcF/0=;
        b=LqZ5KxRjgF4iy3QJ4vbI5TAAR1avqTF5IDycCkE+DWlUG30U9xtJ91SzF2yvM1j2La
         6EzoOtX8oK//3Im2oWMgqx2IrKUzZ/eDI9PE3KsUMTXvBY3B1y9ji/o0jWO9v1S6QjJn
         xTVX/nQXx+esL5zY8NWbo/gczQe8BHR1T3uFPg+9MH7oGqHGu15dQYtIFWd2RqZFQwns
         wKs9BQ1/qbk2cZE6duPJIkVsS5xD/l7jpt3EeNqTXMQardc9dNeG8gOSuNSG8ANeVXgm
         E+qcHWdYAcMvspUYondPwbxF9DHiQxshAnZFP/xVLrX5BX85BhAlo0wSOaNV1GJplEcO
         p+rA==
X-Gm-Message-State: AOAM533fs98TCH8yaKjjjmCNsEC8qrgGSR6q0+XIpvTbw9fwMS+Xmno2
        R9xTV50zvmKjR5N4YwM+CgQWTa38Nas=
X-Google-Smtp-Source: ABdhPJy9L9oB2+/IcBEUbqg+U8Aglv2zxbTvClkzB+vHnkNVI2uNOce+RUTXcfqIvwDERINojC2Ekg==
X-Received: by 2002:a1c:f706:: with SMTP id v6mr1102581wmh.85.1611086049213;
        Tue, 19 Jan 2021 11:54:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x7sm5630083wmi.11.2021.01.19.11.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 11:54:08 -0800 (PST)
Message-Id: <f1c7ce8123fd94009bbb5ed7d641465dff8bb9c2.1611086033.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v3.git.1611086033.gitgitgadget@gmail.com>
References: <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
        <pull.835.v3.git.1611086033.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jan 2021 19:53:52 +0000
Subject: [PATCH v3 16/17] merge-ort: process_renames() now needs more
 defensiveness
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Since directory rename detection adds new paths to opt->priv->paths and
removes old ones, process_renames() needs to now check whether
pair->one->path actually exists in opt->priv->paths instead of just
assuming it does.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 1152d0ae21e..7314f9c69c2 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1410,12 +1410,28 @@ static int process_renames(struct merge_options *opt,
 		const char *rename_branch = NULL, *delete_branch = NULL;
 
 		old_ent = strmap_get_entry(&opt->priv->paths, pair->one->path);
-		oldpath = old_ent->key;
-		oldinfo = old_ent->value;
-
 		new_ent = strmap_get_entry(&opt->priv->paths, pair->two->path);
-		newpath = new_ent->key;
-		newinfo = new_ent->value;
+		if (old_ent) {
+			oldpath = old_ent->key;
+			oldinfo = old_ent->value;
+		}
+		newpath = pair->two->path;
+		if (new_ent) {
+			newpath = new_ent->key;
+			newinfo = new_ent->value;
+		}
+
+		/*
+		 * If pair->one->path isn't in opt->priv->paths, that means
+		 * that either directory rename detection removed that
+		 * path, or a parent directory of oldpath was resolved and
+		 * we don't even need the rename; in either case, we can
+		 * skip it.  If oldinfo->merged.clean, then the other side
+		 * of history had no changes to oldpath and we don't need
+		 * the rename and can skip it.
+		 */
+		if (!oldinfo || oldinfo->merged.clean)
+			continue;
 
 		/*
 		 * diff_filepairs have copies of pathnames, thus we have to
-- 
gitgitgadget

