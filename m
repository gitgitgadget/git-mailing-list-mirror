Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3035B1FF30
	for <e@80x24.org>; Tue, 23 May 2017 09:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935500AbdEWJSq (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 05:18:46 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34745 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753078AbdEWJSk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 05:18:40 -0400
Received: by mail-qk0-f196.google.com with SMTP id u75so22099703qka.1
        for <git@vger.kernel.org>; Tue, 23 May 2017 02:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=YOq8W4k/LmFDsjele7XvWL6haDRCfY5e3vWtVtml0bU=;
        b=H8FbHy0IFtfa8fX1caA5S7JRf050ebj5KCEm8HcWJwn+BPLEHcDbygme0i1nWcfgzX
         1riupS/lnquf+DkCOtTPfpzWC1TTS2h+2EezhJLZFabhOeFGELDoAmboKuxzJQ8DSPXV
         A9B5CZqo93btdVTgB4Ir6qlDlKfoXjMh4FVSmfVYkZUCCMKQhem2xE4rYipaDNsamsY9
         4bx2RoQWrKNqBZahmGxJhVbk/0duWuJIw8rcRlpBXioFrrCGLAjkfs5CV0uDNx4XFIc3
         SmSzbfLPWcdd875BD8NQLR41dirfu/5+3FOOoD8joe/zIok3ekSapywY5GgZUxw1iJIx
         9IxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=YOq8W4k/LmFDsjele7XvWL6haDRCfY5e3vWtVtml0bU=;
        b=LLT0zPnF/dmFhGJnZ/tS67Kte82Egk6MlZqOpohkoO2KWWApKfFNfCENsSrmQAKu3l
         7smd9OZy2Q8+G0YHVcGgLTdNgoEbgroF6wlK54voWw/QFtPqt7K6H9kQRYVXcEiAmxxw
         6G/dKEhhgn4bbHQ74ov3p2mYgxbn+Jzw2XvOeAstbl+wsG2mFAM4LrHlEwPz1A0uaA/v
         nxpUzHvvHAbUto2f25B2KY2ANioxe8RKXRa+Fm2ReBKUziJWXuhydDYAhzIUA+V5svsy
         DMgWTTOfyGlOP1DQuHEmo5O8Lky2xOtDwPyTJk/3oejwoTAhb4V5d4Q/K0SlD66KoCok
         cBCQ==
X-Gm-Message-State: AODbwcC+/0svBB3Xixtz+1vemRO/xJ9LBczWZ6mGPZCHqOGmNn61aUqH
        KvXA6/NMU3rNVngJeiw=
X-Received: by 10.55.21.4 with SMTP id f4mr24963919qkh.67.1495531119473;
        Tue, 23 May 2017 02:18:39 -0700 (PDT)
Received: from localhost.localdomain (cpe-98-14-117-223.nyc.res.rr.com. [98.14.117.223])
        by smtp.gmail.com with ESMTPSA id a45sm83105qta.39.2017.05.23.02.18.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 02:18:38 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v5 3/6] dir: recurse into untracked dirs for ignored files
Date:   Tue, 23 May 2017 05:18:26 -0400
Message-Id: <20170523091829.1746-4-sxlijin@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170523091829.1746-1-sxlijin@gmail.com>
References: <20170523091829.1746-1-sxlijin@gmail.com>
In-Reply-To: <20170518082154.28643-1-sxlijin@gmail.com>
References: <20170518082154.28643-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We consider directories containing only untracked and ignored files to
be themselves untracked, which in the usual case means we don't have to
search these directories. This is problematic when we want to collect
ignored files with DIR_SHOW_IGNORED_TOO, though, so we teach
read_directory_recursive() to recurse into untracked directories to find
the ignored files they contain when DIR_SHOW_IGNORED_TOO is set. This
has the side effect of also collecting all untracked files in untracked
directories as well.

Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
---
 dir.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index f451bfa48..68cf6e47c 100644
--- a/dir.c
+++ b/dir.c
@@ -1784,7 +1784,10 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 			dir_state = state;
 
 		/* recurse into subdir if instructed by treat_path */
-		if (state == path_recurse) {
+		if ((state == path_recurse) ||
+			((state == path_untracked) &&
+			 (dir->flags & DIR_SHOW_IGNORED_TOO) &&
+			 (get_dtype(cdir.de, path.buf, path.len) == DT_DIR))) {
 			struct untracked_cache_dir *ud;
 			ud = lookup_untracked(dir->untracked, untracked,
 					      path.buf + baselen,
-- 
2.13.0

