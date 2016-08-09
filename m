Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 714C52018E
	for <e@80x24.org>; Tue,  9 Aug 2016 04:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbcHIEOF (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 00:14:05 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34730 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbcHIEOE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 00:14:04 -0400
Received: by mail-pf0-f179.google.com with SMTP id p64so735671pfb.1
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 21:14:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GSyCeNAeOfhqEKxSeRl94hMj9BDesNkaeebG8oBYN/E=;
        b=KglJ0+qhwt5aTE+hpygDh0BMFVwN2LYDgyfIgVhjH0P6D1sFQD6n16+5sDGUpJD2xx
         ScJFyEWH2D1cCyZp6SscTJd1ntRsa3TeC21yuesVZiB2g/fJFWuocBLcFRZIU6vLUVAo
         Pmg8d6pD/v0+qSxNtO649w7zkEzhkFo9MXCUCfHfVs13wIl6V/gQtmQpfgsIPee8YTvB
         8P5/2iuH9Cm1wXKMylXyM7GPIynakJSO6y03kbgo1o7iX09RjS/HM0O3heBPntKi+tjG
         3c2pVUQucu1BQ7AXgnn1gEQEeE5ok+FLi/keTaNoEDMmYVNtPFVvA2klEa2N+8o8PI55
         u5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GSyCeNAeOfhqEKxSeRl94hMj9BDesNkaeebG8oBYN/E=;
        b=BIAKsuncrM/gyPcZKi+CMwGSYGT0zyTmM4UmGkFWGA76sPKCEghZH72Z5VLJiept+k
         wsOtDlB0Nfe1PsLtG+PYo7mqLiZUFswk7GmTgBR4UPetJG3b+w3eAhOrwxI9CYHcGTZb
         gaPxVKfpSU1YWG9cBFfr+5ChbtBmvGRS6pzJyKc3gPOkmouaNIY1OqFvpeDq7oAazLqU
         bcYOp4K2WcvUTsTqlunXtQrD39zoyrjJ4ywhiVV9b9Hercreb/FdNaM6h4pQuP046ra2
         tyuda6WLfMhmNT7QjUHMQPfouppNLZ75Evdv8AQX0zlGEGeugMF8GTGOmM1UGV2TaS/b
         OdkQ==
X-Gm-Message-State: AEkoouv1mdFgZTnBPZhNLfUx6pgb44pARWKC8WntUSAWoE1s/j3CBMjTwFT+2rfhZ9iVFNDh
X-Received: by 10.98.193.1 with SMTP id i1mr168359091pfg.66.1470715709721;
        Mon, 08 Aug 2016 21:08:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:ad25:78d3:1e25:67ef])
        by smtp.gmail.com with ESMTPSA id b134sm51486253pfb.55.2016.08.08.21.08.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 21:08:29 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Jens.Lehmann@web.de, mst@redhat.com,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 6/9] clone: implement optional references
Date:	Mon,  8 Aug 2016 21:08:07 -0700
Message-Id: <20160809040811.21408-8-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.583.gd6329be.dirty
In-Reply-To: <20160809040811.21408-1-sbeller@google.com>
References: <20160809040811.21408-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

In a later patch we want to try to create alternates for
all submodules, but they might not exist in the referenced
superproject. So add a way to skip the non existing references
and report them.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-clone.txt |  5 ++++-
 builtin/clone.c             | 32 ++++++++++++++++++++++++++------
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index ec41d3d..e316c4b 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -90,13 +90,16 @@ If you want to break the dependency of a repository cloned with `-s` on
 its source repository, you can simply run `git repack -a` to copy all
 objects from the source repository into a pack in the cloned repository.
 
---reference <repository>::
+--reference[-if-able] <repository>::
 	If the reference repository is on the local machine,
 	automatically setup `.git/objects/info/alternates` to
 	obtain objects from the reference repository.  Using
 	an already existing repository as an alternate will
 	require fewer objects to be copied from the repository
 	being cloned, reducing network and local storage costs.
+	When using the `--reference-if-able`, a non existing
+	directory is skipped with a warning instead of aborting
+	the clone.
 +
 *NOTE*: see the NOTE for the `--shared` option, and also the
 `--dissociate` option.
diff --git a/builtin/clone.c b/builtin/clone.c
index 052a769..8f3c4d4 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -51,6 +51,7 @@ static int option_progress = -1;
 static enum transport_family family;
 static struct string_list option_config = STRING_LIST_INIT_NODUP;
 static struct string_list option_required_reference = STRING_LIST_INIT_NODUP;
+static struct string_list option_optional_reference = STRING_LIST_INIT_NODUP;
 static int option_dissociate;
 static int max_jobs = -1;
 
@@ -81,6 +82,8 @@ static struct option builtin_clone_options[] = {
 		   N_("directory from which templates will be used")),
 	OPT_STRING_LIST(0, "reference", &option_required_reference, N_("repo"),
 			N_("reference repository")),
+	OPT_STRING_LIST(0, "reference-if-able", &option_optional_reference,
+			N_("repo"), N_("reference repository")),
 	OPT_BOOL(0, "dissociate", &option_dissociate,
 		 N_("use --reference only while cloning")),
 	OPT_STRING('o', "origin", &option_origin, N_("name"),
@@ -283,11 +286,22 @@ static void strip_trailing_slashes(char *dir)
 static int add_one_reference(struct string_list_item *item, void *cb_data)
 {
 	char *ref_git;
-	const char *repo;
+	const char *repo, *ref_git_s;
+	int *required = cb_data;
 	struct strbuf alternate = STRBUF_INIT;
 
-	/* Beware: read_gitfile(), real_path() and mkpath() return static buffer */
-	ref_git = xstrdup(real_path(item->string));
+	ref_git_s = *required ?
+			real_path(item->string) :
+			real_path_if_valid(item->string);
+	if (!ref_git_s) {
+		warning(_("Not using proposed alternate %s"), item->string);
+		return 0;
+	} else
+		/*
+		 * Beware: read_gitfile(), real_path() and mkpath()
+		 * return static buffer
+		 */
+		ref_git = xstrdup(ref_git_s);
 
 	repo = read_gitfile(ref_git);
 	if (!repo)
@@ -304,7 +318,8 @@ static int add_one_reference(struct string_list_item *item, void *cb_data)
 	} else if (!is_directory(mkpath("%s/objects", ref_git))) {
 		struct strbuf sb = STRBUF_INIT;
 		if (get_common_dir(&sb, ref_git))
-			die(_("reference repository '%s' as a linked checkout is not supported yet."),
+			die(_("reference repository '%s' as a "
+			      "linked checkout is not supported yet."),
 			    item->string);
 		die(_("reference repository '%s' is not a local repository."),
 		    item->string);
@@ -325,7 +340,12 @@ static int add_one_reference(struct string_list_item *item, void *cb_data)
 
 static void setup_reference(void)
 {
-	for_each_string_list(&option_required_reference, add_one_reference, NULL);
+	int required = 1;
+	for_each_string_list(&option_required_reference,
+			     add_one_reference, &required);
+	required = 0;
+	for_each_string_list(&option_optional_reference,
+			     add_one_reference, &required);
 }
 
 static void copy_alternates(struct strbuf *src, struct strbuf *dst,
@@ -977,7 +997,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	git_config_set(key.buf, repo);
 	strbuf_reset(&key);
 
-	if (option_required_reference.nr)
+	if (option_required_reference.nr || option_optional_reference.nr)
 		setup_reference();
 
 	fetch_pattern = value.buf;
-- 
2.9.2.583.gd6329be.dirty

