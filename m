From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 01/12] Makefile: add missing header file dependencies
Date: Tue, 26 Jan 2010 09:44:47 -0600
Message-ID: <20100126154446.GB4895@progeny.tock>
References: <20100123144201.GA11903@progeny.tock>
 <7v3a1u6bfz.fsf@alter.siamese.dyndns.org>
 <20100126154357.GA4895@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 26 16:45:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZnbA-0000gk-0m
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 16:45:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754412Ab0AZPov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 10:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754004Ab0AZPou
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 10:44:50 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:36912 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753777Ab0AZPos (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 10:44:48 -0500
Received: by ywh6 with SMTP id 6so4132282ywh.4
        for <git@vger.kernel.org>; Tue, 26 Jan 2010 07:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=lF6v5krlWb9Nx8XN2KW2FCAMTOSbMdDvOj1V2GgT1sY=;
        b=KvH6VOBhEcsF9MXe5G6taGAQ5K0TAWBB+TFVUZfVZky5WH7mEbh5W86n6ZSNTLG2r5
         E0AK8hGBpuT7nNzp0KcR1r1+YTJa88s7h4kKCmle0CBSS2EIgmrqVTSCAF4jw1I1lePi
         uT0TpOBHQzmvcshTVtUW87g+dvaCwZjIXRLbA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=I4B740vbSL23lE5kBRWFYI7locjK8709A12dyJL7iBWxof4DZXiPvS5AXOGSO7DGnJ
         ISeXDNxl7sEAJqRzNPBiNuUQGgqej5jJvEKgPnVsHgPzKVDZ2YQDHjOsFgA0NhGw5UlK
         0ZBvhI5ceL7u/dUEhuP1vIUAUBSoz80F+owrI=
Received: by 10.91.182.8 with SMTP id j8mr3205795agp.48.1264520685354;
        Tue, 26 Jan 2010 07:44:45 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm6173662iwn.3.2010.01.26.07.44.44
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 26 Jan 2010 07:44:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100126154357.GA4895@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138042>

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
 Makefile |   23 ++++++++++++++++++++---
 1 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index fd7f51e..bad8f80 100644
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
@@ -1620,9 +1626,9 @@ git-imap-send$X: imap-send.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL)
 
-http.o http-walker.o http-push.o: http.h
+http.o http-walker.o http-push.o remote-curl.o: http.h
 
-http.o http-walker.o: $(LIB_H)
+http.o http-walker.o remote-curl.o: $(LIB_H)
 
 git-http-fetch$X: revision.o http.o http-walker.o http-fetch.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
@@ -1637,14 +1643,25 @@ git-remote-curl$X: remote-curl.o http.o http-walker.o $(GITLIBS)
 
 $(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
 $(patsubst git-%$X,%.o,$(PROGRAMS)) git.o: $(LIB_H) $(wildcard */*.h)
+builtin-branch.o builtin-checkout.o builtin-clone.o builtin-reset.o branch.o: branch.h
+builtin-bundle.o bundle.o transport.o: bundle.h
+builtin-bisect--helper.o builtin-rev-list.o bisect.o: bisect.h
+builtin-clone.o builtin-fetch-pack.o transport.o: fetch-pack.h
+builtin-send-pack.o transport.o: send-pack.h
+builtin-log.o builtin-shortlog.o: shortlog.h
+builtin-prune.o builtin-reflog.o reachable.o: reachable.h
 builtin-revert.o wt-status.o: wt-status.h
+builtin-tar-tree.o archive-tar.o: tar.h
+builtin-pack-objects.o: thread-utils.h
+http-fetch.o http-walker.o remote-curl.o transport.o walker.o: walker.h
 
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIB_OBJS)
 
 XDIFF_OBJS=xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
 	xdiff/xmerge.o xdiff/xpatience.o
-$(XDIFF_OBJS): xdiff/xinclude.h xdiff/xmacros.h xdiff/xdiff.h xdiff/xtypes.h \
+xdiff-interface.o $(XDIFF_OBJS): \
+	xdiff/xinclude.h xdiff/xmacros.h xdiff/xdiff.h xdiff/xtypes.h \
 	xdiff/xutils.h xdiff/xprepare.h xdiff/xdiffi.h xdiff/xemit.h
 
 $(XDIFF_LIB): $(XDIFF_OBJS)
-- 
1.6.6
