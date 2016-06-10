From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/27] upload-pack: tighten number parsing at "deepen" lines
Date: Fri, 10 Jun 2016 19:26:55 +0700
Message-ID: <20160610122714.3341-9-pclouds@gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 14:28:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBLYG-0000qF-C4
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 14:28:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932770AbcFJM2h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 08:28:37 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:36341 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932602AbcFJM2f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 08:28:35 -0400
Received: by mail-pa0-f67.google.com with SMTP id fg1so5021665pad.3
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 05:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mu9ME0XGE+HI1MAlaSHdmF7DW41ppS8ttCZCWCBMn6U=;
        b=JtzHpXKOkfohxJZqXVjFrBCodGKVT++0GlXivJ9UOTI0W7uXArbveSkBbLZiUbmTqQ
         UuzN/SSwJ6ehbR/L9AWGPOsgVqwzaMtqMtEuZ5MsUy38NX+5ZUMEWcDy+upQBt9OTjB2
         xHyyP6M2stWfcoZlnWabaX9etnYo9vF5uAhnGsEcFfJERSPqzt2By4AZ14atWYHpSoqR
         lLLoR5bY7IZxzIC95MJiZEwXf18l0kWPneFcIJznE17picfBobYGue0usgA1PTit8t3i
         YJZDrt+SNXGOfLG5W5MCLIhcztEz08ShYHOLerLwVg3sMb06BIlAZOpdsl6bKxHEXMtP
         hpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mu9ME0XGE+HI1MAlaSHdmF7DW41ppS8ttCZCWCBMn6U=;
        b=biMYaV2YLf+tnCGTbYRcC0/U+i1C/C2GL76lUBQfxWkGIZVs9gR0SBKvPUZsGX1RuZ
         tiPUbwgpdi22/3MI4bzMfvXbiQV7ySV1i7VQ2Hn+QtidOT0MiXWn0MN7vHFQa7e5pwYL
         xqEu4qe8J/qrOuTsGGYZJKGUcvmJGYSuddYmB3pd1P71s7OEkh26KcIs0lTQILZRu/mg
         q+lDbDSmfBYZoQpSZk3dXoh794EJcfmyIA9S4czOe65udpp/umMcfp6FzxRDX3Z1vrGO
         Ipq5j2OoRzfekZ375zHvMf4Pi6RUTMGadgO1fZsV132KWgIJRZIy/p2R0eT3OrivOEGt
         /F1g==
X-Gm-Message-State: ALyK8tJ6QC/Mag/it6wB0Bp1ehTH+17qWg87m4Wp0b9SZSTDj/115olDl/gTgl1de8KeIA==
X-Received: by 10.66.88.73 with SMTP id be9mr2076259pab.113.1465561709685;
        Fri, 10 Jun 2016 05:28:29 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id vy8sm17501441pab.22.2016.06.10.05.28.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jun 2016 05:28:29 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 10 Jun 2016 19:28:25 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160610122714.3341-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296974>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 upload-pack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 615bfb2..60f2e5e 100644
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
2.8.2.524.g6ff3d78
