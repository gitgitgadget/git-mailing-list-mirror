Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A3EC4332E
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 09:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6842070A
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 09:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cm1q1RdN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgCUJWN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 05:22:13 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:42379 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgCUJWM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 05:22:12 -0400
Received: by mail-qt1-f169.google.com with SMTP id t9so3334055qto.9
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 02:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IIIFPfowLgl0tpT5uGrEPCId2FDvfBDXtMs7UrAxmME=;
        b=Cm1q1RdNP34BwDZ25QnJLD/Sie4+V2WnoNpgPs2Au4seSTC/kcqHIDSb2G7OG3/Eq5
         KUHUXqB47qmgTJ9hW4aJAZbhbrMVGSD+G5SGEfrP7F/9fy2W+kEGO5to+IkUT3UrXsFw
         0a9Ea3LJMRCbJ91SonE2oRiTiCr8dstWVcF/h16IgMadYZnX4ja8Ay7U3t5fHavNdWmy
         VsFdfFrE9mxmkqupIYOwK5W7KrDDpP3fOFzYy3k5GNjhhJFcXO9tph4drjiOXpTaT2dF
         vkP97/MHgK8cN+IdsKU6ZCqYd7FyU1pZGCFQUPnEHz/JmsgyIUcHZwaNgdpk3LYDz8Qp
         73vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IIIFPfowLgl0tpT5uGrEPCId2FDvfBDXtMs7UrAxmME=;
        b=MBRPnRvLVtjMmrhxWeyIHxndSDQbz0E7h3mRTbwKjaBdTS4iGPHSSy26HqdV6sLL/V
         +HWpm7ahwkveAzkp0/1A1ht4wEmZtTW2OVLFGI2z9YyCXftztkcT43RRLtrtWPSe/Qla
         9SRbEZL34kQoA781bwqqxi3OfcJriCGIwNjwiAh5ej35E6vQwlk/xIbhqZ7tEGQt4Z0N
         z+S05b0ntuZrauTjAQ79GIF99h/7wUSR9voqqbqJgHuJ6zEI6AngytKfL878OHKqSltX
         auAw3gWggIY1Pa7BDKlSj+Me6Q9jG767pJPgsjKEQ8K+p+Jwgdzw3acPNztSr6Ct4KDk
         xPQw==
X-Gm-Message-State: ANhLgQ2jXQ0qSDdASD2aNeat5OfDZ1XGgjYuS2xof+WjPfgVQo0zWgWF
        5ED6MmGcfaEAkv9BqW6Sc1sjIrEf
X-Google-Smtp-Source: ADFU+vs7VA5fwUjXv82QYZB3JekifNcQ93GatTKcCcew7ivM3vGnIik5YmZ1ahbyXfAkfmEd+ylV9Q==
X-Received: by 2002:aed:3988:: with SMTP id m8mr12612273qte.9.1584782529480;
        Sat, 21 Mar 2020 02:22:09 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id z23sm6579890qkg.21.2020.03.21.02.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 02:22:09 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 01/19] Makefile: ASCII-sort += lists
Date:   Sat, 21 Mar 2020 05:21:20 -0400
Message-Id: <77506a39d04c838773757b189e1b409ce98d612e.1584782450.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.114.g5b0ca878e0
In-Reply-To: <cover.1584782450.git.liu.denton@gmail.com>
References: <cover.1577185374.git.liu.denton@gmail.com> <cover.1584782450.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are many += lists in the Makefile and, over time, they have gotten
slightly out of ASCII order. Sort all += lists to bring them back in
order.

ASCII sorting was chosen over strict alphabetical order even though, if
we omit file prefixes, the lists aren't sorted in strictly alphabetical
order (e.g. archive.o comes after archive-zip.o instead of before
archive-tar.o). This is intentional because the purpose of maintaining
the sorted list is to ensure line insertions are deterministic. By using
ASCII ordering, it is more easily mechanically reproducible in the
future, such as by using :sort in Vim.

This patch is best viewed with `--color-moved`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Makefile | 77 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 39 insertions(+), 38 deletions(-)

