From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 22/41] diff-no-index.c: use error_errno()
Date: Tue,  3 May 2016 19:03:55 +0700
Message-ID: <1462277054-5943-23-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue May 03 14:08:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ80-0000dk-Du
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932813AbcECMIc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 08:08:32 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35998 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932593AbcECMI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:08:29 -0400
Received: by mail-pf0-f176.google.com with SMTP id c189so9679684pfb.3
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ixKnY5jHiqlgjhRy4Dh1VQCzCIoB5KlROrcgSjkOfmc=;
        b=ZJJv8G5bRA85dRcnwLXaT6VBX5ie4t4xLL4qol5EueDMJXQpip2eISeyoD7Q5WRiMz
         7RXGhcGTdLUf6S2lnG6N3Ofk+LbWUm82FGqyG/zZguxYGhZ0essjNLlhkKUsdwTs5EAO
         7qTrZOyVE6a1OJDGqdwTddMVyPoKaU0eAyhgnKl0qD93wKrCT29YFJIKpaxXeu0R39Ju
         TeOjLdDQtOiYMAO+7DZ8jh49bUTTa0Oi10A8TzrmbUxDIbMQSx9C0+wBeKN6cWtNBkqR
         Tim6URlOGQn9Q7yTv5hX6Of0aGwFt2ITJ/yjkmTNhOsqvlGxbPbbKenWzsPO7HKvHZHO
         qwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ixKnY5jHiqlgjhRy4Dh1VQCzCIoB5KlROrcgSjkOfmc=;
        b=DAUMQPlaWWXltUsCwsfRsPHJmDL4G4HhQpJ/P0J+OAk8wLV22DQuijwc80R0yfs0Cl
         CSvGPOEFJ1J2k0Azt36SRNNU7MysK1fpVWuvYdJ8Ff5nNxbpzBWtxybJA2NFbGkEfQAO
         BrDfo/KF5viKCr6zrI7bdRpMSFhzv2iwv2xMQUWeP7JB0j7XqU81ie3y5QB2EDyKfhVT
         T/UeJ7Hc+sioAkUoIUEUJj6romYrFxCtlfzigwb2jgNPz6n0xTh8pCuTloXabCWNj8mZ
         tkjbIvcfLomDSt8WzYYoBFoRjV4WOltySn71SEC72gc1jvq5tblKKVuxBKMXEDQos7Z0
         t8Rg==
X-Gm-Message-State: AOPr4FVvZuvxmbQxM+xtTITQ2Ecs0zVjrOAGUq4t7Qht9MejKAIHrtgRvbRLwbePbotkPg==
X-Received: by 10.98.65.90 with SMTP id o87mr2811095pfa.151.1462277308635;
        Tue, 03 May 2016 05:08:28 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id i6sm5494915pfc.65.2016.05.03.05.08.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:08:27 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:08:24 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293375>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff-no-index.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 03daadb..1f8999b 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -65,8 +65,7 @@ static int populate_from_stdin(struct diff_filespec *=
s)
 	size_t size =3D 0;
=20
 	if (strbuf_read(&buf, 0, 0) < 0)
-		return error("error while reading from stdin %s",
-				     strerror(errno));
+		return error_errno("error while reading from stdin");
=20
 	s->should_munmap =3D 0;
 	s->data =3D strbuf_detach(&buf, &size);
--=20
2.8.0.rc0.210.gd302cd2
