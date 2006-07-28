From: "Ribeiro, Humberto Plinio" <humberto.ribeiro@siemens.com>
Subject: RE: Git clone stalls at a read(3, ...) saw using strace
Date: Fri, 28 Jul 2006 10:36:12 -0300
Message-ID: <EA24FE8B11562848B4760FD5EB4D2E9401B3F3C2@SAO1016V.ww101.siemens.net>
References: <b8bf37780607280258s421faf65o11c5dd241e7a27c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Linus Torvalds" <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Jul 28 15:36:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6SVu-0003aG-AO
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 15:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161098AbWG1NgX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 28 Jul 2006 09:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161142AbWG1NgW
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 09:36:22 -0400
Received: from pxy-mta.siemens.com.br ([200.186.153.37]:27103 "EHLO
	chekov.siemens.com.br") by vger.kernel.org with ESMTP
	id S1161098AbWG1NgW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jul 2006 09:36:22 -0400
Received: from sao0021x.siemens.com.br (sao0021x [129.214.16.91])
	by chekov.siemens.com.br (Postfix) with ESMTP id EA07D387ACE
	for <git@vger.kernel.org>; Fri, 28 Jul 2006 10:36:17 -0300 (BRT)
Received: from sao0021x.siemens.com.br (localhost [127.0.0.1])
	by localhost.siemens.com.br (Postfix) with ESMTP id A7C1517EDC
	for <git@vger.kernel.org>; Fri, 28 Jul 2006 10:35:45 -0300 (BRT)
Received: from sao1100a.ww101.siemens.net (sao1100a.siemens.com.br [129.214.31.218])
	by sao0021x.siemens.com.br (Postfix) with ESMTP id 9213613E3F
	for <git@vger.kernel.org>; Fri, 28 Jul 2006 10:35:45 -0300 (BRT)
Received: from SAO1016V.ww101.siemens.net ([129.214.31.16]) by sao1100a.ww101.siemens.net with InterScan Messaging Security Suite; Fri, 28 Jul 2006 10:36:17 -0300
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <b8bf37780607280258s421faf65o11c5dd241e7a27c6@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Git clone stalls at a read(3, ...) saw using strace
thread-index: AcayLGCwfixK0/cjSKO992qWFWI1RwAHU9Zg
To: =?iso-8859-1?Q?Andr=E9_Goddard_Rosa?= <andre.goddard@gmail.com>,
	"Pavel Roskin" <proski@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24384>

Hi, Andre.

After a "ps -ef" I saw two instances of the script defined by GIT_PROXY=
_COMMAND. Strangely one of those instances was child of the other. A st=
race showed the scripts were blocked in a "waitpid(-1,". I've killed th=
e child script and the git clone resumed the process.=20

I didn't understand why this blocking on git happened though. The creat=
ion of these two instances (one child of the other) was also strange.=20

Regards,
Humberto=20

---
Obrigado/Best regards/Mit freundlichen Gr=FC=DFen/Pozdrawiam
Humberto Ribeiro, MSc.
SIEMENS Home and Office Communication
Phone: +55 92 2129 6205
Mobile: +55 92 8146 3147

-----Original Message-----
=46rom: Andr=E9 Goddard Rosa [mailto:andre.goddard@gmail.com]=20
Sent: sexta-feira, 28 de julho de 2006 05:58
To: Pavel Roskin
Cc: Git Mailing List; Linus Torvalds; Ribeiro, Humberto Plinio
Subject: Re: Git clone stalls at a read(3, ...) saw using strace

On 7/28/06, Andr=E9 Goddard Rosa <andre.goddard@gmail.com> wrote:
> On 7/27/06, Andr=E9 Goddard Rosa <andre.goddard@gmail.com> wrote:
> > On 7/27/06, Pavel Roskin <proski@gnu.org> wrote:
> > > On Thu, 2006-07-27 at 10:50 -0700, Linus Torvalds wrote:
> > > > Nope. I have a fairly constant 120kbps, and:
> > > >
> > > > [torvalds@g5 ~]$  git clone git://source.mvista.com/git/linux-d=
avinci-2.6.git
> > > > Checking files out...)
> > > >  100% (19754/19754) done
> > >
> > > Same thing here.  Current git from the master branch.
> >
> > Forgot to say that we are using this script in GIT_PROXY_COMMAND
> > environment variable:
> >
> > (echo "CONNECT $1:$2 HTTP/1.0"; echo; cat ) | nc <proxy_add> <portn=
um>
> > | (read a; read a; cat )
> >
> > The first 'read a' removes the 'CONNECT SUCCESS HTTP RESPONSE 200' =
and
> > the second removes an empty line as described here:
> >
> > http://www.gelato.unsw.edu.au/archives/git/0605/20664.html
> >
> > I will try from home later again.
>
> Okey, I tried from home (without the proxy trick) and it behaved a lo=
t
> better but my disc went full in the process and I got these messages:
> ...
> ...
> ...
> error: git-checkout-index: unable to write file drivers/scsi/mac53c94=
=2Ec
> error: git-checkout-index: unable to write file drivers/scsi/mac53c94=
=2Eh
> error: git-checkout-index: unable to write file drivers/scsi/mac_esp.=
c
> error: git-checkout-index: unable to create file
> drivers/scsi/mac_scsi.c (No space left on device)
> error: git-checkout-index: unable to create file
> drivers/scsi/mac_scsi.h (No space left on device)
> error: git-checkout-index: unable to create file
> drivers/scsi/mca_53c9x.c (No space left on device)
> error: git-checkout-index: unable to create file
> drivers/scsi/megaraid.c (No space left on device)
> error: git-checkout-index: unable to create file
> drivers/scsi/megaraid.h (No space left on device)
> fatal: cannot create directory at drivers/scsi/megaraid
>
> And it finished keeping the downloaded files, but I still cannot see
> these files listed above.
> I tried to pull but it says that I'm up-to-date:
>
> doctorture:/opt/downloads/mvista/linux-mvista # git-pull
> Already up-to-date.
>
> I remember that using CVS I just used 'cvs update' after checkout and
> it would bring the missing files to me.
>
> What I'm doing wrong here?

I'm also receiving these messages when trying to change branches:

doctorture:/opt/downloads/mvista/linux-mvista # git-checkout origin
fatal: Untracked working tree file '.gitignore' would be overwritten by=
 merge.

Perhaps I will need to download using git-clone again?

Thanks,
--=20
[]s,
Andr=E9 Goddard
