Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2B751F461
	for <e@80x24.org>; Mon, 26 Aug 2019 21:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfHZVrm (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 17:47:42 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:33728 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbfHZVrm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 17:47:42 -0400
Received: by mail-pl1-f201.google.com with SMTP id f5so10741342plr.0
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 14:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=EWkKb740kh+im8qsxx+0rTR0JgxNUbcuB8pp8Hgpn18=;
        b=bWsfHZNMcyZzzKz9krwzDai6oxMrix/1a++4SRW1cfeF5mRrX68R/MiyuIdup5wN85
         LoY9F54RBC6+09ZEH7SeCHVIeIKgULXL5NoypJy+FtNep43HGrtHIAkpdHFey+Y8CCnO
         sAoirnWnZaPMi47EmNrt/fApwgf8iYxXPg3yOmGney7HhQqY1tCbkfmvBSvLdT1bRbR5
         D/+KrEpigTMoQOksU1XgH7N8uEEtdgCBbAEsS3RMvXTwrATXvxi7k2w1yMb3tZ2flQ+C
         a+dDWtDX3PMHS5+Gz934wXzOqBM3GOfCgZFAYLERYrp3hE/o0SeyIPVRbDRthMel7rND
         cSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=EWkKb740kh+im8qsxx+0rTR0JgxNUbcuB8pp8Hgpn18=;
        b=kKBJUC/R4KWvW7RrwkGp+bgCcKS9MpNr5XJE+gm7pjffOJ4Qh3P3MzDr0uDL625/Y4
         cUY/oBefrot4gyEHJbYxXE3mCkIEijnGT6GQSY7H7hE9uNpXPKNQgTbp/SngLqusi+wZ
         28Oy6AcAMgw83yh8OHyveHcS4uo8YebwTsw0XlH0NoCH1DBA3KI0cZ+gIGcO/Y+bWow6
         XGdHc1Py3dORcpdyrHxWp4AbtgXEL1KYoug99oF0qMHnmztO6F1coVYMxBayVxxzkaL7
         /jCHA+AnMT9vrWkdiXf0Ff6b1fLB9AP+CmmDRa2V2GpI4rQXzqzxatJppumkrBUZl8Y1
         eYMw==
X-Gm-Message-State: APjAAAWz0w7mXNML9yMqyCZSxigCH/BHQiVcOZs0AxZyYBKiPxLElRz6
        1AqQ/1Cmy0mRQUxZR18ZlWCvyOvZnPlOBaD/MPBMITJrr8SyBRQvzqHsEtmeOOc2y7zsdQLYMkP
        Q++JgB8BxjWKCYqSRH73Lnue47wYkjbzO71xrWmUzGtTRiWE9/Q+nD7ArN6RwKFOFrjHjHZp3o3
        94
X-Google-Smtp-Source: APXvYqwXqMNDUj9pmhu1Uku30FfwU/nhYMPWlLTeQ/050wboJ9ZSJ2NHjJs5W9DwloJgcdKnQjqQ1m9J+oxmQP9nJ3Zn
X-Received: by 2002:a63:2744:: with SMTP id n65mr18187449pgn.277.1566856060786;
 Mon, 26 Aug 2019 14:47:40 -0700 (PDT)
Date:   Mon, 26 Aug 2019 14:47:37 -0700
Message-Id: <20190826214737.164132-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH] fetch-pack: write fetched refs to .promisor
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The specification of promisor packfiles (in partial-clone.txt) states
that the .promisor files that accompany packfiles do not matter (just
like .keep files), so whenever a packfile is fetched from the promisor
remote, Git has been writing empty .promisor files. But these files
could contain more useful information.

So instead of writing empty files, write the refs fetched to these
files. This makes it easier to debug issues with partial clones, as we
can identify what refs (and their associated hashes) were fetched at the
time the packfile was downloaded, and if necessary, compare those hashes
against what the promisor remote reports now.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
As written in the NEEDSWORK comment, repack does not preserve the
contents of .promisor files, but I thought I'd send this out anyway as
this change is already useful for users who don't run repack much.
---
 builtin/repack.c         |  5 +++++
 fetch-pack.c             | 41 ++++++++++++++++++++++++++++++++++++----
 t/t5616-partial-clone.sh |  8 ++++++++
 3 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 632c0c0a79..8c1621d414 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -232,6 +232,11 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 		/*
 		 * pack-objects creates the .pack and .idx files, but not the
 		 * .promisor file. Create the .promisor file, which is empty.
+		 *
+		 * NEEDSWORK: fetch-pack generates non-empty .promisor files,
+		 * but this would not preserve their contents. Maybe
+		 * concatenate the contents of all .promisor files instead of
+		 * just creating a new empty file.
 		 */
 		promisor_name = mkpathdup("%s-%s.promisor", packtmp,
 					  line.buf);
