Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA6EC43381
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BFFE20798
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbhAACRG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbhAACRF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:05 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915C4C061573
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:25 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id d203so23463398oia.0
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r/q1cvnuGXJzYSWRjU/1m0wldlngfkNZEpIAEjtmdvc=;
        b=qp3vRamwBZl0eZ1wqMI3WEDZGP6xyJBsVyPaqRZ5AC8F0b6tO9ZGLvVi2fzav/nKs3
         ImpB13mxaSo03B2Ku3gkLBj/54Wi4G4Xrjh8HmIC+2uF1ydn3uaEprDf+8+1BW+4u6hU
         /gl3qevAhGMuwr/hEgMsVhL7tg5hysyQtvDMuUO41qE9ypSY6TfAyJxUt9hYSUQmMCal
         nlAcDihmNrzT+6ObI7fJqHDrM47PlXw8OMuvBPXf3dCWqpIwYU7U5AUDzQzTAxtDb6iq
         yor0hitZF2/hZ6u0uQpNutvfiEjNiudoAj2xsxhV9PplzZzV0kP9DfLFT9iXlJskBz7B
         Ruew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r/q1cvnuGXJzYSWRjU/1m0wldlngfkNZEpIAEjtmdvc=;
        b=b3z0qV8iw1/OgtNUnIvjvbfdREsa5Y0DyP1Ek6/aPDs2aZTOUt7UKwh1c8VZOjUfxU
         Chqx/cfmrwLg9+ez6qq/BGfNkaBdSwDFE1wGRVSZ6BODH8AhBacPy18+jC8GNKly8ECr
         fGoq4OTDARgpNoAjrA1FqPtD8bWt/uT3cIEaZZ4AFR6Amsxw48mwTSAhSJtD8VFCaPY+
         3j1PBjb0OGP6Q64x7eXJm6SfafNQflwJjTCiddnTR+CUIfMStKDvel12SoXqolp6N0WF
         yu8s+BufIFJ6StpykXd+i6a+ssEEma7Sh3PmiyThZnesqEraYkIgm7EYC/eu75Od3gkp
         EL2w==
X-Gm-Message-State: AOAM533YqgdmkNegrZl9YApG9lWYHn8oT7XtwyDZIXiCTyHtMwn5ypKg
        wMSVBwrgrzkyH5gd5H5hg62ce1jC1y7h6w==
X-Google-Smtp-Source: ABdhPJzB0APgUHMkbc0lCqLydKBfhu8TgKPMeIOvnaqzs2zzGJss1p7AKgejUL05kIBnjlAS4+8HNg==
X-Received: by 2002:aca:ab8c:: with SMTP id u134mr9787257oie.15.1609467384602;
        Thu, 31 Dec 2020 18:16:24 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id t19sm12459589otp.36.2020.12.31.18.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:16:23 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 00/47] completion: git-completion 1.3 patches
Date:   Thu, 31 Dec 2020 20:15:35 -0600
Message-Id: <20210101021622.798041-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches represent what comprises git-completion 1.3, a friendly
fork I'm maintaining.

Some of these have already been sent, and should be in "seen", but for
some reason they are not [1]. Others have been sent, but probably won't
receive any review soon. And others, particularly zsh improvements,
haven't been sent before.

A summary:

 * Tons of bugfixes
 * zsh: a bunch of improvements
 * zsh: an important fix regarding quoting
 * zsh: automatic suffix removal

The rest is reorganization, but it's still much needed.

I'm not anticipating these patches to be merged, I'm providing them in
case somebody is interested.

[1] https://lore.kernel.org/git/5fea87e816fff_23821208d4@natae.notmuch/

Felipe Contreras (47):
  completion: bash: fix prefix detection in branch.*
  completion: fix for suboptions with value
  completion: bash: fix for multiple dash commands
  completion: bash: add correct suffix in variables
  completion: bash: do not modify COMP_WORDBREAKS
  test: completion: fix currently typed words
  test: completion: switch __gitcomp_nl prefix test
  test: completion: add run_func() helper
  completion: bash: remove non-append functionality
  completion: bash: get rid of _append() functions
  completion: bash: get rid of any non-append code
  completion: zsh: fix options with arguments
  completion: zsh: expand --git-dir file argument
  completion: zsh: add support for general -C opts
  completion: zsh: fix for undefined completions
  completion: zsh: add support for general -c opts
  completion: zsh: fix extra space on foo=
  completion: zsh: add excluded options
  completion: zsh: always set compset
  completion: factor out check in __gitcomp
  completion: simplify equal suffix check
  completion: refactor __gitcomp
  completion: simplify __gitcomp
  completion: bash: change suffix check in __gitcomp
  completion: improve __gitcomp suffix code
  completion: bash: simplify config_variable_name
  test: completion: add missing test
  completion: bash: improve __gitcomp description
  completion: add __gitcomp_opts
  completion: bash: cleanup __gitcomp* invocations
  completion: bash: shuffle __gitcomp functions
  completion: zsh: simplify __gitcomp_direct
  completion: zsh: shuffle __gitcomp* functions
  completion: zsh: fix direct quoting
  completion: zsh: add elements individually in __gitcomp_opts
  completion: zsh: add __gitcompadd helper
  completion: zsh: add correct removable suffix
  completion: bash: simplify _get_comp_words_by_ref()
  completion: bash: refactor _get_comp_words_by_ref()
  completion: bash: cleanup _get_comp_words_by_ref()
  completion: bash: trivial cleanup
  completion: bash: rename _get_comp_words_by_ref()
  completion: bash: add __git_have_func helper
  completion: bash: improve function detection
  test: completion: add tests for __git_complete
  completion: add proper public __git_complete
  completion: zsh: add higher-priority location

 contrib/completion/git-completion.bash | 704 ++++++++++++-------------
 contrib/completion/git-completion.zsh  | 133 +++--
 t/t9902-completion.sh                  | 179 ++++---
 3 files changed, 498 insertions(+), 518 deletions(-)

-- 
2.30.0

