Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AB821FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 20:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932464AbcKVUYU (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 15:24:20 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56880 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932119AbcKVUYT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 15:24:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 969F64E4B2;
        Tue, 22 Nov 2016 15:24:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/CyEh/aMeThgcL9QoP7lBGmAuG4=; b=gowslV
        T/x41ytX8Wk3ZO/XoCs192uQkwPEV0wwvK7S28o+J/qoDqvMbSzVR/Mdgz2ElbFj
        iNwzf9uby8JENBextOleWIE2geqH0L3udt61uVfibrYWHe7pAp3VGLlK95UEWVUW
        5BD09qHPXMqRoGkiceYFaVAGJfpJuCl5XSHas=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SHlAY6Beqwgqe5he60VYY5bfXR65O5PM
        pdztATa/ifh1rM4cM/ZMHBdODh3qzT1aShcaqvB/O14XiuB++x+2zQvAPMMe+xY5
        /XYXhrWDTdyGcQ+XDJPmrhs4r61W2a7ZLnoCkqrHjD5aViUsPD7v8ElyMLvmXY4e
        Zw63AszK3Cc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C4834E4B1;
        Tue, 22 Nov 2016 15:24:17 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CD6E74E4B0;
        Tue, 22 Nov 2016 15:24:16 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Taufiq Hoven <taufiq.hoven@gmail.com>
Subject: Re: [PATCH 2/3] stripspace: respect repository config
References: <cover.1479737858.git.johannes.schindelin@gmx.de>
        <5567548295222401fab10d3f2901c1787afbfd07.1479737858.git.johannes.schindelin@gmx.de>
        <CACsJy8D5oBR+vo2B+Ro2Q4SX0CG3jME4Gfs1_6AohccmpNvD0A@mail.gmail.com>
        <alpine.DEB.2.20.1611221712480.3746@virtualbox>
        <xmqqshqjqw3z.fsf@gitster.mtv.corp.google.com>
        <xmqqzikrpbz2.fsf@gitster.mtv.corp.google.com>
        <20161122195015.rztaixpz7zvdxb4u@sigill.intra.peff.net>
Date:   Tue, 22 Nov 2016 12:24:15 -0800
In-Reply-To: <20161122195015.rztaixpz7zvdxb4u@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 22 Nov 2016 14:50:15 -0500")
Message-ID: <xmqqoa17p8k0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A42A3F76-B0F1-11E6-8A0C-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So what do you want to do for v2.11? I think there are minor regressions
> in stripspace, archive, and mailinfo with respect to reading
> .git/config. The right solution in each case is to do a gentle repo
> setup. We have patches for stripspace already, but not yet for the other
> two. They _should_ be fairly trivial, but we are getting awfully close
> to the release. 

Right.

> Do you want to do another round of -rc3? Ship with the
> minor regressions and fix them up in v2.11.1?

I am leaning towards the former (though we may also end up doing the
latter).

Here is an initial attempt.  It turns out that write_archive() must
be callable outside a repository to respond to "git archive --list",
which happens in parse_archive_args(), and the "have-repository?"
check cannot be moved before that to the caller.

No tests yet.  Help appreciated ;-)


 archive.c                | 9 ++-------
 archive.h                | 2 +-
 builtin/archive.c        | 6 +++---
 builtin/upload-archive.c | 2 +-
 git.c                    | 4 ++--
 5 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/archive.c b/archive.c
