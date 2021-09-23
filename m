Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8D5C433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 10:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ABCA60F39
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 10:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240377AbhIWKco (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 06:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbhIWKcn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 06:32:43 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8F2C061574
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 03:31:12 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t8so15809749wrq.4
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 03:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D5FmZVL8uaiNmP2G8TQGewtxX3x0ng/2cSZCVKvqhTk=;
        b=RQNVKBTX8ACN9J/KB+E6B6wNGOOjkjHV02JZRVvQK6LN1RruAW27fIl11UR6p907EV
         h0JSTxrQVal/CxrLsnBzOZCRqolbYDQnzUpc1o7EK08Ur4dsDhRavbj2GDugO/+Vd/3G
         JciLB4fcBbDmSdozwDtm9DPFLoSvWC3htssVePlKZoHe7fy4ZMFBKDwIJcx3L9eN5L0f
         9bLxJpkuIV5m1BHqeIU1xCm67/sXq+lRLdLbiaaflpjReE26ewRnf2Fnj+zOzf7ZOx7R
         +b3epoOu808oupZEMFuLG9KEDYzWq3B7JgbegmGzALTM6D2cEQ1zuy9jqo39recppkFo
         oixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D5FmZVL8uaiNmP2G8TQGewtxX3x0ng/2cSZCVKvqhTk=;
        b=CQQk5aMIN0GvoieEK59/XinHXjMOuvdoztLUeH/x7YfuJ8RNTrvOX7p0YcC2hO23zu
         3XybCFUaLc7lgfZp3Xpj3I7tF7PcNV8A6FwNQMhAlHrDMP8PuWbvXTNfJwnWhALjjYQ6
         t+qvjXGhcyzDjY+L1xz4WNwYUVVuq04wIZW5Wu/p1F/voQwsZFU93UPjv+glTEVh379r
         IkmO+5SdwVjBuD3peP/hejnJi44AdRC7fLdC7ybfISJsPUDPdx0IBwb70tCAZLQq4gZO
         XQ1KHXkQy83O9iPonUtr4LzbCHttDbRZCqsOAN9opUQQ+3Ho8iCt/1QQqIk1XKItURMU
         mlbw==
X-Gm-Message-State: AOAM5303yfZYZunvvqn/njLfDN3+EguvMrgJqpCg8PwOJwoI2eZdk2c9
        7bfnM8VS6krcHWS/sTSu2hKaG8xateyOwA==
X-Google-Smtp-Source: ABdhPJykwvSpOjz7ZLrF335bQwey4vAhZFicos3riypfix2SDEtnFHLUxuk9My2162BieZQHSCWSTg==
X-Received: by 2002:a05:600c:4f4c:: with SMTP id m12mr14744957wmq.164.1632393070141;
        Thu, 23 Sep 2021 03:31:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b187sm9027312wmd.33.2021.09.23.03.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 03:31:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/8] Makefile: generate a hook-list.h, prep for config-based-hooks
Date:   Thu, 23 Sep 2021 12:29:55 +0200
Message-Id: <cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1229.g50d2591fb53
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is an incremental restart of the es/config-based-hooks and
ab/config-based-hooks-base topics, which should both be ejected in
favor of this.

Those topics have been lingering for a long time. The v5 of
ab/config-based-hooks-base[1] was re-rolled on September 2nd, and then
on September 9th I re-rolled a v4 of Emily's on-top topic[2] to solve
conflicts with the "base" one as other things in "seen" were colliding
with its v4 + Emily's older version.

But in the end the sum total of master..es/config-based-hooks is 43
commits and a rather daunting "44 files changed, 1870 insertions(+),
611 deletions(-)" diffstat. I think it's fair to say that anything
approaching a full picture of these patches only exists in our
respective wetwares, and wider reviewer attention is clearly needed.

That much larger topic also has a conflict Junio's been solving, and
by its presence has surely been holding up the progression of various
other submitted and unsubmitted topics.

So this is step #1 in an (at least) 5 step plan outlined in [3] (start
reading at "It seems due to") to get this greater series into git in a
more piecemeal fashion.

Here we're only setting up some build system changes needed for the
eventual master..ab/config-based-hooks-base topic, the range-diff is
against the relevant part of[1]. These changes are able to stand on
their own.

The only caveat to that is that we end up with a hook.[ch] with just
two functions, which is usually not the point at which we split out
new headers. As noted in the commit messages we expect those headers
to get much larger with the rest of ab/config-based-hooks-base.

I intentionally split this off from the much larger thread starting at
[4] and pruned the CC list. If anyone feels left out or is interested
a review of this is a most welcome way to be re-added :)

Changes since [1]:

 * Resolved a conflict with advice.[ch]-related changes
 * A new commit to skip the "mv $@+ $@" dance for
   $(GENERATED_H). These patches originally pre-dated our use of
   ".DELETE_ON_ERROR" in the Makefile.
 * There was a "while we're at it" change to a comment in
   run-command.h as it was being moved, now this is a purely move-only
   change. I'll either re-incorporate that minor change in re-rolls of
   ab/config-based-hooks-base, or just drop it.

