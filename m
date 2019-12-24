Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752DCC2D0D0
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 11:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3214220643
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 11:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o8ut4gB3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfLXLFt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 06:05:49 -0500
Received: from mail-qt1-f176.google.com ([209.85.160.176]:42248 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfLXLFt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 06:05:49 -0500
Received: by mail-qt1-f176.google.com with SMTP id j5so17851294qtq.9
        for <git@vger.kernel.org>; Tue, 24 Dec 2019 03:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E2jOqMPrWzDQF0yutufREOmEJCTOvkNbo/0lRKaFUjg=;
        b=o8ut4gB3LAfdyfYvTTp2gFnvW6xALybppSv4up0D4m7OQGAVsOeBGmsRNdStyQdXRy
         awhb8GvgnQJXPVxlwPHyHj0BLSp0nxOi/IE96+zF2IKxUZJ6FdbMCB4fNCLsnZb/d0aR
         jPznaopiQjbj253J1Os8u13EZk0XgTIQPjOl0GKkRYrKOge0CBBYZJx+cZsseLw9bo1C
         yxv6VTKScF0pHI9HNyRzdoRqeFIySFHvqi6uchdxR/1+vDdhR70o8FlrOW81b4K8b93t
         KviTS/mmTzzyjcT9m+RdyUl/+Gam9hr18kaM8rdmH3mW2uoQXB2g3LzRkrr08aKFrB48
         dpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E2jOqMPrWzDQF0yutufREOmEJCTOvkNbo/0lRKaFUjg=;
        b=UkpTEn9CEzPgWBnosUDCI29I7YPtmbyouS6jtXXNjSDBqxZAQCvU1p9bUJkhlIcpMa
         sJ9kFRhjVIGmXbmf7c/YphotjhxOt1f+TWGbIZ7kg/raKbRAWiUMADVs5Sshh1DMY1uO
         Tl04urGuudFhRAiHv6ujvuYOEKgdYbPTxw8MptXxv1jtNw7AntSDR3a6MXsIkyIkkJJM
         ZwJJh6Y4YEB4ueGVkXSFpMRXFZjhcOypbsRX+kmgpbJXuIzZI/4/IQicFLcXs0Wf54Ko
         m3nDLtsMn4rCe6OBo0QtbtClmCsW0rvzJ2pygNEJCCxDpZm4ZRzbV6NMFNASxMSkzYzQ
         prYQ==
X-Gm-Message-State: APjAAAVACZHeGpUUJnkeA2iJ7EalzZOrPidR/OKCvXAroux7N/u/spuI
        p+YAu+4ABfqhfCye0DwNV3msOSK8
X-Google-Smtp-Source: APXvYqyTBnDEns7idA/snanmiXBaxkqRH5+9wsulYWA2WCkbtVgepWluQTHc4w2vioz0QnjrIKtKyQ==
X-Received: by 2002:ac8:684:: with SMTP id f4mr5116158qth.184.1577185547661;
        Tue, 24 Dec 2019 03:05:47 -0800 (PST)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id o19sm7446944qtb.43.2019.12.24.03.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 03:05:47 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 01/17] Makefile: alphabetically sort += lists
Date:   Tue, 24 Dec 2019 06:04:58 -0500
Message-Id: <31055cdac4a5bfc48cf6f18179f4e9bce9a04c8c.1577185374.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.810.g65a2f617f4
In-Reply-To: <cover.1577185374.git.liu.denton@gmail.com>
References: <cover.1571246693.git.liu.denton@gmail.com> <cover.1577185374.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are many += lists in the Makefile and, over time, they have gotten
slightly out of order, alphabetically. Alphabetically sort all += lists
to bring them back in order.

Note that if we omit file prefixes, the lists aren't sorted in strictly
alphabetical order (e.g. archive.o comes after archive-zip.o instead of
before archive-tar.o). This is intentional because the purpose of
maintaining the sorted list is to ensure line insertions are
deterministic. As a result, we want to ensure that anybody can easily
reproduce the sort order and that is very simple when we don't have to
treat the prefix specially.

This patch is best viewed with `--color-moved`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Makefile | 75 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 38 insertions(+), 37 deletions(-)

