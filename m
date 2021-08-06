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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9DCC4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 12:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 702AF60EBC
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 12:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245754AbhHFMCZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 08:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbhHFMCY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 08:02:24 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A19C061798
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 05:02:08 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id l19so16365062pjz.0
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 05:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GPNVqTTDSv5GQ5Yz5Mlt9a9xY/9nI/wGU9HKlDP48Eo=;
        b=lO7ld9ZT/59gxN/cdAiD2Ul487cg4ybgtcqLFMc2QzjOh7HMPMNVYBlE+Ddbbh5CUH
         qaeFVLk1iJFwweYrCVm8TgHyLFW9PN9gFLztC6bLYoox78aE/85NjthiJTZHnFnyIPGN
         Nj932IWslrpgDqXMvf/e5pQp5mmgh2lqI0OCgavuwAMK1dA/c3TttnJXYOfm4yo4kkLv
         JNf5vM8csMnHCvACssLE50aFL6afER/HVCJDU4MSiDV9/4ZQGwuL555i1vA86SqWbu9o
         QviWRdtkqSMvmvdhHOJ11WSU5eufy1LKlIs8kTjeTkZuTam7fwhXkLJvcF5FBQ2JlDRA
         NE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GPNVqTTDSv5GQ5Yz5Mlt9a9xY/9nI/wGU9HKlDP48Eo=;
        b=LVS61p/eIukPmi3HV5UVvh5s2VUkYKgkVjUVtc5Pi/LNI8Okt1cSbk2LAdukUH3xXP
         mHhe2ZKRxWu7zPwMQ8TDfH6pJEd+lySSTPiR+DVb+JabUxke9xbA/ve5iRCF2MY3kAZk
         5lkebwd90qDH51I0GOh1HIDx6Vz/fvmsV1COfbxFk6Soi+nIIsvUK3BHAZf1B9K0bOxR
         A+Y0dT42i0KMOeaDMPqwmoXCR7jPj0NfP+mbdoAWr9Vq94lyw/LwlxHgwCgUNegAcmcf
         XKQjFTTgs1q0Q6TKDv84K57+IV24yAK9RSceLUGD+TAS1eU4ZaJyv+s+ixBguDah+rLi
         jlkA==
X-Gm-Message-State: AOAM531KC2//0YkiogWojR8OFOXtS5t2CQank7OLZrsnZeEGiCLKDHkh
        oV4dYt9y3A79EG61v1mZ9iE=
X-Google-Smtp-Source: ABdhPJwJTe58cNrUC2d1+oikZxI+aYJlmpuaGm41UXAHPhKvjkzK5QhGBbVg+7LbvJB2lGEOb/7bxQ==
X-Received: by 2002:a17:90a:1b22:: with SMTP id q31mr10097055pjq.217.1628251327768;
        Fri, 06 Aug 2021 05:02:07 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id z8sm10338162pfa.113.2021.08.06.05.02.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Aug 2021 05:02:07 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: [GSoC] [PATCH v3 0/8] submodule: convert the rest of 'add' to C
Date:   Fri,  6 Aug 2021 17:31:39 +0530
Message-Id: <20210806120147.73349-1-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805074054.29916-1-raykar.ath@gmail.com>
References: <20210805074054.29916-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v2:

* Mention the small overhead introduced in [2/8] in the commit message.
* Attempt a more descriptive name for the libified dir helper. Add a docstring
  to explain it as well.
* Combine the "unconstification of sm_path" patch into the next one.

Atharva Raykar (8):
  submodule--helper: add options for compute_submodule_clone_url()
  submodule--helper: refactor resolve_relative_url() helper
  submodule--helper: remove repeated code in sync_submodule()
  dir: libify and export helper functions from clone.c
  submodule--helper: convert the bulk of cmd_add() to C
  submodule--helper: remove add-clone subcommand
  submodule--helper: remove add-config subcommand
  submodule--helper: remove resolve-relative-url subcommand

 builtin/clone.c             | 118 +-------------
 builtin/submodule--helper.c | 307 +++++++++++++++++++-----------------
 dir.c                       | 114 +++++++++++++
 dir.h                       |  11 ++
 git-submodule.sh            |  96 +----------
 5 files changed, 291 insertions(+), 355 deletions(-)

Range-diff against v2:
-:  ---------- > 1:  75edf24186 submodule--helper: add options for compute_submodule_clone_url()
-:  ---------- > 2:  8e7a3e727a submodule--helper: refactor resolve_relative_url() helper
1:  d8ee0bc450 ! 3:  82961ddd02 submodule--helper: remove repeated code in sync_submodule()
    @@ Commit message
         This part of `sync_submodule()` is doing the same thing that
         `compute_submodule_clone_url()` is doing. Let's reuse that helper here.
     
    +    Note that this change adds a small overhead where we allocate and free
    +    the 'remote' twice, but that is a small price to pay for the higher
    +    level of abstraction we get.
    +
         Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
         Mentored-by: Christian Couder <christian.couder@gmail.com>
         Mentored-by: Shourya Shukla <periperidip@gmail.com>