diff --git a/Makefile b/Makefile
index 9804a0758b..f709fc3f77 100644
--- a/Makefile
+++ b/Makefile
@@ -604,12 +604,12 @@ unexport CDPATH
 SCRIPT_SH += git-bisect.sh
 SCRIPT_SH += git-difftool--helper.sh
 SCRIPT_SH += git-filter-branch.sh
+SCRIPT_SH += git-legacy-stash.sh
 SCRIPT_SH += git-merge-octopus.sh
 SCRIPT_SH += git-merge-one-file.sh
 SCRIPT_SH += git-merge-resolve.sh
 SCRIPT_SH += git-mergetool.sh
 SCRIPT_SH += git-quiltimport.sh
-SCRIPT_SH += git-legacy-stash.sh
 SCRIPT_SH += git-request-pull.sh
 SCRIPT_SH += git-submodule.sh
 SCRIPT_SH += git-web--browse.sh
@@ -617,8 +617,8 @@ SCRIPT_SH += git-web--browse.sh
 SCRIPT_LIB += git-mergetool--lib
 SCRIPT_LIB += git-parse-remote
 SCRIPT_LIB += git-rebase--preserve-merges
-SCRIPT_LIB += git-sh-setup
 SCRIPT_LIB += git-sh-i18n
+SCRIPT_LIB += git-sh-setup
 
 SCRIPT_PERL += git-add--interactive.perl
 SCRIPT_PERL += git-archimport.perl
@@ -686,9 +686,9 @@ PROGRAM_OBJS += daemon.o
 PROGRAM_OBJS += fast-import.o
 PROGRAM_OBJS += http-backend.o
 PROGRAM_OBJS += imap-send.o
+PROGRAM_OBJS += remote-testsvn.o
 PROGRAM_OBJS += sh-i18n--envsubst.o
 PROGRAM_OBJS += shell.o
-PROGRAM_OBJS += remote-testsvn.o
 
 # Binary suffix, set to .exe for Windows builds
 X =
@@ -709,9 +709,9 @@ TEST_BUILTINS_OBJS += test-dump-untracked-cache.o
 TEST_BUILTINS_OBJS += test-example-decorate.o
 TEST_BUILTINS_OBJS += test-genrandom.o
 TEST_BUILTINS_OBJS += test-genzeros.o
+TEST_BUILTINS_OBJS += test-hash-speed.o
 TEST_BUILTINS_OBJS += test-hash.o
 TEST_BUILTINS_OBJS += test-hashmap.o
-TEST_BUILTINS_OBJS += test-hash-speed.o
 TEST_BUILTINS_OBJS += test-index-version.o
 TEST_BUILTINS_OBJS += test-json-writer.o
 TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
@@ -737,8 +737,8 @@ TEST_BUILTINS_OBJS += test-revision-walking.o
 TEST_BUILTINS_OBJS += test-run-command.o
 TEST_BUILTINS_OBJS += test-scrap-cache-tree.o
 TEST_BUILTINS_OBJS += test-serve-v2.o
-TEST_BUILTINS_OBJS += test-sha1.o
 TEST_BUILTINS_OBJS += test-sha1-array.o
+TEST_BUILTINS_OBJS += test-sha1.o
 TEST_BUILTINS_OBJS += test-sha256.o
 TEST_BUILTINS_OBJS += test-sigchain.o
 TEST_BUILTINS_OBJS += test-strcmp-offset.o
@@ -748,10 +748,10 @@ TEST_BUILTINS_OBJS += test-submodule-nested-repo-config.o
 TEST_BUILTINS_OBJS += test-subprocess.o
 TEST_BUILTINS_OBJS += test-trace2.o
 TEST_BUILTINS_OBJS += test-urlmatch-normalization.o
-TEST_BUILTINS_OBJS += test-xml-encode.o
 TEST_BUILTINS_OBJS += test-wildmatch.o
 TEST_BUILTINS_OBJS += test-windows-named-pipe.o
 TEST_BUILTINS_OBJS += test-write-cache.o
