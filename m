From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 5/7] gitweb: auxiliary functions to group data
Date: Fri, 17 Sep 2010 03:24:24 +0200
Message-ID: <201009170324.25801.jnareb@gmail.com>
References: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com> <1284629465-14798-6-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 17 03:24:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwPgz-0004iH-1E
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 03:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752488Ab0IQBYd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Sep 2010 21:24:33 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39761 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186Ab0IQBYc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Sep 2010 21:24:32 -0400
Received: by bwz11 with SMTP id 11so2192329bwz.19
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 18:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=c+U3byyXk65lX4P4CmjQMScb5tf67c1ZlnZj7aPJZsE=;
        b=cUpaJnPa4+FUGJhTXbBQIUpjTCgsbcq1PBaOtnbz04eDxWKdTD21pHjENhHDH8ThT4
         3Y0EqZ4Z6I7FEguixxnTsxoWqZ1rbo7ZdEpIrS0RX5lEiB9MLTsS97J8BJD912/EotBL
         s0RczrQLuOGISQZGHqb/SmdXMiIUaFRJeoUSs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=vl/Bk7tWxGz59J2aHV6evrmtdmIv2NohMiPiAg0tPdOevsnHguxFprTYoHR0ySitJW
         6SYJWFAWoXyw7quiBBN82WoajUDn29T8CkQF3OwWvcABslaM64VSLvimPS8+M+a7BXil
         C1vt0fBbkusvrnlQrIcnAzK/b8iiwF6X0pIt0=
Received: by 10.204.160.146 with SMTP id n18mr3023903bkx.116.1284686670914;
        Thu, 16 Sep 2010 18:24:30 -0700 (PDT)
Received: from [192.168.1.13] (abvo68.neoplus.adsl.tpnet.pl [83.8.212.68])
        by mx.google.com with ESMTPS id g12sm3064556bkb.2.2010.09.16.18.24.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Sep 2010 18:24:29 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1284629465-14798-6-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156367>

On Thu, 16 Sep 2010, Giuseppe Bilotta wrote:

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 6138c6e..92551e4 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3765,6 +3765,21 @@ sub git_print_header_div {
>  	      "\n</div>\n";
>  }
> =20
> +sub git_begin_group {
> +	my ($class, $id, @rest) =3D @_;
> +
> +	$class =3D ' class=3D"' . join(' ', 'group', $class) . '"';
> +
> +	$id =3D ' id=3D"' . $id . '"' if $id;
> +
> +	print "<div$class$id>\n";

I agree with =C6var that it would be better to use HTML generation
subroutines from CGI.pm, even start_div and end_div...

> +	git_print_header_div(@rest);
> +}
> +
> +sub git_end_group {
> +	print "</div>\n"
> +}

=2E.. but I think that having separate subroutines for opening and
closing tags is a bad design / bad API (except in some rare cases).
It is begging for unbalanced HTML.

It would be better if it was a single subroutine wrapping 'div' around
contents given either as a string, or via callback (subroutine referenc=
e),
in my opinion.

> +
>  sub print_local_time {
>  	print format_local_time(@_);
>  }
> --=20
> 1.7.3.rc1.230.g8b572
>=20
>=20

--=20
Jakub Narebski
Poland
