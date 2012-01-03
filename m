From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/2] git-svn, perl/Git.pm: add central method for
 prompting passwords honoring GIT_ASKPASS and SSH_ASKPASS
Date: Tue, 3 Jan 2012 13:06:30 +0100
Message-ID: <CACBZZX4HdrfPZzEL4=YV0_Tt6inYpZjSRy-HnUdGJ6YFOrE0Ag@mail.gmail.com>
References: <4EC52508.9070907@tu-clausthal.de> <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com>
 <4EC65DE4.90005@tu-clausthal.de> <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com>
 <4ED0CE8B.70205@tu-clausthal.de> <20111130064401.GC5317@sigill.intra.peff.net>
 <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain>
 <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de>
 <4EF9ED58.8080205@tu-clausthal.de> <7vd3b967ql.fsf@alter.siamese.dyndns.org>
 <7vty4l4rr8.fsf@alter.siamese.dyndns.org> <4EFA5EB3.4000802@tu-clausthal.de>
 <CACBZZX7P9PEq0wZp0d3dSwDjF6J6Z3cO4VtWc9_frBengtqPLw@mail.gmail.com>
 <4F02D79B.1020002@tu-clausthal.de> <CACBZZX6iMobuU90skpbNPaGQFxYNOAjmZ6ceO4PGqfZSMkgePQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Tue Jan 03 13:07:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ri38u-0002au-Cy
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 13:07:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752806Ab2ACMGy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jan 2012 07:06:54 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58057 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752761Ab2ACMGw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jan 2012 07:06:52 -0500
Received: by eaad14 with SMTP id d14so8589608eaa.19
        for <git@vger.kernel.org>; Tue, 03 Jan 2012 04:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=7F5dGnIgHEHSKo2LtnxLwUpxFJxRXI2kNgYUtEfJQLY=;
        b=oO4NM+fn62+59xxob9CWjDgzLAu/TI5fU9AzyIxwNVorm4yxmFACURvJNuerjyftSz
         nb31OWVeOpkxdlKNUoHCPiAXVTeiQ2SEWv6Z7CIjrUFDOerhzEkb5fcozhXQxoetd0zA
         u2KdalbuH6uAmKtLAQAXneKwIjv6P8OuMJT1c=
Received: by 10.204.148.77 with SMTP id o13mr11402704bkv.97.1325592411402;
 Tue, 03 Jan 2012 04:06:51 -0800 (PST)
Received: by 10.205.112.16 with HTTP; Tue, 3 Jan 2012 04:06:30 -0800 (PST)
In-Reply-To: <CACBZZX6iMobuU90skpbNPaGQFxYNOAjmZ6ceO4PGqfZSMkgePQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187859>

On Tue, Jan 3, 2012 at 13:03, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
> On Tue, Jan 3, 2012 at 11:25, Sven Strickroth
> <sven.strickroth@tu-clausthal.de> wrote:
>> Am 03.01.2012 11:17 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>>> + =C2=A0 =C2=A0 =C2=A0 $ret =3D <$fh>;
>>>> + =C2=A0 =C2=A0 =C2=A0 $ret =3D~ s/[\012\015]//g; # strip \n\r, ch=
omp does not work on all systems (i.e. windows) as expected
>>>
>>> Urm yes it does. \n in Perl is magical and doesn't mean \012 like i=
t
>>> does in some languages. It means "The Platform's Native
>>> Newline".
>>>
>>> Which is \012 on Unix, \015\012 on Windows, and was \015 on Mac OS
>>> until support for it was removed. This is covered in the second
>>> section of "perldoc perlport".
>>>
>>> Can you show me a case where it fails, and under what environment
>>> exactly? Maybe it's e.g.s some Cygwin-specific peculiarity, in whic=
h
>>> case we could check for that platform specifically.
>>
>> I'm using msys perl (shipped with msysgit) and there just using chom=
p()
>> did not work.
>
> That's odd, what does this print:
>
> =C2=A0 =C2=A0perl -MData::Dumper -MFile::Temp=3Dtempfile -we 'my $str=
 =3D
> "moo\015\012"; my ($fh, $name) =3D tempfile(); print $fh $str; close
> $fh; open my $in, "<", $name or die $!; my $in_str =3D <$in>; chomp(m=
y
> $cin_str =3D $in_str); print "in_str:<$in_str> cin_str:<$cin_str>
> END\n"'
>
> And how about this:
>
> =C2=A0 =C2=A0perl -MData::Dumper -MFile::Temp=3Dtempfile -we 'my $str=
 =3D
> "moo\015\012"; my ($fh, $name) =3D tempfile(); print $fh $str; close
> $fh; open my $in, "<:crlf", $name or die $!; my $in_str =3D <$in>;
> chomp(my $cin_str =3D $in_str); print "in_str:<$in_str>
> cin_str:<$cin_str> END\n"'
>
> It could be that there's some bug in either perl or mingw's build of
> perl where it won't turn on the :crlf IO layer by default.

Or actually you could do this before running your patch, except you
have to change the code to use chomp() instead of your regex hack:

  export PERLIO=3Dcrlf

If that makes it work we should just do that somewhere else (e.g. at
the top of Git.pm) if we detect Windows, which'll make chomp() work as
intended everywhere.
