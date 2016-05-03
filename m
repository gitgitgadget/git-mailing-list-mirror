From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 32/41] rerere.c: use error_errno() and warning_errno()
Date: Tue,  3 May 2016 19:04:05 +0700
Message-ID: <1462277054-5943-33-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
 <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 14:09:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ8z-0001BI-Cb
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933074AbcECMJd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 08:09:33 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34012 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932274AbcECMJc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:09:32 -0400
Received: by mail-pa0-f44.google.com with SMTP id r5so9241834pag.1
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=58ErpoAVMLSuG4Zu8bRhgSvY8+jH+m9A+GB4WeCWkiQ=;
        b=HDJjqwwTT+LkbhQgVjq/yp6mUO52kzs/fsGDaZBZUqGvrk4KXh/cyAcPALC5bUxR3d
         HVFedPRjhcfFZ4ymy3AzsvLcw7QVxAWWBeaHSXZi+3ZdK7kg18mZonBg6K4bXPL8K3M5
         2zQDBzrvhF2z8uv/BXHH5i2dRYVfg/muGBjTdq5ZyGx2y2S0mU8WOjfDUJ2x1R28yc4q
         T9WZ+HhkVbDaWgyKqGBOmTIkiqiDtEfrah+YZMFgVxPVf/rN5k9rz6Duss38Os7mC4C5
         FdyeLqmF8J2AOVD25luOsTm6kZTFQjtzHBxXwslcJFXIJte5HjEdBXnc1sMfrGlsGHYG
         88Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=58ErpoAVMLSuG4Zu8bRhgSvY8+jH+m9A+GB4WeCWkiQ=;
        b=ZnlexdjsayQyOb/oQl3/j9bsPeYuI8YtQPO/Kw/RIEYFZ4lFhHo6k0OAe3W000ZgFg
         iKyt2owr0UZKprGq4ppiPnRb2gSb087FU0te/HvVDJDk3XGV+2Tzpo1W6Xog9MtO2FO9
         Or8ulSsj8wmZMwQS9KQFl/IT1uaDyYhDuG97N5xK9wUTlLzgq8RSC7vA0VpiZi3+lF5Y
         f38ssZCRjvBioCSX8E98u7y2dRtwak4/rFBsdKowJ0g4LThxikoPeiw+vVRf7LAU/O3c
         PE0DqwzfObioJWpqfhmhlwjJQ4+sWMSr71ij3214TaPN3Bramvglu3peUo7aHY6pv/wY
         Vbfw==
X-Gm-Message-State: AOPr4FU5vKScnPHsCiSzCTZDKOYZGEKuTIBQC7yFuSMmbc7yVMfN88kdG8qErjQj38xAsg==
X-Received: by 10.66.189.135 with SMTP id gi7mr2916503pac.158.1462277371948;
        Tue, 03 May 2016 05:09:31 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id g84sm5521338pfj.42.2016.05.03.05.09.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:09:30 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:09:27 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293385>

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
