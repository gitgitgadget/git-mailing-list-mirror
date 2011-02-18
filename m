From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/3] Move header files into a include/ subdirectory
Date: Thu, 17 Feb 2011 20:37:50 -0600
Message-ID: <20110218023750.GD23435@elie>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org>
 <1297304069-14764-1-git-send-email-pclouds@gmail.com>
 <20110218022701.GA23435@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 03:38:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqGEL-0002dh-V1
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 03:38:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752910Ab1BRCh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 21:37:57 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:55508 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871Ab1BRCh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 21:37:56 -0500
Received: by qwd7 with SMTP id 7so22965qwd.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 18:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ua0uPPNr2pvdZjdHYHCfKmI3/Y+zGlgJy9U5TCzCZRs=;
        b=jSy+yYL7z5kSu0psjcLM4xnkBLeIUwWUXYdEGm2AJWsfNzUHVXZddMpL87oGKolyiO
         FAl0OdCn7kZ70MbK38H6u6AmeaTDGJqlWZjeSbbxkx7ODlMwQr1eNyycKd6AxRM8psc6
         /nTIguNtz7gMId/BeEd4P4k2tQFq/tYdSO558=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GnqxTnB+Zr718odvPkIjABo6Del+nVRupNIfJ3NpHVquF3Al4lswVOjHFx615tLXZl
         o+fKkSyrrYdltb20T4cwrmb9vTtlMVZBIbcQPTEmHCSCG9LEYkKPkBYGlQHzpnsoMQbH
         qWdKcV0NwEnJB3F8iM6Q2ellSlJWUepyznywQ=
Received: by 10.224.73.200 with SMTP id r8mr140603qaj.137.1297996675129;
        Thu, 17 Feb 2011 18:37:55 -0800 (PST)
Received: from elie (adsl-69-209-72-148.dsl.chcgil.sbcglobal.net [69.209.72.148])
        by mx.google.com with ESMTPS id g28sm1205040qck.37.2011.02.17.18.37.53
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Feb 2011 18:37:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110218022701.GA23435@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167157>

Move most of git's header files to an include/ subdirectory.
This leaves us with 71 fewer files in the toplevel directory,
making the high-level structure of the codebase a little easier
to see.

Three headers stay behind, at least for now: git-compat-util.h,
strbuf.h, and cache.h are referred to by some system-specific code
(in compat/) using paths starting with "..".  Making these three core
headers especially visible doesn't seem like a bad idea, anyway.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile                                       |  146 ++++++++++++------------
 advice.h => include/advice.h                   |    0
 [ etc etc ]
 72 files changed, 73 insertions(+), 73 deletions(-)

diff --git a/Makefile b/Makefile
index f458f65..1e96504 100644
--- a/Makefile
+++ b/Makefile
@@ -333,7 +333,7 @@ SPARSE_FLAGS = -D__BIG_ENDIAN__ -D__powerpc__
 # Those must not be GNU-specific; they are shared with perl/ which may
 # be built by a different compiler. (Note that this is an artifact now
 # but it still might be nice to keep that distinction.)
-BASIC_CFLAGS = -I.
+BASIC_CFLAGS = -I. -Iinclude
 BASIC_LDFLAGS =
 
 # Guard against environment variables
@@ -491,15 +491,15 @@ LIB_FILE=libgit.a
 XDIFF_LIB=xdiff/lib.a
 VCSSVN_LIB=vcs-svn/lib.a
 
-LIB_H += advice.h
-LIB_H += archive.h
-LIB_H += attr.h
-LIB_H += blob.h
-LIB_H += builtin.h
+LIB_H += include/advice.h
+LIB_H += include/archive.h
+LIB_H += include/attr.h
+LIB_H += include/blob.h
+LIB_H += include/builtin.h
 LIB_H += cache.h
-LIB_H += cache-tree.h
-LIB_H += color.h
-LIB_H += commit.h
+LIB_H += include/cache-tree.h
+LIB_H += include/color.h
+LIB_H += include/commit.h
 LIB_H += compat/bswap.h
 LIB_H += compat/cygwin.h
 LIB_H += compat/mingw.h
