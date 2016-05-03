From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 27/41] grep.c: use error_errno()
Date: Tue,  3 May 2016 19:04:00 +0700
Message-ID: <1462277054-5943-28-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue May 03 14:09:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ8W-0000tC-Up
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933176AbcECMJD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 08:09:03 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35099 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932634AbcECMJB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:09:01 -0400
Received: by mail-pf0-f179.google.com with SMTP id 77so9241583pfv.2
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ujH6hiWN5GL1/SZ35DY+SC0L1TLWi8GgMAigMEP9s0=;
        b=chS9l0Fl0NpWrE7FxeYpJGABNx976b22j165R6BL0payzwTuF8aRj2pe2Fb62LS5e1
         uxdtV8L0qoV48m9xqS6tg9MRpagCxl1vIBkSyOXUDy3GMjMgn1an5eL6+kOk8RwfqwYR
         E1nB0FJX/LZdQABoWWP6abD+OBL+NR7I6zUC1xLaYPCSEoRU+Uq5uILLUhgffsBspMQ0
         hK4UXoJllqeYvdOLO71lq9TzjQUb3JSaYMkUBBAkdptmI/dERHUEeV4OLTvVr6gtsTXm
         e1x5uehfnni/bjNmixwMLMGB/hr+BpEbO1muVQma42b3VaxhzhgJuehCCBOoFNfifmsn
         baNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ujH6hiWN5GL1/SZ35DY+SC0L1TLWi8GgMAigMEP9s0=;
        b=DHDL9vUmn3q67cNuyJgN9WSRHlMT7cxrvZH3TYNNESNeejYVYl8QcejKLI1SZ4VeHq
         gAPcDWJ/ESSZcMqY5mXNBu3GuMvBxFv1QIXw5WVRCJGbhu6bT5Is1wpYNtFS3A6OgrFS
         u9pQzkVjJO7WtABlbH8yiDX9WE35/av3+NrImTzzYDwQfsKwml+bc/41kR5nxfMu+kKI
         NT4e/9RKd/466neAl7Gwbaw9hWRwcuKc1O3HJ9XMveKdKNDHUrttZ1I4+wNHU6821S87
         zfyFnRXqnjAnvRDly4GkPauNcaXpZorKro5euiP0SIzhBe41RDMK5rUgW0r4qxcSxWL7
         1m3g==
X-Gm-Message-State: AOPr4FXKkZj/vr6UI6X3TpxoZuXYkwDD/29sjdcKEY2nV1WnSkboHWvz1mg0trl8zGpG7Q==
X-Received: by 10.98.42.211 with SMTP id q202mr2854310pfq.13.1462277340571;
        Tue, 03 May 2016 05:09:00 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id dr4sm5527719pac.11.2016.05.03.05.08.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:08:59 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:08:56 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293380>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 grep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index 528b652..4f3779a 100644
--- a/grep.c
+++ b/grep.c
@@ -1732,7 +1732,7 @@ static int grep_source_load_file(struct grep_sour=
ce *gs)
 	if (lstat(filename, &st) < 0) {
 	err_ret:
 		if (errno !=3D ENOENT)
-			error(_("'%s': %s"), filename, strerror(errno));
+			error_errno("'%s'", filename);
 		return -1;
 	}
 	if (!S_ISREG(st.st_mode))
@@ -1743,7 +1743,7 @@ static int grep_source_load_file(struct grep_sour=
ce *gs)
 		goto err_ret;
 	data =3D xmallocz(size);
 	if (st.st_size !=3D read_in_full(i, data, size)) {
-		error(_("'%s': short read %s"), filename, strerror(errno));
+		error_errno(_("'%s': short read"), filename);
 		close(i);
 		free(data);
 		return -1;
--=20
2.8.0.rc0.210.gd302cd2
