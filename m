From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Rewrite some function exit paths to avoid "unreachable code" traps
Date: Sat, 17 Nov 2007 11:39:32 +0100
Message-ID: <200711171139.32631.robin.rosenberg.lists@dewire.com>
References: <Pine.LNX.4.64.0711152317140.7416@bianca.dialin.t-online.de> <Pine.LNX.4.64.0711162346270.7281@bianca.dialin.t-online.de> <20071117094617.GD4086@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Guido Ostkamp <git@ostkamp.fastmail.fm>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 17 11:37:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItL3V-0002SV-4o
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 11:37:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821AbXKQKhX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Nov 2007 05:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753256AbXKQKhX
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 05:37:23 -0500
Received: from [83.140.172.130] ([83.140.172.130]:10169 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752196AbXKQKhW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 05:37:22 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 4652C802670;
	Sat, 17 Nov 2007 11:28:13 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 23094-02; Sat, 17 Nov 2007 11:28:12 +0100 (CET)
Received: from [10.9.0.5] (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id DFEE780264D;
	Sat, 17 Nov 2007 11:28:12 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <20071117094617.GD4086@steel.home>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65267>

l=F6rdag 17 november 2007 skrev Alex Riesen:
> Noticed by Guido Ostkamp for Sun's Workshop cc.
>=20
> Originally-by: Guido Ostkamp <git@ostkamp.fastmail.fm>
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
> Guido Ostkamp, Fri, Nov 16, 2007 23:52:01 +0100:
> >
> > What about the xdiff/xdiffi.c problem that should also be solved?
> >
>=20

Please... This just looks bad. I'm sure we'll have fixup patches on the=
 list
to fix those gotos.=20

Do we support any such stupid compiler that requires a dummy goto?
If so we could just add a macro to compat-util.h

#if stupid_compiler
#define DUMMY_RETURN(x) return x;
#else
#define DUMMY_RETURN(x)
#endif

and then use it like this:

diff --git a/builtin-apply.c b/builtin-apply.c
index 8edcc08..91f8752 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -683,7 +683,6 @@ static char *git_header_name(char *line, int llen)
=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
=A0 =A0=A0=A0=A0=A0=A0}
-=A0=A0=A0=A0=A0=A0=A0return NULL;
+      DUMMY_RETURN(NULL)
=A0 }

My vote is for Guidos patch and fallback to the suggestion above if we =
support
really stupid compilers.

-- robin
