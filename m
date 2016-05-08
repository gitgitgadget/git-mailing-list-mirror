From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 27/41] grep.c: use error_errno()
Date: Sun,  8 May 2016 16:47:47 +0700
Message-ID: <1462700881-25108-28-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun May 08 11:51:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLMw-00024L-B0
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbcEHJvT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 05:51:19 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36500 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbcEHJvS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:51:18 -0400
Received: by mail-pa0-f66.google.com with SMTP id i5so13723764pag.3
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6eP/8FZ0s2bfkst4pK0hM8pAA5L83rurQKdY12SLmcc=;
        b=GSeWnLlmfHOPyLj4nPKDkRnpbBXILMR+3NX0tTDWrS88B3hXSBoSEURKJqMsLLGdt1
         QsWVrejXleyLVCIA5t3BTGd/+bOsgHRw/hC8UuKUO9f64W9bLTPoZyC0FF2usnoHp+Ln
         4U/M4I91KZsiXtrrULK4jdUmBvRSOQ8Dn3lHh3XWf+9VyH56MWPi+uf2Q9Cdu5Wgspvt
         3k2kVj5R2OHBmpTDS5WVcZ0v1jL8WFk+IC72ALEWKqftK20QjE+JXw3FqjERXVLOlOVC
         je0g1mWBVosC8Z+ew5bBRhvZJOZE7bkCVxnO2TU2zHNegebRDqEgnx3kdxMwNG925WXv
         /ecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6eP/8FZ0s2bfkst4pK0hM8pAA5L83rurQKdY12SLmcc=;
        b=d6ggVJnq/WZf1ad+qPZ+yhuxnvxDPt15rV/RRwQ1iF2dedIih2ab4ZLAzTByKPZebA
         19XhBUZTVc8qTW9ymXHupxtBOms6FQRwEDGhEZzbz8FYKaShySlbdAbQSTriakKPfJOs
         HuLElQzyERKKeR5uLMWlIWj/yuWTlJnFCAChnEFUsKFYqrAvopOQvqJTf+b9/8J/kaxI
         L2FA59dlAB7sbIylhXlq0vcCwLcRDwZIL/GRO6NsFMOqeUru3hcZ1T8Or0ufQgcw6dkp
         SRVXeziAFnwYEZbDZpGq8PcAfsA8KRoCmdfF6jfmcn5BY3kDXSrtt5XBEqDlF5/d2ljx
         YxSQ==
X-Gm-Message-State: AOPr4FVn80UJjTjrhcktH3ByqLjfPuNznvzz6rIZ1LmKelsXB/UO0S2RJQknl4a4EeaUxA==
X-Received: by 10.66.149.194 with SMTP id uc2mr42536130pab.116.1462701077358;
        Sun, 08 May 2016 02:51:17 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id o187sm14413734pfb.76.2016.05.08.02.51.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:51:16 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:51:16 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293931>

While at there, improve the error message a bit (what operation failed?=
)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 grep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index 528b652..ec6f7ff 100644
--- a/grep.c
+++ b/grep.c
@@ -1732,7 +1732,7 @@ static int grep_source_load_file(struct grep_sour=
ce *gs)
 	if (lstat(filename, &st) < 0) {
 	err_ret:
 		if (errno !=3D ENOENT)
-			error(_("'%s': %s"), filename, strerror(errno));
+			error_errno(_("failed to stat '%s'"), filename);
 		return -1;
 	}
 	if (!S_ISREG(st.st_mode))
@@ -1743,7 +1743,7 @@ static int grep_source_load_file(struct grep_sour=
ce *gs)
 		goto err_ret;
 	data =3D xmallocz(size);
 	if (st.st_size !=3D read_in_full(i, data, size)) {
-		error(_("'%s': short read %s"), filename, strerror(errno));
+		error_errno(_("'%s': short read"), filename);
 		close(i);
 		free(data);
 		return -1;
--=20
2.8.0.rc0.210.gd302cd2
