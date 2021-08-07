Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86095C4338F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 07:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67ADD610C7
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 07:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhHGHRK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Aug 2021 03:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbhHGHRK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Aug 2021 03:17:10 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DB7C0613CF
        for <git@vger.kernel.org>; Sat,  7 Aug 2021 00:16:53 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id pj14-20020a17090b4f4eb029017786cf98f9so21436058pjb.2
        for <git@vger.kernel.org>; Sat, 07 Aug 2021 00:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bqaM6y9t0vhhp+MPzNNl4gCh92uitzXLMp+ygdI6vVg=;
        b=axhCn/I14G54zejdzN8D4962hQBuvj2SnChk7OT4ZZUUUTTm4Xfe5/hm5MLkeRC1M4
         vNR8VWeVCgSEKAewkKGsVyde0AOl0M9rEK7fqeOA4bf4e9lcQZ0zO2hifMOvkY43fifw
         utfIwng5DMDofL2u2oz/+wbcdee8LzEJELFIqBX8nwbZOPoXnQTvBzncC33KeHFjIlFI
         Mxhfo31v5/cNofiamXO+qRkwe5qFa3I/U6dTLVzjSTNua5iICP/z8B1heDd1ODJk2ZLM
         WdIgqPXNLu9DAonTiQIHUtW6msCk6ynuSDauH1N3rwNhaBhHI0M94P+onPXV5DIrPCym
         XGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bqaM6y9t0vhhp+MPzNNl4gCh92uitzXLMp+ygdI6vVg=;
        b=CeCtR7f71xuZsoWnlEu54908aS/8qYRDQbXEs/iH0dTgwThDPq5Gm7dKGJXNUjvDJ+
         6kCdwvJTcXsMqs9bLzqSqGjQ62A90pYqfsNgGLX9zUyeD+OzZ/CPw39LG440DJYbNJhR
         18AN/F22mMl0dDFCDLE7gTClv9lGG8Eqcc8zqJJrWoAeQVIRaxClCSCsAnlUZ1UdqE3u
         jhrzf//XyBSoyiKsN/LME20bfyZu4bPHcK0VapgLPgTgpH9rV+LeFutpo2BlzADsQfXQ
         V02FQYXYvaD5Aul4x5yhoklmC5e6YOeF0tYjOWGbjyvxQRsq3sLaZ+TfC/rHEAnSIIBh
         HynQ==
X-Gm-Message-State: AOAM533E42Sq56cDMNlhXl1lw/oaz9kXvoiJbW0TDj0S/r8jPXZuQiKS
        w5kukywg6zTUtbs2Wl2XoV0=
X-Google-Smtp-Source: ABdhPJxoYCdeNYmF3tX5GO50Fa5/S64jRtXcfsEpIX7bTOMkEP5o9yRV7Z4V5Rj/kT3X41mkMsGCxw==
X-Received: by 2002:a17:90a:d686:: with SMTP id x6mr15935438pju.8.1628320612967;
        Sat, 07 Aug 2021 00:16:52 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id b15sm14604981pgm.15.2021.08.07.00.16.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Aug 2021 00:16:52 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: [GSoC] [PATCH v4 0/8] submodule: convert the rest of 'add' to C
Date:   Sat,  7 Aug 2021 12:46:05 +0530
Message-Id: <20210807071613.99610-1-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210806120147.73349-1-raykar.ath@gmail.com>
References: <20210806120147.73349-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v3:

* Rename the libified dir helper and update the docstring.

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
 dir.h                       |  10 ++
 git-submodule.sh            |  96 +----------
 5 files changed, 290 insertions(+), 355 deletions(-)

Range-diff against v3:
-:  ---------- > 1:  75edf24186 submodule--helper: add options for compute_submodule_clone_url()
-:  ---------- > 2:  8e7a3e727a submodule--helper: refactor resolve_relative_url() helper
-:  ---------- > 3:  82961ddd02 submodule--helper: remove repeated code in sync_submodule()
1:  99d139375d ! 4:  fa97d6801e dir: libify and export helper functions from clone.c
    @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
      	else
     -		dir = guess_dir_name(repo_name, is_bundle, option_bare);
     -	strip_trailing_slashes(dir);
    -+		dir = guess_target_dir_from_git_url(repo_name, is_bundle, option_bare);
    ++		dir = git_url_basename(repo_name, is_bundle, option_bare);
     +	strip_dir_trailing_slashes(dir);
      
      	dest_exists = path_exists(dir);
    @@ dir.c: int is_empty_dir(const char *path)
      	return ret;
      }
      
    -+char *guess_target_dir_from_git_url(const char *repo, int is_bundle, int is_bare)
    ++char *git_url_basename(const char *repo, int is_bundle, int is_bare)
     +{
     +	const char *end = repo + strlen(repo), *start, *ptr;
     +	size_t len;
    @@ dir.h: static inline int is_dot_or_dotdot(const char *name)
      int is_empty_dir(const char *dir);
      
     +/*
    -+ * Retrieve a target directory name by reading "humanish" part of the
    -+ * given Git URL.
    ++ * Retrieve the "humanish" basename of the given Git URL.
     + *
     + * For example:
     + * 	/path/to/repo.git => "repo"
     + * 	host.xz.foo/.git => "foo"
     + */
    -+char *guess_target_dir_from_git_url(const char *repo, int is_bundle, int is_bare);
    ++char *git_url_basename(const char *repo, int is_bundle, int is_bare);
     +void strip_dir_trailing_slashes(char *dir);
     +
      void setup_standard_excludes(struct dir_struct *dir);
2:  11eea777ba ! 5:  a3aa25518d submodule--helper: convert the bulk of cmd_add() to C
    @@ builtin/submodule--helper.c: static int add_config(int argc, const char **argv,
     +
     +	add_data.repo = argv[0];
     +	if (argc == 1)
    -+		add_data.sm_path = guess_target_dir_from_git_url(add_data.repo, 0, 0);
    ++		add_data.sm_path = git_url_basename(add_data.repo, 0, 0);
     +	else
     +		add_data.sm_path = xstrdup(argv[1]);
     +
3:  51393cd99b = 6:  9667159d4b submodule--helper: remove add-clone subcommand
4:  50cedcd8a8 = 7:  dc87b5627a submodule--helper: remove add-config subcommand
5:  02558da532 = 8:  ea08e4fbad submodule--helper: remove resolve-relative-url subcommand
-- 
2.32.0

