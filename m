From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 03/41] bisect.c: use die_errno() and warning_errno()
Date: Sun,  8 May 2016 16:47:23 +0700
Message-ID: <1462700881-25108-4-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun May 08 11:49:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLKY-00087A-1s
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbcEHJsv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 05:48:51 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32856 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbcEHJst (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:48:49 -0400
Received: by mail-pf0-f195.google.com with SMTP id y7so13781428pfb.0
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B3bzeIA/gdyoYduk8KkAsCm711A0fc2Dx1J+MYMKpr0=;
        b=p63nbHtZDUC/PRT2dq8GUIJRAS4XpTMXTvVpaMIS1OVSDNRkLCwzyc5GsslFFX2pxQ
         0ajHTJ30cz/7N/8cHKPJxn7IOAywp/+kDgq55p8LZo+GFJNJWaRVj5iWRgEOdQ6LqWlq
         J+dZFE2XY/HCAsqDsowK6wFw2IlnLU8k8BzF6LKZ0+mydz2a43jO17TSlxvHEpGxy1KF
         0dzIaGg5L3AcT0o9iYeFpRs2lJqlO6wjARl0S9KAFlep+M020czMr+GNWZneV9k3I1fy
         6T/6kq4WU2LTqO13ZZIc2Wt1HpCV8FJW1VS+oQ8wJwvM7JUAxeqonloKWWJerUxxUX2f
         oqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B3bzeIA/gdyoYduk8KkAsCm711A0fc2Dx1J+MYMKpr0=;
        b=aRol7fBf/1zip9/zpC2QrXYZgxIobzQFgtK+vV0VghtBLJ0BY3jleJHObbNVmCq6MZ
         /9iBA4ghVi+dO8FftQ+i9pD0QChyFZz9JXKwmGhDsPQ4x2UXY54ljKSC83iom1imaMD1
         Hz7s48wOYyTPZiHkwJvWPLNnzpW6ggHrFCRNync4RUy/Yy98Mom8W0zcWrM3Wjwua/wT
         9kNH7SnO4ijt1Rgv19qEvdYQKzHMKCM7i9luZlVyoZG8jQ+ZTp5tsswqR97bNwBTPkiY
         uw7TYSyO2DOpTVzvw0LKc5p2ROteZnz4R0STEsJXPMjaJF8wlBo6jAw19lsY5dtyU8Rs
         rAOA==
X-Gm-Message-State: AOPr4FX4nuIfSlaV14P/ETB1/MhEV6+pfbDgaObWM/CS4Ah5lFPBQi3clM9bnNXkIEj6tw==
X-Received: by 10.98.23.150 with SMTP id 144mr42078491pfx.96.1462700928903;
        Sun, 08 May 2016 02:48:48 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id ut1sm32837329pac.46.2016.05.08.02.48.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:48:47 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:48:48 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293918>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 bisect.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/bisect.c b/bisect.c
index 7996c29..6d93edb 100644
--- a/bisect.c
+++ b/bisect.c
@@ -860,8 +860,8 @@ static void check_good_are_ancestors_of_bad(const c=
har *prefix, int no_checkout)
 	/* Create file BISECT_ANCESTORS_OK. */
 	fd =3D open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
 	if (fd < 0)
-		warning("could not create file '%s': %s",
-			filename, strerror(errno));
+		warning_errno("could not create file '%s'",
+			      filename);
 	else
 		close(fd);
  done:
@@ -910,8 +910,7 @@ void read_bisect_terms(const char **read_bad, const=
 char **read_good)
 			*read_good =3D "good";
 			return;
 		} else {
-			die("could not read file '%s': %s", filename,
-				strerror(errno));
+			die_errno("could not read file '%s'", filename);
 		}
 	} else {
 		strbuf_getline_lf(&str, fp);
--=20
2.8.0.rc0.210.gd302cd2
