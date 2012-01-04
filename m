From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Catch invalid --depth option passed to clone or fetch
Date: Wed,  4 Jan 2012 17:01:55 +0700
Message-ID: <1325671315-24931-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 04 11:02:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiNfg-0002jE-05
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 11:02:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754973Ab2ADKCH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Jan 2012 05:02:07 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64078 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229Ab2ADKCF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2012 05:02:05 -0500
Received: by iaeh11 with SMTP id h11so32327433iae.19
        for <git@vger.kernel.org>; Wed, 04 Jan 2012 02:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=XWOhDt4t66PTNuGTLaKviwl42S6PeRWMdY8Z0TlCjKs=;
        b=BbZg8q764W8ftY1i8rC2bAyqm6CbaSb8RdvGxh8eLkh4iziSZrBRa8buTJJZ+Zpu1h
         meCIKIY99LPhTE9EP/Rej4K9FIwweSxC2PF+9Uf7av/os6TTaZu3euQQC1W5X4fZDkLJ
         aojGUTAK42yAABFLIGhGQsV4+73DMFDE5skH0=
Received: by 10.42.162.130 with SMTP id y2mr57588430icx.26.1325671324883;
        Wed, 04 Jan 2012 02:02:04 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id lu10sm94738107igc.0.2012.01.04.02.02.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 Jan 2012 02:02:03 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 04 Jan 2012 17:01:57 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187917>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 transport.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/transport.c b/transport.c
index 51814b5..8a13f43 100644
--- a/transport.c
+++ b/transport.c
@@ -474,8 +474,12 @@ static int set_git_option(struct git_transport_opt=
ions *opts,
 	} else if (!strcmp(name, TRANS_OPT_DEPTH)) {
 		if (!value)
 			opts->depth =3D 0;
-		else
-			opts->depth =3D atoi(value);
+		else {
+			char *end;
+			opts->depth =3D strtol(value, &end, 0);
+			if (*end)
+				die("transport: invalid depth option '%s'", value);
+		}
 		return 0;
 	}
 	return 1;
--=20
1.7.3.1.256.g2539c.dirty
