Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3C8C433F5
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 19:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F3146112F
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 19:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbhKATV5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 15:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbhKATVr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 15:21:47 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C2CC061714
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 12:19:13 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id a20-20020a1c7f14000000b003231d13ee3cso172416wmd.3
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 12:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MDV/rcktSEN9/8Q2YHX+9YyZjohjCefwH3Bba3xzEBI=;
        b=qIfJOXWe9NvQElyNhId14Sjc78KQhQJwevUJ4AAWuusAwbFWIEMK1kgPBa0k4uVnwy
         mdZgCHlEsMpgDWxCASzFKAXaZrsEj3tlpdt0dIySn/D9i/5dhXG1uSvb0HHnD5qrCefx
         4WraVm2HiVucTnujypB3Hmdq5hhxVbGzpvsag7Pua+HOGvBc4KSxywi3kdU47kDvxsSf
         +8s1+hW3ZErFifr/fNTYAjxHwN2lmnljJOY13nuJda85E0Y/HNDMlGKfDpByAbG0oGjw
         vr+3KOeu6kh2FvQIwNGpvbxUrPhE0LV3vKv96nIdqubniSavAb5q3vpkiJEJUgE0C/XT
         TeKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MDV/rcktSEN9/8Q2YHX+9YyZjohjCefwH3Bba3xzEBI=;
        b=iNw4k87XnxalxjENtwpt4ZKWiaqBUkbdzzWql0frHiR8WDdyffwQukEObotjCWg5/T
         Z+bhXC0cZCqb5rFW2p6cCKHE/EFDIb3zeNr1J+LCJfx1NQHZJ8qyOfzF73qmQ+VwPtBG
         EHdiEqNT5CgRuFjIqemPNmiFT2fBEeai8TupE69U59oM3BHRvCFR6J1KEKNghuaj8srB
         cCA4IdebviKGOfBV8PFKt+K82LNFNa33RH/JEgIhVLTSQS6MUmx6nuj2ETFsLwvprTh8
         DXZrry0xWg8XoHZMQhZOyRSooqXqbQ9kYYJ2WCuVTPozZy0bYz9v8ZADwTSosluB8S1P
         HcQA==
X-Gm-Message-State: AOAM533xE5qs1vRDxOPRKLFnAfgACTBgNQsocKlIUtuGiYP4wUwV8gqf
        9d1R/XciXq4Y9EUS7AavnKldWmnVM5B22MIu
X-Google-Smtp-Source: ABdhPJxF8/z7MUqLFTUq/noRqZvw7XiAIQ36cmDug3mD6CW2r7Ijf1Cef3P2pG4xD804oU8DX/sBVw==
X-Received: by 2002:a1c:29c6:: with SMTP id p189mr927587wmp.129.1635794350987;
        Mon, 01 Nov 2021 12:19:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v185sm339437wme.35.2021.11.01.12.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 12:19:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Paul Smith <paul@mad-scientist.net>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/3] Makefile: replace most hardcoded object lists with $(wildcard)
Date:   Mon,  1 Nov 2021 20:19:04 +0100
Message-Id: <patch-v2-3.3-cd62d8f92d1-20211101T191231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-v2-0.3-00000000000-20211101T191231Z-avarab@gmail.com>
References: <patch-1.1-bbacbed5c95-20211030T223011Z-avarab@gmail.com> <cover-v2-0.3-00000000000-20211101T191231Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the hardcoded lists of objects in favor of using
$(wildcard). This means that every time a built-in, test tool etc. is
added we won't need to patch the top-level Makefile, except for the
few remaining cases where the asset in question would make it onto one
of our list of exceptions.

Ever since 81b50f3ce40 (Move 'builtin-*' into a 'builtin/'
subdirectory, 2010-02-22) this has been relatively easy to do (and
even before that we could glob builtin-*.c). This pattern of
exhaustively enumerating files was then carried forward for
e.g. TEST_BUILTINS_OBJS in efd71f8913a (t/helper: add an empty
test-tool program, 2018-03-24).

One reason not to do this is that now a new *.c file at the top-level
will be immediately picked up, so if a new *.c file is being worked on
"make" will error if it doesn't compile, whereas before that file
would need to be explicitly listed in the Makefile. I think than small
trade-off is worth it.

We could make this simpler still for the Makefile by moving
"unix-socket.c" etc. to e.g. a "conditional-src/" directory, likewise
for $(PROGRAM_OBJS) to e.g. "programs/". If we did that we would not
need the "$(filter-out)" for LIB_OBJS. I don't think that's worth it,
e.g. due to "git log -- <path>" on the files now needing a "--follow".

There's a few small "while we're at it" changes here, since I'm
touching the code in question:

 - Start splitting up the the "Guard against the environment" section
   at the top, but don't move anything that exists there out to avoid
   merge conflicts

 - The $(TEST_BUILTINS_OBJS) variable was needlessly complex, because
   it didn't have the full paths we'd pathsubst it back & forth.

 - Introduce *_SRC in addition to *_OBJ for the variable I'm
   touching. Eventually we'll want to do this for all the *.o files,
   i.e. make the *.c list a source of truth for *.o, which means we can
   e.g. use that exhaustive list for "make TAGS".

 - Add a missing "curl-objs" target. See 029bac01a87 (Makefile: add
   {program,xdiff,test,git,fuzz}-objs & objects targets, 2021-02-23)
   for the commit that added the rest.

 - De-indent an "ifndef" block, we don't usually indent their
   contents.

