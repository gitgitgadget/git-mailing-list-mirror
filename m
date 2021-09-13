Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD70C433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 03:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 432CE60F3A
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 03:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238421AbhIMDqz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 23:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235475AbhIMDqz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 23:46:55 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F98C061574
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 20:45:39 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id m9so12367715wrb.1
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 20:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JAnD8IkMTVvGw5I/Q3pAhlAizLTvFp8u4+LvsfAqEyg=;
        b=LRySV2sUY+PMrKE30OFbAp+ivwKOoXelB0A3qxqK/ApWo/Tl9L8IKptIcujsmpf0At
         /a+GoYn/ndIsN12+o+971jrrMHiujR/za/F2D+rh1L1s9azUP1uWDWLsWFuH2rgmvDwA
         yusVaYcRV7P/R5M2Ldaa3var4yMQtpd/uBe3ruz9HlDrrL/OXFuzosbxJnRwgao/i26F
         tnuwjDCa6SLCI+lnqFPdqy1H0c+yPcWLhDU09San/met8JtmmaWyKzrAiJ6y28sv8bm8
         MRUvr5LykbQNe88b/6Q7WgBRAWYFf/P16YJHvssFxML4dIyqBJyvOMwX95vTDFtCcpmu
         zsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JAnD8IkMTVvGw5I/Q3pAhlAizLTvFp8u4+LvsfAqEyg=;
        b=sTrmzmPVT7dWkottnCLdpXqLX/mBIwQV1bNb+1/u6nTa0YIA2vC2Ug2mPx0qdWxwlh
         b+cv48jj9VgvqnZwRyVz8/S5qQ8smp/bDIviDZGRM3d9f4/SI8DRcRW88Ua/w6DOKh6g
         jygDS79lzlLlt8mupr9L8oG5mkXpztEGjezVHOy8aT+UidKQ7JAAUdwP0rcDPVcioqXZ
         J4H6gt8FLO1nLDLAxy3Cm4KRK8DSxThi4zuXpu7wAoLrIL2jX8bSt0aWkzhvsiIdZ18D
         5KO9uEbwaVXdg6L/XyH60MfQ765/wvSwCtuOJzjB9GEyHzD5y+8c5EzBjS+NYZa+M1ja
         eMTQ==
X-Gm-Message-State: AOAM531rF5wFgM7zWOzO0ft3DeSJRfigVYWusjZL5DK8wb4ivvm/tdtH
        mhSWXuTjhrEjUDSE4Fm8rDM6xD/4RIzdxg==
X-Google-Smtp-Source: ABdhPJxOoHVTQcX3e5wqW9P/uDnactsRs74SQkDKeHru+2RJGMalaUdVw254PRqyfts6fDBIu7XW3A==
X-Received: by 2002:a05:6000:160c:: with SMTP id u12mr10022760wrb.100.1631504738215;
        Sun, 12 Sep 2021 20:45:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o10sm6631472wrc.16.2021.09.12.20.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 20:45:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/4] difftool refactoring + remove OPT_ARGUMENT() macro
Date:   Mon, 13 Sep 2021 05:35:36 +0200
Message-Id: <cover-v2-0.4-00000000000-20210913T033204Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.999.ga5f89b684e9
In-Reply-To: <cover-0.2-00000000000-20210911T182009Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20210911T182009Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We've only ever used parse-option.c's OPT_ARGUMENT() in one place, as
it turns out we can use an OPT_BOOL there instead. and get a net
reduction in code & complexity.

I think this v2 should address the comments Jeff King had in
https://lore.kernel.org/git/YT6BnnXeAWn8BycF@coredump.intra.peff.net/;
there's now an amended version of his proposed patch as part of this,
but I prepended it with another one to prepare the "struct
child_process" in cmd_difftool().

Doing so nicely gets around the question of the strvec memory
management, since we can trust the run-command.c API to do that for
us, but couldn't in my v1 when we'd copy our own "struct strvec *" to
its "args".

Jeff King (1):
  difftool: prepare "diff" cmdline in cmd_difftool()

Ævar Arnfjörð Bjarmason (3):
  difftool: prepare "struct child_process" in cmd_difftool()
  difftool: use run_command() API in run_file_diff()
  parse-options API: remove OPTION_ARGUMENT feature

 Documentation/technical/api-parse-options.txt |  5 --
 builtin/difftool.c                            | 51 ++++++++++---------
 parse-options.c                               | 13 -----
 parse-options.h                               |  3 --
 t/helper/test-parse-options.c                 |  1 -
 t/t0040-parse-options.sh                      |  5 --
 6 files changed, 26 insertions(+), 52 deletions(-)

