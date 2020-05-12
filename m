Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73867C2D0F6
	for <git@archiver.kernel.org>; Tue, 12 May 2020 16:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C0E7206B9
	for <git@archiver.kernel.org>; Tue, 12 May 2020 16:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MypHufB3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbgELQvM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 12:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728754AbgELQvH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 12:51:07 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5265CC05BD0B
        for <git@vger.kernel.org>; Tue, 12 May 2020 09:51:06 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y16so9191637wrs.3
        for <git@vger.kernel.org>; Tue, 12 May 2020 09:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Hp5yG9+CquHsWuYFgdMYdUyuDymbEde0E+KmMyLc9r8=;
        b=MypHufB37t9SxybSa2Phjt/iOsjTzaoFKCAbqvmYYRp+SWsuLnG15HToa9UZIfoifW
         16TrVEvxq5B8/plhoZqHDe/R6CtgRQY/EeRGCFTeQzflKFnDuJo4NccVkzqUJ5W9Ta15
         TaUU+0tAivrmAzNRE/f543Z4FaybdUqfZloMmJzJ+gIwOIlI2HWr5SJpdq9k5re369dM
         gqH34WD1hUylwAFDOhCHujqqER6ThFmbfTDokn7IHpen2KbOfviARcfQSdVtrnB2Xpvj
         9N/Xqpjc6Owhd6qjYALX6kQ8uHgiKLsyZp47xovISKg+Qlb6rorSACGACGBh2dukgp2b
         pmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Hp5yG9+CquHsWuYFgdMYdUyuDymbEde0E+KmMyLc9r8=;
        b=BiINjxLO5GmLemg/pGYoSv5HGClDNEX4gx6WpCU+fQPrIYRCt3FBeCMmOTwx3E43W/
         8vADFxTz83P3pY/o/j0ESUEk1iwyhHWaymBMFuyQ43KorZX86KYy9LCK9ZmUm2nbDmvP
         cLTNZ7d+rMLFmCYFo5tkER7HvJXoFwSAbAR5XtYN78IVMfRv2Hts67ET5jjeWoZ3HwUR
         i5b52EoJkNb43WCR67PlScFTnls/9oxXLwNv80BV6l86Zoy9Dk+Nj+WpbSO8BXGH0hUe
         3P8RvkKLAD8o+WVcmbfdFkeWGYHXywW7alHfypic8nMD4HtdgdhMmuKQASyQyquHN8Ac
         2M2A==
X-Gm-Message-State: AGi0Pub//OxjsR0REU99hM/AuLPm5op8aiaRPpbccqzUiruJ0ZgalGeN
        0unxtSVv42TJh29IURYnoxn4teEZ
X-Google-Smtp-Source: APiQypKMC6MgDYB6VTdf6QQMlYY/11rFGyhxHMCR2wvzGp1KJ5srwks5dC+ScEj2adCSXAXEdm56eg==
X-Received: by 2002:adf:aacb:: with SMTP id i11mr26121863wrc.6.1589302264612;
        Tue, 12 May 2020 09:51:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c83sm33940468wmd.23.2020.05.12.09.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 09:51:04 -0700 (PDT)
Message-Id: <b0a321a714a766962456e2a9e8dd7d2be349e34d.1589302255.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
        <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
From:   "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 May 2020 16:50:53 +0000
Subject: [PATCH v2 10/11] cmake: parse the makefile for the sources.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>

The CMake script parses the Makefile for:
SCRIPT_SH
SCRIPT_PERL
TEST_BUILTINS_OBJS
LIB_OBJS
BUILTIN_OBJS
XDIFF_OBJS
VCSSVN_OBJS

