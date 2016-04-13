From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/26] upload-pack: tighten number parsing at "deepen" lines
Date: Wed, 13 Apr 2016 19:54:52 +0700
Message-ID: <1460552110-5554-9-git-send-email-pclouds@gmail.com>
References: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 14:55:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKKs-00046X-1l
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 14:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030704AbcDMMzz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 08:55:55 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36720 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030495AbcDMMzx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 08:55:53 -0400
Received: by mail-pa0-f68.google.com with SMTP id k3so3874908pav.3
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 05:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2XF84I1WAPNzSZuj7HWJv3f27HBj32Gmu8DlCydsUNA=;
        b=ntNVfPleBgDNvYMryl42CLXNyF6MjaKI/LyWlGTrKfFqP7I0xUG/h8Uuv3gHR2Yeu/
         q1jsgbhWwcwGNFTqdW1/REMi7lnlj8pNeZ/8TEufR+t02NdT6zSi0TDoV9fYn/alFDm7
         BDzCcv7zDMaKLv3mE5fRcx/Q5HMdytp/jCqzRMLSZj6EwQX8zz10C3bNOzdh8/h+gU/Q
         9PHaBZLJRzHxhGQ8n2U6z9O40uScxrojP9PsyMYKd9P+87qvExdore0jenuHW5U7fttX
         83xGG0Ye3mPLV2VaHAhvHCuovw/2gJQceTAjtqQbuoqGUosh/GmvBdwFnEPMaQwawmOk
         FVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2XF84I1WAPNzSZuj7HWJv3f27HBj32Gmu8DlCydsUNA=;
        b=Cv0p/azM0Tilq9iIMMaBxoCtj+IZL7OqFx0U3WUV6n8r1dl5uLwHDlaJ+v99o/d2a/
         3HCkt4Cx4bhFxkPfTP9hqe+OipNpYt0Eb/13BnF5xzCLzAIso6MlhRItzK12Ni2Q6jkb
         Vl1gBaGfEBBztQf8rT/jRtDabf7e9T5XrHsCzgoqYRwBG49qYo8fTwItq1ZucsGW1em7
         vJ/hWBop/mu/bZ/8gL3J7KhRmOyP0+sp5kTGrXIjxnmn/6OFDx98gaGOhmgT4aAEjZgr
         p/Mx3u48N4wzyQgn6fGZGREKuEWxAuKbxzJfjiSX9fznuOb9trTdQMx3N+p3H1YvUdC/
         8CRg==
X-Gm-Message-State: AOPr4FWmH34vT48fJUirYKYvSe4gytR0l6g6Oiz+YIiw0yF/tTI97PgNWq/6Cyk6EqO3Kw==
X-Received: by 10.66.156.232 with SMTP id wh8mr12671584pab.153.1460552152523;
        Wed, 13 Apr 2016 05:55:52 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id f12sm51019454pfd.87.2016.04.13.05.55.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 05:55:50 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 19:55:58 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291401>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 upload-pack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 257ad48..9f14933 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -641,9 +641,9 @@ static void receive_needs(void)
 			continue;
 		}
 		if (skip_prefix(line, "deepen ", &arg)) {
-			char *end;
+			char *end =3D NULL;
 			depth =3D strtol(arg, &end, 0);
-			if (end =3D=3D arg || depth <=3D 0)
+			if (!end || *end || depth <=3D 0)
 				die("Invalid deepen: %s", line);
 			continue;
 		}
--=20
2.8.0.rc0.210.gd302cd2
