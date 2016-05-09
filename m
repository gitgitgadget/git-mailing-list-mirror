From: David Turner <dturner@twopensource.com>
Subject: [PATCH v9 01/19] read-cache.c: fix constness of verify_hdr()
Date: Mon,  9 May 2016 16:48:31 -0400
Message-ID: <1462826929-7567-2-git-send-email-dturner@twopensource.com>
References: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Mon May 09 22:52:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azs76-0003nz-BK
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 22:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbcEIUtH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2016 16:49:07 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:33368 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131AbcEIUtF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 16:49:05 -0400
Received: by mail-qg0-f54.google.com with SMTP id f92so95674944qgf.0
        for <git@vger.kernel.org>; Mon, 09 May 2016 13:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uewEGQ0wF/3DxfN+baDwQCJkdkBanU90hVkFsq63qvw=;
        b=LwFiaaErxDCon+H0qT2UZL8YjHG0lmTcXoZ3Iy2uakUSB3G0mpU+SNGLoe2XFLw6BH
         0kX1vP8TarHTzP5FM7ZHPCAvo2ov4PLp7fPOQtqdlV8DJ9atMgTOsdfznE0oAnOr3F3G
         wXikta7aQMfzweURCPnZDS5QGPsofDGYiucs2wHtqVQCwm1LyGxIAVuL2YmnplX1iTC4
         AP2lzEyJ5EEedozNPyreoDU5DAU7h3bqgotY/btaE31WDS/g7sLFdbpF+/fOmxXazB1k
         TvTybXfM4Hv687P4+ReX1wC/OFZysEyemqEKkaflBrzu0+en+KjV3p3TRa3LsSDyV+A8
         KQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uewEGQ0wF/3DxfN+baDwQCJkdkBanU90hVkFsq63qvw=;
        b=LzT7Sk0p1RQvepz2U3uDQsB9bxyGjBHPPHEg5TYBg3vnmq7iZN4tTa72ftYgyRMhNj
         r5CdpexHkLrK74R07g0y5W/j8+p8Dq+Dcu/cBZOESIWvg9rv2G7JiIA9euVZ/AtezxTA
         II45833Hd1gPE0UywitS89+pPr62AYi3Jw281BI7J6KPguoz8yxkexWUalkbhR9TVPos
         imdApFI+U0KNhptF5roOHE2iiKTS4rVENzjsQuGM5sTetE3NR9/5fEnr2tH7cnd5RplA
         1Xi/lNhNxgTVc4afCfl/4VG7Wwzq16fK48lf7ZDFwjWT84cPv24hrii+NKoQe1egl3ja
         O6Qw==
X-Gm-Message-State: AOPr4FXsXBrcFgGwPgT8a4zIUI2ZaTL+PWl2sTfZTuyh5K2J+9WDozx5eOEpbJapySCCiA==
X-Received: by 10.140.144.204 with SMTP id 195mr38504728qhq.92.1462826944068;
        Mon, 09 May 2016 13:49:04 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id n1sm12729182qkn.3.2016.05.09.13.49.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 May 2016 13:49:02 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294068>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 read-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index d9fb78b..16cc487 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1345,7 +1345,7 @@ struct ondisk_cache_entry_extended {
 			    ondisk_cache_entry_extended_size(ce_namelen(ce)) : \
 			    ondisk_cache_entry_size(ce_namelen(ce)))
=20
-static int verify_hdr(struct cache_header *hdr, unsigned long size)
+static int verify_hdr(const struct cache_header *hdr, unsigned long si=
ze)
 {
 	git_SHA_CTX c;
 	unsigned char sha1[20];
--=20
2.4.2.767.g62658d5-twtrsrc
