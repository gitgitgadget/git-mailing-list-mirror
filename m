Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96725C433F5
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 02:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344234AbiBICkn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 21:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244514AbiBICKM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 21:10:12 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CE2C061348
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 18:10:11 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id j5-20020a05600c1c0500b0034d2e956aadso532149wms.4
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 18:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1HGnQLW1zcbVY24YYNTMgiHKWstYD0uwXQGiNdsBJok=;
        b=Iv8d7/sbUrIjMq2S+6H12l6F0desGIckblwZPQ2Y7p6F7NcwOs9Pr2kFYNIcNDPcm8
         dGzLY+P6bTXf38Axa8YRb9BWL8TiM65xd45JoHMv9eqtj1pYq3cYaJ/IGol4rly6mwOa
         XvLeJRiZ2PmsNqzh5yNdC4J8YzTM2YTzmr4jIMQhqGVkjiO/biqSP+l/dR/Cpvxvp387
         sTabDAwpHeTcXwFdDZWTB5ITtuMIJbmrWTdfdQbX6icfsQpdPUOaeZa+BooK8H4V+7t5
         qbsQL5gcndZADQeONajWHMsN3pX/OZkQohkk8R8GImdOyrhz2cKAJsmNScRjHUYP/EQh
         GUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1HGnQLW1zcbVY24YYNTMgiHKWstYD0uwXQGiNdsBJok=;
        b=uWUrmkEH/w9L/LduMe2jshkUKPCt0w8MZIgRMTxeb38soIzJ86QhcSjKvj++f+r4Iq
         Sf7+4Ok7Q/wGY7l+WdM63fLvbsuRYyoS6TpIVQntAEXkksFfY9MmoPvT9F05MouuOYX4
         /rZIatYoSBHvnQRnKHRSsuAQ/6dai47BYFhu77bN054p5UmtMpOy3TLUeSo8zi6pjk27
         HpddNJLlhEG7xu7rypixjSzQrlvVI8RdcvH+6/lNS07CvYvca4QoDdnedGQScek6dI/C
         XPd9bBIyucSw6kkSPNqc+zZt7Pcc7JJDfP7npLvu6wIoAQYzosgSVAYNZUj+T5L9NevN
         2sjg==
X-Gm-Message-State: AOAM5313kzR1vwRgplO23JuuNG57TPyRjiw4NBPlI33SwCet/IJyS9So
        +tOOkVLNWPpZbvquYTQ9CCjLD/fYYAg=
X-Google-Smtp-Source: ABdhPJz/YPuaZRNj8angScAb9Std8d+bfRlzv0q+DHVtNl3jFe6TVPYSZlAnzkLHaHjdPmVN50dpbA==
X-Received: by 2002:a05:600c:4295:: with SMTP id v21mr636196wmc.19.1644372609608;
        Tue, 08 Feb 2022 18:10:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m5sm4006776wms.4.2022.02.08.18.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 18:10:09 -0800 (PST)
Message-Id: <6e7c8410b8dcd2f4a7e188eb5b55ae8eecb54e40.1644372606.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1206.v2.git.git.1644372606.gitgitgadget@gmail.com>
References: <pull.1206.git.git.1643248180.gitgitgadget@gmail.com>
        <pull.1206.v2.git.git.1644372606.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Feb 2022 02:10:04 +0000
Subject: [PATCH v2 2/4] repack: add --filter=<filter-spec> option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

In order to use a separate http server as a remote to offload large
blobs, imagine the following:

A. an http server to use as a generalized object store.
B. a server update hook that uploads large blobs to (A).
C. a git server
D. a remote helper that knows how to download objects from the http
server
E. a regular job that runs `git repack --filter` to remove large
blobs from (C).

Clients would need to configure both (C) and (A) as promisor remotes to
be able to get everything. When they push new large blobs, they can
still push them to (C), as (B) will upload them to (A), and (E) will
regularly remove those large blobs from (C).

