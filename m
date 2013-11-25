From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 02/28] send-pack: forbid pushing from a shallow repository
Date: Mon, 25 Nov 2013 10:55:28 +0700
Message-ID: <1385351754-9954-3-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 25 04:52:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VknDL-0001fT-BC
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 04:51:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753045Ab3KYDvu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Nov 2013 22:51:50 -0500
Received: from mail-pb0-f51.google.com ([209.85.160.51]:44368 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752678Ab3KYDvk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Nov 2013 22:51:40 -0500
Received: by mail-pb0-f51.google.com with SMTP id up15so4837873pbc.10
        for <git@vger.kernel.org>; Sun, 24 Nov 2013 19:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=FVibd1oBGuSSjgoHjQJU+Q4eVft9CBbWmUz1wJVcQb4=;
        b=w8N/LRKVUYuNk//Fy0w2PU/cTARmgBQHnZlqYndyqnhWdQfCGYJE4YIfQk2osMPekE
         YiiY99kjx/+FEy+WMLeN4guz3vNGiAs1Hz4xobx7tv4LUDMgCAYuwfrnn9ODKkKmAIIj
         5W5i3oGtfBOkleVRVv02Oj8tnTO/N1OT5hkPRZfCM8DoC7oIaBk31ILgKeFNx8JOK/Zh
         09UZSu84obpconLZ50F905Qj+gyrgS7TXok7gF8W3PtLN6LMr9DcJ/U6FCNfiIsbPGyM
         rYjkndOOSLzX9d1XQmp9LOj5L1qKFogY4T6FpTsEwxOp7Hxag5KIEhTohLEnCcxnsg6r
         RYWg==
X-Received: by 10.66.191.162 with SMTP id gz2mr366171pac.151.1385351500252;
        Sun, 24 Nov 2013 19:51:40 -0800 (PST)
Received: from lanh ([115.73.213.240])
        by mx.google.com with ESMTPSA id qz9sm68423438pbc.3.2013.11.24.19.51.37
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 24 Nov 2013 19:51:39 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 25 Nov 2013 10:56:13 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238274>

send-pack can send a pack with loose ends to the server.  receive-pack
before 6d4bb38 (fetch: verify we have everything we need before
updating our ref - 2011-09-01) does not detect this and keeps the pack
anyway, which corrupts the repository, at least from fsck point of
view.

send-pack will learn to safely push from a shallow repository later.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/send-pack.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 4482f16..51121f2 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -207,6 +207,9 @@ int cmd_send_pack(int argc, const char **argv, cons=
t char *prefix)
 	    (send_all && args.send_mirror))
 		usage(send_pack_usage);
=20
+	if (is_repository_shallow())
+		die("attempt to push from a shallow repository");
+
 	if (remote_name) {
 		remote =3D remote_get(remote_name);
 		if (!remote_has_url(remote, dest)) {
--=20
1.8.2.83.gc99314b
