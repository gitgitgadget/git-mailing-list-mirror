Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 601741F404
	for <e@80x24.org>; Mon, 13 Aug 2018 16:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbeHMS62 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 14:58:28 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36624 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729760AbeHMS61 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 14:58:27 -0400
Received: by mail-lf1-f65.google.com with SMTP id b22-v6so11660557lfa.3
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 09:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OxXxIbbgolmgKh9AfZQU3qLDgxcUGAlYzMJWheWwQ+w=;
        b=m0veeITZ0ke4PPC1/hV1FsbNyuXZDYknq1sX1i/o2p0b8skXz9vYF2HOpVSPvWomFj
         xhr2R9EURB6c39MtWwtvPQvKXlTjHgqc0jQ0JjdsHvF8TSGbUm87IyMVbthhbfdLkLer
         zLB/EwLRDpwtHJWIJYbGe7iPSbB90I/Mjuw/nR7cdo24tvQMRlw8pNlmTmjHuKFDwTgW
         U91mRZi0wZ1nbbMNYkQfBD4pC/2bMafaZkb2Q1708BCy/xhJKkycGY67UicCoesg0Y39
         D4abtzZzGS8YlW6b0zAZ518qRF5zO2Ece2OQZk69UIlumbszby4B37+vDwAINJY3IiEB
         FR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OxXxIbbgolmgKh9AfZQU3qLDgxcUGAlYzMJWheWwQ+w=;
        b=pIHjaniQsZ21h4DSa9XSe9J7L1UZZo7NbDrcqolkDydEgiJWXFAIc3h7YvnYJXS1rz
         3/p00j0c9U28KiCFePLGe2XUuqKrOrzmIIoOeQKhyOYgMLvDug9T0iAhIgH2/iouIxMD
         iozd4udh13yakaWixWLKGENEXhZPj2KZqOIXWSnNJlUxhakl056Dipg67Yt+mp9kSaNK
         xDRB2hQhVRJs2WRRmGJmHaUPXMhXGQLzBCTKx811Ww5aikAPOyuPArYhPi8/ACTTmIzZ
         sH7oyOXcqfiT9PwkRuQJ9uxacEsPpaYs+If9ILnG7oPBZyUtRQ0c29c2hKG/XaE4bOI+
         5CEA==
X-Gm-Message-State: AOUpUlGc8zvcjPkqJGrP+yFc7qBSDsI//OeSa80CRYL8HR+r3vNTZ99H
        4fu1rI8PQhszSRNLoPAomaVfbGVB
X-Google-Smtp-Source: AA+uWPyvoCdx/0bea3QBPsi9GBIiLz+HiTOH8R2mx05vPgDXyebvAZ/R+HY8LCr6dkh9JzGu8GYfRw==
X-Received: by 2002:a19:f50d:: with SMTP id j13-v6mr10957055lfb.127.1534176932536;
        Mon, 13 Aug 2018 09:15:32 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id d14-v6sm3066031ljc.56.2018.08.13.09.15.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 09:15:31 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 12/24] unpack-trees: avoid the_index in verify_absent()
Date:   Mon, 13 Aug 2018 18:14:29 +0200
Message-Id: <20180813161441.16824-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.1004.g6639190530
In-Reply-To: <20180813161441.16824-1-pclouds@gmail.com>
References: <20180813161441.16824-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Both functions that are updated in this commit are called by
verify_absent(), which is part of the "unpack-trees" operation that is
supposed to work on any index file specified by the caller. Thanks to
Brandon [1] [2], an implicit dependency on the_index is exposed. This
commit fixes it.

In both functions, it makes sense to use src_index to check for
exclusion because it's almost unchanged and should give us the same
outcome as if running the exclude check before the unpack.

It's "almost unchanged" because we do invalidate cache-tree and
untracked cache in the source index. But this should not affect how
exclude machinery uses the index: to see if a file is tracked, and to
read a blob from the index instead of worktree if it's marked
skip-worktree (i.e. it's not available in worktree)

[1] a0bba65b10 (dir: convert is_excluded to take an index - 2017-05-05
[2] 2c1eb10454 (dir: convert read_directory to take an index - 2017-05-05)

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 unpack-trees.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 5d11f10e66..14e9043f9d 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1658,7 +1658,7 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 	memset(&d, 0, sizeof(d));
 	if (o->dir)
 		d.exclude_per_dir = o->dir->exclude_per_dir;
-	i = read_directory(&d, &the_index, pathbuf, namelen+1, NULL);
+	i = read_directory(&d, o->src_index, pathbuf, namelen+1, NULL);
 	if (i)
 		return o->gently ? -1 :
 			add_rejected_path(o, ERROR_NOT_UPTODATE_DIR, ce->name);
@@ -1700,7 +1700,7 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 		return 0;
 
 	if (o->dir &&
-	    is_excluded(o->dir, &the_index, name, &dtype))
+	    is_excluded(o->dir, o->src_index, name, &dtype))
 		/*
 		 * ce->name is explicitly excluded, so it is Ok to
 		 * overwrite it.
-- 
2.18.0.1004.g6639190530

