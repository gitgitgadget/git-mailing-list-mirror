From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] Makefile: fix header dependency checker to allow
 NO_CURL builds
Date: Sat, 8 May 2010 22:57:28 -0500
Message-ID: <20100509035728.GA8198@progeny.tock>
References: <20100509035536.GA8118@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 09 05:57:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAxdY-0001YG-VC
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 05:57:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754402Ab0EID41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 23:56:27 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63063 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678Ab0EID40 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 23:56:26 -0400
Received: by gyg13 with SMTP id 13so1369671gyg.19
        for <git@vger.kernel.org>; Sat, 08 May 2010 20:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Jyy4/xLoYT2swonEZBRsJH5Ck11T17D/+PV3jCzRaQo=;
        b=cvq3fZHTN4n9395S4mQg6L0BhcngechYOYzvuR0aFKEWoIbDia7el8EA8LoLyhxKFG
         2tKhI4lO/8UapLPUP/qNujQvRBvvvMuFZgsm8lDdoGTjecje0cnmlFSgBTX6JQTmwZS2
         a541KuUlh9nv+qH0ouMq0v+Z8deBTSEaQ4cH4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FbJF6haBLhJn7kbPqjr9QPG/W4MEzSQW4wn7V9YbFhdSf6vaecv9g5m9TB5Us4l9IM
         SxsQjeLR3CiGwNw+5oPVmWO2ExOU3ka8j2A5nOEnCR6eFNJIUKt+B/cqaxVQUAvC3Je3
         5Kf6vG59KRUxC9SLFOP7Tarkipx1Wih9TuUkc=
Received: by 10.150.244.8 with SMTP id r8mr5916267ybh.206.1273377385998;
        Sat, 08 May 2010 20:56:25 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm2594614yxe.13.2010.05.08.20.56.24
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 08 May 2010 20:56:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100509035536.GA8118@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146700>

Do not expect to find http-related dependency fragments after a build
with HTTP support disabled.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 910f471..567b859 100644
--- a/Makefile
+++ b/Makefile
@@ -1656,7 +1656,10 @@ git.o git.spec \
 
 TEST_OBJS := $(patsubst test-%$X,test-%.o,$(TEST_PROGRAMS))
 GIT_OBJS := $(LIB_OBJS) $(BUILTIN_OBJS) $(PROGRAM_OBJS) $(TEST_OBJS) \
-	git.o http.o http-walker.o remote-curl.o
+	git.o
+ifndef NO_CURL
+	GIT_OBJS += http.o http-walker.o remote-curl.o
+endif
 XDIFF_OBJS = xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
 	xdiff/xmerge.o xdiff/xpatience.o
 OBJECTS := $(GIT_OBJS) $(XDIFF_OBJS)
-- 
1.7.1
