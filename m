Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 036F81F954
	for <e@80x24.org>; Sat, 18 Aug 2018 14:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbeHRRtf (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 13:49:35 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36054 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbeHRRtf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 13:49:35 -0400
Received: by mail-lj1-f193.google.com with SMTP id u7-v6so8501798lji.3
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 07:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CXM80yIutHscECruUvFdcotzLQp1UuUTlZtt9MPCoYg=;
        b=QNlmSkZ+JAt2tASQOixP8HrOIKL1pwwN8xoc4jaassoUTyNOiU+IbqkrnGK29WSIA9
         zNjXYex0LQ0/WlClsiRTZdJqA/iSiejJzDz/iaXWETpQxJ/bs0jJHFRCJSjEtFXeqEMG
         UQhj1gR0/4GAjkz/ZhZeGnI0Wd4CCGV3OTqU8psop1e2uycS4CVoMgcfnILy/DRpCpJJ
         hSMYcmT/sN+l5WpJ31v3oerYeMDGhca+PapY1O/WVAh9kgzmCO3pB6ixWCFkLcLS2QrF
         H0sUL0kIOrHJd9elPL9Qldd6MMkFzoEtLqe+IhdT2Y2qpanCsRVq8v9U93vCq8P2X+Tt
         WITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CXM80yIutHscECruUvFdcotzLQp1UuUTlZtt9MPCoYg=;
        b=NZruPwQ6/zPshEmgxdTAetw0gnTeg9SwVswVPAETCjjY98CvUCG4vzzqMFuQEVn1Cz
         R5GLvlVW9+akz7VliQW+KGrVmjhSOWqC7E9OxBrYmdqjZDhiMyRqQYusrFb/lsjv20e9
         EbwC0Xxaxrs6WmUCYIaRygshMYCeVIlW/vwisE0Zzqn1h7Oce2pbU2SnpNDTpRk8AkeP
         q3malM9BQdSGuZPedqZTL+XltScX6j0J8DYWBvHeO/MWfa/T/uwLUjT9o9K46lH/Yzzg
         L/zmD/hM8a4OCc6f+Eyh7YtvSjdbfK8s/a0Wox1sCm2VLwWY5iOS/+QSq4JRkFJUtBxG
         DTCQ==
X-Gm-Message-State: AOUpUlE6sUmK1sfXPSeglY+Zffo5o2yfImTgf9YLstIHpPC0CjAwtDFY
        zcVbaTSAEgN/LvK1MvhpFvE=
X-Google-Smtp-Source: AA+uWPy++aZbLYxRAUty6qr5TLx36/DDiYBZwTnfPxakmhsYYpjb5tDoJUJsvN6FFFgXNRsiO4yjTQ==
X-Received: by 2002:a2e:8617:: with SMTP id a23-v6mr1318741lji.43.1534603297637;
        Sat, 18 Aug 2018 07:41:37 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id b76-v6sm884451lff.53.2018.08.18.07.41.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Aug 2018 07:41:36 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Ben.Peart@microsoft.com, git@vger.kernel.org, gitster@pobox.com,
        newren@gmail.com, peartben@gmail.com, peff@peff.net
Subject: [PATCH v5 0/7] Speed up unpack_trees()
Date:   Sat, 18 Aug 2018 16:41:21 +0200
Message-Id: <20180818144128.19361-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.1004.g6639190530
In-Reply-To: <20180812081551.27927-1-pclouds@gmail.com>
References: <20180812081551.27927-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v5 fixes some minor comments from round 4 and a big mistake in 5/5.
Junio's scary feeling turns out true. There is a missing invalidation
in keep_entry() which is not added in 6/7. 7/7 makes sure that similar
problems will not slip through.

I had to rebase this series on top of 'master' because 7/7 caught a
bad cache-tree situation that has been fixed by Elijah in ad3762042a
(read-cache: fix directory/file conflict handling in
read_index_unmerged() - 2018-07-31). I believe the issue was we prime
cache-tree in 'git reset --hard' even though the index has conflicts.

Range-diff (before the rebase):

1:  a192faf79e ! 1:  ed8763726b trace.h: support nested performance tracing
    @@ -49,13 +49,16 @@
      	struct untracked_cache_dir *untracked;
     -	uint64_t start = getnanotime();
      
    - 	if (has_symlink_leading_path(path, len))
    +-	if (has_symlink_leading_path(path, len))
    ++	trace_performance_enter();
    ++
    ++	if (has_symlink_leading_path(path, len)) {
    ++		trace_performance_leave("read directory %.*s", len, path);
      		return dir->nr;
    ++	}
      
    -+	trace_performance_enter();
      	untracked = validate_untracked_cache(dir, len, pathspec);
      	if (!untracked)
    - 		/*
     @@
      		dir->nr = i;
      	}
2:  9afe7c488a = 2:  9b70652fa2 unpack-trees: add performance tracing
3:  74101edb60 ! 3:  8b3cfea623 unpack-trees: optimize walking same trees with cache-tree
    @@ -141,7 +141,7 @@
     +
     +	/*
     +	 * Do what unpack_callback() and unpack_nondirectories() normally
    -+	 * do. But we walk all paths recursively in just one loop instead.
    ++	 * do. But we walk all paths in an iterative loop instead.
     +	 *
     +	 * D/F conflicts and higher stage entries are not a concern
     +	 * because cache-tree would be invalidated and we would never
4:  9261c5920e = 4:  5af28d44ca unpack-trees: reduce malloc in cache-tree walk
5:  43fac1154f = 5:  5657c92fe9 unpack-trees: reuse (still valid) cache-tree from src_index
-:  ---------- > 6:  3b91783afc unpack-trees: add missing cache invalidation
-:  ---------- > 7:  0d5464c0dc cache-tree: verify valid cache-tree in the test suite

Nguyễn Thái Ngọc Duy (7):
  trace.h: support nested performance tracing
  unpack-trees: add performance tracing
  unpack-trees: optimize walking same trees with cache-tree
  unpack-trees: reduce malloc in cache-tree walk
  unpack-trees: reuse (still valid) cache-tree from src_index
  unpack-trees: add missing cache invalidation
  cache-tree: verify valid cache-tree in the test suite

 cache-tree.c    |  80 +++++++++++++++++++++++++
 cache-tree.h    |   1 +
 diff-lib.c      |   4 +-
 dir.c           |   9 ++-
 name-hash.c     |   4 +-
 preload-index.c |   4 +-
 read-cache.c    |  16 +++--
 t/test-lib.sh   |   6 ++
 trace.c         |  69 ++++++++++++++++++++--
 trace.h         |  15 +++++
 unpack-trees.c  | 154 +++++++++++++++++++++++++++++++++++++++++++++++-
 11 files changed, 340 insertions(+), 22 deletions(-)

-- 
2.18.0.1004.g6639190530

