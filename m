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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3D6C433B4
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 14:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFC2B610CB
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 14:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbhDROAq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Apr 2021 10:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbhDROAp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Apr 2021 10:00:45 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187E1C06174A
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 07:00:17 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id s15so37586988edd.4
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 07:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ppo6vxZJLw6tA5rti2BglT0Ydh6Kaqa+0wXT+hqlp4A=;
        b=G8ITZKfEZwOsWDV8q5ZyBH9VRKJl2nsBIK9MBfo2eynHQsjslJLc8+agHOOU3opN7e
         rliJIbFFD8ERNJRjKtA2uXlhYEWn599JBqxTG/loLzx85V0O84sKcPxcm0ejdXWRohQW
         8+6bE6QnxO/WBMQpPc3KGGN7LcoY5AklKi5JJXXqDEGIWmQwpa5gao48Pdn+VXhGhdlD
         OCIZlMgMU5ZUaUrM6q8nhkjUA2UY49q7CxUG9OADf6P/iLOPNBiayCY/h/AbUdjzJj8s
         LJ6L+biXI+AiNAO1BRRKwLZYXchZiZtb5odP+6cDV+PigYqcYM+DAnN7Tk3mpaAfJLX5
         cEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ppo6vxZJLw6tA5rti2BglT0Ydh6Kaqa+0wXT+hqlp4A=;
        b=V8hvhc6NSZiK//HjbVldMbVJIZQYqWycRtdT0Od5DRqKhkysUcyXI7T/VqXtEFuRUA
         CBs7ae7FI0y91UqMfmpojWWLAwpBNwnH0VjeNDB5T90cXeqS1/Qgo9S4g0//6SVEA76C
         oUBsHcRE+FoNveBBX9jZN5lSdKxyKfleQ7NZlcM47uDW/ZqhcEDFbD9hFtyCucpr7imO
         pEFJvXrsONaRV3hoj7Ys0nKlGZeqrVVaig6k2yJEDWdZbFAyFvgxHi7pm/OqMAhO0ehC
         68KjfHbfmIBOlQpxHPKTbOSHCS6qRKLYM3N12XJ1HI3o64lf4FKTf6SAqZOaTTgjJV5S
         I4Xg==
X-Gm-Message-State: AOAM533iKdOLSDTBDqCfZO/jixStM4JdTZWGANFZkEat8A5YsWwBNO46
        wh1UIz5p1gN9KljJ2clChMCPrLoi4l4Dz2s2
X-Google-Smtp-Source: ABdhPJxSe/o5tVoMnyATrnvlxnsjtni3Use9jr140c7YlKcCnolV9RmaQ40Qc8z9jnImkSUr0UXJHw==
X-Received: by 2002:a05:6402:cb4:: with SMTP id cn20mr5518923edb.167.1618754415467;
        Sun, 18 Apr 2021 07:00:15 -0700 (PDT)
Received: from localhost.localdomain ([79.140.115.143])
        by smtp.gmail.com with ESMTPSA id w13sm9823415edx.80.2021.04.18.07.00.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Apr 2021 07:00:14 -0700 (PDT)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH v2 1/1] repack: avoid loosening promisor objects in partial clones
Date:   Sun, 18 Apr 2021 15:57:49 +0200
Message-Id: <20210418135749.27152-2-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.31.0.699.g8849f49b87
In-Reply-To: <20210418135749.27152-1-rafaeloliveira.cs@gmail.com>
References: <20210414191403.4387-1-rafaeloliveira.cs@gmail.com>
 <20210418135749.27152-1-rafaeloliveira.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When `git repack -A -d` is run in a partial clone, `pack-objects`
is invoked twice: once to repack all promisor objects, and once to
repack all non-promisor objects. The latter `pack-objects` invocation
is with --exclude-promisor-objects and --unpack-unreachable, which
loosens all unused objects. Unfortunately, this includes promisor
objects.

Because the -d argument to `git repack` subsequently deletes all loose
objects also in packs, these just-loosened promisor objects will be
immediately deleted. However, this extra disk churn is unnecessary in
the first place.  For example, a newly-clone partial repo that filters
all blob objects (e.g. `--filter=blob:none`), `repack` ends up
unpacking all trees and commits into the filesystem because every
object, in this particular case, is a promisor object. Depending on
the repo size, this increases the disk usage considerably: In my copy
of the linux.git, the object directory peaked 26GB of more disk usage.

In order to avoid this extra disk churn, pass the names of the promisor
packfiles as --keep-pack arguments to the second invocation of
`pack-objects`. This informs `pack-objects` that the promisor objects
are already in a safe packfile and, therefore, do not need to be
loosened. The --keep-pack option takes only a packfile name, but we
concatenate both the path and the name in a single string. Instead,
let's split them into separate string in order to easily pass the
packfile name later.

