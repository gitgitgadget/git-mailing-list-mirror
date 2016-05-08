From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 25/41] fast-import.c: use error_errno()
Date: Sun,  8 May 2016 16:47:45 +0700
Message-ID: <1462700881-25108-26-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun May 08 11:52:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLMl-0001qV-3U
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbcEHJvG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 05:51:06 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34441 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbcEHJvF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:51:05 -0400
Received: by mail-pa0-f67.google.com with SMTP id yl2so13705506pac.1
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LauUMXXv2uC43czWwgzKxUfWipu6Qv639Ykrm+eOP/M=;
        b=sO/semxLBKFHJ7IKADxzloWqtL26dnp6fSr+fJQhaK3h+VgGfRtMmD6Xp7nrBXDP4S
         ODceSdHnhz1uS05wQg96dVp7Iktn0oZ/HECqb4pQGU4ZaiLUv+ceeaMZEyK1PfdJK2/B
         VWFWmgKhQzn5JqdRxzuZuzkaxTtCPsII6+ArVmD3pqQu+cstRY+JcXq5PCZsEFvxIz9S
         2V1nJF0wx/t8eUauOT3lNCRK9RYYTc/Zi3sojp8t8x4VANZbPjLjegnAOSm88SyNbnj7
         Fi6RmGv2dNHNuIujF9Tjp5hvt21qM2Y4Z7DXCvGR4MiwTM+UtW+rV6ap8k+D0fDoKBdc
         sdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LauUMXXv2uC43czWwgzKxUfWipu6Qv639Ykrm+eOP/M=;
        b=YIu0pleK6N9kkwFHMazq9MVineuHjJLp96bGxPKP6wjFGqwAx9LF71HAV5+Ddl2oDO
         HuXmxUhnH7iidJHjvWvbo9wOYIUw3H7QU3f49QK4bR+6oZgn9ohKJ1uKj24J+2V2mitw
         Bqwb+p2IX3Tpj5j3MkVYJxtj7KD0en+cVy0cRlOITEkmKj04uh0uS/T4R7eDneAbfgV6
         LhnCm75+f5Qt8xy4NpPwEPGFIx7qKbAO9KTeoOdJjM87pCxNYdDNQiJX9HZFuz57o548
         kToYoGNP/wsW//mioCilW+Bl+uadfhv7KoFTSH6v/RKTSgs4gtr8Q6pBnxtgj97XsMAy
         vd+w==
X-Gm-Message-State: AOPr4FV0X94tM3QVjP6hzMALHyMoj1ZMdqAZc4zNNejB5Zanz/JFZwDkIJDRexelJgF7BQ==
X-Received: by 10.66.175.110 with SMTP id bz14mr41966980pac.41.1462701064681;
        Sun, 08 May 2016 02:51:04 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id lz5sm32858703pab.34.2016.05.08.02.51.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:51:03 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:51:04 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293941>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 fast-import.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 9fc7093..21881d1 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -414,7 +414,7 @@ static void write_crash_report(const char *err)
 	struct recent_command *rc;
=20
 	if (!rpt) {
-		error("can't write crash report %s: %s", loc, strerror(errno));
+		error_errno("can't write crash report %s", loc);
 		free(loc);
 		return;
 	}
@@ -1806,8 +1806,8 @@ static void dump_marks(void)
 		return;
=20
 	if (hold_lock_file_for_update(&mark_lock, export_marks_file, 0) < 0) =
{
-		failure |=3D error("Unable to write marks file %s: %s",
-			export_marks_file, strerror(errno));
+		failure |=3D error_errno("Unable to write marks file %s",
+				       export_marks_file);
 		return;
 	}
=20
@@ -1822,8 +1822,8 @@ static void dump_marks(void)
=20
 	dump_marks_helper(f, 0, marks);
 	if (commit_lock_file(&mark_lock)) {
-		failure |=3D error("Unable to write file %s: %s",
-			export_marks_file, strerror(errno));
+		failure |=3D error_errno("Unable to write file %s",
+				       export_marks_file);
 		return;
 	}
 }
--=20
2.8.0.rc0.210.gd302cd2
