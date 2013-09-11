From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/21] fixup! pack v4: support "end-of-pack" indicator in index-pack and pack-objects
Date: Wed, 11 Sep 2013 13:06:04 +0700
Message-ID: <1378879582-15372-4-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Wed Sep 11 08:07:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJdaC-0004w6-Bf
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 08:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754547Ab3IKGHO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Sep 2013 02:07:14 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:58012 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098Ab3IKGHN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 02:07:13 -0400
Received: by mail-pa0-f49.google.com with SMTP id ld10so8787145pab.22
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 23:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=V+eLVqEPFXTSKjpsRsMU8BdB6vRAs06kI3alyBQFE7U=;
        b=HOHAor4eq1+FphUGFjxeoUHzUS0FzEOzUwhJoEwAGke8RvG0WZoPCaWFt7cyI799DU
         5o+aGtvrJpToU2FpDkTxDeXvI5vcXCmjw5Rhl2rOHneVK5jjEnlBXgqYRcjVPfHw4DA8
         cX78Y4VreGIGn4jW8INoDdja7VZtT7t2vT9Wfg7YYTVAxck7lMbb+gQHbap5Q+J/WXU2
         sKfw9FlWvS5ZlN3uSEJBExObQ4vH+OAJMCYTbHUZRGLqp1TgIlGSo0F2T4VtDuSWaCLl
         aKTQ82L/MuHFcSptTtJnlVzmyuTwemOS/LHrYnmNgIOiv1xH4s+UrtNN5TrXc0+yCYkZ
         ELsQ==
X-Received: by 10.68.200.34 with SMTP id jp2mr29105781pbc.53.1378879632421;
        Tue, 10 Sep 2013 23:07:12 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id 7sm1060349paf.22.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 23:07:11 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 11 Sep 2013 13:07:05 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1378879582-15372-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234527>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 nr_objects contains a lot more than the number of objects to be
 written.

 builtin/pack-objects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index b60b1a0..39d1e08 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -872,7 +872,7 @@ static void write_pack_file(void)
 			 * Pack v4 thin pack is terminated by a "type
 			 * 0, size 0" in variable length encoding
 			 */
-			if (pack_version =3D=3D 4 && nr_written < nr_objects)
+			if (pack_version =3D=3D 4 && nr_written < v4.all_objs_nr)
 				sha1write(f, &type_zero, 1);
 			sha1close(f, sha1, CSUM_CLOSE);
 		} else if (nr_written =3D=3D nr_remaining) {
--=20
1.8.2.82.gc24b958
