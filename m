From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/27] upload-pack: make check_non_tip() clean things up error
Date: Fri, 10 Jun 2016 19:26:56 +0700
Message-ID: <20160610122714.3341-10-pclouds@gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 14:28:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBLYG-0000qF-Tq
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 14:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932763AbcFJM2g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 08:28:36 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35851 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932150AbcFJM2f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 08:28:35 -0400
Received: by mail-pf0-f193.google.com with SMTP id 62so5081170pfd.3
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 05:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SLk7JQ0oq+sgT1gFI49nCgU8sE5mTUcPDaYEHgK0ksA=;
        b=mwcL6g+onHWWp1xGL1nAZw6Dagki29Dj8GmwmJGTvw7nbZ4XyOZj1S8nUo0wNUm5EZ
         EfqlDBpIdwVtajgJrzCLfb2J9D9xOaPnqYTLC9ayZXaujIsDTSMUtJe1yc9ltjd4JJp6
         93nfhxnlTlito3y5WDsYUG3lE3O5lw5nt3qRzuGLX8HdCPzAm53adP/7kVvd9W7DahmJ
         bZh0RvbJLrym4fDlvjhoa3bKfvIacHbW4rrbqAZ8N/CfN2CDo3JvGFB/ahCKkoUXNBj2
         z8EaY9xLT7376qFdLl9eajR1Hj/RzhG+V/L+ccb2bXsm5wOLPnhVTDkn3DzBoEFRlLzo
         mxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SLk7JQ0oq+sgT1gFI49nCgU8sE5mTUcPDaYEHgK0ksA=;
        b=SVMxOm4tBXZMCAU7nxjBLm+7jP6zap7IbZbx8pccyS5Lu3tTtxZSR14kywtVZznjTv
         5oPf5AhpiIbVoD/B3+l/sivF8rc4HjPiUOO+gzkI4+TiBDazCzxxTWoC8FpcMEQk0LnL
         0XF8zXb1IfYMFwvM1tCx9mbvFsBao8R/z2qg9KmyzIt3/5i4PJSgG0HG7AEg2w/xKRXf
         VjZ8pIKjBSHlhS31WNcNhqKulkJ+RBuHK9ZkHjlyTrpi82EHXY10xJKyQEa4+gt9smq5
         jWNHTObsKoL3i+6Ia5RA3wQEwyknC7PHBRyt+2z/ALOX4fLqjQhVjNVLnJBArjyfgSDX
         brTA==
X-Gm-Message-State: ALyK8tIoyFklt0g4/6bbkRk2S0t2a3cuQhpyFgtqAQyy2d+ll1Mih5qFzVlneDOugvC4ng==
X-Received: by 10.98.78.206 with SMTP id c197mr2041943pfb.129.1465561714623;
        Fri, 10 Jun 2016 05:28:34 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id s131sm17523532pfs.45.2016.06.10.05.28.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jun 2016 05:28:33 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 10 Jun 2016 19:28:29 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160610122714.3341-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296975>

On error check_non_tip() will die and not closing file descriptors is n=
o
big deal. The next patch will split the majority of this function out
for reuse in other cases, where die() may not be the only outcome. Same
story for popping SIGPIPE out of the signal chain. So let's make sure w=
e
clean things up properly first.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 upload-pack.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 60f2e5e..1e8b025 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -494,8 +494,10 @@ static void check_non_tip(void)
 		if (!is_our_ref(o))
 			continue;
 		memcpy(namebuf + 1, oid_to_hex(&o->oid), GIT_SHA1_HEXSZ);
-		if (write_in_full(cmd.in, namebuf, 42) < 0)
+		if (write_in_full(cmd.in, namebuf, 42) < 0) {
+			sigchain_pop(SIGPIPE);
 			goto error;
+		}
 	}
 	namebuf[40] =3D '\n';
 	for (i =3D 0; i < want_obj.nr; i++) {
@@ -503,10 +505,13 @@ static void check_non_tip(void)
 		if (is_our_ref(o))
 			continue;
 		memcpy(namebuf, oid_to_hex(&o->oid), GIT_SHA1_HEXSZ);
-		if (write_in_full(cmd.in, namebuf, 41) < 0)
+		if (write_in_full(cmd.in, namebuf, 41) < 0) {
+			sigchain_pop(SIGPIPE);
 			goto error;
+		}
 	}
 	close(cmd.in);
+	cmd.in =3D -1;
=20
 	sigchain_pop(SIGPIPE);
=20
@@ -518,6 +523,7 @@ static void check_non_tip(void)
 	if (i)
 		goto error;
 	close(cmd.out);
+	cmd.out =3D -1;
=20
 	/*
 	 * rev-list may have died by encountering a bad commit
@@ -531,6 +537,11 @@ static void check_non_tip(void)
 	return;
=20
 error:
+	if (cmd.in >=3D 0)
+		close(cmd.in);
+	if (cmd.out >=3D 0)
+		close(cmd.out);
+
 	/* Pick one of them (we know there at least is one) */
 	for (i =3D 0; i < want_obj.nr; i++) {
 		o =3D want_obj.objects[i].item;
--=20
2.8.2.524.g6ff3d78
