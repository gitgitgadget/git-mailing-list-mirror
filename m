From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/8] checkout: no need to call check_linked_checkouts if head_ref is NULL
Date: Tue, 29 Jul 2014 20:50:25 +0700
Message-ID: <1406641831-2390-3-git-send-email-pclouds@gmail.com>
References: <1406115795-24082-1-git-send-email-pclouds@gmail.com>
 <1406641831-2390-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	git@drmicha.warpmail.net,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 15:52:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC7pe-0005cC-6J
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 15:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753788AbaG2Nwl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jul 2014 09:52:41 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:39973 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753783AbaG2Nwl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 09:52:41 -0400
Received: by mail-pa0-f47.google.com with SMTP id kx10so12380374pab.20
        for <git@vger.kernel.org>; Tue, 29 Jul 2014 06:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=PcIVciiVrKXFrqZRwWKzjUSCoLOQbxZaZMvsF5cETCk=;
        b=gVc/75n0PmUTOqzQSBMkbYCYxSlWz3+KA6EAMzTm4FuPfrVvjCCuMbASd979rOPEbv
         Z/r4IwqOzFowES+r9/036yKxgnlqybMK91uqYy4CiepLceyjw3PFW0V/dySv6VITQQTq
         lkNUd+tswZBUW9M1Vw6U8tViBZNiu8494Al9xA5yhYJWRzRHkhVV9vPTHYXRgcGXoLsK
         mg9C/G0wFFioHCz4dapvuMEDSYIINYMiiMTVKz8RdRKMZl9c1i+Ah4JacbBaBp7Xw1kW
         b1ips1PlbtgC52eromUVo9wrAHJgh3k1Hd0lG9yxQvNZL825VfTu91Qb+gI9/WugUv2s
         oaTw==
X-Received: by 10.68.103.98 with SMTP id fv2mr2343547pbb.18.1406641960760;
        Tue, 29 Jul 2014 06:52:40 -0700 (PDT)
Received: from lanh ([115.73.243.195])
        by mx.google.com with ESMTPSA id ak1sm20832297pbc.58.2014.07.29.06.52.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jul 2014 06:52:40 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 29 Jul 2014 20:52:43 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1406641831-2390-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254436>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index c83f476..6ac89eb 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1202,7 +1202,8 @@ static int parse_branchname_arg(int argc, const c=
har **argv,
 		unsigned char sha1[20];
 		int flag;
 		char *head_ref =3D resolve_refdup("HEAD", sha1, 0, &flag);
-		if (!(flag & REF_ISSYMREF) || strcmp(head_ref, new->path))
+		if (head_ref &&
+		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new->path)))
 			check_linked_checkouts(new);
 		free(head_ref);
 	}
--=20
2.1.0.rc0.78.gc0d8480