@@ -507,58 +507,58 @@ LIB_H += compat/win32/pthread.h
 LIB_H += compat/win32/syslog.h
 LIB_H += compat/win32/sys/poll.h
 LIB_H += compat/win32/dirent.h
-LIB_H += csum-file.h
-LIB_H += decorate.h
-LIB_H += delta.h
-LIB_H += diffcore.h
-LIB_H += diff.h
-LIB_H += dir.h
-LIB_H += exec_cmd.h
-LIB_H += fsck.h
+LIB_H += include/csum-file.h
+LIB_H += include/decorate.h
+LIB_H += include/delta.h
+LIB_H += include/diffcore.h
+LIB_H += include/diff.h
+LIB_H += include/dir.h
+LIB_H += include/exec_cmd.h
+LIB_H += include/fsck.h
 LIB_H += git-compat-util.h
-LIB_H += graph.h
-LIB_H += grep.h
-LIB_H += hash.h
-LIB_H += help.h
-LIB_H += levenshtein.h
-LIB_H += list-objects.h
-LIB_H += ll-merge.h
-LIB_H += log-tree.h
-LIB_H += mailmap.h
-LIB_H += merge-recursive.h
-LIB_H += notes.h
-LIB_H += notes-cache.h
-LIB_H += notes-merge.h
-LIB_H += object.h
-LIB_H += pack.h
-LIB_H += pack-refs.h
-LIB_H += pack-revindex.h
-LIB_H += parse-options.h
-LIB_H += patch-ids.h
-LIB_H += pkt-line.h
-LIB_H += progress.h
-LIB_H += quote.h
-LIB_H += reflog-walk.h
-LIB_H += refs.h
-LIB_H += remote.h
-LIB_H += rerere.h
-LIB_H += resolve-undo.h
-LIB_H += revision.h
-LIB_H += run-command.h
-LIB_H += sha1-lookup.h
-LIB_H += sideband.h
-LIB_H += sigchain.h
+LIB_H += include/graph.h
+LIB_H += include/grep.h
+LIB_H += include/hash.h
+LIB_H += include/help.h
+LIB_H += include/levenshtein.h
+LIB_H += include/list-objects.h
+LIB_H += include/ll-merge.h
+LIB_H += include/log-tree.h
+LIB_H += include/mailmap.h
+LIB_H += include/merge-recursive.h
+LIB_H += include/notes.h
+LIB_H += include/notes-cache.h
+LIB_H += include/notes-merge.h
+LIB_H += include/object.h
+LIB_H += include/pack.h
+LIB_H += include/pack-refs.h
+LIB_H += include/pack-revindex.h
+LIB_H += include/parse-options.h
+LIB_H += include/patch-ids.h
+LIB_H += include/pkt-line.h
+LIB_H += include/progress.h
+LIB_H += include/quote.h
+LIB_H += include/reflog-walk.h
+LIB_H += include/refs.h
+LIB_H += include/remote.h
+LIB_H += include/rerere.h
+LIB_H += include/resolve-undo.h
+LIB_H += include/revision.h
+LIB_H += include/run-command.h
+LIB_H += include/sha1-lookup.h
+LIB_H += include/sideband.h
+LIB_H += include/sigchain.h
 LIB_H += strbuf.h
-LIB_H += string-list.h
-LIB_H += submodule.h
-LIB_H += tag.h
-LIB_H += transport.h
-LIB_H += tree.h
-LIB_H += tree-walk.h
-LIB_H += unpack-trees.h
-LIB_H += userdiff.h
-LIB_H += utf8.h
-LIB_H += xdiff-interface.h
+LIB_H += include/string-list.h
+LIB_H += include/submodule.h
+LIB_H += include/tag.h
+LIB_H += include/transport.h
+LIB_H += include/tree.h
+LIB_H += include/tree-walk.h
+LIB_H += include/unpack-trees.h
+LIB_H += include/userdiff.h
+LIB_H += include/utf8.h
+LIB_H += include/xdiff-interface.h
 LIB_H += xdiff/xdiff.h
 
 LIB_OBJS += libgit/abspath.o
