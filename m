From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Fix symbolic ref validation
Date: Wed, 5 Oct 2005 17:52:12 +0200
Message-ID: <20051005155212.GA16391@diku.dk>
References: <433B3B10.5050407@zytor.com> <20051005131631.GA9442@diku.dk> <Pine.LNX.4.63.0510051556320.14244@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 05 17:55:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENBZ3-0000gc-9D
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 17:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbVJEPwO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 5 Oct 2005 11:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030190AbVJEPwO
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 11:52:14 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:57593 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S1030186AbVJEPwN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Oct 2005 11:52:13 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 19D8A6DFD36; Wed,  5 Oct 2005 17:52:05 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id CBE926DFD14; Wed,  5 Oct 2005 17:52:04 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 63D6360F44; Wed,  5 Oct 2005 17:52:12 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0510051556320.14244@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.6i
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9713>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote Wed, Oct 05, 200=
5:
> Hi,

Hello,

> On Wed, 5 Oct 2005, Jonas Fonseca wrote:
>=20
> >   user@machine /usr/local/dev/git/git
> >   $ git-log
> >   fatal: Not a git repository
> >=20
> >   user@machine /usr/local/dev/git/git
> >   $ GIT_DIR=3D.git git-log | wc -l
> >   26094
>=20
> That could have its cause in your .git/HEAD being no symlink. That ha=
ppens=20
> when rsync=B4ing the .git directory.

Yes, used rsync when I cloned. Seems validate_symref() was buggy.=20

> The other errors could also stem from the fact that quite a few place=
s=20
> expect HEAD to be a symlink.

git-reset still error out ...

---

Use the correct buffer when validating 'ref: refs/...'

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---
diff --git a/refs.c b/refs.c
--- a/refs.c
+++ b/refs.c
@@ -46,7 +46,7 @@ int validate_symref(const char *path)
 	len -=3D 4;
 	while (len && isspace(*buf))
 		buf++, len--;
-	if (len >=3D 5 && !memcmp("refs/", buffer, 5))
+	if (len >=3D 5 && !memcmp("refs/", buf, 5))
 		return 0;
 	return -1;
 }

--=20
Jonas Fonseca
