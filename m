From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb: using quotemeta
Date: Fri, 6 Oct 2006 14:38:50 +0200
Message-ID: <200610061438.50965.jnareb@gmail.com>
References: <20061002201256.89409.qmail@web31809.mail.mud.yahoo.com> <200610022250.32029.jnareb@gmail.com> <7vven1syg0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 06 14:38:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVoy0-0007n9-6L
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 14:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWJFMiN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 6 Oct 2006 08:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWJFMiM
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 08:38:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:28088 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751176AbWJFMiL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Oct 2006 08:38:11 -0400
Received: by ug-out-1314.google.com with SMTP id o38so309008ugd
        for <git@vger.kernel.org>; Fri, 06 Oct 2006 05:38:10 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JcTCDz02Z4hXbOetCzz1u6i1WUY1XsnWET6SnInFCQwScf0oGHkGmkfApufbHqcDxmXC5X9iqCaRxWZkiV1Q/HulnWf0ZquzO67j+MbGG22cNvJo8J9DSBlhjMmeDpmteWFOKvuMwbFLp0lsR+7QxuY2pywngOAR+v537qsQAJw=
Received: by 10.67.105.19 with SMTP id h19mr3156982ugm;
        Fri, 06 Oct 2006 05:38:09 -0700 (PDT)
Received: from host-81-190-18-48.torun.mm.pl ( [81.190.18.48])
        by mx.google.com with ESMTP id m4sm1855508ugc.2006.10.06.05.38.08;
        Fri, 06 Oct 2006 05:38:09 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7vven1syg0.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28399>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>=20
>> But you forget that in HTTP headers, to be more exact in
>> =A0=A0=A0=A0=A0=A0Content-Disposition: inline; filename=3D"<filename=
>"
>> header, the quote '"' and end-of-line '\n' characters in <filename>
>> are treated specially. So you need to quote somehow at least those
>> two characters.
>=20
> True, but untrue. =A0This is just a suggestion so we do not _have_
> to quote. =A0We only need to avoid spitting out dq and lf
> literally. =A0We could even just do something like the attached if
> we wanted to:
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0s/[^ -~]+/?/g=A0=A0=A0;# replace each sequenc=
e of bytes outside
> =A0 =A0 =A0 =A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 # ' =
' to '~' range to a '?'
>=20
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 44991b1..e7202ee 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2651,7 +2651,7 @@ sub git_blob_plain {
> =A0=A0=A0=A0=A0=A0=A0=A0# save as filename, even when no $file_name i=
s given
> =A0=A0=A0=A0=A0=A0=A0=A0my $save_as =3D "$hash";
> =A0=A0=A0=A0=A0=A0=A0=A0if (defined $file_name) {
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0$save_as =3D $file_name=
;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0($save_as =3D $file_nam=
e) =3D~ s/[^ -~]+/?/g;
> =A0=A0=A0=A0=A0=A0=A0=A0} elsif ($type =3D~ m/^text\//) {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0$save_as .=3D '.txt';
> =A0=A0=A0=A0=A0=A0=A0=A0}

I'd rather add (and use) separate subroutine for quoting/escaping
values in HTTP headers, or to be more exact for the filename part
of HTTP header "Content-Disposition:". This way if we decide to
not replace all characters outside US-ASCII in suggested filename
to save with '?', but only qoublequote '"' and linefeed '\n' characters=
,
or even implement RFC 2047 to do the encoding (of course if browsers
can read it), we could do this in one place.=20

How such a subroutine should be named? esc_http? esc_header or esc_hdr?
esc_http_header? Any other ideas?
--=20
Jakub Narebski
Poland
