Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747A7C4727E
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 03:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F375821D43
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 03:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rHZ5jABf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbgJADqU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 23:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgJADqU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 23:46:20 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242DEC061755
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 20:46:20 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id v12so1470672wmh.3
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 20:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JQq3Z/zsQRelEH2h/RE0t2J5ZetUzKSD4jS5MH9tlM8=;
        b=rHZ5jABfno2QDwH3b5+1bbIk4oEd+oiyYjUGOvYRUaQAaSRA5dHd/0wOEhS5ERMorl
         xN/sZ0Ve/rOveaOFFNYmpl3D0XrlOx1Ya16Ov8WC5IJrayJIep9o4PYYWnP9W8s56ygO
         i4c0Ea/TwqC/Pb3CpbhuSOI0TqctnSXHRn6pjwB3hQb2gbC0QSSFlDNbtuciCAM29rkl
         aGimfMr968hJhWdiBHgkJvRradf2w/z8GZd7/2GidoNvIOlv0cKQKU6xePm/Lh9S1cXX
         KI/C/IY5ltfmGvpZm7im1kOPUIVt5yXXtqqsrerqKUEuRYthJOxgPsROMyFWovHl1RB3
         5Cug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JQq3Z/zsQRelEH2h/RE0t2J5ZetUzKSD4jS5MH9tlM8=;
        b=eriVr7ZPT9MWQHYdGJziUJImYp67WTZN6xKv58w4XrSTFL5BX0cCY8TXzwecbNEbeV
         Byi4apfORUMHw4YxT6m4BFs800tY2WGxYpLQIha4VS0G8UarOaKtLsB1XjAjbLeVzZH1
         iCIquBgBfBRFrL+5yb9OH8FQ+4VB4tnsWBWta5pqBrcZDvb8IiXvz+2HUMLMWdZTB/g8
         5+lm/gTGCVvjjXenTEY9LvI0NpLK41CwNHMJU39RuS45lb0zQsv2yE4vptnfQwZTU12n
         t0j3x0g7Fpf5Zn/GovuZziUEriFmuj9Xe/blDoLqmR5ncH+8aeRc/ql51jNEUCYOSOo9
         vMsg==
X-Gm-Message-State: AOAM530LYjR2ytWjhRTY0Ybv5Xaqe5ex3zZAp9gI4VI7mdLK8aOhQnxx
        Y75CbGJM2v75YVNOcVtSu4wia9uzD2A=
X-Google-Smtp-Source: ABdhPJzi2G2IpKCTW6oieToFeMghCtcvieBWvmYQYDjk7M3E6AKBq65FOd7ZP/UkeCFISNhQsnVfyA==
X-Received: by 2002:a7b:c40b:: with SMTP id k11mr5949526wmi.135.1601523978391;
        Wed, 30 Sep 2020 20:46:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l8sm6372709wrx.22.2020.09.30.20.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 20:46:17 -0700 (PDT)
Message-Id: <pull.727.v3.git.1601523977.gitgitgadget@gmail.com>
In-Reply-To: <pull.727.v2.git.1601350615.gitgitgadget@gmail.com>
References: <pull.727.v2.git.1601350615.gitgitgadget@gmail.com>
From:   "Sean Barag via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Oct 2020 03:46:09 +0000
Subject: [PATCH v3 0/7] clone: allow configurable default for -o/--origin
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>, Sean Barag <sean@barag.org>,
        Andrei Rybak <rybak.a.v@gmail.com>, Sean Barag <sean@barag.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3 (changes since v2):

 * [5/7] fix compilation error: validate option_origin since remote_name
   doesn't exist yet
 * [7/7] remove default_remote_name; apply default value inline if no other
   value applied

v2 (changes since v1):

 * Convert Thanks-to trailer to Helped-by
 * Rewrite several commit titles and messages
 * Unify error reporting between clone.c and remote.c
 * Add tests for git remote add and git remote rename with invalid remote
   names
 * Prevent leak of old remote_name

v1: Took another pass at supporting a configurable default for-o/--origin,
this time following Junio's suggestions from a previous approach as much as
possible [1]. Unfortunately, Johannes mentioned that --template can write
new config values that aren't automatically merged without re-calling 
git_config. There doesn't appear to be a way around this without rewriting
significant amounts of init and config logic across the codebase.

While this could have been v2 of the original patchset, it's diverged so
drastically from the original that it likely warrants its own root thread.
If that's not appropriate though, I'd be happy to restructure!

Thanks for all the advice Junio and Johannes! This feels significantly
better than my first attempt.

[1] 
https://lore.kernel.org/git/pull.710.git.1598456751674.gitgitgadget@gmail.com/
[2] https://github.com/gitgitgadget/git/pull/727#issuecomment-689740195

