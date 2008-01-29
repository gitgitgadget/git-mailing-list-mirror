From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Subject: Re: [PATCH] gitweb: convert from perl internal to utf8 for commitdiff_plain
Date: Tue, 29 Jan 2008 05:11:30 +0200
Organization: Pardus / KDE
Message-ID: <200801290511.31025.ismail@pardus.org.tr>
References: <87ve5dicih.wl@mail2.atmark-techno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Yasushi SHOJI <yashi@atmark-techno.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 04:11:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJgsy-0005ho-Hh
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 04:11:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992AbYA2DLQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jan 2008 22:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753692AbYA2DLP
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 22:11:15 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:60480 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753273AbYA2DLO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jan 2008 22:11:14 -0500
Received: from ninjamobile.local (unknown [85.101.47.123])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id 5BE5A6208A23;
	Tue, 29 Jan 2008 05:11:09 +0200 (EET)
User-Agent: KMail/1.9.8
In-Reply-To: <87ve5dicih.wl@mail2.atmark-techno.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71937>

At Tuesday 29 January 2008 around 04:14:00 Yasushi SHOJI wrote:
> commitdiff with raw, or plain format if you are reading the code,
> doesn't convert any word from perl internal to utf8, which is set to
> charset in http header.  this cause a problem when commit includes no=
n
> ascii code.
>
> here is a few example in the git tree:
>
> http://git.kernel.org/?p=3Dgit/git.git;a=3Dcommitdiff_plain;h=3D6ba78=
238a82428281
>6944550edc4297dd2808a72
> http://git.kernel.org/?p=3Dgit/git.git;a=3Dcommitdiff_plain;h=3De360b=
ebf713b6b037
>68c62de8b94ddf9350b0953
> http://git.kernel.org/?p=3Dgit/git.git;a=3Dcommitdiff_plain;h=3D9459a=
a77a032621a2
>9d53605542844641cca843a
>
> This patch effectively revert the commitdiff plain part of the commit
>
> 	59b9f61a3f76762dc975e99cc05335a3b97ad1f9
>
> which converted from print to here-doc. but it doesn't
> explain why in the commit log.
> ---
>  gitweb/gitweb.perl |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 6256641..5d9ac1d 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -5048,16 +5048,16 @@ sub git_commitdiff {
>  			-expires =3D> $expires,
>  			-content_disposition =3D> 'inline; filename=3D"' . "$filename" . =
'"');
>  		my %ad =3D parse_date($co{'author_epoch'}, $co{'author_tz'});
> -		print <<TEXT;
> -From: $co{'author'}
> -Date: $ad{'rfc2822'} ($ad{'tz_local'})
> -Subject: $co{'title'}
> -TEXT
> +		print "From: " . to_utf8($co{'author'}) . "\n";
> +		print "Date: " . to_utf8($ad{'rfc2822'}) . " "
> +			       . to_utf8($ad{'tz_local'}) . "\n";
> +		print "Subject: " . to_utf8($co{'title'}) . "\n";
> +
>  		print "X-Git-Tag: $tagname\n" if $tagname;
>  		print "X-Git-Url: " . $cgi->self_url() . "\n\n";
>
>  		foreach my $line (@{$co{'comment'}}) {
> -			print "$line\n";
> +			print to_utf8($line) . "\n";
>  		}
>  		print "---\n\n";
>  	}

Nice find, looks correct. You could print "Date" on one line instead of=
 two,=20
but FWIW

Acked-by: =C4=B0smail D=C3=B6nmez <ismail@pardus.org.tr>

--=20
Never learn by your mistakes, if you do you may never dare to try again=
=2E
