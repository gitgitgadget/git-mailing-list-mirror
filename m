From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH] Makefile: allow po generation through po target
Date: Thu, 17 Mar 2016 16:14:52 +0100
Message-ID: <2296423d1c46365f1fdeaa12cd1917bc859ff8d9.1458227678.git.git@drmicha.warpmail.net>
References: <56EAC47F.6000708@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jiang Xin <worldhello.net@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 17 16:15:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agZdb-0002Qz-EI
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 16:14:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030905AbcCQPO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 11:14:56 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:40050 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965634AbcCQPOy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Mar 2016 11:14:54 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id AD91420E83
	for <git@vger.kernel.org>; Thu, 17 Mar 2016 11:14:53 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Thu, 17 Mar 2016 11:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:date:from:in-reply-to:message-id:references:subject:to
	:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=L3HHaMhYXe1ByZm/uNvXs1iMQOE
	=; b=JbVTgsyzI1WXfMJBXX3lkuinewDM+sPBX4efCmqQ6LOtjK3kc0lzWbG+pW0
	ml8k4IRSX2BQr49kT4a2EvNq+YF7n09qZrAGaEwCuqN5VS9o3hc94NpjUzEwH8lw
	/c22YGm70vL9DOzwjBHEXs6Sd6LJbnTupv2N82Fql2QaUAyE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=L3HH
	aMhYXe1ByZm/uNvXs1iMQOE=; b=n7i1HyI3l4jIuxOoT01Uh4mlE5DIsmRDzAfK
	NAWT2hxOL9Dk56OKxsK/al9P/qAuEI+R7vsDstzSjo1x8unf3g30N8xd1vL3b2Ss
	zA+d978tpdAW5qTeI2vrnxA20++WSCUkdvv3fcgLX7AZqaiYTRBLTDk/M2nl2xcb
	jNyCssU=
X-Sasl-enc: 4sIYL02LQ4FcntSQ/3QEtXkLyPk4dwdF+XMUf95g53Hc 1458227693
Received: from localhost (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 29D62C00014;
	Thu, 17 Mar 2016 11:14:53 -0400 (EDT)
X-Mailer: git-send-email 2.8.0.rc2.197.g3b88641.dirty
In-Reply-To: <56EAC47F.6000708@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289120>

The main Makefile has a "pot" target that recreates the git.pot file of
strings which are marked for translation.

Add a "po" target that recreates the $(LANGUAGE).po files which contain
the translations (or stubs).

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---

Notes:
    This makes it easier to recreate po (and mo) without reading po/README.
    Alternatively, one may think about a Makefile in po/ which does both pot
    and po updates, just like we have makefiles in t/ and Ducumentation/.
    
    This doesn't give you proper before-after diffs yet, but at least the after
    state.

 Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Makefile b/Makefile
index 24bef8d..bb60a34 100644
--- a/Makefile
+++ b/Makefile
@@ -445,6 +445,7 @@ TCL_PATH = tclsh
 TCLTK_PATH = wish
 XGETTEXT = xgettext
 MSGFMT = msgfmt
+MSGMERGE = msgmerge
 CURL_CONFIG = curl-config
 PTHREAD_LIBS = -lpthread
 PTHREAD_CFLAGS =
@@ -1514,6 +1515,7 @@ ifndef V
 	QUIET_LNCP     = @echo '   ' LN/CP $@;
 	QUIET_XGETTEXT = @echo '   ' XGETTEXT $@;
 	QUIET_MSGFMT   = @echo '   ' MSGFMT $@;
+	QUIET_MSGMERGE = @echo '   ' MSGMERGE $@;
 	QUIET_GCOV     = @echo '   ' GCOV $@;
 	QUIET_SP       = @echo '   ' SP $<;
 	QUIET_RC       = @echo '   ' RC $@;
@@ -2088,6 +2090,9 @@ pot: po/git.pot
 POFILES := $(wildcard po/*.po)
 MOFILES := $(patsubst po/%.po,po/build/locale/%/LC_MESSAGES/git.mo,$(POFILES))
 
+.PHONY: po
+po: $(POFILES)
+
 ifndef NO_GETTEXT
 all:: $(MOFILES)
 endif
@@ -2095,6 +2100,9 @@ endif
 po/build/locale/%/LC_MESSAGES/git.mo: po/%.po
 	$(QUIET_MSGFMT)mkdir -p $(dir $@) && $(MSGFMT) -o $@ $<
 
+po/%.po: po/git.pot
+	$(QUIET_MSGMERGE)$(MSGMERGE) --add-location --backup=off -q -U $@ $<
+
 FIND_SOURCE_FILES = ( git ls-files '*.[hcS]' 2>/dev/null || \
 			$(FIND) . \( -name .git -type d -prune \) \
 				-o \( -name '*.[hcS]' -type f -print \) )
-- 
2.8.0.rc2.197.g3b88641.dirty
