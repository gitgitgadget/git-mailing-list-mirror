Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 959FC1F954
	for <e@80x24.org>; Fri, 17 Aug 2018 16:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbeHQTUz (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 15:20:55 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35655 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbeHQTUz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 15:20:55 -0400
Received: by mail-lf1-f68.google.com with SMTP id f18-v6so6275542lfc.2
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 09:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bfDzN4Rf+KbnLH9Y2DL8kkyG+ZaJOU9iNxq5y41+kEA=;
        b=WizDx2x9ujUEG1Dxw5cMRv7DEiQtUF0YFcoLqRIv+eMm/c3nzsgeH4s9dtjyK7A2kw
         yUYYmIl5/am4R7CybkXJIunqWYNg0jEF78RghgC32aTKAdBjWN67cphvEb7HR5gzbACM
         uyH/PF8bj6xXZOZLpVuKWyEuNBzE/fBTTwB4iY0gw/tedOToqTr0CU0UFIQb4i4mhG4o
         XGJ2MPzkuJ9jfiOjxHTgo30E80lJWJGJWt0GHy2wWbL2UqrL2liqUcUfvDkBxkjRCLcw
         pDE2LLOobBLsNroggU+UyD1jJxKZ5ET+DYJ5eSPoYxP0IC7AvlgsZdTg/ia7e5g9iyuR
         duSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bfDzN4Rf+KbnLH9Y2DL8kkyG+ZaJOU9iNxq5y41+kEA=;
        b=trIenYpUrPfvu20PziKZeNTTmdKrRTInfb5Oki22Sgv4Iy35eUQuZ1vGtDQzjIX0AR
         ldgqWcUsaVa10HI0YWE1Wa0LDW5WfENO3ytMaEWwBeUWOyX1jCBKFUBJ4SeojtW7qTys
         Tv60k3hin8wmPiZ1onwxDG9tZGyrBWOujLNwoLeJaQ7L2yGeOK5I3af3XH7lHQIhb1sp
         hunNHRTkPn2X9/tKGh7Z95BVO3KS1AQZqlp3/++A53xxVM8MddX3g41p101E0wl8gvUq
         kzbukIr50DmFMo4+fjAX/Ln792+OSlPH4MMTANzZlWk6h/MGamF01EoRPt3/wXAicKob
         s01A==
X-Gm-Message-State: AOUpUlGrxi/OScyKbShyvXSNOhFgsvbcsMgazCcLLgLmyQk0Ugs8wapt
        KKnKA4VKmyhoadPCrZFb572bvRpf
X-Google-Smtp-Source: AA+uWPwuJs5QMxqMp2vUYJyuTRmfqnnsxwX98xuAbDswzL3zLY0YLvuKG5ksJDV2MeSoolM6O49CMQ==
X-Received: by 2002:a19:138b:: with SMTP id 11-v6mr23955687lft.74.1534522615243;
        Fri, 17 Aug 2018 09:16:55 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id p65-v6sm370681lja.44.2018.08.17.09.16.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 09:16:54 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@jeffhostetler.com, git@vger.kernel.org, gitster@pobox.com,
        newren@gmail.com, pawelparuzel95@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com, tboegi@web.de
Subject: [PATCH v5] clone: report duplicate entries on case-insensitive filesystems
Date:   Fri, 17 Aug 2018 18:16:45 +0200
Message-Id: <20180817161645.28249-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.1004.g6639190530
In-Reply-To: <20180812090714.19060-1-pclouds@gmail.com>
References: <20180812090714.19060-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paths that only differ in case work fine in a case-sensitive
filesystems, but if those repos are cloned in a case-insensitive one,
you'll get problems. The first thing to notice is "git status" will
never be clean with no indication what exactly is "dirty".

This patch helps the situation a bit by pointing out the problem at
clone time. Even though this patch talks about case sensitivity, the
patch makes no assumption about folding rules by the filesystem. It
simply observes that if an entry has been already checked out at clone
time when we're about to write a new path, some folding rules are
behind this.

In the case that we can't rely on filesystem (via inode number) to do
this check, fall back to fspathcmp() which is not perfect but should
not give false positives.

This patch is tested with vim-colorschemes and Sublime-Gitignore
repositories on a JFS partition with case insensitive support on
Linux.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 v5 respects core.checkStat and sorts the output case-insensitively.

 I still don't trust magic st_ino zero, or core.checkStat being zero
 on Windows, so the #if condition still remains but it covers smallest
 area possible and I tested it by manually make it "#if 1"

 The fallback with fspathcmp() is only done when inode can't be
 trusted because strcmp is more expensive and when fspathcmp() learns
 more about real world in the future, it could become even more
 expensive.

 The output sorting is the result of Sublime-Gitignore repo being
 reported recently. It's not perfect but it should help seeing the
 groups in normal case.

 builtin/clone.c  |  1 +
 cache.h          |  1 +
 entry.c          | 31 +++++++++++++++++++++++++++++++
 t/t5601-clone.sh |  8 +++++++-
 unpack-trees.c   | 35 +++++++++++++++++++++++++++++++++++
 unpack-trees.h   |  1 +
 6 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 5c439f1394..0702b0e9d0 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -747,6 +747,7 @@ static int checkout(int submodule_progress)
 	memset(&opts, 0, sizeof opts);
 	opts.update = 1;
 	opts.merge = 1;
+	opts.clone = 1;
 	opts.fn = oneway_merge;
 	opts.verbose_update = (option_verbosity >= 0);
 	opts.src_index = &the_index;
diff --git a/cache.h b/cache.h
index 8b447652a7..6d6138f4f1 100644
--- a/cache.h
+++ b/cache.h
@@ -1455,6 +1455,7 @@ struct checkout {
 	unsigned force:1,
 		 quiet:1,
 		 not_new:1,
+		 clone:1,
 		 refresh_cache:1;
 };
 #define CHECKOUT_INIT { NULL, "" }
diff --git a/entry.c b/entry.c
index b5d1d3cf23..8766e27255 100644
--- a/entry.c
+++ b/entry.c
@@ -399,6 +399,34 @@ static int check_path(const char *path, int len, struct stat *st, int skiplen)
 	return lstat(path, st);
 }
 
