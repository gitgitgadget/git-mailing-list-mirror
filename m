From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 12/41] builtin/update-index.c: prefer "err" to "errno" in process_lstat_error
Date: Tue,  3 May 2016 19:03:45 +0700
Message-ID: <1462277054-5943-13-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue May 03 14:07:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ77-0000BL-SZ
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:07:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933153AbcECMHe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 08:07:34 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36216 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932756AbcECMH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:07:27 -0400
Received: by mail-pa0-f42.google.com with SMTP id bt5so8690745pac.3
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NhU1JD0j4p3G372yMnppd9qOiKcmLWiqMVDocvnGCeY=;
        b=mJifcqvFqd7OnR890Whe5955EOErCfO15GwkEuI3hdmL+DQVxLX54Y9/YUgTX4j5ol
         SL5huo4UtHwu6xS7kSo3ohqCswQHVSXjE/hnamxoiCa5c5Zcvi/mfY1zKHGN7XwC2XgQ
         9mxlDNlSf0UlzJWT/p6frbhWeC/WDslzlV7fn58XedUwmFkiXR2MPEU2JXLkjKMTb2dT
         KeuFY6oK4uJChxt4sekdiKcd/AyWTX8Nlh10CBz4EwUp2PuBQLTKY4ERf9Ba7l4Kct59
         GKnVXfYdiOsh97mO7lVULnHjKfRgCqxtgHmKKwPu/MsyA6Fd9GRvsTZHJTnvT6LDBMvP
         B3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NhU1JD0j4p3G372yMnppd9qOiKcmLWiqMVDocvnGCeY=;
        b=cWEYTw5hQ+wLAYH0+eiUdl7ax/3pidGBhzy7FvSh2wHu8oil2Zb1nWoOozaFZqRUij
         KXKHzyNY/cdBHqqaVVKWcycp80JctrCnkGNRKicnSn3+4yJsRCO52FXS3oH2blmD4dag
         8CACDULfha0X9Bk3V9qBtuWhm58yVyU6zsoeZhtJ7mJocbWXgB7jYRuoiQyKlQyXr9mf
         v8CukH1ps8JLfRjHKJuvEeJ5JQPDntgdVvzJ0HT0f+xQmeEa7Vz6Xu4XSwIHk3YXyjZW
         ycr3iD4Z52MKJzBxUv6ru85gZwl5TeiXgB78Ml11CyF2pMonjKm3Z6oRLmWnFUDVjzWa
         XAYA==
X-Gm-Message-State: AOPr4FXlYuI2AScxAe74TcBqKAek1VQxfLrlRteSgQ1nnEOenxHIPmLHabcA5SqzUuMSpg==
X-Received: by 10.66.145.35 with SMTP id sr3mr2898289pab.82.1462277246870;
        Tue, 03 May 2016 05:07:26 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id p26sm5474163pfi.84.2016.05.03.05.07.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:07:25 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:07:22 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293364>

"errno" is already passed in as "err". Here we should use err instead o=
f
errno. errno is probably a copy/paste mistake in e011054 (Teach
git-update-index about gitlinks - 2007-04-12)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/update-index.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 1c94ca5..b8b8522 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -255,7 +255,7 @@ static int process_lstat_error(const char *path, in=
t err)
 {
 	if (err =3D=3D ENOENT || err =3D=3D ENOTDIR)
 		return remove_one_path(path);
-	return error("lstat(\"%s\"): %s", path, strerror(errno));
+	return error("lstat(\"%s\"): %s", path, strerror(err));
 }
=20
 static int add_one_path(const struct cache_entry *old, const char *pat=
h, int len, struct stat *st)
--=20
2.8.0.rc0.210.gd302cd2
