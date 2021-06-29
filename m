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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6B4C11F67
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 18:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 255C661DBA
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 18:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbhF2S4w (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 14:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbhF2S4v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 14:56:51 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2550DC061766
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 11:54:23 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id v20-20020a05600c2154b02901dcefb16af0so3146208wml.5
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 11:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fDZqGB6BfNWzU/GXOxaeSbtrvgSjQgt3ad9FwrVTq7Q=;
        b=fC+jsTmctUNfIcd69eDJMCdhGdk06CVnYV4hJUBkkyKPYyOcvNKp+rz/7QlOUPfRfF
         14o2v4z36eM4dtKYYKtjUTtc8bBfg8CDCMHKgFo5FFaXCj4GbBzLh9S/M9v1HIr2TNcC
         7gT+tVQUSioJqE+pADiGyfVfGdrjRr8foDuJ0krYFiaUULIXIbt+Llg+kG9+/E8T6eTK
         opYFjbH9El3VBLfGJqvrhIQEawTmIOBv9xlD2yIIuIJ7rA2pzBfUBBkolILcc2AKntpP
         wjcHrHbRbZ7sfxXO3ixWPCPIBY4pysnlf4I4tLQ2KOFKiyA0k54LyzPimJDblilVl4D0
         9b6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fDZqGB6BfNWzU/GXOxaeSbtrvgSjQgt3ad9FwrVTq7Q=;
        b=rpT+0KI1tOFdJ1wAvDg55EFSjQ1kD9/vw2Xmphv+TSk4TZNh4jRpXJxTc4JFXsZQC1
         VcNso3DrWHKcgGjvr1jlBeQbNnZSSBZAXQSM40naqVcwEfSboFh9CxUlVOp7knqAA42k
         CsHxMsWGX+Y2S/mBQJzo4zGiEeoRmRgYam30Z631cFYV0NMouHPWPNS0fbBafOAEQnL/
         e4u9kAA+r54n5zuM1uGpeddWvzEH38U6PDKZeeeMBrbdDxYwmplouJj5nwWHCFph8oeM
         FnWcJaJ7u6trPIukGcDAvloNiPukmmprxa+M/UaEm2EKUNZPvbOdEVmNh2pimnXTrRIp
         DMqg==
X-Gm-Message-State: AOAM532Qnw+02YoOdm+ZWQ8p5imisxwjwykl9ZInu9LNmv0Uw/ESSiww
        tJrimQjzJxwR4jP3AIXSqez1OWji4hydPw==
X-Google-Smtp-Source: ABdhPJziA+x6vxJbx7stYmAdy+wwLBlkVjfP367B8lOhRxrwYi3wCFbhrCktjYJICfsT8qqZXqzljQ==
X-Received: by 2002:a7b:c8c1:: with SMTP id f1mr9109369wml.135.1624992860481;
        Tue, 29 Jun 2021 11:54:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k13sm19025218wrp.73.2021.06.29.11.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 11:54:20 -0700 (PDT)
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
Subject: [PATCH v2 0/3] Add a generated list of hooks in hook-list.h
Date:   Tue, 29 Jun 2021 20:53:59 +0200
Message-Id: <cover-0.3-0000000000-20210629T183325Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.615.g90fb4d7369
In-Reply-To: <cover-0.3-0000000000-20210617T100239Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210617T100239Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A re-roll of this v1[1] to stop hardcoding the hook list, and instead generate it.

The v1 used a Perl script to generate the hook-list.h, it's now a
shellscsript that uses "sed" instead.

The sed script is an adaptation of René's in [2]. I fixed a regression
in it vis-a-vis the Perl version, we need to set LC_ALL so we don't
sort the list at build-time with the locale of the user performing the
build.

I also turned the two sed commands into one, with a trick that's
perhaps too clever, but which has worked in my cross-platform testing
so far.

1. http://lore.kernel.org/git/cover-0.3-0000000000-20210617T100239Z-avarab@gmail.com
2. https://lore.kernel.org/git/648321ed-bda9-d7fc-73e1-7ccf48addf9c@web.de/

Emily Shaffer (1):
  hook.c: add a hook_exists() wrapper and use it in bugreport.c

Ævar Arnfjörð Bjarmason (2):
  hook.[ch]: move find_hook() to this new library
  hook-list.h: add a generated list of hooks, like config-list.h

 .gitignore                          |  1 +
 Makefile                            | 11 +++++-
 builtin/am.c                        |  1 +
 builtin/bugreport.c                 | 46 +++++-----------------
 builtin/commit.c                    |  1 +
 builtin/merge.c                     |  1 +
 builtin/receive-pack.c              |  1 +
 builtin/worktree.c                  |  1 +
 contrib/buildsystems/CMakeLists.txt |  7 ++++
 generate-hooklist.sh                | 18 +++++++++
 hook.c                              | 61 +++++++++++++++++++++++++++++
 hook.h                              | 16 ++++++++
 refs.c                              |  1 +
 run-command.c                       | 35 +----------------
 run-command.h                       |  7 ----
 sequencer.c                         |  1 +
 transport.c                         |  1 +
 17 files changed, 131 insertions(+), 79 deletions(-)
 create mode 100755 generate-hooklist.sh
 create mode 100644 hook.c
 create mode 100644 hook.h

Range-diff against v1:
-:  ---------- > 1:  58c37e4f06 hook.[ch]: move find_hook() to this new library
-:  ---------- > 2:  0cf7e078ef hook.c: add a hook_exists() wrapper and use it in bugreport.c
1:  f343fc7ae6 ! 3:  ba7f01f4f6 hook-list.h: add a generated list of hooks, like config-list.h
    @@ Commit message
          - 976aaedca0 (msvc: add a Makefile target to pre-generate the Visual
            Studio solution, 2019-07-29)
     
    +    The LC_ALL=C is needed because at least in my locale the dash ("-") is
    +    ignored for the purposes of sorting, which results in a different
    +    order. I'm not aware of anything in git that has a hard dependency on
    +    the order, but e.g. the bugreport output would end up using whatever
    +    locale was in effect when git was compiled.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +    Signed-off-by: René Scharfe <l.s.r@web.de>
     
      ## .gitignore ##
     @@
    @@ Makefile: command-list.h: $(wildcard Documentation/git*.txt)
      		$(patsubst %,--exclude-program %,$(EXCLUDED_PROGRAMS)) \
      		command-list.txt >$@+ && mv $@+ $@
      
    -+hook-list.h: generate-hooklist.sh
    -+hook-list.h: Documentation/githooks.txt
    ++hook-list.h: generate-hooklist.sh Documentation/githooks.txt
     +	$(QUIET_GEN)$(SHELL_PATH) ./generate-hooklist.sh \
     +		>$@+ && mv $@+ $@
     +
    @@ contrib/buildsystems/CMakeLists.txt: if(NOT EXISTS ${CMAKE_BINARY_DIR}/config-li
      ## generate-hooklist.sh (new) ##
     @@
     +#!/bin/sh
    ++#
    ++# Usage: ./generate-hooklist.sh >hook-list.h
     +
    -+echo "/* Automatically generated by generate-hooklist.sh */"
    ++cat <<EOF
    ++/* Automatically generated by generate-hooklist.sh */
     +
    -+print_hook_list () {
    -+	cat <<EOF
     +static const char *hook_name_list[] = {
     +EOF
    -+	perl -ne '
    -+		chomp;
    -+		@l[$.] = $_;
    -+		push @h => $l[$. - 1] if /^~~~+$/s;
    -+		END {
    -+			print qq[\t"$_",\n] for sort @h;
    -+		}
    -+	' <Documentation/githooks.txt
    -+	cat <<EOF
    ++
    ++sed -n -e '/^~~~~*$/ {x; s/^.*$/	"&",/; p;}; x' \
    ++	<Documentation/githooks.txt |
    ++	LC_ALL=C sort
    ++
    ++cat <<EOF
     +	NULL,
     +};
     +EOF
    -+}
    -+
    -+echo
    -+print_hook_list
     
      ## hook.c ##
     @@
-- 
2.32.0.615.g90fb4d7369