+static void mark_colliding_entries(const struct checkout *state,
+				   struct cache_entry *ce, struct stat *st)
+{
+	int i, trust_ino = check_stat;
+
+#if defined(GIT_WINDOWS_NATIVE)
+	trust_ino = 0;
+#endif
+
+	ce->ce_flags |= CE_MATCHED;
+
+	for (i = 0; i < state->istate->cache_nr; i++) {
+		struct cache_entry *dup = state->istate->cache[i];
+
+		if (dup == ce)
+			break;
+
+		if (dup->ce_flags & (CE_MATCHED | CE_VALID | CE_SKIP_WORKTREE))
+			continue;
+
+		if ((trust_ino && dup->ce_stat_data.sd_ino == st->st_ino) ||
+		    (!trust_ino && !fspathcmp(ce->name, dup->name))) {
+			dup->ce_flags |= CE_MATCHED;
+			break;
+		}
+	}
+}
+
 /*
  * Write the contents from ce out to the working tree.
  *
@@ -455,6 +483,9 @@ int checkout_entry(struct cache_entry *ce,
 			return -1;
 		}
 
+		if (state->clone)
+			mark_colliding_entries(state, ce, &st);
+
 		/*
 		 * We unlink the old file, to get the new one with the
 		 * right permissions (including umask, which is nasty
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 0b62037744..f2eb73bc74 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -624,10 +624,16 @@ test_expect_success 'clone on case-insensitive fs' '
 			git hash-object -w -t tree --stdin) &&
 		c=$(git commit-tree -m bogus $t) &&
 		git update-ref refs/heads/bogus $c &&
-		git clone -b bogus . bogus
+		git clone -b bogus . bogus 2>warning
 	)
 '
 
+test_expect_success !MINGW,!CYGWIN,CASE_INSENSITIVE_FS 'colliding file detection' '
+	grep X icasefs/warning &&
+	grep x icasefs/warning &&
+	test_i18ngrep "the following paths have collided" icasefs/warning
+'
+
 partial_clone () {
 	       SERVER="$1" &&
 	       URL="$2" &&
diff --git a/unpack-trees.c b/unpack-trees.c
index cd0680f11e..4338fee3b7 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -359,6 +359,12 @@ static int check_updates(struct unpack_trees_options *o)
 	state.refresh_cache = 1;
 	state.istate = index;
 
+	if (o->clone) {
+		state.clone = 1;
+		for (i = 0; i < index->cache_nr; i++)
+			index->cache[i]->ce_flags &= ~CE_MATCHED;
+	}
+
 	progress = get_progress(o);
 
 	if (o->update)
@@ -423,6 +429,35 @@ static int check_updates(struct unpack_trees_options *o)
 	errs |= finish_delayed_checkout(&state);
 	if (o->update)
 		git_attr_set_direction(GIT_ATTR_CHECKIN, NULL);
+
+	if (o->clone) {
+		struct string_list list = STRING_LIST_INIT_NODUP;
+		int i;
+
+		for (i = 0; i < index->cache_nr; i++) {
+			struct cache_entry *ce = index->cache[i];
+
+			if (!(ce->ce_flags & CE_MATCHED))
+				continue;
+
+			string_list_append(&list, ce->name);
+			ce->ce_flags &= ~CE_MATCHED;
+		}
+
+		list.cmp = fspathcmp;
+		string_list_sort(&list);
+
+		if (list.nr)
+			warning(_("the following paths have collided (e.g. case-sensitive paths\n"
+				  "on a case-insensitive filesystem) and only one from the same\n"
+				  "colliding group is in the working tree:\n"));
+
+		for (i = 0; i < list.nr; i++)
+			fprintf(stderr, "  '%s'\n", list.items[i].string);
+
+		string_list_clear(&list, 0);
+	}
+
 	return errs != 0;
 }
 
diff --git a/unpack-trees.h b/unpack-trees.h
index c2b434c606..d940f1c5c2 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -42,6 +42,7 @@ struct unpack_trees_options {
 	unsigned int reset,
 		     merge,
 		     update,
+		     clone,
 		     index_only,
 		     nontrivial_merge,
 		     trivial_merges_only,
-- 
2.18.0.1004.g6639190530

