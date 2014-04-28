From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/32] read-cache: be strict about "changed" in remove_marked_cache_entries()
Date: Mon, 28 Apr 2014 17:55:28 +0700
Message-ID: <1398682553-11634-8-git-send-email-pclouds@gmail.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 12:55:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WejDW-0001Pn-Rt
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 12:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755310AbaD1KzN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 06:55:13 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:33314 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755299AbaD1KzK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 06:55:10 -0400
Received: by mail-pb0-f53.google.com with SMTP id jt11so3987395pbb.12
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 03:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=K2d56lR9RNZCINObmH7XbeGhOen5pNUAMgaKr2T4nPA=;
        b=n4zeGy3Hyf1izD2AvELpmaEHraCjn/hm9g2SZpnNGj9LiRiH3rCWyFhpBMmXL3pID0
         kVOV2gyCaOSwdodn+SbmTL67QKc8Nk4/XkZ+5yCjBl1VRhzqreGgfAboT/YbFHL40FvH
         l+aDx550bMXfALhcsKYcMK8ldrZyUmxakqFOqhvhWBl+qoOWrIHk4ikNgOtdYkKsKQCP
         JuV0XZVbe+0PnDMalEE56jRXk8NjV5m5R741c4ffT+Lr4cN7sSh9B78c5llIjYE+7r8d
         gUide8mgQMlY1KT+OV5qB+ATdBHzW+tJcLu8iSTd0p1aeQ4stocFUkhEDiva1KlXPt3p
         UgfQ==
X-Received: by 10.66.250.161 with SMTP id zd1mr3077232pac.136.1398682509704;
        Mon, 28 Apr 2014 03:55:09 -0700 (PDT)
Received: from lanh ([115.73.231.31])
        by mx.google.com with ESMTPSA id qw8sm34216392pbb.27.2014.04.28.03.55.07
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 03:55:09 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Apr 2014 17:56:37 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247274>

remove_marked_cache_entries() deletes entries marked with
CE_REMOVE. But if there is no such entry, do not mark the index as
"changed" because that could trigger an index update unnecessarily.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 read-cache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index 5761b1f..9819363 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -510,6 +510,8 @@ void remove_marked_cache_entries(struct index_state=
 *istate)
 		else
 			ce_array[j++] =3D ce_array[i];
 	}
+	if (j =3D=3D istate->cache_nr)
+		return;
 	istate->cache_changed =3D 1;
 	istate->cache_nr =3D j;
 }
--=20
1.9.1.346.ga2b5940
