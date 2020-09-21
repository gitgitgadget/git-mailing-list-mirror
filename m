Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B69C4727D
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8104E23A65
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBG0v67r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbgIUW2V (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 18:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgIUW2V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 18:28:21 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4863C061755
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 15:28:20 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l9so1164013wme.3
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 15:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ge3gcn8blRVm7jWGRWjpGB2Dm0d7FjtXHinUNOuxghE=;
        b=HBG0v67raONAAy/VHTGS0bxYkG+V6XkIGk8ZPpuYNNUCNShCZFXl+SOzCe/zsL9H7B
         ihDwZYjGQweHbfiE2Y2B07o38ex0McdxWkxUeg41GQnzXss+M4QdvMkaUhd49iPNvIhJ
         iCBKPJCbWqY8G9kP89hGJZCsDKdQ6+CQjC0fV11hdgwZdfJ7jYf8heO1xJXreOGfcnjV
         orE5dZcOvSAEvNENZX4ym7HyI4g8BbYAmbei/lvcZBIa9kdECG00T1RVPwuZYRekaA3+
         ToUvkxcTX1Sf+PbA53hmW5wR4VbZLkxD2X5KjmPspw6+XKtxMLorClPiotJVa+WVIVLd
         gdlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ge3gcn8blRVm7jWGRWjpGB2Dm0d7FjtXHinUNOuxghE=;
        b=tsMH3wXpGEWV4NN0kxVs/GhlEzzbyskgb2QoMjrGRjnyKcklza+yU+TgnwvSqYWf21
         jiUbb6II3hSu6wVzNLqHFGpdvgLsfMcyaZsolPjsZMWNR5bxgPt6ui/htbrahQcHp7g7
         fLdVGccLGWuyXYtGIG1tdhdswG5lxNdINYaPoKHl7pu+4d7XR0TkDi10SAtg6n7uEnWJ
         rQG4l9JBniD5S/LSDbzfB3zZQhywQv+jDhePieVrvjSfndKVoATTbzgeCzYSgumAFl1h
         v0RthpUvSZUSLV9AVKRtErvJXFdMQTbDLNzNOxr+yqsnUs99OMGKsM9nF8+CGs6VZt+f
         9r2Q==
X-Gm-Message-State: AOAM533Odl1sKcsBkWTQDBS+3iX9Tgd+XyODf2X9/hKT1EU1Pxl3kOuq
        66rRxxPC3gf5BnSgXLHGFVhwoyw5eH0=
X-Google-Smtp-Source: ABdhPJzkYHfUg7kkG5AYO9/rdlEskLwsuTGFy3Q/ifAzkjsaAfrsxdR2iAUTFHQtxn2PYWpFIVphDA==
X-Received: by 2002:a7b:c0c5:: with SMTP id s5mr1342369wmh.152.1600727299317;
        Mon, 21 Sep 2020 15:28:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h2sm23886996wrp.69.2020.09.21.15.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 15:28:18 -0700 (PDT)
Message-Id: <pull.411.v4.git.1600727297.gitgitgadget@gmail.com>
In-Reply-To: <pull.411.v3.git.1598443012.gitgitgadget@gmail.com>
References: <pull.411.v3.git.1598443012.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Sep 2020 22:28:14 +0000
Subject: [PATCH v4 0/3] Optionally skip linking/copying the built-ins
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The dashed invocation of Git commands (git-rev-parse instead of git
rev-parse) is deprecated for a long time already. This patch series makes it
possible to skip building (and installing) them.

Incidentally, these patches also handle the .pdb issue in MSVC's install 
Makefile target that Peff pointed out in the context of the "slimming down"
patch series
[https://lore.kernel.org/git/20200813145719.GA891370@coredump.intra.peff.net/]
.

This addresses https://github.com/gitgitgadget/git/issues/406

Changes since v3:

 * We now skip linking the built-ins in all CI jobs, including the
   containerized builds.
 * The commit message of the third patch was rewritten for clarity.
 * Rebased on top of master to resolve merge conflicts with jk/slimmed-down.

Changes since v2:

 * Reworded and clarified the commit messages of the second and the third
   patch.

Changes since v1:

 * Fixed check-docs under SKIP_DASHED_BUILT_INS
 * Renamed ALL_PROGRAMS_AND_BUILT_INS to ALL_COMMANDS_TO_INSTALL to reflect
   its purpose better.
 * Revamped the commit message of patch 2/3 and 3/3.

Johannes Schindelin (3):
  msvc: copy the correct `.pdb` files in the Makefile target `install`
  Optionally skip linking/copying the built-ins
  ci: stop linking built-ins to the dashed versions

 Makefile  | 66 ++++++++++++++++++++++++++++++++-----------------------
 ci/lib.sh |  1 +
 2 files changed, 40 insertions(+), 27 deletions(-)


base-commit: 385c171a018f2747b329bcfa6be8eda1709e5abd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-411%2Fdscho%2Foptionally-skip-dashed-built-ins-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-411/dscho/optionally-skip-dashed-built-ins-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/411

Range-diff vs v3:

 1:  1880a0e4bf ! 1:  5df767c919 msvc: copy the correct `.pdb` files in the Makefile target `install`
     @@ Makefile: ifdef MSVC
       	# because it is just a copy/hardlink of git.exe, rather than a unique binary.
      -	$(INSTALL) git.pdb '$(DESTDIR_SQ)$(bindir_SQ)'
      -	$(INSTALL) git-shell.pdb '$(DESTDIR_SQ)$(bindir_SQ)'
     --	$(INSTALL) git-upload-pack.pdb '$(DESTDIR_SQ)$(bindir_SQ)'
     --	$(INSTALL) git-credential-store.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
      -	$(INSTALL) git-daemon.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
     --	$(INSTALL) git-fast-import.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
      -	$(INSTALL) git-http-backend.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
      -	$(INSTALL) git-http-fetch.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
      -	$(INSTALL) git-http-push.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
      -	$(INSTALL) git-imap-send.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
      -	$(INSTALL) git-remote-http.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
     --	$(INSTALL) git-remote-testsvn.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
      -	$(INSTALL) git-sh-i18n--envsubst.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
     --	$(INSTALL) git-show-index.pdb '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
      +	$(INSTALL) $(patsubst %.exe,%.pdb,$(filter-out $(BUILT_INS),$(patsubst %,%$X,$(BINDIR_PROGRAMS_NEED_X)))) '$(DESTDIR_SQ)$(bindir_SQ)'
      +	$(INSTALL) $(patsubst %.exe,%.pdb,$(filter-out $(BUILT_INS) $(REMOTE_CURL_ALIASES),$(PROGRAMS))) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
       ifndef DEBUG
 2:  52deafded5 = 2:  14d6eeefbc Optionally skip linking/copying the built-ins
 3:  99a5328492 < -:  ---------- ci: stop linking built-ins to the dashed versions
 -:  ---------- > 3:  1fdf24af36 ci: stop linking built-ins to the dashed versions

-- 
gitgitgadget