diff --git a/fetch-pack.c b/fetch-pack.c
index 65be043f2a..07029e1bbf 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -758,8 +758,33 @@ static int sideband_demux(int in, int out, void *data)
 	return ret;
 }
 
+static void write_promisor_file(const char *keep_name,
+				struct ref **sought, int nr_sought)
+{
+	struct strbuf promisor_name = STRBUF_INIT;
+	int suffix_stripped;
+	FILE *output;
+	int i;
+
+	strbuf_addstr(&promisor_name, keep_name);
+	suffix_stripped = strbuf_strip_suffix(&promisor_name, ".keep");
+	if (!suffix_stripped)
+		BUG("name of pack lockfile should end with .keep (was '%s')",
+		    keep_name);
+	strbuf_addstr(&promisor_name, ".promisor");
+
+	output = xfopen(promisor_name.buf, "w");
+	for (i = 0; i < nr_sought; i++)
+		fprintf(output, "%s %s\n", oid_to_hex(&sought[i]->old_oid),
+			sought[i]->name);
+	fclose(output);
+
+	strbuf_release(&promisor_name);
+}
+
 static int get_pack(struct fetch_pack_args *args,
-		    int xd[2], char **pack_lockfile)
+		    int xd[2], char **pack_lockfile,
+		    struct ref **sought, int nr_sought)
 {
 	struct async demux;
 	int do_keep = args->keep_pack;
@@ -821,7 +846,13 @@ static int get_pack(struct fetch_pack_args *args,
 		}
 		if (args->check_self_contained_and_connected)
 			argv_array_push(&cmd.args, "--check-self-contained-and-connected");
-		if (args->from_promisor)
+		/*
+		 * If we're obtaining the filename of a lockfile, we'll use
+		 * that filename to write a .promisor file with more
+		 * information below. If not, we need index-pack to do it for
+		 * us.
+		 */
+		if (!(do_keep && pack_lockfile) && args->from_promisor)
 			argv_array_push(&cmd.args, "--promisor");
 	}
 	else {
@@ -859,6 +890,8 @@ static int get_pack(struct fetch_pack_args *args,
 		die(_("fetch-pack: unable to fork off %s"), cmd_name);
 	if (do_keep && pack_lockfile) {
 		*pack_lockfile = index_pack_lockfile(cmd.out);
+		if (args->from_promisor)
+			write_promisor_file(*pack_lockfile, sought, nr_sought);
 		close(cmd.out);
 	}
 
@@ -1009,7 +1042,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 		alternate_shallow_file = setup_temporary_shallow(si->shallow);
 	else
 		alternate_shallow_file = NULL;
-	if (get_pack(args, fd, pack_lockfile))
+	if (get_pack(args, fd, pack_lockfile, sought, nr_sought))
 		die(_("git fetch-pack: fetch failed."));
 
  all_done:
@@ -1458,7 +1491,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 
 			/* get the pack */
 			process_section_header(&reader, "packfile", 0);
-			if (get_pack(args, fd, pack_lockfile))
+			if (get_pack(args, fd, pack_lockfile, sought, nr_sought))
 				die(_("git fetch-pack: fetch failed."));
 
 			state = FETCH_DONE;
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 565254558f..486db27ee0 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -46,6 +46,14 @@ test_expect_success 'do partial clone 1' '
 	test "$(git -C pc1 config --local core.partialclonefilter)" = "blob:none"
 '
 
+test_expect_success 'verify that .promisor file contains refs fetched' '
+	ls pc1/.git/objects/pack/pack-*.promisor >promisorlist &&
+	test_line_count = 1 promisorlist &&
+	git -C srv.bare rev-list HEAD >headhash &&
+	grep "$(cat headhash) HEAD" $(cat promisorlist) &&
+	grep "$(cat headhash) refs/heads/master" $(cat promisorlist)
+'
+
 # checkout master to force dynamic object fetch of blobs at HEAD.
 test_expect_success 'verify checkout with dynamic object fetch' '
 	git -C pc1 rev-list --quiet --objects --missing=print HEAD >observed &&
-- 
2.23.0.187.g17f5b7556c-goog

