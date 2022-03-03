Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F9EC433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 16:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbiCCQFe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 11:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbiCCQFa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 11:05:30 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4123B197B43
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 08:04:41 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id j17so8632788wrc.0
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 08:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R+K8q8YwlbJN5TzwY+jnj/1or/upVz9Qm8iLwSbJsqw=;
        b=gwGmuGJjRHFltTywAyFXkl765qJFdwwfAUnEiBYnkyfYV0egbZ02J7u/SKTXMFsznf
         fSIQcJ8Noq7fCeMP2oUFfGsL87AuhPvjErqybLlG7S2wwgRjUwdquBUujsjwjyNAunZv
         VHn9zOQF7nNux73ONe8otYfOjU0js9/EmpzIUaDIPjjkatHfJuD2xsUPoEqqJnt8oAqS
         J7L6N4sXcm/fssdEjin+zZHNsJp0IaBWFH5puF3VmcP4ouWQibm4fArQVRXeiqqaqg/I
         sj7NZ5T7mk+iKUOtKbq/65uoWe1t1/OJ8zR1A/84jUGWZK1aIOI4hNl941hT1kdiRsRH
         edUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R+K8q8YwlbJN5TzwY+jnj/1or/upVz9Qm8iLwSbJsqw=;
        b=a1IsP3cRG+4fgHGaRwodDKhw8yRlgA2rVQm49yxKwLYO+2xFgIh+3V+nb+mICo0Q3A
         DzpKBODY3BNhvotOcXk8AKj/Vufm+7ELKEONSYFclyYoD2OcarukY7PXLOB8mmFp7Ml5
         HB6b3DALxtWTt1EJFTe9I8iUfbNvhRaPiiyvnOq6aCXcNFXOTWnoPmOvBbI2Mp4vkVtj
         LmL/vyL+NHA36692nFzBQlUcr+E2eeH6oVfGUK1zSmoCl5tXOWKL6W9tuW2e3z91V2wq
         8O6L2QJ3Cutie091nrBemaB1LHmOuQNnWUJRZX84fJVA/8/ImHzVAmGuM+HWbetTtmd7
         4nhQ==
X-Gm-Message-State: AOAM530bfus/Wzx5lDkiG/Jf2SMQWMXriCuLZrtrwzmSIZwXUlFsUtho
        XFtsLZWCtUqN5iFKkkvHZbD8W9+uIr9TZQ==
X-Google-Smtp-Source: ABdhPJyi+29RsifZEQSO2JuuNTVhNekY3yyAuhvrZ7GR4KQ8ZCf6HlmcP8ldvMj9N0kUO16TIUH1fw==
X-Received: by 2002:a5d:64ed:0:b0:1f0:6672:f10c with SMTP id g13-20020a5d64ed000000b001f06672f10cmr279151wri.679.1646323479308;
        Thu, 03 Mar 2022 08:04:39 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m13-20020a05600c4f4d00b00386744cb31bsm4040667wmq.35.2022.03.03.08.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 08:04:38 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 0/8] Makefile: optimize noop runs, add shared.mak