2:  6ac470d86f ! 4:  99d139375d dir: libify and export helper functions from clone.c
    @@ Commit message
     
         Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
         Mentored-by: Christian Couder <christian.couder@gmail.com>
    -    Mentored-by: Shourya Shukla <shouryashukla.oo@gmail.com>
    +    Mentored-by: Shourya Shukla <periperidip@gmail.com>
     
      ## builtin/clone.c ##
     @@ builtin/clone.c: static char *get_repo_path(const char *repo, int *is_bundle)
    @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
      	else
     -		dir = guess_dir_name(repo_name, is_bundle, option_bare);
     -	strip_trailing_slashes(dir);
    -+		dir = guess_dir_name_from_git_url(repo_name, is_bundle, option_bare);
    ++		dir = guess_target_dir_from_git_url(repo_name, is_bundle, option_bare);
     +	strip_dir_trailing_slashes(dir);
      
      	dest_exists = path_exists(dir);
    @@ dir.c: int is_empty_dir(const char *path)
      	return ret;
      }
      
    -+char *guess_dir_name_from_git_url(const char *repo, int is_bundle, int is_bare)
    ++char *guess_target_dir_from_git_url(const char *repo, int is_bundle, int is_bare)
     +{
     +	const char *end = repo + strlen(repo), *start, *ptr;
     +	size_t len;
    @@ dir.h: static inline int is_dot_or_dotdot(const char *name)
      
      int is_empty_dir(const char *dir);
      
    -+char *guess_dir_name_from_git_url(const char *repo, int is_bundle, int is_bare);
    ++/*
    ++ * Retrieve a target directory name by reading "humanish" part of the
    ++ * given Git URL.
    ++ *
    ++ * For example:
    ++ * 	/path/to/repo.git => "repo"
    ++ * 	host.xz.foo/.git => "foo"
    ++ */
    ++char *guess_target_dir_from_git_url(const char *repo, int is_bundle, int is_bare);
     +void strip_dir_trailing_slashes(char *dir);
     +
      void setup_standard_excludes(struct dir_struct *dir);
3:  c0b264a4e8 < -:  ---------- submodule--helper: remove constness of sm_path
4:  f61124327f ! 5:  11eea777ba submodule--helper: convert the bulk of cmd_add() to C
    @@ Commit message
         Introduce the 'add' subcommand to `submodule--helper.c` that does all
         the work 'submodule add' past the parsing of flags.
     
    +    We also remove the constness of the sm_path field of the `add_data`
    +    struct. This is needed so that it can be modified by
    +    normalize_path_copy().
    +
         As with the previous conversions, this is meant to be a faithful
         conversion with no modification to the behaviour of `submodule add`.
     
    @@ Commit message
         Based-on-patch-by: Prathamesh Chavan <pc44800@gmail.com>
     
      ## builtin/submodule--helper.c ##
    +@@ builtin/submodule--helper.c: struct add_data {
    + 	const char *prefix;
    + 	const char *branch;
    + 	const char *reference_path;
    +-	const char *sm_path;
    ++	char *sm_path;
    + 	const char *sm_name;
    + 	const char *repo;
    + 	const char *realrepo;
     @@ builtin/submodule--helper.c: static int add_config(int argc, const char **argv, const char *prefix)
      	return 0;
      }
    @@ builtin/submodule--helper.c: static int add_config(int argc, const char **argv,
     +
     +	add_data.repo = argv[0];
     +	if (argc == 1)
    -+		add_data.sm_path = guess_dir_name_from_git_url(add_data.repo, 0, 0);
    ++		add_data.sm_path = guess_target_dir_from_git_url(add_data.repo, 0, 0);
     +	else
     +		add_data.sm_path = xstrdup(argv[1]);
     +
    @@ builtin/submodule--helper.c: static int add_config(int argc, const char **argv,
     +		if ((exit_code = pipe_command(&cp, NULL, 0, NULL, 0, &sb, 0))) {
     +			strbuf_complete_line(&sb);
     +			fputs(sb.buf, stderr);
    ++			free(add_data.sm_path);
     +			return exit_code;
     +		}
     +		strbuf_release(&sb);
    @@ builtin/submodule--helper.c: static int add_config(int argc, const char **argv,
     +	add_data.progress = !!progress;
     +	add_data.dissociate = !!dissociate;
     +
    -+	if (add_submodule(&add_data))
    ++	if (add_submodule(&add_data)) {
    ++		free(add_data.sm_path);
     +		return 1;
    ++	}
     +	configure_added_submodule(&add_data);
     +	free(add_data.sm_path);
     +
5:  0c37bf84c3 = 6:  51393cd99b submodule--helper: remove add-clone subcommand
6:  d7e0db2565 = 7:  50cedcd8a8 submodule--helper: remove add-config subcommand
7:  6dd7cb1e18 = 8:  02558da532 submodule--helper: remove resolve-relative-url subcommand
-- 
2.32.0