Range-diff against v1:
1:  e7481eb0c0c ! 1:  f57c6c9b069 difftool: use "struct strvec" API in run_{dir,file}_diff()
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    difftool: use "struct strvec" API in run_{dir,file}_diff()
    +    difftool: prepare "struct child_process" in cmd_difftool()
     
    -    The underlying run_command() API can take either the "struct strvec
    -    args", or a "const char **argv". Let's move to the former to use the
    -    more "native" version of run_command() in both of these functions.
    -
    -    This change probably isn't worth in on its own, but sets us up to
    -    simplify API use even more in a subsequent commit.
    +    Move the preparation of the "struct child_process" from run_dir_diff()
    +    to its only caller, cmd_difftool(). This is in preparation for
    +    migrating run_file_diff() to using the run_command() API directly, and
    +    to move more of the shared setup of the two to cmd_difftool().
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ builtin/difftool.c: static int checkout_path(unsigned mode, struct object_id *oi
      
      static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
     -			int argc, const char **argv)
    -+			struct strvec *args)
    ++			int argc, const char **argv,
    ++			struct child_process *child)
      {
      	char tmpdir[PATH_MAX];
      	struct strbuf info = STRBUF_INIT, lpath = STRBUF_INIT;
     @@ builtin/difftool.c: static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
    - 	child.clean_on_exit = 1;
    - 	child.dir = prefix;
    - 	child.out = -1;
    + 	struct index_state wtindex;
    + 	struct checkout lstate, rstate;
    + 	int rc, flags = RUN_GIT_CMD, err = 0;
    +-	struct child_process child = CHILD_PROCESS_INIT;
    + 	const char *helper_argv[] = { "difftool--helper", NULL, NULL, NULL };
    + 	struct hashmap wt_modified, tmp_modified;
    + 	int indices_loaded = 0;
    +@@ builtin/difftool.c: static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
    + 	rdir_len = rdir.len;
    + 	wtdir_len = wtdir.len;
    + 
    +-	child.no_stdin = 1;
    +-	child.git_cmd = 1;
    +-	child.use_shell = 0;
    +-	child.clean_on_exit = 1;
    +-	child.dir = prefix;
    +-	child.out = -1;
     -	strvec_pushl(&child.args, "diff", "--raw", "--no-abbrev", "-z",
    --		     NULL);
    --	for (i = 0; i < argc; i++)
    ++	child->no_stdin = 1;
    ++	child->git_cmd = 1;
    ++	child->use_shell = 0;
    ++	child->clean_on_exit = 1;
    ++	child->dir = prefix;
    ++	child->out = -1;
    ++	strvec_pushl(&child->args, "diff", "--raw", "--no-abbrev", "-z",
    + 		     NULL);
    + 	for (i = 0; i < argc; i++)
     -		strvec_push(&child.args, argv[i]);
    -+	child.argv = args->v;
    -+
    - 	if (start_command(&child))
    +-	if (start_command(&child))
    ++		strvec_push(&child->args, argv[i]);
    ++	if (start_command(child))
      		die("could not obtain raw diff");
    - 	fp = xfdopen(child.out, "r");
    -@@ builtin/difftool.c: static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
    - 	strbuf_release(&rdir);
    - 	strbuf_release(&wtdir);
    - 	strbuf_release(&buf);
    -+	strvec_clear(args);
    - 
    - 	return ret;
    - }
    +-	fp = xfdopen(child.out, "r");
    ++	fp = xfdopen(child->out, "r");
      
    --static int run_file_diff(int prompt, const char *prefix,
    --			 int argc, const char **argv)
    -+static int run_file_diff(int prompt, const char *prefix, struct strvec *args)
    - {
    --	struct strvec args = STRVEC_INIT;
    --	const char *env[] = {
    --		"GIT_PAGER=", "GIT_EXTERNAL_DIFF=git-difftool--helper", NULL,
    --		NULL
    --	};
    --	int i;
    -+	struct child_process cmd = CHILD_PROCESS_INIT;
    -+	int ret;
    - 
    -+	strvec_pushl(&cmd.env_array, "GIT_PAGER=",
    -+		     "GIT_EXTERNAL_DIFF=git-difftool--helper", NULL);
    - 	if (prompt > 0)
    --		env[2] = "GIT_DIFFTOOL_PROMPT=true";
    -+		strvec_push(&cmd.env_array, "GIT_DIFFTOOL_PROMPT=true");
    - 	else if (!prompt)
    --		env[2] = "GIT_DIFFTOOL_NO_PROMPT=true";
    -+		strvec_push(&cmd.env_array, "GIT_DIFFTOOL_NO_PROMPT=true");
    - 
    -+	cmd.git_cmd = 1;
    -+	cmd.dir = prefix;
    -+	cmd.argv = args->v;
    - 
    --	strvec_push(&args, "diff");
    --	for (i = 0; i < argc; i++)
    --		strvec_push(&args, argv[i]);
    --	return run_command_v_opt_cd_env(args.v, RUN_GIT_CMD, prefix, env);
    -+	ret = run_command(&cmd);
    -+	strvec_clear(args);
    -+	return ret;
    - }
    + 	/* Build index info for left and right sides of the diff */
    + 	i = 0;
    +@@ builtin/difftool.c: static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
      
    - int cmd_difftool(int argc, const char **argv, const char *prefix)
    + 	fclose(fp);
    + 	fp = NULL;
    +-	if (finish_command(&child)) {
    ++	if (finish_command(child)) {
    + 		ret = error("error occurred running diff --raw");
    + 		goto finish;
    + 	}
     @@ builtin/difftool.c: int cmd_difftool(int argc, const char **argv, const char *prefix)
      		OPT_ARGUMENT("no-index", &no_index, N_("passed to `diff`")),
      		OPT_END()
      	};
    -+	struct strvec args = STRVEC_INIT;
    ++	struct child_process child = CHILD_PROCESS_INIT;
      
      	git_config(difftool_config, NULL);
      	symlinks = has_symlinks;
     @@ builtin/difftool.c: int cmd_difftool(int argc, const char **argv, const char *prefix)
    - 	 * will invoke a separate instance of 'git-difftool--helper' for
      	 * each file that changed.
      	 */
    -+	strvec_push(&args, "diff");
    -+	if (dir_diff)
    -+		strvec_pushl(&args, "--raw", "--no-abbrev", "-z", NULL);
    -+	strvec_pushv(&args, argv);
    -+
      	if (dir_diff)
     -		return run_dir_diff(extcmd, symlinks, prefix, argc, argv);
    --	return run_file_diff(prompt, prefix, argc, argv);
    -+		return run_dir_diff(extcmd, symlinks, prefix, &args);
    -+	return run_file_diff(prompt, prefix, &args);
    ++		return run_dir_diff(extcmd, symlinks, prefix, argc, argv, &child);
    + 	return run_file_diff(prompt, prefix, argc, argv);
      }
