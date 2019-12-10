Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B6AC43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 10:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96CF520663
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 10:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9SIRSQB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfLJKmn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 05:42:43 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50976 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfLJKmn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 05:42:43 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so2588525wmg.0
        for <git@vger.kernel.org>; Tue, 10 Dec 2019 02:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7A5DHSW+gO4x6nEQIXoCsXVBg07IyAh5noY4dCA9cmc=;
        b=b9SIRSQBXoPPxuL9METe/fgXwopKzbP6CozUK3YMtXYXJOXAp3oQwrWnEpga2H/jI0
         +hE46i3Qd9jalC4gs6w248DYpfIEHcm7qfl7bBfVThGd4rpssiBUa6JXYm0V44WtrOvw
         hXBdqF+dy5Si23zyrAo55xXdNOHI9FMpc5vfaTm3ZMsC9SPrJVL3f32qj1t2DP2okW89
         zV631MNpzvGod9DthkMsL/b/kY3/aDeOvCxft5pECmGf7YJYz2XMkcL43iBAVCJPZNss
         Fc17DCYRCZKxqYqzMjwiZ+YQFrBcgniOjyQKK519KY+sIf3+T9psWaHWk3npraiwz6zB
         vAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7A5DHSW+gO4x6nEQIXoCsXVBg07IyAh5noY4dCA9cmc=;
        b=qRWVjZikb7jMoF1lhnmVdxX4cuLMxunLIcbUDr3YZEShKkWtGKudXaSG7bX4STCykI
         4nnDicAuZFFmtYBE5FdnoW9dKuSDPMyiaal7y6ZNAzUb92E/uWk5yL4yEP7uSZ7CiGqj
         GLtVhLZz8iPNPRnqyfWPmAPcNFkf23vTOYHt3XKS9xvA611f4V1IQ544j7VzTrYo5TYE
         aOllBWFgrQP8DKED/u0ac0ToJblDz1NbAUML8xILyoaYCNPbK4N3OVkzi4ozsqNtDq3J
         LMCmk1TEHJFLOro56vUDtzZ6dQTg3BE4gUgpfehaS3Sg9kMk1ZMz6ngAEkt7WOOKcmy3
         FB8w==
X-Gm-Message-State: APjAAAXNM58Xs4qVXUqRYH7Tc96Ei3pCkXk8QUnEfwAOODsl1mUZLDOE
        o+58O4qQ2A33/2wbl2ClQuxhx2eI
X-Google-Smtp-Source: APXvYqyrdou4WAdpoCOhxkgs4i+PvRj7eFwkzHyRaKV/2ihlRqEUo8X6VeeaXQ16GK6BfnWfA7ROpw==
X-Received: by 2002:a7b:c7d3:: with SMTP id z19mr4238665wmk.94.1575974560178;
        Tue, 10 Dec 2019 02:42:40 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-0-192.as13285.net. [92.22.0.192])
        by smtp.gmail.com with ESMTPSA id t1sm2718679wma.43.2019.12.10.02.42.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 02:42:39 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 5/5] commit: support the --pathspec-from-file option
To:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        phillip.wood@dunelm.org.uk,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
 <f4847046896848d3f16bc5f3cb7a26271cefd97c.1572895605.git.gitgitgadget@gmail.com>
 <9ca7fa57-c438-7243-6ab1-956d8f132d37@gmail.com>
 <25aaaca1-1c88-d2c6-b502-cd35752ce745@syntevo.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <4401823b-8039-99b4-2436-ed2f1a571d78@gmail.com>
Date:   Tue, 10 Dec 2019 10:42:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <25aaaca1-1c88-d2c6-b502-cd35752ce745@syntevo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alexandr

Sorry it has taken me so long to reply

On 06/11/2019 15:56, Alexandr Miloslavskiy wrote:
> I think I have implemented most suggestions in PatchV2. Thanks!
> 
>> It might be worth tailoring the message to the command rather than 
>> having exactly the same message for commit and reset
> 
> I decided to move the general comment to base commit where options are 
> introduced and not repeat it where options are supported.
> 
>> I wonder if there is a way of calling parse_pathspec_file() from 
>> parse_and_validate_options() instead. Otherwise we end up validating 
>> options here instead which is a bit messy.
> 
> The code looks a bit too entangled to support that without making it 
> worse. The biggest concern I have is that parse_and_validate_options() 
> will populate `pathspec` and some other function will need to remember 
> to clean it up. I like it better when `pathspec` is handled in one place.

I don't think it's so bad if the pathspec is cleaned up just after it is used, 
the diff below applies on top of your patch - see what you think. The diff 
also adds dies if --all is given with --pathspec-from-file which (together 
with a test) would be worth adding to you series I think.

> 
> I agree that things are not perfect, but this seems to be a consequence 
> of other existing problems. For example, I would have expected a 
> structure instead of a handful of global variables. That would have 
> solved many problems. However, I didn't have the bravery to dive into 
> this refactoring.

Yes it is a pain that the builtin functions tend to use a lot of global 
variables rather than a structure.

Best Wishes

Phillip