+TEST_BUILTINS_OBJS += test-xml-encode.o
 
 # Do not add more tests here unless they have extra dependencies. Add
 # them in TEST_BUILTINS_OBJS above.
@@ -788,10 +788,10 @@ OTHER_PROGRAMS = git$X
 
 # what test wrappers are needed and 'install' will install, in bindir
 BINDIR_PROGRAMS_NEED_X += git
-BINDIR_PROGRAMS_NEED_X += git-upload-pack
 BINDIR_PROGRAMS_NEED_X += git-receive-pack
-BINDIR_PROGRAMS_NEED_X += git-upload-archive
 BINDIR_PROGRAMS_NEED_X += git-shell
+BINDIR_PROGRAMS_NEED_X += git-upload-archive
+BINDIR_PROGRAMS_NEED_X += git-upload-pack
 
 BINDIR_PROGRAMS_NO_X += git-cvsserver
 
@@ -831,9 +831,9 @@ LIB_OBJS += advice.o
 LIB_OBJS += alias.o
 LIB_OBJS += alloc.o
 LIB_OBJS += apply.o
-LIB_OBJS += archive.o
 LIB_OBJS += archive-tar.o
 LIB_OBJS += archive-zip.o
+LIB_OBJS += archive.o
 LIB_OBJS += argv-array.o
 LIB_OBJS += attr.o
 LIB_OBJS += base85.o
@@ -849,9 +849,9 @@ LIB_OBJS += checkout.o
 LIB_OBJS += color.o
 LIB_OBJS += column.o
 LIB_OBJS += combine-diff.o
-LIB_OBJS += commit.o
 LIB_OBJS += commit-graph.o
 LIB_OBJS += commit-reach.o
+LIB_OBJS += commit.o
 LIB_OBJS += compat/obstack.o
 LIB_OBJS += compat/terminal.o
 LIB_OBJS += config.o
@@ -865,17 +865,17 @@ LIB_OBJS += ctype.o
 LIB_OBJS += date.o
 LIB_OBJS += decorate.o
 LIB_OBJS += delta-islands.o
+LIB_OBJS += diff-delta.o
+LIB_OBJS += diff-lib.o
+LIB_OBJS += diff-no-index.o
+LIB_OBJS += diff.o
 LIB_OBJS += diffcore-break.o
 LIB_OBJS += diffcore-delta.o
 LIB_OBJS += diffcore-order.o
 LIB_OBJS += diffcore-pickaxe.o
 LIB_OBJS += diffcore-rename.o
-LIB_OBJS += diff-delta.o
-LIB_OBJS += diff-lib.o
-LIB_OBJS += diff-no-index.o
-LIB_OBJS += diff.o
-LIB_OBJS += dir.o
 LIB_OBJS += dir-iterator.o
+LIB_OBJS += dir.o
 LIB_OBJS += editor.o
 LIB_OBJS += entry.o
 LIB_OBJS += environment.o
@@ -893,7 +893,6 @@ LIB_OBJS += gpg-interface.o
 LIB_OBJS += graph.o
 LIB_OBJS += grep.o
 LIB_OBJS += hashmap.o
-LIB_OBJS += linear-assignment.o
 LIB_OBJS += help.o
 LIB_OBJS += hex.o
 LIB_OBJS += ident.o
@@ -903,9 +902,10 @@ LIB_OBJS += kwset.o
 LIB_OBJS += levenshtein.o
 LIB_OBJS += line-log.o
 LIB_OBJS += line-range.o
-LIB_OBJS += list-objects.o
-LIB_OBJS += list-objects-filter.o
+LIB_OBJS += linear-assignment.o
 LIB_OBJS += list-objects-filter-options.o
+LIB_OBJS += list-objects-filter.o
+LIB_OBJS += list-objects.o
 LIB_OBJS += ll-merge.o
 LIB_OBJS += lockfile.o
 LIB_OBJS += log-tree.o
@@ -914,31 +914,31 @@ LIB_OBJS += mailinfo.o
 LIB_OBJS += mailmap.o
 LIB_OBJS += match-trees.o
 LIB_OBJS += mem-pool.o
