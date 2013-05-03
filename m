From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 1/4] clone: let the user know when check_everything_connected is run
Date: Fri,  3 May 2013 19:35:11 +0700
Message-ID: <1367584514-19806-2-git-send-email-pclouds@gmail.com>
References: <1367405974-22190-1-git-send-email-pclouds@gmail.com>
 <1367584514-19806-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 03 14:34:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYFCB-0001nj-W0
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 14:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761770Ab3ECMec convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 May 2013 08:34:32 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:40352 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761744Ab3ECMeb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 08:34:31 -0400
Received: by mail-pd0-f178.google.com with SMTP id w11so883719pde.23
        for <git@vger.kernel.org>; Fri, 03 May 2013 05:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=a93qDDlVGWmvECQZ7nLaLdRzLfYghiJljInuiTkuhO0=;
        b=It8of/wCniC5Vv4jxjd24AowToO92WDDj52dCP0FX5ST++wM4fecUUm/CRFZtiaOtQ
         xYyRYx29aKudHnyZTI/U9GkQ1OQwI+dKs0OxuA5HZhJZQTLNqg9dqVA9IlSkJWV7mXod
         y1fKLnm4FfSjwSnDVrLWZKGP9BaYHFpj275oCSTh/T+idR7rp2VjTnzwY69kfMiUKGZV
         pyrEXVhiqvdKnAAvSMi1+VyHnLRigh9J01wpBcukgyf7PLWRSffj6bYT7baJQhXirjOB
         GCWH+K2ByWhjHwCXf+gOUe7Joitrl32zwLwzN45x2HxTTGySZ+6aRvXtmcpqxQPjaBuz
         /QEQ==
X-Received: by 10.66.150.165 with SMTP id uj5mr14479859pab.37.1367584470685;
        Fri, 03 May 2013 05:34:30 -0700 (PDT)
Received: from lanh ([115.74.38.7])
        by mx.google.com with ESMTPSA id sa6sm11518628pbb.26.2013.05.03.05.34.27
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 03 May 2013 05:34:29 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 03 May 2013 19:35:22 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1367584514-19806-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223305>

check_everything_connected could take a long time, especially in the
clone case where the whole DAG is traversed. The user deserves to know
what's going on.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clone.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index 035ab64..dad4265 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -546,8 +546,12 @@ static void update_remote_refs(const struct ref *r=
efs,
 {
 	const struct ref *rm =3D mapped_refs;
=20
+	if (0 <=3D option_verbosity)
+		printf(_("Checking connectivity... "));
 	if (check_everything_connected(iterate_ref_map, 0, &rm))
 		die(_("remote did not send all necessary objects"));
+	if (0 <=3D option_verbosity)
+		printf(_("done\n"));
=20
 	if (refs) {
 		write_remote_refs(mapped_refs);
--=20
1.8.2.83.gc99314b
