From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 11/27] fetch-pack: use skip_prefix() instead of starts_with()
Date: Sun, 12 Jun 2016 17:53:53 +0700
Message-ID: <20160612105409.22156-12-pclouds@gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
 <20160612105409.22156-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 12 12:55:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bC33T-0003Up-3Y
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jun 2016 12:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753329AbcFLKzm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jun 2016 06:55:42 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33626 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253AbcFLKzk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2016 06:55:40 -0400
Received: by mail-pf0-f193.google.com with SMTP id c74so8475844pfb.0
        for <git@vger.kernel.org>; Sun, 12 Jun 2016 03:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jQLxC7o7xm2yfY9+ZlBZtxTF3Go3hrmAUSsgKy/5xOw=;
        b=ZgrIbiAuWUwLqQl2fswLy5cAxEqVFtpwM/JsdTiX8XcTQ/6VsFIDMRLMf3UqaBErg/
         Tf9iQIGN8f3Oo0Uie2aCngJYfL1+fChj7clnozRKdLv5ZbOU3MpIR1POKBilldDFOYvR
         DXMC2/9oUvWlrt8LJVX1lmJ31+KLoKowrulq/zijZJW1lHbWDRAK00b75ypqiqxS/Vr6
         HaugINbkEt9BiKm25MpWeNhhN37N8DaYCOnU8rPNQ6BYj8y8bVuua0h/+qNxfxOZDMXw
         spR7DejjpJ5jIzW2lLBIHDim9FbwjU/Kd6KqmAWdSLzOzA8CDRFxfq1gXf1WudofICEQ
         ZTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jQLxC7o7xm2yfY9+ZlBZtxTF3Go3hrmAUSsgKy/5xOw=;
        b=dxjauUsewjqln+tgj3z+fYiJ51m6irvK8QNsnBRuzHpffNvb/0fcfgAO4XGiu63OwH
         +7SCdr79JqNBsu24s1pzmZ9uMG7KnxF106aya+lLR/0HXbttpJzRkqPhBDeOm9XD8x3L
         8NSvLjFPXP9d+V02okRq8fq63IfgEUwx/Ckf1ywfaiSxiZpBKJIoDD6WUEwHkQmo1qgf
         6CtZM2kWG+6nwWFFCTsOuHbSwXnmP85I8S3TPL61J7IfKO5FNP/jS/QeZelNBsQ86ueM
         cuBJOxndBOkT/EEmJsp2/hHhW/Yu5ee/U5AVRtpZC7aK6wValNT8XgCH6ltrIdQSY/05
         fkZQ==
X-Gm-Message-State: ALyK8tLNUP+KyEMCz1cqnprmuGbhLDivv2e1WPx+/AUwNS5NM6c0qP3VUhXwqjUaFYMh3g==
X-Received: by 10.98.32.15 with SMTP id g15mr14379881pfg.67.1465728940138;
        Sun, 12 Jun 2016 03:55:40 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id uj5sm7972870pac.28.2016.06.12.03.55.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jun 2016 03:55:39 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 12 Jun 2016 17:55:35 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160612105409.22156-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297117>

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
