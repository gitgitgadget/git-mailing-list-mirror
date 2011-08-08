From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Suppressing auto-cc for specific addresses
Date: Mon, 8 Aug 2011 23:17:26 +0200
Message-ID: <20110808211726.GA18619@elie.gateway.2wire.net>
References: <4E3EF38A.9010307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>,
	Joe Perches <joe@perches.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	"J. Bruce Fields" <bfields@fieldses.org>, Jeff King <peff@peff.net>
To: Daniel Mack <zonque@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 08 23:17:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqXCj-0005D8-0K
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 23:17:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257Ab1HHVRk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Aug 2011 17:17:40 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64198 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843Ab1HHVRj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2011 17:17:39 -0400
Received: by ywf7 with SMTP id 7so508841ywf.19
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 14:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=He9X1oG1qnnkVhCCyIs8UjvYtfSV8vbeiH2lI0Mz/vw=;
        b=lYyxIuQnQ26p9cYx/70DwxEokrWM40LTXVpFudYjqC1n/0x5VmUGbElzNmBwrJzK8r
         egExnvzIta8TVJ8dgYwf/g2zbsEXmvrxCK6MljfnJ7F7eGFhlhOy+pKCRXcOnngZQ3NU
         UovWQd09PWEIFLhFcgxR7dh2SDtZ6ziVOW05w=
Received: by 10.150.225.17 with SMTP id x17mr3331979ybg.257.1312838258537;
        Mon, 08 Aug 2011 14:17:38 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-49-224.dsl.chcgil.ameritech.net [69.209.49.224])
        by mx.google.com with ESMTPS id j3sm5076982yhl.38.2011.08.08.14.17.37
        (version=SSLv3 cipher=OTHER);
        Mon, 08 Aug 2011 14:17:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E3EF38A.9010307@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178988>

(+cc: some send-email people)
Hi,

Daniel Mack wrote:

> I'm looking for a way to suppress certain Cc: fields that are normall=
y
> automatically added for addresses mentioned in Cc: lines found in pat=
ches.

Makes sense.  Could you please add a quick commit message, following
the guidelines in Documentation/SubmittingPatches (i.e., explaining
the problem this intends to solve and justifying how it is solved)?

Patch left untrimmed for Joe and =C3=86var's convenience.  Thanks and h=
ope
that helps.

> From: Daniel Mack <zonque@gmail.com>
> Date: Sun, 7 Aug 2011 22:16:00 +0200
> Subject: [PATCH] send-email: Allow email addresses and domains as
>  --suppress-cc options
>=20
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>  Documentation/git-send-email.txt |   10 +++++++---
>  git-send-email.perl              |   12 +++++++++++-
>  2 files changed, 18 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-sen=
d-email.txt
> index 327233c..5966abb 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -233,9 +233,9 @@ Automating
>  	cc list. Default is the value of 'sendemail.signedoffbycc' configur=
ation
>  	value; if that is unspecified, default to --signed-off-by-cc.
> =20
> ---suppress-cc=3D<category>::
> -	Specify an additional category of recipients to suppress the
> -	auto-cc of:
> +--suppress-cc=3D<category|address|domain>::
> +	Specify an additional category, email address or domain of recipien=
ts
> +	to suppress the auto-cc for. Possible categories are:
>  +
>  --
>  - 'author' will avoid including the patch author
> @@ -251,6 +251,10 @@ Automating
>  - 'all' will suppress all auto cc values.
>  --
>  +
> +If a full email address is given, auto-cc will be suppressed for thi=
s particular
> +address. This also works for entire domains if the parameter starts =
with the '@'
> +sign. All email addresses in that domain will hence be ignored by au=
to-cc.
> ++
>  Default is the value of 'sendemail.suppresscc' configuration value; =
if
>  that is unspecified, default to 'self' if --suppress-from is
>  specified, as well as 'body' if --no-signed-off-cc is specified.
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 98ab33a..22813e5 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -374,7 +374,7 @@ my(%suppress_cc);
>  if (@suppress_cc) {
>  	foreach my $entry (@suppress_cc) {
>  		die "Unknown --suppress-cc field: '$entry'\n"
> -			unless $entry =3D~ /^(?:all|cccmd|cc|author|self|sob|body|bodycc)=
$/;
> +			unless $entry =3D~ /^(?:all|cccmd|cc|author|self|sob|body|bodycc|=
=2E*@.*)$/;
>  		$suppress_cc{$entry} =3D 1;
>  	}
>  }
> @@ -1213,6 +1213,11 @@ foreach my $t (@files) {
>  					} else {
>  						next if ($suppress_cc{'cc'});
>  					}
> +					next if ($suppress_cc{$addr});
> +					if ($addr =3D~ /^(.+)(@.+)$/) {
> +						my $domain =3D $2;
> +						next if $suppress_cc{$domain};
> +					}
>  					printf("(mbox) Adding cc: %s from line '%s'\n",
>  						$addr, $_) unless $quiet;
>  					push @cc, $addr;
> @@ -1261,6 +1266,11 @@ foreach my $t (@files) {
>  				next if $suppress_cc{'sob'} and $what =3D~ /Signed-off-by/i;
>  				next if $suppress_cc{'bodycc'} and $what =3D~ /Cc/i;
>  			}
> +			next if ($suppress_cc{$c});
> +			if ($c =3D~ /^(.+)(@.+)$/) {
> +				my $domain =3D $2;
> +				next if $suppress_cc{$domain};
> +			}
>  			push @cc, $c;
>  			printf("(body) Adding cc: %s from line '%s'\n",
>  				$c, $_) unless $quiet;
> --=20
> 1.7.6
