From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 8/8] Provide a build time default-pager setting
Date: Fri, 30 Oct 2009 05:39:25 -0500
Message-ID: <20091030103925.GI1610@progeny.tock>
References: <1256742357-sup-3798@ntdws12.chass.utoronto.ca>
 <7vskd3o11t.fsf@alter.siamese.dyndns.org>
 <20091029073224.GA15403@progeny.tock>
 <20091029075021.GC15403@progeny.tock>
 <7v8weu6idl.fsf@alter.siamese.dyndns.org>
 <20091030101634.GA1610@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 11:29:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3ojY-0001Am-Sa
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 11:29:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757050AbZJ3K3Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Oct 2009 06:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756993AbZJ3K3O
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 06:29:14 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:46969 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757037AbZJ3K3J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 06:29:09 -0400
Received: by ywh40 with SMTP id 40so2535857ywh.33
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 03:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=MsM4vsPl+e4yypa6RUAEpnQpJV4cTS6UZO4x3KAPXXc=;
        b=gLGbHk8EmZ3dPYgyaDwWi4Sc+bOov2EFkbotQxHiu64+OEvYOw27+37SO6N6FHKwxH
         jhoIuvqxmFGpIpM2VQ16d2IshOOIvxnguk8jBcn20lnH8/Vc6bjTZXSYMM52A+T7uvEy
         jnWKXlLZGeefg2x3FMLAs3U53RoNiGA8IKpMU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=qXoyrsCYY4WwdXLHNjqBSyNF6aOWbRl/VBLw0X8Sv7IW9cYE3cnYkzkZn+8Ol/jGbz
         uTCTz0LW0fBgQOjp3L1O/DFwSyef88wP+x/BskjgOjV4rfxw54wo9ABChYmLqMAzx2sP
         OUBAZNXnEdlFjboBvzVp08AbFKDQnqRsPYE9Q=
Received: by 10.91.153.15 with SMTP id f15mr3843320ago.77.1256898554575;
        Fri, 30 Oct 2009 03:29:14 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 35sm1303452yxh.69.2009.10.30.03.29.13
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Oct 2009 03:29:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091030101634.GA1610@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131692>

=46rom: Junio C Hamano <gitster@pobox.com>

Provide a DEFAULT_PAGER knob so packagers can set the fallback
pager to something appropriate during the build.

Examples:

On (old) solaris systems, /usr/bin/less (typically the first less
found) doesn't understand the default arguments (FXRS), which
forces users to alter their environment (PATH, GIT_PAGER, LESS,
etc) or have a local or global gitconfig before paging works as
expected.

On Debian systems, by policy packages must fall back to the
'pager' command, so that changing the target of the
/usr/bin/pager symlink changes the default pager for all packages
at once.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Previously I suggested that the default pager isn=E2=80=99t being track=
ed
properly with TRACK_CFLAGS.  Actually, since it is included in
BASIC_CFLAGS, it always was.  Sorry for the confusion.

 Makefile |   11 +++++++++++
 pager.c  |    6 +++++-
 2 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 625866c..18fc50a 100644
--- a/Makefile
+++ b/Makefile
@@ -201,6 +201,10 @@ all::
 #
 # Define NO_REGEX if you have no or inferior regex support in your C l=
ibrary.
 #
+# Define DEFAULT_PAGER to a sensible pager command (defaults to "less"=
) if
+# you want to use something different.  The value will be interpreted =
by the
+# shell at runtime when it is used.
+#
 # Define DEFAULT_EDITOR to a sensible editor command (defaults to "vi"=
) if you
 # want to use something different.  The value will be interpreted by t=
he shell
 # if necessary when it is used.  Examples:
@@ -1380,6 +1384,13 @@ DEFAULT_EDITOR_CQ_SQ =3D $(subst ','\'',$(DEFAUL=
T_EDITOR_CQ))
 BASIC_CFLAGS +=3D -DDEFAULT_EDITOR=3D'$(DEFAULT_EDITOR_CQ_SQ)'
 endif
=20
+ifdef DEFAULT_PAGER
+DEFAULT_PAGER_CQ =3D "$(subst ",\",$(subst \,\\,$(DEFAULT_PAGER)))"
+DEFAULT_PAGER_CQ_SQ =3D $(subst ','\'',$(DEFAULT_PAGER_CQ))
+
+BASIC_CFLAGS +=3D -DDEFAULT_PAGER=3D'$(DEFAULT_PAGER_CQ_SQ)'
+endif
+
 ALL_CFLAGS +=3D $(BASIC_CFLAGS)
 ALL_LDFLAGS +=3D $(BASIC_LDFLAGS)
=20
diff --git a/pager.c b/pager.c
index 0b63d99..92c03f6 100644
--- a/pager.c
+++ b/pager.c
@@ -2,6 +2,10 @@
 #include "run-command.h"
 #include "sigchain.h"
=20
+#ifndef DEFAULT_PAGER
+#define DEFAULT_PAGER "less"
+#endif
+
 /*
  * This is split up from the rest of git so that we can do
  * something different on Windows.
@@ -60,7 +64,7 @@ const char *git_pager(void)
 	if (!pager)
 		pager =3D getenv("PAGER");
 	if (!pager)
-		pager =3D "less";
+		pager =3D DEFAULT_PAGER;
 	else if (!*pager || !strcmp(pager, "cat"))
 		pager =3D NULL;
=20
--=20
1.6.5.2