index dde1ab4c79..901b10264f 100644
--- a/archive.c
+++ b/archive.c
@@ -504,15 +504,11 @@ static int parse_archive_args(int argc, const char **argv,
 }
 
 int write_archive(int argc, const char **argv, const char *prefix,
-		  int setup_prefix, const char *name_hint, int remote)
+		  const char *name_hint, int remote)
 {
-	int nongit = 0;
 	const struct archiver *ar = NULL;
 	struct archiver_args args;
 
-	if (setup_prefix && prefix == NULL)
-		prefix = setup_git_directory_gently(&nongit);
-
 	git_config_get_bool("uploadarchive.allowunreachable", &remote_allow_unreachable);
 	git_config(git_default_config, NULL);
 
@@ -520,7 +516,7 @@ int write_archive(int argc, const char **argv, const char *prefix,
 	init_zip_archiver();
 
 	argc = parse_archive_args(argc, argv, &ar, &args, name_hint, remote);
-	if (nongit) {
+	if (!startup_info->have_repository) {
 		/*
 		 * We know this will die() with an error, so we could just
 		 * die ourselves; but its error message will be more specific
@@ -528,7 +524,6 @@ int write_archive(int argc, const char **argv, const char *prefix,
 		 */
 		setup_git_directory();
 	}
-
 	parse_treeish_arg(argv, &args, prefix, remote);
 	parse_pathspec_arg(argv + 1, &args);
 
diff --git a/archive.h b/archive.h
index 4a791e1fed..415e0152e2 100644
--- a/archive.h
+++ b/archive.h
@@ -36,7 +36,7 @@ typedef int (*write_archive_entry_fn_t)(struct archiver_args *args,
 					unsigned int mode);
 
 extern int write_archive_entries(struct archiver_args *args, write_archive_entry_fn_t write_entry);
-extern int write_archive(int argc, const char **argv, const char *prefix, int setup_prefix, const char *name_hint, int remote);
+extern int write_archive(int argc, const char **argv, const char *prefix, const char *name_hint, int remote);
 
 const char *archive_format_from_filename(const char *filename);
 extern void *sha1_file_to_archive(const struct archiver_args *args,
diff --git a/builtin/archive.c b/builtin/archive.c
index 49f491413a..f863465a0f 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -85,8 +85,8 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
 	const char *output = NULL;
 	const char *remote = NULL;
 	struct option local_opts[] = {
-		OPT_STRING('o', "output", &output, N_("file"),
-			N_("write the archive to this file")),
+		OPT_FILENAME('o', "output", &output,
+			     N_("write the archive to this file")),
 		OPT_STRING(0, "remote", &remote, N_("repo"),
 			N_("retrieve the archive from remote repository <repo>")),
 		OPT_STRING(0, "exec", &exec, N_("command"),
@@ -105,5 +105,5 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
 
 	setvbuf(stderr, NULL, _IOLBF, BUFSIZ);
 
-	return write_archive(argc, argv, prefix, 1, output, 0);
+	return write_archive(argc, argv, prefix, output, 0);
 }
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index dc872f6a94..cde06977b7 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -43,7 +43,7 @@ int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix)
 	}
 
 	/* parse all options sent by the client */
-	return write_archive(sent_argv.argc, sent_argv.argv, prefix, 0, NULL, 1);
+	return write_archive(sent_argv.argc, sent_argv.argv, prefix, NULL, 1);
 }
 
 __attribute__((format (printf, 1, 2)))
diff --git a/git.c b/git.c
index efa1059fe0..e8b2baf2d1 100644
--- a/git.c
+++ b/git.c
@@ -396,7 +396,7 @@ static struct cmd_struct commands[] = {
 	{ "am", cmd_am, RUN_SETUP | NEED_WORK_TREE },
 	{ "annotate", cmd_annotate, RUN_SETUP },
 	{ "apply", cmd_apply, RUN_SETUP_GENTLY },
-	{ "archive", cmd_archive },
+	{ "archive", cmd_archive, RUN_SETUP_GENTLY },
 	{ "bisect--helper", cmd_bisect__helper, RUN_SETUP },
 	{ "blame", cmd_blame, RUN_SETUP },
 	{ "branch", cmd_branch, RUN_SETUP },
@@ -445,7 +445,7 @@ static struct cmd_struct commands[] = {
 	{ "ls-files", cmd_ls_files, RUN_SETUP | SUPPORT_SUPER_PREFIX },
 	{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
 	{ "ls-tree", cmd_ls_tree, RUN_SETUP },
-	{ "mailinfo", cmd_mailinfo },
+	{ "mailinfo", cmd_mailinfo, RUN_SETUP_GENTLY },
 	{ "mailsplit", cmd_mailsplit },
 	{ "merge", cmd_merge, RUN_SETUP | NEED_WORK_TREE },
 	{ "merge-base", cmd_merge_base, RUN_SETUP },