Date:   Thu,  3 Mar 2022 17:04:11 +0100
Message-Id: <cover-v5-0.8-00000000000-20220303T160155Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1230.ga6e6579e98c
In-Reply-To: <cover-v4-0.9-00000000000-20220302T124320Z-avarab@gmail.com>
References: <cover-v4-0.9-00000000000-20220302T124320Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As the v1 notes (among other things):
https://lore.kernel.org/git/cover-0.8-00000000000-20211217T012902Z-avarab@gmail.com/

    This speeds up noop runs of "make" by a lot. After a "make" running a
    "make -j1" with this is ~1.5 faster than on "master"[2], and around 3x
    as fast with "make -j1 NO_TCLTK=Y" (the TCL part takes a lot of time,
    but that's another matter).

This v5 re-roll (for v3, see:
https://lore.kernel.org/git/cover-v4-0.9-00000000000-20220302T124320Z-avarab@gmail.com/):

 * Drops the "wspfx" patch.
 * Rephrases the 1/8 commit message, dropping the mention of .DEFAULT_GOAL etc.

I think this should be ready to advance now per Junio's comment on v4
(https://lore.kernel.org/git/xmqqpmn4jdhy.fsf@gitster.g/):

    Other than a few things I noticed and commented on, 1-7 and 9
    looked all sensible.

Ævar Arnfjörð Bjarmason (8):
  scalar Makefile: use "The default target of..." pattern
  Makefiles: add "shared.mak", move ".DELETE_ON_ERROR" to it
  Makefile: disable GNU make built-in wildcard rules
  Makefile: define $(LIB_H) in terms of $(FIND_SOURCE_FILES)
  Makefile: move ".SUFFIXES" rule to shared.mak
  Makefile: move $(comma), $(empty) and $(space) to shared.mak
  Makefile: add "$(QUIET)" boilerplate to shared.mak
  Makefiles: add and use wildcard "mkdir -p" template

 Documentation/Makefile    |  63 ++------------------
 Makefile                  | 118 ++++++++++++--------------------------
 config.mak.uname          |   1 -
 contrib/scalar/Makefile   |  20 ++-----
 contrib/scalar/t/Makefile |   3 +
 shared.mak                | 103 +++++++++++++++++++++++++++++++++
 t/Makefile                |   3 +
 t/interop/Makefile        |   3 +
 t/perf/Makefile           |   3 +
 templates/Makefile        |   8 +--
 10 files changed, 165 insertions(+), 160 deletions(-)
 create mode 100644 shared.mak

Range-diff against v4:
 1:  26c6bb897cf !  1:  7547bf3e481 scalar Makefile: use "The default target of..." pattern
    @@ Metadata
      ## Commit message ##
         scalar Makefile: use "The default target of..." pattern
     
    -    Make have the "contrib/scalar/Makefile" be stylistically consistent
    -    with the top-level "Makefile" in first declaring "all" to be the
    -    default rule, follwed by including other Makefile snippets.
    +    Make the "contrib/scalar/Makefile" be stylistically consistent with
    +    the top-level "Makefile" in first declaring "all" to be the default
    +    rule, followed by including other Makefile snippets.
     
         This adjusts code added in 0a43fb22026 (scalar: create a rudimentary
    -    executable, 2021-12-03), it's a style-only change, in a subsequent
    -    commit the "QUIET" boilerplate at the beginning of this file will be
    -    retrieved via an include, and having an "all:" between the two set of
    -    "include"'s after that change would look odd.
    -
    -    As noted in [1] using ".DEFAULT_GOAL = all" is another way to do this
    -    in more modern GNU make versions, which we already have a hard
    -    dependency on, but let's leave any such change for a future
    -    improvement and go with using our established pattern consistently for
    -    now.
    -
    -    1. https://lore.kernel.org/git/220226.861qzq7d2r.gmgdl@evledraar.gmail.com/
    +    executable, 2021-12-03), it further ensures that when we add another
    +    "include" file in a subsequent commit that the included file won't be
    +    the one to define our default target.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
 2:  74692458b70 =  2:  91795eccc32 Makefiles: add "shared.mak", move ".DELETE_ON_ERROR" to it
 3:  0fbdeeffc7b =  3:  9f42f40b518 Makefile: disable GNU make built-in wildcard rules
 4:  ea6b835308a =  4:  034779ff7fb Makefile: define $(LIB_H) in terms of $(FIND_SOURCE_FILES)
 5:  c2339694cf7 =  5:  18e0a6985f1 Makefile: move ".SUFFIXES" rule to shared.mak
 6:  741fdfd48e2 =  6:  422dee02ae9 Makefile: move $(comma), $(empty) and $(space) to shared.mak
 7:  a723cbce270 =  7:  21bf1e6e01c Makefile: add "$(QUIET)" boilerplate to shared.mak
 8:  3733b0c8df1 <  -:  ----------- Makefile: use $(wspfx) for $(QUIET...) in shared.mak
 9:  4cc4aeabb20 !  8:  e6a93cae81d Makefiles: add and use wildcard "mkdir -p" template
    @@ Makefile: test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_
      ## shared.mak ##
     @@ shared.mak: ifndef V
      	QUIET          = @
    - 	QUIET_GEN      = @echo $(wspfx_SQ) GEN $@;
    + 	QUIET_GEN      = @echo '   ' GEN $@;
      
     +	QUIET_MKDIR_P_PARENT  = @echo $(wspfx_SQ) MKDIR -p $(@D);
     +
      ## Used in "Makefile"
    - 	QUIET_CC       = @echo $(wspfx_SQ) CC $@;
    - 	QUIET_AR       = @echo $(wspfx_SQ) AR $@;
    + 	QUIET_CC       = @echo '   ' CC $@;
    + 	QUIET_AR       = @echo '   ' AR $@;
     @@ shared.mak: ifndef V
      	export V
      endif
-- 
2.35.1.1230.ga6e6579e98c

