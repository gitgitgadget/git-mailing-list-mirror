Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4602EC433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 14:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31F5C603E8
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 14:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbhINOoo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 10:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbhINOns (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 10:43:48 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB9DC06124A
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 07:39:20 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso2311138wmb.2
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 07:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=A6Xh/Yi4qVOtMT91B3vencuWQjCKOIzIU3gsZOoyzC8=;
        b=DAgw25bOpKXWBlydYuhHtowXksBhwouG8PfJlVsM28BoB14U2FuU19rF2fnNNWj/4t
         iSMZCZNe5oZyoGVktkdy/0lUnchjsF73dIdstl65/6w2CkrsOTzweoJREE7G1Q8d1L0H
         9Tggy4/nm4EZSwsMli7ygKM23f2e0CjRui87J9hqTVw+kQnvdZ1sx1uZW3nz+NyUOu/8
         2XXzMP2zyGoH2jFp8NesBHgcm2RB9E+Z69Li1XS9/jHGMb98KcEsTkR7Ivtk61GUC1Bw
         7mrKcXiHQ16T+3mlsvXR65tLKdsdRvekSL/w2SiCBW2b9KWp9K3cC72enI9SurEfYfTA
         Z1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=A6Xh/Yi4qVOtMT91B3vencuWQjCKOIzIU3gsZOoyzC8=;
        b=NDCz/o2exVJR66VSTEg6VOvAsCMTP0S48JLcNxqjEnkFReKxi6NWpKYFKG9St2u24e
         QM09wFoQy7PLEYCYb1tUb9epYrZz5bIh6IsGDfi85O/sHE3lQF2nrUGwSg7usXXBXOru
         VmF/PI5enuF+7L3TSHk3YWq8Kb7Z/9CrthfC/PZdzYxha4V0O0NPKslwmitxDEEpYejn
         DNRBF2sFI/6wRW+QmJjcyVBqpDg2hYOydoZFkT9hrkc2itcASk/ZrbP3mYU2o7y2FpTj
         5Yeus4pEqJPsxyNfB70KnoZLs4VUYJPeJ5xi90CXgJpVnHBrjmim4CR0lnFAAHv/Hg8y
         0+3w==
X-Gm-Message-State: AOAM530sGGBB/syGNzJjaepwPoFNlaUgcnS0l6AcEXixF5Oql/rPCT6a
        1Tr6enqJy2WtbDprfxQvZzFpOVOMnzI=
X-Google-Smtp-Source: ABdhPJyichTMn5os3CEEzfz3arOI/tKrdtdNqbXBwNLIJLlgUCwbi0NN74zql1cG4sMn9JXL0j0dXw==
X-Received: by 2002:a7b:c405:: with SMTP id k5mr2628714wmi.24.1631630358785;
        Tue, 14 Sep 2021 07:39:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 129sm1331328wmz.26.2021.09.14.07.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 07:39:18 -0700 (PDT)
Message-Id: <852ec003109b8244e2f9360ec64749779989c4a2.1631630356.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
References: <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
        <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Sep 2021 14:39:02 +0000
Subject: [PATCH v4 01/15] scalar: create a rudimentary executable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The idea of Scalar (https://github.com/microsoft/scalar), and before
that, of VFS for Git, has always been to prove that Git _can_ scale, and
to upstream whatever strategies have been demonstrated to help.

With this patch, we start the journey from that C# project to move what
is left to Git's own `contrib/` directory, reimplementing it in pure C,
with the intention to facilitate integrating the functionality into core
Git all while maintaining backwards-compatibility for existing Scalar
users (which will be much easier when both live in the same worktree).
It has always been the plan to contribute all of the proven strategies
back to core Git.

For example, while the virtual filesystem provided by VFS for Git helped
the team developing the Windows operating system to move onto Git, while
trying to upstream it we realized that it cannot be done: getting the
virtual filesystem to work (which we only managed to implement fully on
Windows, but not on, say, macOS or Linux), and the required server-side
support for the GVFS protocol, made this not quite feasible.

The Scalar project learned from that and tackled the problem with
different tactics: instead of pretending to Git that the working
directory is fully populated, it _specifically_ teaches Git about
partial clone (which is based on VFS for Git's cache server), about
sparse checkout (which VFS for Git tried to do transparently, in the
file system layer), and regularly runs maintenance tasks to keep the
repository in a healthy state.

With partial clone, sparse checkout and `git maintenance` having been
upstreamed, there is little left that `scalar.exe` does which `git.exe`
cannot do. One such thing is that `scalar clone <url>` will
automatically set up a partial, sparse clone, and configure
known-helpful settings from the start.

So let's bring this convenience into Git's tree.

The idea here is that you can (optionally) build Scalar via

	make -C contrib/scalar/Makefile

This will build the `scalar` executable and put it into the
contrib/scalar/ subdirectory.

The slightly awkward addition of the `contrib/scalar/*` bits to the
top-level `Makefile` are actually really required: we want to link to
`libgit.a`, which means that we will need to use the very same `CFLAGS`
and `LDFLAGS` as the rest of Git.

An early development version of this patch tried to replicate all the
conditional code in `contrib/scalar/Makefile` (e.g. `NO_POLL`) just like
`contrib/svn-fe/Makefile` used to do before it was retired. It turned
out to be quite the whack-a-mole game: the SHA-1-related flags, the
flags enabling/disabling `compat/poll/`, `compat/regex/`,
`compat/win32mmap.c` & friends depending on the current platform... To
put it mildly: it was a major mess.

Instead, this patch makes minimal changes to the top-level `Makefile` so
that the bits in `contrib/scalar/` can be compiled and linked, and
adds a `contrib/scalar/Makefile` that uses the top-level `Makefile` in a
most minimal way to do the actual compiling.

Note: With this commit, we only establish the infrastructure, no
Scalar functionality is implemented yet; We will do that incrementally
over the next few commits.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile                  |  8 ++++++++
 contrib/scalar/.gitignore |  2 ++
 contrib/scalar/Makefile   | 34 ++++++++++++++++++++++++++++++++++
 contrib/scalar/scalar.c   | 36 ++++++++++++++++++++++++++++++++++++
 4 files changed, 80 insertions(+)
 create mode 100644 contrib/scalar/.gitignore
 create mode 100644 contrib/scalar/Makefile
 create mode 100644 contrib/scalar/scalar.c

diff --git a/Makefile b/Makefile
index c3565fc0f8f..2d5c822f7a8 100644
--- a/Makefile
+++ b/Makefile
@@ -2447,6 +2447,10 @@ endif
 .PHONY: objects
 objects: $(OBJECTS)
 
+SCALAR_SOURCES := contrib/scalar/scalar.c
+SCALAR_OBJECTS := $(SCALAR_SOURCES:c=o)
+OBJECTS += $(SCALAR_OBJECTS)
+
 dep_files := $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
 dep_dirs := $(addsuffix .depend,$(sort $(dir $(OBJECTS))))
 
@@ -2586,6 +2590,10 @@ $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITLIBS
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
 
+contrib/scalar/scalar$X: $(SCALAR_OBJECTS) GIT-LDFLAGS $(GITLIBS)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
+		$(filter %.o,$^) $(LIBS)
+
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
diff --git a/contrib/scalar/.gitignore b/contrib/scalar/.gitignore
new file mode 100644
index 00000000000..ff3d47e84d0
--- /dev/null
+++ b/contrib/scalar/.gitignore
@@ -0,0 +1,2 @@
+/*.exe
+/scalar
diff --git a/contrib/scalar/Makefile b/contrib/scalar/Makefile
new file mode 100644
index 00000000000..40c03ad10e1
--- /dev/null
+++ b/contrib/scalar/Makefile
@@ -0,0 +1,34 @@
+QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
+QUIET_SUBDIR1  =
+
+ifneq ($(findstring s,$(MAKEFLAGS)),s)
+ifndef V
+	QUIET_SUBDIR0  = +@subdir=
+	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
+			 $(MAKE) $(PRINT_DIR) -C $$subdir
+else
+	export V
+endif
+endif
+
+all:
+
+include ../../config.mak.uname
+-include ../../config.mak.autogen
+-include ../../config.mak
+
+TARGETS = scalar$(X) scalar.o
+GITLIBS = ../../common-main.o ../../libgit.a ../../xdiff/lib.a
+
+all: scalar$X
+
+$(GITLIBS):
+	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) $(subst ../../,,$@)
+
+$(TARGETS): $(GITLIBS) scalar.c
+	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) $(patsubst %,contrib/scalar/%,$@)
+
+clean:
+	$(RM) $(TARGETS)
+
+.PHONY: all clean FORCE
diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
new file mode 100644
index 00000000000..7cff29e0fcd
--- /dev/null
+++ b/contrib/scalar/scalar.c
@@ -0,0 +1,36 @@
+/*
+ * The Scalar command-line interface.
+ */
+
+#include "cache.h"
+#include "gettext.h"
+#include "parse-options.h"
+
+static struct {
+	const char *name;
+	int (*fn)(int, const char **);
+} builtins[] = {
+	{ NULL, NULL},
+};
+
+int cmd_main(int argc, const char **argv)
+{
+	struct strbuf scalar_usage = STRBUF_INIT;
+	int i;
+
+	if (argc > 1) {
+		argv++;
+		argc--;
+
+		for (i = 0; builtins[i].name; i++)
+			if (!strcmp(builtins[i].name, argv[0]))
+				return !!builtins[i].fn(argc, argv);
+	}
+
+	strbuf_addstr(&scalar_usage,
+		      N_("scalar <command> [<options>]\n\nCommands:\n"));
+	for (i = 0; builtins[i].name; i++)
+		strbuf_addf(&scalar_usage, "\t%s\n", builtins[i].name);
+
+	usage(scalar_usage.buf);
+}
-- 
gitgitgadget

