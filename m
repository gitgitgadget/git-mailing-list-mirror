From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 10/41] builtin/pack-objects.c: use die_errno() and warning_errno()
Date: Tue,  3 May 2016 19:03:43 +0700
Message-ID: <1462277054-5943-11-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue May 03 14:07:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ6y-000054-GF
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:07:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933136AbcECMHT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 08:07:19 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33786 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932756AbcECMHO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:07:14 -0400
Received: by mail-pf0-f180.google.com with SMTP id 206so9345154pfu.0
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ywgfT3CDiqsMECgYSjUiwwmWupoyQ0eqCrc3g1tJJ3o=;
        b=UDZ35WMkC6qGUYW+QDbN4QMlTN28hmJP/bwDt3QKyKg1c/0e924zo+QN4h0/6JHf8+
         AkWXP/lWeoCmOpCkcN8lEO51qp/+7xsKlSuzYEY8IB48uSmD0bmFWddDNSS2b3N70OJH
         PiOadlTgAjKnS5K6yVwOI59uupp/IXpKomO43rPvvt6x9Cobk8vBM/97Rqv5Utu8Zl+e
         8rRkHJ7wP+48fO15/g04u++0Cq9xYjc9h3Vuz2xhkOmVO/6Cxk+xMLR9nTG81102hQ1h
         PbyGiMD3Ntvk35Ze7WjAAHPa+JIfI/D1GN+xhEpWiskFG+RePPakdfEhS0XNHU/vKtx6
         3pcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ywgfT3CDiqsMECgYSjUiwwmWupoyQ0eqCrc3g1tJJ3o=;
        b=DBfoH+SzK+tWsdcTQ7DWVyLSSCbI4OYGCuiqNi4FGQpPqE875acLUFaMMkUc0Vvdrh
         fgXBVQCXv1WEHQA1bGbMMrUXDBih8cNS/kdX0PmWxeGVQH3WOP7lsNUHeb8Zv3fRoL3i
         4a0JKZFBHXg1f04vr6IB78L4kgulIx8cFfgc1GX/hr9KXsqTW0i5Oh2wUlyAJqhI2eWB
         aYPzFWGgL/RazpgPIL/FlBfdhJ21UiPPIpaM9pxX2p5JmEBWMN646to1ESKY0j2oK5A6
         NUNcD9Xp9/N53EhNV+qd2ybOCChDpyHkCFhNa/sckCwMqTyHiw9W7TVgPK5WvQqqWDxd
         8ZhA==
X-Gm-Message-State: AOPr4FXx3VrCKOzULIj69YeI0FVN64gOAoVw6ea8KYytmF9hM1l+Qtx9r1eNAkJTWH/OeA==
X-Received: by 10.98.27.78 with SMTP id b75mr2856540pfb.49.1462277234117;
        Tue, 03 May 2016 05:07:14 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id qy8sm5505717pac.17.2016.05.03.05.07.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:07:13 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:07:10 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293363>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/pack-objects.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a27de5b..e18e190 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -828,8 +828,7 @@ static void write_pack_file(void)
 			 * to preserve this property.
 			 */
 			if (stat(pack_tmp_name, &st) < 0) {
-				warning("failed to stat %s: %s",
-					pack_tmp_name, strerror(errno));
+				warning_errno("failed to stat %s", pack_tmp_name);
 			} else if (!last_mtime) {
 				last_mtime =3D st.st_mtime;
 			} else {
@@ -837,8 +836,7 @@ static void write_pack_file(void)
 				utb.actime =3D st.st_atime;
 				utb.modtime =3D --last_mtime;
 				if (utime(pack_tmp_name, &utb) < 0)
-					warning("failed utime() on %s: %s",
-						pack_tmp_name, strerror(errno));
+					warning_errno("failed utime() on %s", pack_tmp_name);
 			}
=20
 			strbuf_addf(&tmpname, "%s-", base_name);
@@ -2020,7 +2018,7 @@ static void ll_find_deltas(struct object_entry **=
list, unsigned list_size,
 		ret =3D pthread_create(&p[i].thread, NULL,
 				     threaded_find_deltas, &p[i]);
 		if (ret)
-			die("unable to create thread: %s", strerror(ret));
+			die_errno("unable to create thread");
 		active_threads++;
 	}
=20
--=20
2.8.0.rc0.210.gd302cd2
