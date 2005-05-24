From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 23:41:06 +0200
Message-ID: <20050524214106.GE25606@cip.informatik.uni-erlangen.de>
References: <20050524161745.GA9537@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505240929051.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505240943080.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505241017510.2307@ppc970.osdl.org> <20050524184612.GA23637@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505241236020.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505241259250.2307@ppc970.osdl.org> <20050524202846.GC25606@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505241410380.2307@ppc970.osdl.org> <42939942.9080807@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
Cc: Linus Torvalds <torvalds@osdl.org>,
	David Mansfield <david@cobite.com>,
	Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 23:41:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dah8G-0002Sp-BB
	for gcvg-git@gmane.org; Tue, 24 May 2005 23:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262199AbVEXVlo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 17:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbVEXVlo
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 17:41:44 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:57260 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262199AbVEXVlN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 17:41:13 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4OLf7S8005894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 24 May 2005 21:41:07 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4OLf6Ix005893;
	Tue, 24 May 2005 23:41:06 +0200 (CEST)
To: "H. Peter Anvin" <hpa@zytor.com>
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@osdl.org>,
	David Mansfield <david@cobite.com>,
	Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <42939942.9080807@zytor.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

> I was considering using CVS for that at one point, but the way CVS 
> distributes its metadata and recurses makes that insane.  For git, it 
> would be trivial.

I have a shared environment, and handle it this way:

	- I edit all files on my machine on university or at least put
	  it there per scp when I am done modifing them local.

	- I have file called .env in my home which contains a list with
	  all files I want to 'distribute'.

	- There is a script called envup, which updates all files which
	  are not up2date. It uses perl because perl is everywhere I
	  have an account on. After that I call a perl preprocessor to
	  generate ssh config files (there are floating so much ssh
	  versions out there) and one to adopt my .screenrc (for the
	  machine local screen) to my needs.

my .bash_profile does a lot of testing to add paths and sets aliases
based on the environment of the machine and not based on host/domain
names. Files with lot of deltas like my .fvwm2rc or .bash_profile are
all version controled using rcs on a per file basis of course. This
works very well for me on Linux, Solaris, OpenBSD, FreeBSD, NetBSD, OSF,
AIX, MacOSX, name it ...

Oh and to bootstrap my environment on a 'new' machine:

tar cfz env.tgz `cat .env`, move it over, unpack and re login.

A while ago I also distributed binaries (bash, rar, fvwm) via envup for
my environment, but I adopted now to something that works everywhere,
and if it doesn't I do that manual. So envup only transfers stuff which
is new. (I have some accounts on low bandwidth sites). One known side
effect. If envup doesn't find md5sum binary it just transfers all files.

Oh and a friend and colleague has a similliar script only that he pushes
his environment out.

	Thomas

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=envup
Content-Transfer-Encoding: quoted-printable

#!/usr/bin/perl -w

use strict;
use integer;

my $command  =3D '';

my %local    =3D ();
my %remote   =3D ();

my @sums     =3D ();
my @transfer =3D ();

if ( -f '/home/cip/adm/sithglan/bin/envup.server'
  || -f "$ENV{HOME}/bin/envup.server" ) {
	die "NEVER EVER RUN THIS IN THE CIP POOL: YOU SUCK :-)";
	exit; # way to secure=17redundant
}


# [remote] ------------------------------------------
@sums =3D `ssh 131.188.30.105 bin/envup.server`;

foreach $_ (@sums) {
	chomp;
	if (/(^[a-f0-9]{32})[ ]{2}([^\s]+)$/) {
		$remote{$2} =3D $1;
		# print "$1 -> $2\n";
	} else {
		print "remote: can't match: <$_>\n";
	}
}

# [local] ------------------------------------------

$command =3D 'md5sum ' . join(' ', keys(%remote));

@sums =3D qx($command 2> /dev/null);

foreach $_ (@sums) {
	chomp;
	if (/(^[a-f0-9]{32})[ ]{2}([^\s]+)$/) {
		$local{$2} =3D $1;
		#print "$1 -> $2\n";

	} else {
		print "local can't match: <$_>\n";
	}
}

foreach my $file (keys(%remote)) {
	if (exists($local{$file})) {
		if ($remote{$file} ne $local{$file}) {
			push(@transfer, $file);
		}

	} else {
		push(@transfer, $file);
	}
}

if (@transfer) {
        $command =3D "ssh 131.188.30.105 -- tar cf - " . join(' ', @transfe=
r) . " | tar xf -";
        system($command);
}


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="envup.server"

#!/bin/bash

md5sum $(find `cat $HOME/.env` -type f)

--XsQoSWH+UP9D9v3l--
