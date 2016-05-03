From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 16/41] combine-diff.c: use error_errno()
Date: Tue,  3 May 2016 19:03:49 +0700
Message-ID: <1462277054-5943-17-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue May 03 14:08:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ7O-0000Cn-GX
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:07:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933165AbcECMHy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 08:07:54 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:32899 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932610AbcECMHw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:07:52 -0400
Received: by mail-pa0-f53.google.com with SMTP id xk12so8979903pac.0
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t2u5nQO3KDMy5bdZifRGPS5giGlr5MNQmeOmuk0Z0pc=;
        b=0NTg2t5Zlb9RoU2vfCkx2J7YyMSk56CqOwa5hxwI4FuzvVJKzyHGyJQbd4dF6JRMwz
         G1mfPHiasyzEDxhBb77sstPiN5Rda3eI3jV61EGGVHgm1vLnu1CVuEvzB6YRWtQLZ+n3
         wjGXz4w+XJGNdkocuIu9bOgkxD/5ii1CiFNo2tWyOtWk87+CSISqHsamHCrk4u+nYfCk
         gN8agk79yZctgD9yMXQcbznTD/whyyLUPqu907oD7PSBeM++sjBIs3u3t2B+s3XcmdEY
         jjpH8nkjD25PjcLxDM0wtCAbdr64gsasmY22rwvF6hpPwqkdJrXMyk4wRkAUCX2iUF1b
         eAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t2u5nQO3KDMy5bdZifRGPS5giGlr5MNQmeOmuk0Z0pc=;
        b=VcDDaXwGBfTCt5bUS0wN2v6XqoAHoa31kXqMpuFHdjv+WBZWSasKXwmYm3oZmnahXq
         b/OsnDRNhRE7j36IYO0fZ+A5HDbMirH9XIb/2K0wuJwCIY7A1AhT8X8qiUFdzJ6c4Hd8
         GqE1NSXFCP3zgiPAPZNPyn7tfcvn6zqsj8J1xeqqiyN8WNUzmo2b7gIZZ9SFRzweTC6h
         ocnkccu3+sqaipBVBgOPoqqe7p0I0TG1jkxNYVqWVgqLxIeZ6ZjWcymGOvilwcRuL0ye
         fJVleREhzpKXXX+MChe1mUPU7FRW9rDQK5L1q67flk1cpA44kNO6JzOoCZwI3TyBlN1L
         eHTQ==
X-Gm-Message-State: AOPr4FWgbkdTj2XDM2QC9DGeRd0GzmUFXR8OHBeW2QUC+13CG7iAwKD23JLwTJl7K8t0XA==
X-Received: by 10.66.249.228 with SMTP id yx4mr2864155pac.29.1462277271414;
        Tue, 03 May 2016 05:07:51 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id kb15sm5498464pad.28.2016.05.03.05.07.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:07:50 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:07:47 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293367>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 combine-diff.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 0e1d4b0..8f2313d 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1005,8 +1005,7 @@ static void show_patch_diff(struct combine_diff_p=
ath *elem, int num_parent,
 			struct strbuf buf =3D STRBUF_INIT;
=20
 			if (strbuf_readlink(&buf, elem->path, st.st_size) < 0) {
-				error("readlink(%s): %s", elem->path,
-				      strerror(errno));
+				error_errno("readlink(%s)", elem->path);
 				return;
 			}
 			result_size =3D buf.len;
--=20
2.8.0.rc0.210.gd302cd2
