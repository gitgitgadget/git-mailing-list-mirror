From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 25/41] fast-import.c: use error_errno()
Date: Tue,  3 May 2016 19:03:58 +0700
Message-ID: <1462277054-5943-26-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue May 03 14:08:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ8H-0000ln-KC
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:08:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932860AbcECMIt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 08:08:49 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35050 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932976AbcECMIs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:08:48 -0400
Received: by mail-pf0-f171.google.com with SMTP id 77so9239085pfv.2
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LauUMXXv2uC43czWwgzKxUfWipu6Qv639Ykrm+eOP/M=;
        b=YT5glRIvRf4DSrGzJaH0ZycA49zKf3xg82UGmGiQa7hP0i0yutGi67plRhpq3pXYWU
         01EDVepO5k+cL2t2x4AlP3BK5bYGHzUn7MLurNA8zuh5vtS8gFTZ/Pu5wSAhVJPZPc9r
         ETLM4kaPmk3BIrhLEUkVP5lr/9atkK9ZcPL9U2r+oTsmegDnzRAX9NZN+unT0UQJ1F1h
         q4D/MsPuHlBNuvGjwBiGWQtucee3B3D+GdL37TXIIrPIgK634CfR9JFANhnqsSp45tQ0
         /te9gT53TdSdxq2w3fstsR0BMAdPAsnQFm4gX7aRFG2JeZp4mIUc5p6KLaYl9eS7auja
         Fevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LauUMXXv2uC43czWwgzKxUfWipu6Qv639Ykrm+eOP/M=;
        b=Ll1bhvWv/7rlsQt6stYkaWQuXm66lQYTmQrXblsP6dZz1KgUpvRe/0ohum/icnOaXd
         jz8ScHZncbwQvtyGG+nPThYsELO7/h8EbpuVdld557qiixd2Va3ZzeAQHIFVXaip38ug
         0LDakQQ1ZIlq2E3cctD2B1yCuVBaGNpD5jh5Qbk38ioy558k26818Rh4JL14iRKs6bZK
         pH4KfXx/cYEGnC4ldbsE1kA/ySfkCBiqp7wPkUTDG2qTRC562s9yczloDnUOhLOcA0Gk
         n/s7UhFiUo+YnEXZJVf+dz/PbUdPeYvaGZaLjroibEnXZx6Sa0AMQB841Fat12J7WrmL
         SxWQ==
X-Gm-Message-State: AOPr4FU+pv3XNJnZkmn1OzNTi+JXG338/KPIcR6LiSxC6fGbMBw9uxNMzvb8+VeWRIoF9Q==
X-Received: by 10.98.72.199 with SMTP id q68mr2915669pfi.164.1462277328066;
        Tue, 03 May 2016 05:08:48 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id p1sm5533546paz.8.2016.05.03.05.08.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:08:46 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:08:43 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293378>

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