diff --git a/Makefile b/Makefile
index 42a061d3fb..de149947f6 100644
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
@@ -736,8 +736,8 @@ TEST_BUILTINS_OBJS += test-revision-walking.o
 TEST_BUILTINS_OBJS += test-run-command.o
 TEST_BUILTINS_OBJS += test-scrap-cache-tree.o
 TEST_BUILTINS_OBJS += test-serve-v2.o
-TEST_BUILTINS_OBJS += test-sha1.o
 TEST_BUILTINS_OBJS += test-sha1-array.o
+TEST_BUILTINS_OBJS += test-sha1.o
 TEST_BUILTINS_OBJS += test-sha256.o
 TEST_BUILTINS_OBJS += test-sigchain.o
 TEST_BUILTINS_OBJS += test-strcmp-offset.o
@@ -747,10 +747,10 @@ TEST_BUILTINS_OBJS += test-submodule-nested-repo-config.o
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
@@ -787,10 +787,10 @@ OTHER_PROGRAMS = git$X
 
 # what test wrappers are needed and 'install' will install, in bindir
 BINDIR_PROGRAMS_NEED_X += git
-BINDIR_PROGRAMS_NEED_X += git-upload-pack
 BINDIR_PROGRAMS_NEED_X += git-receive-pack
-BINDIR_PROGRAMS_NEED_X += git-upload-archive
 BINDIR_PROGRAMS_NEED_X += git-shell
+BINDIR_PROGRAMS_NEED_X += git-upload-archive
+BINDIR_PROGRAMS_NEED_X += git-upload-pack
 
 BINDIR_PROGRAMS_NO_X += git-cvsserver
 
@@ -829,9 +829,9 @@ LIB_OBJS += advice.o
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
@@ -847,9 +847,9 @@ LIB_OBJS += checkout.o
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
@@ -863,17 +863,17 @@ LIB_OBJS += ctype.o
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
@@ -891,7 +891,6 @@ LIB_OBJS += gpg-interface.o
 LIB_OBJS += graph.o
 LIB_OBJS += grep.o
 LIB_OBJS += hashmap.o
-LIB_OBJS += linear-assignment.o
 LIB_OBJS += help.o
 LIB_OBJS += hex.o
 LIB_OBJS += ident.o
@@ -901,9 +900,10 @@ LIB_OBJS += kwset.o
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
@@ -912,31 +912,31 @@ LIB_OBJS += mailinfo.o
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
@@ -954,6 +954,7 @@ LIB_OBJS += range-diff.o
 LIB_OBJS += reachable.o
 LIB_OBJS += read-cache.o
 LIB_OBJS += rebase-interactive.o
+LIB_OBJS += ref-filter.o
 LIB_OBJS += reflog-walk.o
 LIB_OBJS += refs.o
 LIB_OBJS += refs/files-backend.o
@@ -961,7 +962,6 @@ LIB_OBJS += refs/iterator.o
 LIB_OBJS += refs/packed-backend.o
 LIB_OBJS += refs/ref-cache.o
 LIB_OBJS += refspec.o
-LIB_OBJS += ref-filter.o
 LIB_OBJS += remote.o
 LIB_OBJS += replace-object.o
 LIB_OBJS += repo-settings.o
@@ -976,8 +976,8 @@ LIB_OBJS += serve.o
 LIB_OBJS += server-info.o
 LIB_OBJS += setup.o
 LIB_OBJS += sha1-array.o
-LIB_OBJS += sha1-lookup.o
 LIB_OBJS += sha1-file.o
+LIB_OBJS += sha1-lookup.o
 LIB_OBJS += sha1-name.o
 LIB_OBJS += shallow.o
 LIB_OBJS += sideband.o
@@ -987,9 +987,9 @@ LIB_OBJS += stable-qsort.o
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
@@ -1008,11 +1008,11 @@ LIB_OBJS += trace2/tr2_tgt_normal.o
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
@@ -1052,9 +1052,9 @@ BUILTIN_OBJS += builtin/checkout.o
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
@@ -1085,13 +1085,13 @@ BUILTIN_OBJS += builtin/ls-remote.o
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
@@ -1111,9 +1111,9 @@ BUILTIN_OBJS += builtin/read-tree.o
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
@@ -2328,16 +2328,16 @@ reconfigure config.mak.autogen: config.status
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
 
@@ -3146,9 +3146,10 @@ endif
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
2.24.1.810.g65a2f617f4

