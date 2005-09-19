From: Patrick Mauritz <oxygene@studentenbude.ath.cx>
Subject: Re: [PATCHES] CURLDIR support, more usable cmd-rename.sh
Date: Mon, 19 Sep 2005 16:11:19 +0200
Message-ID: <1127139079.781.9.camel@divert>
References: <1127128475.781.6.camel@divert>
	 <20050919133731.GB2903@pasky.or.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-Mw66UYUjONr3D4ba09n/"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 16:12:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHMMB-0002bL-NO
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 16:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbVISOK2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 10:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbVISOK1
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 10:10:27 -0400
Received: from khepri.openbios.org ([80.190.231.112]:59303 "EHLO
	khepri.openbios.org") by vger.kernel.org with ESMTP id S932419AbVISOK1
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 10:10:27 -0400
Received: from dsl-082-083-077-252.arcor-ip.net ([82.83.77.252] helo=t-stueck.streichelzoo)
	by khepri.openbios.org with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.50)
	id 1EHMLh-0006jU-GQ; Mon, 19 Sep 2005 16:10:26 +0200
Received: from 192.168.1.201 (divert.studentenbude.ath.cx [192.168.1.201])
	by t-stueck.streichelzoo (8.13.4+Sun/8.13.3) with ESMTP id j8JEAIWu007333;
	Mon, 19 Sep 2005 16:10:24 +0200 (CEST)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050919133731.GB2903@pasky.or.cz>
X-Mailer: Ximian Evolution 1.4.6.316 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0 (t-stueck.streichelzoo [192.168.1.200]); Mon, 19 Sep 2005 16:10:24 +0200 (CEST)
X-Spam-Score: -1.3 (-)
X-Duff: Orig. Duff, Duff Lite, Duff Dry, Duff Dark,
	Raspberry Duff, Lady Duff, Red Duff, Tartar Control Duff
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8861>


--=-Mw66UYUjONr3D4ba09n/
Content-Type: text/plain; charset=ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2005-09-19 at 15:37, Petr Baudis wrote:
> seems that they didn't quite get attached in the end. ;-)
oops :)
here they are

> Linus already did in <Pine.LNX.4.58.0509181829310.9106@g5.osdl.org>.
yay :)


patrick mauritz

--=-Mw66UYUjONr3D4ba09n/
Content-Disposition: attachment; filename=patch-20050919-1-curl
Content-Type: text/x-patch; name=patch-20050919-1-curl
Content-Transfer-Encoding: 7bit

diff -ur git-core-0.99.7.orig//Makefile git-core-0.99.7/Makefile
--- git-core-0.99.7.orig//Makefile	Mon Sep 19 12:43:04 2005
+++ git-core-0.99.7/Makefile	Mon Sep 19 12:45:45 2005
@@ -42,7 +42,10 @@
 
 GIT_VERSION = 0.99.7
 
-CFLAGS = -g -O2 -Wall
+CFLAGS = -g -O2
+ifdef CURLDIR
+CFLAGS+=-I$(CURLDIR)/include
+endif
 ALL_CFLAGS = $(CFLAGS) $(PLATFORM_DEFINES) $(DEFINES)
 
 prefix = $(HOME)
@@ -261,7 +264,11 @@
 git-ssh-pull: rsh.o fetch.o
 git-ssh-push: rsh.o
 
+ifdef CURLDIR
+git-http-fetch: LIBS += -L$(CURLDIR)/lib -R$(CURLDIR)/lib -lcurl
+else
 git-http-fetch: LIBS += -lcurl
+endif
 git-rev-list: LIBS += $(OPENSSL_LIBSSL)
 
 init-db.o: init-db.c

--=-Mw66UYUjONr3D4ba09n/
Content-Disposition: attachment; filename=patch-20050919-3-cmdrename
Content-Type: text/plain; name=patch-20050919-3-cmdrename
Content-Transfer-Encoding: 7bit

--- cmd-rename.sh~	Mon Sep 19 12:53:40 2005
+++ git-core-0.99.7/cmd-rename.sh	Mon Sep 19 12:53:58 2005
@@ -4,7 +4,9 @@
 while read old new
 do
 	rm -f "$d/$old"
+	if [ -x "$d/$new" ]; then
 	ln -s "$new" "$d/$old"
+	fi
 done <<\EOF
 git-add-script	git-add
 git-archimport-script	git-archimport

--=-Mw66UYUjONr3D4ba09n/--
