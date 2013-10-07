From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Feature Request: gitignore recursion
Date: Mon, 7 Oct 2013 20:41:42 +0700
Message-ID: <20131007134141.GA23026@lanh>
References: <loom.20131007T000517-673@post.gmane.org>
 <CACsJy8CHcyDrzieX1Ps3LU2UxCP+QJdv9+5BXZj9Mw2bMs5v3w@mail.gmail.com>
 <20131007112411.GA5792@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: AJ <alljeep@gmail.com>, Git Mailing List <git@vger.kernel.org>,
	Jonathan Niedier <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 07 15:38:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTB0n-00043K-UB
	for gcvg-git-2@plane.gmane.org; Mon, 07 Oct 2013 15:38:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753459Ab3JGNiF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Oct 2013 09:38:05 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55641 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753350Ab3JGNiD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Oct 2013 09:38:03 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so7081209pbb.5
        for <git@vger.kernel.org>; Mon, 07 Oct 2013 06:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=o6I/DOzdHkt4ssfMSpQ7RWYeplNk6jhRnSbyMFwmh7g=;
        b=eFXFlV2px7+iRIvSrjLMqm+Nqy9Hpnx+iWoQi9tS6EQY+JtJy7x8+r3MJMeEEV+5zI
         x/FdIP6xFOjNeHutwXyBnZbB4pjs8Ma6d9mv5wvsmjw1zkegj9AM8OcIBtHjTSN6jbhX
         22Da4xllVXWrBmMpsONwUH6GBCuExP7gjtnaOrp+zf/ROOoo6JS7hz2D701N16p0/Qmy
         cY7J7NXDMLtbqZFH5z847jWPwouKnP7jxjDdujvidDHOMI83HZ4cbamZVTw3nUrRG3jA
         ySCUon2+PSCpdVu35t99fVK/sC7IX/OhOAsaoxILrUhe9ouIcafX+LY+kr1Ybr9Bbzdb
         n5Eg==
X-Received: by 10.68.195.36 with SMTP id ib4mr31110385pbc.56.1381153082547;
        Mon, 07 Oct 2013 06:38:02 -0700 (PDT)
Received: from lanh ([115.73.233.66])
        by mx.google.com with ESMTPSA id os4sm33422869pbb.25.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 07 Oct 2013 06:38:01 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 07 Oct 2013 20:41:42 +0700
Content-Disposition: inline
In-Reply-To: <20131007112411.GA5792@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235760>

On Mon, Oct 07, 2013 at 07:24:11AM -0400, Jeff King wrote:
> However, one thing I expected to work but didn't is:
>=20
>   echo '*' >.gitignore
>   echo '!*' >my_dir/.gitignore
>=20
> That _does_ work for attributes, like:
>=20
>   echo '* foo=3Done' >.gitattributes
>   echo '* foo=3Dtwo' >my_dir/.gitattributes
>=20
> where the more-specific file takes precedence. It works because we ke=
ep
> an attribute stack, and look from most-specific directory to least.
>
> ...

Yeah. I'm still bugged about that because we could at least make your
case work (deep/down/.gitignore will never ever, of course) but I
probably won't do anything about it for the next few months. So how
about this.

The first use of footnote:[] is already in git-notes.txt. The second
instance should not cause any issues with supported asciidoc versions.

-- 8< --
Subject: [PATCH] gitignore.txt: note about a behavior not so obvious mu=
ch to users


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/gitignore.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 54e334e..cd59f6e 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -21,7 +21,10 @@ Each line in a `gitignore` file specifies a pattern.
 When deciding whether to ignore a path, Git normally checks
 `gitignore` patterns from multiple sources, with the following
 order of precedence, from highest to lowest (within one level of
-precedence, the last matching pattern decides the outcome):
+precedence, the last matching pattern decides the outcome
+footnote:[Due to optimizations Git will not look further into ignored
+directories. So if you have a rule to ignore directory `foo`,
+`.gitignore` in `foo` and its subdirectories are all ignored]):
=20
  * Patterns read from the command line for those commands that support
    them.
--=20
1.8.2.83.gc99314b
-- 8< --
