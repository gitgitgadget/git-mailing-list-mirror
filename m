From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 10/41] builtin/pack-objects.c: use die_errno() and warning_errno()
Date: Sun,  8 May 2016 16:47:30 +0700
Message-ID: <1462700881-25108-11-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun May 08 11:49:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLLE-0000KR-BS
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbcEHJtc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 05:49:32 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36171 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbcEHJtb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:49:31 -0400
Received: by mail-pa0-f66.google.com with SMTP id i5so13721714pag.3
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lRteXN6lhjAsV2RvW98yexmAOQUbb03mVF+Ck76X2A0=;
        b=dc9WFopobRwPbaM8MkBeqOJcQddDOh6QtP6J6T91xjQSP9iubn/qlm097ppRjL9RiI
         ApqcCnvjrauIiaZnuGythmFY5rQb2y0dpp5WJYBXSoL1bSnq/6c1QRncweXY7xU0GpH1
         GoDqRIwLcrBCqX/EZVTRawxZhP+xhzgleAQml/nzoD6QoPfKCCpLwLyM3V4Mqt4DHNGX
         m0V7TbMjNPi6Pt4wPzHp9rn4mn6gdiUVj3YlRU6xeIAdxjW3eqYtiiDfdbUJfde2YwNA
         3BFYhVR+13MWTfCs0u8QMiQMcdEkrCeJxJ9l2G3J9JzDTBJNqMyI29I12aXXp6Pyw1f/
         PUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lRteXN6lhjAsV2RvW98yexmAOQUbb03mVF+Ck76X2A0=;
        b=aZ1dtHH1dUNghnwaB3llEOyP5Cfa/edQUA3Ja+Q9tXXaNOGamYHHd0rpalcTSm3m9C
         wI+9izij5+bdl+jeqnWwQC6DTg/jWu+wyfFP0sQTGeeLfvnexdT6ptqUhUyM1Fh6ooRp
         Jw7SLnLAANByJnRYy3IcNrexmFaV+gVEhev+B1lWo/cxPlmBy6eHkd8UsGO1iqXoVuDm
         Y0UoMlbEijpx0FVVWYFl9NwVAWJ2Pigy5N+bGDW8olD+aQwbBMKlVNmNSg8GO1IITtJf
         4tLngiA7K7ZTq9ZjjOsxGE8q7G+12mUR9/ONZz65zOTTza0QtYGTp0ei2KseE4DZHjv/
         UgVQ==
X-Gm-Message-State: AOPr4FUDiWAOIG2klIyrlIbh8lsebMchjDpvpxwPz9PuoK5W2lZoCKb0auGnRDcjRXOrgg==
X-Received: by 10.66.184.40 with SMTP id er8mr42290991pac.134.1462700971222;
        Sun, 08 May 2016 02:49:31 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id kb15sm32855705pad.28.2016.05.08.02.49.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:49:29 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:49:31 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293917>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/pack-objects.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a27de5b..1145747 100644
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
--=20
2.8.0.rc0.210.gd302cd2
