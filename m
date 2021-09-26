Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F106C433F5
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 19:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59A6760EE4
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 19:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhIZTFL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Sep 2021 15:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhIZTFK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Sep 2021 15:05:10 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E60C061570
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 12:03:33 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id w29so45305381wra.8
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 12:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3J5wSD5E5n2Y2S/fpbxs45e4PhZE3LaqvOY4BJkGPXA=;
        b=SeEGPOB5LIh62yJpSGCZcDs6nR0y017AAgpysqBNQz4x640L3Rjcq2wsGrdmluz5+V
         i7HthBT/uKeMaMljIhAMJ+dNPxRqF8yM7SKdXrWeeUUkxNSQQuZkRtV5wh6tljl5FkVU
         J0UIgwVIJP740Wr2Cx/ziAQKwW8uHbKB/Wf/sEy2gzbwU4Q/WLXEs8dep1RZqaY+kkKS
         Ip0q+e345kQKGf9xJGhgo6vKHwl+jY69NyLVLwVarh7zenvKwDk/7zrgic1vjjQ+/LAc
         A2KW8XFk/N5t6RNEwqrs3Kj1hr2Geje/B8opjiFX7jnwUynlye0+Wh1EBCZb3w12yI7J
         hOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3J5wSD5E5n2Y2S/fpbxs45e4PhZE3LaqvOY4BJkGPXA=;
        b=ScDYY2gOLw6A9RDLy9kxTz4CTBsJxGwCKK0LREtH9Kt9BnwAjf+HsS6vgGs1vtCiOV
         iTCAxsrnAB+ewXkoIcYp1NcHVwoo4mx1CA8q9Nsyp/P8m5EJgKvibScn/R/yWlCCPBln
         Ypz/DR3xkgvP2AUu2sO85XpfTIirmNCbRVNB4GXENMNbZp7QaJOMgwkUJG22MVB3CoJd
         B4aXoQZYFG42dWLfqEkMmsQRnH8b12MK+bqigl2WCA27JrkXXIRqklOp1WsK0TwTQIhZ
         yEFnJ7T0uPs6V0F+36BHOKGcAXzzayYghHO+bj4QOppmfkUf/AQVe0KoHlgGu3PAFAP/
         qN7g==
X-Gm-Message-State: AOAM53042CUtX+j7wWr35sbq/B8B1AG2gtha03m2foSN2H0WP0yoGg42
        OXQIusyP7PCZQjzeGZ0ICzFB+ewcveLVoQ==
X-Google-Smtp-Source: ABdhPJxUjzuRyOtUPZaje5qjyLVfqEu3W3CUvwtGTA/tlKr3lsfP/+g+lC5iTrTo2liIIdnMI0fNgg==
X-Received: by 2002:a5d:47ad:: with SMTP id 13mr23856390wrb.77.1632683011937;
        Sun, 26 Sep 2021 12:03:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v20sm14691523wra.73.2021.09.26.12.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 12:03:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/8] Makefile: generate a hook-list.h, prep for config-based-hooks
Date:   Sun, 26 Sep 2021 21:03:21 +0200
Message-Id: <cover-v2-0.8-00000000000-20210926T185800Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1291.g8857a6a91ac
In-Reply-To: <cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is an incremental restart of the now-ejected
es/config-based-hooks and ab/config-based-hooks-base topics. See [1]
for a summary of the plan and progression.

In v2 the "sed" invocation that generates the new hook-list.h has been
changed to be portable under POSIX. See the thread starting at
https://lore.kernel.org/git/92471ff9-7573-c3e4-e9fd-63a5cbf5738f@gmail.com/;

The portability issue is AFAICT theoretical in that any "sed" command
I've tried accepts the old version (I tried the large list of OS's
listed in [2]), but better safe than sorry.

