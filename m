Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BB661F403
	for <e@80x24.org>; Wed,  6 Jun 2018 05:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932106AbeFFFCj (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 01:02:39 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34950 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932097AbeFFFCa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 01:02:30 -0400
Received: by mail-lf0-f66.google.com with SMTP id y72-v6so7035527lfd.2
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 22:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L/2BQM1FKIBjodlNSVRAke+U2HyaX9rVQDXnjip3ICQ=;
        b=YHNWNHZo8GKNsgp7xSoUh/N8UgS5G40sXB/nN5vfvOlSZ6QVlXZA1uZfXVOJXGKMwi
         Om9bmrpNgWwFADc0D77v88D7GGgSbuhus1z+K1HEDJtyU8JyCILVyQ6oBXuzNCmROPPI
         rm+9ebEZz0fKhdRZkBR5PXGjALPJZRU6LF3ODrWM/S/tAKDQED51Zsy5gBTjkwAk7e2k
         7Qvldi5qgPmqrBwC1PhuV18sQw9jMYti5bq7vtxLEiTaKEJoS6jKFefgRY/u59c8zL2p
         M9dMIAVMwYGAs2Pw8aSsvCWUrrwZbxcn0msaWec5STMOdbFWbc9qw2io9dDLVnyd0utq
         CRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L/2BQM1FKIBjodlNSVRAke+U2HyaX9rVQDXnjip3ICQ=;
        b=iCu/J8HK5Q0a7BGlVwNyxaF/2ZkUirnNohXB9qclv3ArXSIIKaqM+i++V8DVlHgL40
         akQg4iQuFyF+LIBAZ3f/7mcxYnfm+rsrHP/nMDktrXLzxzna5YOJwqs95H4hbGHtiElc
         HCXENOY3ys4uIFUcRN8MIogM/cd57u2z+Xxf0IKxOHLWyx2wp7J9IEx17aTILbk7BTVB
         HmP1wEDfyfDRymQ5MrnInaH34NsEjVxvRiEWw973NdEzrMTw2J3eDKT/7iZs+QQlnvcz
         LFvepUYnzCS6kVNXBWzS4bYgZE7I9vHTzRGE8Q9qj9MW+joH/Buk08EBOu+RAb9f0ju3
         wzVw==
X-Gm-Message-State: APt69E2/ImNt+z9AoEr20oA87N6Ii/W7yIbnytb4szHT1690jjJX3o/1
        XjyAMRhtjRQAld1u8obf6K1VmA==
X-Google-Smtp-Source: ADUXVKJo7teTA60dlj6edgshrzubBXjQ1b4rap5u9T4IT0wTbtuqXuL0KabgwoSUnHVdlBM0hTtjcw==
X-Received: by 2002:a19:1c5:: with SMTP id 188-v6mr827146lfb.67.1528261349041;
        Tue, 05 Jun 2018 22:02:29 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u3-v6sm4125798lji.4.2018.06.05.22.02.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 22:02:28 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2 5/5] unpack-trees: avoid the_index in verify_absent()
Date:   Wed,  6 Jun 2018 07:02:07 +0200
Message-Id: <20180606050207.13556-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606050207.13556-1-pclouds@gmail.com>
References: <20180605154334.22613-1-pclouds@gmail.com>
 <20180606050207.13556-1-pclouds@gmail.com>
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