@@ -1949,20 +1949,20 @@ else
 # gcc detects!
 
 $(GIT_OBJS): $(LIB_H)
-builtin/branch.o builtin/checkout.o builtin/clone.o builtin/reset.o: branch.h
-libgit/branch.o libgit/transport.o: branch.h
-builtin/bundle.o libgit/bundle.o libgit/transport.o: bundle.h
-builtin/bisect--helper.o builtin/rev-list.o libgit/bisect.o: bisect.h
-builtin/clone.o builtin/fetch-pack.o libgit/transport.o: fetch-pack.h
-builtin/grep.o builtin/pack-objects.o libgit/transport-helper.o: thread-utils.h
-builtin/send-pack.o libgit/transport.o: send-pack.h
-builtin/log.o builtin/shortlog.o: shortlog.h
-builtin/prune.o builtin/reflog.o libgit/reachable.o: reachable.h
-builtin/commit.o builtin/revert.o libgit/wt-status.o: wt-status.h
-builtin/tar-tree.o libgit/archive-tar.o: tar.h
-libgit/connect.o libgit/transport.o http-backend.o: url.h
-http-fetch.o http-walker.o remote-curl.o libgit/transport.o libgit/walker.o: walker.h
-http.o http-walker.o http-push.o http-fetch.o remote-curl.o: http.h url.h
+builtin/branch.o builtin/checkout.o builtin/clone.o builtin/reset.o: include/branch.h
+libgit/branch.o libgit/transport.o: include/branch.h
+builtin/bundle.o libgit/bundle.o libgit/transport.o: include/bundle.h
+builtin/bisect--helper.o builtin/rev-list.o libgit/bisect.o: include/bisect.h
+builtin/clone.o builtin/fetch-pack.o libgit/transport.o: include/fetch-pack.h
+builtin/grep.o builtin/pack-objects.o libgit/transport-helper.o: include/thread-utils.h
+builtin/send-pack.o libgit/transport.o: include/send-pack.h
+builtin/log.o builtin/shortlog.o: include/shortlog.h
+builtin/prune.o builtin/reflog.o libgit/reachable.o: include/reachable.h
+builtin/commit.o builtin/revert.o libgit/wt-status.o: include/wt-status.h
+builtin/tar-tree.o libgit/archive-tar.o: include/tar.h
+libgit/connect.o libgit/transport.o http-backend.o: include/url.h
+http-fetch.o http-walker.o remote-curl.o libgit/transport.o libgit/walker.o: include/walker.h
+http.o http-walker.o http-push.o http-fetch.o remote-curl.o: include/http.h include/url.h
 
 libgit/xdiff-interface.o $(XDIFF_OBJS): \
 	xdiff/xinclude.h xdiff/xmacros.h xdiff/xdiff.h xdiff/xtypes.h \
