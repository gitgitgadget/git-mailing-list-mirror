Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C632EC00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 23:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60DE02225E
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 23:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8J2kpT0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgKBXpi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 18:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgKBXpi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 18:45:38 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C337FC0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 15:45:37 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 33so5726449wrl.7
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 15:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hI7cCXdi6R5ujHR9vWmQG88xwGtWx3rJxz6tsaW3ZeA=;
        b=n8J2kpT0GB4XhlpwAlW0jKtXvCgIXslaPld2+kBu5dgU1i8ujb7UtSChZpnFg0zVFA
         yJjEdXAu7K6lN6AJWDqVXAHI7i0sK/DIewMKSNbkYeEh6Yq3RkfIWXQRpSeAKFRGnWd+
         Cx88UlqIZC00a+nN46f043sjJW4n3OzbhslNrFEVmdEEgph2rUIJ827wHcrZUO/rMWni
         9V0ihlL9PXA5TZ4AwpEMY9Zh6VpoJQcQfUyhJ8U8JzkrL+zE3M/wuDCpMxXa8Cgtc4nP
         Ykvzc5yp0wEECleS8kVRaLhBfgBy4ZWsib8q1/MbAkTCFcQx8NwrPV1dTEMSq/EENXIe
         04kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hI7cCXdi6R5ujHR9vWmQG88xwGtWx3rJxz6tsaW3ZeA=;
        b=Gx6u9aNmWo2KNsae41AARE6OBCfG7d71WcJ3MauBh8x4S1lX7orgxmSgBnwYOnLf42
         nzElZclxw/jRjcNoKikIW56kEURwwXrs6k5VX4fZzKwo3QwMOIVjTkcx2vJz7UzJ4Bum
         vMsDkJ7t9QRLoEdt1rnBAIq8IlPT6MjxJo1L3Pw98sXSLpuN3P+deNfdKImkC+Piec6L
         NPplkZNeMvmRZLbSV6yj9f7l4N0ek1kitOVcXHFdBBDuddu1GoBlAUUy5T3ZdvLtMicl
         QWshBzghLmM+8V9tcF2Wtp2OVkatApOnKf0+cEsf737qn1rBg4D6FgcU2JnX80WI4b9Y
         Q1qg==
X-Gm-Message-State: AOAM532J7D7/Jslmf5zvYr/d1XUTIUfasv1O6bKKm0SL35T5Wk4cwofY
        0E4K3e+LRLdnG3g+o56h1APG3bvuqG8=
X-Google-Smtp-Source: ABdhPJwGok+e+zCLG4+WyxGmHEOHWOy/bIx53bgsFAna/KWk/FPo5i2j2CnRafPXmVi9MCAVD2+p2A==
X-Received: by 2002:adf:9e48:: with SMTP id v8mr11548205wre.55.1604360736163;
        Mon, 02 Nov 2020 15:45:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r10sm1075400wmg.16.2020.11.02.15.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 15:45:35 -0800 (PST)
Message-Id: <pull.895.v5.git.git.1604360734.gitgitgadget@gmail.com>
In-Reply-To: <pull.895.v4.git.git.1604003535.gitgitgadget@gmail.com>
References: <pull.895.v4.git.git.1604003535.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Nov 2020 23:45:30 +0000
Subject: [PATCH v5 0/4] Beginning of new merge strategy: New API, empty implementation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Peter Baumann <peter.baumann@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In this series, I show the new merge API I have developed in merge-ort, and
show how it differs from that provided by merge-recursive. I do this in four
steps, each corresponding to a patch.

Changes since v4:

 * Fix a bug where 'cherry-pick --continue' would report 'fatal:
   cherry-pick: --strategy cannot be used with --continue' when pull.twohead
   was set to ort (found by user of internal deployment at $DAYJOB)

Elijah Newren (4):
  merge-ort: barebones API of new merge strategy with empty
    implementation
  merge-ort-wrappers: new convience wrappers to mimic the old merge API
  fast-rebase: demonstrate merge-ort's API via new test-tool command
  merge,rebase,revert: select ort or recursive by config or environment

 Makefile                    |   3 +
 builtin/merge.c             |  26 ++++-
 builtin/rebase.c            |  13 ++-
 builtin/revert.c            |   7 ++
 merge-ort-wrappers.c        |  62 +++++++++++
 merge-ort-wrappers.h        |  25 +++++
 merge-ort.c                 |  52 +++++++++
 merge-ort.h                 |  58 ++++++++++
 sequencer.c                 |  72 ++++++++++--
 sequencer.h                 |   1 +
 t/helper/test-fast-rebase.c | 211 ++++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c        |   1 +
 t/helper/test-tool.h        |   1 +
 13 files changed, 517 insertions(+), 15 deletions(-)
 create mode 100644 merge-ort-wrappers.c
 create mode 100644 merge-ort-wrappers.h
 create mode 100644 merge-ort.c
 create mode 100644 merge-ort.h
 create mode 100644 t/helper/test-fast-rebase.c


