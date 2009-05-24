From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: y.a. static code analysis
Date: Sun, 24 May 2009 15:16:49 +0200
Message-ID: <20090524131648.GA22800@blimp.localdomain>
References: <927245250905231200ifbda2f6t1c54628e314d63e6@mail.gmail.com> <81b0412b0905240604q3c8c798bi6ad64d8916b4cd9e@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Clemens Buchacher <drizzd@aon.at>,
	Serhat =?utf-8?B?xZ5ldmtpIERpbsOnZXI=?= <jfcgauss@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 24 15:17:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8DZa-0005mi-RU
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 15:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375AbZEXNQ6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 May 2009 09:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbZEXNQ6
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 09:16:58 -0400
Received: from mout4.freenet.de ([195.4.92.94]:54764 "EHLO mout4.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751339AbZEXNQ5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 May 2009 09:16:57 -0400
Received: from [195.4.92.22] (helo=12.mx.freenet.de)
	by mout4.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #91)
	id 1M8DZP-0002oJ-Jt; Sun, 24 May 2009 15:16:55 +0200
Received: from x5e86.x.pppool.de ([89.59.94.134]:55381 helo=tigra.home)
	by 12.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 587) (Exim 4.69 #79)
	id 1M8DZP-0005Gf-4C; Sun, 24 May 2009 15:16:55 +0200
Received: from blimp.localdomain (blimp.home [192.168.1.28])
	by tigra.home (Postfix) with ESMTP id 5FBD9277D8;
	Sun, 24 May 2009 15:16:50 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 7EC0636D28; Sun, 24 May 2009 15:16:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <81b0412b0905240604q3c8c798bi6ad64d8916b4cd9e@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119819>

Noticed and reported by Serhat =C5=9Eevki Din=C3=A7er.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Alex Riesen, Sun, May 24, 2009 15:04:06 +0200:
> 2009/5/23 Serhat =C5=9Eevki Din=C3=A7er <jfcgauss@gmail.com>:
>=20
> > [./http-push.c:1419]: (error) Using 'lock' after it is deallocated =
/ released
>=20
> This is the only real bug.
>=20

Here's a fix.

 http-push.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/http-push.c b/http-push.c
index dac2c6e..45e8a69 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1415,8 +1415,9 @@ static void remove_locks(void)
=20
 	fprintf(stderr, "Removing remote locks...\n");
 	while (lock) {
+		struct remote_lock *next =3D lock->next;
 		unlock_remote(lock);
-		lock =3D lock->next;
+		lock =3D next;
 	}
 }
=20
--=20
1.6.3.1.93.g316b2
