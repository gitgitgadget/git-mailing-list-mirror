From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 03/11] gitweb: separate heads and remotes list in summary view
Date: Fri, 14 Nov 2008 21:04:34 +0100
Message-ID: <200811142104.35019.jnareb@gmail.com>
References: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com> <1226616555-24503-3-git-send-email-giuseppe.bilotta@gmail.com> <1226616555-24503-4-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 21:05:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L14vT-00035m-0R
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 21:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753518AbYKNUEk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Nov 2008 15:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753286AbYKNUEk
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 15:04:40 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:18408 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654AbYKNUEj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 15:04:39 -0500
Received: by nf-out-0910.google.com with SMTP id d3so785136nfc.21
        for <git@vger.kernel.org>; Fri, 14 Nov 2008 12:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Jr9HRP9hVW6VHf4nGFZlkaEHN6czWQVqarTu4PNwljY=;
        b=lwhJ0MPa0az1DbNQP8SeISTh1CYsaN6e/H4vODmuVBVeyjT+m/c24OJ4lJ8ihTc5kk
         53BLFAwt2Mvt1BPOibRNWTxZVdfQZ6fMEEs2cTecoI7/fULvYey6LEBq6V67s2SuqrDF
         KhyEWo9L8fKwl5NuMTiSFcgecbCk7lRVvLECo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=PrNrzJV5roi/7zvyCbbEk0Z68Xa5EjdNVRpZJW3hMJxsBAF5D/Bd2eJTy7VyAWzOGk
         Q7F5fqWQzzXlVuDb1/l0ECJscO69rKj73iDuP3kJFLDDeVxr1qPz1/bUsgqOPeqWF1yN
         5WgzU8gxGOnXJXrgzMARz6yxfS7REcCpq8XAo=
Received: by 10.86.84.5 with SMTP id h5mr817902fgb.49.1226693077745;
        Fri, 14 Nov 2008 12:04:37 -0800 (PST)
Received: from ?192.168.1.11? (abwt29.neoplus.adsl.tpnet.pl [83.8.243.29])
        by mx.google.com with ESMTPS id e20sm2248675fga.1.2008.11.14.12.04.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 Nov 2008 12:04:36 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1226616555-24503-4-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101010>

Dnia czwartek 13. listopada 2008 23:49, Giuseppe Bilotta napisa=B3:

Very nice patch. Now that I have read it, I don't think it should be
squashed with previous patch (well, again that is only a suggestion).
Barring one issue (see below) its conciseness shows that gitweb has
quite good internal API.

> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.perl |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)
>=20
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index d7c97a3..ab29aec 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -4449,6 +4449,7 @@ sub git_summary {
>  	my %co =3D parse_commit("HEAD");
>  	my %cd =3D %co ? parse_date($co{'committer_epoch'}, $co{'committer_=
tz'}) : ();
>  	my $head =3D $co{'id'};
> +	my ($remote_heads) =3D gitweb_check_feature('remote_heads');
> =20
>  	my $owner =3D git_get_project_owner($project);
> =20
> @@ -4456,7 +4457,8 @@ sub git_summary {
>  	# These get_*_list functions return one more to allow us to see if
>  	# there are more ...
>  	my @taglist  =3D git_get_tags_list(16);
> -	my @headlist =3D git_get_heads_list(16);
> +	my @headlist =3D git_get_heads_list(16, 'heads');
> +	my @remotelist =3D $remote_heads ? git_get_heads_list(16, 'remotes'=
) : ();

Nice.

>  	my @forklist;
>  	my ($check_forks) =3D gitweb_check_feature('forks');
> =20
> @@ -4535,6 +4537,13 @@ sub git_summary {
>  		               $cgi->a({-href =3D> href(action=3D>"heads")}, "..."=
));
>  	}
> =20
> +	if (@remotelist) {
> +		git_print_header_div('remotes');
> +		git_heads_body(\@remotelist, $head, 0, 15,
> +		               $#remotelist <=3D 15 ? undef :
> +		               $cgi->a({-href =3D> href(action=3D>"heads")}, "..."=
));
> +	}
> +

The only problem is that link leads to list of _all_ heads (best case),
or list to local branches (worst case, but I don't think gitweb does
it), instead of only list of remotes refs (remote-tracking branches),
as one would think.  Perhaps we could use 'h' (hash), or 'opt (extra
options) parameter for this action, or just add 'remotes' action?=20

>  	if (@forklist) {
>  		git_print_header_div('forks');
>  		git_project_list_body(\@forklist, 'age', 0, 15,
> --=20
> 1.5.6.5

P.S. Not uptodate (git version 1.6.0.4)? Just kidding...

--=20
Jakub Narebski
Poland
