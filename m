From: Steffen Jaeckel <jaeckel@stzedn.de>
Subject: Re: [PATCH] cygwin: Convert paths for html help from posix to windows
Date: Mon, 26 Jan 2009 11:05:11 +0100
Organization: Steinbeis Innovationszentrum Embedded Design und Networking
Message-ID: <1232544917.20090126110511@stzedn.de>
References: <20090122171605.GA16684@atjola.homenet> <497B632B.1060801@ramsay1.demon.co.uk>
Reply-To: Steffen Jaeckel <jaeckel@stzedn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Jan 26 11:06:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LROMd-00053E-OB
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 11:06:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbZAZKFS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Jan 2009 05:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbZAZKFQ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 05:05:16 -0500
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:41046 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbZAZKFP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jan 2009 05:05:15 -0500
X-RZG-CLASS-ID: mo00
X-RZG-AUTH: :Jm0Bdkutd9+hmApeFfvVItwLAhvERWWdnqr6RNEtsBX+cJj9Jg197xtEQP6NGcQ=
Received: from T7400SJ (pd956be74.dip0.t-ipconnect.de [217.86.190.116])
	by post.strato.de (fruni mo40) (RZmta 18.10)
	with ESMTP id L041b5l0Q9Hort ; Mon, 26 Jan 2009 11:05:10 +0100 (MET)
X-Mailer: The Bat! (v3.99.29) Home
X-Priority: 3 (Normal)
In-Reply-To: <497B632B.1060801@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107182>

-----Original Message-----
=46rom: Ramsay Jones [mailto:ramsay@ramsay1.demon.co.uk]

> Hi Bj=F6rn,

> I had the same problem. However, rather than modifying git, I created=
 a
> firefox wrapper script (in ~/bin) which used the cygpath command line
> tool to do the path conversion. Also, if you use "git instaweb", you
> also need to filter out http URLs and pass them through un-molested
> by cygpath (it turns http://localhost into http:\localhost).

> My script is clearly a "quick hack" just to get something working for
> me, but you may find it useful as a starting point for your own
> ("proper" ;-) script, so I've included it below.

> HTH,
> Ramsay Jones

Hi Ramsay,

thanks for this idea. I solved the problem by using the bash script
included below.

Cheerz,
Steffen


>sj
#!/bin/sh
#

ff=3D"/cygdrive/c/Programme/Mozilla Firefox/firefox.exe"

while test $# !=3D 0
do
    case "$1" in
        -version)
            echo $("$ff" "-version")
            exit 0
            ;;
        -new-tab)
            p=3D
            case "$2" in
                http*)
                    p=3D"$2"
                    ;;
                *)
                    # check if file exists
                    if [ -e "$2" ]
                    then
                      p=3D"$(cygpath -w "$2")"
                    fi
                    ;;
            esac
            # check if $p has been set, otherwise exit with error
            if [ "$p" ]
            then
              $("$ff" "$p")
              exit 0
            else
              exit 1
            fi
            ;;
    esac
    shift
done

exit 1

--=20
Steffen Jaeckel
Steinbeis-Transferzentrum/Steinbeis-Innovationszentrum=20
Embedded Design und Networking
an der Berufsakademie L=F6rrach
Poststra=DFe 35, 79423 Heitersheim
Leiter: Prof. Dr.-Ing. Axel Sikora
Phone: +49 7634 6949341
Mob  : +49  170 2328968
=46ax  : +49 7634 5049886
www.stzedn.de

HINWEIS
Das Steinbeis Transferzentrum Embedded Design und Networking (stzedn)
an der Dualen Hochschule Baden-W=FCrttemberg/Berufsakademie L=F6rrach w=
ird
vom 3.-5.3.2009 auf der Embedded World 2009 in N=FCrnberg mit einem Sta=
nd
vertreten sein. Bitte besuchen Sie uns in Halle 12 Stand 322h.

Zentrale:=20
Steinbeis GmbH & Co. KG f=FCr Technologietransfer=20
Willi-Bleicher-Stra=DFe 19, 70174 Stuttgart=20
Registergericht Stuttgart HRA 12 480=20

Komplement=E4r: Steinbeis-Verwaltung-GmbH, Registergericht Stuttgart HR=
B 18715=20
Gesch=E4ftsf=FChrer: Prof. Dr. Heinz Trasch, Prof. Dr. Michael Auer=20

Der Inhalt dieser E-Mail einschlie=DFlich aller Anh=E4nge ist vertrauli=
ch und=20
ausschlie=DFlich f=FCr den bezeichneten Adressaten bestimmt. Wenn Sie n=
icht der=20
vorgesehene Adressat dieser E-Mail oder dessen Vertreter sein sollten, =
so=20
beachten Sie bitte, dass jede Form der Kenntnisnahme, Ver=F6ffentlichun=
g,=20
Vervielf=E4ltigung oder Weitergabe des Inhalts dieser E-Mail unzul=E4ss=
ig ist.=20
Wir bitten Sie, sich in diesem Fall mit dem Absender der E-Mail in Verb=
indung=20
zu setzen, sowie die Originalnachricht zu l=F6schen und alle Kopien hie=
rvon zu=20
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
