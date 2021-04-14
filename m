Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E4BC433B4
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 19:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D41061220
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 19:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353211AbhDNTPe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 15:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352871AbhDNTPb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 15:15:31 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E0BC061574
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 12:15:07 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id s15so25051461edd.4
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 12:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ks7UK25FNIfqs07p/JGiuaXMI0OCqKDD19FMuMZgGAQ=;
        b=oPfA0B6aF5TzWTt3zMbLSsKBi4z9ANb55za42hJIPl1qzbph6MNCcaD5+4PqXRxrUR
         7rqJu3TIwbuJNdoXGOzyNMT20OPEOcOh95yAOBvrSSVTS+UDpB0dzaI/KbHMwwikONor
         HMIeLve7i7PAVLM7dafNVdBG5aNkCTtlgN0bAytuBbcLhN6e03yAlzcfvUoQdiRMxRO2
         L0rP4H6E2n01yqARaK9PT1+9ecTaxx46hZ3g2E5Nzwtu+2fOXmxl09HeJeN3VelrWyM6
         EuZmRSO0hZ6Uy8gFBQ2/R+4R30WinZLWn4RCryy8QNw2Luz4Iox/P0rneR34UONrUpyy
         Wj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ks7UK25FNIfqs07p/JGiuaXMI0OCqKDD19FMuMZgGAQ=;
        b=NQC1CP5XqexXR+PBFEtASRYNiKSHmgXq8iFMftbyab3pyW2qiJoUN+20wUqWQjKlEy
         ecdeUQ0TEGqdRcFrB+0ZEXzgX+Ap58iEa04vFMa8QaxXHLy49R+4WFl3HCm348089O9U
         1PfYpSMn02R9HctWI7FwY+8eMXbddR2MMrI7l9wP9MhVFBOxLmp6kONfsgsfoFDSznRk
         /q90iF3kEVboUplTRkexqewUaq8YkrDm316OtTKk048YvZCjxY7suCVJGYm+TmWKieuf
         JvCBuIWm3+xzm7ROuS6HX5IEqYe6xAqvhZxFJY5B3MsBZGq7eM8oHHAEs5lJL6r4XkgK
         49lg==
X-Gm-Message-State: AOAM5324jGo6EFADTLIbAjqTQWM9rx54SAXEXI9zozPLLCb7ilq2OUhO
        nqgGy/vCzz6yfrpo3PugRJjGe1e5poZDkdGb
X-Google-Smtp-Source: ABdhPJyvcm1oqaH6pdk6U7wD4FHgUc7pDLe1n6KSO4TaE+ulQQ9URjrQ6qbXMSc5Tk87b5wP58PX2w==
X-Received: by 2002:aa7:d2cc:: with SMTP id k12mr456377edr.374.1618427706157;
        Wed, 14 Apr 2021 12:15:06 -0700 (PDT)
Received: from localhost.localdomain ([212.86.35.110])
        by smtp.gmail.com with ESMTPSA id cq26sm363547edb.60.2021.04.14.12.15.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Apr 2021 12:15:05 -0700 (PDT)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH 1/2] repack: teach --no-prune-packed to skip `git prune-packed`
Date:   Wed, 14 Apr 2021 21:14:02 +0200
Message-Id: <20210414191403.4387-2-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.31.0.565.gcc42f43761
In-Reply-To: <20210414191403.4387-1-rafaeloliveira.cs@gmail.com>
References: <20210403090412.GH2271@szeder.dev>
 <20210414191403.4387-1-rafaeloliveira.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `git repack -d` command will remove any packfile that becomes
redundant after repacking, and then call  `git pruned-packed` for
pruning any unpacked objects. The command, however, does not offer
an option to skip the `pruned-packed` execution in order to allow
inspecting the objects before they are removed, forcing developers
to either make some temporary code changes or to manually craft
the `pack-objects` command in order to skip their deletion:

    git pack-objects --honor-pack-keep --non-empty --all --reflog \
    	--unpack-unreachable

Let’s teach `repack -d` to take --no-pruned-packed option that will
simply skip the call to `git prune-packed`, thus providing an easy
way to debug the `repack` command. This also allows us to simplify
our test suite by replacing calls to `pack-objects` with `repack`:

    git repack -A -d --no-prune-packed

Moreover, using the repack command will actually test its code path
instead of just testing the real repack operation by calling
`git pack-objects` directly. Let's refactor two tests in t7700 with
the new option.

