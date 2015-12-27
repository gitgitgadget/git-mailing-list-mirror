From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/6] grep: make it clear i-t-a entries are ignored
Date: Sun, 27 Dec 2015 08:51:32 +0700
Message-ID: <1451181092-26054-7-git-send-email-pclouds@gmail.com>
References: <1451181092-26054-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 27 02:52:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aD0VP-0006Rc-85
	for gcvg-git-2@plane.gmane.org; Sun, 27 Dec 2015 02:52:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754422AbbL0BwN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Dec 2015 20:52:13 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34884 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754282AbbL0BwE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Dec 2015 20:52:04 -0500
Received: by mail-pf0-f176.google.com with SMTP id 78so94561753pfw.2
        for <git@vger.kernel.org>; Sat, 26 Dec 2015 17:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=QzKtPsvKm5oBtgq2pFRPMAHvLSNpBOBgWhx+DxHgxQM=;
        b=he5ls/A9EY0gtjHt/PzLXqncrGb3waGrzFwLX1vyfai2de/eTWvRlElI7kbA3v5731
         r2Ww0aABNM2kSi3dSoOb5zjlrlX3FDybd6UMsMTwfGHCwyXxzIK0Xw2MO4D+4nD0qg/6
         mSr1fmb8VxCQat+/0Q7RK23yW0r5suYyNr7MvwMM6fON27I3awliLEJbR37UCGZ5hxFu
         be5ZV40Jfuy7xhEbcOAS6q0vWpL/GdiQsxHfm0dieHQOhN2Amgf4UGBOpindYfzGtNyE
         iv69F++e39HtKI/cpkJhM7NwXh67OKZkSE2pz4VQgowUESJq4Tmu0VcX9Wm2kywWSord
         VOHg==
X-Received: by 10.98.19.82 with SMTP id b79mr27047599pfj.28.1451181123909;
        Sat, 26 Dec 2015 17:52:03 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id uz4sm72570077pac.39.2015.12.26.17.52.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Dec 2015 17:52:02 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 27 Dec 2015 08:52:09 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1451181092-26054-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283002>

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
