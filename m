From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 17/41] compat/win32/syslog.c: use warning_errno()
Date: Tue,  3 May 2016 19:03:50 +0700
Message-ID: <1462277054-5943-18-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue May 03 14:08:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ7Z-0000Pj-13
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:08:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755900AbcECMH7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 08:07:59 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34669 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755759AbcECMH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:07:58 -0400
Received: by mail-pa0-f53.google.com with SMTP id r5so9223610pag.1
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ytrv7VsD9KFUU59IXJ+UOnzp7KtbwGWbBKeUHdmDiuI=;
        b=q9oMy+i/Txv56R03WNq06P/RkDNanofCkuysLiKflZFkSmTf7CazpjRXkfymByITuq
         sD9Grm/nI0WyA2q9bBzB6RAJJn/EOB+plAJjdmANKJXkBqpDn2aV0LNWps2QAXNDihfE
         d0Eq0qKi8v3l4bwgLBPESA3ZQN8//yGPvIeEMt+reG18T9aHo6Ga9IPu8LkSVKxSnBRG
         HzK1u44R21GJ4NwuCzFw/FxFebx2kirYFXjak6bLipPUB/V04jm5yukaEI1RVAwyGYgi
         MplJW95aIDkZMCtPjeic3GlfDGcz6sBijm1eLIvIKg2rp+8lplJcHZgY1xtvXPsyHVur
         OYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ytrv7VsD9KFUU59IXJ+UOnzp7KtbwGWbBKeUHdmDiuI=;
        b=QAFfrQCd2Bwhy5B847I3yJ/qnLFrW2NpX3rF5HZz4JxYMRnzAC0yS11hsfFR8T9DDy
         dcBGLApoI6hBw90Rjdb4cn6M8XGfZt0wVA5wmXlZ0WU5ul+TYmIugJf1FIgBWSwvZENu
         KD98iCmokRpDvgJTjLcJNmr+dhXrnTfeBPivm71EX/dkDJ5E65ggWk614J9S8BYc4qy4
         qzWmyhuuvHYG1U0RCFgw70QlTyeZlvJp2huTxXbHhxaGg/zMQs25uOMq0Lf/q3Y/RoQ0
         drSqKdTp1LYG2bugOBvLbSsIiShgqyCDq9XJeICcK4JAVowvuka4f3XSevMg+uLs81Me
         ldmw==
X-Gm-Message-State: AOPr4FUH0E+cVTEod1a69sGU4L+y2ds9l5CMhLWg1/076LrH+cxp+fMzrhQ7OxgxgueF3g==
X-Received: by 10.66.26.225 with SMTP id o1mr2864681pag.79.1462277277510;
        Tue, 03 May 2016 05:07:57 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id zn12sm5522943pab.14.2016.05.03.05.07.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:07:56 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:07:53 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293369>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 compat/win32/syslog.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/compat/win32/syslog.c b/compat/win32/syslog.c
index b905aea..6c7c9b6 100644
--- a/compat/win32/syslog.c
+++ b/compat/win32/syslog.c
@@ -28,13 +28,13 @@ void syslog(int priority, const char *fmt, ...)
 	va_end(ap);
=20
 	if (str_len < 0) {
-		warning("vsnprintf failed: '%s'", strerror(errno));
+		warning_errno("vsnprintf failed");
 		return;
 	}
=20
 	str =3D malloc(st_add(str_len, 1));
 	if (!str) {
-		warning("malloc failed: '%s'", strerror(errno));
+		warning_errno("malloc failed");
 		return;
 	}
=20
@@ -45,7 +45,7 @@ void syslog(int priority, const char *fmt, ...)
 	while ((pos =3D strstr(str, "%1")) !=3D NULL) {
 		str =3D realloc(str, st_add(++str_len, 1));
 		if (!str) {
-			warning("realloc failed: '%s'", strerror(errno));
+			warning_errno("realloc failed");
 			return;
 		}
 		memmove(pos + 2, pos + 1, strlen(pos));
--=20
2.8.0.rc0.210.gd302cd2