-LIB_OBJS += merge.o
 LIB_OBJS += merge-blobs.o
 LIB_OBJS += merge-recursive.o
+LIB_OBJS += merge.o
 LIB_OBJS += mergesort.o
 LIB_OBJS += midx.o
 LIB_OBJS += name-hash.o
 LIB_OBJS += negotiator/default.o
 LIB_OBJS += negotiator/skipping.o
-LIB_OBJS += notes.o
 LIB_OBJS += notes-cache.o
 LIB_OBJS += notes-merge.o
 LIB_OBJS += notes-utils.o
+LIB_OBJS += notes.o
 LIB_OBJS += object.o
 LIB_OBJS += oidmap.o
 LIB_OBJS += oidset.o
-LIB_OBJS += packfile.o
-LIB_OBJS += pack-bitmap.o
 LIB_OBJS += pack-bitmap-write.o
+LIB_OBJS += pack-bitmap.o
 LIB_OBJS += pack-check.o
 LIB_OBJS += pack-objects.o
 LIB_OBJS += pack-revindex.o
 LIB_OBJS += pack-write.o
+LIB_OBJS += packfile.o
 LIB_OBJS += pager.o
-LIB_OBJS += parse-options.o
 LIB_OBJS += parse-options-cb.o
+LIB_OBJS += parse-options.o
 LIB_OBJS += patch-delta.o
 LIB_OBJS += patch-ids.o
 LIB_OBJS += path.o
@@ -955,8 +955,9 @@ LIB_OBJS += quote.o
 LIB_OBJS += range-diff.o
 LIB_OBJS += reachable.o
 LIB_OBJS += read-cache.o
-LIB_OBJS += rebase.o
 LIB_OBJS += rebase-interactive.o
+LIB_OBJS += rebase.o
+LIB_OBJS += ref-filter.o
 LIB_OBJS += reflog-walk.o
 LIB_OBJS += refs.o
 LIB_OBJS += refs/files-backend.o
@@ -964,7 +965,6 @@ LIB_OBJS += refs/iterator.o
 LIB_OBJS += refs/packed-backend.o
 LIB_OBJS += refs/ref-cache.o
 LIB_OBJS += refspec.o
-LIB_OBJS += ref-filter.o
 LIB_OBJS += remote.o
 LIB_OBJS += replace-object.o
 LIB_OBJS += repo-settings.o
@@ -979,8 +979,8 @@ LIB_OBJS += serve.o
 LIB_OBJS += server-info.o
 LIB_OBJS += setup.o
 LIB_OBJS += sha1-array.o
-LIB_OBJS += sha1-lookup.o
 LIB_OBJS += sha1-file.o
+LIB_OBJS += sha1-lookup.o
 LIB_OBJS += sha1-name.o
 LIB_OBJS += shallow.o
 LIB_OBJS += sideband.o
@@ -990,9 +990,9 @@ LIB_OBJS += stable-qsort.o
 LIB_OBJS += strbuf.o
 LIB_OBJS += streaming.o
 LIB_OBJS += string-list.o
-LIB_OBJS += submodule.o
-LIB_OBJS += submodule-config.o
 LIB_OBJS += sub-process.o
+LIB_OBJS += submodule-config.o
+LIB_OBJS += submodule.o
 LIB_OBJS += symlinks.o
 LIB_OBJS += tag.o
 LIB_OBJS += tempfile.o
@@ -1011,11 +1011,11 @@ LIB_OBJS += trace2/tr2_tgt_normal.o
 LIB_OBJS += trace2/tr2_tgt_perf.o
 LIB_OBJS += trace2/tr2_tls.o
 LIB_OBJS += trailer.o
-LIB_OBJS += transport.o
 LIB_OBJS += transport-helper.o
+LIB_OBJS += transport.o
 LIB_OBJS += tree-diff.o
-LIB_OBJS += tree.o
 LIB_OBJS += tree-walk.o
