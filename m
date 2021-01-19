Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457C6C433E0
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E09D22DD3
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbhASX15 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 18:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbhASXZ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 18:25:27 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90FBC061573
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 15:24:32 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id h21so1068509qvb.8
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 15:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vMg3iNL7GQNFeaafXKuZoT1WiGmc3XlfB+ZCi3J578I=;
        b=sp23Gr4WekDK3K4IpdNfIfTF03niCE2REtcV0TkQBMxrt0rqtnvRmx/siBgObDGrM+
         2g9lwp2AzM5nRhgq6dRdYqZfvaVnUwKPA3JuX0Nqr5ucquYIXsPbrqsQVSnRzvUlUuOx
         ewKUqfIcAhrd89sOXpKVA8MFATPVxR6UU6AeBePVDhSv3xL3vSH8b/ACMk1EGPa8KOoI
         uHeenaeN+8I9MNjVC4eVsPqCGJbBshvwsmJ4By/MrX+mNuJHcgAD8bCuwa8q+NmwpEzV
         pS8fR8u16gl55HC5f5RIO9xutwjBNV1vx9HbgwsV4tLlQYY1J1dMoqn/fAB2LrZ+dkyU
         SO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vMg3iNL7GQNFeaafXKuZoT1WiGmc3XlfB+ZCi3J578I=;
        b=d/T/U2crEjNCwqURSxksRQTyetFm7k4R4SH1bi4Y1l9pO+P7Psyr/zLvrteM4X9c6o
         w7TZYv7rIX2rNxjDh57ndA0bnke/r07HTNW6BJ2/RMAzmOjm9zanMMSSvYuhXNy+Ld7F
         gSS4tH6X5cb4Kk/4UPQ1YJCh6Ef8VatRILXyqMFGjom674bXSspSaUkE1nuDBWKDacw4
         CKcYVKjzmBm6hcc9030kLsFaZksgkTfWy/DP9tlA+Hjl53Tab7iyP2UkCnp/E10Hy2JW
         w49D+Z5eWzH4oXlORyfrKqYHVfm0spF62z2Sz2GenRY9vxVzRMIJ2jAc2LJksxaT+Yyf
         PfHQ==
X-Gm-Message-State: AOAM5304L/2c6ex/c4dromWoH61LwTxzWVpPRrBCoj/2J7WU1q2p6huL
        AbyojLXgIX2QK9sZpsjtGtkJ6Uo60G2uug==
X-Google-Smtp-Source: ABdhPJyoWAWZVVvcSHuUddBGLG1FU1ZeE50kNKej9qzqZ61EwHc4wXgR3pCfyjqwNrWVUDluvJG9EQ==
X-Received: by 2002:a0c:9e5e:: with SMTP id z30mr6955904qve.56.1611098671892;
        Tue, 19 Jan 2021 15:24:31 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:ed38:94a5:e78e:2d58])
        by smtp.gmail.com with ESMTPSA id k7sm89748qtg.65.2021.01.19.15.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 15:24:31 -0800 (PST)
Date:   Tue, 19 Jan 2021 18:24:29 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com
Subject: [PATCH 08/10] builtin/pack-objects.c: teach '--keep-pack-stdin'
Message-ID: <6547c082f8f2b696f8711295bdeb4a24a09dffe5.1611098616.git.me@ttaylorr.com>
References: <cover.1611098616.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1611098616.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a shortcut to specify '--keep-pack=<pack-name>' arguments over
stdin, in case a caller wishes to indicate more kept packs than the
argument limit will allow.

Passing this option overrides any other option to 'git pack-objects'
that takes input over stdin. For example, '--revs' still forces a
reachability traversal, but will not accept any revision arguments over
stdin. Use of '--keep-pack-stdin' within Git is limited to one caller
(added in a subsequent patch) which does not pass any other input over
stdin.

