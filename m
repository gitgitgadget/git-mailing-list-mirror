From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH] Add missing inside_work_tree setting in
	setup_git_directory_gently
Date: Sat, 3 Nov 2007 17:03:23 +0700
Message-ID: <20071103100323.GA25305@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 03 11:03:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoFr2-0004K3-5R
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 11:03:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759046AbXKCKDg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Nov 2007 06:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759032AbXKCKDg
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 06:03:36 -0400
Received: from rv-out-0910.google.com ([209.85.198.190]:40521 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758977AbXKCKDe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 06:03:34 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1018392rvb
        for <git@vger.kernel.org>; Sat, 03 Nov 2007 03:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        bh=FBiU7Abph+9QqGfkUIpoqfMGQ3PyeVCg/KBsFcEjuB8=;
        b=ZHJ9fhMx3mOa7pXrzJbDkzNLaAkjafO2n0HhZL5pIV51zsVj4iBYUUgB2xUWH/5e2xNsxEgIrA0gsWEGdr5GAj5c72xpDa9sz4bxH2zSs9zlmIV3wEnfJ95IGWtve85OFXk/zjofFkzPo0fY1C2ttBNbtGq8zlGTPWHvkw/aeso=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        b=Mtn0iRcimni3bG+iTWkFrvee4EhcKhi+V7vkm0jAGk6nIIEvwxq7wfrX50VbfP4dSQtS9N5mwtnttlXkr2x7Uwv1Dpv4AYeq0wvYwDnZdh6iO0fVIyDtWLn4Tpjv5x5EngBg3+y0jJLov71G3HHC0GqUuos5fb15My4ZqfmevpY=
Received: by 10.141.50.17 with SMTP id c17mr1367647rvk.1194084214432;
        Sat, 03 Nov 2007 03:03:34 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.0.14])
        by mx.google.com with ESMTPS id l21sm7340602rvb.2007.11.03.03.03.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Nov 2007 03:03:33 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat,  3 Nov 2007 17:03:24 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63226>

Without this, work_tree handling code in setup_git_directory
will be activated. If you stay in root work tree (no prefix),
it does not harm. It does if you work from a subdirectory though.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Turns out my patch on NEED_WORK_TREE is fixing a wrong place.

 setup.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/setup.c b/setup.c
index 145eca5..6f8f769 100644
--- a/setup.c
+++ b/setup.c
@@ -240,6 +240,7 @@ const char *setup_git_directory_gently(int *nongit_=
ok)
 			if (chdir(work_tree_env) < 0)
 				die ("Could not chdir to %s", work_tree_env);
 			strcat(buffer, "/");
+			inside_work_tree =3D 1;
 			return retval;
 		}
 		if (nongit_ok) {
--=20
1.5.3.rc4.3.gab089
