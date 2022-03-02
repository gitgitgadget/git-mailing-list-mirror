Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8FDC4332F
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 12:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241942AbiCBMu0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 07:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241920AbiCBMuY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 07:50:24 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B298E194
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 04:49:39 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id t11so2621009wrm.5
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 04:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+wbZyyNxl0KdX+Zz9m+4Wgier+msJx7gHn74zBIJOe4=;
        b=EDeIRKQsx2ErLye8U7eQQJlsb9rCx6UXB7eKP6/xncMKEL5Z0q81TQYEXSj7QMlBP5
         meCBqfvrYzsT+WCoyT6kWbz6foE5hS0rVvXOBML0ecJX4kslBikRQFvur+hvo4e3+SK4
         IayHd/njZaGVOqYuF2LjaobJl9Hq2Qv6PKHCs20kgbeeLka1HGoLmiL537dj2TyVrZtT
         MY4dDQeSYyoi4/RGDbCyJr5xQ6Lsq5Zc/1TKcJrZoXEecfKCz4Kw1+Uwbg9B90IDSpGi
         YdEFKFI19iP0W6iw8A7QL8c1+fBtlNV91V6DcVDsiVtgW4RU15aDY3YwaYXOaYqAZAjL
         S/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+wbZyyNxl0KdX+Zz9m+4Wgier+msJx7gHn74zBIJOe4=;
        b=UfJOAqnDAIy2PK4bPnldfi/M49bNUz05PqbVBewrbVRRB2If6BMoUp8E8n8LsAFPu2
         MCAhyUu5YFgPyzTxnUyagpWqoNNXP5GQS71I79PWGGNJGs1+Si7g6EWq9dA7tS1fj0Rp
         NSUTDzyWFnG5Y/IY6Qu6ZRD6MfJrQna/dq/b+W0cDkUMICVZLsQmd0tAjLG8q066+5KE
         EmGH73SG9TWCJEj38E+MGkFHjt0lvrXUA++SWtjD5qDVW700kPwtV+G+fHhqDQvE0X8J
         GwsYH/q6kGmLqFhuG1hlvaLdbjt8tCsrb/Qs35Yg3vRyU0EDXv6eNlALvA1rhc5uT78O
         Yqyw==
X-Gm-Message-State: AOAM531MYoCOI8N2O3jYihAGizI+bjEmNHDecXQ/89FgdiK3TRSc3IUJ
        RNIfTRHSBCuETm9fsamhHPtUv7yUALH8fQ==
X-Google-Smtp-Source: ABdhPJzTrIju6V19heGb18iheGhPDXGQADeivI6Oq7PYlsyyDIsrmVvB9oDv/423oAL7gz2By9nSfA==
X-Received: by 2002:adf:eb87:0:b0:1ef:85f5:6ab4 with SMTP id t7-20020adfeb87000000b001ef85f56ab4mr16467390wrn.158.1646225377485;
        Wed, 02 Mar 2022 04:49:37 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p30-20020a1c545e000000b003811f9102c0sm8210107wmi.32.2022.03.02.04.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 04:49:36 -0800 (PST)
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
Subject: [PATCH v4 0/9] Makefile: optimize noop runs, add shared.mak
Date:   Wed,  2 Mar 2022 13:49:08 +0100
Message-Id: <cover-v4-0.9-00000000000-20220302T124320Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1228.g56895c6ee86
In-Reply-To: <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com>
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

