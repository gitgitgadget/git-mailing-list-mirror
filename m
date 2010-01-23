From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/5] Makefile: make sure test helpers are rebuilt when
 headers change
Date: Sat, 23 Jan 2010 08:44:15 -0600
Message-ID: <20100123144415.GC11903@progeny.tock>
References: <20100123144201.GA11903@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 15:44:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYhDm-0001zb-9q
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 15:44:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753860Ab0AWOoO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 09:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753657Ab0AWOoO
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 09:44:14 -0500
Received: from mail-iw0-f186.google.com ([209.85.223.186]:50837 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752772Ab0AWOoN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 09:44:13 -0500
Received: by iwn16 with SMTP id 16so926851iwn.33
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 06:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=/2ySyPq6wQpBMasD7E3suYlFVB0QHvIMCp/9mZ24Qns=;
        b=Zdw4WqD1ElysFILS/B9BxuRqxrUAb8SbiqJI23p76eH3V/JHM1hM4cY6oXbkeNlZT1
         +V6u5xvC0ZeGUQhgk+yeXdmwf2yCorFBhMKc3NJJKccFWLomAywMH7mgoOHW+47fFiF1
         p8nPTew4c+dTgAF3zLdEsXOfbTXLsbwd9Yq7c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=TtoqxO5KuL0jfVnPaqKy+WF5qr4ieaxX4QZchNOzuA4MUpzkxDtuzshMmb6j2Fv1vU
         3LTaX1oV9EiVS3eubFT56MZ+SgtCCvJ6fOb0bGnDl4b3fC8ZCfAZRsgqrqv+7gdcR/yf
         UldsINYfL7ZII4OqdGOXM17+1dyLob6PK5vnk=
Received: by 10.231.147.149 with SMTP id l21mr322426ibv.0.1264257852080;
        Sat, 23 Jan 2010 06:44:12 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm2816156iwn.4.2010.01.23.06.44.11
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 Jan 2010 06:44:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100123144201.GA11903@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137844>

It is not worth the bother to maintain an up-to-date list of
which headers each test helper uses, so depend on $(LIB_H) to
catch them all.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Verified (a few weeks ago) with 'make CHECK_HEADER_DEPENDENCIES=1'.

 Makefile |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/Makefile b/Makefile
index 2a408d7..448d552 100644
--- a/Makefile
+++ b/Makefile
@@ -384,6 +384,18 @@ SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
 # Empty...
 EXTRA_PROGRAMS =
 
+TEST_PROGRAMS += test-chmtime$X
+TEST_PROGRAMS += test-ctype$X
+TEST_PROGRAMS += test-date$X
+TEST_PROGRAMS += test-delta$X
+TEST_PROGRAMS += test-dump-cache-tree$X
+TEST_PROGRAMS += test-genrandom$X
+TEST_PROGRAMS += test-match-trees$X
+TEST_PROGRAMS += test-parse-options$X
+TEST_PROGRAMS += test-path-utils$X
+TEST_PROGRAMS += test-sha1$X
+TEST_PROGRAMS += test-sigchain$X
+
 # ... and all the rest that could be moved out of bindir to gitexecdir
 PROGRAMS += $(EXTRA_PROGRAMS)
 PROGRAMS += git-fast-import$X
@@ -695,6 +707,8 @@ BUILTIN_OBJS += builtin-verify-pack.o
 BUILTIN_OBJS += builtin-verify-tag.o
 BUILTIN_OBJS += builtin-write-tree.o
 
+TEST_OBJS := $(patsubst test-%$X,test-%.o,$(TEST_PROGRAMS))
+
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 EXTLIBS =
 
@@ -1641,7 +1655,7 @@ git-remote-curl$X: remote-curl.o http.o http-walker.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
-$(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
+$(LIB_OBJS) $(BUILTIN_OBJS) $(TEST_OBJS): $(LIB_H)
 $(patsubst git-%$X,%.o,$(PROGRAMS)) git.o: $(LIB_H) $(wildcard */*.h)
 builtin-branch.o builtin-checkout.o builtin-clone.o builtin-reset.o branch.o: branch.h
 builtin-bundle.o bundle.o transport.o: bundle.h
@@ -1732,18 +1746,6 @@ endif
 
 ### Testing rules
 
-TEST_PROGRAMS += test-chmtime$X
-TEST_PROGRAMS += test-ctype$X
-TEST_PROGRAMS += test-date$X
-TEST_PROGRAMS += test-delta$X
-TEST_PROGRAMS += test-dump-cache-tree$X
-TEST_PROGRAMS += test-genrandom$X
-TEST_PROGRAMS += test-match-trees$X
-TEST_PROGRAMS += test-parse-options$X
-TEST_PROGRAMS += test-path-utils$X
-TEST_PROGRAMS += test-sha1$X
-TEST_PROGRAMS += test-sigchain$X
-
 all:: $(TEST_PROGRAMS)
 
 # GNU make supports exporting all variables by "export" without parameters.
@@ -1763,9 +1765,7 @@ test-delta$X: diff-delta.o patch-delta.o
 
 test-parse-options$X: parse-options.o
 
-test-parse-options.o: parse-options.h
-
-.PRECIOUS: $(patsubst test-%$X,test-%.o,$(TEST_PROGRAMS))
+.PRECIOUS: $(TEST_OBJS)
 
 test-%$X: test-%.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
-- 
1.6.6.rc2