This way with a little bit of client and server configuration, we can
have a native way to support offloading large files without git LFS.
It would be more flexible as you can easily tweak which blobs are
considered large files by tweaking (B) and (E).

A fuller demo can be found at http://tiny.cc/object_storage_demo

Based-on-patch-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: John Cai <johncai86@gmail.com>
---
 Documentation/git-repack.txt |  5 +++++
 builtin/repack.c             | 22 +++++++++++++++-------
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index ee30edc178a..e394ec52ab1 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -126,6 +126,11 @@ depth is 4095.
 	a larger and slower repository; see the discussion in
 	`pack.packSizeLimit`.
 
+--filter=<filter-spec>::
+	Omits certain objects (usually blobs) from the resulting
+	packfile. See linkgit:git-rev-list[1] for valid
+	`<filter-spec>` forms.
+
 -b::
 --write-bitmap-index::
 	Write a reachability bitmap index as part of the repack. This
diff --git a/builtin/repack.c b/builtin/repack.c
index da1e364a756..3f1e8a39a2b 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -152,6 +152,7 @@ struct pack_objects_args {
 	const char *depth;
 	const char *threads;
 	const char *max_pack_size;
+	const char *filter;
 	int no_reuse_delta;
 	int no_reuse_object;
 	int quiet;
@@ -172,6 +173,8 @@ static void prepare_pack_objects(struct child_process *cmd,
 		strvec_pushf(&cmd->args, "--threads=%s", args->threads);
 	if (args->max_pack_size)
 		strvec_pushf(&cmd->args, "--max-pack-size=%s", args->max_pack_size);
+	if (args->filter)
+		strvec_pushf(&cmd->args, "--filter=%s", args->filter);
 	if (args->no_reuse_delta)
 		strvec_pushf(&cmd->args, "--no-reuse-delta");
 	if (args->no_reuse_object)
@@ -238,6 +241,13 @@ static unsigned populate_pack_exts(char *name)
 	return ret;
 }
 
+static void write_promisor_file_1(char *p)
+{
+	char *promisor_name = mkpathdup("%s-%s.promisor", packtmp, p);
+	write_promisor_file(promisor_name, NULL, 0);
+	free(promisor_name);
+}
+
 static void repack_promisor_objects(const struct pack_objects_args *args,
 				    struct string_list *names)
 {
@@ -269,7 +279,6 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 	out = xfdopen(cmd.out, "r");
 	while (strbuf_getline_lf(&line, out) != EOF) {
 		struct string_list_item *item;
-		char *promisor_name;
 
 		if (line.len != the_hash_algo->hexsz)
 			die(_("repack: Expecting full hex object ID lines only from pack-objects."));
@@ -286,13 +295,8 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 		 * concatenate the contents of all .promisor files instead of
 		 * just creating a new empty file.
 		 */
-		promisor_name = mkpathdup("%s-%s.promisor", packtmp,
-					  line.buf);
-		write_promisor_file(promisor_name, NULL, 0);
-
+		write_promisor_file_1(line.buf);
 		item->util = (void *)(uintptr_t)populate_pack_exts(item->string);
-
-		free(promisor_name);
 	}
 	fclose(out);
 	if (finish_command(&cmd))
@@ -660,6 +664,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("limits the maximum number of threads")),
 		OPT_STRING(0, "max-pack-size", &po_args.max_pack_size, N_("bytes"),
 				N_("maximum size of each packfile")),
+		OPT_STRING(0, "filter", &po_args.filter, N_("args"),
+				N_("object filtering")),
 		OPT_BOOL(0, "pack-kept-objects", &pack_kept_objects,
 				N_("repack objects in packs marked with .keep")),
 		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
@@ -819,6 +825,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		if (line.len != the_hash_algo->hexsz)
 			die(_("repack: Expecting full hex object ID lines only from pack-objects."));
 		string_list_append(&names, line.buf);
+		if (po_args.filter)
+			write_promisor_file_1(line.buf);
 	}
 	fclose(out);
 	ret = finish_command(&cmd);
-- 
gitgitgadget

