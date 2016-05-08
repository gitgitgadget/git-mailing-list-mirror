From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 20/41] copy.c: use error_errno()
Date: Sun,  8 May 2016 16:47:40 +0700
Message-ID: <1462700881-25108-21-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun May 08 11:51:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLME-0001GE-Vl
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbcEHJuf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 05:50:35 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33165 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbcEHJue (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:50:34 -0400
Received: by mail-pf0-f195.google.com with SMTP id y7so13783333pfb.0
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9gdftNInvYkBsfXxTpXaj8uI5t5aQ7m0JqFwg6BLLAk=;
        b=A3+IxFPdu+N99jKtBTXVrjXQjVEGVnjCjRoOqvuzhAoDFNexXGm44MnDGCP+wo2tF7
         JEaJImVI+Q1S78cI1a58GOufNQl+myTDi/Ulgsbh6agaCg0KKe3Y9o+Xt7BM3CCU6CQl
         xKhCyo9BtoU5gPhDwnbRIJTYtKDbRYRlOeLQ25K12/es5y+Vk8iiLpWw8NSBO87ghprB
         bqBE7jBnkSagW4HiC/hw+o7BdV5DjnGDc9m23SGZxSkNfvJgN1G132kpnFLj4dc9SsYt
         onKyYTLRy9O6dMR81V6IyewE7YdiY0q1oebHhHZ6sK/UoO/MQygDGo2gGiEaX3z+ofg2
         GhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9gdftNInvYkBsfXxTpXaj8uI5t5aQ7m0JqFwg6BLLAk=;
        b=RCkKCgVPU5od2ZECRO9KgJQVmEilFBOnVSEYxe2AD7x4URMZzudK4JdAE5oN+ovo8N
         1r47aC8I9ilDwixfemMOy0xCZwBmrNJmm8sT2e78wJ9S/7DfomedJtFyNdBv1XOOoPOF
         /OhD72mjIkQ/vk2JPHbzipbxJdCMcpVTdY8mbeh4RhMb0G0La2aSaSTMUQYL578oKxBU
         eqtg4CXbmxlva3HMsXBJcaeq78XHuRshyyB8sRijGyqzdAgIK+ZgEwDB0jmvkFlsmn7z
         UVwTErD7ATfCoKT1YIxft4SguwLHV71Ge13ec6Dhp/eHYL3oaPPR9aA0EzF5s2uPW3mi
         24ng==
X-Gm-Message-State: AOPr4FX0H/SDirt+kBpBvzlTs4Ymu+Xk0OPw+7cw4OVHlZIl+ahzCHQ9JS5Re5j7e7aNSA==
X-Received: by 10.98.82.208 with SMTP id g199mr41821979pfb.113.1462701033442;
        Sun, 08 May 2016 02:50:33 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id p187sm8100215pfb.3.2016.05.08.02.50.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:50:31 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:50:32 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293933>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 copy.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/copy.c b/copy.c
index 574fa1f..4de6a11 100644
--- a/copy.c
+++ b/copy.c
@@ -42,15 +42,15 @@ int copy_file(const char *dst, const char *src, int=
 mode)
 	status =3D copy_fd(fdi, fdo);
 	switch (status) {
 	case COPY_READ_ERROR:
-		error("copy-fd: read returned %s", strerror(errno));
+		error_errno("copy-fd: read returned");
 		break;
 	case COPY_WRITE_ERROR:
-		error("copy-fd: write returned %s", strerror(errno));
+		error_errno("copy-fd: write returned");
 		break;
 	}
 	close(fdi);
 	if (close(fdo) !=3D 0)
-		return error("%s: close error: %s", dst, strerror(errno));
+		return error_errno("%s: close error", dst);
=20
 	if (!status && adjust_shared_perm(dst))
 		return -1;
--=20
2.8.0.rc0.210.gd302cd2