diff --git a/advice.h b/include/advice.h
similarity index 100%
rename from advice.h
rename to include/advice.h
diff --git a/archive.h b/include/archive.h
similarity index 100%
rename from archive.h
rename to include/archive.h
diff --git a/attr.h b/include/attr.h
similarity index 100%
rename from attr.h
rename to include/attr.h
diff --git a/bisect.h b/include/bisect.h
similarity index 100%
rename from bisect.h
rename to include/bisect.h
diff --git a/blob.h b/include/blob.h
similarity index 100%
rename from blob.h
rename to include/blob.h
diff --git a/branch.h b/include/branch.h
similarity index 100%
rename from branch.h
rename to include/branch.h
diff --git a/builtin.h b/include/builtin.h
similarity index 100%
rename from builtin.h
rename to include/builtin.h
diff --git a/bundle.h b/include/bundle.h
similarity index 100%
rename from bundle.h
rename to include/bundle.h
diff --git a/cache-tree.h b/include/cache-tree.h
similarity index 100%
rename from cache-tree.h
rename to include/cache-tree.h
diff --git a/color.h b/include/color.h
similarity index 100%
rename from color.h
rename to include/color.h
diff --git a/commit.h b/include/commit.h
similarity index 100%
rename from commit.h
rename to include/commit.h
diff --git a/csum-file.h b/include/csum-file.h
similarity index 100%
rename from csum-file.h
rename to include/csum-file.h
diff --git a/decorate.h b/include/decorate.h
similarity index 100%
rename from decorate.h
rename to include/decorate.h
diff --git a/delta.h b/include/delta.h
similarity index 100%
rename from delta.h
rename to include/delta.h
diff --git a/diff.h b/include/diff.h
similarity index 100%
rename from diff.h
rename to include/diff.h
diff --git a/diffcore.h b/include/diffcore.h
similarity index 100%
rename from diffcore.h
rename to include/diffcore.h
diff --git a/dir.h b/include/dir.h
similarity index 100%
rename from dir.h
rename to include/dir.h
diff --git a/exec_cmd.h b/include/exec_cmd.h
similarity index 100%
rename from exec_cmd.h
rename to include/exec_cmd.h
diff --git a/fetch-pack.h b/include/fetch-pack.h
similarity index 100%
rename from fetch-pack.h
rename to include/fetch-pack.h
diff --git a/fsck.h b/include/fsck.h
similarity index 100%
rename from fsck.h
rename to include/fsck.h
diff --git a/graph.h b/include/graph.h
similarity index 100%
rename from graph.h
rename to include/graph.h
diff --git a/grep.h b/include/grep.h
similarity index 100%
rename from grep.h
rename to include/grep.h
diff --git a/hash.h b/include/hash.h
similarity index 100%
rename from hash.h
rename to include/hash.h
diff --git a/help.h b/include/help.h
similarity index 100%
rename from help.h
rename to include/help.h
diff --git a/http.h b/include/http.h
similarity index 100%
rename from http.h
rename to include/http.h
diff --git a/levenshtein.h b/include/levenshtein.h
similarity index 100%
rename from levenshtein.h
rename to include/levenshtein.h
diff --git a/list-objects.h b/include/list-objects.h
similarity index 100%
rename from list-objects.h
rename to include/list-objects.h
diff --git a/ll-merge.h b/include/ll-merge.h
similarity index 100%
rename from ll-merge.h
rename to include/ll-merge.h
diff --git a/log-tree.h b/include/log-tree.h
similarity index 100%
rename from log-tree.h
rename to include/log-tree.h
diff --git a/mailmap.h b/include/mailmap.h
similarity index 100%
rename from mailmap.h
rename to include/mailmap.h
diff --git a/merge-recursive.h b/include/merge-recursive.h
similarity index 100%
rename from merge-recursive.h
rename to include/merge-recursive.h
diff --git a/notes-cache.h b/include/notes-cache.h
similarity index 100%
rename from notes-cache.h
rename to include/notes-cache.h
diff --git a/notes-merge.h b/include/notes-merge.h
similarity index 100%
rename from notes-merge.h
rename to include/notes-merge.h
diff --git a/notes.h b/include/notes.h
similarity index 100%
rename from notes.h
rename to include/notes.h
diff --git a/object.h b/include/object.h
similarity index 100%
rename from object.h
rename to include/object.h
diff --git a/pack-refs.h b/include/pack-refs.h
similarity index 100%
rename from pack-refs.h
rename to include/pack-refs.h
diff --git a/pack-revindex.h b/include/pack-revindex.h
similarity index 100%
rename from pack-revindex.h
rename to include/pack-revindex.h
diff --git a/pack.h b/include/pack.h
similarity index 100%
rename from pack.h
rename to include/pack.h
diff --git a/parse-options.h b/include/parse-options.h
similarity index 100%
rename from parse-options.h
rename to include/parse-options.h
diff --git a/patch-ids.h b/include/patch-ids.h
similarity index 100%
rename from patch-ids.h
rename to include/patch-ids.h
diff --git a/pkt-line.h b/include/pkt-line.h
similarity index 100%
rename from pkt-line.h
rename to include/pkt-line.h
diff --git a/progress.h b/include/progress.h
similarity index 100%
rename from progress.h
rename to include/progress.h
diff --git a/quote.h b/include/quote.h
similarity index 100%
rename from quote.h
rename to include/quote.h
diff --git a/reachable.h b/include/reachable.h
similarity index 100%
rename from reachable.h
rename to include/reachable.h
diff --git a/reflog-walk.h b/include/reflog-walk.h
similarity index 100%
rename from reflog-walk.h
rename to include/reflog-walk.h
diff --git a/refs.h b/include/refs.h
similarity index 100%
rename from refs.h
rename to include/refs.h
diff --git a/remote.h b/include/remote.h
similarity index 100%
rename from remote.h
rename to include/remote.h
diff --git a/rerere.h b/include/rerere.h
similarity index 100%
rename from rerere.h
rename to include/rerere.h
diff --git a/resolve-undo.h b/include/resolve-undo.h
similarity index 100%
rename from resolve-undo.h
rename to include/resolve-undo.h
diff --git a/revision.h b/include/revision.h
similarity index 100%
rename from revision.h
rename to include/revision.h
diff --git a/run-command.h b/include/run-command.h
similarity index 100%
rename from run-command.h
rename to include/run-command.h
diff --git a/send-pack.h b/include/send-pack.h
similarity index 100%
rename from send-pack.h
rename to include/send-pack.h
diff --git a/sha1-lookup.h b/include/sha1-lookup.h
similarity index 100%
rename from sha1-lookup.h
rename to include/sha1-lookup.h
diff --git a/shortlog.h b/include/shortlog.h
similarity index 100%
rename from shortlog.h
rename to include/shortlog.h
diff --git a/sideband.h b/include/sideband.h
similarity index 100%
rename from sideband.h
rename to include/sideband.h
diff --git a/sigchain.h b/include/sigchain.h
similarity index 100%
rename from sigchain.h
rename to include/sigchain.h
diff --git a/string-list.h b/include/string-list.h
similarity index 100%
rename from string-list.h
rename to include/string-list.h
diff --git a/submodule.h b/include/submodule.h
similarity index 100%
rename from submodule.h
rename to include/submodule.h
diff --git a/tag.h b/include/tag.h
similarity index 100%
rename from tag.h
rename to include/tag.h
diff --git a/tar.h b/include/tar.h
similarity index 100%
rename from tar.h
rename to include/tar.h
diff --git a/thread-utils.h b/include/thread-utils.h
similarity index 100%
rename from thread-utils.h
rename to include/thread-utils.h
diff --git a/transport.h b/include/transport.h
similarity index 100%
rename from transport.h
rename to include/transport.h
diff --git a/tree-walk.h b/include/tree-walk.h
similarity index 100%
rename from tree-walk.h
rename to include/tree-walk.h
diff --git a/tree.h b/include/tree.h
similarity index 100%
rename from tree.h
rename to include/tree.h
diff --git a/unpack-trees.h b/include/unpack-trees.h
similarity index 100%
rename from unpack-trees.h
rename to include/unpack-trees.h
diff --git a/url.h b/include/url.h
similarity index 100%
rename from url.h
rename to include/url.h
diff --git a/userdiff.h b/include/userdiff.h
similarity index 100%
rename from userdiff.h
rename to include/userdiff.h
diff --git a/utf8.h b/include/utf8.h
similarity index 100%
rename from utf8.h
rename to include/utf8.h
diff --git a/walker.h b/include/walker.h
similarity index 100%
rename from walker.h
rename to include/walker.h
diff --git a/wt-status.h b/include/wt-status.h
similarity index 100%
rename from wt-status.h
rename to include/wt-status.h
diff --git a/xdiff-interface.h b/include/xdiff-interface.h
similarity index 100%
rename from xdiff-interface.h
rename to include/xdiff-interface.h
-- 
1.7.4.1
