From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/12] refs.c: use skip_prefix() in prune_ref()
Date: Wed, 18 Dec 2013 21:53:57 +0700
Message-ID: <1387378437-20646-13-git-send-email-pclouds@gmail.com>
References: <1387378437-20646-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 18 15:55:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtIX1-0004SF-7q
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 15:55:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755215Ab3LROzS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Dec 2013 09:55:18 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:53866 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754693Ab3LROzR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 09:55:17 -0500
Received: by mail-pa0-f51.google.com with SMTP id fa1so6071570pad.10
        for <git@vger.kernel.org>; Wed, 18 Dec 2013 06:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=OHJeKh0UdCqULQZHjMshvKdxh0fVBR7bO/oiHuzEaPQ=;
        b=x30+Kp/8tyfgvYMuVAee9fGPcRL3t42G5h7N5hEU+at/lTpwHhLy1RkXxN456IXRLS
         xyiSZa0LXGhx7+pPWPoHQMlYCykNCesUY5C+JI6VMF17V5cnbnVbLEjZuHp4JM9GKtvT
         OjU2iYZ6njSY4DZ4nwtb+0Pr4jnm8RPGRjdsnRqryVUM5zDzKwv++pCY8i8aK+ceYoFr
         wcO22eUz8Wffbqy57Mx/CxwjEEcyJ6jejh13jmFob42ALn5ZaypxR28R8hUg3HSovLUV
         URXe2VFgjWBHq1YLAudEH6yKAms8xLGzaczq4jX87uo9fpK+EhuXH+a2QgZ7KKC+1AWG
         RmHg==
X-Received: by 10.68.12.138 with SMTP id y10mr34359615pbb.101.1387378516650;
        Wed, 18 Dec 2013 06:55:16 -0800 (PST)
Received: from lanh ([115.73.220.136])
        by mx.google.com with ESMTPSA id ql10sm505032pbc.44.2013.12.18.06.55.13
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Dec 2013 06:55:15 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 18 Dec 2013 21:55:13 +0700
X-Mailer: git-send-email 1.8.5.1.208.g019362e
In-Reply-To: <1387378437-20646-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239449>

This removes the magic number 5, which is the string length of
"refs/". This comes from get_loose_refs(), called in packed_refs().

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 refs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 1fb658f..217093f 100644
--- a/refs.c
+++ b/refs.c
@@ -2318,7 +2318,8 @@ static void try_remove_empty_parents(char *name)
 /* make sure nobody touched the ref, and unlink */
 static void prune_ref(struct ref_to_prune *r)
 {
-	struct ref_lock *lock =3D lock_ref_sha1(r->name + 5, r->sha1);
+	const char *name =3D skip_prefix_defval(r->name, "refs/", r->name);
+	struct ref_lock *lock =3D lock_ref_sha1(name, r->sha1);
=20
 	if (lock) {
 		unlink_or_warn(git_path("%s", r->name));
--=20
1.8.5.1.208.g019362e
