Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606FEC433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 22:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbiCCW0D (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 17:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiCCW0B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 17:26:01 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7615F3EA95
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 14:25:15 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id w4so5184680ilj.5
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 14:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YA+Wl/9xws4N9b8m9FWfPDfMI/ODLRxRJWbxQX3I1tc=;
        b=RCTho9GanVERLrV7iLnj0WWpESxyWd8kQ7iIWieCGtD9A/OwBUrIgEH8udO87tGCWS
         8h2xWIe5dtkqBOgql+lwwJxX6WYBBWpo+7nNXO7RPdJUZsaa8Tgk8Pm82/+YVs8pZKpp
         hAKoljYQAN2x8OtCXd3YcMj6tvPniEDIeCQQjSa3SZmV5nolu3MvtTQwOZJx2TsOKhXU
         4lnSciBOliLqYz+ZWmbLECFbOVGhqQx5rNHl6rUtERbYylSMcNK6PAIOWUC5daj3DjrI
         DwExg1oAqfup5Wo5Y1X8xjxmyUcKaszHCGDXoUOUQe15l0BNI4YsfNNTMSrhU1QVqFFE
         Ngcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YA+Wl/9xws4N9b8m9FWfPDfMI/ODLRxRJWbxQX3I1tc=;
        b=sOnyWAI+AfXmD81tOn+9ID/dJCHNIy89hBiohdnT/zU8tPFlN3BYjveknAOEr6+8RS
         lcp1vnZNDPoGkzohyfsjXJfQqecWe6dehnh6YEabv1DW3D0rFarJOTLlt4pZKIaCIaWL
         CxUdTeQYywW9EmScjOP32KHCZec1Qh8Mv74sT54PZ0oEHhVVZ962jNeGab2q6TueLHw7
         NtTdhe6Wrz2swnWno4ZWGmS3Ogw432NDiNd19nhSEmfYNzqJWinXQBabaw73kAQsindQ
         GbXS8iI0ZfIT4KDsfnR/JEXg2y1G8Mw3i/xGgnj6lKBDUYLldddoNEebHQoejdp9sxil
         H3iA==
X-Gm-Message-State: AOAM531Ul3Q8/TnygZPhOCTYRRdIhMr2oOQCvxrOo0N94xdn9zxQmf2I
        isB+HIQsXYjXTx2Bclr/z9+5VUga2mSHSTGD
X-Google-Smtp-Source: ABdhPJyiiTkL981ApMBR0gH3Q/jGDaXxAxhDxe8rpnKphYxHybm33H631eKFwKIx9JkwUgKAdCJQSA==
X-Received: by 2002:a92:7513:0:b0:2b9:5b61:e376 with SMTP id q19-20020a927513000000b002b95b61e376mr34083842ilc.193.1646346314743;
        Thu, 03 Mar 2022 14:25:14 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u19-20020a6be413000000b0064103112badsm2866580iog.45.2022.03.03.14.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 14:25:14 -0800 (PST)
Date:   Thu, 3 Mar 2022 17:25:13 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, derrickstolee@github.com,
        avarab@gmail.com, gitster@pobox.com
Subject: [PATCH v3 0/2] remote: show progress display when renaming
Message-ID: <cover.1646346286.git.me@ttaylorr.com>
References: <70a0325ca8ab0492a9b0873ee3fba576c5ab90b9.1646173186.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <70a0325ca8ab0492a9b0873ee3fba576c5ab90b9.1646173186.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a reroll of the patch we've been discussing to add progress
output when renaming remote-tracking references (as part of a `git
remote rename <old> <new>`).

This single patch is now two (and hence, has a cover letter!) because of
a slight change in approach which amounts to changing this behavior from
an opt-in

    git remote -v rename <old> <new>

to something much more in line with our existing use of the
`--[no-]progress` option like:

    git remote rename [--[no-]progress] <old> <new>

(where `--progress` is the default exactly when `isatty(2)` is true).

I think similar treatment could be applied to other `git remote`
sub-commands, but I'm reasonably happy starting with just `git remote
rename` and looking at the others later.

Taylor Blau (2):
  builtin/remote.c: parse options in 'rename'
  builtin/remote.c: show progress when renaming remote references

 Documentation/git-remote.txt |  2 +-
 builtin/remote.c             | 39 ++++++++++++++++++++++++++++--------
 t/t5505-remote.sh            |  4 +++-
 3 files changed, 35 insertions(+), 10 deletions(-)

Range-diff against v2:
-:  ---------- > 1:  b76da50b54 builtin/remote.c: parse options in 'rename'
1:  dc63ec91ab ! 2:  d5b0a4b710 builtin/remote.c: show progress when renaming remote references
    @@ Documentation/git-remote.txt: SYNOPSIS
      'git remote' [-v | --verbose]
      'git remote add' [-t <branch>] [-m <master>] [-f] [--[no-]tags] [--mirror=(fetch|push)] <name> <URL>
     -'git remote rename' <old> <new>
    -+'git remote' [-v | --verbose] 'rename' <old> <new>
    ++'git remote rename' [--[no-]progress] <old> <new>
      'git remote remove' <name>
      'git remote set-head' <name> (-a | --auto | -d | --delete | <branch>)
      'git remote set-branches' [--add] <name> <branch>...
    @@ builtin/remote.c
      	"git remote [-v | --verbose]",
      	N_("git remote add [-t <branch>] [-m <master>] [-f] [--tags | --no-tags] [--mirror=<fetch|push>] <name> <url>"),
     -	N_("git remote rename <old> <new>"),
    -+	N_("git remote [-v | --verbose] rename <old> <new>"),
    ++	N_("git remote rename [--[no-]progress] <old> <new>"),
      	N_("git remote remove <name>"),
      	N_("git remote set-head <name> (-a | --auto | -d | --delete | <branch>)"),
      	N_("git remote [-v | --verbose] show [-n] <name>"),
    +@@ builtin/remote.c: static const char * const builtin_remote_add_usage[] = {
    + };
    + 
    + static const char * const builtin_remote_rename_usage[] = {
    +-	N_("git remote rename <old> <new>"),
    ++	N_("git remote rename [--[no-]progress] <old> <new>"),
    + 	NULL
    + };
    + 
     @@ builtin/remote.c: struct rename_info {
      	const char *old_name;
      	const char *new_name;
    @@ builtin/remote.c: static int read_remote_branches(const char *refname,
      	}
      	strbuf_release(&buf);
      
    +@@ builtin/remote.c: static void handle_push_default(const char* old_name, const char* new_name)
    + 
    + static int mv(int argc, const char **argv)
    + {
    ++	int show_progress = isatty(2);
    + 	struct option options[] = {
    ++		OPT_BOOL(0, "progress", &show_progress, N_("force progress reporting")),
    + 		OPT_END()
    + 	};
    + 	struct remote *oldremote, *newremote;
     @@ builtin/remote.c: static int mv(int argc, const char **argv)
      		old_remote_context = STRBUF_INIT;
      	struct string_list remote_branches = STRING_LIST_INIT_DUP;
    @@ builtin/remote.c: static int mv(int argc, const char **argv)
     +	int i, refs_renamed_nr = 0, refspec_updated = 0;
     +	struct progress *progress = NULL;
      
    - 	if (argc != 3)
    - 		usage_with_options(builtin_remote_rename_usage, options);
    + 	argc = parse_options(argc, argv, NULL, options,
    + 			     builtin_remote_rename_usage, 0);
     @@ builtin/remote.c: static int mv(int argc, const char **argv)
    - 	rename.old_name = argv[1];
    - 	rename.new_name = argv[2];
    + 	rename.old_name = argv[0];
    + 	rename.new_name = argv[1];
      	rename.remote_branches = &remote_branches;
     +	rename.symrefs_nr = 0;
      
    @@ builtin/remote.c: static int mv(int argc, const char **argv)
      	 * the new symrefs.
      	 */
      	for_each_ref(read_remote_branches, &rename);
    -+	if (verbose) {
    ++	if (show_progress) {
     +		/*
     +		 * Count symrefs twice, since "renaming" them is done by
     +		 * deleting and recreating them in two separate passes.
    @@ t/t5505-remote.sh: test_expect_success 'rename a remote' '
      		cd four &&
      		git config branch.main.pushRemote origin &&
     -		git remote rename origin upstream &&
    -+		GIT_PROGRESS_DELAY=0 git remote -v rename origin upstream 2>err &&
    ++		GIT_TRACE2_EVENT=$(pwd)/trace \
    ++			git remote rename --progress origin upstream &&
    ++		test_region progress "Renaming remote references" trace &&
      		grep "pushRemote" .git/config &&
    -+		grep "Renaming remote references: 100% (4/4), done" err &&
      		test -z "$(git for-each-ref refs/remotes/origin)" &&
      		test "$(git symbolic-ref refs/remotes/upstream/HEAD)" = "refs/remotes/upstream/main" &&
    - 		test "$(git rev-parse upstream/main)" = "$(git rev-parse main)" &&
-- 
2.35.1.73.gccc5557600