No new tests are added here, since a caller from 'git repack' will
exercise these options in a subsequent patch.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-pack-objects.txt |  8 ++++++++
 builtin/pack-objects.c             | 23 ++++++++++++++++++++---
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index cbe08e7415..45ecc4e9e5 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -135,6 +135,14 @@ depth is 4095.
 	leading directory (e.g. `pack-123.pack`). The option could be
 	specified multiple times to keep multiple packs.
 
+--keep-pack-stdin::
+	Take a list of line-delimited `<pack-name>` arguments, treating
+	them as if they were each passed as `--keep-pack=<pack-name>`.
+	Useful for when many packs are being kept to avoid argument
+	length limitations. Requires that `--revs` be passed or implied,
+	but does not allow the caller to pass additional traversal
+	arguments over standard input.
+
 --assume-kept-packs-closed::
 	This flag causes `git rev-list` to halt the object traversal
 	when it encounters an object found in a kept pack. This is
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f2c7a1e35b..f528a07d78 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3343,7 +3343,7 @@ static void record_recent_commit(struct commit *commit, void *data)
 	oid_array_append(&recent_objects, &commit->object.oid);
 }
 
-static void get_object_list(int ac, const char **av)
+static void get_object_list(int ac, const char **av, int read_from_stdin)
 {
 	struct rev_info revs;
 	struct setup_revision_opt s_r_opt = {
@@ -3363,7 +3363,7 @@ static void get_object_list(int ac, const char **av)
 	save_warning = warn_on_object_refname_ambiguity;
 	warn_on_object_refname_ambiguity = 0;
 
-	while (fgets(line, sizeof(line), stdin) != NULL) {
+	while (read_from_stdin && fgets(line, sizeof(line), stdin) != NULL) {
 		int len = strlen(line);
 		if (len && line[len - 1] == '\n')
 			line[--len] = 0;
@@ -3487,6 +3487,15 @@ static int option_parse_unpack_unreachable(const struct option *opt,
 	return 0;
 }
 
+static void collect_kept_packs(struct string_list *keep_pack_list)
+{
+	struct strbuf buf = STRBUF_INIT;
+	while (strbuf_getline(&buf, stdin) != EOF)
+		string_list_append(keep_pack_list,
+				   strbuf_detach(&buf, NULL));
+	strbuf_release(&buf);
+}
+
 int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 {
 	int use_internal_rev_list = 0;
@@ -3496,6 +3505,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	int rev_list_unpacked = 0, rev_list_all = 0, rev_list_reflog = 0;
 	int rev_list_index = 0;
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
+	int keep_pack_stdin = 0;
 	struct option pack_objects_options[] = {
 		OPT_SET_INT('q', "quiet", &progress,
 			    N_("do not show progress meter"), 0),
@@ -3568,6 +3578,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			 N_("assume the union of kept packs is closed under reachability")),
 		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
 				N_("ignore this pack")),
+		OPT_BOOL(0, "keep-pack-stdin", &keep_pack_stdin,
+			 N_("read the list of kept packs from stdin")),
 		OPT_INTEGER(0, "compression", &pack_compression_level,
 			    N_("pack compression level")),
 		OPT_SET_INT(0, "keep-true-parents", &grafts_replace_parents,
@@ -3728,6 +3740,11 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (progress && all_progress_implied)
 		progress = 2;
 
+	if (keep_pack_stdin) {
+		if (!use_internal_rev_list)
+			die(_("--keep-pack-stdin requires --revs"));
+		collect_kept_packs(&keep_pack_list);
+	}
 	add_extra_kept_packs(&keep_pack_list);
 	if (ignore_packed_keep_on_disk) {
 		struct packed_git *p;
@@ -3769,7 +3786,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (!use_internal_rev_list)
 		read_object_list_from_stdin();
 	else {
-		get_object_list(rp.nr, rp.v);
+		get_object_list(rp.nr, rp.v, !keep_pack_stdin);
 		strvec_clear(&rp);
 	}
 	cleanup_preferred_base();
-- 
2.30.0.138.g6d7191ea01

