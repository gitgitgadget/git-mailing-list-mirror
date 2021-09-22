Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEA3C433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 23:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6EDA61153
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 23:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238409AbhIVXNb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 19:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238389AbhIVXN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 19:13:29 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F47C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 16:11:58 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v24so16260078eda.3
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 16:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=DehJNq/lsbeFRlrJyNwuWT0hsNKMT2a5nL05sBNZRnI=;
        b=YQLx3Amz9u+zR9mfsRtStq6Hiw0nXUcEPYt6sXlQ9eNvURf++JXfhbirPiOEK2FfJb
         1/6wILos0NL7CVrDGg0fpgzWXJqOMr+IkmMO5VGD0ANdGGhQRkGqmNY7CK6REm5MMyLd
         RHdJQIIuJ/gFE24UFkiWSowaoWXLzPTG7M4SlPdmakeixdOFRyrLA+kAn8h/yWjKnNIf
         GLf/1YMQhJa0RlqmUeSse677ytemL6zyvMk/u7GY1f3tYUjZZKsq3BK+FZyzB/y0O7ig
         qGWM3PSH51ff6iQadgT9is/ORABFeALk/0rsrHhF3g2xIDp92L12geDfKF1+c2BFd28o
         oC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=DehJNq/lsbeFRlrJyNwuWT0hsNKMT2a5nL05sBNZRnI=;
        b=gujuCmk18t1XXVWrN84tBflKirHbl6VWWwW0sHPrFI+dRe8Hs7SWp/glX1CoyICnOX
         SxWt5GITbbSfJyf5CjyheUg+EdEubaS/0wGVI00sUN/ZZyeTt6GTlyWKH0vVn+Ycei24
         cjJYnM0q1KTSJEh/FUU3dOMZXpOM9SjQsM2nfNUdCAJg04JvtxQFhBXBWSH4plXkbyoA
         tHX1Jv3k9ltPaLqeGetwYRkBsw5LlmM6Rur+i9drm5oOtjBEMp8dX/yRoHzO2QsjmiSP
         8hBi0R6ejToYRGtFBBqMXlaFs0KOpOy+bQq3ncW4UGsBqHMy9MXh5T8+zCMaxSl/yujP
         b8ZA==
X-Gm-Message-State: AOAM5325G3GhB+hBzeYiVF/zq/hLiikrXC4nE6vTM4tBsRkb8faH+S+2
        p9aQvUZr9fSUPRWJ81ZpTEE=
X-Google-Smtp-Source: ABdhPJzUS2dovXKtnnM4JLVK3phzyMcg7MGRJMwp+G9j1wUfbtOrS1/smd25J9jD8ctGAvOBZJX77Q==
X-Received: by 2002:a17:907:7844:: with SMTP id lb4mr1812966ejc.381.1632352317207;
        Wed, 22 Sep 2021 16:11:57 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id y3sm1311343eda.9.2021.09.22.16.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 16:11:56 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Makefile: make COMPUTE_HEADER_DEPENDENCIES=auto work
 with DEVOPTS=pedantic
Date:   Thu, 23 Sep 2021 00:40:04 +0200
References: <patch-1.1-6b2e9af5e67-20210922T103749Z-avarab@gmail.com>
 <xmqqmto48ufz.fsf@gitster.g> <YUtiNuUiBU4Xg4gw@coredump.intra.peff.net>
 <xmqqzgs479d5.fsf@gitster.g> <YUuPYDkxjDIvIfwI@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YUuPYDkxjDIvIfwI@coredump.intra.peff.net>
Message-ID: <8735pw6w8z.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 22 2021, Jeff King wrote:

> It's a shame we can't just try to do the _real_ compiles using the
> auto-dependency stuff, and then fall back if they fail. But I think
> there's a chicken-and-egg problem there with "make" doing real work, and
> figuring out the dependencies to do real work.

Isn't this just a chicken & egg problem because we've made it a chicken
& egg problem? I.e. this WIP hack seems to work for me to avoid it:

===============================================================================
diff --git a/Makefile b/Makefile
index 0fe0a9aaa19..68e1714a100 100644
--- a/Makefile
+++ b/Makefile
@@ -1953,6 +1953,7 @@ endif
 ifneq ($(findstring s,$(MAKEFLAGS)),s)
 ifndef V
 	QUIET_CC       = @echo '   ' CC $@;
