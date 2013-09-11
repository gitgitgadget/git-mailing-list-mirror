From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/21] pack v4: lift dict size check in load_dict()
Date: Wed, 11 Sep 2013 13:06:07 +0700
Message-ID: <1378879582-15372-7-git-send-email-pclouds@gmail.com>
References: <xmqqtxhswexg.fsf@gitster.dls.corp.google.com>
 <1378879582-15372-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 11 08:07:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJdaV-0005N1-Od
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 08:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755126Ab3IKGHf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Sep 2013 02:07:35 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33399 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755015Ab3IKGHf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 02:07:35 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz10so8771346pad.30
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 23:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Fo2+1IaelLP9pcrvDp2mo/TXjdXN+vwpqgtN1PChefs=;
        b=aNC4rxiAR5mwxNW6K7DwbxAKfjXo28dyngH+ApcxdVoa9y1fbiLIUjqAzwsaLei3Ol
         Wb9MEEttAT+CoBesHQNzsIgtTg2ZviguM/ecWhUZhKmwnqQLvc+kcZREwEdrA+fBHo+n
         p1C5mJj+1bzARn1q2lRuQriWqK9IWiSBFjDp7UnE5rqZaTgoRTBzA72dhBgKaoH3RKsh
         ja3iOacEfaLJ8qbn4hspNe6JXs+lJ5Ju5KkLcwRWmD3hYyn+xNPQ/3Qa23hivbolkxQD
         uL6qYaM4+8IdAyZPuJslEVCpiA9s2DS7cg1AGJPG/YcpOyVQh89LQ70UqnCIJHqqXPgQ
         +WHQ==
X-Received: by 10.68.189.5 with SMTP id ge5mr29652641pbc.42.1378879654663;
        Tue, 10 Sep 2013 23:07:34 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id go4sm23644601pbb.15.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 23:07:34 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 11 Sep 2013 13:07:27 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1378879582-15372-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234530>

A pack with no trees (or an empty pack) could have zero-sized name
dictionary.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 packv4-parse.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/packv4-parse.c b/packv4-parse.c
index f96acc1..80ad6fc 100644
--- a/packv4-parse.c
+++ b/packv4-parse.c
@@ -87,10 +87,6 @@ static struct packv4_dict *load_dict(struct packed_g=
it *p, off_t *offset)
 	src =3D use_pack(p, &w_curs, curpos, &avail);
 	cp =3D src;
 	dict_size =3D decode_varint(&cp);
-	if (dict_size < 3) {
-		error("bad dict size");
-		return NULL;
-	}
 	curpos +=3D cp - src;
=20
 	data =3D xmallocz(dict_size);
--=20
1.8.2.82.gc24b958
