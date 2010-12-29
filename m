From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUGFIX PATCH 1/4] git-instaweb: Fix issue with static files for
 'plackup' server
Date: Wed, 29 Dec 2010 15:24:19 -0800
Message-ID: <7v62ucrwm4.fsf@alter.siamese.dyndns.org>
References: <201012291743.41213.jnareb@gmail.com>
 <201012291747.01288.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Tadeusz Sosnierz <tadzikes@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 30 00:24:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PY5Nn-0006IR-5H
	for gcvg-git-2@lo.gmane.org; Thu, 30 Dec 2010 00:24:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028Ab0L2XYd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Dec 2010 18:24:33 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55626 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086Ab0L2XYc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Dec 2010 18:24:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 286AD3050;
	Wed, 29 Dec 2010 18:25:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Id93px1uQBBu
	nTRAyPzlulLd9ng=; b=oDxX6N6Me/r+vO8dxgVSuGsmlF9nTHN07sDG9D/Q0D4J
	1dE5lKb/S9C6Pb23UV2GWYpPY8FuHeROyNPICnaHqocPVBIJoM531vw5He71535l
	o5rbdMXOKZ7D+u25lcqZiv0zLP6NtEkr2W1Bxy1TRQ2GCKQDZ+5+oJ4ZQO/FC5o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=rGRgAe
	4IsdkljJ+gLEwyX2Q/bCKYvSsVodAFo6+3eZMkB7Q6Rpo9+OqKpHlTzDmkAZnbEs
	SoK0qeC6rUsXmdiItdsWzJtx5QBmL4s3vuDciqYIKBTaIgod6q+/8gzvW6ir80Xo
	eWFQdMKG18Rx32v5T1YuE1SrkJ8bEbJcSdJq4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BD431304D;
	Wed, 29 Dec 2010 18:24:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4FA0D3048; Wed, 29 Dec 2010
 18:24:54 -0500 (EST)
In-Reply-To: <201012291747.01288.jnareb@gmail.com> (Jakub Narebski's message
 of "Wed\, 29 Dec 2010 17\:47\:00 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DAC6054E-13A2-11E0-967D-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164339>

Jakub Narebski <jnareb@gmail.com> writes:

> The default (in gitweb/Makefile) is to use relative paths for gitweb
> static files, e.g. "static/gitweb.css" for GITWEB_CSS.  But the
> configuration for Plack::Middleware::Static in plackup_conf assumed
> that static files must be absolute paths starting with "/gitweb/"
> prefix which had to be stripped, e.g. "/gitweb/static/gitweb.css".
> This in turn caused web server run by "git instaweb --httpd=3Dplackup=
"
> to not access static files (e.g. CSS) correctly.
>
> This is a minimal fixup, making 'plackup' web server in git-instaweb
> work with default gitweb build configuration.
>
> Reported-by: Tadeusz So=C5=9Bnierz <tadzikes@gmail.com>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> The regexp is probably too strict: qr{^/static/} should be enough,
> but I didn't want to change too much at once.
>
> This bug was not noticed because we don't have any test for
> git-instaweb, not mentioning tests for all web servers supported.  An=
d
> the fact that I was checking "git instaweb -httpd=3Dplackup" against
> gitweb.cgi built with custom configuration (including the fact that
> GITWEB_CSS=3D"/gitweb/static/gitweb.css").
>
> tadzik, does that fix the issue you noticed?
>
> Junio, could you apply this before 1.7.4?

Hmph, I was kind of hoping that I can issue 1.7.3.5 tonight...

>
>  git-instaweb.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/git-instaweb.sh b/git-instaweb.sh
> index 10fcebb..bb57d81 100755
> --- a/git-instaweb.sh
> +++ b/git-instaweb.sh
> @@ -549,7 +549,7 @@ my \$app =3D builder {
>  	};
>  	# serve static files, i.e. stylesheet, images, script
>  	enable 'Static',
> -		path =3D> sub { m!\.(js|css|png)\$! && s!^/gitweb/!! },
> +		path =3D> qr{^/static/.*(?:js|css|png)\$},
>  		root =3D> "$root/",
>  		encoding =3D> 'utf-8'; # encoding for 'text/plain' files
>  	# convert CGI application to PSGI app
> --=20
> 1.7.3
