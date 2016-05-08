From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 39/41] upload-pack.c: use error_errno()
Date: Sun,  8 May 2016 16:47:59 +0700
Message-ID: <1462700881-25108-40-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun May 08 11:54:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLO9-0003V8-5J
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbcEHJwd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 05:52:33 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36706 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbcEHJwc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:52:32 -0400
Received: by mail-pa0-f66.google.com with SMTP id i5so13724965pag.3
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GrMpYL76dCsegoGZnSvjOxowW8myTE9oSuxMkZa2abU=;
        b=MtTr0yYJV9AE602bwjj6I/vaPHszOk8jOT97ObLj2OoOlLn2UX5XNGcLcjWB7rdZvR
         RXuMWjY/1t+TJSDU+gRWsOyTT7JaSK0U8RGie8Mg2wG+pAe9d6Y+z+7T2XSV5760nuvC
         mIa3PaSuJYqKRth9Z93s/sT6B40ugvJQzLT5uE4GyR4h0S4l1ugA55QKtzqQ9hYRQerp
         nykUIlMoP/tN/PGxXHhG8KingCXp/Q9ni1gRIY5UwWK6AqSG1HW5dAK8QCCtvHwtycCc
         Oa+u0iTZp75K5O8mse7t1/eCvBw3zFOetNq3iscmmuK3mRbg/4ja5u11QiYHQZ24zhoP
         0WVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GrMpYL76dCsegoGZnSvjOxowW8myTE9oSuxMkZa2abU=;
        b=R+b+B92qgrWbB5/SIb8p2YD/MGAmhcj+UCQZRXd1oGAjLU+f9ZewN3fmerlhqdHlil
         sGM8BcH2UT+wtF5EMqCH/vCPIDjuwxrdTpLIjjFA7LoAWQDgI7di7ejGzsnco3d8QsJg
         4OXW7fouDOlPuDMIv/vVlUDTxtgQeaGQWH6iKiodUqmiplJFpKuf7QPM+lsRp8QiGRw+
         bgSMh+tBVBh7agrCZcIIEj1vMDJkaq3OEdPWuQ9pEzLQABY+71ub/s3ca1Y/tlx3jcSd
         YOckiJIjrRFAbtrtpR6U8GUr2dy/IiGP9iUgs9EUp2qhCfEd98EOl8+MP5UOZsOUa74i
         BGoQ==
X-Gm-Message-State: AOPr4FUToTG8cA4WJcngM75gva1cen81iS+HgwLmrCu845j2h7dgl0EQzb3QToKU5PCtbw==
X-Received: by 10.66.138.16 with SMTP id qm16mr42232163pab.28.1462701152385;
        Sun, 08 May 2016 02:52:32 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id 63sm32754470pff.43.2016.05.08.02.52.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:52:31 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:52:32 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293957>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 upload-pack.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index dc802a0..f19444d 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -174,8 +174,7 @@ static void create_pack_file(void)
=20
 		if (ret < 0) {
 			if (errno !=3D EINTR) {
-				error("poll failed, resuming: %s",
-				      strerror(errno));
+				error_errno("poll failed, resuming");
 				sleep(1);
 			}
 			continue;
--=20
2.8.0.rc0.210.gd302cd2
