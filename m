From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
Subject: [PATCH] Fix bug introduced by the latest changes to git-pack-redundant
Date: Fri, 18 Nov 2005 17:30:29 +0100
Message-ID: <437E01A5.7040501@etek.chalmers.se>
References: <81b0412b0511150749g5672158v7b39c02ffdf13e08@mail.gmail.com> <20051115213442.GA4256@steel.home> <437A560E.8020500@etek.chalmers.se> <20051115223340.GA3951@steel.home> <437C819C.4040507@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>,
	Alex Riesen <raa.lkml@gmail.com>, junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Nov 18 17:34:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ed97p-0007lm-9v
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 17:30:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbVKRQaA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 18 Nov 2005 11:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbVKRQaA
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 11:30:00 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:29597 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932362AbVKRQ37 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 11:29:59 -0500
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout2-sn1.fre.skanova.net (7.2.069.1)
        id 437D32AE000325D8; Fri, 18 Nov 2005 17:29:58 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <437C819C.4040507@etek.chalmers.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12239>

I forgot to initialize part of the pll struct when copying it.
=46ound by valgrind.

Signed-off-by: Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>
---

 pack-redundant.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

applies-to: 500482a7b3ebb2ebac182136696cb124332feba8
b51be59ab5b323ef148f833976a9c324d6a27404
diff --git a/pack-redundant.c b/pack-redundant.c
index 2d7183e..3123f45 100644
--- a/pack-redundant.c
+++ b/pack-redundant.c
@@ -442,7 +442,7 @@ void minimize(struct pack_list **min)
 			break; /* ignore all larger permutations */
 		if (is_superset(perm->pl, missing)) {
 			new_perm =3D xmalloc(sizeof(struct pll));
-			new_perm->pl =3D perm->pl;
+			memcpy(new_perm, perm, sizeof(struct pll));
 			new_perm->next =3D perm_ok;
 			perm_ok =3D new_perm;
 		}
---
0.99.9.GIT
