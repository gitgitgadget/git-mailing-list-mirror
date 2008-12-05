From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v3 1/3] gitweb: Modularized git_get_project_description to be more generic
Date: Fri, 5 Dec 2008 02:38:14 +0100
Message-ID: <200812050238.16018.jnareb@gmail.com>
References: <87wsei1uvp.wl%seb@cine7.net> <7viqq0c1pg.fsf@gitster.siamese.dyndns.org> <87k5ag22ke.wl%seb@cine7.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>,
	Gustavo Sverzut Barbieri <barbieri@profusion.mobi>
To: =?iso-8859-2?q?S=E9bastien_Cevey?= <seb@cine7.net>
X-From: git-owner@vger.kernel.org Fri Dec 05 02:39:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8PfR-0000N2-I9
	for gcvg-git-2@gmane.org; Fri, 05 Dec 2008 02:39:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522AbYLEBiY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Dec 2008 20:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753269AbYLEBiY
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 20:38:24 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:12121 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117AbYLEBiY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 20:38:24 -0500
Received: by ug-out-1314.google.com with SMTP id 39so3955327ugf.37
        for <git@vger.kernel.org>; Thu, 04 Dec 2008 17:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=aMqnYCUgSurLDy7Mu+qVEqi+X6DJ8fgdHT4/mOC/EZc=;
        b=NOZXnrnYqLd4ezJLvqxQs2mpb0eIZpdXMTIirwa1utu6+140WR+CEzm8r3FDbcOzl9
         c5Z93/g0mvTfy5EU6SWkouAdEHzLNfvn5SS6r6PqynQQDjQ+YNMGjl9A964aIzQlH0F6
         Gr0hGTRHjwZIzapCIWfxrHaG7WJAQgSt7Z30o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=OncpuoKoCmCgeXw8DKZ3CNpDifOLJsvXjjRUjLJTH4PmtEOsvRK7F0U2u0QZYfjZJL
         XyrjxzqE21sxICcEmuFUMOULTM5ZPYOwzHG1weiiLhl9a1P5ca+iKhhPsgaZuxjxzNEn
         pOYwt+EFVM3oYY0C4xIVrTYhI7i91TTdCRX/g=
Received: by 10.86.80.5 with SMTP id d5mr274132fgb.7.1228441102002;
        Thu, 04 Dec 2008 17:38:22 -0800 (PST)
Received: from ?192.168.1.11? (abvv86.neoplus.adsl.tpnet.pl [83.8.219.86])
        by mx.google.com with ESMTPS id 12sm3270022fgg.53.2008.12.04.17.38.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Dec 2008 17:38:20 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <87k5ag22ke.wl%seb@cine7.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102385>

On Thu, 4 Dec 2008, at 01:42, S=E9bastien Cevey wrote:

> Introduce a git_get_file_or_project_config utility function to
> retrieve a repository variable either from a plain text file in the
> $GIT_DIR=20

I would say that we try $GIT_DIR/$variable file.

> or else from 'gitweb.$variable' in the repository config=20
> (e.g. 'description').

It _might_ also be added (just in case) that currently the only user
of this new subroutine is git_get_project_description, but this is
to change, and that is why this split was introduced.

>=20
> Signed-off-by: Sebastien Cevey <seb@cine7.net>

But those are minor issues. So, FWIW

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.perl |   24 ++++++++++++++++--------
>  1 files changed, 16 insertions(+), 8 deletions(-)
>=20
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 933e137..b31274c 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2001,18 +2001,26 @@ sub git_get_path_by_hash {
>  ## .................................................................=
=2E....
>  ## git utility functions, directly accessing git repository
> =20
> -sub git_get_project_description {
> -	my $path =3D shift;
> +# get the value of a config variable either from a file with the sam=
e
> +# name in the repository, or the gitweb.$name value in the repositor=
y
> +# config file.

It would probably be better to explicitly say that we use $git_dir/$nam=
e
file, or if it doesn't exist, gitweb.$name configuration variable.

> +sub git_get_file_or_project_config {
> +	my ($name, $path) =3D @_;

I think that $project, or $projectpath _might_ be better name for the
second argument to this subroutine.

> =20
>  	$git_dir =3D "$projectroot/$path";
> -	open my $fd, "$git_dir/description"
> -		or return git_get_project_config('description');
> -	my $descr =3D <$fd>;
> +	open my $fd, "$git_dir/$name"
> +		or return git_get_project_config($name);
> +	my $conf =3D <$fd>;
>  	close $fd;
> -	if (defined $descr) {
> -		chomp $descr;
> +	if (defined $conf) {
> +		chomp $conf;
>  	}
> -	return $descr;
> +	return $conf;
> +}
> +
> +sub git_get_project_description {
> +	my $path =3D shift;
> +	return git_get_file_or_project_config('description', $path);
>  }

Nicely done.

> =20
>  sub git_get_project_ctags {
> --=20
> 1.5.6.5
>=20
>=20

--=20
Jakub Nar=EAbski
Poland
