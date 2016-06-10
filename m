From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/27] fetch-pack: use skip_prefix() instead of starts_with()
Date: Fri, 10 Jun 2016 19:26:58 +0700
Message-ID: <20160610122714.3341-12-pclouds@gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 14:29:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBLYP-0000xB-L1
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 14:28:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932828AbcFJM2q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 08:28:46 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35324 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932602AbcFJM2o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 08:28:44 -0400
Received: by mail-pa0-f65.google.com with SMTP id gp3so5024596pac.2
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 05:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jQLxC7o7xm2yfY9+ZlBZtxTF3Go3hrmAUSsgKy/5xOw=;
        b=Iv7rVoSn+PL/R4iQtfs+xB88YkFNWJdGLTh5nd9lOE+BSSH+isay2RF7HMvW8tRWdX
         z8qwlbiN993hJ7iA+wzoKyqAmFPQi7ozuiM7bV0rKoxLasDL4tWYr9C8F74/UdIpJRz4
         7rhlUjbaO3PBeBuHj4qkBLJ6/s86TH8Hd4Ft+k3uJJ+EQHp0nHrpCW6Lu6RyNoia0oyR
         3DkDsUKNM8aTCBnp5TdWhKQXC7qYGqrJKUD7giHPc6XM8xNqcrM653UwwXa/YWZH2NVL
         hNyASlQZdzwBUkM5a8+ny0a2GZj+C9pfWrQ49gnIEsoANofCNFokZs5/zz8vtM8XA+kx
         sx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jQLxC7o7xm2yfY9+ZlBZtxTF3Go3hrmAUSsgKy/5xOw=;
        b=VrB0mUAEXXdsEiS2r28sowsbQUs2EEVVBVl+ifEZrTODjwq0sewxcP6o3xIE0fS5xY
         mN/pR3HdZnW36CoRY365cu5+41VSCZd81ITF+r1zK+m+PeHqqAqBCr5hczIciPArMW9J
         aWdsHb+ATwEmtq6SSErdbcIcWbR88F+j01DzI4ETVRWXStIFMBULlCFkLPRgINkQiwto
         0oYw9CKqqLY+8NUTXa8snii8K278Z0w+e3AosulXaatyASRS4JbBYamOYA2XEgZH8ONj
         enXcGcu0hyXLccLMAec6MmqEMraxuCcPJObU7XNhvzVtzrFasKhylkZp8NYQHrf9Tnd7
         VWmA==
X-Gm-Message-State: ALyK8tIjtzpVCA9hFCfZOt+tSvoQfGL28SU0UE4H/UoemQpKGoT4mOdssLFyIyQR9uMCyQ==
X-Received: by 10.66.230.162 with SMTP id sz2mr2062276pac.138.1465561723856;
        Fri, 10 Jun 2016 05:28:43 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id d8sm17476571pfg.72.2016.06.10.05.28.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jun 2016 05:28:43 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 10 Jun 2016 19:28:39 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160610122714.3341-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296979>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fetch-pack.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 9b2a514..8332d3d 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -59,12 +59,12 @@ int cmd_fetch_pack(int argc, const char **argv, con=
st char *prefix)
 	for (i =3D 1; i < argc && *argv[i] =3D=3D '-'; i++) {
 		const char *arg =3D argv[i];
=20
-		if (starts_with(arg, "--upload-pack=3D")) {
-			args.uploadpack =3D arg + 14;
+		if (skip_prefix(arg, "--upload-pack=3D", &arg)) {
+			args.uploadpack =3D arg;
 			continue;
 		}
-		if (starts_with(arg, "--exec=3D")) {
-			args.uploadpack =3D arg + 7;
+		if (skip_prefix(arg, "--exec=3D", &arg)) {
+			args.uploadpack =3D arg;
 			continue;
 		}
 		if (!strcmp("--quiet", arg) || !strcmp("-q", arg)) {
@@ -100,8 +100,8 @@ int cmd_fetch_pack(int argc, const char **argv, con=
st char *prefix)
 			args.verbose =3D 1;
 			continue;
 		}
-		if (starts_with(arg, "--depth=3D")) {
-			args.depth =3D strtol(arg + 8, NULL, 0);
+		if (skip_prefix(arg, "--depth=3D", &arg)) {
+			args.depth =3D strtol(arg, NULL, 0);
 			continue;
 		}
 		if (!strcmp("--no-progress", arg)) {
--=20
2.8.2.524.g6ff3d78
