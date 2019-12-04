Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF86C43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 07:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 554BA20637
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 07:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHIslWec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfLDHrw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 02:47:52 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38742 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfLDHrw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 02:47:52 -0500
Received: by mail-pg1-f195.google.com with SMTP id t3so2960235pgl.5
        for <git@vger.kernel.org>; Tue, 03 Dec 2019 23:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GfmW/7RmEs3AfjkNmpuAa8mu6tqyS7XsDBOCvOFxbtY=;
        b=eHIslWecYEa8dX7TEgFy4f3fj+cOiVpGQrrWu73AHxBfDG9eJDZSq/AZ2tobcfaAYc
         7Uf1+XpA7Ndhp5kf6dEvChcHyy1Asgn56wLX2Jsh0YLvcYIZNoVJrviR92DeHEcTzcB3
         0HZJ0KQlmMCydEjWjUDUJbiSYiHR8KyM/yO8LCkjV8Pvft7tIPTDPgSodYZPXvLXimWQ
         Y7fblYxGPoxIPgqQIWw5v09bbGqcd7UbfHPQ6DX1YUMypVGTtMb6iN2QD2MXKfdt7jWY
         440dG7ajdhJxzMPcBR8zG958MN5Z0IoVH9oVdBKbteK2fs/Ih5wgKdRkUi/tJmxxDIvy
         VMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GfmW/7RmEs3AfjkNmpuAa8mu6tqyS7XsDBOCvOFxbtY=;
        b=aP8zttc1uBHL7e/g2I/m7HLBP74TDiBhtw1u8WufD4wh7icXK0Wh5ltCZ2NgKDrg2y
         BMVTevs1kReoSj/o0Ck1YIH4bsOEOt+cvYRwSfl3B89bng3DQmfKyXr2/hFi6QlLXbyN
         NRLnmKtxs/JqWSYusBbp5i9IeNCCD3pqm/Ylt7QV+PhpbKHKmglhiwIXKa8voNZ7GscO
         lJzAutBZyTssZCkdBDnD57ixVxtSHPDfH59u0PeNS9YOuNJEPwAko9svgu44QBb4T0Dl
         oBaedqalTzqzf7YQa8FqBlL7EuL3RLwX06sF3BT32JSze3sYwJrUMOVRyvaACzWsAtsR
         YDjw==
X-Gm-Message-State: APjAAAVMLue3qYXiu03MIFRP29mXzbYTHjLycvBrpuh20SR6d+zD9GZm
        1LsZgXz2jIhUJ8yTaTZGVHrdrdkz
X-Google-Smtp-Source: APXvYqwYRVcIIAh9TuKlEiWMZOrQvgSHCvsC8APJ7nFBjvtUtsfmbh8bzI+7ckAkhUF1DArIcnMmGQ==
X-Received: by 2002:a63:cf14:: with SMTP id j20mr2079937pgg.430.1575445671239;
        Tue, 03 Dec 2019 23:47:51 -0800 (PST)
Received: from generichostname ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id r10sm5911394pgn.68.2019.12.03.23.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 23:47:50 -0800 (PST)
Date:   Tue, 3 Dec 2019 23:47:49 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Christian Biesinger <cbiesinger@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/5] rebase: fix breakage with `format.useAutoBase`
Message-ID: <cover.1575445582.git.liu.denton@gmail.com>
References: <cover.1574878089.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574878089.git.liu.denton@gmail.com>
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
 builtin/log.c                      | 24 +++++++++++++++++++++---
 builtin/rebase.c                   |  3 ++-
 t/t3400-rebase.sh                  |  6 ++++++
 t/t4014-format-patch.sh            | 14 +++++++++-----
 5 files changed, 41 insertions(+), 11 deletions(-)

Range-diff against v2:
1:  4089e51041 = 1:  8d67bbe5bf t3400: demonstrate failure with format.useAutoBase
2:  d288d6c3a5 = 2:  8cfde9f98e format-patch: fix indentation
3:  196b5d8dbc = 3:  638c4add00 t4014: use test_config()
4:  f7e5325cc0 ! 4:  6cba51ca24 format-patch: teach --no-base
    @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *pre
     +			   N_("add prerequisite tree info to the patch series"),
     +			   0, base_callback },
      		OPT_FILENAME(0, "signature-file", &signature_file,
    --				N_("add a signature from a file")),
    -+			N_("add a signature from a file")),
    + 				N_("add a signature from a file")),
      		OPT__QUIET(&quiet, N_("don't print the patch filenames")),
    - 		OPT_BOOL(0, "progress", &show_progress,
    - 			 N_("show progress while generating patches")),
     
      ## t/t4014-format-patch.sh ##
     @@ t/t4014-format-patch.sh: test_expect_success 'format-patch --base overrides format.useAutoBase' '
5:  62c59c12e3 = 5:  eb266aaedc rebase: fix format.useAutoBase breakage
-- 
2.24.0.578.g4820254054

