Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28E281F403
	for <e@80x24.org>; Wed,  6 Jun 2018 16:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933564AbeFFQu6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 12:50:58 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38445 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752425AbeFFQu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 12:50:57 -0400
Received: by mail-lf0-f65.google.com with SMTP id i83-v6so10172713lfh.5
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 09:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L/2BQM1FKIBjodlNSVRAke+U2HyaX9rVQDXnjip3ICQ=;
        b=nwaJtoKuxKlc03hbBfxfD27W8ChAvb0JCyT46HsqCGy/9wNWfkAtYlAcXM2Lc+8RTN
         ttufpjjF/yW5W+pnNDmazGrBlUZZHvZbeBF+HSIVz5FMdd4VE9BK9v6MaPyOsDjP0ZX8
         S52IyVsOnxhvGpTfGQ+QmRpCOVA7JrjiKYceqeUB8EzmiyqJEn2DS9LgIyol1PjbN7ez
         9JWy7MFf8rd8QgFhEgETpmtWUStAGYyzVw2AY8NwtiEIx3vCxzWg6STFNldsIRh757FQ
         eF06XURL4Om9Ck7XyLj9cua6bj0kmlOBgrOBh+kxqQiXwxm57D0dokxv7Vys1RqEOCSd
         nAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L/2BQM1FKIBjodlNSVRAke+U2HyaX9rVQDXnjip3ICQ=;
        b=AIKwzcCIpofVtU3rzQT2C0tXgAurXdVFqDp0XiIeyjxLiAkNzoiQio6zgj3tWLBHCR
         7zHpgPuI2JRjV9jzg505rcz7h2fFZUR1KRR9IEnXj3yMVt2apAljIAIX0HKDD+kCy+dx
         gt4hhLND71WFVxatFEhJjK9VyQm22cgU+G7uwBfwI2QV7Nns8qJyq9LnIS9eYHhyOQR/
         6Cfjrv8JZxGtWG0vHW9zP0ewdoaL7ZsEADtAN4arsGzEK34l3in/5Md/p1B8HnulhbTH
         anJz9Oj8Hgj0cvtn6b8c75zGFCIsLgbhesJTmB01E1OAJnMRQQAS+vih/DaLf0F5Lw6M
         9AfA==
X-Gm-Message-State: APt69E0HcpIaG/9fAGsH0sx7zr7q4BtgtxwF/HmXC15DNnP2FNpMjvmX
        daXsbz/z2YUEMWpIFrFUTkE=
X-Google-Smtp-Source: ADUXVKKsH66iRC0glSsXpjrrO7KWKIpE78Mmafn43HWXn44IS4Ij1LeakPuOPOvMWkzE8UAxULnYiQ==
X-Received: by 2002:a2e:5453:: with SMTP id y19-v6mr2523504ljd.11.1528303855715;
        Wed, 06 Jun 2018 09:50:55 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id y6-v6sm909489ljc.67.2018.06.06.09.50.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 09:50:37 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: [PATCH v4 05/23] unpack-trees: avoid the_index in verify_absent()
Date:   Wed,  6 Jun 2018 18:49:58 +0200
Message-Id: <20180606165016.3285-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606165016.3285-1-pclouds@gmail.com>
References: <20180606073933.14755-1-pclouds@gmail.com>
 <20180606165016.3285-1-pclouds@gmail.com>
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
index 5268de7af5..3ace82ca27 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1651,7 +1651,7 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 	memset(&d, 0, sizeof(d));
 	if (o->dir)
 		d.exclude_per_dir = o->dir->exclude_per_dir;
-	i = read_directory(&d, &the_index, pathbuf, namelen+1, NULL);
+	i = read_directory(&d, o->src_index, pathbuf, namelen+1, NULL);
 	if (i)
 		return o->gently ? -1 :
 			add_rejected_path(o, ERROR_NOT_UPTODATE_DIR, ce->name);
@@ -1693,7 +1693,7 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 		return 0;
 
 	if (o->dir &&
-	    is_excluded(o->dir, &the_index, name, &dtype))
+	    is_excluded(o->dir, o->src_index, name, &dtype))
 		/*
 		 * ce->name is explicitly excluded, so it is Ok to
 		 * overwrite it.
-- 
2.18.0.rc0.333.g22e6ee6cdf

