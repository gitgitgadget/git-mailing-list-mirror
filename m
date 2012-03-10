From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 2/2] perl/Makefile: install Git::I18N under NO_PERL_MAKEMAKER
Date: Sat, 10 Mar 2012 12:29:35 +0000
Message-ID: <1331382575-16936-3-git-send-email-avarab@gmail.com>
References: <CACBZZX5wHEigiYjn6ahmnXN3wd9sEyDnRV2EZiP+JSUCc182TQ@mail.gmail.com>
 <1331382575-16936-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Tom G. Christensen" <tgc@statsbiblioteket.dk>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 10 13:31:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6LSC-0006pS-SI
	for gcvg-git-2@plane.gmane.org; Sat, 10 Mar 2012 13:31:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224Ab2CJMbQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Mar 2012 07:31:16 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:62429 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753146Ab2CJMbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2012 07:31:16 -0500
Received: by wejx9 with SMTP id x9so1827759wej.19
        for <git@vger.kernel.org>; Sat, 10 Mar 2012 04:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=EnSNNHctxnK3ujx8f0WhGFYZ8xu67MsLOzNe/yNMd94=;
        b=SnHEw7LwYvZy6dKwkJ4Dt1qPLLMtaYAypJ6I5q83VVSS9VFRX74aH6cAUB1FP/TX6r
         milpBdVeVZIzlilC+yJlwKUrmm6CL32gYXmtu3fcWDySp4d++k+ZajWOnmWNzUWa7k3N
         hzlIJvccwUc8k2jr1nEg78qkeq/eKVAYm7xw44KPR7Tv8XfCJXdG92jcHcMD7xtYJQzL
         WRqsmTtF5tI3OKuwkKw4s7Q4uAn/cB8SbvJSTGccry1T/Oj005aAk3w4oUr5QKMSIUO2
         rpr2kr5FPAiBFlbBow816gDFFeGGHm5oyri7HS9U8Uc3SLIx+HUlqIpQggmYgExOCGFX
         TWwA==
Received: by 10.216.138.223 with SMTP id a73mr3431559wej.86.1331382610754;
        Sat, 10 Mar 2012 04:30:10 -0800 (PST)
Received: from w.nix.is (w.nix.is. [188.40.98.140])
        by mx.google.com with ESMTPS id e6sm10892551wix.8.2012.03.10.04.30.09
        (version=SSLv3 cipher=OTHER);
        Sat, 10 Mar 2012 04:30:10 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1331382575-16936-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192780>

When I added the i18n infrastructure in v1.7.8-rc2-1-g5e9637c I forgot
to install Git::I18N also when NO_PERL_MAKEMAKER=3DYesPlease was
set. Change the generation of the fallback perl.mak file to do that.

Now Git/I18N.pm is installed alongside Git.pm in such a way that
anything that uses GITPERLLIB will find it.

Reported-by: Tom G. Christensen <tgc@statsbiblioteket.dk>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 perl/Makefile |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/perl/Makefile b/perl/Makefile
index b2977cd..9af9025 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -23,20 +23,25 @@ clean:
 ifdef NO_PERL_MAKEMAKER
 instdir_SQ =3D $(subst ','\'',$(prefix)/lib)
 $(makfile): ../GIT-CFLAGS Makefile
-	echo all: private-Error.pm Git.pm > $@
+	echo all: private-Error.pm Git.pm Git/I18N.pm > $@
 	echo '	mkdir -p blib/lib' >> $@
+	echo '	mkdir -p blib/lib/Git' >> $@
 	echo '	$(RM) blib/lib/Git.pm; cp Git.pm blib/lib/' >> $@
+	echo '	$(RM) blib/lib/Git/I18N.pm; cp Git/I18N.pm blib/lib/Git/' >> $=
@
 	echo '	$(RM) blib/lib/Error.pm' >> $@
 	'$(PERL_PATH_SQ)' -MError -e 'exit($$Error::VERSION < 0.15009)' || \
 	echo '	cp private-Error.pm blib/lib/Error.pm' >> $@
 	echo install: >> $@
 	echo '	mkdir -p "$$(DESTDIR)$(instdir_SQ)"' >> $@
+	echo '	mkdir -p "$$(DESTDIR)$(instdir_SQ)/Git"' >> $@
 	echo '	$(RM) "$$(DESTDIR)$(instdir_SQ)/Git.pm"; cp Git.pm "$$(DESTDIR=
)$(instdir_SQ)"' >> $@
+	echo '	$(RM) "$$(DESTDIR)$(instdir_SQ)/Git/I18N.pm"; cp Git/I18N.pm "=
$$(DESTDIR)$(instdir_SQ)/Git"' >> $@
 	echo '	$(RM) "$$(DESTDIR)$(instdir_SQ)/Error.pm"' >> $@
 	'$(PERL_PATH_SQ)' -MError -e 'exit($$Error::VERSION < 0.15009)' || \
 	echo '	cp private-Error.pm "$$(DESTDIR)$(instdir_SQ)/Error.pm"' >> $@
 	echo instlibdir: >> $@
 	echo '	echo $(instdir_SQ)' >> $@
+	echo '	echo $(instdir_SQ)/Git' >> $@
 else
 $(makfile): Makefile.PL ../GIT-CFLAGS
 	$(PERL_PATH) $< PREFIX=3D'$(prefix_SQ)' INSTALL_BASE=3D'' --localedir=
=3D'$(localedir_SQ)'
--=20
1.7.9
