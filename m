From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/43] builtin: USE_PAGER should not be used without RUN_SETUP*
Date: Mon,  5 Apr 2010 20:40:52 +0200
Message-ID: <1270492888-26589-8-git-send-email-pclouds@gmail.com>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:42:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrFe-0005ZJ-QB
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755931Ab0DESmD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:42:03 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35754 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755800Ab0DESmA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:42:00 -0400
Received: by vws13 with SMTP id 13so1519498vws.19
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=rLbCyhOx6tseEK6+6wvJFIiWBU3dqGqPri/s4eqYtdI=;
        b=r1JgYVhS5jVSnq2RauNdBnAGhtXOOV0GJ8Bm0VchATGZr53UuwYdKHr0ngtvfKPN41
         B/o0AEyHbg02cPnymoILip7oVOiealK16qMKuCmyzPhT7X3ekVwldYBq5Sna9h8bCaXL
         ZtfqDKIHfs4wV9gpx2TA5BYw/8lfz6untS2oQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=OvUBQMkiPasuR4dRTIqU4m9ScAIAU0jGZT8G79KlVu2O8OUprjkOJvBIO0pASTIEgh
         LUFmaxYc9JCcsITTc1IAWHA3N0PfOcyz2Z9JZ0oiUzsW3gBC6rQb1SMaJwg3+7oSBvp4
         LUgwp6skwYZNkP971SvP4k67yYpgbHLMpcfZg=
Received: by 10.220.107.73 with SMTP id a9mr2769955vcp.185.1270492919605;
        Mon, 05 Apr 2010 11:41:59 -0700 (PDT)
Received: from dektop ([72.14.241.35])
        by mx.google.com with ESMTPS id 22sm34264376vws.3.2010.04.05.11.41.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:41:58 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:41:53 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144008>

USE_PAGER may need core.pager from repository. So a repository search
should be done before core.pager is read.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git.c b/git.c
index 3904fe2..84dd78e 100644
--- a/git.c
+++ b/git.c
@@ -253,8 +253,11 @@ static int run_builtin(struct cmd_struct *p, int a=
rgc, const char **argv)
=20
 		if (use_pager =3D=3D -1 && p->option & RUN_SETUP)
 			use_pager =3D check_pager_config(p->cmd);
-		if (use_pager =3D=3D -1 && p->option & USE_PAGER)
+		if (use_pager =3D=3D -1 && p->option & USE_PAGER) {
+			if ((p->option & (RUN_SETUP | RUN_SETUP_GENTLY)) =3D=3D 0)
+				die("Internal error: USE_PAGER must be together with RUN_SETUP*");
 			use_pager =3D 1;
+		}
 	}
 	commit_pager_choice();
=20
--=20
1.7.0.rc1.541.g2da82.dirty
