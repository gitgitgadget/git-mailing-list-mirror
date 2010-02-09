From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/4] rev-parse: make --git-dir return /.git instead of //.git
Date: Wed, 10 Feb 2010 00:02:28 +0700
Message-ID: <1265734950-15145-2-git-send-email-pclouds@gmail.com>
References: <1265734950-15145-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org,
	=?UTF-8?q?Jo=C3=A3o=20Carlos=20Mendes=20Lu=C3=ADs?= 
	<jonny@jonny.eng.br>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Feb 09 18:05:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NetWk-0006xS-F6
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 18:05:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755104Ab0BIRFY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Feb 2010 12:05:24 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53343 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755030Ab0BIRFV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 12:05:21 -0500
Received: by mail-vw0-f46.google.com with SMTP id 12so351911vws.19
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 09:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=zijKXoJLcvN2vJqPe8MQhrHtZ94Uq1rblTvDa9WtvsI=;
        b=Jy1BiaDhqT++lcqeBZcklf5zbz4ShcVtildwmn0VXxTPIn5AMon+ga/WEgjqHrpKqV
         4sFEtxbg447DuNJiZ4LOBZt+o/qjSO9EXDq/BO53B6ImxfI4vxWA3kD7K/5iP5j612jH
         Zrf5rQ1F/z8HnYeqhXrjbyMkIMlu0LlbWpcJw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=KguHFeMe9hMo3QEDmARzrcPfUp8jbGHK9WUpFPOd0TCFWrZgsizmZ4msiMtnw5Sqpk
         LiK1mIhaSsQvWnH1CNzk0jgLHuWvm842yhb1nw8k2pgzly9ya49Eq79fCED6AbVAKUtt
         8rvP8DVuahxW9uD96hAhsVIMhll+O/SlKSK5I=
Received: by 10.220.122.156 with SMTP id l28mr742898vcr.123.1265735121145;
        Tue, 09 Feb 2010 09:05:21 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.235.86])
        by mx.google.com with ESMTPS id 28sm2358477vws.1.2010.02.09.09.05.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Feb 2010 09:05:20 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 10 Feb 2010 00:02:39 +0700
X-Mailer: git-send-email 1.7.0.rc2.182.g3adef
In-Reply-To: <1265734950-15145-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139416>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-rev-parse.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index a8c5043..9c22cd1 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -647,7 +647,7 @@ int cmd_rev_parse(int argc, const char **argv, cons=
t char *prefix)
 				}
 				if (!getcwd(cwd, PATH_MAX))
 					die_errno("unable to get current working directory");
-				printf("%s/.git\n", cwd);
+				printf("%s%s.git\n", cwd, *cwd =3D=3D '/' && cwd[1] =3D=3D '\0' ? =
"" : "/");
 				continue;
 			}
 			if (!strcmp(arg, "--is-inside-git-dir")) {
--=20
1.7.0.rc2.182.g3adef
