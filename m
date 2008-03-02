From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 05/10] http-push: Avoid calling setup_git_directory() twice
Date: Sun, 2 Mar 2008 17:34:19 +0700
Message-ID: <20080302103419.GA8957@laptop>
References: <cover.1204453703.git.pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 11:35:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVlX9-0003L3-T7
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 11:35:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614AbYCBKea convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Mar 2008 05:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751581AbYCBKea
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 05:34:30 -0500
Received: from gv-out-0910.google.com ([216.239.58.187]:54970 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbYCBKea (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 05:34:30 -0500
Received: by gv-out-0910.google.com with SMTP id s4so2353724gve.37
        for <git@vger.kernel.org>; Sun, 02 Mar 2008 02:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        bh=ZS++qHzZQxy83NIarLOtmtFwliX5I2RjEBN+pDFdc5k=;
        b=YK57Ch5qFN8RILgRvlmw4FBJt2BRf2OflMmNxBfZxF5wvGtkw1huW8cvyQ5Qk0aESfA/rs3ijCsf9LVVJOjb85YWZFQaWME1OC4afq4Np3rLT7crq6Lcy1C33NaVYOOpjr0U29qk4Y8jwmHIO2mcf7zsBLEV4SawLahwqw0uFQk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        b=ZHzAb0kWaMK/jWfUARP6bFe3r0iXhwYRhiq/ALcaFrRnVgP4NQhaMdUbkV5SBeTL4LExVEaQG/rP9e5iwbRVLpusiGZ6N5rv6nUPKTQ3MYaOtuMh9eCHi+XBPmg9ktnpmOA3+Pgc8CEC6k6oSuBfEVNHspLaX3kd4J2n2gTuD9s=
Received: by 10.114.191.1 with SMTP id o1mr1598982waf.117.1204454067916;
        Sun, 02 Mar 2008 02:34:27 -0800 (PST)
Received: from pclouds@gmail.com ( [117.5.2.84])
        by mx.google.com with ESMTPS id k39sm23207885wah.4.2008.03.02.02.34.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 02 Mar 2008 02:34:26 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  2 Mar 2008 17:34:19 +0700
Content-Disposition: inline
In-Reply-To: <cover.1204453703.git.pclouds@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75765>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 http-push.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/http-push.c b/http-push.c
index 5b23038..c4b28f2 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2175,7 +2175,7 @@ int main(int argc, char **argv)
 	struct ref *ref;
 	char *rewritten_url =3D NULL;
=20
-	setup_git_directory();
+	const char *prefix =3D setup_git_directory();
=20
 	remote =3D xcalloc(sizeof(*remote), 1);
=20
@@ -2382,7 +2382,7 @@ int main(int argc, char **argv)
 			commit_argv[3] =3D old_sha1_hex;
 			commit_argc++;
 		}
-		init_revisions(&revs, setup_git_directory());
+		init_revisions(&revs, prefix);
 		setup_revisions(commit_argc, commit_argv, &revs, NULL);
 		free(new_sha1_hex);
 		if (old_sha1_hex) {
--=20
1.5.4.2.281.g28d0e
