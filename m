From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH] Avoid TAGS/tags warning from GNU Make
Date: Sat, 4 Sep 2010 04:03:32 -0500
Message-ID: <20100904090331.GA10903@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <frekui@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 04 11:05:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Orogp-0001N5-I0
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 11:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316Ab0IDJFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 05:05:30 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60546 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910Ab0IDJF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 05:05:29 -0400
Received: by iwn5 with SMTP id 5so2297833iwn.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 02:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=j44NYiSts27/iRbRw1drcaV3mvWYrVtPdreg6iYJjVo=;
        b=ppa+kLFs9m5TjM89ly6qNoKgrcnmUVJJi47F8/t8GoO6uuu1zkMgm0gjrtg1/JYydL
         x4wonBt/hGgzUUcdzeBpb4c06xOCZU8O4Fv0K7uekpFxH6wGjATmQ5EOSsWyR0fVICbV
         6i8uyNikKfp36FM02VejuU7bExtcfYPZLy/qE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=b+XXrjqh7GTVexWxZHu1RIvO6MIz7Rm+P6GD0g+ipMSGRfvLtNKo91xvP0997/qQHO
         f2vTxOgSbbC2xobDq/1GUBgkbmNoEAy97nqGiUc4M0SbN3cmnbVeNme9teRsYVaNPgC/
         tKqAkvg6A9cL6koTV+VknzC3FgXBLkeTuLt5I=
Received: by 10.231.152.78 with SMTP id f14mr2501335ibw.60.1283591128151;
        Sat, 04 Sep 2010 02:05:28 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id i6sm261182iba.14.2010.09.04.02.05.27
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 02:05:27 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155313>

From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Thu, 22 Oct 2009 19:04:17 +0200

MinGW make considers the TAGS and tags targets to refer to
the same file:

 Makefile: warning: overriding commands for target `TAGS'
 Makefile: warning: ignoring old commands for target `TAGS'

Suppress both targets on that platform.

Cc: Fredrik Kuivinen <frekui@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
This is kind of ugly; I hope there is a better way.  Maybe mingw
make ought to special-case the TAGS name, since this has come up in
other projects[1], too.

[1] e.g., http://thread.gmane.org/gmane.comp.video.mplayer.devel/51542/focus=51545

 Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 40fbcae..a1d4550 100644
--- a/Makefile
+++ b/Makefile
@@ -1952,6 +1952,7 @@ info:
 pdf:
 	$(MAKE) -C Documentation pdf
 
+ifeq (,$(findstring MINGW,$(uname_S)))
 TAGS:
 	$(RM) TAGS
 	$(FIND) . -name '*.[hcS]' -print | xargs etags -a
@@ -1959,6 +1960,7 @@ TAGS:
 tags:
 	$(RM) tags
 	$(FIND) . -name '*.[hcS]' -print | xargs ctags -a
+endif
 
 cscope:
 	$(RM) cscope*
-- 
1.7.2.3
