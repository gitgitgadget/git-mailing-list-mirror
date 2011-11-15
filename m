From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/10] receive-pack: request resolve_ref() to allocate new buffer
Date: Tue, 15 Nov 2011 13:07:53 +0700
Message-ID: <1321337276-17803-7-git-send-email-pclouds@gmail.com>
References: <20111115060603.GA17585@tre>
 <1321337276-17803-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 15 07:06:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQC9y-0005p2-Lj
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 07:06:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500Ab1KOGFy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Nov 2011 01:05:54 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41979 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349Ab1KOGFx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 01:05:53 -0500
Received: by mail-yx0-f174.google.com with SMTP id q3so231832yen.19
        for <git@vger.kernel.org>; Mon, 14 Nov 2011 22:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=8FhwqZPN6AF3nzdGEEvd/G0EQdIwoMokQxrCNIEQA7g=;
        b=vcnoPDhKmOqpcZoU+gR89sJYqIOH5XuiR0LJPedrvn7wZl62kiTT4H8iax6Pa4Hs52
         hUA3yOEcJm/sq8wuK3gZWGR/6S4LjDM6v4BT2RM5DgKVGvtARoyH/m7gY5ZblEmJXoZO
         51TDYoSaVgdN92fMy2SuXP2PKnlmQMzzZbn/E=
Received: by 10.68.29.101 with SMTP id j5mr55925453pbh.61.1321337152445;
        Mon, 14 Nov 2011 22:05:52 -0800 (PST)
Received: from tre ([115.74.43.88])
        by mx.google.com with ESMTPS id s4sm62422217pbq.8.2011.11.14.22.05.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Nov 2011 22:05:51 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Tue, 15 Nov 2011 13:08:37 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1321337276-17803-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185432>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/receive-pack.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 903f2c5..e447adb 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -36,7 +36,7 @@ static int use_sideband;
 static int prefer_ofs_delta =3D 1;
 static int auto_update_server_info;
 static int auto_gc =3D 1;
-static const char *head_name;
+static char *head_name;
 static int sent_capabilities;
=20
 static enum deny_action parse_deny_action(const char *var, const char =
*value)
@@ -695,7 +695,8 @@ static void execute_commands(struct command *comman=
ds, const char *unpacker_erro
=20
 	check_aliased_updates(commands);
=20
-	head_name =3D resolve_ref("HEAD", sha1, 0, NULL, 0);
+	free(head_name);
+	head_name =3D resolve_ref("HEAD", sha1, 0, NULL, 1);
=20
 	for (cmd =3D commands; cmd; cmd =3D cmd->next)
 		if (!cmd->skip_update)
--=20
1.7.4.74.g639db
