From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/5] dir.c: clean the entire struct in clear_exclude_list()
Date: Wed,  2 Dec 2015 20:13:42 +0100
Message-ID: <1449083626-20075-2-git-send-email-pclouds@gmail.com>
References: <1449083626-20075-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Max Kirillov <max@max630.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 02 20:14:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4Cqx-0003GB-Oq
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 20:14:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933078AbbLBTOG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Dec 2015 14:14:06 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:34645 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932376AbbLBTOF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 14:14:05 -0500
Received: by wmvv187 with SMTP id v187so270344933wmv.1
        for <git@vger.kernel.org>; Wed, 02 Dec 2015 11:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=KcEjl9cFHulu/bor7Fj7A9Ti6wH0pFI325dccR5TG3U=;
        b=ImHMpgduD+gGHIl3ji2LyZMQ7m8GVEWDt2hrQOeLY5NiO78p1rDKDFz39vob4E1L5D
         EPYMNwLh9ZyZBgnaJBUZTBTpjuJJWY7YNSWx6/P5JZTGVgjhAm/EUgTcqhaWTEczAk+4
         IZ8u/RSQeTgngINqYvaj539adJi5sivMiIekoSRO7zqJCcmMSb53SGLQSne2si2LsCHD
         zkbDUGT48SBY1Hb5RXEZmo2dcJizDKQFZgJpdfkT5FuvvGOj+8pWGet+3gSSotn5IxQ2
         MCk2Aoepb/j7GwxVl0VmrTbPdDYWMaZ051qGG7uvweX49y5J0EzUQ27xW+LdQbSKatYh
         zjpA==
X-Received: by 10.28.23.83 with SMTP id 80mr7996784wmx.78.1449083644288;
        Wed, 02 Dec 2015 11:14:04 -0800 (PST)
Received: from duynguyen-vnpc.dek-tpc.internal.homenet.telecomitalia.it (host171-164-static.60-79-b.business.telecomitalia.it. [79.60.164.171])
        by smtp.gmail.com with ESMTPSA id uz5sm4090822wjc.8.2015.12.02.11.14.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Dec 2015 11:14:03 -0800 (PST)
X-Mailer: git-send-email 2.2.0.513.g477eb31
In-Reply-To: <1449083626-20075-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281901>

Make sure "el" can be reuseable again. The problem was el->alloc is
not cleared and may cause segfaults next time because add_exclude()
thinks el->excludes (being NULL) has enough space. Just clear the
entire struct to be safe.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index d2a8f06..b8b4576 100644
--- a/dir.c
+++ b/dir.c
@@ -564,9 +564,7 @@ void clear_exclude_list(struct exclude_list *el)
 	free(el->excludes);
 	free(el->filebuf);
=20
-	el->nr =3D 0;
-	el->excludes =3D NULL;
-	el->filebuf =3D NULL;
+	memset(el, 0, sizeof(*el));
 }
=20
 static void trim_trailing_spaces(char *buf)
--=20
2.2.0.513.g477eb31
