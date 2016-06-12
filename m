From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 08/27] upload-pack: tighten number parsing at "deepen" lines
Date: Sun, 12 Jun 2016 17:53:50 +0700
Message-ID: <20160612105409.22156-9-pclouds@gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
 <20160612105409.22156-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 12 12:55:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bC33F-0003Kz-Pp
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jun 2016 12:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250AbcFLKz2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jun 2016 06:55:28 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34405 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753045AbcFLKzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2016 06:55:25 -0400
Received: by mail-pf0-f196.google.com with SMTP id 66so6636997pfy.1
        for <git@vger.kernel.org>; Sun, 12 Jun 2016 03:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CxGYKv239VkwmECXSX7PdjyqFLoOBynCTBRUpWx72mI=;
        b=ftLjxsZnQD7ZTQlyjSjOc9DVa+/hrEuQW2YRsjAH8VjTWpFMuE0JFjNKQ93GVctQWJ
         XZ5VVz0kAOOWboNcnkN4Ez4K92kjDgtIvS4zxdPsvRfLmlLMEAYbqHcDkaTWXV+eQ6Jm
         qWBgbonrnZ+ViH477TeOG2TUaXu7NL96x5QUwOh3OCqYeKqYSMWcY+2ynRhFZuXqLFE8
         XRJpjIsj1dQnzGYyfYcymVwbg1bWm+o3mwP8Tz/Ka592aGQ0zDB2ad/kbuyeySbD4MTa
         9zA1RqpHCD1Z2Nlzitcv1/U0PWrBdml1Y93idfC0jCDl/oyllAc1X/zQlOVCNTEbOHRI
         LXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CxGYKv239VkwmECXSX7PdjyqFLoOBynCTBRUpWx72mI=;
        b=ISZTTmNT0fb18cAoXMsleUfbLJwDoU8t6+Lb4WJB8BJclkOS6I3deDIxz+IrJr7er/
         XQCNzeptkYkFOnNQC+XPFJwsVHlxKVMVJxgV1Fv7t6o1uJgacdAKh/cnPJo/jy+S+C+T
         eog8at/xrKCT/Guq4Xpypy2n3QmXHWSoZVim9z54fMYApLVZo5wyMqfW7ZNgL3UB8Ktk
         TnHh3qudG32kzPYx5iV9pHImN1Ak5nhqK1Div9a3/1uOv9llRXz1kMhhKqABQEKAmVMy
         +oONzXPLLAJCa8j57TY5X9AvM/NZ6HhuLs59jt/ZRdxF1Zpd96Ixr810X39+5j193Qw8
         9LgA==
X-Gm-Message-State: ALyK8tJgbJkjapuUe0iwrKoZLFd2xT4tdkIwb3+99jxBgDMfXRG/3VeSRuJYBkCI0wctuA==
X-Received: by 10.98.10.137 with SMTP id 9mr14281035pfk.28.1465728925189;
        Sun, 12 Jun 2016 03:55:25 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id a17sm29758192pfa.70.2016.06.12.03.55.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jun 2016 03:55:24 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 12 Jun 2016 17:55:20 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160612105409.22156-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297115>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 upload-pack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index fa7ce09..8f4d7f4 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -645,9 +645,9 @@ static void receive_needs(void)
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
