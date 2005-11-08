From: Alex Riesen <raa.lkml@gmail.com>
Subject: make tests ignorable with "make -i"
Date: Tue, 8 Nov 2005 10:51:10 +0100
Message-ID: <81b0412b0511080151v69bc4578we093eaa751ee4bac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1164_19866520.1131443470389"
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Nov 08 10:51:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZQ8I-0007rh-NK
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 10:51:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965133AbVKHJvM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 04:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965134AbVKHJvM
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 04:51:12 -0500
Received: from nproxy.gmail.com ([64.233.182.200]:45504 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965133AbVKHJvL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Nov 2005 04:51:11 -0500
Received: by nproxy.gmail.com with SMTP id q29so148949nfc
        for <git@vger.kernel.org>; Tue, 08 Nov 2005 01:51:10 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=mHAyK5Gw9RhFj7aL82QwM4fkwTDf9Uti3JfPNvwPgkL9iRFEVPGcDs5cO/k2ny/oywxkrgAtqNELz+gZInmn0CZli/cpBS/8Qbtl5Kqrpfdu/wYFtDBgFaWzeMPtz92WDKxadTaz2nAcSFrCZie+bHYLjs5+PmymymTZY9wNQls=
Received: by 10.48.49.8 with SMTP id w8mr1138580nfw;
        Tue, 08 Nov 2005 01:51:10 -0800 (PST)
Received: by 10.48.247.3 with HTTP; Tue, 8 Nov 2005 01:51:10 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11320>

------=_Part_1164_19866520.1131443470389
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Allow failed tests to be ignored using make's "-i". The patch also
disables parallel make in t/. This doesn't make the testing any
different as before: the tests were run sequentially before.

It also allows to run more tests, ignoring the ones usually failing
just to figure out if something else broke.  (Or to ignore plainly
uninteresting situations because of the testing being done on say...
cygwin ;)

---

How about hiding "ok ..." output?

------=_Part_1164_19866520.1131443470389
Content-Type: application/xxxxx; name=make-tests-ignorable.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="make-tests-ignorable.patch"

diff --git a/t/Makefile b/t/Makefile
index 5c76aff..5c5a620 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -15,9 +15,14 @@ shellquote = '$(call shq,$(1))'
 
 T = $(wildcard t[0-9][0-9][0-9][0-9]-*.sh)
 
-all:
-	@$(foreach t,$T,echo "*** $t ***"; $(call shellquote,$(SHELL_PATH)) $t $(GIT_TEST_OPTS) || exit; )
-	@rm -fr trash
+all: $(T) clean
+
+$(T):
+	@echo "*** $@ ***"; $(call shellquote,$(SHELL_PATH)) $@ $(GIT_TEST_OPTS)
 
 clean:
 	rm -fr trash
+
+.PHONY: $(T) clean
+.NOPARALLEL:
+





------=_Part_1164_19866520.1131443470389--