Sean Barag (7):
  clone: add tests for --template and some disallowed option pairs
  clone: use more conventional config/option layering
  remote: add tests for add and rename with invalid names
  refs: consolidate remote name validation
  clone: validate --origin option before use
  clone: read new remote name from remote_name instead of option_origin
  clone: allow configurable default for `-o`/`--origin`

 Documentation/config.txt       |  2 +
 Documentation/config/clone.txt |  5 +++
 Documentation/git-clone.txt    |  5 ++-
 builtin/clone.c                | 71 +++++++++++++++++++++++++++-------
 builtin/remote.c               |  7 +---
 refspec.c                      | 10 +++++
 refspec.h                      |  1 +
 t/t5505-remote.sh              | 13 +++++++
 t/t5606-clone-options.sh       | 68 +++++++++++++++++++++++++++++++-
 9 files changed, 159 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/config/clone.txt


base-commit: 306ee63a703ad67c54ba1209dc11dd9ea500dc1f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-727%2Fsjbarag%2Fclone_add-configurable-default-for--o-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-727/sjbarag/clone_add-configurable-default-for--o-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/727

Range-diff vs v2:

 1:  29ab418b1b = 1:  4195dec00c clone: add tests for --template and some disallowed option pairs
 2:  e3479e7b35 ! 2:  1abcf417d9 clone: use more conventional config/option layering
     @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
      -	git_config(git_default_config, NULL);
      +	/*
      +	 * re-read config after init_db and write_config to pick up any config
     -+	 * injected by --template and --config, respectively
     ++	 * injected by --template and --config, respectively.
      +	 */
      +	git_config(git_clone_config, NULL);
       
 3:  85be780b8e = 3:  ec371306ec remote: add tests for add and rename with invalid names
 4:  42dc18601a = 4:  cb686b4129 refs: consolidate remote name validation
 5:  fdc9d3b369 ! 5:  e1d3b54fdc clone: validate --origin option before use
     @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
       	if (!option_origin)
       		option_origin = "origin";
       
     -+	if (!valid_remote_name(remote_name))
     -+		die(_("'%s' is not a valid remote name"), remote_name);
     ++	if (!valid_remote_name(option_origin))
     ++		die(_("'%s' is not a valid remote name"), option_origin);
      +
       	repo_name = argv[0];
       
 6:  99f4d765b4 ! 6:  c3fba50092 clone: read new remote name from remote_name instead of option_origin
     @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
      +	if (option_origin)
      +		remote_name = option_origin;
       
     - 	if (!valid_remote_name(remote_name))
     - 		die(_("'%s' is not a valid remote name"), remote_name);
     +-	if (!valid_remote_name(option_origin))
     +-		die(_("'%s' is not a valid remote name"), option_origin);
     ++	if (!valid_remote_name(remote_name))
     ++		die(_("'%s' is not a valid remote name"), remote_name);
     + 
     + 	repo_name = argv[0];
     + 
      @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
       
       		git_config_set("core.bare", "true");
 7:  737f91c624 ! 7:  da8212e500 clone: allow configurable default for `-o`/`--origin`
     @@ builtin/clone.c: static int option_shallow_submodules;
       static char *option_template, *option_depth, *option_since;
       static char *option_origin = NULL;
      -static char *remote_name = "origin";
     -+static char *default_remote_name = "origin";
      +static char *remote_name = NULL;
       static char *option_branch = NULL;
       static struct string_list option_not = STRING_LIST_INIT_NODUP;
     @@ builtin/clone.c: static int checkout(int submodule_progress)
       static int git_clone_config(const char *k, const char *v, void *cb)
       {
      +	if (!strcmp(k, "clone.defaultremotename")) {
     -+		if (remote_name != default_remote_name)
     -+			free(remote_name);
     ++		free(remote_name);
      +		remote_name = xstrdup(v);
      +	}
       	return git_default_config(k, v, cb);
       }
       
     -@@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
     - 	int submodule_progress;
     - 
     - 	struct strvec ref_prefixes = STRVEC_INIT;
     -+	remote_name = default_remote_name;
     - 
     - 	packet_trace_identity("clone");
     - 
      @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
       		option_no_checkout = 1;
       	}
     @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
       
       	path = get_repo_path(repo_name, &is_bundle);
      @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
     - 
     - 	/*
     - 	 * re-read config after init_db and write_config to pick up any config
     --	 * injected by --template and --config, respectively
     -+	 * injected by --template and --config, respectively.
       	 */
       	git_config(git_clone_config, NULL);
       
     @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
      +	 * apply the remote name provided by --origin only after this second
      +	 * call to git_config, to ensure it overrides all config-based values.
      +	 */
     -+	if (option_origin)
     -+		remote_name = option_origin;
     ++	if (option_origin != NULL)
     ++		remote_name = xstrdup(option_origin);
     ++
     ++	if (remote_name == NULL)
     ++		remote_name = xstrdup("origin");
      +
      +	if (!valid_remote_name(remote_name))
      +		die(_("'%s' is not a valid remote name"), remote_name);
     @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
       	if (option_bare) {
       		if (option_mirror)
       			src_ref_prefix = "refs/";
     +@@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
     + 	junk_mode = JUNK_LEAVE_REPO;
     + 	err = checkout(submodule_progress);
     + 
     ++	free(remote_name);
     + 	strbuf_release(&reflog_msg);
     + 	strbuf_release(&branch_top);
     + 	strbuf_release(&key);
      
       ## t/t5606-clone-options.sh ##
      @@ t/t5606-clone-options.sh: test_expect_success 'clone -o' '

-- 
gitgitgadget
