From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Unix root dir as a work tree
Date: Mon, 8 Feb 2010 09:18:25 +0700
Message-ID: <fcaeb9bf1002071818j29fe919bve0ef2d1c4cac8a79@mail.gmail.com>
References: <4B6F6971.6000106@jonny.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Jo=C3=A3o_Carlos_Mendes_Lu=C3=ADs?= <jonny@jonny.eng.br>
X-From: git-owner@vger.kernel.org Mon Feb 08 03:19:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeJDR-0004VM-Aw
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 03:19:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755807Ab0BHCSq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Feb 2010 21:18:46 -0500
Received: from mail-px0-f189.google.com ([209.85.216.189]:58507 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755613Ab0BHCSp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Feb 2010 21:18:45 -0500
Received: by pxi27 with SMTP id 27so3308781pxi.4
        for <git@vger.kernel.org>; Sun, 07 Feb 2010 18:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Xz+vVwyueGobqfE+MNQsERfACdSrZUtdTGTyVcH8y9o=;
        b=ws4azfNdqNnddrva8B7SP/QBh5B8KAC0rES1zWpO07BycdwTzjGihGt7lnUJ1Dmal+
         Nos8utl1RCElVhbyU4J8tFsMBoaS+6syka/MbaQmgaZr/3m6oEvznGgi1OcA0foCzFM+
         144ZB7gLu2iLhpm4Plnobw4WRaiEvNJmdlK1o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=O9eNpihkNOMnPUCdBhpnu81O6hJ8+T1XnvvOM725KIqE7kGkGi/FjeBA8NQaXUPhzD
         OsGuadiG+xQhCo/sm40QHSSHa0WrxaupJDLSweA2dvWkhcvyhswkF7vJKuzQJuHAD5rR
         MiIifswuqAYHsiAdU8tyZM6hNpVsYnK24nQBI=
Received: by 10.114.215.17 with SMTP id n17mr3932677wag.197.1265595525121; 
	Sun, 07 Feb 2010 18:18:45 -0800 (PST)
In-Reply-To: <4B6F6971.6000106@jonny.eng.br>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139273>

2010/2/8 Jo=C3=A3o Carlos Mendes Lu=C3=ADs <jonny@jonny.eng.br>:
> =C2=A0Now, I have a patch that appears to work, but since I am a begi=
nner to git,
> I don't know if this is the best way to implement it, if it has any s=
ide
> effects, or even if it works for other operating systems (probably th=
ey
> don't even have the bug). =C2=A0Would any git wizard care to look at =
it, check if
> it is ok, and maybe commit in HEAD or give me any advice against my p=
atch?

Hmm.. I guess you put .git at root directory so you needed your patch.
I haven't tried it yet because I don't have root access here.

Anyway you may also need the below patch. Please report back if any
Git operation that does not work under your setup.

diff --git a/setup.c b/setup.c
index 710e2f3..d31dcb8 100644
--- a/setup.c
+++ b/setup.c
@@ -25,7 +25,7 @@ const char *prefix_path(const char *prefix, int len,
const char *path)
 		len =3D strlen(work_tree);
 		total =3D strlen(sanitized) + 1;
 		if (strncmp(sanitized, work_tree, len) ||
-		    (sanitized[len] !=3D '\0' && sanitized[len] !=3D '/')) {
+		    (len > 1 && sanitized[len] !=3D '\0' && sanitized[len] !=3D '/')=
) {
 		error_out:
 			die("'%s' is outside repository", orig);
 		}

--=20
Duy
