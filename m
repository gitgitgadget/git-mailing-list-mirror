From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 6/8] gitweb: Highlight interesting parts of diff
Date: Sun, 12 Feb 2012 02:42:34 -0800 (PST)
Message-ID: <m3lio8s57v.fsf@localhost.localdomain>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1328865494-24415-7-git-send-email-michal.kiedrowicz@gmail.com>
	<m3y5s9rl3g.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-2?q?Micha=B3_Kiedrowicz?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 12 11:42:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwWtH-0004se-QX
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 11:42:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887Ab2BLKmh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Feb 2012 05:42:37 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:45959 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819Ab2BLKmg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Feb 2012 05:42:36 -0500
Received: by eaah12 with SMTP id h12so1425643eaa.19
        for <git@vger.kernel.org>; Sun, 12 Feb 2012 02:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=hZloP6edRD3035DSJe3ibMlvOoAYcXYOhMEykjtGOSw=;
        b=JCvfnkU7yX6fhJe1V1Z1gdT08N6L3m7iXrlK0mUrLusy5dpTPsM0DIFJuulcjeBSc9
         x8Lj3v3F+E/txHAzOytP0kT5vVHcc+uMuB7caIrwE4jZbxaw9JAD2hJVRHdj3MWWoMvG
         OJA2sj+B/JgeUyVsv8CcYUQwBgV0czMS2XNkY=
Received: by 10.14.95.4 with SMTP id o4mr3956370eef.95.1329043354667;
        Sun, 12 Feb 2012 02:42:34 -0800 (PST)
Received: from localhost.localdomain (abwh127.neoplus.adsl.tpnet.pl. [83.8.231.127])
        by mx.google.com with ESMTPS id z47sm46998303eeh.9.2012.02.12.02.42.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 12 Feb 2012 02:42:34 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q1CAgUa9028187;
	Sun, 12 Feb 2012 11:42:30 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q1CAgTb7028184;
	Sun, 12 Feb 2012 11:42:29 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <m3y5s9rl3g.fsf@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190566>

Jakub Narebski <jnareb@gmail.com> writes:
> Micha=B3 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:
=20
> > +# Highlight characters from $prefix to $suffix and escape HTML.
> > +# $str is a reference to the array of characters.
> > +sub esc_html_mark_range {
> > +	my ($str, $prefix, $suffix) =3D @_;
> > +
> > +	# Don't generate empty <span> element.
> > +	if ($prefix =3D=3D $suffix + 1) {
> > +		return esc_html(join('', @$str), -nbsp=3D>1);
> > +	}
> > +
> > +	my $before =3D join('', @{$str}[0..($prefix - 1)]);
> > +	my $marked =3D join('', @{$str}[$prefix..$suffix]);
> > +	my $after =3D join('', @{$str}[($suffix + 1)..$#{$str}]);
>=20
> Eeeeeek!  First you split into letters, in caller at that, then join?
> Why not pass striung ($str suggests string not array of characters),
> and use substr instead?
>=20
> [Please disregard this and the next paragraph at first reading]
>=20
> > +
> > +	return esc_html($before, -nbsp=3D>1) .
> > +		$cgi->span({-class=3D>'marked'}, esc_html($marked, -nbsp=3D>1)) =
=2E
> > +		esc_html($after,-nbsp=3D>1);
> > +}
>=20
> Anyway I have send to git mailing list a patch series, which in one o=
f
> patches adds esc_html_match_hl($str, $regexp) to highlight matches in
> a string.  Your esc_html_mark_range(), after a generalization, could
> be used as underlying "engine".
>=20
> Something like this, perhaps (untested):
>=20
>    # Highlight selected fragments of string, using given CSS class,
>    # and escape HTML.  It is assumed that fragments do not overlap.
>    # Regions are passed as list of pairs (array references).
>    sub esc_html_hl {
>         my ($str, $css_class, @sel) =3D @_;
>         return esc_html($str) unless @sel;
>   =20
>         my $out =3D '';
>         my $pos =3D 0;
>   =20
>         for my $s (@sel) {
>                 $out .=3D esc_html(substr($str, $pos, $s->[0] - $pos)=
)
>                         if ($s->[0] - $pos > 0);
>                 $out .=3D $cgi->span({-class =3D> $css_class},
>                                    esc_html(substr($str, $s->[0], $s-=
>[1] - $s->[0])));
>=20
>                 $pos =3D $m->[1];
>         }
>         $out .=3D esc_html(substr($str, $pos))
>                 if ($pos < length($str));
>   =20
>         return $out;
>    }

Actually we can accomodate both operating on string and operating on
array of characters in a single subroutine.  Though it can be left for
later commit, anyway...

     # Highlight selected fragments of string, using given CSS class,
     # and escape HTML.  It is assumed that fragments do not overlap.
     # Regions are passed as list of pairs (array references).
     sub esc_html_hl {
          my ($sth, $css_class, @sel) =3D @_;

          if (!@sel) {
                if (ref($sth) eq "ARRAY") {
                        return esc_html(join('', @$sth), -nbsp=3D>1);
                } else {
                        return esc_html($sth, -nbsp=3D>1);
          }

          if (ref($sth) eq "ARRAY") {
                return esc_html_hl_gen($sth,
                        sub {=20
                                my ($arr, $from, $to) =3D @_;
                                return join('', @{$arr}[$from..$to]);
                        },
                        scalar @{$arr}, $css_class, @sel);
           } else {
                return esc_html_hl_gen($sth,
                        sub {
                                my ($str, $from, $to) =3D @_;
                                if ($to < 0) { $to +=3D lenght($str); }=
;
                                return substr($str, $from, $to - $from)=
;
                        },
                        length($sth), $css_class, @sel);
           }
     }

     # Highlight selected fragments of string or array of characters
     # with given length, using provided $extr subroutine to extract
     # fragment (substring)
     sub esc_html_hl_gen {
          my ($sth, $extr, $len, $css_class, @sel) =3D @_;
    =20
          my $out =3D '';
          my $pos =3D 0;
    =20
          for my $s (@sel) {
                $out .=3D esc_html($extr->($str, $pos, $s->[0]))
                        if ($s->[0] - $pos > 0);
                $out .=3D $cgi->span({-class =3D> $css_class},
                                   esc_html($extr->($str, $s->[0], $s->=
[1])));
 =20
                $pos =3D $s->[1];
          }
          $out .=3D esc_html($extr->($str, $pos, $len))
                  if ($pos < $len);
    =20
          return $out;
     }

Or maybe I have read "Higher-Order Perl" one time too many ;-))))

--=20
Jakub Nar=EAbski
