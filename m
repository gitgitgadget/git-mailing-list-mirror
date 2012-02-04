From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 04/12] Stop starting pager recursively
Date: Sat,  4 Feb 2012 22:59:08 +0700
Message-ID: <1328371156-4009-5-git-send-email-pclouds@gmail.com>
References: <1328276078-27955-1-git-send-email-pclouds@gmail.com>
 <1328371156-4009-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 16:55:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rthxb-0006ZG-1p
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 16:55:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753685Ab2BDPz0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Feb 2012 10:55:26 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36432 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753573Ab2BDPzY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 10:55:24 -0500
Received: by mail-pz0-f46.google.com with SMTP id p15so3553938dad.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 07:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=chmaY0CVyUK6h8u6yy7EEzwg1q7ddDQxG2FG+O7Fei0=;
        b=wOYJLE/gQ6ACr5Y8UBu3s9bk8XpvhjaEbbFT9uI8U4VFEi+q7DLfCZqaSm7AvZNMZl
         DJQqX2fMSudt3KH9dH3R9lPNLlB18OKsNcoW8TrzU6OZxkmqI3j3bF/b31MAhYEEect+
         nRF+H7UWGYmIDexUx4ve6Tpkp33oqbr4LsNq0=
Received: by 10.68.118.136 with SMTP id km8mr29345152pbb.73.1328370924448;
        Sat, 04 Feb 2012 07:55:24 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id t10sm22400418pbb.18.2012.02.04.07.55.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 04 Feb 2012 07:55:23 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Sat, 04 Feb 2012 22:59:50 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1328371156-4009-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189876>

git-column can be used as a pager for other git commands, something
like this:

    GIT_PAGER=3D"git -p column --mode=3D'dense color'" git -p branch

The problem with this is that "git -p column" also has $GIT_PAGER
set so the pager runs itself again as a pager, then again and again.

Stop this.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 pager.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/pager.c b/pager.c
index 772a5a6..e4353dc 100644
--- a/pager.c
+++ b/pager.c
@@ -89,7 +89,7 @@ void setup_pager(void)
 	const char *pager =3D git_pager(isatty(1));
 	int width;
=20
-	if (!pager)
+	if (!pager || pager_in_use())
 		return;
=20
 	setenv("GIT_PAGER_IN_USE", "true", 1);
--=20
1.7.8.36.g69ee2
