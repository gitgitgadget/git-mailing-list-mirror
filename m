From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: gc considered dangerous
Date: Sun, 8 Feb 2009 17:04:59 +0100
Message-ID: <200902081704.59439.robin.rosenberg.lists@dewire.com>
References: <200902080347.25970.robin.rosenberg.lists@dewire.com> <alpine.DEB.1.00.0902081551290.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 08 17:06:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWCB0-0006VP-6w
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 17:06:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752402AbZBHQFH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2009 11:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbZBHQFH
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 11:05:07 -0500
Received: from mail.dewire.com ([83.140.172.130]:18943 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751876AbZBHQFG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Feb 2009 11:05:06 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 441558026F9;
	Sun,  8 Feb 2009 17:05:02 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZXOx3qH4a8Tm; Sun,  8 Feb 2009 17:05:01 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 8906B800258;
	Sun,  8 Feb 2009 17:05:01 +0100 (CET)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
In-Reply-To: <alpine.DEB.1.00.0902081551290.10279@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108989>

s=F6ndag 08 februari 2009 15:56:38 skrev Johannes Schindelin:
> Hi,
>=20
> On Sun, 8 Feb 2009, Robin Rosenberg wrote:
>=20
> > I've seen this. Running git gc on Windows, while having Elipse open=
 can=20
> > kill your object database.
>=20
> You had me really scared with the mail subject!

Losing a repo *is* scary., especially if your boss is the one losing it=
=2E
That should simply not happen unless there is a disk failure. Fortunate=
ly
I believe the two lost branches did not contain anything useful.

> > if gc doesn't find a new optimal pack it tries to rewrite a new pac=
k=20
> > with the same id. So it rm's the idx file (fine) and the the pack f=
ile=20
> > (not ok) and gives up,
>=20
> I disagree with your notion that it is fine to kill the existing idx =
file=20
> until the new one has been written successfully.
Then you misunderstood me. I meant that the repack script thought
it was fine.

> My preliminary guess is that this code in pack-write.c needs to use t=
he=20
> lock file paradigm:

>=20
>         if (!index_name) {
> 		[...]
>         } else {
>                 unlink(index_name);
>                 fd =3D open(index_name, O_CREAT|O_EXCL|O_WRONLY, 0600=
);
>         }

Yeah, it needs to check that it can actually delete both files before a=
ctually
doing it. Then again if it wants to replace a file with a new one just =
like it,
why shouldn't it just skip it. Isn't that the only case I see where we =
can lose
data?

GC should also notice that something is not right when there are old-fi=
les
present.

-- robin
