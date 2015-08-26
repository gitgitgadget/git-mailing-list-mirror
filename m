From: Till =?ISO-8859-1?Q?Sch=E4fer?= <till2.schaefer@tu-dortmund.de>
Subject: git clone svn: authors from authors file are ignored, authors-prog works, but crashes on branch points
Date: Wed, 26 Aug 2015 21:57:10 +0200
Organization: TU Dortmund
Message-ID: <5613050.3arVUQYvEz@granit>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 26 22:27:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUhHt-0001On-HP
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 22:27:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842AbbHZU1I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Aug 2015 16:27:08 -0400
Received: from mx1.HRZ.tu-dortmund.de ([129.217.128.51]:54499 "EHLO
	unimail.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbbHZU1G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Aug 2015 16:27:06 -0400
X-Greylist: delayed 1789 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Aug 2015 16:27:06 EDT
Received: from granit.localnet (granit.cs.uni-dortmund.de [129.217.38.151])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.15.2/8.15.2) with ESMTPSA id t7QJvAFs025456
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Wed, 26 Aug 2015 21:57:16 +0200 (CEST)
User-Agent: KMail/4.14.10 (Linux/4.0.5-gentoo; KDE/4.14.11; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276636>

Hi,
i am observing some weired "git svn clone" behavior during my try to mi=
grate the Scaffold Hunter [1] SVN repository [2] to Git:=20

if i just use the command=20

$ git svn clone svn://svn.code.sf.net/p/scaffoldhunter/code --no-metada=
ta -s code

everything went smoothly. Now i wanted to replace the authors SVN-login=
s by useful names and created a mapping file with the following content=
:=20

anjenson =3D Andrew Zhilka <>
bernhard.dick =3D Bernhard Dick <>
dominic.sacre =3D Dominic Sacr=C3=A9 <>
doxmoxbox =3D doxmoxbox <>
falkn =3D Falk Nette <>
henning.garus =3D Henning Garus <>
kakl =3D Karsten Klein <>
klein =3D Karsten Klein <>
lappie00 =3D Jeroen Lappenschaar <>
michael.hesse =3D Michael Hesse <>
nlskrg =3D Nils Kriege <nlskrg@gmail.com>
philipp.kopp =3D Philipp Kopp <>
philipp.lewe =3D Philipp Lewe <>
schrins =3D Sven Schrinner <>
shamshadnpti =3D Shamshad Alam <>
srenner7 =3D Steffen Renner <>
sturm89 =3D Werner Sturm <>
thomas.schmitz =3D Thomas Schmitz <>
thorsten.fluegel =3D Thorsten Fl=C3=BCgel <>
till.schaefer =3D Till Sch=C3=A4fer <till2.schaefer@tu-dortmund.de>
tillschaefer =3D Till Sch=C3=A4fer <till2.schaefer@tu-dortmund.de>


I executed:

$ git svn clone svn://svn.code.sf.net/p/scaffoldhunter/code --authors-f=
ile=3D/home/till/temp/code-authors-transform.txt --no-metadata -s code

and got the error message "Author: klein not defined in /home/till/temp=
/code-authors-transform.txt file".=20
I tried a workaround by using a python script to return the entries i h=
ave already defined in the authors file:=20

$ git svn clone svn://svn.code.sf.net/p/scaffoldhunter/code --authors-f=
ile=3D/home/till/temp/code-authors-transform.txt --authors-prog=3D/home=
/till/temp/authors.py --no-metadata -s code

The import process now went over the "klein" commit. The weired thing i=
s, that a few SVN usernames seem to be recognized in the authors file a=
nd a few are passed to my script (I logged the output). However, at the=
 first revision, where a tag was added in the SVN repo the cloning proc=
ess crashed with the error message:=20

=46ound possible branch point: svn://svn.code.sf.net/p/scaffoldhunter/c=
ode/trunk =3D> svn://svn.code.sf.net/p/scaffoldhunter/code/branches/sub=
search, 17
Use of uninitialized value $u in substitution (s///) at /usr/lib64/perl=
5/vendor_perl/5.20.2/Git/SVN.pm line 101.
Use of uninitialized value $u in concatenation (.) or string at /usr/li=
b64/perl5/vendor_perl/5.20.2/Git/SVN.pm line 101.
refs/remotes/origin/trunk: 'svn://svn.code.sf.net/p/scaffoldhunter/code=
' not found in ''

One problem I am seeing in the SVN repo is, that between the revisions =
97 and 102 the trunk folder was absent. the old one was moved to some s=
ubfolder and a new one was created. Therefore, I started the cloning be=
ginning with rev 102 using the command line option "-r102:HEAD". Howeve=
r, the same error occurred for some later tag (the first tag after rev =
102).=20

=46ound possible branch point: svn://svn.code.sf.net/p/scaffoldhunter/c=
ode/trunk =3D> svn://svn.code.sf.net/p/scaffoldhunter/code/tags/release=
-2.0, 1565
Use of uninitialized value $u in substitution (s///) at /usr/lib64/perl=
5/vendor_perl/5.20.2/Git/SVN.pm line 101.
Use of uninitialized value $u in concatenation (.) or string at /usr/li=
b64/perl5/vendor_perl/5.20.2/Git/SVN.pm line 101.
refs/remotes/origin/trunk: 'svn://svn.code.sf.net/p/scaffoldhunter/code=
' not found in ''

I would be very glad if someone has a hint about what is going wrong he=
re. Is this a bug in git or is something wrong with the SVN repo?


used software versions:=20
- git 2.5.0=20
- subversion 1.8.14


Regards,
Till

[1] http://scaffoldhunter.sourceforge.net/
[2] https://svn.code.sf.net/p/scaffoldhunter/code/trunk

--=20
Dipl.-Inf. Till Sch=C3=A4fer
TU Dortmund University
Chair 11 - Algorithm Engineering
Otto-Hahn-Str. 14 / Room 237
44227 Dortmund, Germany

e-mail: till.schaefer@cs.tu-dortmund.de
phone: +49(231)755-7706
fax: +49(231)755-7740
web: http://ls11-www.cs.uni-dortmund.de/staff/schaefer
pgp: https://keyserver2.pgp.com/vkd/SubmitSearch.event?&&SearchCriteria=
=3D0xD84DED79
