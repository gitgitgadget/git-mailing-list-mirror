From: Steffen Jaeckel <jaeckel@stzedn.de>
Subject: Re[2]: [PATCH] cygwin: Convert paths for html help from posix to windows
Date: Thu, 22 Jan 2009 20:34:19 +0100
Organization: Steinbeis Innovationszentrum Embedded Design und Networking
Message-ID: <1166352985.20090122203419@stzedn.de>
References: <20090122171605.GA16684@atjola.homenet> <7veiyv6ynm.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901221829180.3586@pacific.mpi-cbg.de>
Reply-To: Steffen Jaeckel <jaeckel@stzedn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Bj=C3=B6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	<git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 22 20:36:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ5L8-0006nz-Ei
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 20:35:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756161AbZAVTeX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Jan 2009 14:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755993AbZAVTeW
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 14:34:22 -0500
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:41518 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755956AbZAVTeV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jan 2009 14:34:21 -0500
X-RZG-CLASS-ID: mo00
X-RZG-AUTH: :Jm0Bdkutd9+hmApeFfvVItwLAhvERWWdnqr6RNEtsBX+cJj9Jg197xtEQP6NGcQ=
Received: from T7400SJ (pd956be74.dip0.t-ipconnect.de [217.86.190.116])
	by post.strato.de (klopstock mo51) (RZmta 18.10)
	with ESMTP id a00dddl0MIx5oe ; Thu, 22 Jan 2009 20:34:17 +0100 (MET)
X-Mailer: The Bat! (v3.99.29) Home
X-Priority: 3 (Normal)
In-Reply-To: <alpine.DEB.1.00.0901221829180.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106781>

Hi,

-----Original Message-----
=46rom: Johannes Schindelin [mailto:Johannes.Schindelin@gmx.de]=20

> Hi,

> On Thu, 22 Jan 2009, Junio C Hamano wrote:

>> Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:
>>=20
>> > OK, I don't really know if this is the right way to do it. Maybe w=
hen
>> > the browser was built for cygwin this breaks? I have no clue,...
>>=20
>> It might be simple enough to check if all it takes is to install a
>> prepackaged browser from Cygwin suite and try to run it.  Doesn't Cy=
gwin
>> have small ones such as lynx (or links)?

> Was it not the case that Cygwin programs could grok Windows paths, to=
o? =20
> IIRC w3m is available, dunno about lynx.

> Ciao,
> Dscho

The intention of this patch was to hand over the url to a windows
application.

In cygwin you can use lynx, links and others, but they are not as
smart to use as a browser with a real gui.

Cygwin can't handle windows paths, and this patch will break
cygwin based browsers like links...

My first idea was to patch the git-web--browse.sh script in the section
where the browser is called.
--------
diff --git a/git-web--browse.sh b/git-web--browse.sh
index 78d236b..f726f8f 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -143,7 +143,7 @@ case "$browser" in
        vers=3D$(expr "$($browser_path -version)" : '.* \([0-9][0-9]*\)=
\..*')
        NEWTAB=3D'-new-tab'
        test "$vers" -lt 2 && NEWTAB=3D''
-       "$browser_path" $NEWTAB "$@" &
+       "$browser_path" $NEWTAB "`cygpath -w $@`" &
        ;;
     konqueror)
        case "$(basename "$browser_path")" in
--------
This solution works for cygwin internal browsers where the posix path
is required and it works for windows apps called out of the cygwin
environment as well.
This is certainely not a proper solution but I've got no other idea
how to solve the problem.

Best regards,
steffen
--=20
Steffen Jaeckel
Steinbeis-Transferzentrum/Steinbeis-Innovationszentrum=20
Embedded Design und Networking
an der Berufsakademie L=C3=B6rrach
Poststra=C3=9Fe 35, 79423 Heitersheim
Leiter: Prof. Dr.-Ing. Axel Sikora
Phone: +49 7634 6949341
Mob  : +49  170 2328968
=46ax  : +49 7634 5049886
www.stzedn.de

HINWEIS
Das Steinbeis Transferzentrum Embedded Design und Networking (stzedn)
an der Dualen Hochschule Baden-W=C3=BCrttemberg/Berufsakademie L=C3=B6r=
rach wird
vom 3.-5.3.2009 auf der Embedded World 2009 in N=C3=BCrnberg mit einem =
Stand
vertreten sein. Bitte besuchen Sie uns in Halle 12 Stand 322h.

Zentrale:=20
Steinbeis GmbH & Co. KG f=C3=BCr Technologietransfer=20
Willi-Bleicher-Stra=C3=9Fe 19, 70174 Stuttgart=20
Registergericht Stuttgart HRA 12 480=20

Komplement=C3=A4r: Steinbeis-Verwaltung-GmbH, Registergericht Stuttgart=
 HRB 18715=20
Gesch=C3=A4ftsf=C3=BChrer: Prof. Dr. Heinz Trasch, Prof. Dr. Michael Au=
er=20

Der Inhalt dieser E-Mail einschlie=C3=9Flich aller Anh=C3=A4nge ist ver=
traulich und=20
ausschlie=C3=9Flich f=C3=BCr den bezeichneten Adressaten bestimmt. Wenn=
 Sie nicht der=20
vorgesehene Adressat dieser E-Mail oder dessen Vertreter sein sollten, =
so=20
beachten Sie bitte, dass jede Form der Kenntnisnahme, Ver=C3=B6ffentlic=
hung,=20
Vervielf=C3=A4ltigung oder Weitergabe des Inhalts dieser E-Mail unzul=C3=
=A4ssig ist.=20
Wir bitten Sie, sich in diesem Fall mit dem Absender der E-Mail in Verb=
indung=20
zu setzen, sowie die Originalnachricht zu l=C3=B6schen und alle Kopien =
hiervon zu=20
vernichten.

This e-mail message including any attachments is for the sole use of th=
e=20
intended recipient(s) and may contain privileged or confidential inform=
ation.=20
Any unauthorized review, use, disclosure or distribution is prohibited.=
 If you=20
are not the intended recipient, please immediately contact the sender b=
y reply=20
e-mail and delete the original message and destroy all copies thereof.
