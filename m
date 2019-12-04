Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C65C43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 21:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6979421826
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 21:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nu1bfRZp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfLDVYv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 16:24:51 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41896 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbfLDVYv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 16:24:51 -0500
Received: by mail-pg1-f195.google.com with SMTP id x8so462531pgk.8
        for <git@vger.kernel.org>; Wed, 04 Dec 2019 13:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3XDLw09wDmNvpjinP5FCW+1C3AnVUpEXrbChDzzL3SE=;
        b=Nu1bfRZpYR6uKnP/VDU9PC5sBu+1gIoaLgyNB+CcXit0jCRQ99DjN7SZdUYw4TLE9P
         K+Om2rSAtqAZu5Mj/t48eayWpSgp1Ffx9W8gJscBcLqP/GJarzpErZBu53sdF/N2hNO0
         W4EhOxlAenyzsOviB0v7BOsPTLtBba4LNEu5rDF3rlEWQFPbXBeSoDGH91AyY+PnlvHy
         LCWOdnhdo4KwrjaYfLvprp3oUs2ccR/IMtpsyAJmofq4p9/LX3ZcgChZqnKcz/NGonnR
         TpN+7MXULLQaeK73OzbXiF8uyVZsY7Pn4h5tU3YUnQtNPGz85YbZIYZOuBlbr9cKbVyU
         qDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3XDLw09wDmNvpjinP5FCW+1C3AnVUpEXrbChDzzL3SE=;
        b=HWhNxG4gsLTufyfVt+Bhhq0T2QeNlvJqs/dZXFzhtpojfuN7SMPIjGRituMLWMtLH0
         26jC4dpQagTn3JR4TGAFOjD4xRQFfvRfdfXhfhdiBt+nXMwLWc6vVoMrA2ttq55NUpGP
         JmqhA38lOlzwtRtWwXwuTU+K2y/PACJ2p42FePciHkfMVvzqT4JKh7bzSa7cUms70BWK
         uOX21RXwHaneQRvytG1rUfeLhVsM84qQclwM62lAR++1aCtwlhQOHYECTctdHea4HD3D
         wG4DTc0ky0WWZkNxJ/Llza2nwue5SdyZ2+J1QtbFzfWjJIRm0OZIBQMmZTh+yMZNHliU
         KZfQ==
X-Gm-Message-State: APjAAAXiDl6Vrb8ZVQs17xnIKqEav+ycYFvagTsVA0g1+7r+KYABITKZ
        93ebe1XgJsZea6a+bQvf7NCIKvf2
X-Google-Smtp-Source: APXvYqzCHsqHnspnYce7uABc4voMAoiXfBTZNi7geJXZuwXHHtzu7lhM/LUBNS4D0BWWU2rD2J1kWw==
X-Received: by 2002:a63:1b53:: with SMTP id b19mr5721360pgm.5.1575494689756;
        Wed, 04 Dec 2019 13:24:49 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id q13sm7477189pjc.4.2019.12.04.13.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 13:24:48 -0800 (PST)
Date:   Wed, 4 Dec 2019 13:24:44 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Christian Biesinger <cbiesinger@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v4 0/5] rebase: fix breakage with `format.useAutoBase`
Message-ID: <cover.1575494617.git.liu.denton@gmail.com>
References: <cover.1575445582.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1575445582.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apparently, this use case has been broken for a long time... Since
bb52995f3e (format-patch: introduce format.useAutoBase configuration,
2016-04-26). I'm surprised it's only been reported now.

This patchset fixes the breakage by teaching
`git format-patch --no-base` and making rebase use it.

This patch is based on the latest master since it's such an old bug that
only got noticed recently, I'm not sure if it's worth fixing in 'maint'.
The series does not apply cleanly on top of 'maint' because it relies on
c1a6f21cd4 (Doc: add more detail for git-format-patch, 2019-08-27) but
the conflicts are relatively minor.

Changes since v3:

* Correct error in log messages more precise by saying that rebases fail
  in general (even if an upstream is set)

* Change ugly use of OPT_CALLBACK into a more elegant form

Changes since v2:

* Remove spurious indentation change

* Rebase onto the latest master

Changes since v1:

* Update some log messages

Denton Liu (5):
  t3400: demonstrate failure with format.useAutoBase
  format-patch: fix indentation
  t4014: use test_config()
  format-patch: teach --no-base
  rebase: fix format.useAutoBase breakage

 Documentation/git-format-patch.txt |  5 +++--
 builtin/log.c                      |  9 ++++++---
 builtin/rebase.c                   |  3 ++-
 t/t3400-rebase.sh                  |  6 ++++++
 t/t4014-format-patch.sh            | 14 +++++++++-----
 5 files changed, 26 insertions(+), 11 deletions(-)

