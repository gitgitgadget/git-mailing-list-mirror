Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E43A1F597
	for <e@80x24.org>; Sat, 21 Jul 2018 06:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbeGUH0Q (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 03:26:16 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:41318 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbeGUH0O (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 03:26:14 -0400
Received: by mail-yb0-f194.google.com with SMTP id s8-v6so5463517ybe.8
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 23:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oFVdgfCwIDRppIee5u8FMApenCm9exgGOYZAcZuOFt8=;
        b=JdPT3jpijc/IH3WKP4Hv9EQUnRLqT/QSDcO64CKlf0jGpJDYi94Qeo4a5chj1/v5FU
         FytQjdsrPdOQPG17IE6AuiT9rIrwMbodB+v3nsUlWxPYFAtpG+/eA6kNkmAcFcFMWWXr
         CJsQ1cyw2DjPCSXQtYG3ZLs6ubVw21SqbObhmMRJt3t8k1C1XXgCTcxt3yBWNRdQpQ3Y
         RZCAWye6JFxJZzau1U37azpCLM3+5IJOJB0B17bnRbaZsZ1CQxTO97yhHauOEchDxWri
         DOPmmHDkrnGb9npc8Y1NPzsGZeKIO7y/GT3ALoXz7vscJJ7gnA4G3dJA3KJ0hSmhqHy+
         E/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oFVdgfCwIDRppIee5u8FMApenCm9exgGOYZAcZuOFt8=;
        b=Kj1e8X+6dWtWE6+ceoj5g7yCfxaM/OmfBJ8VJu+1QrMbI6x6NjJhzBQq4hEueiaUHs
         pU2qFLn3FAZg36cAl6b7HSvmjBY89I0YDXcNeIN6CRU8cH0F2sR2Lil5XRi+Q0JJu78R
         5DTqsvY88nshfk9BIdfI2bQfGxGd6UAE/u1551wlfV+M6MdI01N1WaxjlgQt1rrxEQdI
         0Xj934Vd2vhCy/riwbuXtqYpiKA1iUxSl5GBby1VA+h6lpwzRy8z1d45H6WrHHRj+8N6
         5/iAUC5SXo/DnVHDPyb0tSdT3F4fnhrJAZQiogOzFztR/7fWFcnDnw5ON3y/E7A439Ps
         NPMw==
X-Gm-Message-State: AOUpUlEo16O6BBkKowk79uxQXIlquSzsOYoYAc0Ov9SibX6UlqNOqb+h
        e6nuv8u2HVY1upyyKZn6jMhgJfcj
X-Google-Smtp-Source: AAOMgpc80dEIQpZ5jSGotrcrEuELeUsRLpVi5AjdLNl/3ZRlWXJ+jOGGh31OpqR2nHejyhNGZZxBTA==
X-Received: by 2002:a25:4e87:: with SMTP id c129-v6mr2524211ybb.156.1532154879259;
        Fri, 20 Jul 2018 23:34:39 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id w199-v6sm1739509ywd.104.2018.07.20.23.34.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 23:34:38 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, kewillf@microsoft.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 2/2] merge-recursive: preserve skip_worktree bit when necessary
Date:   Fri, 20 Jul 2018 23:34:28 -0700
Message-Id: <20180721063428.20518-3-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.234.g2d1e6cefb
In-Reply-To: <20180721063428.20518-1-newren@gmail.com>
References: <5a8d1098-b4c5-64e1-da98-dac13521e7ba@gmail.com>
 <20180721063428.20518-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

merge-recursive takes any files marked as unmerged by unpack_trees,
tries to figure out whether they can be resolved (e.g. using renames
or a file-level merge), and then if they can be it will delete the old
cache entries and writes new ones.  This means that any ce_flags for
those cache entries are essentially cleared when merging.

Unfortunately, if a file was marked as skip_worktree and it needs a
file-level merge but the merge results in the same version of the file
that was found in HEAD, we skip updating the worktree (because the
file was unchanged) but clear the skip_worktree bit (because of the
delete-cache-entry-and-write-new-one).  This makes git treat the file
as having a local change in the working copy, namely a delete, when it
should appear as unchanged despite not being present.  Avoid this
problem by copying the skip_worktree flag in this case.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
No need to check whether pos >= 0 in this patch because the fact that
we got to this point in the code meant the entry was definitely in
both the new and old indexes (and with the same oid and mode).

We could optimize this a bit; the call to was_tracked_and_matches()
already does the lookup in o->orig_index.  So we could cache that and
re-use it.  Likewise, if we instead set ce_flags just after calling
make_cache_entry() within add_cacheinfo(), we could avoid looking up
the cache entry in the_index as well.  Setting ce_flags there would
just require plumbing an extra flag option through add_cacheinfo() and
modifying all other callsites to pass 0 for that flag.  But doing all
this felt a little messy, and I really wanted to keep the logic for
this case all in one little place.  Especially for a fixup that might
be wanted for maint.

There is also another callsite in update_file_flags() that could be
updated to preserve the skip_worktree flag, which would be technically
better.  But I really don't want to tackle that right now, I just want
a small simple fix for Ben's issue.

Besides, as Junio said:

  "If it can be done without too much effort, then it certainly is
  nicer to keep the sparseness when we do not have to materialize the
  working tree file.  But at least in my mind, if it needs too many
  special cases, hacks, and conditionals, then it is not worth the
  complexity"

 merge-recursive.c               | 16 ++++++++++++++++
 t/t3507-cherry-pick-conflict.sh |  2 +-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 113c1d696..fd74bca17 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3069,10 +3069,26 @@ static int merge_content(struct merge_options *o,
 	if (mfi.clean &&
 	    was_tracked_and_matches(o, path, &mfi.oid, mfi.mode) &&
 	    !df_conflict_remains) {
+		int pos;
+		struct cache_entry *ce;
+
 		output(o, 3, _("Skipped %s (merged same as existing)"), path);
 		if (add_cacheinfo(o, mfi.mode, &mfi.oid, path,
 				  0, (!o->call_depth && !is_dirty), 0))
 			return -1;
+		/*
+		 * However, add_cacheinfo() will delete the old cache entry
+		 * and add a new one.  We need to copy over any skip_worktree
+		 * flag to avoid making the file appear as if it were
+		 * deleted by the user.
+		 */
+		pos = index_name_pos(&o->orig_index, path, strlen(path));
+		ce = o->orig_index.cache[pos];
+		if (ce_skip_worktree(ce)) {
+			pos = index_name_pos(&the_index, path, strlen(path));
+			ce = the_index.cache[pos];
+			ce->ce_flags |= CE_SKIP_WORKTREE;
+		}
 		return mfi.clean;
 	}
 
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 25fac490d..9b1456a7c 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -392,7 +392,7 @@ test_expect_success 'commit --amend -s places the sign-off at the right place' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'failed cherry-pick with sparse-checkout' '
+test_expect_success 'failed cherry-pick with sparse-checkout' '
        pristine_detach initial &&
        git config core.sparseCheckout true &&
        echo /unrelated >.git/info/sparse-checkout &&
-- 
2.18.0.234.g2d1e6cefb