For testing, we need to validate whether any object was loosened.
However, the "evidence" (loosened objects) is deleted during the
process which prevents us from inspecting the object directory.
Instead, let's teach `pack-objects` to count loosened objects and
emit via trace2 thus allowing inspecting the debug events after the
process is finished. This new event is used on the added regression
test.

Lastly, add a new perf test to evaluate the performance impact
made by this changes (tested on git.git):

     Test          HEAD^                 HEAD
     ----------------------------------------------------------
     5600.3: gc    134.38(41.93+90.95)   7.80(6.72+1.35) -94.2%

For a bigger repository, such as linux.git, the improvement is
even bigger:

     Test          HEAD^                     HEAD
     -------------------------------------------------------------------
     5600.3: gc    6833.00(918.07+3162.74)   268.79(227.02+39.18) -96.1%

These improvements are particular big because every object in the
newly-cloned partial repository is a promisor object.

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Helped-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
---
 builtin/pack-objects.c        | 8 +++++++-
 builtin/repack.c              | 9 +++++++--
 t/perf/p5600-partial-clone.sh | 4 ++++
 t/t5616-partial-clone.sh      | 8 ++++++++
 4 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 40ee6fa19f..73889cec95 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3479,6 +3479,7 @@ static void loosen_unused_packed_objects(void)
 {
 	struct packed_git *p;
 	uint32_t i;
+	uint32_t loosened_objects_nr = 0;
 	struct object_id oid;
 
 	for (p = get_all_packs(the_repository); p; p = p->next) {
@@ -3492,11 +3493,16 @@ static void loosen_unused_packed_objects(void)
 			nth_packed_object_id(&oid, p, i);
 			if (!packlist_find(&to_pack, &oid) &&
 			    !has_sha1_pack_kept_or_nonlocal(&oid) &&
-			    !loosened_object_can_be_discarded(&oid, p->mtime))
+			    !loosened_object_can_be_discarded(&oid, p->mtime)) {
 				if (force_object_loose(&oid, p->mtime))
 					die(_("unable to force loose object"));
+				loosened_objects_nr++;
+			}
 		}
 	}
+
+	trace2_data_intmax("pack-objects", the_repository,
+			   "loosen_unused_packed_objects/loosened", loosened_objects_nr);
 }
 
 /*
diff --git a/builtin/repack.c b/builtin/repack.c
index 2847fdfbab..5f9bc74adc 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -20,7 +20,7 @@ static int delta_base_offset = 1;
 static int pack_kept_objects = -1;
 static int write_bitmaps = -1;
 static int use_delta_islands;
-static char *packdir, *packtmp;
+static char *packdir, *packtmp_name, *packtmp;
 
 static const char *const git_repack_usage[] = {
 	N_("git repack [<options>]"),
@@ -530,7 +530,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	}
 
 	packdir = mkpathdup("%s/pack", get_object_directory());
-	packtmp = mkpathdup("%s/.tmp-%d-pack", packdir, (int)getpid());
+	packtmp_name = xstrfmt(".tmp-%d-pack", (int)getpid());
+	packtmp = mkpathdup("%s/%s", packdir, packtmp_name);
 
 	sigchain_push_common(remove_pack_on_signal);
 
@@ -573,6 +574,10 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		repack_promisor_objects(&po_args, &names);
 
 		if (existing_packs.nr && delete_redundant) {
+			for_each_string_list_item(item, &names) {
+				strvec_pushf(&cmd.args, "--keep-pack=%s-%s.pack",
+					     packtmp_name, item->string);
+			}
 			if (unpack_unreachable) {
 				strvec_pushf(&cmd.args,
 					     "--unpack-unreachable=%s",
diff --git a/t/perf/p5600-partial-clone.sh b/t/perf/p5600-partial-clone.sh
index ca785a3341..a965f2c4d6 100755
--- a/t/perf/p5600-partial-clone.sh
+++ b/t/perf/p5600-partial-clone.sh
@@ -35,4 +35,8 @@ test_perf 'count non-promisor commits' '
 	git -C bare.git rev-list --all --count --exclude-promisor-objects
 '
 
+test_perf 'gc' '
+	git -C bare.git gc
+'
+
 test_done
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 5cb415386e..6e3e7565d0 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -548,6 +548,14 @@ test_expect_success 'fetch from a partial clone, protocol v2' '
 	grep "version 2" trace
 '
 
+test_expect_success 'repack does not loosen promisor objects' '
+	rm -rf client trace &&
+	git clone --bare --filter=blob:none "file://$(pwd)/srv.bare" client &&
+	test_when_finished "rm -rf client trace" &&
+	GIT_TRACE2_PERF="$(pwd)/trace" git -C client repack -A -d &&
+	grep "loosen_unused_packed_objects/loosened:0" trace
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
2.31.0.699.g8849f49b87