Aside from improving our test suite, this new option will be used in
an upcoming commit for testing the behavior of `repack` with partial
clone repositories.

Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
---
 Documentation/git-repack.txt |  5 +++++
 builtin/repack.c             |  6 +++++-
 t/t7700-repack.sh            | 23 +++++++++++------------
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 317d63cf0d..6ff7a1be16 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -86,6 +86,11 @@ to the new separate pack will be written.
 	this repository (or a direct copy of it)
 	over HTTP or FTP.  See linkgit:git-update-server-info[1].
 
+--no-prune-packed::
+	Only useful with `-d`.  Do not remove redundant loose object
+	files by skipping the execution of `git prune-packed`.
+	See linkgit:git-prune-packed[1].
+
 --window=<n>::
 --depth=<n>::
 	These two options affect how the objects contained in the pack are
diff --git a/builtin/repack.c b/builtin/repack.c
index 2847fdfbab..6baaeb979c 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -452,6 +452,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	int keep_unreachable = 0;
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
 	int no_update_server_info = 0;
+	int no_prune_packed = 0;
 	struct pack_objects_args po_args = {NULL};
 	int geometric_factor = 0;
 
@@ -469,6 +470,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("pass --no-reuse-object to git-pack-objects")),
 		OPT_BOOL('n', NULL, &no_update_server_info,
 				N_("do not run git-update-server-info")),
+		OPT_BOOL(0, "no-prune-packed", &no_prune_packed,
+				N_("do not run git-prune-packed")),
 		OPT__QUIET(&po_args.quiet, N_("be quiet")),
 		OPT_BOOL('l', "local", &po_args.local,
 				N_("pass --local to git-pack-objects")),
@@ -707,7 +710,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		}
 		if (!po_args.quiet && isatty(2))
 			opts |= PRUNE_PACKED_VERBOSE;
-		prune_packed_objects(opts);
+		if (!no_prune_packed)
+			prune_packed_objects(opts);
 
 		if (!keep_unreachable &&
 		    (!(pack_everything & LOOSEN_UNREACHABLE) ||
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 25b235c063..728a16ad97 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -127,12 +127,7 @@ test_expect_success 'packed unreachable obs in alternate ODB are not loosened' '
 	git reset --hard HEAD^ &&
 	test_tick &&
 	git reflog expire --expire=$test_tick --expire-unreachable=$test_tick --all &&
-	# The pack-objects call on the next line is equivalent to
-	# git repack -A -d without the call to prune-packed
-	git pack-objects --honor-pack-keep --non-empty --all --reflog \
-	    --unpack-unreachable </dev/null pack &&
-	rm -f .git/objects/pack/* &&
-	mv pack-* .git/objects/pack/ &&
+	git repack -A -d --no-prune-packed &&
 	git verify-pack -v -- .git/objects/pack/*.idx >packlist &&
 	! grep "^$coid " packlist &&
 	echo >.git/objects/info/alternates &&
@@ -144,18 +139,22 @@ test_expect_success 'local packed unreachable obs that exist in alternate ODB ar
 	echo "$coid" | git pack-objects --non-empty --all --reflog pack &&
 	rm -f .git/objects/pack/* &&
 	mv pack-* .git/objects/pack/ &&
-	# The pack-objects call on the next line is equivalent to
-	# git repack -A -d without the call to prune-packed
-	git pack-objects --honor-pack-keep --non-empty --all --reflog \
-	    --unpack-unreachable </dev/null pack &&
-	rm -f .git/objects/pack/* &&
-	mv pack-* .git/objects/pack/ &&
+	git repack -A -d --no-prune-packed &&
 	git verify-pack -v -- .git/objects/pack/*.idx >packlist &&
 	! grep "^$coid " &&
 	echo >.git/objects/info/alternates &&
 	test_must_fail git show $coid
 '
 
+test_expect_success '-A -d and --no-prune-packed do not remove loose objects' '
+	test_create_repo repo &&
+	test_when_finished "rm -rf repo" &&
+	test_commit -C repo commit &&
+	git -C repo repack -A -d --no-prune-packed &&
+	git -C repo count-objects -v >out &&
+	grep "^prune-packable: 3" out
+'
+
 test_expect_success 'objects made unreachable by grafts only are kept' '
 	test_tick &&
 	git commit --allow-empty -m "commit 4" &&
-- 
2.31.0.565.gcc42f43761

