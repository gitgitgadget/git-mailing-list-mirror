From: Walter Bright <boost@digitalmars.com>
Subject: Re: noob user, want checkins to all be forced to LF terminated lines
Date: Fri, 30 Jul 2010 23:32:53 -0700
Organization: Digital Mars
Message-ID: <i30g2s$dpt$1@dough.gmane.org>
References: <i308gl$v6p$1@dough.gmane.org> <20100731044957.GA8920@burratino> <i30bg7$50k$1@dough.gmane.org> <20100731054437.GD14425@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 31 08:33:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of5dJ-0007gK-Jy
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 08:33:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755300Ab0GaGdQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 02:33:16 -0400
Received: from lo.gmane.org ([80.91.229.12]:49350 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755151Ab0GaGdP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 02:33:15 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Of5d9-0007cj-1c
	for git@vger.kernel.org; Sat, 31 Jul 2010 08:33:11 +0200
Received: from c-24-16-56-60.hsd1.wa.comcast.net ([24.16.56.60])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 08:33:11 +0200
Received: from boost by c-24-16-56-60.hsd1.wa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 08:33:11 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-16-56-60.hsd1.wa.comcast.net
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <20100731054437.GD14425@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152316>

Jonathan Nieder wrote:
> Hi again,
>=20
> Some clarifications.
>=20
> Walter Bright wrote:
>=20
>> git is installed under Ubuntu, but I'll be checking in files that I
>> edit on both Windows and Ubuntu, so the line endings will vary
>> depending on which platform I last editted the file on. Hence, I
>> want to force them all to be LF upon checkin.
>=20
> "[core] autocrlf =3D input" would work.  With this setting, the work
> tree is considered sacred (i.e., not touched in any magical way at
> all) but content checked in that looks like text is converted to
> use LF.
>=20
> Using .gitattributes you can override the autodetection (see
> convert.c::is_binary) of text files.
>=20
>>> 	[core]
>>> 		eol =3D lf
>> So this changes the file in the repository to lf only, but not in
>> the worktree? That's what I want.
>=20
> The opposite.  This makes the file in the worktree use lf on
> checkout, if it is known to be a text file.
>=20
> On Linux it is a no-op.  For files known to be text files, the versio=
n
> checked in _always_ uses LF anyway.  The setting "[core] eol =3D lf" =
is
> just a way to turn off "[core] eol =3D crlf".

So I'm lost again. If the version in the repository is always converted=
 to LF,=20
then why do I need to set autocrlf=3Dinput ?


>=20
>> In the tracked tree? The documentation:
>>
>> http://www.kernel.org/pub/software/scm/git/docs/gitattributes.html#_=
checking_out_and_checking_in
>>
>> says it goes in:
>>
>>  $GIT_DIR/info/attributes, .gitattributes
>>
>> so I'm confused again. Does .gitattributes go in $GIT_DIR, or in
>> $GIT_DIR/info ? And what if both of those files are there, which one
>> 'wins' ?
>=20
> Though I said "in the tracked tree", it is generally the file in the
> worktree that counts.  There can be .gitattributes files in any
> subdirectory of the toplevel of the work tree.
>=20
> .git/info/attributes is a place to put local attribute settings that
> should not be tracked.  It has higher precedence than the
> .gitattributes files.  As the gitattributes(5) page says:
>=20
> 	git consults $GIT_DIR/info/attributes file (which has the
> 	highest precedence), .gitattributes file in the same
> 	directory as the path in question, and its parent
> 	directories up to the toplevel of the work tree (the
> 	further the directory that contains .gitattributes is
> 	from the path in question, the lower its precedence).

Ok, got it!

>=20
>>> If everyone for which you want these setting to take effect uses a
>>> recent version of git, you can write =E2=80=9Ctext=E2=80=9D instead=
 of =E2=80=9Ccrlf=E2=80=9D if
>>> you prefer.
>> git --version says I'm using 1.5.6.3
>=20
> Not recent enough. :)

Eh, it's what ubuntu's apt-get gave me.


> Actually versions before 1.7.2 do not have the "[core] eol"
> configuration, either, so there is one less thing to worry about.
>=20
>> A final question: where does the repository actually go (so I can
>> back it up)?
>=20
> The subdirectory .git of the top level of the worktree.
>=20
> You can back up with "git clone" or "git bundle", but copying the
> .git directory also works fine.

Why would "git clone" even exist if copying the directory works? Is it =
the=20
embedded inode problem that Ilari mentioned?
