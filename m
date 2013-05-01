From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/5] clone: let the user know when check_everything_connected is run
Date: Wed,  1 May 2013 17:59:30 +0700
Message-ID: <1367405974-22190-2-git-send-email-pclouds@gmail.com>
References: <1364728148-7537-1-git-send-email-pclouds@gmail.com>
 <1367405974-22190-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 01 12:59:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXUkU-00076K-PI
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 12:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759844Ab3EAK6z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 May 2013 06:58:55 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:56671 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756263Ab3EAK6x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 06:58:53 -0400
Received: by mail-pb0-f54.google.com with SMTP id jt11so691111pbb.13
        for <git@vger.kernel.org>; Wed, 01 May 2013 03:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=a93qDDlVGWmvECQZ7nLaLdRzLfYghiJljInuiTkuhO0=;
        b=ah78Ayns3w/PTOoIvPZGuaIV4KT+i/YbK1jH72v8uw+uJ32Ljv9i4ius3fid77a3Ub
         kY/0FtTFvh66jCdYnD0ZAwDqG9xohQyMull1OQ/Xs3GcuADgWwK4VdV2EdiqQ2rgZLQy
         y4jSB9KXBVzS+XezZd45VYnPlNlTmHDZwGsz+7moiOa1EalEHOFXfZQEdla5Umz/SrLX
         s1wHt0OuKErY0TEusHaPDEKpPHOwS6yqLJFaKWd3Fw9577EuAp958ZhRScJfdvKuZhAF
         0Rfnzo7GlZE70wMOXDP2hQ8iJwLd0e6DeLngPawntD9pd7jsYwpI+NmHrg/IEfvlu6Bk
         +6Ww==
X-Received: by 10.68.164.3 with SMTP id ym3mr3311672pbb.205.1367405933168;
        Wed, 01 May 2013 03:58:53 -0700 (PDT)
Received: from lanh ([115.74.47.19])
        by mx.google.com with ESMTPSA id be7sm3209966pad.20.2013.05.01.03.58.49
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 01 May 2013 03:58:52 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 01 May 2013 17:59:42 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1367405974-22190-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223081>

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
