From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 03/28] send-pack: forbid pushing from a shallow repository
Date: Thu,  5 Dec 2013 20:02:30 +0700
Message-ID: <1386248575-10206-4-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
 <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 05 13:58:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoYVr-0001Ki-F4
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 13:58:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122Ab3LEM6f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Dec 2013 07:58:35 -0500
Received: from mail-pb0-f45.google.com ([209.85.160.45]:42620 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932090Ab3LEM6e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 07:58:34 -0500
Received: by mail-pb0-f45.google.com with SMTP id rp16so25855085pbb.32
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 04:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=rOxvmyqBUeUv9Zic4YBbjeBRoULXDEpu7m/r6fLU/8s=;
        b=bmCERmSkY8LinyqoynD4nBvTmm9CaobhKiV0NPHDGayeEsOvYOnfSQT12b2ASbN14L
         ChvQN/0Ad8OBzOTWj2EXTiaQH06vCoR6YCxymIMLsqy6v/i1dVBEF9R6hcuLLgxtObMe
         eVz3SyyPoFuohmQjNfg+n51aW80GJEk3/176YbfDYd471FNeUsyJFxsaGov/aIu5YqIM
         +AmU3ZDhSz5NEKXSF0zagj6upy3NrjKQltSurh9hr0zga9pK+CpX116KM9HJwMiqzizD
         Rsu3Lfwrw8pASgDx4RUxd4pFCo0nPkCQQh1nFuO0sBdNsnXdaGu47Sw6CWiMqF8L42AY
         sohg==
X-Received: by 10.69.19.161 with SMTP id gv1mr51864020pbd.134.1386248314431;
        Thu, 05 Dec 2013 04:58:34 -0800 (PST)
Received: from lanh ([115.73.194.163])
        by mx.google.com with ESMTPSA id ik1sm117796702pbc.9.2013.12.05.04.58.31
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Dec 2013 04:58:33 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 05 Dec 2013 20:03:18 +0700
X-Mailer: git-send-email 1.8.5.1.25.g8667982
In-Reply-To: <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238859>

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
index faaa603..961df04 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -208,6 +208,9 @@ int cmd_send_pack(int argc, const char **argv, cons=
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
1.8.5.1.25.g8667982