-:  ----------- > 2:  1c2794115c7 difftool: prepare "diff" cmdline in cmd_difftool()
-:  ----------- > 3:  2b093bd71fc difftool: use run_command() API in run_file_diff()
2:  28b43789b11 ! 4:  4fddce0a38d parse-options API: remove OPTION_ARGUMENT feature
    @@ builtin/difftool.c: int cmd_difftool(int argc, const char **argv, const char *pr
     +		OPT_BOOL(0, "no-index", &no_index, N_("passed to `diff`")),
      		OPT_END()
      	};
    - 	struct strvec args = STRVEC_INIT;
    + 	struct child_process child = CHILD_PROCESS_INIT;
     @@ builtin/difftool.c: int cmd_difftool(int argc, const char **argv, const char *prefix)
      	 * each file that changed.
      	 */
    - 	strvec_push(&args, "diff");
    + 	strvec_push(&child.args, "diff");
     +	if (no_index)
    -+		strvec_push(&args, "--no-index");
    ++		strvec_push(&child.args, "--no-index");
      	if (dir_diff)
    - 		strvec_pushl(&args, "--raw", "--no-abbrev", "-z", NULL);
    - 	strvec_pushv(&args, argv);
    + 		strvec_pushl(&child.args, "--raw", "--no-abbrev", "-z", NULL);
    + 	strvec_pushv(&child.args, argv);
     
      ## parse-options.c ##
     @@ parse-options.c: static enum parse_opt_result parse_long_opt(
-- 
2.33.0.999.ga5f89b684e9

