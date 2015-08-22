From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/8] grep: make it clear i-t-a entries are ignored
Date: Sat, 22 Aug 2015 08:08:09 +0700
Message-ID: <1440205700-19749-7-git-send-email-pclouds@gmail.com>
References: <xmqqy4j80wdb.fsf@gitster.dls.corp.google.com>
 <1440205700-19749-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, phiggins@google.com,
	snoksrud@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 22 03:09:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSxJ4-00052E-A8
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 03:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752992AbbHVBJI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2015 21:09:08 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35533 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752981AbbHVBJH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 21:09:07 -0400
Received: by pacdd16 with SMTP id dd16so54732254pac.2
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 18:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=QzKtPsvKm5oBtgq2pFRPMAHvLSNpBOBgWhx+DxHgxQM=;
        b=bpbSIYTm9dftsHTbCX/3Nzt/Jbw5/0AWGJSMV1idKVZQZxtup07vEJG0ENjvFEow1h
         9N55rVjlH73kWe2VT/EB43KCRYTQVqQ6UXWxeHM7bfNjDQGNocoKWLnB7zveP9vLU379
         qmejTQpXDg8FRFJoChBfAHmlqjfmw9ozJXqBMjVdKhyi2JfxRSYMXEQ98NyuaEQYlOxn
         3tGoS3EJrSMcGHJIxm+2YHgdWTi8QDxgpRHS07tT+DpUsnpNv6RpllazEpv4cKg8Yllm
         bcx6egWNy5HUSDX92Hw4bzhwRhXYegWcld/EX9/gsIQX4MjIwB0YSumDPaEKNLnhA8AO
         QKOw==
X-Received: by 10.68.88.130 with SMTP id bg2mr22467719pbb.129.1440205746703;
        Fri, 21 Aug 2015 18:09:06 -0700 (PDT)
Received: from lanh ([171.232.84.126])
        by smtp.gmail.com with ESMTPSA id au10sm9107198pbd.81.2015.08.21.18.09.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2015 18:09:06 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 22 Aug 2015 08:09:02 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1440205700-19749-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276358>

The expression "!S_ISREG(ce)" covers i-t-a entries as well because
ce->ce_mode would be zero then. I could make a comment saying that, but
it's probably better just to comment with code, in case i-t-a entry
content changes in future.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index d04f440..f508179 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -375,7 +375,7 @@ static int grep_cache(struct grep_opt *opt, const s=
truct pathspec *pathspec, int
=20
 	for (nr =3D 0; nr < active_nr; nr++) {
 		const struct cache_entry *ce =3D active_cache[nr];
-		if (!S_ISREG(ce->ce_mode))
+		if (!S_ISREG(ce->ce_mode) || ce_intent_to_add(ce))
 			continue;
 		if (!ce_path_match(ce, pathspec, NULL))
 			continue;
--=20
2.3.0.rc1.137.g477eb31
