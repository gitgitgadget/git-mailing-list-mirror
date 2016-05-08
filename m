From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 12/41] builtin/update-index.c: prefer "err" to "errno" in process_lstat_error
Date: Sun,  8 May 2016 16:47:32 +0700
Message-ID: <1462700881-25108-13-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun May 08 11:51:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLLQ-0000PO-5Y
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbcEHJtp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 05:49:45 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35414 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbcEHJto (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:49:44 -0400
Received: by mail-pa0-f65.google.com with SMTP id zy2so16125485pac.2
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NhU1JD0j4p3G372yMnppd9qOiKcmLWiqMVDocvnGCeY=;
        b=Dwei31+UGCqf3JGgN8CphdqTETlBHYZxPenbCVMLUXyrAfJQVFboIYPkze7ssAXRfV
         Ef1WwWQTGrZqWsN7Rp0BR58tG1F6EZZvwk8bTtS1Afkq7Njo31Osw89wb+DBQ0nGIIfy
         1k/30ZZKS9gnNfFc1TDTv8Xar7YDsBLgXbd8ssf8L08W7Z22XOFA6zXeooTlxu0nKKST
         EaxhcZYllWIklrDYWfRN5BERs1KXGvMK0qWkR2gNSKEDKRyFegoamh8bTdfMXORQiBKj
         XlahPeu9TY7EASWQrsloLgQqKsNxfO2VXk0du4GvD08ChlcX+cL7VussSKTj27O2fVmm
         tSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NhU1JD0j4p3G372yMnppd9qOiKcmLWiqMVDocvnGCeY=;
        b=H6Z16/2Ydiv31GP4swoS9FtMCxMwmn9uEjxlpp5jGDve6vy/kUAjNiguOMbtuF1TMX
         MFGqgXE3vu/m9cTC+LZPzrSTns+6SlIMybc/lO7fxtGgy6OKsG/ae4quhNl58tTVoScG
         O8X1YyXEiGZZW+uEaCJL+sSKoQ0E2/pwKcXZ49CuFd7scY7xWqjPBcOh/hef5RcrcuR7
         v0t17XW6PquGkBRDJ530kE+kWD6rSgmKShzcsTmzHpSdapvC2EibOs0dHJMLMDVNVR3X
         IfaamdNe/aDIZoBVPpzOed53oVQxz1lJWLLe+BPkThbKTs8jq1yWiPCj5XhdkTonGg+w
         2I2Q==
X-Gm-Message-State: AOPr4FUfn1eGmhgzJ7b/HPA8F69HK9wyreGueWs7PFBnZRhxJ/v/A/25jmnKQ9//k+LLTw==
X-Received: by 10.66.249.228 with SMTP id yx4mr42031741pac.29.1462700983492;
        Sun, 08 May 2016 02:49:43 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id n10sm32838232pax.18.2016.05.08.02.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:49:42 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:49:43 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293928>

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
