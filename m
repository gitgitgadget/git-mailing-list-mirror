From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: Re: Compiler warning under cygwin/mingw (was: fix for 50a6c8e)
Date: Mon, 29 Feb 2016 15:05:14 +0100
Message-ID: <1456754714-25237-1-git-send-email-szeder@ira.uka.de>
References: <20160229104708.GA17042@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 29 15:06:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaOSt-0005AS-Av
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 15:06:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbcB2OGT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Feb 2016 09:06:19 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:46369 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750709AbcB2OGS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Feb 2016 09:06:18 -0500
Received: from x590c46ff.dyn.telefonica.de ([89.12.70.255] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1aaOSW-00032T-RY; Mon, 29 Feb 2016 15:06:06 +0100
X-Mailer: git-send-email 2.7.2.410.g92cb358
In-Reply-To: <20160229104708.GA17042@sigill.intra.peff.net>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1456754766.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287839>

Hi,

> > And MINGW is not happy for other reasons:
> >
> > builtin/rev-parse.c: In function 'cmd_rev_parse':
> > builtin/rev-parse.c:775:12: warning: implicit declaration of functi=
on
> > 'realpath' [-Wimplicit-function-declaration]
> >        if (!realpath(gitdir, absolute_path))
> >             ^
>=20
> I guess you're building "pu"; that is only in sg/completion-updates. =
I
> don't know if our custom real_path() would suffice there. You might w=
ant
> to ping the author. The patch is:
>=20
>   http://article.gmane.org/gmane.comp.version-control.git/287462

Oh, I was not aware that there is a custom real_path() that is
preferred over the system realpath().  I don't see why our real_path()
would not suffice, it even makes the code a tad shorter.

I will include the patch below in the reroll.

Best,
G=C3=A1bor


 ----  >8  ----
Subject: [PATCH] fixup! rev-parse: add '--absolute-git-dir' option

---
 builtin/rev-parse.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 90a4dd6032c0..d6d9a82c77c4 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -762,10 +762,7 @@ int cmd_rev_parse(int argc, const char **argv, con=
st char *prefix)
 					if (!gitdir && !prefix)
 						gitdir =3D ".git";
 					if (gitdir) {
-						char absolute_path[PATH_MAX];
-						if (!realpath(gitdir, absolute_path))
-							die_errno(_("unable to get absolute path"));
-						puts(absolute_path);
+						puts(real_path(gitdir));
 						continue;
 					}
 				}
--=20
2.7.2.410.g92cb358
