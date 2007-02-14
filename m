From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: git-gui Error
Date: Wed, 14 Feb 2007 19:09:06 +0100
Message-ID: <20070214180906.GB21612@auto.tuwien.ac.at>
References: <20070213065616.GA4195@auto.tuwien.ac.at> <20070213074519.GA32687@spearce.org> <20070213215303.GA26716@auto.tuwien.ac.at> <20070214022200.GB30884@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 14 19:09:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHOZ9-0004bI-Ls
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 19:09:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbXBNSJM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 14 Feb 2007 13:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbXBNSJM
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 13:09:12 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:58778 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932415AbXBNSJL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 13:09:11 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 545356869BC7;
	Wed, 14 Feb 2007 19:09:07 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dS-Gwq9Ab5zT; Wed, 14 Feb 2007 19:09:06 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id D3C116869BC3; Wed, 14 Feb 2007 19:09:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20070214022200.GB30884@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39713>

On Tue, Feb 13, 2007 at 09:22:00PM -0500, Shawn O. Pearce wrote:
> Martin Koegler <mkoegler@auto.tuwien.ac.at> wrote:
> > My fault, I had only a too old GIT core (1.4.1) in my path.
> > With the current version, the problem disapears.
>=20
> Yea, I figured (much later) it was something like that.  I still
> think there is a bug in git-gui, namely not telling you that it
> requires Git 1.5.x or later if it finds out the 'git' its invoking
> is older than that.  I'll probably patch it tonight, but it won't
> ship that way in 1.5.0.
> =20
> > Some notes about using git-gui:=20
> >=20
> > * Fetching over ssh results in an empty dialog. The password prompt=
 is
> > only shown in the terminal window, which is likly to be hidden by t=
he
> > the main window of git-gui.
>=20
> This is a "feature".  I only use git-gui + ssh with an ssh-agent
> and public key authentication, so I never get password prompts.
> Unfortunately Tcl does not permit me to setup bi-directional pipes
> to a process (heck, I can't get both stdout and stderr except by
> going through cat!), and even if it does, I think ssh would demand
> the tty to get the password, thereby bypassing my pipe anyway.
>=20
> Basically I don't know how to improve this.  If someone has a bright
> idea, please pass it along!

Well, there are two way:

1) SSH_ASKPASS (see ssh(1))
    If ssh needs a passphrase, it will read the passphrase from the
    current terminal if it was run from a terminal.  If ssh does not
    have a terminal associated with it but DISPLAY and SSH_ASKPASS
    are set, it will execute the program specified by SSH_ASKPASS
    and open an X11 window to read the passphrase.  This is particu-
    larly useful when calling ssh from a .Xsession or related
    script.  (Note that on some machines it may be necessary to
    redirect the input from /dev/null to make this work.)

This require, that a password helper is installed. One implementation
is part of every linux distribution (openssh-askpass-gnome).

2) Simulate user (like http://websvn.kde.org/tags/KDE/3.4.3/kdebase/kio=
slave/fish/fish.cpp?rev=3D467549&view=3Dauto)

This requires opening a pty and running ssh on the slave of
it. Additionally it requires some logic to determine, what type of
input ssh requires.

I tried to implement the second way in a C program once. The interpreti=
on
of the ssh output is difficult, but I got it working, but after a syste=
m upgrade,
the logic was not working any more. So I would avoid this.

mfg Martin K=F6gler