On the CMake changes here:

 - When CMake support was introduced in was introduced
   061c2240b1b (Introduce CMake support for configuring Git, 2020-06-12)
   there was a discussion about the maintenance burden of maintaining the
   top-level Makefile in parallel with CMakeLists.txt[1] where reviewers
   were assured that doing so would simply be a matter of adding something
   to a list in the CMake recipe.

   Between change and some recent changes of mine where the "vs-build"
   job failed to a divergence between the Makefile and CMakeList.txt I
   can confidently say that that doesn't at all match reality. Even
   seemingly trivial changes to the Makefile like this one are forcing
   us to do a deep-dive into CMake internals to make forward progress
   with our main build system.

 - The promised "We can add a (continue-on-error) to vs-build job to
   make this process less of a hindrance." in [2] never materialized.
   Since 4c2c38e800f (ci: modification of main.yml to use cmake for
   vs-build job, 2020-06-26) got a hard dependency on CMake as far as
   getting the CI to pass goes.

 - The "vs-build" CI doesn't actually require that there be no GNU make
   usage in the job, as it itself has a hard dependency on running a
   "make -n artifacts-tar" command. So as far as any vs-specific special-sauce
   goes we don't need a GNU-make free build system for vs-build.

 - The stated goal in 061c2240b1b of avoiding a GNU make dependency
   for developer because it requires an SDK that "occupies around two
   gigabytes" and "three quarters of a gigabyte worth of Git objects"
   hardly seems worthwhile trade-off given the above. Disk space is cheap,
   developer time required to maintain two parallel build systems isn't.

My attempt to amend/revert 4c2c38e800f to have it use the
pre-4c2c38e800f "make" invocation as a fallback failed, partially
because I don't have a Windows development environment, so any attempt
to change it is a painfully slow round-trip to GitHub CI.

Let's instead have CMake call out to the Makefile asking it what the
definition of various variables lists is, rather than being forced to
maintain those lists in a way that CMake can parse with regexes (which
precludes anything but a giant hardcoded list).

I could familiarize myself enough with CMake to do this in some
CMake-native way, but that would take "just as long as adding it to
the Makefile"[2] (I think that took me <5 minutes, but I'm several
hours into fighting with CMake)

So I consider this both a bugfix to the stated aims of this CMake
integration, and a better way forward for having an alternate build
system. I.e. If someone really does care about a having a
GNU-make-less dependency for the "vs-build" I think this change offers
a much better way forward for that.

Once we invoke the Makefile to spew out e.g. its idea of "LIB_OBJS",
it's going to be trivial to do that via some wrapper script that lives
in "contrib/buildsystems". Such a script would either invoke "make
print-{var,list}-%", or alternatively use an in-tree committed text
file with the last known result of such a "make print-{var,list}-%"
run.

1. https://lore.kernel.org/git/xmqq8sikblv2.fsf@gitster.c.googlers.com
2. https://lore.kernel.org/git/CAKiG+9Xtof8Hj3npsS-M0SnT_dcjtHjP_+avWB4oOHkaMdnSbw@mail.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile                            | 485 ++++------------------------
 contrib/buildsystems/CMakeLists.txt |  53 ++-
 2 files changed, 74 insertions(+), 464 deletions(-)

diff --git a/Makefile b/Makefile
index 4139bcf675c..5d78ab6860a 100644
--- a/Makefile
+++ b/Makefile
@@ -590,6 +590,19 @@ TEST_OBJS =
 TEST_PROGRAMS_NEED_X =
 THIRD_PARTY_SOURCES =
 
+## Guard against env: programs
+TEST_PROGRAMS =
+
+## Guard against env: sources
+CURL_SRC =
+TEST_PROGRAMS_NEED_X_SRC =
+XDIFF_SRC =
+
+## Guard against env: objects
+CONDITIONAL_OBJS =
+CURL_OBJS =
+LIB_OBJS_DIRS =
+
 # Utility to dump whatever variables are defined here
 print-var-%:
 	@echo $($*)
@@ -697,87 +710,23 @@ X =
 
 PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 
