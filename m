From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 28/32] read-tree: force split-index mode off on --index-output
Date: Mon, 28 Apr 2014 17:55:49 +0700
Message-ID: <1398682553-11634-29-git-send-email-pclouds@gmail.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 12:57:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WejFQ-0003tZ-7l
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 12:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbaD1K5F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 06:57:05 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:56826 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932070AbaD1K5D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 06:57:03 -0400
Received: by mail-pd0-f172.google.com with SMTP id w10so5614947pde.3
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 03:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=O5BgyoX2PujU37h2JhtVsgxaqYC5TnQgAuNnM2V2YW0=;
        b=PmOIYUgwGwZ9rzOp7casaLYV+j6upbiOJGK9pmRMMkB9tenUMeTVwA03iJ6tNwd/Ru
         om8OHazXnyqcWQPVhXr88+iaGK+XZXVsP1qsM8Dx/hmlsh8QRzlgKPQ54OJemu8SSdDu
         jnPVg5riBazN13XNZWz8E+zJUhVbRmzoFh7TiaSWO5ylUvPH7dGmXnsjf2Ll4XDEy0gH
         tmgMYgJyWea21KErQcFnlLAMU6dR15n4eWUnrtDDhWWMM2rTLjA4O2jvZlsPMVlWIHl5
         2WAoJIU1Nn+JYmBOg0PSSGGEQjPR88SgIatCVXXXPhFtVDo1Uh3ExEoGw9vypPzRcgaz
         vMVA==
X-Received: by 10.68.130.137 with SMTP id oe9mr27783604pbb.21.1398682621845;
        Mon, 28 Apr 2014 03:57:01 -0700 (PDT)
Received: from lanh ([115.73.231.31])
        by mx.google.com with ESMTPSA id ba3sm18388269pbb.10.2014.04.28.03.56.59
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 03:57:01 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Apr 2014 17:58:30 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247293>

Just a (paranoid?) safety measure..

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 read-cache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index f9fc3a5..568bc20 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2070,7 +2070,8 @@ int write_locked_index(struct index_state *istate=
, struct lock_file *lock,
 {
 	struct split_index *si =3D istate->split_index;
=20
-	if (!si || (istate->cache_changed & ~EXTMASK)) {
+	if (!si || alternate_index_output ||
+	    (istate->cache_changed & ~EXTMASK)) {
 		if (si)
 			hashclr(si->base_sha1);
 		return do_write_locked_index(istate, lock, flags);
--=20
1.9.1.346.ga2b5940
