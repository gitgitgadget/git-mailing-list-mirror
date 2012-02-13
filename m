From: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH 6/8] gitweb: Highlight interesting parts of diff
Date: Mon, 13 Feb 2012 07:54:51 +0100
Message-ID: <20120213075451.1bc20885@mkiedrowicz.ivo.pl>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1328865494-24415-7-git-send-email-michal.kiedrowicz@gmail.com>
	<m3y5s9rl3g.fsf@localhost.localdomain>
	<m3lio8s57v.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 07:55:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwpoS-0000BN-1o
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 07:55:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754606Ab2BMGyz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Feb 2012 01:54:55 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:44127 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637Ab2BMGyz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2012 01:54:55 -0500
Received: by eekc14 with SMTP id c14so1745951eek.19
        for <git@vger.kernel.org>; Sun, 12 Feb 2012 22:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=7/pFALshxcuUxHcUZ+1aMdk6iW17NFmeq2oGfnW4GKI=;
        b=hqZdGHjS0qoVcUbueBzgloL6ebsHa4Ib6su6kvfXYXLMFNvd/ihUki6LFFboCBrQZc
         Ta5MA3rm9BVkNzc01VhPueH41Sa1ZlnkWzV4aDoWxHEerPDt9DB5feut/m7nuVBD67ww
         OR8KAqIdBeK9Lc4NxrNUCj/Pncc1ZwVKJUDAs=
Received: by 10.14.40.76 with SMTP id e52mr4925845eeb.8.1329116093853;
        Sun, 12 Feb 2012 22:54:53 -0800 (PST)
Received: from mkiedrowicz.ivo.pl (pc10.ivo.park.gdynia.pl. [153.19.128.10])
        by mx.google.com with ESMTPS id y12sm57785815eeb.11.2012.02.12.22.54.53
        (version=SSLv3 cipher=OTHER);
        Sun, 12 Feb 2012 22:54:53 -0800 (PST)
In-Reply-To: <m3lio8s57v.fsf@localhost.localdomain>
X-Mailer: Claws Mail 3.7.10 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190614>

Jakub Narebski <jnareb@gmail.com> wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> > Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:
> =20
> > > +# Highlight characters from $prefix to $suffix and escape HTML.
> > > +# $str is a reference to the array of characters.
> > > +sub esc_html_mark_range {
> > > +	my ($str, $prefix, $suffix) =3D @_;
> > > +
> > > +	# Don't generate empty <span> element.
> > > +	if ($prefix =3D=3D $suffix + 1) {
> > > +		return esc_html(join('', @$str), -nbsp=3D>1);
> > > +	}
> > > +
> > > +	my $before =3D join('', @{$str}[0..($prefix - 1)]);
> > > +	my $marked =3D join('', @{$str}[$prefix..$suffix]);
> > > +	my $after =3D join('', @{$str}[($suffix + 1)..$#{$str}]);
> >=20
> > Eeeeeek!  First you split into letters, in caller at that, then
> > join? Why not pass striung ($str suggests string not array of
> > characters), and use substr instead?
> >=20
> > [Please disregard this and the next paragraph at first reading]
> >=20
> > > +
> > > +	return esc_html($before, -nbsp=3D>1) .
> > > +		$cgi->span({-class=3D>'marked'}, esc_html($marked,
> > > -nbsp=3D>1)) .
> > > +		esc_html($after,-nbsp=3D>1);
> > > +}
> >=20
> > Anyway I have send to git mailing list a patch series, which in one
> > of patches adds esc_html_match_hl($str, $regexp) to highlight
> > matches in a string. =20

Yeah, I saw that but after seeing that they accept different arguments
I decided to leave them alone.

> Your esc_html_mark_range(), after a
> > generalization, could be used as underlying "engine".
> >=20
> > Something like this, perhaps (untested):

I think I'll leave it to you after merging both these series to
master :)

> >=20
> >    # Highlight selected fragments of string, using given CSS class,
> >    # and escape HTML.  It is assumed that fragments do not overlap.
> >    # Regions are passed as list of pairs (array references).
> >    sub esc_html_hl {
> >         my ($str, $css_class, @sel) =3D @_;
> >         return esc_html($str) unless @sel;
> >   =20
> >         my $out =3D '';
> >         my $pos =3D 0;
> >   =20
> >         for my $s (@sel) {
> >                 $out .=3D esc_html(substr($str, $pos, $s->[0] - $po=
s))
> >                         if ($s->[0] - $pos > 0);
> >                 $out .=3D $cgi->span({-class =3D> $css_class},
> >                                    esc_html(substr($str, $s->[0],
> > $s->[1] - $s->[0])));
> >=20
> >                 $pos =3D $m->[1];
> >         }
> >         $out .=3D esc_html(substr($str, $pos))
> >                 if ($pos < length($str));
> >   =20
> >         return $out;
> >    }
>=20
> Actually we can accomodate both operating on string and operating on
> array of characters in a single subroutine.  Though it can be left fo=
r
> later commit, anyway...

>=20
>      # Highlight selected fragments of string, using given CSS class,
>      # and escape HTML.  It is assumed that fragments do not overlap.
>      # Regions are passed as list of pairs (array references).
>      sub esc_html_hl {
>           my ($sth, $css_class, @sel) =3D @_;
>=20
>           if (!@sel) {
>                 if (ref($sth) eq "ARRAY") {
>                         return esc_html(join('', @$sth), -nbsp=3D>1);
>                 } else {
>                         return esc_html($sth, -nbsp=3D>1);
>           }
>=20
>           if (ref($sth) eq "ARRAY") {
>                 return esc_html_hl_gen($sth,
>                         sub {=20
>                                 my ($arr, $from, $to) =3D @_;
>                                 return join('', @{$arr}[$from..$to]);
>                         },
>                         scalar @{$arr}, $css_class, @sel);
>            } else {
>                 return esc_html_hl_gen($sth,
>                         sub {
>                                 my ($str, $from, $to) =3D @_;
>                                 if ($to < 0) { $to +=3D lenght($str);=
 };
>                                 return substr($str, $from, $to -
> $from); },
>                         length($sth), $css_class, @sel);
>            }
>      }
>=20
>      # Highlight selected fragments of string or array of characters
>      # with given length, using provided $extr subroutine to extract
>      # fragment (substring)
>      sub esc_html_hl_gen {
>           my ($sth, $extr, $len, $css_class, @sel) =3D @_;
>     =20
>           my $out =3D '';
>           my $pos =3D 0;
>     =20
>           for my $s (@sel) {
>                 $out .=3D esc_html($extr->($str, $pos, $s->[0]))
>                         if ($s->[0] - $pos > 0);
>                 $out .=3D $cgi->span({-class =3D> $css_class},
>                                    esc_html($extr->($str, $s->[0],
> $s->[1])));=20
>                 $pos =3D $s->[1];
>           }
>           $out .=3D esc_html($extr->($str, $pos, $len))
>                   if ($pos < $len);
>     =20
>           return $out;
>      }
>=20
> Or maybe I have read "Higher-Order Perl" one time too many ;-))))
>=20