1. https://lore.kernel.org/git/cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com/#t
2. https://lore.kernel.org/git/cover-v4-0.5-00000000000-20210909T122802Z-avarab@gmail.com/
3. https://lore.kernel.org/git/875yut8nns.fsf@evledraar.gmail.com/
4. https://lore.kernel.org/git/20210311021037.3001235-1-emilyshaffer@google.com/#t

Emily Shaffer (1):
  hook.c: add a hook_exists() wrapper and use it in bugreport.c

Ævar Arnfjörð Bjarmason (7):
  Makefile: mark "check" target as .PHONY
  Makefile: stop hardcoding {command,config}-list.h
  Makefile: don't perform "mv $@+ $@" dance for $(GENERATED_H)
  Makefile: remove an out-of-date comment
  hook.[ch]: move find_hook() from run-command.c to hook.c
  hook.c users: use "hook_exists()" instead of "find_hook()"
  hook-list.h: add a generated list of hooks, like config-list.h

 .gitignore                          |  1 +
 Makefile                            | 29 ++++++++++--------
 builtin/am.c                        |  1 +
 builtin/bugreport.c                 | 46 ++++++-----------------------
 builtin/commit.c                    |  3 +-
 builtin/merge.c                     |  3 +-
 builtin/receive-pack.c              |  3 +-
 builtin/worktree.c                  |  1 +
 compat/vcbuild/README               |  2 +-
 config.mak.uname                    |  6 ++--
 contrib/buildsystems/CMakeLists.txt |  7 +++++
 generate-hooklist.sh                | 18 +++++++++++
 hook.c                              | 42 ++++++++++++++++++++++++++
 hook.h                              | 16 ++++++++++
 refs.c                              |  1 +
 run-command.c                       | 35 +---------------------
 run-command.h                       |  7 -----
 sequencer.c                         |  3 +-
 transport.c                         |  1 +
 19 files changed, 126 insertions(+), 99 deletions(-)
 create mode 100755 generate-hooklist.sh
 create mode 100644 hook.c
 create mode 100644 hook.h

Range-diff:
1:  ac419613fdc = 1:  91d0cd09c8e Makefile: mark "check" target as .PHONY
2:  a161b7f0a5c = 2:  804795771c6 Makefile: stop hardcoding {command,config}-list.h
-:  ----------- > 3:  010701fd784 Makefile: don't perform "mv $@+ $@" dance for $(GENERATED_H)
3:  ffef1d3257e = 4:  b3cce74d259 Makefile: remove an out-of-date comment
4:  545e16c6f04 ! 5:  7dd874d50ec hook.[ch]: move find_hook() from run-command.c to hook.c
    @@ hook.c (new)
     +			err = errno;
     +#endif
     +
    -+		if (err == EACCES && advice_ignored_hook) {
    ++		if (err == EACCES && advice_enabled(ADVICE_IGNORED_HOOK)) {
     +			static struct string_list advise_given = STRING_LIST_INIT_DUP;
     +
     +			if (!string_list_lookup(&advise_given, name)) {
    @@ hook.h (new)
     +#ifndef HOOK_H
     +#define HOOK_H
     +
    -+/**
    ++/*
     + * Returns the path to the hook file, or NULL if the hook is missing
     + * or disabled. Note that this points to static storage that will be
    -+ * overwritten by further calls to find_hook().
    ++ * overwritten by further calls to find_hook and run_hook_*.
     + */
     +const char *find_hook(const char *name);
     +
    @@ refs.c
     
      ## run-command.c ##
     @@
    - #include "string-list.h"
      #include "quote.h"
      #include "config.h"
    + #include "packfile.h"
     +#include "hook.h"
      
      void child_process_init(struct child_process *child)
    @@ run-command.c: int async_with_fork(void)
     -			err = errno;
     -#endif
     -
    --		if (err == EACCES && advice_ignored_hook) {
    +-		if (err == EACCES && advice_enabled(ADVICE_IGNORED_HOOK)) {
     -			static struct string_list advise_given = STRING_LIST_INIT_DUP;
     -
     -			if (!string_list_lookup(&advise_given, name)) {
5:  a9bc4519e9a = 6:  db8893afee6 hook.c: add a hook_exists() wrapper and use it in bugreport.c
6:  e99ec2e6f8f = 7:  b61130dee5b hook.c users: use "hook_exists()" instead of "find_hook()"
7:  2ffb2332c8a ! 8:  80aae4d5c13 hook-list.h: add a generated list of hooks, like config-list.h
    @@ Makefile: git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
      	'-DGIT_MAN_PATH="$(mandir_relative_SQ)"' \
     @@ Makefile: command-list.h: $(wildcard Documentation/git*.txt)
      		$(patsubst %,--exclude-program %,$(EXCLUDED_PROGRAMS)) \
    - 		command-list.txt >$@+ && mv $@+ $@
    + 		command-list.txt >$@
      
     +hook-list.h: generate-hooklist.sh Documentation/githooks.txt
    -+	$(QUIET_GEN)$(SHELL_PATH) ./generate-hooklist.sh \
    -+		>$@+ && mv $@+ $@
    ++	$(QUIET_GEN)$(SHELL_PATH) ./generate-hooklist.sh >$@
     +
      SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
      	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
-- 
2.33.0.1229.g0a86d28df49

