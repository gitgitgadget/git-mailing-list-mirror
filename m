From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 20/21] show-index: acknowledge that it does not read .idx v3
Date: Wed, 11 Sep 2013 13:06:21 +0700
Message-ID: <1378879582-15372-21-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Wed Sep 11 08:09:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJdcM-00080G-2y
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 08:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187Ab3IKGJa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Sep 2013 02:09:30 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:59222 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377Ab3IKGJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 02:09:29 -0400
Received: by mail-pb0-f43.google.com with SMTP id md4so8599240pbc.30
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 23:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ukwnx0wM0GdkvKxGuNI3Co7TqFfzUVT6wACusz1scqU=;
        b=hG0KGORKQZwnL8cSXYFWRotQGUR9e77y1eGFIukwlMp8bLlPLDMJnAPjChloS/IxAl
         jwv8YW/f8Am51/HZnzJ7KcjIRokWVp59CCqBfgGkCYRzCDmu/YHxFAgsY6vXRycil/wN
         M2/ncSqqZEvg/lkc4nj65ksBhwMHRP/O5hOUUACnwQISskrwspvdUBtsG//In49W2Cjw
         QsNGD8o2KGEndUa/NWm+fHEw4eCisWbeJ0RlJmGiI/rdMo3rAyI428iu2KBHXJDpsD1d
         Hg39+VtBI1CcfutH/0u7C3oGDGXQScHYFeU9EZvlJwsBoJBndb68pxeXGDwvQ5MbbC/n
         QXbw==
X-Received: by 10.66.175.133 with SMTP id ca5mr1862708pac.40.1378879767507;
        Tue, 10 Sep 2013 23:09:27 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id w6sm27441244pbt.32.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 23:09:26 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 11 Sep 2013 13:09:19 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1378879582-15372-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234544>

show-index takes .idx from stdin while v3 requires the .pack. It's
used for testing purposes only. Let those test scripts force .idx v2
with index-pack.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 show-index.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/show-index.c b/show-index.c
index 5a9eed7..2028e02 100644
--- a/show-index.c
+++ b/show-index.c
@@ -19,8 +19,10 @@ int main(int argc, char **argv)
 		die("unable to read header");
 	if (top_index[0] =3D=3D htonl(PACK_IDX_SIGNATURE)) {
 		version =3D ntohl(top_index[1]);
-		if (version < 2 || version > 2)
+		if (version < 2 || version > 3)
 			die("unknown index version");
+		if (version =3D=3D 3)
+			die("show-index does not support .idx v3, convert to v2 instead");
 		if (fread(top_index, 256 * 4, 1, stdin) !=3D 1)
 			die("unable to read index");
 	} else {
--=20
1.8.2.82.gc24b958