By doing this we avoid duplication of text between the Makefile and
the CMake script.

Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 137 ++++++----------------------
 1 file changed, 30 insertions(+), 107 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index e0ce069dc2a..4592ce614cf 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -21,6 +21,25 @@ project(git
 #TODO Enable NLS on windows natively
 #TODO Add pcre support
 
+#macros for parsing the Makefile for sources and scripts
+macro(parse_makefile_for_sources list_var regex)
+	file(STRINGS ${CMAKE_SOURCE_DIR}/Makefile ${list_var} REGEX "^${regex} \\+=(.*)")
+	string(REPLACE "${regex} +=" "" ${list_var} ${${list_var}})
+	string(REPLACE "$(COMPAT_OBJS)" "" ${list_var} ${${list_var}}) #remove "$(COMPAT_OBJS)" This is only for libgit.
+	string(STRIP ${${list_var}} ${list_var}) #remove trailing/leading whitespaces
+	string(REPLACE ".o" ".c;" ${list_var} ${${list_var}}) #change .o to .c, ; is for converting the string into a list
+	list(TRANSFORM ${list_var} STRIP) #remove trailing/leading whitespaces for each element in list
+	list(REMOVE_ITEM ${list_var} "") #remove empty list elements
+endmacro()
+
+macro(parse_makefile_for_scripts list_var regex lang)
+	file(STRINGS ${CMAKE_SOURCE_DIR}/Makefile ${list_var} REGEX "^${regex} \\+=(.*)")
+	string(REPLACE "${regex} +=" "" ${list_var} ${${list_var}})
+	string(STRIP ${${list_var}} ${list_var}) #remove trailing/leading whitespaces
+	string(REPLACE " " ";" ${list_var} ${${list_var}}) #convert string to a list
+	list(TRANSFORM ${list_var} REPLACE "${lang}" "") #do the replacement
+endmacro()
+
 
 include(CheckTypeSize)
 include(CheckCSourceRuns)
@@ -489,57 +508,18 @@ include_directories(${CMAKE_BINARY_DIR})
 
 
 #build
-set(libgit_SOURCES
-	abspath.c add-interactive.c add-patch.c advice.c alias.c
-	alloc.c apply.c archive.c archive-tar.c archive-zip.c argv-array.c
-	attr.c base85.c bisect.c blame.c blob.c bloom.c branch.c bulk-checkin.c
-	bundle.c cache-tree.c chdir-notify.c checkout.c color.c column.c
-	combine-diff.c commit.c commit-graph.c commit-reach.c compat/obstack.c
-	compat/terminal.c config.c connect.c connected.c convert.c copy.c credential.c
-	csum-file.c ctype.c date.c decorate.c delta-islands.c diffcore-break.c
-	diffcore-delta.c diffcore-order.c diffcore-pickaxe.c diffcore-rename.c
-	diff-delta.c diff-lib.c diff-no-index.c diff.c dir.c dir-iterator.c editor.c
-	entry.c environment.c ewah/bitmap.c ewah/ewah_bitmap.c ewah/ewah_io.c
-	ewah/ewah_rlw.c exec-cmd.c fetch-negotiator.c fetch-pack.c fmt-merge-msg.c fsck.c fsmonitor.c
-	gettext.c gpg-interface.c graph.c grep.c hashmap.c linear-assignment.c help.c hex.c
-	ident.c interdiff.c json-writer.c kwset.c levenshtein.c line-log.c line-range.c list-objects.c
-	list-objects-filter.c list-objects-filter-options.c ll-merge.c lockfile.c
-	log-tree.c ls-refs.c mailinfo.c mailmap.c match-trees.c mem-pool.c merge.c merge-blobs.c
-	merge-recursive.c mergesort.c midx.c name-hash.c negotiator/default.c
-	negotiator/skipping.c notes.c notes-cache.c notes-merge.c notes-utils.c object.c oidmap.c
-	oidset.c oid-array.c packfile.c pack-bitmap.c pack-bitmap-write.c pack-check.c pack-objects.c
-	pack-revindex.c pack-write.c pager.c parse-options.c parse-options-cb.c patch-delta.c
-	patch-ids.c path.c pathspec.c pkt-line.c preload-index.c pretty.c prio-queue.c progress.c
-	promisor-remote.c prompt.c protocol.c prune-packed.c quote.c range-diff.c reachable.c read-cache.c rebase.c
-	rebase-interactive.c reflog-walk.c refs.c refs/files-backend.c refs/iterator.c
-	refs/packed-backend.c refs/ref-cache.c refspec.c ref-filter.c remote.c replace-object.c
-	repo-settings.c repository.c rerere.c reset.c resolve-undo.c revision.c run-command.c
-	send-pack.c sequencer.c serve.c server-info.c setup.c sha1-lookup.c
-	sha1-file.c sha1-name.c shallow.c sideband.c sigchain.c split-index.c
-	stable-qsort.c strbuf.c streaming.c string-list.c submodule.c submodule-config.c
-	sub-process.c symlinks.c tag.c tempfile.c thread-utils.c tmp-objdir.c
-	trace.c trace2.c trace2/tr2_cfg.c trace2/tr2_cmd_name.c trace2/tr2_dst.c
-	trace2/tr2_sid.c trace2/tr2_sysenv.c trace2/tr2_tbuf.c trace2/tr2_tgt_event.c
-	trace2/tr2_tgt_normal.c trace2/tr2_tgt_perf.c trace2/tr2_tls.c trailer.c transport.c
-	transport-helper.c tree-diff.c tree.c tree-walk.c unpack-trees.c upload-pack.c url.c
-	urlmatch.c usage.c userdiff.c utf8.c varint.c version.c versioncmp.c walker.c wildmatch.c
-	worktree.c wrapper.c write-or-die.c ws.c wt-status.c xdiff-interface.c
-	zlib.c)
+parse_makefile_for_sources(libgit_SOURCES "LIB_OBJS")
 
 list(TRANSFORM libgit_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
 list(TRANSFORM compat_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
 add_library(libgit ${libgit_SOURCES} ${compat_SOURCES})
 
-set(libxdiff_SOURCES
-	xdiff/xdiffi.c xdiff/xprepare.c xdiff/xutils.c xdiff/xemit.c
-	xdiff/xmerge.c xdiff/xpatience.c xdiff/xhistogram.c)
+parse_makefile_for_sources(libxdiff_SOURCES "XDIFF_OBJS")
 
 list(TRANSFORM libxdiff_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
 add_library(xdiff STATIC ${libxdiff_SOURCES})
 
-set(libvcs-svn_SOURCES
-	vcs-svn/line_buffer.c vcs-svn/sliding_window.c vcs-svn/fast_export.c
-	vcs-svn/svndiff.c vcs-svn/svndump.c)
+parse_makefile_for_sources(libvcs-svn_SOURCES "VCSSVN_OBJS")
 
 list(TRANSFORM libvcs-svn_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
 add_library(vcs-svn STATIC ${libvcs-svn_SOURCES})
@@ -588,40 +568,7 @@ elseif(UNIX)
 endif()
 
 
-set(git_SOURCES
-	builtin/add.c builtin/am.c builtin/annotate.c builtin/apply.c
-	builtin/archive.c builtin/bisect--helper.c builtin/blame.c
-	builtin/branch.c builtin/bundle.c builtin/cat-file.c builtin/check-attr.c
-	builtin/check-ignore.c builtin/check-mailmap.c builtin/check-ref-format.c
-	builtin/checkout-index.c builtin/checkout.c builtin/clean.c
-	builtin/clone.c builtin/column.c builtin/commit-tree.c
-	builtin/commit.c builtin/commit-graph.c builtin/config.c
-	builtin/count-objects.c builtin/credential.c builtin/describe.c
-	builtin/diff-files.c builtin/diff-index.c builtin/diff-tree.c
-	builtin/diff.c builtin/difftool.c builtin/env--helper.c
-	builtin/fast-export.c builtin/fetch-pack.c builtin/fetch.c builtin/fmt-merge-msg.c
-	builtin/for-each-ref.c builtin/fsck.c builtin/gc.c
-	builtin/get-tar-commit-id.c builtin/grep.c builtin/hash-object.c
-	builtin/help.c builtin/index-pack.c builtin/init-db.c
-	builtin/interpret-trailers.c builtin/log.c builtin/ls-files.c
-	builtin/ls-remote.c builtin/ls-tree.c builtin/mailinfo.c builtin/mailsplit.c
-	builtin/merge.c builtin/merge-base.c builtin/merge-file.c builtin/merge-index.c
-	builtin/merge-ours.c builtin/merge-recursive.c builtin/merge-tree.c
-	builtin/mktag.c builtin/mktree.c builtin/multi-pack-index.c builtin/mv.c
-	builtin/name-rev.c builtin/notes.c builtin/pack-objects.c builtin/pack-redundant.c
-	builtin/pack-refs.c builtin/patch-id.c builtin/prune-packed.c builtin/prune.c
-	builtin/pull.c builtin/push.c builtin/range-diff.c builtin/read-tree.c
-	builtin/rebase.c builtin/receive-pack.c builtin/reflog.c builtin/remote.c
-	builtin/remote-ext.c builtin/remote-fd.c builtin/repack.c builtin/replace.c
-	builtin/rerere.c builtin/reset.c builtin/rev-list.c builtin/rev-parse.c
-	builtin/revert.c builtin/rm.c builtin/send-pack.c builtin/shortlog.c
-	builtin/show-branch.c builtin/show-index.c builtin/show-ref.c
-	builtin/sparse-checkout.c builtin/stash.c builtin/stripspace.c
-	builtin/submodule--helper.c builtin/symbolic-ref.c builtin/tag.c
-	builtin/unpack-file.c builtin/unpack-objects.c builtin/update-index.c
-	builtin/update-ref.c builtin/update-server-info.c builtin/upload-archive.c
-	builtin/upload-pack.c builtin/var.c builtin/verify-commit.c builtin/verify-pack.c
-	builtin/verify-tag.c builtin/worktree.c builtin/write-tree.c)
+parse_makefile_for_sources(git_SOURCES "BUILTIN_OBJS")
 
 list(TRANSFORM git_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
 add_executable(git ${CMAKE_SOURCE_DIR}/git.c ${git_SOURCES})
@@ -714,11 +661,9 @@ set(GITWEBDIR ${FALLBACK_RUNTIME_PREFIX}/share/locale)
 set(INSTLIBDIR ${FALLBACK_RUNTIME_PREFIX}/share/perl5)
 
 #shell scripts
+parse_makefile_for_scripts(git_sh_scripts "SCRIPT_SH" ".sh")
 set(git_shell_scripts
-	git-bisect git-difftool--helper git-filter-branch
-	git-merge-octopus git-merge-one-file git-merge-resolve
-	git-mergetool git-quiltimport
-	git-request-pull git-submodule git-web--browse
+	${git_sh_scripts}
 	git-mergetool--lib git-parse-remote git-rebase--preserve-merges
 	git-sh-setup git-sh-i18n git-instaweb)
 
@@ -738,9 +683,7 @@ foreach(script ${git_shell_scripts})
 endforeach()
 
 #perl scripts
-set(git_perl_scripts
-	git-add--interactive git-archimport git-cvsexportcommit
-	git-cvsimport git-cvsserver git-send-email git-svn)
+parse_makefile_for_scripts(git_perl_scripts "SCRIPT_PERL" ".perl")
 
 #create perl header
 file(STRINGS ${CMAKE_SOURCE_DIR}/perl/header_templates/fixed_prefix.template.pl perl_header )
@@ -865,30 +808,10 @@ target_link_libraries(test-line-buffer common-main vcs-svn)
 add_executable(test-svn-fe ${CMAKE_SOURCE_DIR}/t/helper/test-svn-fe.c)
 target_link_libraries(test-svn-fe common-main vcs-svn)
 
-set(test-tool_SOURCES
-	t/helper/test-tool.c t/helper/test-advise.c t/helper/test-bloom.c t/helper/test-chmtime.c
-	t/helper/test-config.c t/helper/test-ctype.c t/helper/test-date.c t/helper/test-delta.c
-	t/helper/test-dir-iterator.c t/helper/test-drop-caches.c t/helper/test-dump-cache-tree.c
-	t/helper/test-dump-fsmonitor.c t/helper/test-dump-split-index.c
-	t/helper/test-dump-untracked-cache.c t/helper/test-example-decorate.c
-	t/helper/test-genrandom.c t/helper/test-genzeros.c t/helper/test-hash.c
-	t/helper/test-hashmap.c t/helper/test-hash-speed.c t/helper/test-index-version.c
-	t/helper/test-json-writer.c t/helper/test-lazy-init-name-hash.c
-	t/helper/test-match-trees.c t/helper/test-mergesort.c t/helper/test-mktemp.c
-	t/helper/test-oidmap.c t/helper/test-online-cpus.c t/helper/test-parse-options.c
-	t/helper/test-parse-pathspec-file.c t/helper/test-path-utils.c t/helper/test-pkt-line.c
-	t/helper/test-prio-queue.c t/helper/test-progress.c t/helper/test-reach.c
-	t/helper/test-read-cache.c t/helper/test-read-graph.c t/helper/test-read-midx.c
-	t/helper/test-ref-store.c t/helper/test-regex.c t/helper/test-repository.c
-	t/helper/test-revision-walking.c t/helper/test-run-command.c t/helper/test-scrap-cache-tree.c
-	t/helper/test-serve-v2.c t/helper/test-sha1.c t/helper/test-oid-array.c t/helper/test-sha256.c
-	t/helper/test-sigchain.c t/helper/test-strcmp-offset.c t/helper/test-string-list.c
-	t/helper/test-submodule-config.c t/helper/test-submodule-nested-repo-config.c t/helper/test-subprocess.c
-	t/helper/test-trace2.c t/helper/test-urlmatch-normalization.c t/helper/test-xml-encode.c
-	t/helper/test-wildmatch.c t/helper/test-windows-named-pipe.c t/helper/test-write-cache.c)
-
-list(TRANSFORM test-tool_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
-add_executable(test-tool ${test-tool_SOURCES})
+parse_makefile_for_sources(test-tool_SOURCES "TEST_BUILTINS_OBJS")
+
+list(TRANSFORM test-tool_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/t/helper/")
+add_executable(test-tool ${CMAKE_SOURCE_DIR}/t/helper/test-tool.c ${test-tool_SOURCES})
 target_link_libraries(test-tool common-main)
 
 set_target_properties(test-fake-ssh test-line-buffer test-svn-fe test-tool
-- 
gitgitgadget

