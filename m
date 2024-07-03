Received: from relay1.telecom.mipt.ru (relay1.telecom.mipt.ru [81.5.91.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACECC1741DD
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 13:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.5.91.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720014084; cv=none; b=hb1mbJ9NrQx3m7coYwYJXMU6SFoUSE7nk99AV0X41LtACt7ki+gyrIIOG9fwSs3Ogj83e101N68szjtlUYudTtEqAcYIg117YhmQgBX3nCPbFirWrElZryCS7f0A9Y/XNXCJs7RBMxUp9wB6IMeAbXH6F3BV5EU8eByuFmsj5YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720014084; c=relaxed/simple;
	bh=ahclEbCP4BlrpPwHLL31LCRmj1c18/ZSUfO4f0oBgCU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MgRZI9OcDo0DpK5OHv4gBKcmBfUmo4iBxexWDHxmpHQbA6Ijvhs9GYS0tO/y+Pxy5KnBAfeeYVJzA8Uv1iyPNSQ3Oj85gYImdQHRm6YoW8sWsmACUCI2qaJFaFR0SsTc85aASVJt0f27kZvmuI+nXQcbdSF8qnIof5bPIoqsDAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.mipt.ru; spf=pass smtp.mailfrom=mail.mipt.ru; dkim=pass (1024-bit key) header.d=mipt.ru header.i=@mipt.ru header.b=HRXQyqF+; arc=none smtp.client-ip=81.5.91.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.mipt.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.mipt.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mipt.ru header.i=@mipt.ru header.b="HRXQyqF+"
Received: from localhost (localhost [127.0.0.1])
	by relay1.telecom.mipt.ru (Postfix) with ESMTP id 6CCC011FB01;
	Wed,  3 Jul 2024 16:40:54 +0300 (MSK)
X-Virus-Scanned: Debian amavisd-new at relay2.telecom.mipt.ru
Received: from relay1.telecom.mipt.ru ([127.0.0.1])
	by localhost (relay1.telecom.mipt.ru [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id HkCQv1j8oHBK; Wed,  3 Jul 2024 16:40:49 +0300 (MSK)
Received: from mail.mipt.ru (mail.mipt.ru [81.5.91.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by relay1.telecom.mipt.ru (Postfix) with ESMTPS id AA17E11F7E9;
	Wed,  3 Jul 2024 16:40:49 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mipt.ru; s=mail;
	t=1720014049; i=@mipt.ru;
	bh=ahclEbCP4BlrpPwHLL31LCRmj1c18/ZSUfO4f0oBgCU=;
	h=From:To:Cc:Subject:Date:From;
	b=HRXQyqF+JP8nuOEU77yx12zyHSGSR4HT78/AEGsnkisv3zYHVf7leb8pxz8Ua0sCG
	 omQASIhDCZ99d7vVwCjZvs5CW1eor+7V52o+VRLeq8TvDGpbk8kUVc7W4owBaDAzmc
	 oQeFKI3RErYdZ8dI47LX63zuoCG3EFZ6zRla0MAg=
Received: from mail.mipt.ru (localhost [127.0.0.1])
	by mail.mipt.ru (Postfix) with ESMTPS id 9AFD3BC4D0F;
	Wed,  3 Jul 2024 16:40:49 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
	by mail.mipt.ru (Postfix) with ESMTP id 888BCBC4D09;
	Wed,  3 Jul 2024 16:40:49 +0300 (MSK)
Received: from mail.mipt.ru ([127.0.0.1])
 by localhost (mail.mipt.ru [127.0.0.1]) (amavis, port 10026) with ESMTP
 id VVxOAiPo2rbP; Wed,  3 Jul 2024 16:40:49 +0300 (MSK)
Received: from localhost.localdomain (81.5.104.175.dhcp.mipt-telecom.ru [81.5.104.175])
	by mail.mipt.ru (Postfix) with ESMTPSA id 30757BC49A9;
	Wed,  3 Jul 2024 16:40:49 +0300 (MSK)
From: Ivan Pozdeev <vano@mail.mipt.ru>
To: git@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ivan Pozdeev <vano@mail.mipt.ru>
Subject: [PATCH] unpack-objects: Fix EACCES pushing to remote on vmhgfs
Date: Wed,  3 Jul 2024 16:40:28 +0300
Message-Id: <20240703134028.876-1-vano@mail.mipt.ru>
X-Mailer: git-send-email 2.36.1.windows.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Creating files with 0444 mode causes EACCES opening them for writing
in some setups where the creating user does not automatically have
write access.
E.g. on a vmhgfs (VMWare shared folders) with Windows host, this causes
the file on the host to be created with the read-only attribute set
which prohibits writing for everyone.

Change the mode to 0644, explicitly signaling we want write access.

Signed-off-by: Ivan Pozdeev <vano@mail.mipt.ru>
---
 object-file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/object-file.c b/object-file.c
index 610b1f465c..bc71106ea8 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2002,7 +2002,7 @@ static int create_tmpfile(struct strbuf *tmp, const=
 char *filename)
 	strbuf_reset(tmp);
 	strbuf_add(tmp, filename, dirlen);
 	strbuf_addstr(tmp, "tmp_obj_XXXXXX");
-	fd =3D git_mkstemp_mode(tmp->buf, 0444);
+	fd =3D git_mkstemp_mode(tmp->buf, 0644);
 	if (fd < 0 && dirlen && errno =3D=3D ENOENT) {
 		/*
 		 * Make sure the directory exists; note that the contents
@@ -2019,7 +2019,7 @@ static int create_tmpfile(struct strbuf *tmp, const=
 char *filename)
=20
 		/* Try again */
 		strbuf_addstr(tmp, "/tmp_obj_XXXXXX");
-		fd =3D git_mkstemp_mode(tmp->buf, 0444);
+		fd =3D git_mkstemp_mode(tmp->buf, 0644);
 	}
 	return fd;
 }
--=20
2.36.1.windows.1

