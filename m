Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C33731F403
	for <e@80x24.org>; Wed,  6 Jun 2018 07:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932349AbeFFHkL (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 03:40:11 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40392 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932208AbeFFHkI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 03:40:08 -0400
Received: by mail-lf0-f65.google.com with SMTP id q11-v6so7550567lfc.7
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 00:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M6pExQtuTThMGrNN92F/aLzO1P0JUm+yr0dm1zMXanc=;
        b=ghyuYkuMxiEsxL9xTRHFR1ootCtQljV2gnoqyYgJ6GBQpHNOvVVDf6e9kh71BA8tgS
         02GzBk42DmKQsjdSkB5PJeeJ4GiJZ/Fw63mw3v4d90VqkTLVhL22biqOqTWLBc9QEOg4
         RpqlUSzbNtLzZVniqyMHxOfgDjiraopM69URG4p/7CHCwjH4vwGZk0Kc4XtX9tB9neG4
         OkMh+1a/0TXyuRHaCIhDOVbrCYUThxMR/DytU8Sll5W5jj5ILc6UCyz1Spu3HVdcyupT
         0j6FC2Cz7vUuz88FE6UfWzvgXMChflaSVcIIaNpHQDKTujyVEXBqAswp16t+IWPs9vVx
         3Snw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M6pExQtuTThMGrNN92F/aLzO1P0JUm+yr0dm1zMXanc=;
        b=GnuaFnRULJbGiE6NT6Vw1ma1Mip8Q9UxSWs75pQSVduVbvoFNWfSJgdomSw4SC0DfW
         ftJU2UQk0RF/eSyvb0YHm3kAvkcwBIlpva6+XNnr6jFjWNLDywhkEUqUm+DKC+m0bz3o
         g9q8Ws6tv3uotFhooKKy0WxNOzxioSna+ir8PXJO14pa758G6yKmJDeP+5kq2IF3/fo5
         WLfzaVM9T8ZeyTnaa29D9hEv6F1kaXNArDd2/OkprDGH4E04YR2Rpo6BOHw+LLZqbodD
         4UJZ9sVBCIGqjwm3fqh54Ko7Lxpa+YSf3INtrM7yyxJJ/U+x3pOaLylmBoSjydl6JtPS
         mutg==
X-Gm-Message-State: APt69E38ODhhTmd4Spsy1cC0YNhpJA+Y8Qpu307SV7vz05uvlMP6glTa
        5PTHqoKoJzBkuy7HiGpfFKLltg==
X-Google-Smtp-Source: ADUXVKLl5LKUMEvXONrPVFsZ+4+xVZLJmWmzLgcU+Fy78Ogy+egFZS6K3mRuASC1FBq13wB1WzNgpA==
X-Received: by 2002:a2e:878f:: with SMTP id n15-v6mr1228869lji.69.1528270806861;
        Wed, 06 Jun 2018 00:40:06 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u3-v6sm4189048lji.4.2018.06.06.00.40.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 00:40:06 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: [PATCH v3 19/20] grep: use the right index instead of the_index
Date:   Wed,  6 Jun 2018 09:39:32 +0200
Message-Id: <20180606073933.14755-20-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606073933.14755-1-pclouds@gmail.com>
References: <20180606050207.13556-1-pclouds@gmail.com>
 <20180606073933.14755-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/grep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 2eae397e92..a8cef2b159 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -497,7 +497,7 @@ static int grep_cache(struct grep_opt *opt, struct repository *repo,
 		strbuf_addstr(&name, ce->name);
 
 		if (S_ISREG(ce->ce_mode) &&
-		    match_pathspec(&the_index, pathspec, name.buf, name.len, 0, NULL,
+		    match_pathspec(repo->index, pathspec, name.buf, name.len, 0, NULL,
 				   S_ISDIR(ce->ce_mode) ||
 				   S_ISGITLINK(ce->ce_mode))) {
 			/*
@@ -515,7 +515,7 @@ static int grep_cache(struct grep_opt *opt, struct repository *repo,
 				hit |= grep_file(opt, name.buf);
 			}
 		} else if (recurse_submodules && S_ISGITLINK(ce->ce_mode) &&
-			   submodule_path_match(&the_index, pathspec, name.buf, NULL)) {
+			   submodule_path_match(repo->index, pathspec, name.buf, NULL)) {
 			hit |= grep_submodule(opt, repo, pathspec, NULL, ce->name, ce->name);
 		} else {
 			continue;
-- 
2.18.0.rc0.333.g22e6ee6cdf

