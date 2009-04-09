From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/3] attr: add GIT_ATTR_INDEX "direction"
Date: Thu,  9 Apr 2009 17:01:29 +1000
Message-ID: <1239260490-6318-3-git-send-email-pclouds@gmail.com>
References: <1239260490-6318-1-git-send-email-pclouds@gmail.com>
 <1239260490-6318-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Apr 09 09:04:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LroId-0004of-Vh
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 09:03:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755537AbZDIHBx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Apr 2009 03:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754974AbZDIHBw
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 03:01:52 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:2112 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753830AbZDIHBv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 03:01:51 -0400
Received: by wf-out-1314.google.com with SMTP id 29so498805wff.4
        for <git@vger.kernel.org>; Thu, 09 Apr 2009 00:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ub1F4cD3KI1gEWYS8Oelx292hWTxEyNVR6cp7Zsr8pc=;
        b=ltciQJtq702eZMVPrw9dGSWbCHOU6ngW0S6XQlZucvlmyom8RTeSnXIaEUBpvp6ljp
         7OJXKU6VR8LEAPqk5Mu7+IXMlnwDsGi5XkFGgDJKL5l5rlsSNvAXzZ+ypOX2ZE8gpZg8
         whLD4X1h+U6Le1so3Bsbuo/AnzY22iDScvxrE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=GW6ZMnbPEO4ToFQaf1ti1b+5cPnIhZckTCFW/4eG7q92jmbm1J0L9sggCYgLOC/cbK
         yNHT3f4CLrcBIGxc871hKp9XKK6noHEdxG9osqDUpIQxypel39BpcCHCoBKVs7oMsh3Q
         jPqOdp3dlF/Z2Lup6y3KlxncG5T6z/4SAgwF0=
Received: by 10.143.12.20 with SMTP id p20mr768692wfi.169.1239260511369;
        Thu, 09 Apr 2009 00:01:51 -0700 (PDT)
Received: from dektop (dektec.lnk.telstra.net [203.45.32.221])
        by mx.google.com with ESMTPS id 20sm1395286wfi.32.2009.04.09.00.01.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Apr 2009 00:01:50 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Thu,  9 Apr 2009 17:01:45 +1000
X-Mailer: git-send-email 1.6.2.2.602.g83ee9f
In-Reply-To: <1239260490-6318-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116142>

This instructs attr mechanism, not to look into working .gitattributes
at all. Needed by tools that does not handle working directory, such
as "git archive".

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 attr.c |    4 +++-
 attr.h |    3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/attr.c b/attr.c
index 43259e5..37ca288 100644
--- a/attr.c
+++ b/attr.c
@@ -405,7 +405,7 @@ static struct attr_stack *read_attr(const char *pat=
h, int macro_ok)
 		if (!res)
 			res =3D read_attr_from_file(path, macro_ok);
 	}
-	else {
+	else if (direction =3D=3D GIT_ATTR_CHECKIN) {
 		res =3D read_attr_from_file(path, macro_ok);
 		if (!res)
 			/*
@@ -415,6 +415,8 @@ static struct attr_stack *read_attr(const char *pat=
h, int macro_ok)
 			 */
 			res =3D read_attr_from_index(path, macro_ok);
 	}
+	else
+		res =3D read_attr_from_index(path, macro_ok);
 	if (!res)
 		res =3D xcalloc(1, sizeof(*res));
 	return res;
diff --git a/attr.h b/attr.h
index 3a2f4ec..69b5767 100644
--- a/attr.h
+++ b/attr.h
@@ -33,7 +33,8 @@ int git_checkattr(const char *path, int, struct git_a=
ttr_check *);
=20
 enum git_attr_direction {
 	GIT_ATTR_CHECKIN,
-	GIT_ATTR_CHECKOUT
+	GIT_ATTR_CHECKOUT,
+	GIT_ATTR_INDEX,
 };
 void git_attr_set_direction(enum git_attr_direction, struct index_stat=
e *);
=20
--=20
1.6.2.2.602.g83ee9f
