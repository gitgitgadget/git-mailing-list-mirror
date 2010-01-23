From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/5] Makefile: add missing header file dependencies
Date: Sat, 23 Jan 2010 08:43:20 -0600
Message-ID: <20100123144320.GB11903@progeny.tock>
References: <20100123144201.GA11903@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 15:43:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYhCt-0001ha-P5
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 15:43:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753744Ab0AWOnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 09:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753016Ab0AWOnS
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 09:43:18 -0500
Received: from mail-iw0-f186.google.com ([209.85.223.186]:64017 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864Ab0AWOnR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 09:43:17 -0500
Received: by iwn16 with SMTP id 16so926509iwn.33
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 06:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=XOLvMLXkKcosxgnSUuZFplLUt+dkyP9CL6E3GmevFM4=;
        b=VM72pFC3HDa7qesu529gGXo8gR3ZgNLQhXctLPZWDgaqCiuQxq34qqcV0wjb2hKShE
         H+PRudLyHBFBNBAEocGiTdgpVDJGwivZzqZt2Qef20SRwfNONXJbhGX9uU/epVoW0fpL
         LzGY5e3dr+bDYsHYU1QgiK2NQG+VP7E82DAjc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Z02TKwaeOX727yI4eU4t6V2VQN2ZGX8ZRpu8/XNTlpqcmprMy0CcnkP5lkybTtPfqX
         7TDrIcn+917yVZkDWzhTxLZzWfgdVoadK6eYv659tInXn/c2qbxl0uKkQHxGB6CJiXYN
         JKQ6MPqMoE31Kq1Sv04VuaIXOstulgsUlW3SU=
Received: by 10.231.159.207 with SMTP id k15mr6953171ibx.52.1264257796674;
        Sat, 23 Jan 2010 06:43:16 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm2814496iwn.12.2010.01.23.06.43.15
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 Jan 2010 06:43:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100123144201.GA11903@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137843>

LIB_H is missing exec_cmd.h and color.h.  cache.h includes
SHA1_HEADER, and thus so does almost everything else, so add that
to LIB_H, too.  xdiff-interface.h is not included by any header
files, but so many source files use xdiff that it is simplest to
include it in LIB_H, too.

xdiff-interface.o uses the xdiff library heavily; let it depend
on all xdiff headers to avoid needing to keep track of which
headers it uses.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index fd7f51e..2a408d7 100644
--- a/Makefile
+++ b/Makefile
@@ -447,6 +447,7 @@ LIB_H += blob.h
 LIB_H += builtin.h
 LIB_H += cache.h
 LIB_H += cache-tree.h
+LIB_H += color.h
 LIB_H += commit.h
 LIB_H += compat/bswap.h
 LIB_H += compat/cygwin.h
@@ -457,6 +458,7 @@ LIB_H += delta.h
 LIB_H += diffcore.h
 LIB_H += diff.h
 LIB_H += dir.h
+LIB_H += exec_cmd.h
 LIB_H += fsck.h
 LIB_H += git-compat-util.h
 LIB_H += graph.h
@@ -499,6 +501,8 @@ LIB_H += unpack-trees.h
 LIB_H += userdiff.h
 LIB_H += utf8.h
 LIB_H += wt-status.h
+LIB_H += xdiff-interface.h
+LIB_H += xdiff/xdiff.h
 
 LIB_OBJS += abspath.o
 LIB_OBJS += advice.o
@@ -1281,10 +1285,12 @@ endif
 ifdef BLK_SHA1
 	SHA1_HEADER = "block-sha1/sha1.h"
 	LIB_OBJS += block-sha1/sha1.o
+	LIB_H += block-sha1/sha1.h
 else
 ifdef PPC_SHA1
 	SHA1_HEADER = "ppc/sha1.h"
 	LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
+	LIB_H += ppc/sha1.h
 else
 	SHA1_HEADER = <openssl/sha.h>
 	EXTLIBS += $(LIB_4_CRYPTO)
@@ -1637,14 +1643,25 @@ git-remote-curl$X: remote-curl.o http.o http-walker.o $(GITLIBS)
 
 $(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
 $(patsubst git-%$X,%.o,$(PROGRAMS)) git.o: $(LIB_H) $(wildcard */*.h)
+builtin-branch.o builtin-checkout.o builtin-clone.o builtin-reset.o branch.o: branch.h
+builtin-bundle.o bundle.o transport.o: bundle.h
+builtin-bisect--helper.o builtin-rev-list.o bisect.o: bisect.h
+builtin-clone.o builtin-fetch-pack.o transport.o: fetch-pack.h
+builtin-send-pack.o transport.o: send-pack.h
+builtin-log.o builtin-shortlog.o: shortlog.h
 builtin-revert.o wt-status.o: wt-status.h
+builtin-prune.o builtin-reflog.o reachable.o: reachable.h
+builtin-tar-tree.o archive-tar.o: tar.h
+builtin-pack-objects.o: thread-utils.h
+http-fetch.o http-walker.o remote-curl.o transport.o walker.o: walker.h
 
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIB_OBJS)
 
 XDIFF_OBJS=xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
 	xdiff/xmerge.o xdiff/xpatience.o
-$(XDIFF_OBJS): xdiff/xinclude.h xdiff/xmacros.h xdiff/xdiff.h xdiff/xtypes.h \
+xdiff-interface.o $(XDIFF_OBJS): xdiff/xinclude.h \
+	xdiff/xmacros.h xdiff/xdiff.h xdiff/xtypes.h \
 	xdiff/xutils.h xdiff/xprepare.h xdiff/xdiffi.h xdiff/xemit.h
 
 $(XDIFF_LIB): $(XDIFF_OBJS)
-- 
1.6.6.rc2