+LIB_OBJS += tree.o
 LIB_OBJS += unpack-trees.o
 LIB_OBJS += upload-pack.o
 LIB_OBJS += url.o
@@ -1055,9 +1055,9 @@ BUILTIN_OBJS += builtin/checkout.o
 BUILTIN_OBJS += builtin/clean.o
 BUILTIN_OBJS += builtin/clone.o
 BUILTIN_OBJS += builtin/column.o
+BUILTIN_OBJS += builtin/commit-graph.o
 BUILTIN_OBJS += builtin/commit-tree.o
 BUILTIN_OBJS += builtin/commit.o
-BUILTIN_OBJS += builtin/commit-graph.o
 BUILTIN_OBJS += builtin/config.o
 BUILTIN_OBJS += builtin/count-objects.o
 BUILTIN_OBJS += builtin/credential.o
@@ -1088,13 +1088,13 @@ BUILTIN_OBJS += builtin/ls-remote.o
 BUILTIN_OBJS += builtin/ls-tree.o
 BUILTIN_OBJS += builtin/mailinfo.o
 BUILTIN_OBJS += builtin/mailsplit.o
-BUILTIN_OBJS += builtin/merge.o
 BUILTIN_OBJS += builtin/merge-base.o
 BUILTIN_OBJS += builtin/merge-file.o
 BUILTIN_OBJS += builtin/merge-index.o
 BUILTIN_OBJS += builtin/merge-ours.o
 BUILTIN_OBJS += builtin/merge-recursive.o
 BUILTIN_OBJS += builtin/merge-tree.o
+BUILTIN_OBJS += builtin/merge.o
 BUILTIN_OBJS += builtin/mktag.o
 BUILTIN_OBJS += builtin/mktree.o
 BUILTIN_OBJS += builtin/multi-pack-index.o
@@ -1114,9 +1114,9 @@ BUILTIN_OBJS += builtin/read-tree.o
 BUILTIN_OBJS += builtin/rebase.o
 BUILTIN_OBJS += builtin/receive-pack.o
 BUILTIN_OBJS += builtin/reflog.o
-BUILTIN_OBJS += builtin/remote.o
 BUILTIN_OBJS += builtin/remote-ext.o
 BUILTIN_OBJS += builtin/remote-fd.o
+BUILTIN_OBJS += builtin/remote.o
 BUILTIN_OBJS += builtin/repack.o
 BUILTIN_OBJS += builtin/replace.o
 BUILTIN_OBJS += builtin/rerere.o
@@ -2335,16 +2335,16 @@ reconfigure config.mak.autogen: config.status
 endif
 
 XDIFF_OBJS += xdiff/xdiffi.o
-XDIFF_OBJS += xdiff/xprepare.o
-XDIFF_OBJS += xdiff/xutils.o
 XDIFF_OBJS += xdiff/xemit.o
+XDIFF_OBJS += xdiff/xhistogram.o
 XDIFF_OBJS += xdiff/xmerge.o
 XDIFF_OBJS += xdiff/xpatience.o
-XDIFF_OBJS += xdiff/xhistogram.o
+XDIFF_OBJS += xdiff/xprepare.o
+XDIFF_OBJS += xdiff/xutils.o
 
+VCSSVN_OBJS += vcs-svn/fast_export.o
 VCSSVN_OBJS += vcs-svn/line_buffer.o
 VCSSVN_OBJS += vcs-svn/sliding_window.o
-VCSSVN_OBJS += vcs-svn/fast_export.o
 VCSSVN_OBJS += vcs-svn/svndiff.o
 VCSSVN_OBJS += vcs-svn/svndump.o
 
@@ -3152,9 +3152,10 @@ endif
 #
 ALL_COMMANDS = $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS)
 ALL_COMMANDS += git
+ALL_COMMANDS += git-citool
+ALL_COMMANDS += git-gui
 ALL_COMMANDS += gitk
 ALL_COMMANDS += gitweb
-ALL_COMMANDS += git-gui git-citool
 
 .PHONY: check-docs
 check-docs::
-- 
2.25.0.114.g5b0ca878e0

