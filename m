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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725A9C43460
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 19:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44DAC61220
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 19:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353220AbhDNTPe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 15:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352685AbhDNTPb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 15:15:31 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC52C061756
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 12:15:09 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id w3so33118398ejc.4
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 12:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=echYCociiTf862YPNWC7ZjpOg4edVypXWw6+pwt1WvM=;
        b=YMrumJ1NrGPCNOENXbnvdl0U7+K0n9oDWD6JQx/ld+o7dLbwbZdhYoFLKv0GARhoXy
         qRQjQWJ2sym6+lsAg1Qaokxwr1WXpNfN1QA4SLqKlzcAMJOjMzrHQfc1rc5HNzffvQ2C
         PeaWJjp6wc2rVbUv8RN/XtmfDftpCyo4fHT0Wb4rB6x/GEqhmu1KS8A9yeUfQq0qmER6
         dIyuagd5L1S8EKG9ddB0nBxYN6DBMvDNf8pXH9a9GG1Sny9bQw1OQBeLJeCTArHR03Ym
         8XLgwllPgvi8HNgJbiSysJ/4T/cmfxbombr0EpeAfSNYBjPA4Kr0U5ozWu5OgEHRZVvv
         LnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=echYCociiTf862YPNWC7ZjpOg4edVypXWw6+pwt1WvM=;
        b=XWjr5b1vAK3iLsmBE7mO0N4Za9kEkIspBDlp3a1f8LeIzjbW7lIJQ5iSbFpOynWSyW
         eITAP1ur/lSuFWlpHx6jFG1MZr2vCGX3Sjdmyeqom2Bl+DnfcJ+NxsBIFubsWgyn4PpY
         RjSZH+YqPMjvNnyFK8FasgsHTeOdJCMyWTWeshZyg/gnzxTVzIobkArccpdF3ew1UTs5
         LtacOooxm6Ie1OLhRyeC1AaohObVDZ2FH2sRMpNyOvY1f5Fyq18hKA+apwSF13y5IVrx
         QT+5Nybe/CDZnnmM4MjwEncp6bb0e8eeKb0NVZt+Us70JzVy9knVB8vCYWzSn+hL+VuI
         FoSw==
X-Gm-Message-State: AOAM530buFsM5cGtTuz5x/ZRksgkl3BHO/nm21DBdR7Lg8nxkkTYDMbQ
        PavGKUwkduTznyEZYLQn2pgUjM+gkdPnS4wH
X-Google-Smtp-Source: ABdhPJxu5tp570R0+YgRS/T0ea1ImB90uEd4496GAJtKGGuzRn5rkPiqm/aYPTorG1enGFuZs/u/mg==
X-Received: by 2002:a17:907:98ae:: with SMTP id ju14mr379210ejc.287.1618427707225;
        Wed, 14 Apr 2021 12:15:07 -0700 (PDT)
Received: from localhost.localdomain ([212.86.35.110])
        by smtp.gmail.com with ESMTPSA id cq26sm363547edb.60.2021.04.14.12.15.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Apr 2021 12:15:06 -0700 (PDT)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH 2/2] repack: avoid loosening promisor pack objects in partial clones
Date:   Wed, 14 Apr 2021 21:14:03 +0200
Message-Id: <20210414191403.4387-3-rafaeloliveira.cs@gmail.com>
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

When `-A` and `-d` are used together, besides packing all objects (-A)
and removing redundant packs (-d), it also unpack all unreachable
objects and deletes them by calling `git pruned-packed`. For a partial
clone, that contains unreferenced objects, this results in unpacking
all "promisor" objects and deleting them right after, which
unnecessarily increases the `repack` execution time and disk usage
during the unpacking of the objects.

For instance, a partially cloned repository that filters all the blob
objects (e.g. "--filter=blob:none"), `repack` ends up unpacking all
blobs into the filesystem that, depending on the repo size, makes
nearly impossible to repack the operation before running out of disk.

For a partial clone, `git repack` calls `git pack-objects` twice: (1)
for handle the "promisor" objects and (2) for performing the repack
with --exclude-promisor-objects option, that results in unpacking and
deleting of the objects. Given that we actually should keep the
promisor objects, let's teach `repack` to tell `pack-objects` to
--keep the old "promisor" pack file.

The --keep-pack option takes only a packfile name, but we concatenate
both the path and the name in a single string. Instead, let's split
them into separate string in order to easily pass the packfile name
later.

Additionally, add a new perf test to evaluate the performance
impact made by this changes (tested on git.git):

    Test            HEAD^                 HEAD
    ------------------------------------------------------------
    5600.5: gc      137.67(42.48+93.64)   8.08(6.91+1.45) -94.1%

In this particular script, the improvement is big because every
object in the newly-cloned partial repository is a promisor object.

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
---
 builtin/repack.c              | 9 +++++++--
 t/perf/p5600-partial-clone.sh | 4 ++++
 t/t5616-partial-clone.sh      | 9 +++++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 6baaeb979c..0ecd76b79c 100644
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
@@ -533,7 +533,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	}
 
 	packdir = mkpathdup("%s/pack", get_object_directory());
-	packtmp = mkpathdup("%s/.tmp-%d-pack", packdir, (int)getpid());
+	packtmp_name = xstrfmt(".tmp-%d-pack", (int)getpid());
+	packtmp = mkpathdup("%s/%s", packdir, packtmp_name);
 
 	sigchain_push_common(remove_pack_on_signal);
 
@@ -576,6 +577,10 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
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
index 5cb415386e..de77822735 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -548,6 +548,15 @@ test_expect_success 'fetch from a partial clone, protocol v2' '
 	grep "version 2" trace
 '
 
+test_expect_success 'repack does not loose all objects' '
+	rm -rf client &&
+	git clone --bare --filter=blob:none "file://$(pwd)/srv.bare" client &&
+	test_when_finished "rm -rf client" &&
+	git -C client repack -A -l -d --no-prune-packed &&
+	git -C client count-objects -v >object-count &&
+	grep "^prune-packable: 0" object-count
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
2.31.0.565.gcc42f43761

