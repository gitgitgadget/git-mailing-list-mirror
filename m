From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] fread does not return negative on error
Date: Mon, 22 Jun 2009 18:42:33 +0200
Message-ID: <4A3FB479.2090902@lsrfire.ath.cx>
References: <4A3FB09D.9050903@gmail.com> <20090622153431.GA18466@elte.hu> <25e057c00906220847t15425f38maf486c291d1d2468@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>
To: roel kluin <roel.kluin@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 18:42:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MImbW-0002B0-1P
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 18:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965AbZFVQmg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Jun 2009 12:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbZFVQmf
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 12:42:35 -0400
Received: from india601.server4you.de ([85.25.151.105]:36290 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261AbZFVQmf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 12:42:35 -0400
Received: from [10.0.1.101] (p57B7CB36.dip.t-dialin.net [87.183.203.54])
	by india601.server4you.de (Postfix) with ESMTPSA id E12A72F8066;
	Mon, 22 Jun 2009 18:42:36 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <25e057c00906220847t15425f38maf486c291d1d2468@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122048>

Hi,

the following patch is for git.  I just removed the unneeded check for
res =3D=3D 0 from your version.  Does it look OK?

Thanks,
Ren=E9

--- snip! ---
=46rom: Roel Kluin <roel.kluin@gmail.com>

size_t res cannot be less than 0. fread returns 0 on error.

Reported-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
 strbuf.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index a884960..f03d117 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -260,7 +260,7 @@ size_t strbuf_fread(struct strbuf *sb, size_t size,=
 FILE *f)
 	res =3D fread(sb->buf + sb->len, 1, size, f);
 	if (res > 0)
 		strbuf_setlen(sb, sb->len + res);
-	else if (res < 0 && oldalloc =3D=3D 0)
+	else if (oldalloc =3D=3D 0)
 		strbuf_release(sb);
 	return res;
 }