This v4 re-roll (for v3, see
https://lore.kernel.org/git/cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com/):

 * The "all" boilerplate goes first now, before "include"
 * Elaborated on DELETE_ON_ERROR ina commit message.
 * No longer change a ":=" to "=" while moving code.
 * Rephrased other commit messages (one of which referred to a
   function from another future series)
 * Typo fix in commit message.

Ævar Arnfjörð Bjarmason (9):
  scalar Makefile: use "The default target of..." pattern
  Makefiles: add "shared.mak", move ".DELETE_ON_ERROR" to it
  Makefile: disable GNU make built-in wildcard rules
  Makefile: define $(LIB_H) in terms of $(FIND_SOURCE_FILES)
  Makefile: move ".SUFFIXES" rule to shared.mak
  Makefile: move $(comma), $(empty) and $(space) to shared.mak
  Makefile: add "$(QUIET)" boilerplate to shared.mak
  Makefile: use $(wspfx) for $(QUIET...) in shared.mak
  Makefiles: add and use wildcard "mkdir -p" template

 Documentation/Makefile    |  63 ++------------------
 Makefile                  | 118 ++++++++++++--------------------------
 config.mak.uname          |   1 -
 contrib/scalar/Makefile   |  20 ++-----
 contrib/scalar/t/Makefile |   3 +
 shared.mak                | 109 +++++++++++++++++++++++++++++++++++
 t/Makefile                |   3 +
 t/interop/Makefile        |   3 +
 t/perf/Makefile           |   3 +
 templates/Makefile        |   8 +--
 10 files changed, 171 insertions(+), 160 deletions(-)
 create mode 100644 shared.mak

Range-diff against v3:
 1:  2404c4d8b96 <  -:  ----------- scalar Makefile: set the default target after the includes
 -:  ----------- >  1:  26c6bb897cf scalar Makefile: use "The default target of..." pattern
 2:  96a490bec54 !  2:  74692458b70 Makefiles: add "shared.mak", move ".DELETE_ON_ERROR" to it
    @@ Commit message
         .DELETE_ON_ERROR, 2021-05-21) for the addition and use of the
         ".DELETE_ON_ERROR" flag.
     
    -    This does have the potential downside that if e.g. templates/Makefile
    -    would like to include this "shared.mak" in the future the semantics of
    -    such a Makefile will change, but as noted in the above commits (and
    -    GNU make's own documentation) any such change would be for the better,
    -    so it's safe to do this.
    +    I.e. this changes the behavior of existing rules in the altered
    +    Makefiles (except "Makefile" & "Documentation/Makefile"). I'm
    +    confident that this is safe having read the relevant rules in those
    +    Makfiles, and as the GNU make manual notes that it isn't the default
    +    behavior is out of an abundance of backwards compatibility
    +    caution. From edition 0.75 of its manual, covering GNU make 4.3:
     
    -    This also doesn't introduce a bug by e.g. having this
    +        [Enabling '.DELETE_ON_ERROR' is] almost always what you want
    +        'make' to do, but it is not historical practice; so for
    +        compatibility, you must explicitly request it.
    +
    +    This doesn't introduce a bug by e.g. having this
         ".DELETE_ON_ERROR" flag only apply to this new shared.mak, Makefiles
         have no such scoping semantics.
     
    +    It does increase the danger that any Makefile without an explicit "The
    +    default target of this Makefile is..." snippet to define the default
    +    target as "all" could have its default rule changed if our new
    +    shared.mak ever defines a "real" rule. In subsequent commits we'll be
    +    careful not to do that, and such breakage would be obvious e.g. in the
    +    case of "make -C t".
    +
    +    We might want to make that less fragile still (e.g. by using
    +    ".DEFAULT_GOAL" as noted in the preceding commit), but for now let's
    +    simply include "shared.mak" without adding that boilerplate to all the
    +    Makefiles that don't have it already. Most of those are already
    +    exposed to that potential caveat e.g. due to including "config.mak*".
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Documentation/Makefile ##
    @@ Documentation/Makefile: doc-l10n install-l10n::
     
      ## Makefile ##
     @@
    -+# Import tree-wide shared Makefile behavior and libraries
    -+include shared.mak
    -+
      # The default target of this Makefile is...
      all::
      
    ++# Import tree-wide shared Makefile behavior and libraries
    ++include shared.mak
    ++
    + # Define V=1 to have a more verbose compile.
    + #
    + # Define SHELL_PATH to a POSIX shell if your /bin/sh is broken.
     @@ Makefile: shell_compatibility_test: please_set_SHELL_PATH_to_a_more_modern_shell
      strip: $(PROGRAMS) git$X
      	$(STRIP) $(STRIP_OPTS) $^
    @@ Makefile: shell_compatibility_test: please_set_SHELL_PATH_to_a_more_modern_shell
     
      ## contrib/scalar/Makefile ##
     @@
    + # The default target of this Makefile is...
    + all::
    + 
     +# Import tree-wide shared Makefile behavior and libraries
     +include ../../shared.mak
     +
    - QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
    - QUIET_SUBDIR1  =
    - 
    + include ../../config.mak.uname
    + -include ../../config.mak.autogen
    + -include ../../config.mak
     
      ## contrib/scalar/t/Makefile ##
     @@
 3:  9392e3c3e97 !  3:  0fbdeeffc7b Makefile: disable GNU make built-in wildcard rules
    @@ Commit message
         contents from RCS or SCCS. See [1] for an old mailing list discussion
         about how to disable these.
     
    -    The speed-up may wary. I've seen 1-10% depending on the speed of the
    +    The speed-up may vary. I've seen 1-10% depending on the speed of the
         local disk, caches, -jN etc. Running:
     
             strace -f -c -S calls make -j1 NO_TCLTK=Y
 4:  07cf9daa9d6 =  4:  ea6b835308a Makefile: define $(LIB_H) in terms of $(FIND_SOURCE_FILES)
 5:  16f2e3ff35b =  5:  c2339694cf7 Makefile: move ".SUFFIXES" rule to shared.mak
 6:  1b6ecb27f02 !  6:  741fdfd48e2 Makefile: move $(comma), $(empty) and $(space) to shared.mak
    @@ Metadata
      ## Commit message ##
         Makefile: move $(comma), $(empty) and $(space) to shared.mak
     
    -    Move these variables over to the shared.max, we'll make use of them in
    -    a subsequent commit. There was no reason for these to be "simply
    -    expanded variables", so let's use the normal lazy "=" assignment here.
    +    Move these variables over to the shared.mak, we'll make use of them in
    +    a subsequent commit.
    +
    +    Note that there's reason for these to be "simply expanded variables",
    +    i.e. to use ":=" assignments instead of lazily expanded "="
    +    assignments. We could use "=", but let's leave this as-is for now for
    +    ease of review.
     
         See 425ca6710b2 (Makefile: allow combining UBSan with other
         sanitizers, 2017-07-15) for the commit that introduced these.
    @@ shared.mak
     +
     +## comma, empty, space: handy variables as these tokens are either
     +## special or can be hard to spot among other Makefile syntax.
    -+comma = ,
    -+empty =
    -+space = $(empty) $(empty)
    ++comma := ,
    ++empty :=
    ++space := $(empty) $(empty)
 7:  471067deefc !  7:  a723cbce270 Makefile: add "$(QUIET)" boilerplate to shared.mak
    @@ config.mak.uname: vcxproj:
      
     
      ## contrib/scalar/Makefile ##
    -@@
    - # Import tree-wide shared Makefile behavior and libraries
    - include ../../shared.mak
    +@@ contrib/scalar/Makefile: include ../../config.mak.uname
    + -include ../../config.mak.autogen
    + -include ../../config.mak
      
     -QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
     -QUIET_SUBDIR1  =
    @@ contrib/scalar/Makefile
     -endif
     -endif
     -
    - include ../../config.mak.uname
    - -include ../../config.mak.autogen
    - -include ../../config.mak
    + TARGETS = scalar$(X) scalar.o
    + GITLIBS = ../../common-main.o ../../libgit.a ../../xdiff/lib.a
    + 
     
      ## shared.mak ##
     @@
    - comma = ,
    - empty =
    - space = $(empty) $(empty)
    + comma := ,
    + empty :=
    + space := $(empty) $(empty)
     +
     +### Quieting
     +## common
 8:  510306d2219 !  8:  3733b0c8df1 Makefile: use $(wspfx) for $(QUIET...) in shared.mak
    @@ Commit message
         Makefile: use $(wspfx) for $(QUIET...) in shared.mak
     
         Change the mostly move-only change in the preceding commit to use the
    -    $(wspfx) variable for defining the QUIET padding, to guarantee that
    -    it's consistent with the "TRACK_template" template.
    +    $(wspfx) variable for defining the QUIET padding. This refactoring
    +    will make it easier to emit that exact amount of padding in functions
    +    that we might add to shared.mak in the future.
     
    -        $ make CFLAGS=-I$RANDOM grep.o wspfx='$(space)->'
    -         -> GIT-CFLAGS PARAMETERS (changed)
    -         -> CC grep.o
    +    Such a function is not part of this patch series, but a
    +    "TRACK_template" that I'd like to add as a follow-up to it makes use
    +    of this. Let's make this change now while modifying these QUIET rules
    +    is fresh in our minds.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## shared.mak ##
    -@@ shared.mak: comma = ,
    - empty =
    - space = $(empty) $(empty)
    +@@ shared.mak: comma := ,
    + empty :=
    + space := $(empty) $(empty)
      
     +## wspfx: the whitespace prefix padding for $(QUIET...) and similarly
     +## aligned output.
 9:  85bb74aa32f =  9:  4cc4aeabb20 Makefiles: add and use wildcard "mkdir -p" template
-- 
2.35.1.1228.g56895c6ee86

