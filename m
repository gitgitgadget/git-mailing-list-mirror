Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CF8C11F67
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 19:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 488AC61DE3
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 19:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbhF2TGF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 15:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235375AbhF2TGE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 15:06:04 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED73FC061760
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 12:03:36 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id l8so370022wry.13
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 12:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/c/QXtu3sJARVbpO6VIftwIhB831qwuRiSoZCluBkBE=;
        b=IJKuXhnHj9liR+G4TslSe/WBNZsEl81G7r47zJ1m454dBkBlYzXTscBEDc5MFXGibx
         l4Lmf0Tf0UJqjyuydVgp6a8lN12JJdbPBvZ8DkIbdP3e/fkId4P0lOkNcRxsA0y88+/3
         Fn4pQyj6SEqvFVFo9v4/StVLaup3xppfSq+K+xkn4nyv01P3qbfyRjEmdGjq0i0OKNnd
         nHH1kNl0ZDDfG9WLrLsq++YoW7zi5uHCbJfFNSE48SYyGyugE26qMVU+T9n0ChqTl/8Q
         q+QsXD4jRV+0FSBHQuFFsStKm2+WlIeRVtzKv48A5TQ5DlsEjMbfTETod3zI9rKR62+N
         Vn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/c/QXtu3sJARVbpO6VIftwIhB831qwuRiSoZCluBkBE=;
        b=Xv9y6lzuZajmzQKuYdV9yDHgQZdjWtkG8CsjZkXZUgJt+7nAljfY4om4igP6Fnfr5+
         CLrfKZN6nknrX9br5bsEmdy4He+dNN5qQ1o7NqVYvxxOINsZIAWU6FHXf3JH3eltuwc1
         pGocHdcCEaBzLfYrVKxiJ8VTVHufVyUgkgrCWBTsSKlbvGhVZWthfwyP+9bn+YFSdUHv
         z7iDIadS0Iaa+TOFUdygFC2QbpxK4EE36JE6svsdK4EwFzwyYjyANwwlHsyjZOSfitqc
         0rAHP/dfMFkZa5028BfLLv9TBvyf/O+B53LLckDk1TxxqxGxP9ETcQBoFy2H8zTOrzT6
         RPLQ==
X-Gm-Message-State: AOAM533tIBn7ZtwqsGfhV+eojScwsVaXZtQyZW4bqqBxwwLRQr+w4I/c
        hHvb2RRov48iR76g1DYkbxlcOSpTKHem5w==
X-Google-Smtp-Source: ABdhPJzO14ZjYA0vED2QMGOyK1a23RWwDT+5f7O6KNjMxiA7uf+lz5xMWhZPLF1iGDitoz9bHF5yIQ==
X-Received: by 2002:a05:6000:144b:: with SMTP id v11mr34924929wrx.421.1624993415373;
        Tue, 29 Jun 2021 12:03:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9sm17641188wmb.35.2021.06.29.12.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 12:03:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/3] Makefile: misc trivial fixes
Date:   Tue, 29 Jun 2021 21:03:30 +0200
Message-Id: <cover-0.3-0000000000-20210629T190137Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.615.g90fb4d7369
In-Reply-To: <cover-0.3-0000000000-20210617T095827Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210617T095827Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A base topic for some larger changes. See the v1 CL for a summary:
http://lore.kernel.org/git/cover-0.3-0000000000-20210617T095827Z-avarab@gmail.com

The only changes since v1 are to commit message issues pointed out by
Felipe and a trivial whitespace change. I also updated the commit
message of 2/3 as he suggested to point out why the change is being
made.

Ævar Arnfjörð Bjarmason (3):
  Makefile: mark "check" target as .PHONY
  Makefile: stop hardcoding {command,config}-list.h
  Makefile: remove an out-of-date comment

 Makefile              | 14 +++++---------
 compat/vcbuild/README |  2 +-
 config.mak.uname      |  6 +++---
 3 files changed, 9 insertions(+), 13 deletions(-)

Range-diff against v1:
-:  ---------- > 1:  27c94247f8 Makefile: mark "check" target as .PHONY
1:  6e164edb0b ! 2:  983d072d52 Makefile: stop hardcoding {command,config}-list.h
    @@ Commit message
         added in 029bac01a8 (Makefile: add {program,xdiff,test,git,fuzz}-objs
         & objects targets, 2021-02-23).
     
    +    A follow-up commit (not part of this series) will add a new generated
    +    hook-list.h. By doing this refactoring we'll only need to add the new
    +    file to the GENERATED_H variable, not EXCEPT_HDRS, the vcbuild/README
    +    etc.
    +
         I have not tested the Windows-specific change in config.mak.uname
         being made here, but we use other variables from the Makefile in the
         same block, and the GENERATED_H is fully defined before we include
         config.mak.uname.
     
         Hardcoding command-list.h there seems to have been a case of
    -    copy/paste programming in dce7d29551 (msvc: support building Git using
    -    MS Visual C++, 2019-06-25). The config-list.h was added later in
    -    709df95b78 (help: move list_config_help to builtin/help, 2020-04-16).
    +    copy/paste programming in 976aaedca0 (msvc: add a Makefile target to
    +    pre-generate the Visual Studio solution, 2019-07-29). The
    +    config-list.h was added later in 709df95b78 (help: move
    +    list_config_help to builtin/help, 2020-04-16).
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
2:  ddae86802e ! 3:  44a4781218 Makefile: remove an out-of-date comment
    @@ Commit message
         The rest of it was also somewhere between inaccurate and outdated,
         since as of b8ba629264 (Makefile: fold MISC_H into LIB_H, 2012-06-20)
         it's not followed by a list of header files, that got moved earlier in
    -    the file into LIB_H in b8ba629264 (Makefile: fold MISC_H into LIB_H,
    -    2012-06-20).
    +    the file into LIB_H in 60d24dd255 (Makefile: fold XDIFF_H and VCSSVN_H
    +    into LIB_H, 2012-07-06).
     
         Let's just remove it entirely, to the extent that we have anything
         useful to say here the comment on the
    @@ Makefile: ifneq ($(dep_files_present),)
     -# Dependencies on automatically generated headers such as command-list.h
     -# should _not_ be included here, since they are necessary even when
     -# building an object for the first time.
    - 
    +-
      $(OBJECTS): $(LIB_H) $(GENERATED_H)
      endif
    + 
-- 
2.32.0.615.g90fb4d7369

