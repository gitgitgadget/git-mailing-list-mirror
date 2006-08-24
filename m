From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Running gitweb under mod_perl
Date: Thu, 24 Aug 2006 22:59:18 +0200
Organization: At home
Message-ID: <ecl3v4$s14$1@sea.gmane.org>
References: <eck6sq$agn$1@sea.gmane.org> <eckor9$jje$1@sea.gmane.org> <20060824193220.G4a28fdc4@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Aug 24 23:00:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGMIy-00008o-4y
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 23:00:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422658AbWHXU75 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 24 Aug 2006 16:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422659AbWHXU75
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 16:59:57 -0400
Received: from main.gmane.org ([80.91.229.2]:12732 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1422658AbWHXU74 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Aug 2006 16:59:56 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GGMIl-0008W7-7s
	for git@vger.kernel.org; Thu, 24 Aug 2006 22:59:47 +0200
Received: from host-81-190-21-215.torun.mm.pl ([81.190.21.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Aug 2006 22:59:47 +0200
Received: from jnareb by host-81-190-21-215.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Aug 2006 22:59:47 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-215.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25978>

Dennis Stosberg wrote:

> Jakub Narebski wrote:
>=20
>> By the way, does the "static" variables works under mod_perl? i.e.
>>=20
>> {
>>   my $private_var =3D "something"
>>=20
>>   sub some_sub {
>>     ...
>>   }
>>=20
>>   sub other_sub {
>>     ...
>>   }
>> }
>=20
> Depends on what you expect.  The variable will remain shared between
> those subs over successive executions, but it will not be reinitialis=
ed
> to "something" -- at least not visibly to the subs:

Well, I wanted to share read-only variable, initialized once and not
changed at all. It could be global variable, but it is used only by
those two functions.

> On the first invocation, $private_var is initialised and the two
> subroutines are created.  Internally, they refer to the _instance_ of
> $private_var.  The next time the script is run by mod_perl, $private_=
var
> gets initialised again, but the subs are persistent and still refer t=
o
> the old instance.  _Their_ copy of the variable will still be shared
> between them, but it will not be reset to "something".

I don't need to reinitialize $private_var -- it is not changed.=20

> Apache::Registry wraps the whole script in another function, which
> is called on each request, so your piece of code really looks somewha=
t
> like this:
>=20
> #!/usr/bin/perl
> sub handler {
> =A0 =A0 # do something
> =A0 =A0 {
> =A0 =A0 =A0 =A0 my $a =3D 'A';
> =A0=A0=A0=A0=A0=A0=A0=A0sub sub_a { $a .=3D 'B' }
> =A0=A0=A0=A0=A0=A0=A0=A0sub sub_b { print $a."\n" }
> =A0 =A0 }
> =A0 =A0 sub_a();
> =A0 =A0 sub_b();
> }
> for(1..10) { handler() }

Thanks for an explanation.

Is there any way to check at _runtime_ if script is run under mod_perl,
or would it be simplier (after script reorganization) for install time
selection of using CGI, FastCGI, or Apache2::something...?
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