+	QUIET_DEP      = @echo '   ' DEP $@;
 	QUIET_AR       = @echo '   ' AR $@;
 	QUIET_LINK     = @echo '   ' LINK $@;
 	QUIET_BUILT_IN = @echo '   ' BUILTIN $@;
@@ -2454,24 +2455,6 @@ endif
 .PHONY: objects
 objects: $(OBJECTS)
 
-dep_files := $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
-dep_dirs := $(addsuffix .depend,$(sort $(dir $(OBJECTS))))
-
-ifeq ($(COMPUTE_HEADER_DEPENDENCIES),yes)
-$(dep_dirs):
-	@mkdir -p $@
-
-missing_dep_dirs := $(filter-out $(wildcard $(dep_dirs)),$(dep_dirs))
-dep_file = $(dir $@).depend/$(notdir $@).d
-dep_args = -MF $(dep_file) -MQ $@ -MMD -MP
-endif
-
-ifneq ($(COMPUTE_HEADER_DEPENDENCIES),yes)
-dep_dirs =
-missing_dep_dirs =
-dep_args =
-endif
-
 compdb_dir = compile_commands
 
 ifeq ($(GENERATE_COMPILATION_DATABASE),yes)
@@ -2489,10 +2472,22 @@ endif
 ASM_SRC := $(wildcard $(OBJECTS:o=S))
 ASM_OBJ := $(ASM_SRC:S=o)
 C_OBJ := $(filter-out $(ASM_OBJ),$(OBJECTS))
+C_DEP_OBJ := $(OBJECTS:o=dep)
 
 .SUFFIXES:
 
-$(C_OBJ): %.o: %.c GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
+ifeq ($(COMPUTE_HEADER_DEPENDENCIES),yes)
+$(C_DEP_OBJ): $(GENERATED_H)
+$(C_DEP_OBJ): %.dep : %.c command-list.h
+	$(QUIET_DEP)$(CC) -MF $*.dep -MQ $*.o -MM $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
+
+ALL.dep: $(C_DEP_OBJ)
+	$(QUIET_DEP)cat $(C_DEP_OBJ) >$@
+
+include ALL.dep
+endif
+
+$(C_OBJ): %.o: %.c %.dep GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
 	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(compdb_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
 $(ASM_OBJ): %.o: %.S GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
 	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(compdb_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
===============================================================================

This is just stealing a pattern we already use for
Documentation/doc.dep.

I.e. here every *.c file depends on a corresponding *.dep file, we
generate the *.dep files and *.c files seperately, instead of making the
*.dep a "while we're at it" as we make the *.o.

It's on obvious WIP, e.g. there's no ASM_DEP_OBJ yet, and e.g. a
"grep.dep" itself should in turn depend on say "strbuf.h", since if we
touch strbuf.h we should re-generate the grep.dep file before we make
the "grep.o" from the "grep.c".

It also means that if you have a clean tree and make "grep.o" we'll
generate all the *.dep files and the ALL.dep first, although skipping
that could be done with some clever use of $(MAKECMDGOALS) if anyone
cared.

It also makes "git clean -dxf; make -j8 all" take ~17s on my box instead
of ~13s.

I wonder if it's worth doing anyway, the cost of doing incremental
compiles isn't much affected.

I think the cases where the current schema bites us are rather obscure
though, but maybe I haven't thought of some obvious ones.

I.e. if we don't have the dep file we'll make it for the first time when
making the grep.o file, then include those generated dependencies.

If one of those dependencies changes we'll update the dependencies by
virtue of re-making the grep.o. I *think* the only edge cases are if
you've created a grep.o with COMPUTE_HEADER_DEPENDENCIES=yes, then
recompiled and it's gained a new dependency while using
COMPUTE_HEADER_DEPENDENCIES=no, and finally you try to recompile with
COMPUTE_HEADER_DEPENDENCIES=yes and it does nothing, because you're
referencing a stale ".depends" directory.

But that could be solved by just making the grep.o depend on its own
dependency file, which we don't do now, but could easily do.

So maybe I've talked myself out of there being an inherent dependency
graph violation with the current schema, i.e. the current one seems like
an easily solved bug.

One good thing the above approach still gives you is that you can use
GCC or Clang to make the dependency graph, but then use another compiler
to compile, i.e. we could have a $(GCC_LIKE) in addition to $(CC), so if
I'm compiling with xlc or suncc I can still use the present GCC just to
create the dependency graph.
