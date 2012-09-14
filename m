From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Makefile: respect $LINGUAS variable on selecting .mo files to install
Date: Fri, 14 Sep 2012 19:40:18 +0700
Message-ID: <1347626418-14032-1-git-send-email-pclouds@gmail.com>
References: <CACsJy8DKUdn-eY1P1d6vFz34SvEbUBm07ZR3xy5xLaKxE+Wnqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 14 14:40:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCVCM-0003KQ-Ir
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 14:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541Ab2INMke convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Sep 2012 08:40:34 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:60266 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017Ab2INMkd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 08:40:33 -0400
Received: by oago6 with SMTP id o6so2790719oag.19
        for <git@vger.kernel.org>; Fri, 14 Sep 2012 05:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=JBTUa+PoyM6dkYWFT8yf21f56BhYMD+vNaFl+GWEb+I=;
        b=UAPnzJ+ceE60xE1TNiLQMR3dy2vtS2EIOw9hYj9QJQNW6Iw+YvnKInLolZUN8l7K51
         jT6eQdKlbRplFMxOQRXcalu5JDp8Sh1EwhExyI5oyV12va8AYzVJxmAupvo5irus90Cn
         wVVUi8qfv0T84Ji0eqwcFB+tZjHTz58/AKDN6Y/M9HHXbjNrgOQPmW9EmEd7v7nR7DSr
         1Wtss6CpArDiH/MlZT6KUNHfjea+WHuAxKNenxbX04ynnGLYP+y1cJ2+T52RpXO2HBSi
         Koj0Ws+zNxBhZo4Qc8FBYO/puw4XPR87jfKdZx/vOMB7D7lbFR95G3tiROPfYgHyo4pO
         NbyQ==
Received: by 10.60.172.143 with SMTP id bc15mr2852613oec.73.1347626433207;
        Fri, 14 Sep 2012 05:40:33 -0700 (PDT)
Received: from lanh ([115.74.49.150])
        by mx.google.com with ESMTPS id bp7sm1683537obc.12.2012.09.14.05.40.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Sep 2012 05:40:32 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 14 Sep 2012 19:40:33 +0700
X-Mailer: git-send-email 1.7.12.403.gce5cf6f.dirty
In-Reply-To: <CACsJy8DKUdn-eY1P1d6vFz34SvEbUBm07ZR3xy5xLaKxE+Wnqg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205485>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Fri, Sep 14, 2012 at 6:35 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.c=
om> wrote:
 > We should honor LINGUAS variable on installation. Only languages
 > listed in that variable are installed. Many if not most of projects =
do
 > that already.

 And here is a try.

 Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index 56301dc..eeba645 100644
--- a/Makefile
+++ b/Makefile
@@ -2437,7 +2437,11 @@ po/git.pot: $(LOCALIZED_C)
=20
 pot: po/git.pot
=20
+ifdef LINGUAS
+POFILES :=3D $(shell sh -c "ls $(patsubst %,po/%.po,$(LINGUAS)) 2>/dev=
/null")
+else
 POFILES :=3D $(wildcard po/*.po)
+endif
 MOFILES :=3D $(patsubst po/%.po,po/build/locale/%/LC_MESSAGES/git.mo,$=
(POFILES))
=20
 ifndef NO_GETTEXT
--=20
1.7.12.403.gce5cf6f.dirty
