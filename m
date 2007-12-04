From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: Fix UTF Encoding issue
Date: Tue, 4 Dec 2007 09:16:34 +0100
Message-ID: <20071204081634.GD31042@auto.tuwien.ac.at>
References: <4753D419.80503@clearchain.com> <200712031802.55514.jnareb@gmail.com> <20071204075028.GB31042@auto.tuwien.ac.at> <200712040955.04655.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Alexandre Julliard <julliard@winehq.org>,
	Benjamin Close <Benjamin.Close@clearchain.com>,
	git@vger.kernel.org,
	Perl Unicode Mailing List <perl-unicode@perl.org>,
	Dan Kogai <dankogai@dan.co.jp>
To: Ismail =?iso-8859-1?Q?D=F6nmez?= <ismail@pardus.org.tr>
X-From: git-owner@vger.kernel.org Tue Dec 04 09:17:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzSxh-0006S9-Ej
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 09:17:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbXLDIQl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Dec 2007 03:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbXLDIQk
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 03:16:40 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:56161 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896AbXLDIQk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 03:16:40 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 5194E8BE0E76;
	Tue,  4 Dec 2007 09:16:35 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XALIh5bY5cy6; Tue,  4 Dec 2007 09:16:34 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id E76968C06799; Tue,  4 Dec 2007 09:16:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200712040955.04655.ismail@pardus.org.tr>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67017>

On Tue, Dec 04, 2007 at 09:55:04AM +0200, Ismail D=C3=B6nmez wrote:
> Tuesday 04 December 2007 Tarihinde 09:50:28 yazm????t??:
> > The bug affects old versions of perl (Debian sarge =3D oldstable).
> > As it works on the newer Debian etch, do you really think, that it =
is
> > a good idea to report issue?
>=20
> Same problem here with v5.8.8 which is latest stable perl5 release.

I have put together a small perl script, which tests the various ways
of decoding, which have been posted on the list. The first test is
wrong by design. A working decoding method should result in
"#=C3=B6=C3=A4=C3=BC#=C3=A4=C3=B6=C3=BC".

Debian sarge:
#=C3=B6=C3=A4=C3=BC#=C3=83=E2=82=AC=C3=83=C2=B6=C3=83=C5=92
##=C3=A4=C3=B6=C3=BC
##=C3=A4=C3=B6=C3=BC
##=C3=A4=C3=B6=C3=BC

Debian etch, OpenSuSE 10.2, Fedora 7:
#=C3=B6=C3=A4=C3=BC#=C3=83=E2=82=AC=C3=83=C2=B6=C3=83=C5=92
#=C3=B6=C3=A4=C3=BC#=C3=A4=C3=B6=C3=BC
#=C3=B6=C3=A4=C3=BC#=C3=A4=C3=B6=C3=BC
#=C3=B6=C3=A4=C3=BC#=C3=A4=C3=B6=C3=BC

mfg Martin K=C3=B6gler

#!/usr/bin/perl
use Encode;

sub t {
my $str =3D shift;
my ($res);
eval { return ($res =3D decode_utf8($str, Encode::FB_CROAK)); };
return decode("latin1", $str, Encode::FB_DEFAULT);
}
sub t1 {
my $str =3D shift;
my ($res);
eval { ($res =3D decode_utf8($str, Encode::FB_CROAK)); };
if ($@) {
return decode("latin1", $str, Encode::FB_DEFAULT); }
else
{ return $res; }
}

sub t2 {
my $str =3D shift;
my ($res);

eval { $res =3D decode_utf8($str, Encode::FB_CROAK); };
 if (defined $res) {
        return $res;
} else {
        return decode("latin1", $str, Encode::FB_DEFAULT);
}
}

sub t3 {
	my $str =3D shift;
	my $res;
	eval { $res =3D decode_utf8 ($str, 1); };
	return $res || decode('latin1', $str);
}

print t("#=C3=B6=C3=A4=C3=BC");
print t("#=C3=83=E2=82=AC=C3=83=C2=B6=C3=83=C5=92");
print "\n";
print t1("#=C3=B6=C3=A4=C3=BC");
print t1("#=C3=83=E2=82=AC=C3=83=C2=B6=C3=83=C5=92");
print "\n";
print t2("#=C3=B6=C3=A4=C3=BC");
print t2("#=C3=83=E2=82=AC=C3=83=C2=B6=C3=83=C5=92");
print "\n";
print t3("#=C3=B6=C3=A4=C3=BC");
print t3("#=C3=83=E2=82=AC=C3=83=C2=B6=C3=83=C5=92");
print "\n";