base-commit: 69986e19ffcfb9af674ae5180689ab7bbf92ed28
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-895%2Fnewren%2Fort-api-with-empty-implementation-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-895/newren/ort-api-with-empty-implementation-v5
Pull-Request: https://github.com/git/git/pull/895

Range-diff vs v4:

 1:  3357ea415e = 1:  3357ea415e merge-ort: barebones API of new merge strategy with empty implementation
 2:  d7f6a834ab = 2:  d7f6a834ab merge-ort-wrappers: new convience wrappers to mimic the old merge API
 3:  fce0db8778 = 3:  fce0db8778 fast-rebase: demonstrate merge-ort's API via new test-tool command
 4:  75d19804bd ! 4:  61217a83bd merge,rebase,revert: select ort or recursive by config or environment
     @@ builtin/rebase.c: static struct replay_opts get_replay_opts(const struct rebase_
      -	replay.strategy = opts->strategy;
      +	if (opts->strategy)
      +		replay.strategy = opts->strategy;
     ++	else if (!replay.strategy && replay.default_strategy) {
     ++		replay.strategy = replay.default_strategy;
     ++		replay.default_strategy = NULL;
     ++	}
       
       	if (opts->strategy_opts)
       		parse_strategy_opts(&replay, opts->strategy_opts);
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
       	case REBASE_PRESERVE_MERGES:
      
       ## builtin/revert.c ##
     +@@ builtin/revert.c: static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
     + 				NULL);
     + 	}
     + 
     ++	if (!opts->strategy && opts->default_strategy) {
     ++		opts->strategy = opts->default_strategy;
     ++		opts->default_strategy = NULL;
     ++	}
     ++
     + 	if (opts->allow_ff)
     + 		verify_opt_compatible(me, "--ff",
     + 				"--signoff", opts->signoff,
      @@ builtin/revert.c: static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
       	/* These option values will be free()d */
       	opts->gpg_sign = xstrdup_or_null(opts->gpg_sign);
     @@ sequencer.c: static int git_sequencer_config(const char *k, const char *v, void
       		return 0;
       	}
       
     -+	if (!opts->strategy && !strcmp(k, "pull.twohead")) {
     -+		int ret = git_config_string((const char**)&opts->strategy, k, v);
     ++	if (!opts->default_strategy && !strcmp(k, "pull.twohead")) {
     ++		int ret = git_config_string((const char**)&opts->default_strategy, k, v);
      +		if (ret == 0) {
      +			/*
      +			 * pull.twohead is allowed to be multi-valued; we only
      +			 * care about the first value.
      +			 */
     -+			char *tmp = strchr(opts->strategy, ' ');
     ++			char *tmp = strchr(opts->default_strategy, ' ');
      +			if (tmp)
      +				*tmp = '\0';
      +		}
     @@ sequencer.c: static int git_sequencer_config(const char *k, const char *v, void
       	status = git_gpg_config(k, v, NULL);
       	if (status)
       		return status;
     +@@ sequencer.c: int sequencer_remove_state(struct replay_opts *opts)
     + 	free(opts->committer_name);
     + 	free(opts->committer_email);
     + 	free(opts->gpg_sign);
     ++	free(opts->default_strategy);
     + 	free(opts->strategy);
     + 	for (i = 0; i < opts->xopts_nr; i++)
     + 		free(opts->xopts[i]);
      @@ sequencer.c: static int do_recursive_merge(struct repository *r,
       			      struct replay_opts *opts)
       {
     @@ sequencer.c: static int do_merge(struct repository *r,
       	if (ret <= 0)
       		fputs(o.obuf.buf, stdout);
       	strbuf_release(&o.obuf);
     +
     + ## sequencer.h ##
     +@@ sequencer.h: struct replay_opts {
     + 	int explicit_cleanup;
     + 
     + 	/* Merge strategy */
     ++	char *default_strategy;  /* from config options */
     + 	char *strategy;
     + 	char **xopts;
     + 	size_t xopts_nr, xopts_alloc;

-- 
gitgitgadget