Range-diff against v3:
1:  78b928bf49 ! 1:  386148a550 t3400: demonstrate failure with format.useAutoBase
    @@ Commit message
     
         Ever since bb52995f3e (format-patch: introduce format.useAutoBase
         configuration, 2016-04-26), `git rebase` has been broken when
    -    `format.useAutoBase = true`. It fails when rebasing a branch that
    -    doesn't have an upstream set:
    +    `format.useAutoBase = true`. It fails when rebasing a branch:
     
                 fatal: failed to get upstream, if you want to record base commit automatically,
                 please use git branch --set-upstream-to to track a remote branch.
2:  5435a04427 = 2:  0464bd61c2 format-patch: fix indentation
3:  455f2df08d = 3:  a55eacbad7 t4014: use test_config()
4:  7c7b94c0c4 ! 4:  eb35de8f49 format-patch: teach --no-base
    @@ Commit message
         format-patch: teach --no-base
     
         If `format.useAutoBase = true`, there was no way to override this from
    -    the command-line. Teach format-patch the `--no-base` option which
    -    overrides `format.useAutoBase`.
    +    the command-line. Teach the `--no-base` option in format-patch to
    +    override `format.useAutoBase`.
    +
    +    Helped-by: René Scharfe <l.s.r@web.de>
     
      ## Documentation/git-format-patch.txt ##
     @@ Documentation/git-format-patch.txt: you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
    @@ Documentation/git-format-patch.txt: you can use `--suffix=-patch` to get `0001-d
      	Treat the revision argument as a <revision range>, even if it
     
      ## builtin/log.c ##
    -@@ builtin/log.c: static int from_callback(const struct option *opt, const char *arg, int unset)
    - 	return 0;
    - }
    - 
    -+static int base_callback(const struct option *opt, const char *arg, int unset)
    -+{
    -+	char **base_commit = opt->value;
    -+
    -+	free(*base_commit);
    -+
    -+	if (unset) {
    -+		base_auto = 0;
    -+		*base_commit = NULL;
    -+	} else if (arg) {
    -+		*base_commit = xstrdup(arg);
    -+	} else {
    -+		BUG("arg is NULL");
    -+	}
    -+	return 0;
    -+}
    -+
    - struct base_tree_info {
    - 	struct object_id base_commit;
    - 	int nr_patch_id, alloc_patch_id;
    +@@ builtin/log.c: static struct commit *get_base_commit(const char *base_commit,
    + 		base = lookup_commit_reference_by_name(base_commit);
    + 		if (!base)
    + 			die(_("unknown commit %s"), base_commit);
    +-	} else if ((base_commit && !strcmp(base_commit, "auto")) || base_auto) {
    ++	} else if ((base_commit && !strcmp(base_commit, "auto"))) {
    + 		struct branch *curr_branch = branch_get(NULL);
    + 		const char *upstream = branch_get_upstream(curr_branch, NULL);
    + 		if (upstream) {
     @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *prefix)
    - 			    PARSE_OPT_OPTARG, thread_callback },
    - 		OPT_STRING(0, "signature", &signature, N_("signature"),
    - 			    N_("add a signature")),
    --		OPT_STRING(0, "base", &base_commit, N_("base-commit"),
    --			   N_("add prerequisite tree info to the patch series")),
    -+		{ OPTION_CALLBACK, 0, "base", &base_commit, N_("base-commit"),
    -+			   N_("add prerequisite tree info to the patch series"),
    -+			   0, base_callback },
    - 		OPT_FILENAME(0, "signature-file", &signature_file,
    --				N_("add a signature from a file")),
    -+			N_("add a signature from a file")),
    - 		OPT__QUIET(&quiet, N_("don't print the patch filenames")),
    - 		OPT_BOOL(0, "progress", &show_progress,
    - 			 N_("show progress while generating patches")),
    + 	s_r_opt.def = "HEAD";
    + 	s_r_opt.revarg_opt = REVARG_COMMITTISH;
    + 
    ++	if (base_auto)
    ++		base_commit = "auto";
    ++
    + 	if (default_attach) {
    + 		rev.mime_boundary = default_attach;
    + 		rev.no_inline = 1;
    +@@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *prefix)
    + 	}
    + 
    + 	memset(&bases, 0, sizeof(bases));
    +-	if (base_commit || base_auto) {
    ++	if (base_commit) {
    + 		struct commit *base = get_base_commit(base_commit, list, nr);
    + 		reset_revision_walk();
    + 		clear_object_flags(UNINTERESTING);
     
      ## t/t4014-format-patch.sh ##
     @@ t/t4014-format-patch.sh: test_expect_success 'format-patch --base overrides format.useAutoBase' '
5:  2b4166e371 ! 5:  210905f163 rebase: fix format.useAutoBase breakage
    @@ Commit message
         rebase: fix format.useAutoBase breakage
     
         With `format.useAutoBase = true`, running rebase resulted in an
    -    error when an upstream wasn't set:
    +    error:
     
                 fatal: failed to get upstream, if you want to record base commit automatically,
                 please use git branch --set-upstream-to to track a remote branch.
-- 
2.24.0.578.g4820254054