-TEST_BUILTINS_OBJS += test-advise.o
-TEST_BUILTINS_OBJS += test-bitmap.o
-TEST_BUILTINS_OBJS += test-bloom.o
-TEST_BUILTINS_OBJS += test-chmtime.o
-TEST_BUILTINS_OBJS += test-config.o
-TEST_BUILTINS_OBJS += test-crontab.o
-TEST_BUILTINS_OBJS += test-ctype.o
-TEST_BUILTINS_OBJS += test-date.o
-TEST_BUILTINS_OBJS += test-delta.o
-TEST_BUILTINS_OBJS += test-dir-iterator.o
-TEST_BUILTINS_OBJS += test-drop-caches.o
-TEST_BUILTINS_OBJS += test-dump-cache-tree.o
-TEST_BUILTINS_OBJS += test-dump-fsmonitor.o
-TEST_BUILTINS_OBJS += test-dump-split-index.o
-TEST_BUILTINS_OBJS += test-dump-untracked-cache.o
-TEST_BUILTINS_OBJS += test-example-decorate.o
-TEST_BUILTINS_OBJS += test-fast-rebase.o
-TEST_BUILTINS_OBJS += test-genrandom.o
-TEST_BUILTINS_OBJS += test-genzeros.o
-TEST_BUILTINS_OBJS += test-getcwd.o
-TEST_BUILTINS_OBJS += test-hash-speed.o
-TEST_BUILTINS_OBJS += test-hash.o
-TEST_BUILTINS_OBJS += test-hashmap.o
-TEST_BUILTINS_OBJS += test-index-version.o
-TEST_BUILTINS_OBJS += test-json-writer.o
-TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
-TEST_BUILTINS_OBJS += test-match-trees.o
-TEST_BUILTINS_OBJS += test-mergesort.o
-TEST_BUILTINS_OBJS += test-mktemp.o
-TEST_BUILTINS_OBJS += test-oid-array.o
-TEST_BUILTINS_OBJS += test-oidmap.o
-TEST_BUILTINS_OBJS += test-oidtree.o
-TEST_BUILTINS_OBJS += test-online-cpus.o
-TEST_BUILTINS_OBJS += test-parse-options.o
-TEST_BUILTINS_OBJS += test-parse-pathspec-file.o
-TEST_BUILTINS_OBJS += test-partial-clone.o
-TEST_BUILTINS_OBJS += test-path-utils.o
-TEST_BUILTINS_OBJS += test-pcre2-config.o
-TEST_BUILTINS_OBJS += test-pkt-line.o
-TEST_BUILTINS_OBJS += test-prio-queue.o
-TEST_BUILTINS_OBJS += test-proc-receive.o
-TEST_BUILTINS_OBJS += test-progress.o
-TEST_BUILTINS_OBJS += test-reach.o
-TEST_BUILTINS_OBJS += test-read-cache.o
-TEST_BUILTINS_OBJS += test-read-graph.o
-TEST_BUILTINS_OBJS += test-read-midx.o
-TEST_BUILTINS_OBJS += test-ref-store.o
-TEST_BUILTINS_OBJS += test-regex.o
-TEST_BUILTINS_OBJS += test-repository.o
-TEST_BUILTINS_OBJS += test-revision-walking.o
-TEST_BUILTINS_OBJS += test-run-command.o
-TEST_BUILTINS_OBJS += test-scrap-cache-tree.o
-TEST_BUILTINS_OBJS += test-serve-v2.o
-TEST_BUILTINS_OBJS += test-sha1.o
-TEST_BUILTINS_OBJS += test-sha256.o
-TEST_BUILTINS_OBJS += test-sigchain.o
-TEST_BUILTINS_OBJS += test-simple-ipc.o
-TEST_BUILTINS_OBJS += test-strcmp-offset.o
-TEST_BUILTINS_OBJS += test-string-list.o
-TEST_BUILTINS_OBJS += test-submodule-config.o
-TEST_BUILTINS_OBJS += test-submodule-nested-repo-config.o
-TEST_BUILTINS_OBJS += test-subprocess.o
-TEST_BUILTINS_OBJS += test-trace2.o
-TEST_BUILTINS_OBJS += test-urlmatch-normalization.o
-TEST_BUILTINS_OBJS += test-userdiff.o
-TEST_BUILTINS_OBJS += test-wildmatch.o
-TEST_BUILTINS_OBJS += test-windows-named-pipe.o
-TEST_BUILTINS_OBJS += test-write-cache.o
-TEST_BUILTINS_OBJS += test-xml-encode.o
-
 # Do not add more tests here unless they have extra dependencies. Add
 # them in TEST_BUILTINS_OBJS above.
 TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-tool
 