--- >8 ---
diff --git a/builtin/commit.c b/builtin/commit.c
index ed40729355..bb9515c44b 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -330,37 +330,18 @@ static void refresh_cache_or_die(int refresh_flags)
 }
 
 static const char *prepare_index(int argc, const char **argv, const char *prefix,
+				 struct pathspec *pathspec,
 				 const struct commit *current_head, int is_status)
 {
 	struct string_list partial = STRING_LIST_INIT_DUP;
-	struct pathspec pathspec;
+
 	int refresh_flags = REFRESH_QUIET;
 	const char *ret;
 
 	if (is_status)
 		refresh_flags |= REFRESH_UNMERGED;
-	parse_pathspec(&pathspec, 0,
-		       PATHSPEC_PREFER_FULL,
-		       prefix, argv);
 
-	if (pathspec_from_file) {
-		if (interactive)
-			die(_("--pathspec-from-file is incompatible with --interactive/--patch"));
-
-		if (pathspec.nr)
-			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
-
-		parse_pathspec_file(&pathspec, 0,
-				    PATHSPEC_PREFER_FULL,
-				    prefix, pathspec_from_file, pathspec_file_nul);
-	} else if (pathspec_file_nul) {
-		die(_("--pathspec-file-nul requires --pathspec-from-file"));
-	}
-
-	if (!pathspec.nr && (also || (only && !amend && !allow_empty)))
-		die(_("No paths with --include/--only does not make sense."));
-
-	if (read_cache_preload(&pathspec) < 0)
+	if (read_cache_preload(pathspec) < 0)
 		die(_("index file corrupt"));
 
 	if (interactive) {
@@ -411,9 +392,9 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 	 * (A) if all goes well, commit the real index;
 	 * (B) on failure, rollback the real index.
 	 */
-	if (all || (also && pathspec.nr)) {
+	if (all || (also && pathspec->nr)) {
 		hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
-		add_files_to_cache(also ? prefix : NULL, &pathspec, 0);
+		add_files_to_cache(also ? prefix : NULL, pathspec, 0);
 		refresh_cache_or_die(refresh_flags);
 		update_main_cache_tree(WRITE_TREE_SILENT);
 		if (write_locked_index(&the_index, &index_lock, 0))
@@ -432,7 +413,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 	 * and create commit from the_index.
 	 * We still need to refresh the index here.
 	 */
-	if (!only && !pathspec.nr) {
+	if (!only && !pathspec->nr) {
 		hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
 		refresh_cache_or_die(refresh_flags);
 		if (active_cache_changed
@@ -474,7 +455,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 			die(_("cannot do a partial commit during a cherry-pick."));
 	}
 
-	if (list_paths(&partial, !current_head ? NULL : "HEAD", &pathspec))
+	if (list_paths(&partial, !current_head ? NULL : "HEAD", pathspec))
 		exit(1);
 
 	discard_cache();
@@ -505,7 +486,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 	read_cache_from(ret);
 out:
 	string_list_clear(&partial, 0);
-	clear_pathspec(&pathspec);
+	clear_pathspec(pathspec);
 	return ret;
 }
 
@@ -1148,6 +1129,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 				      const struct option *options,
 				      const char * const usage[],
 				      const char *prefix,
+				      struct pathspec *pathspec,
 				      struct commit *current_head,
 				      struct wt_status *s)
 {
@@ -1223,19 +1205,42 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		die(_("paths '%s ...' with -a does not make sense"),
 		    argv[0]);
 
+	if (pathspec_from_file) {
+		if (interactive)
+			die(_("--pathspec-from-file is incompatible with --interactive/--patch"));
+
+		if (argc)
+			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
+
+		if (all)
+			die(_("--pathspec-from-file is incompatible with --all"));
+
+		parse_pathspec_file(pathspec, 0,
+				    PATHSPEC_PREFER_FULL,
+				    prefix, pathspec_from_file, pathspec_file_nul);
+	} else if (pathspec_file_nul) {
+		die(_("--pathspec-file-nul requires --pathspec-from-file"));
+	} else {
+		parse_pathspec(pathspec, 0, PATHSPEC_PREFER_FULL, prefix, argv);
+	}
+
+	if (!pathspec->nr && (also || (only && !amend && !allow_empty)))
+		die(_("No paths with --include/--only does not make sense."));
+
 	if (status_format != STATUS_FORMAT_NONE)
 		dry_run = 1;
 
 	return argc;
 }
 
 static int dry_run_commit(int argc, const char **argv, const char *prefix,
+			  struct pathspec *pathspec,
 			  const struct commit *current_head, struct wt_status *s)
 {
 	int committable;
 	const char *index_file;
 
-	index_file = prepare_index(argc, argv, prefix, current_head, 1);
+	index_file = prepare_index(argc, argv, prefix, pathspec, current_head, 1);
 	committable = run_status(stdout, index_file, prefix, 0, s);
 	rollback_index_files();
 
@@ -1571,6 +1576,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	struct commit *current_head = NULL;
 	struct commit_extra_header *extra = NULL;
 	struct strbuf err = STRBUF_INIT;
+	struct pathspec pathspec;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_commit_usage, builtin_commit_options);
@@ -1590,13 +1596,15 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	verbose = -1; /* unspecified */
 	argc = parse_and_validate_options(argc, argv, builtin_commit_options,
 					  builtin_commit_usage,
-					  prefix, current_head, &s);
+					  prefix, &pathspec, current_head, &s);
 	if (verbose == -1)
 		verbose = (config_commit_verbose < 0) ? 0 : config_commit_verbose;
 
 	if (dry_run)
-		return dry_run_commit(argc, argv, prefix, current_head, &s);
-	index_file = prepare_index(argc, argv, prefix, current_head, 0);
+		return dry_run_commit(argc, argv, prefix, &pathspec,
+				     current_head, &s);
+	index_file = prepare_index(argc, argv, prefix, &pathspec, current_head,
+				   0);
 
 	/* Set up everything for writing the commit object.  This includes
 	   running hooks, writing the trees, and interacting with the user.  */

