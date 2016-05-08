From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 32/41] rerere.c: use error_errno() and warning_errno()
Date: Sun,  8 May 2016 16:47:52 +0700
Message-ID: <1462700881-25108-33-git-send-email-pclouds@gmail.com>
References: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
 <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 11:53:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLNR-0002cx-GQ
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbcEHJvu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 05:51:50 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34881 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbcEHJvt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:51:49 -0400
Received: by mail-pf0-f196.google.com with SMTP id r187so16140814pfr.2
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=58ErpoAVMLSuG4Zu8bRhgSvY8+jH+m9A+GB4WeCWkiQ=;
        b=FYOYgdb+v+ZY9LuxfNJ1O6dp8e1ixKYw9NDIq2wL3dKMZdCMz9rYHc45FxjTq3AAyT
         0AICz0sfqGe5E5orKfR3lvv8q3zInwv/efZOF/op6/gPemxkdtxOjtiB9ogFhpuw9AQb
         sxVbXHixBqLW1jHN7MKxH8505tFg8WgBCnkvM6xognQ0MaoDrOuKFNZRU9JiQ0GiS4Nu
         EBoLuXHol0sOXpGE4YFQ6Y/Um3G4hGbt0kWN2zK0PKQQDBOpZBr1nhO8MxR0fOb9GwvV
         Lr//uWnDdozb3kXa764ZYVzPatYmGK7cfXeEHHqpp3TCK9VKKbJg6EiMoQ7xib8iqzhV
         h81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=58ErpoAVMLSuG4Zu8bRhgSvY8+jH+m9A+GB4WeCWkiQ=;
        b=L5HjfB0xl+OmjNn5oNC7Y1q4esebDsNI+8+aRnZp59Uex+6n5U3GnC6wYj4rHnzgt4
         TRbBKwX051DNjjhbjhldDQ/E3rQKY1TPzM3drIP9baccvQNHKDZf+UMJVgf5y2I/RYLE
         O6xNvcgzRE7NLzbDQunQC9i4GIswL+AKiKgdRoCMCDFH1yTuCYDezRH3JiVAqr0xMM1W
         AOf0f8nLuoPVJOWeuxnCRj5bdRPIM1XYIrTKxBbH0nGDRMQy+W7AH+GPBIUb7E4lshjH
         cFpjGHmybkBVLIearEyrC9Hrj9P+/xxfhv+mrwdbqnT0FeIKfPOFoJw3GEBmg2bWV4pp
         BSDg==
X-Gm-Message-State: AOPr4FUqsBcP5AEYt2PwYTVN5tlb9ru6SCmSHq5WzdGemUW9amxSgrjuXRIuApLRU9J5MA==
X-Received: by 10.98.46.71 with SMTP id u68mr42375880pfu.136.1462701108811;
        Sun, 08 May 2016 02:51:48 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id b64sm32754201pfa.48.2016.05.08.02.51.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:51:47 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:51:48 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293952>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 rerere.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/rerere.c b/rerere.c
index c8b9f40..1810c04 100644
--- a/rerere.c
+++ b/rerere.c
@@ -501,8 +501,7 @@ static int handle_file(const char *path, unsigned c=
har *sha1, const char *output
 		error("There were errors while writing %s (%s)",
 		      path, strerror(io.io.wrerror));
 	if (io.io.output && fclose(io.io.output))
-		io.io.wrerror =3D error("Failed to flush %s: %s",
-				      path, strerror(errno));
+		io.io.wrerror =3D error_errno("Failed to flush %s", path);
=20
 	if (hunk_no < 0) {
 		if (output)
@@ -684,20 +683,17 @@ static int merge(const struct rerere_id *id, cons=
t char *path)
 	 * Mark that "postimage" was used to help gc.
 	 */
 	if (utime(rerere_path(id, "postimage"), NULL) < 0)
-		warning("failed utime() on %s: %s",
-			rerere_path(id, "postimage"),
-			strerror(errno));
+		warning_errno("failed utime() on %s",
+			      rerere_path(id, "postimage"));
=20
 	/* Update "path" with the resolution */
 	f =3D fopen(path, "w");
 	if (!f)
-		return error("Could not open %s: %s", path,
-			     strerror(errno));
+		return error_errno("Could not open %s", path);
 	if (fwrite(result.ptr, result.size, 1, f) !=3D 1)
-		error("Could not write %s: %s", path, strerror(errno));
+		error_errno("Could not write %s", path);
 	if (fclose(f))
-		return error("Writing %s failed: %s", path,
-			     strerror(errno));
+		return error_errno("Writing %s failed", path);
=20
 out:
 	free(cur.ptr);
@@ -1071,7 +1067,7 @@ static int rerere_forget_one_path(const char *pat=
h, struct string_list *rr)
 	if (unlink(filename))
 		return (errno =3D=3D ENOENT
 			? error("no remembered resolution for %s", path)
-			: error("cannot unlink %s: %s", filename, strerror(errno)));
+			: error_errno("cannot unlink %s", filename));
=20
 	/*
 	 * Update the preimage so that the user can resolve the
--=20
2.8.0.rc0.210.gd302cd2
