From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] Makefile: determine the list of header files using a glob
Date: Fri, 27 Nov 2009 09:04:53 +0100
Message-ID: <4B0F8825.3040107@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 27 09:05:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDvp8-0006Iy-AI
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 09:05:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbZK0IEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 03:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbZK0IEt
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 03:04:49 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:57467 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751002AbZK0IEt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 03:04:49 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NDvoz-0006ew-M4; Fri, 27 Nov 2009 09:04:53 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 6CEBB1660F;
	Fri, 27 Nov 2009 09:04:53 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133872>

From: Johannes Sixt <j6t@kdbg.org>

The list of header files was incomplete because a number of header files
were added to the code base, but were not added to the list LIB_H that we
have in the Makefile. This meant that no rebuild was triggered if one of
the missing headers was changed because we do not have automatic
dependency tracking, either.

Sidestep the issue by computing the list using $(wildcard).

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Makefile |   63 +------------------------------------------------------------
 1 files changed, 2 insertions(+), 61 deletions(-)

diff --git a/Makefile b/Makefile
index 5a0b3d4..279c7e4 100644
--- a/Makefile
+++ b/Makefile
@@ -326,7 +326,6 @@ BUILTIN_OBJS =
 BUILT_INS =
 COMPAT_CFLAGS =
 COMPAT_OBJS =
-LIB_H =
 LIB_OBJS =
 PROGRAMS =
 SCRIPT_PERL =
@@ -429,65 +428,7 @@ export PERL_PATH
 LIB_FILE=libgit.a
 XDIFF_LIB=xdiff/lib.a

-LIB_H += advice.h
-LIB_H += archive.h
-LIB_H += attr.h
-LIB_H += blob.h
-LIB_H += builtin.h
-LIB_H += cache.h
-LIB_H += cache-tree.h
-LIB_H += commit.h
-LIB_H += compat/bswap.h
-LIB_H += compat/cygwin.h
-LIB_H += compat/mingw.h
-LIB_H += csum-file.h
-LIB_H += decorate.h
-LIB_H += delta.h
-LIB_H += diffcore.h
-LIB_H += diff.h
-LIB_H += dir.h
-LIB_H += fsck.h
-LIB_H += git-compat-util.h
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
-LIB_H += revision.h
-LIB_H += run-command.h
-LIB_H += sha1-lookup.h
-LIB_H += sideband.h
-LIB_H += sigchain.h
-LIB_H += strbuf.h
-LIB_H += string-list.h
-LIB_H += submodule.h
-LIB_H += tag.h
-LIB_H += transport.h
-LIB_H += tree.h
-LIB_H += tree-walk.h
-LIB_H += unpack-trees.h
-LIB_H += userdiff.h
-LIB_H += utf8.h
-LIB_H += wt-status.h
+LIB_H = $(wildcard *.h */*.h compat/*/*.h)

 LIB_OBJS += abspath.o
 LIB_OBJS += advice.o
@@ -1611,7 +1552,7 @@ git-remote-curl$X: remote-curl.o http.o http-walker.o $(GITLIBS)
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)

 $(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
-$(patsubst git-%$X,%.o,$(PROGRAMS)) git.o: $(LIB_H) $(wildcard */*.h)
+$(patsubst git-%$X,%.o,$(PROGRAMS)) git.o: $(LIB_H)
 builtin-revert.o wt-status.o: wt-status.h

 $(LIB_FILE): $(LIB_OBJS)
-- 
1.6.6.rc0.43.g50037
