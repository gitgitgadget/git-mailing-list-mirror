From: Hugo Mildenberger <Hugo.Mildenberger@namir.de>
Subject: Re: git fails with control characters in trunk directory name
Date: Tue, 12 May 2009 18:59:58 +0200
Message-ID: <200905121900.00625.Hugo.Mildenberger@namir.de>
References: <200905112208.21017.Hugo.Mildenberger@namir.de> <200905121557.18542.Hugo.Mildenberger@namir.de> <81b0412b0905120759u15f1ec73k73625a7904515792@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 12 19:08:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3vSw-0005sd-Rr
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 19:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752445AbZELRIW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 May 2009 13:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752208AbZELRIW
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 13:08:22 -0400
Received: from mx01.qsc.de ([213.148.129.14]:40844 "EHLO mx01.qsc.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167AbZELRIV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 May 2009 13:08:21 -0400
X-Greylist: delayed 445 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 May 2009 13:08:21 EDT
Received: from localhost (port-87-234-69-58.dynamic.qsc.de [87.234.69.58])
	by mx01.qsc.de (Postfix) with ESMTPA id 7254B3D21B;
	Tue, 12 May 2009 19:00:56 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <81b0412b0905120759u15f1ec73k73625a7904515792@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118931>

> > I looked into guess_dir_name().
>=20
> That's not the right place. The place I meant is right below the call
> to this function (you have to parse the names given in the command-li=
ne
> too).
>=20
> The automatically generated (that's the case with guess_dir_name)
> directory name certainly shouldn't contain any unexpected characters.
>=20
> > A regex call would be easy to fit, but
> > currently the git binary does not depend on libpcre. Is it generall=
y
> > considered to be acceptable to add such a dependency?
>=20
> No. And pcre is not the only regex lib in the world. And we prefer
> shell patterns, if any at all.
>=20
> > While I like the idea to make use of a configurable regular express=
ion, such
> > an expression had to be a command line parameter with a reasonable =
default
> > value, because .git/config still would not exist when the value wou=
ld be
> > needed.
>=20
> That's where _default_ policy plays its role. "Default" like in "it i=
s compiled
> into the git executable and needs no configuration present".
>=20
> > Last not least, I managed to reproduce the problem almost exactly:
> >
> > 1.) hm@localhost git
> > clone "git://git.kernel.org/pub/scm/linux/kernel/git/holtmann/bluet=
ooth-testing.git
> > "
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0(Note the trailing linefeed)
>=20
> That's all the command printed? No "Initialized empty Git repository"=
 line?
>=20
> > 2.) hm@localhost ~/tmp/bluetooth-testing.git $ make
>=20
> Hmm... At this point the clone may have worked (at least partially).
> It named "bluetooth-testing.git", which it shouldn't (but explainable=
:
> the repo url suffix is not .git anymore, but ".git\r\n"). But it look=
s like
> the post-clone checkout failed (silently? which would be bad):
>=20
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0Makefile:313: /home/hm/tmp/bluetooth-tes=
ting.git
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0/scripts/Kbuild.include: No such file or=
 directory
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0make[1]: /home/hm/tmp/bluetooth-testing.=
git: No such file or directory
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0make[1]: *** No rule to make target `/ho=
me/hm/tmp/bluetooth-testing.git'.
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0Stop.
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0make: *** No rule to make target `includ=
e/config/auto.conf', needed by
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0`include/config/kernel.release'. =C2=A0S=
top.
>=20
> Assuming the files must be present, of course.
>=20
> > 3.) hm@localhost ~/tmp/bluetooth-testing.git $ git pull
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0fatal: Error in line 2:
> >
> > 4.) ".git/config" now contains
> >
> > url =3D
> > git://git.kernel.org/pub/scm/linux/kernel/git/holtmann/bluetooth-te=
sting.git\n
> >
> > I particulary liked the git message "fatal: Error in line 2:" ...
> >
>=20
> Separate issue. Will look at it later.
> --

You really want to use shell patterns to match against a string from wi=
thin a binary? Although git=20
already makes use of regexec from glibc or compat/regex directory in nu=
merous places?=20

Regarding the procedure above, sorry for keeping it much too short. Her=
e comes a=20
complete sequence (I will put some comments within square brackets):

hm@localhost /var/tmp $ git --version
git version 1.6.0.6

hm@localhost /var/tmp $ git clone "git://git.kernel.org/pub/scm/linux/k=
ernel/git/holtmann/bluetooth-testing.git
"
Initialized empty Git repository in /mnt/hda1/tmp/bluetooth-testing.git
/.git/
remote: Counting objects: 1177836, done.
remote: Compressing objects: 100% (189467/189467), done.
remote: Total 1177836 (delta 982785), reused 1176855 (delta 981880)
Receiving objects: 100% (1177836/1177836), 288.16 MiB | 1288 KiB/s, don=
e.
Resolving deltas: 100% (982785/982785), done.
Checking out files: 100% (27842/27842), done.

hm@localhost /var/tmp $ ls
bluetooth-testing.git?   [Note that question mark replacing \n in repos=
itory's name]

hm@localhost /var/tmp $ cd blue=09
bluetooth-testing.git^J/ bluez-utils-2.25-r1.new/
[I typed cd blue<TAB> here, and there is the "^J" I remembered to have =
seen elsewhere]=20

hm@localhost /var/tmp $ cd 'bluetooth-testing.git
'/ [bash puts the directory name automatically within single quotes in =
this case]

hm@localhost /var/tmp/bluetooth-testing.git $ make defconfig
*** Default configuration is based on 'i386_defconfig'
#
# configuration written to .config
#

hm@localhost /var/tmp/bluetooth-testing.git $ make
make[1]: /mnt/hda1/tmp/bluetooth-testing.git: No such file or directory
make[1]: *** No rule to make target `/mnt/hda1/tmp/bluetooth-testing.gi=
t'.  Stop.
make: *** No rule to make target `include/config/auto.conf', needed by =
`include/config/kernel.release'.  Stop.
[The problem is simply the odd directory name, while make tries to use =
the real one]

hm@localhost /var/tmp/bluetooth-testing.git $ git pull
fatal: Error in line 2:
