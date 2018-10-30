Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEC121F45E
	for <e@80x24.org>; Tue, 30 Oct 2018 22:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbeJaHEp (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 03:04:45 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:55955 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728548AbeJaHEp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 03:04:45 -0400
Received: by mail-qt1-f201.google.com with SMTP id b16so7954886qtc.22
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 15:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EHSIh9Pm1e+80GSkmEQXSv47yZnmKq38dWRt9OP6SZY=;
        b=mDVmAJI875u3Qp7cQI8Ta96ZpC3kU1OL0LG+j+YP8nboxEN4I9BCEMlE7fqq2/hGZK
         nuP+0GGJwuGq7tTAmXzTi+8ds4JIlLXXl3zTwn6LVuvS2TPoIi5/fiKLEdF/HZ4OtxYo
         FdY0D68yTUIkuzxGi1rziwkfafsAcKEL3WeG8E1hpbi3q2631MehRC5dZ6W2xRJ3KiDf
         2AGcX/gBeJxRY9xMsymYs3gXT8Dfbl03DZVHdVHebnHzCwB08t/abL8ujdmVkztEz7hG
         2JQmuhMObAoWuyxfB0ZJ8WnigzwhaBAEvK/woQ/oOpAGE3Tda8oJX1ZTQ5CbZEV4A8VJ
         4ucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EHSIh9Pm1e+80GSkmEQXSv47yZnmKq38dWRt9OP6SZY=;
        b=cvk28XLKzuyxL1jnMkrTpimhnZ07mlguIhf8YBBsX9N9wHnAWsAOSBdics5U/XQGBc
         t4VtTI4XcnCqOaKhJbqlEZAkqdCIJTIuW/Kvj3HliiPyxlZLdfdton5eHRyE4ZiV443c
         tCs+BNhQKWM5Kkm/GWCuYVXf2dN935yzCV6b4+avv5VSbCa+ZwgjKxAlEwuqaMk6Oxmv
         exkYudxKrpQg+WKKsK5pmUDo/ctXLHPReRYMmCnfRezOF8TdVGXnkDPBBGlTHo96mgAZ
         OjZ38TJfw/Qgikc5Y/iAUNDHySgwm7/ZKYmefu88YMUVRuiZFGi0cEVv2jgIXjoCexrd
         /iGw==
X-Gm-Message-State: AGRZ1gI+aCI8D0FKv9P0ExGVtwmdb++UrQGwGjCpCdGuOf+xcfrXwKht
        PG0TevKyfnphXUOASCmuXGMaIeK+X4pLyapgELNSPxsH/ykk/2hVLhV9WR5sGwIvBNcdCvgkIqw
        gVsFtnrR+vePUxtI1BInT/Hpg1YYTP5lTeOu5EbnONqqK6zLGduRrL0edyy9m
X-Google-Smtp-Source: AJdET5e25I47Q/NaHZ8w+gAURhiduMnqC7nsJozWNFlnIOkaauRVIpj7NkjGFVDk7JF6OkfyBhPIqTNYtbXw
X-Received: by 2002:a0c:ad8e:: with SMTP id w14mr464318qvc.16.1540937369465;
 Tue, 30 Oct 2018 15:09:29 -0700 (PDT)
Date:   Tue, 30 Oct 2018 15:08:16 -0700
In-Reply-To: <20181030220817.61691-1-sbeller@google.com>
Message-Id: <20181030220817.61691-24-sbeller@google.com>
Mime-Version: 1.0
References: <20181030220817.61691-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
Subject: [PATCH 23/24] path.h: make REPO_GIT_PATH_FUNC repository agnostic
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, jonathantanmy@google.com,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git_pathdup uses the_repository internally, but the macro
REPO_GIT_PATH_FUNC is specifically made for arbitrary repositories.
Switch to repo_git_path which works on arbitrary repositories.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 path.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/path.h b/path.h
index b654ea8ff5..651e6157fc 100644
--- a/path.h
+++ b/path.h
@@ -165,7 +165,7 @@ extern void report_linked_checkout_garbage(void);
 	const char *git_path_##var(struct repository *r) \
 	{ \
 		if (!r->cached_paths.var) \
-			r->cached_paths.var = git_pathdup(filename); \
+			r->cached_paths.var = repo_git_path(r, filename); \
 		return r->cached_paths.var; \
 	}
 
-- 
2.19.1.930.g4563a0d9d0-goog