Other changes:

 * I noticed that the run-command.h inclusion in transport.c become
   redundant, I removed that and validated the other ones that have
   the new hook.h, they all still need run-command.h.

 * A whitespace change in v1 in a change to the Makefile makes the
   diff for 8/8 easier to read.

1. http://lore.kernel.org/git/cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com
2. https://lore.kernel.org/git/87fstt3gzd.fsf@evledraar.gmail.com/

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
 Makefile                            | 28 ++++++++++--------
 builtin/am.c                        |  1 +
 builtin/bugreport.c                 | 46 ++++++-----------------------
 builtin/commit.c                    |  3 +-
 builtin/merge.c                     |  3 +-
 builtin/receive-pack.c              |  3 +-
 builtin/worktree.c                  |  1 +
 compat/vcbuild/README               |  2 +-
 config.mak.uname                    |  6 ++--
 contrib/buildsystems/CMakeLists.txt |  7 +++++
 generate-hooklist.sh                | 20 +++++++++++++
 hook.c                              | 42 ++++++++++++++++++++++++++
 hook.h                              | 16 ++++++++++
 refs.c                              |  1 +
 run-command.c                       | 35 +---------------------
 run-command.h                       |  7 -----
 sequencer.c                         |  3 +-
 transport.c                         |  2 +-
 19 files changed, 127 insertions(+), 100 deletions(-)
 create mode 100755 generate-hooklist.sh
 create mode 100644 hook.c
 create mode 100644 hook.h

Range-diff against v1:
1:  91d0cd09c8e = 1:  095ef66c29e Makefile: mark "check" target as .PHONY
2:  804795771c6 = 2:  520e4baede6 Makefile: stop hardcoding {command,config}-list.h
3:  010701fd784 = 3:  312b353c651 Makefile: don't perform "mv $@+ $@" dance for $(GENERATED_H)
4:  b3cce74d259 = 4:  aea4868f988 Makefile: remove an out-of-date comment
5:  7dd874d50ec ! 5:  64f3af94161 hook.[ch]: move find_hook() from run-command.c to hook.c
    @@ sequencer.c
     
      ## transport.c ##
     @@
    + #include "cache.h"
      #include "config.h"
      #include "transport.h"
    - #include "run-command.h"
    +-#include "run-command.h"
     +#include "hook.h"
      #include "pkt-line.h"
      #include "fetch-pack.h"
6:  db8893afee6 = 6:  4eabe7ca39f hook.c: add a hook_exists() wrapper and use it in bugreport.c
7:  b61130dee5b = 7:  6237a1a5549 hook.c users: use "hook_exists()" instead of "find_hook()"
8:  80aae4d5c13 ! 8:  7420267ce09 hook-list.h: add a generated list of hooks, like config-list.h
    @@ Makefile: XDIFF_LIB = xdiff/lib.a
      generated-hdrs: $(GENERATED_H)
      
     @@ Makefile: git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
    + 		$(filter %.o,$^) $(LIBS)
      
      help.sp help.s help.o: command-list.h
    ++hook.sp hook.s hook.o: hook-list.h
      
     -builtin/help.sp builtin/help.s builtin/help.o: config-list.h GIT-PREFIX
    -+hook.sp hook.s hook.o: hook-list.h
    -+
     +builtin/help.sp builtin/help.s builtin/help.o: config-list.h hook-list.h GIT-PREFIX
      builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
      	'-DGIT_HTML_PATH="$(htmldir_relative_SQ)"' \
    @@ generate-hooklist.sh (new)
     +static const char *hook_name_list[] = {
     +EOF
     +
    -+sed -n -e '/^~~~~*$/ {x; s/^.*$/	"&",/; p;}; x' \
    ++sed -n \
    ++	-e '/^~~~~*$/ {x; s/^.*$/	"&",/; p;}' \
    ++	-e 'x' \
     +	<Documentation/githooks.txt |
     +	LC_ALL=C sort
     +
-- 
2.33.0.1291.g8857a6a91ac