-TEST_PROGRAMS = $(patsubst %,t/helper/%$X,$(TEST_PROGRAMS_NEED_X))
+TEST_PROGRAMS_NEED_X_SRC += $(TEST_PROGRAMS_NEED_X:%=t/helper/%.c)
+TEST_PROGRAMS += $(TEST_PROGRAMS_NEED_X_SRC:%.c=%$X)
+TEST_BUILTINS_SRC += $(filter-out $(TEST_PROGRAMS_NEED_X_SRC),$(wildcard t/helper/*.c))
+TEST_BUILTINS_OBJS += $(TEST_BUILTINS_SRC:%.c=%.o)
 
-# List built-in command $C whose implementation cmd_$C() is not in
-# builtin/$C.o but is linked in as part of some other command.
+# List built-in command $C whose implementation cmd_$C() is in
+# builtin/$C.o
+BUILTIN_OBJS = $(patsubst %.c,%.o,$(wildcard builtin/*.c))
 BUILT_INS += $(patsubst builtin/%.o,git-%$X,$(BUILTIN_OBJS))
 
+# List built-in command $C whose implementation cmd_$C() is not in
+# builtin/$C.o but is linked in as part of some other command.
 BUILT_INS += git-cherry$X
 BUILT_INS += git-cherry-pick$X
 BUILT_INS += git-format-patch$X
@@ -837,355 +786,28 @@ LIB_H := $(sort $(patsubst ./%,%,$(shell git ls-files '*.h' ':!t/' ':!Documentat
 	-name Documentation -prune -o \
 	-name '*.h' -print)))
 
-LIB_OBJS += abspath.o
-LIB_OBJS += add-interactive.o
-LIB_OBJS += add-patch.o
-LIB_OBJS += advice.o
-LIB_OBJS += alias.o
-LIB_OBJS += alloc.o
-LIB_OBJS += apply.o
-LIB_OBJS += archive-tar.o
-LIB_OBJS += archive-zip.o
-LIB_OBJS += archive.o
-LIB_OBJS += attr.o
-LIB_OBJS += base85.o
-LIB_OBJS += bisect.o
-LIB_OBJS += blame.o
-LIB_OBJS += blob.o
-LIB_OBJS += bloom.o
-LIB_OBJS += branch.o
-LIB_OBJS += bulk-checkin.o
-LIB_OBJS += bundle.o
-LIB_OBJS += cache-tree.o
-LIB_OBJS += cbtree.o
-LIB_OBJS += chdir-notify.o
-LIB_OBJS += checkout.o
-LIB_OBJS += chunk-format.o
-LIB_OBJS += color.o
-LIB_OBJS += column.o
-LIB_OBJS += combine-diff.o
-LIB_OBJS += commit-graph.o
-LIB_OBJS += commit-reach.o
-LIB_OBJS += commit.o
+# LIB_OBJS: compat/* objects that live at the top-level
+CONDITIONAL_OBJS += unix-socket.o
+CONDITIONAL_OBJS += unix-stream-server.o
+CONDITIONAL_OBJS += sha1dc_git.o
+
+# LIB_OBJS: Mostly glob *.c at the top-level, with some exlusions
+LIB_OBJS += $(filter-out \
+	$(CONDITIONAL_OBJS) \
+	git.o common-main.o $(PROGRAM_OBJS) \
+	$(FUZZ_OBJS) $(CURL_OBJS),\
+	$(patsubst %.c,%.o,$(wildcard *.c)))
+
+# LIB_OBJS: Directories that contain only LIB_OBJS
+LIB_OBJS_DIRS += ewah
+LIB_OBJS_DIRS += negotiator
+LIB_OBJS_DIRS += refs
+LIB_OBJS_DIRS += trace2
+LIB_OBJS += $(patsubst %.c,%.o,$(wildcard $(addsuffix /*.c,$(LIB_OBJS_DIRS))))
+
+# LIB_OBJS: unconditional compat/* objects
 LIB_OBJS += compat/obstack.o
 LIB_OBJS += compat/terminal.o
-LIB_OBJS += config.o
-LIB_OBJS += connect.o
-LIB_OBJS += connected.o
-LIB_OBJS += convert.o
-LIB_OBJS += copy.o
-LIB_OBJS += credential.o
-LIB_OBJS += csum-file.o
-LIB_OBJS += ctype.o
-LIB_OBJS += date.o
-LIB_OBJS += decorate.o
-LIB_OBJS += delta-islands.o
-LIB_OBJS += diff-delta.o
-LIB_OBJS += diff-merges.o
-LIB_OBJS += diff-lib.o
-LIB_OBJS += diff-no-index.o
-LIB_OBJS += diff.o
-LIB_OBJS += diffcore-break.o
-LIB_OBJS += diffcore-delta.o
-LIB_OBJS += diffcore-order.o
-LIB_OBJS += diffcore-pickaxe.o
-LIB_OBJS += diffcore-rename.o
-LIB_OBJS += diffcore-rotate.o
-LIB_OBJS += dir-iterator.o
-LIB_OBJS += dir.o
-LIB_OBJS += editor.o
-LIB_OBJS += entry.o
-LIB_OBJS += environment.o
-LIB_OBJS += ewah/bitmap.o
-LIB_OBJS += ewah/ewah_bitmap.o
-LIB_OBJS += ewah/ewah_io.o
-LIB_OBJS += ewah/ewah_rlw.o
-LIB_OBJS += exec-cmd.o
-LIB_OBJS += fetch-negotiator.o
-LIB_OBJS += fetch-pack.o
-LIB_OBJS += fmt-merge-msg.o
-LIB_OBJS += fsck.o
-LIB_OBJS += fsmonitor.o
-LIB_OBJS += gettext.o
-LIB_OBJS += gpg-interface.o
-LIB_OBJS += graph.o
-LIB_OBJS += grep.o
-LIB_OBJS += hash-lookup.o
-LIB_OBJS += hashmap.o
-LIB_OBJS += help.o
-LIB_OBJS += hex.o
-LIB_OBJS += hook.o
-LIB_OBJS += ident.o
-LIB_OBJS += json-writer.o
-LIB_OBJS += kwset.o
-LIB_OBJS += levenshtein.o
-LIB_OBJS += line-log.o
-LIB_OBJS += line-range.o
-LIB_OBJS += linear-assignment.o
-LIB_OBJS += list-objects-filter-options.o
-LIB_OBJS += list-objects-filter.o
-LIB_OBJS += list-objects.o
-LIB_OBJS += ll-merge.o
-LIB_OBJS += lockfile.o
-LIB_OBJS += log-tree.o
-LIB_OBJS += ls-refs.o
-LIB_OBJS += mailinfo.o
-LIB_OBJS += mailmap.o
-LIB_OBJS += match-trees.o
-LIB_OBJS += mem-pool.o
-LIB_OBJS += merge-blobs.o
-LIB_OBJS += merge-ort.o
-LIB_OBJS += merge-ort-wrappers.o
-LIB_OBJS += merge-recursive.o
-LIB_OBJS += merge.o
-LIB_OBJS += mergesort.o
-LIB_OBJS += midx.o
-LIB_OBJS += name-hash.o
-LIB_OBJS += negotiator/default.o
-LIB_OBJS += negotiator/noop.o
-LIB_OBJS += negotiator/skipping.o
-LIB_OBJS += notes-cache.o
-LIB_OBJS += notes-merge.o
-LIB_OBJS += notes-utils.o
-LIB_OBJS += notes.o
-LIB_OBJS += object-file.o
-LIB_OBJS += object-name.o
-LIB_OBJS += object.o
-LIB_OBJS += oid-array.o
-LIB_OBJS += oidmap.o
-LIB_OBJS += oidset.o
-LIB_OBJS += oidtree.o
-LIB_OBJS += pack-bitmap-write.o
-LIB_OBJS += pack-bitmap.o
-LIB_OBJS += pack-check.o
-LIB_OBJS += pack-objects.o
-LIB_OBJS += pack-revindex.o
-LIB_OBJS += pack-write.o
-LIB_OBJS += packfile.o
-LIB_OBJS += pager.o
-LIB_OBJS += parallel-checkout.o
-LIB_OBJS += parse-options-cb.o
-LIB_OBJS += parse-options.o
-LIB_OBJS += patch-delta.o
-LIB_OBJS += patch-ids.o
-LIB_OBJS += path.o
-LIB_OBJS += pathspec.o
-LIB_OBJS += pkt-line.o
-LIB_OBJS += preload-index.o
-LIB_OBJS += pretty.o
-LIB_OBJS += prio-queue.o
-LIB_OBJS += progress.o
-LIB_OBJS += promisor-remote.o
-LIB_OBJS += prompt.o
-LIB_OBJS += protocol.o
-LIB_OBJS += protocol-caps.o
-LIB_OBJS += prune-packed.o
-LIB_OBJS += quote.o
-LIB_OBJS += range-diff.o
-LIB_OBJS += reachable.o
-LIB_OBJS += read-cache.o
-LIB_OBJS += rebase-interactive.o
-LIB_OBJS += rebase.o
-LIB_OBJS += ref-filter.o
-LIB_OBJS += reflog-walk.o
-LIB_OBJS += refs.o
-LIB_OBJS += refs/debug.o
-LIB_OBJS += refs/files-backend.o
-LIB_OBJS += refs/iterator.o
-LIB_OBJS += refs/packed-backend.o
-LIB_OBJS += refs/ref-cache.o
-LIB_OBJS += refspec.o
-LIB_OBJS += remote.o
-LIB_OBJS += replace-object.o
-LIB_OBJS += repo-settings.o
-LIB_OBJS += repository.o
-LIB_OBJS += rerere.o
-LIB_OBJS += reset.o
-LIB_OBJS += resolve-undo.o
-LIB_OBJS += revision.o
-LIB_OBJS += run-command.o
-LIB_OBJS += send-pack.o
-LIB_OBJS += sequencer.o
-LIB_OBJS += serve.o
-LIB_OBJS += server-info.o
-LIB_OBJS += setup.o
-LIB_OBJS += shallow.o
-LIB_OBJS += sideband.o
-LIB_OBJS += sigchain.o
-LIB_OBJS += sparse-index.o
-LIB_OBJS += split-index.o
-LIB_OBJS += stable-qsort.o
-LIB_OBJS += strbuf.o
-LIB_OBJS += streaming.o
-LIB_OBJS += string-list.o
-LIB_OBJS += strmap.o
-LIB_OBJS += strvec.o
-LIB_OBJS += sub-process.o
-LIB_OBJS += submodule-config.o
-LIB_OBJS += submodule.o
-LIB_OBJS += symlinks.o
-LIB_OBJS += tag.o
-LIB_OBJS += tempfile.o
-LIB_OBJS += thread-utils.o
-LIB_OBJS += tmp-objdir.o
-LIB_OBJS += trace.o
-LIB_OBJS += trace2.o
-LIB_OBJS += trace2/tr2_cfg.o
-LIB_OBJS += trace2/tr2_cmd_name.o
-LIB_OBJS += trace2/tr2_dst.o
-LIB_OBJS += trace2/tr2_sid.o
-LIB_OBJS += trace2/tr2_sysenv.o
-LIB_OBJS += trace2/tr2_tbuf.o
-LIB_OBJS += trace2/tr2_tgt_event.o
-LIB_OBJS += trace2/tr2_tgt_normal.o
-LIB_OBJS += trace2/tr2_tgt_perf.o
-LIB_OBJS += trace2/tr2_tls.o
-LIB_OBJS += trailer.o
-LIB_OBJS += transport-helper.o
-LIB_OBJS += transport.o
-LIB_OBJS += tree-diff.o
-LIB_OBJS += tree-walk.o
-LIB_OBJS += tree.o
-LIB_OBJS += unpack-trees.o
-LIB_OBJS += upload-pack.o
-LIB_OBJS += url.o
-LIB_OBJS += urlmatch.o
-LIB_OBJS += usage.o
-LIB_OBJS += userdiff.o
-LIB_OBJS += utf8.o
-LIB_OBJS += varint.o
-LIB_OBJS += version.o
-LIB_OBJS += versioncmp.o
-LIB_OBJS += walker.o
-LIB_OBJS += wildmatch.o
-LIB_OBJS += worktree.o
-LIB_OBJS += wrapper.o
-LIB_OBJS += write-or-die.o
-LIB_OBJS += ws.o
-LIB_OBJS += wt-status.o
-LIB_OBJS += xdiff-interface.o
-LIB_OBJS += zlib.o
-
-BUILTIN_OBJS += builtin/add.o
-BUILTIN_OBJS += builtin/am.o
-BUILTIN_OBJS += builtin/annotate.o
-BUILTIN_OBJS += builtin/apply.o
-BUILTIN_OBJS += builtin/archive.o
-BUILTIN_OBJS += builtin/bisect--helper.o
-BUILTIN_OBJS += builtin/blame.o
-BUILTIN_OBJS += builtin/branch.o
-BUILTIN_OBJS += builtin/bugreport.o
-BUILTIN_OBJS += builtin/bundle.o
-BUILTIN_OBJS += builtin/cat-file.o
-BUILTIN_OBJS += builtin/check-attr.o
-BUILTIN_OBJS += builtin/check-ignore.o
-BUILTIN_OBJS += builtin/check-mailmap.o
-BUILTIN_OBJS += builtin/check-ref-format.o
-BUILTIN_OBJS += builtin/checkout--worker.o
-BUILTIN_OBJS += builtin/checkout-index.o
-BUILTIN_OBJS += builtin/checkout.o
-BUILTIN_OBJS += builtin/clean.o
-BUILTIN_OBJS += builtin/clone.o
-BUILTIN_OBJS += builtin/column.o
-BUILTIN_OBJS += builtin/commit-graph.o
-BUILTIN_OBJS += builtin/commit-tree.o
-BUILTIN_OBJS += builtin/commit.o
-BUILTIN_OBJS += builtin/config.o
-BUILTIN_OBJS += builtin/count-objects.o
-BUILTIN_OBJS += builtin/credential-cache--daemon.o
-BUILTIN_OBJS += builtin/credential-cache.o
-BUILTIN_OBJS += builtin/credential-store.o
-BUILTIN_OBJS += builtin/credential.o
-BUILTIN_OBJS += builtin/describe.o
-BUILTIN_OBJS += builtin/diff-files.o
-BUILTIN_OBJS += builtin/diff-index.o
-BUILTIN_OBJS += builtin/diff-tree.o
-BUILTIN_OBJS += builtin/diff.o
-BUILTIN_OBJS += builtin/difftool.o
-BUILTIN_OBJS += builtin/env--helper.o
-BUILTIN_OBJS += builtin/fast-export.o
-BUILTIN_OBJS += builtin/fast-import.o
-BUILTIN_OBJS += builtin/fetch-pack.o
-BUILTIN_OBJS += builtin/fetch.o
-BUILTIN_OBJS += builtin/fmt-merge-msg.o
-BUILTIN_OBJS += builtin/for-each-ref.o
-BUILTIN_OBJS += builtin/for-each-repo.o
-BUILTIN_OBJS += builtin/fsck.o
-BUILTIN_OBJS += builtin/gc.o
-BUILTIN_OBJS += builtin/get-tar-commit-id.o
-BUILTIN_OBJS += builtin/grep.o
-BUILTIN_OBJS += builtin/hash-object.o
-BUILTIN_OBJS += builtin/help.o
-BUILTIN_OBJS += builtin/index-pack.o
-BUILTIN_OBJS += builtin/init-db.o
-BUILTIN_OBJS += builtin/interpret-trailers.o
-BUILTIN_OBJS += builtin/log.o
-BUILTIN_OBJS += builtin/ls-files.o
-BUILTIN_OBJS += builtin/ls-remote.o
-BUILTIN_OBJS += builtin/ls-tree.o
-BUILTIN_OBJS += builtin/mailinfo.o
-BUILTIN_OBJS += builtin/mailsplit.o
-BUILTIN_OBJS += builtin/merge-base.o
-BUILTIN_OBJS += builtin/merge-file.o
-BUILTIN_OBJS += builtin/merge-index.o
-BUILTIN_OBJS += builtin/merge-ours.o
-BUILTIN_OBJS += builtin/merge-recursive.o
-BUILTIN_OBJS += builtin/merge-tree.o
-BUILTIN_OBJS += builtin/merge.o
-BUILTIN_OBJS += builtin/mktag.o
-BUILTIN_OBJS += builtin/mktree.o
-BUILTIN_OBJS += builtin/multi-pack-index.o
-BUILTIN_OBJS += builtin/mv.o
-BUILTIN_OBJS += builtin/name-rev.o
-BUILTIN_OBJS += builtin/notes.o
-BUILTIN_OBJS += builtin/pack-objects.o
-BUILTIN_OBJS += builtin/pack-redundant.o
-BUILTIN_OBJS += builtin/pack-refs.o
-BUILTIN_OBJS += builtin/patch-id.o
-BUILTIN_OBJS += builtin/prune-packed.o
-BUILTIN_OBJS += builtin/prune.o
-BUILTIN_OBJS += builtin/pull.o
-BUILTIN_OBJS += builtin/push.o
-BUILTIN_OBJS += builtin/range-diff.o
-BUILTIN_OBJS += builtin/read-tree.o
-BUILTIN_OBJS += builtin/rebase.o
-BUILTIN_OBJS += builtin/receive-pack.o
-BUILTIN_OBJS += builtin/reflog.o
-BUILTIN_OBJS += builtin/remote-ext.o
-BUILTIN_OBJS += builtin/remote-fd.o
-BUILTIN_OBJS += builtin/remote.o
-BUILTIN_OBJS += builtin/repack.o
-BUILTIN_OBJS += builtin/replace.o
-BUILTIN_OBJS += builtin/rerere.o
-BUILTIN_OBJS += builtin/reset.o
-BUILTIN_OBJS += builtin/rev-list.o
-BUILTIN_OBJS += builtin/rev-parse.o
-BUILTIN_OBJS += builtin/revert.o
-BUILTIN_OBJS += builtin/rm.o
-BUILTIN_OBJS += builtin/send-pack.o
-BUILTIN_OBJS += builtin/shortlog.o
-BUILTIN_OBJS += builtin/show-branch.o
-BUILTIN_OBJS += builtin/show-index.o
-BUILTIN_OBJS += builtin/show-ref.o
-BUILTIN_OBJS += builtin/sparse-checkout.o
-BUILTIN_OBJS += builtin/stash.o
-BUILTIN_OBJS += builtin/stripspace.o
-BUILTIN_OBJS += builtin/submodule--helper.o
-BUILTIN_OBJS += builtin/symbolic-ref.o
-BUILTIN_OBJS += builtin/tag.o
-BUILTIN_OBJS += builtin/unpack-file.o
-BUILTIN_OBJS += builtin/unpack-objects.o
-BUILTIN_OBJS += builtin/update-index.o
-BUILTIN_OBJS += builtin/update-ref.o
-BUILTIN_OBJS += builtin/update-server-info.o
-BUILTIN_OBJS += builtin/upload-archive.o
-BUILTIN_OBJS += builtin/upload-pack.o
-BUILTIN_OBJS += builtin/var.o
-BUILTIN_OBJS += builtin/verify-commit.o
-BUILTIN_OBJS += builtin/verify-pack.o
-BUILTIN_OBJS += builtin/verify-tag.o
-BUILTIN_OBJS += builtin/worktree.o
-BUILTIN_OBJS += builtin/write-tree.o
 
 # THIRD_PARTY_SOURCES is a list of patterns compatible with the
 # $(filter) and $(filter-out) family of functions. They specify source
@@ -2076,6 +1698,7 @@ endif
 LIBS = $(filter-out %.o, $(GITLIBS)) $(EXTLIBS)
 
 BASIC_CFLAGS += $(COMPAT_CFLAGS)
+LIB_OBJS_NO_COMPAT := $(LIB_OBJS)
 LIB_OBJS += $(COMPAT_OBJS)
 
 # Quote for C
@@ -2436,17 +2059,12 @@ reconfigure config.mak.autogen: config.status
 .PHONY: reconfigure # This is a convenience target.
 endif
 
-XDIFF_OBJS += xdiff/xdiffi.o
-XDIFF_OBJS += xdiff/xemit.o
-XDIFF_OBJS += xdiff/xhistogram.o
-XDIFF_OBJS += xdiff/xmerge.o
-XDIFF_OBJS += xdiff/xpatience.o
-XDIFF_OBJS += xdiff/xprepare.o
-XDIFF_OBJS += xdiff/xutils.o
+XDIFF_SRC += $(wildcard xdiff/*.c)
+XDIFF_OBJS += $(XDIFF_SRC:.c=.o)
 .PHONY: xdiff-objs
 xdiff-objs: $(XDIFF_OBJS)
 
-TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
+TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(TEST_BUILTINS_OBJS)
 .PHONY: test-objs
 test-objs: $(TEST_OBJS)
 
@@ -2457,13 +2075,20 @@ GIT_OBJS += git.o
 .PHONY: git-objs
 git-objs: $(GIT_OBJS)
 
+CURL_SRC += http.c
+CURL_SRC += http-walker.c
+CURL_SRC += remote-curl.c
+CURL_OBJS += $(CURL_SRC:.c=.o)
+.PHONY: curl-objs
+curl-objs: $(CURL_OBJS)
+
 OBJECTS += $(GIT_OBJS)
 OBJECTS += $(PROGRAM_OBJS)
 OBJECTS += $(TEST_OBJS)
 OBJECTS += $(XDIFF_OBJS)
 OBJECTS += $(FUZZ_OBJS)
 ifndef NO_CURL
-	OBJECTS += http.o http-walker.o remote-curl.o
+OBJECTS += $(CURL_OBJS)
 endif
 .PHONY: objects
 objects: $(OBJECTS)
@@ -2900,7 +2525,7 @@ perf: all
 
 .PRECIOUS: $(TEST_OBJS)
 
-t/helper/test-tool$X: $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
+t/helper/test-tool$X: $(TEST_BUILTINS_OBJS)
 
 t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index fd1399c440f..d57c9203b66 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -111,32 +111,15 @@ project(git
 #TODO Add pcre support
 
 #macros for parsing the Makefile for sources and scripts
-macro(parse_makefile_for_sources list_var regex)
-	file(STRINGS ${CMAKE_SOURCE_DIR}/Makefile ${list_var} REGEX "^${regex} \\+=(.*)")
-	string(REPLACE "${regex} +=" "" ${list_var} ${${list_var}})
-	string(REPLACE "$(COMPAT_OBJS)" "" ${list_var} ${${list_var}}) #remove "$(COMPAT_OBJS)" This is only for libgit.
-	string(STRIP ${${list_var}} ${list_var}) #remove trailing/leading whitespaces
-	string(REPLACE ".o" ".c;" ${list_var} ${${list_var}}) #change .o to .c, ; is for converting the string into a list
-	list(TRANSFORM ${list_var} STRIP) #remove trailing/leading whitespaces for each element in list
-	list(REMOVE_ITEM ${list_var} "") #remove empty list elements
-endmacro()
-
-macro(parse_makefile_for_scripts list_var regex lang)
-	file(STRINGS ${CMAKE_SOURCE_DIR}/Makefile ${list_var} REGEX "^${regex} \\+=(.*)")
-	string(REPLACE "${regex} +=" "" ${list_var} ${${list_var}})
-	string(STRIP ${${list_var}} ${list_var}) #remove trailing/leading whitespaces
-	string(REPLACE " " ";" ${list_var} ${${list_var}}) #convert string to a list
-	if(NOT ${lang}) #exclude for SCRIPT_LIB
-		list(TRANSFORM ${list_var} REPLACE "${lang}" "") #do the replacement
-	endif()
-endmacro()
-
-macro(parse_makefile_for_executables list_var regex)
-	file(STRINGS ${CMAKE_SOURCE_DIR}/Makefile ${list_var} REGEX "^${regex} \\+= git-(.*)")
-	string(REPLACE "${regex} +=" "" ${list_var} ${${list_var}})
+macro(ask_makefile_for_list list_var var_name)
+	execute_process(COMMAND make print-list-${var_name}
+			WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
+			OUTPUT_VARIABLE ${list_var})
+	string(REGEX REPLACE "\\.o\n" ".c\n" ${list_var} ${${list_var}}) #change .o to .c
 	string(STRIP ${${list_var}} ${list_var}) #remove trailing/leading whitespaces
-	string(REPLACE "git-" "" ${list_var} ${${list_var}}) #strip `git-` prefix
-	string(REPLACE "\$X" ";" ${list_var} ${${list_var}}) #strip $X, ; is for converting the string into a list
+	## Parse the Makefile print-list-% format
+	string(REGEX REPLACE "${var_name} =\n" "" ${list_var} ${${list_var}})
+	string(REGEX REPLACE "${var_name} \\+?= ([^\n]+)" "\\1;" ${list_var} ${${list_var}})
 	list(TRANSFORM ${list_var} STRIP) #remove trailing/leading whitespaces for each element in list
 	list(REMOVE_ITEM ${list_var} "") #remove empty list elements
 endmacro()
@@ -635,14 +618,14 @@ include_directories(${CMAKE_BINARY_DIR})
 
 #build
 #libgit
-parse_makefile_for_sources(libgit_SOURCES "LIB_OBJS")
+ask_makefile_for_list(libgit_SOURCES "LIB_OBJS_NO_COMPAT")
 
 list(TRANSFORM libgit_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
 list(TRANSFORM compat_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
 add_library(libgit ${libgit_SOURCES} ${compat_SOURCES})
 
 #libxdiff
-parse_makefile_for_sources(libxdiff_SOURCES "XDIFF_OBJS")
+ask_makefile_for_list(libxdiff_SOURCES "XDIFF_OBJS")
 
 list(TRANSFORM libxdiff_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
 add_library(xdiff STATIC ${libxdiff_SOURCES})
@@ -693,7 +676,7 @@ elseif(UNIX)
 endif()
 
 #git
-parse_makefile_for_sources(git_SOURCES "BUILTIN_OBJS")
+ask_makefile_for_list(git_SOURCES "BUILTIN_OBJS")
 
 list(TRANSFORM git_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
 add_executable(git ${CMAKE_SOURCE_DIR}/git.c ${git_SOURCES})
@@ -729,7 +712,9 @@ if(CURL_FOUND)
 	endif()
 endif()
 
-parse_makefile_for_executables(git_builtin_extra "BUILT_INS")
+ask_makefile_for_list(git_builtin_extra "BUILT_INS")
+list(TRANSFORM git_builtin_extra REPLACE "^git-(.*)" "\\1") #strip `git-` prefix
+list(TRANSFORM git_builtin_extra REPLACE "\.exe$" "") #strip $X
 
 option(SKIP_DASHED_BUILT_INS "Skip hardlinking the dashed versions of the built-ins")
 
@@ -766,8 +751,8 @@ set(GITWEBDIR ${FALLBACK_RUNTIME_PREFIX}/share/locale)
 set(INSTLIBDIR ${FALLBACK_RUNTIME_PREFIX}/share/perl5)
 
 #shell scripts
-parse_makefile_for_scripts(git_sh_scripts "SCRIPT_SH" ".sh")
-parse_makefile_for_scripts(git_shlib_scripts "SCRIPT_LIB" "")
+ask_makefile_for_list(git_sh_scripts "SCRIPT_SH_GEN")
+ask_makefile_for_list(git_shlib_scripts "SCRIPT_LIB_GEN")
 set(git_shell_scripts
 	${git_sh_scripts} ${git_shlib_scripts} git-instaweb)
 
@@ -787,7 +772,7 @@ foreach(script ${git_shell_scripts})
 endforeach()
 
 #perl scripts
-parse_makefile_for_scripts(git_perl_scripts "SCRIPT_PERL" ".perl")
+ask_makefile_for_list(git_perl_scripts "SCRIPT_PERL_GEN")
 
 #create perl header
 file(STRINGS ${CMAKE_SOURCE_DIR}/perl/header_templates/fixed_prefix.template.pl perl_header )
@@ -910,9 +895,9 @@ add_executable(test-fake-ssh ${CMAKE_SOURCE_DIR}/t/helper/test-fake-ssh.c)
 target_link_libraries(test-fake-ssh common-main)
 
 #test-tool
-parse_makefile_for_sources(test-tool_SOURCES "TEST_BUILTINS_OBJS")
+ask_makefile_for_list(test-tool_SOURCES "TEST_BUILTINS_OBJS")
 
-list(TRANSFORM test-tool_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/t/helper/")
+list(TRANSFORM test-tool_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
 add_executable(test-tool ${CMAKE_SOURCE_DIR}/t/helper/test-tool.c ${test-tool_SOURCES})
 target_link_libraries(test-tool common-main)
 
-- 
2.33.1.1570.g069344fdd45

