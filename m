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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955E8C43462
	for <git@archiver.kernel.org>; Mon, 10 May 2021 11:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6335961139
	for <git@archiver.kernel.org>; Mon, 10 May 2021 11:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbhEJLMr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 07:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbhEJK6B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 06:58:01 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7158CC06125E
        for <git@vger.kernel.org>; Mon, 10 May 2021 03:50:29 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id l7so18176724edb.1
        for <git@vger.kernel.org>; Mon, 10 May 2021 03:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vzVXdAL5MWOrJNypdpzIf9F+6pi3OyVS4dmsVOIm1Jk=;
        b=fplEti1n3J9B8yPBZTCesvKrj9tm729Qbk8DsYn2xb7XWa4kMKjOMWhy7CjG5Or8sw
         Y6ndbEPaoeyV+bD/hDExbPadPB3ICmDmaYCjSlgl5xIyRg8GZSpHMVaU32qS9xrHQZw2
         F4bnxJtGkJNHirOEpvH4d5Yjy76dmv0kJ4C5INUi/4Ww6iLsnzLkHgxJIdpQJ4sLVbq1
         HKE7YiQRJ+DxTeytQqQLNZ8BhAFIV78Ief7UEUgA9AuBj1l0LzWwC9qkUp/gcjOtvhTi
         12CsCV+FjxltqYgFgJAuMBLuUPpNuw39TbwZjYtfud5bcQ8bPWSR1POyEVCwKHSfeyIJ
         NWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vzVXdAL5MWOrJNypdpzIf9F+6pi3OyVS4dmsVOIm1Jk=;
        b=ShbXsWehlGRV4mSdcqJNALLRbD4HJFoup+0VM/ocLKpFKdKVfBC3HNDh+SpsFj4N2a
         VXOlZtISaRACWBrzvmB7yUjZ7rwYCEeXsWce7OkuwW98D16XG93FTNbeF3EB5k0+TnI8
         bmezca1VyjS0KI5njyJe6Cimj9ZIxVFJfCjc++HIJwwDkVbvfH3rC/l9G4EJVURfFY6n
         oea/Q9Yac8zQxp5CRjix5b+11mloFtOfcdLBBMhmQOFQZ7SXEpz1pRjczrjsaWDgf3ze
         pq1FYM3j/G6CUrswW7uAE9ClHr+JJjW+Sy9r1fYB7N1rvESrnzLHkQyzJiL3/iHjy6X7
         z4GA==
X-Gm-Message-State: AOAM531w6M4Htir6VpSslgyvfWLh1VMqYAX4yzBNCn/vtyi8JKcO+rx0
        xPImeW833q40dJkjc3q/2GDk/TzzvcwRYg==
X-Google-Smtp-Source: ABdhPJxhGqTyUcR6dfFGUcdsQQrQ+No//K/vn2U5MselbBQB8Ay2lcuU34PrzEZTuyW95cLQZ3Xuhg==
X-Received: by 2002:aa7:dbc9:: with SMTP id v9mr28504746edt.183.1620643827880;
        Mon, 10 May 2021 03:50:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o13sm9050741ejx.86.2021.05.10.03.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 03:50:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/6] Makefile/perl: correctly re-generate build/* + speed up under NO_GETTEXT=Y
Date:   Mon, 10 May 2021 12:50:16 +0200
Message-Id: <cover-0.6-00000000000-20210510T104937Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.838.g924d365b763
In-Reply-To: <cover-0.4-00000000000-20210505T121857Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20210505T121857Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The summary, from v1:

    These patches are relatively trivial fixes for bugs noticed when I was
    working on recent send-email patches. We don't re-build perl/build/*
    assets when variables that affect them are changed, and needlessly use
    our non-mock gettext Perl i18n framework under NO_GETTEXT=Y if the
    system happens to have Locale::Messages installed.

Changes since v1:

The only change to the end-state is the trivial change-on-top of:

    -PERL_DEFINES :=
    +PERL_DEFINES =

I.e. the PERL_DEFINES is now also refactored away from a
simply-expanded variable. The re-arrangement and split-up of patches
in this v2 just makes for a more incremental way to get there, per the
discussion on v1.

Ævar Arnfjörð Bjarmason (6):
  Makefile: regenerate perl/build/* if GIT-PERL-DEFINES changes
  Makefile: don't re-define PERL_DEFINES
  Makefile: make PERL_DEFINES recursively expanded
  Makefile: split up the deceleration of PERL_DEFINES
  Makefile: regenerate *.pm on NO_PERL_CPAN_FALLBACKS change
  perl: use mock i18n functions under NO_GETTEXT=Y

 Makefile         | 13 +++++++++----
 perl/Git/I18N.pm | 10 ++++++++++
 2 files changed, 19 insertions(+), 4 deletions(-)

Range-diff against v1:
2:  49339028db4 = 1:  8b899364916 Makefile: regenerate perl/build/* if GIT-PERL-DEFINES changes
-:  ----------- > 2:  c15887bbc93 Makefile: don't re-define PERL_DEFINES
-:  ----------- > 3:  7919ae0e546 Makefile: make PERL_DEFINES recursively expanded
1:  ed2005a2fbf ! 4:  2cdefbe920c Makefile: don't re-define PERL_DEFINES
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    Makefile: don't re-define PERL_DEFINES
    +    Makefile: split up the deceleration of PERL_DEFINES
     
    -    Since 07d90eadb50 (Makefile: add Perl runtime prefix support,
    -    2018-04-10) we have been declaring PERL_DEFINES right after assigning
    -    to it, with the effect that the first PERL_DEFINES was ignored.
    +    Split the declaration of PERL_DEFINES across multiple line, making
    +    this easier to read.
     
    -    That bug didn't matter in practice since the first line had all the
    -    same variables as the second, so we'd correctly re-generate
    -    everything. It just made for confusing reading.
    -
    -    Let's remove that first assignment, and while we're at it split these
    -    across lines to make them more maintainable.
    +    In 07d90eadb50 (Makefile: add Perl runtime prefix support, 2018-04-10)
    +    when PERL_DEFINES was added only the RUNTIME_PREFIX was put on its own
    +    line the rest weren't formatted like that for consistency. Let's do
    +    that to make this consistent with most of the rest of this Makefile.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ Makefile: perl_localedir_SQ = $(localedir_SQ)
      
      ifndef NO_PERL
      PERL_HEADER_TEMPLATE = perl/header_templates/fixed_prefix.template.pl
    --PERL_DEFINES = $(PERL_PATH_SQ):$(PERLLIB_EXTRA_SQ):$(perllibdir_SQ)
    --
    --PERL_DEFINES := $(PERL_PATH_SQ) $(PERLLIB_EXTRA_SQ) $(perllibdir_SQ)
    -+PERL_DEFINES :=
    +-PERL_DEFINES = $(PERL_PATH_SQ) $(PERLLIB_EXTRA_SQ) $(perllibdir_SQ)
    ++PERL_DEFINES =
     +PERL_DEFINES += $(PERL_PATH_SQ)
     +PERL_DEFINES += $(PERLLIB_EXTRA_SQ)
     +PERL_DEFINES += $(perllibdir_SQ)
3:  06e25bc1db3 = 5:  1171b73256e Makefile: regenerate *.pm on NO_PERL_CPAN_FALLBACKS change
4:  97247cb72a5 = 6:  7a5e7cf39a5 perl: use mock i18n functions under NO_GETTEXT=Y
-- 
2.31.1.838.g924d365b763

