From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUGFIX PATCH 1/4] git-instaweb: Fix issue with static files for
 'plackup' server
Date: Wed, 29 Dec 2010 15:52:42 -0800
Message-ID: <7v1v50rvat.fsf@alter.siamese.dyndns.org>
References: <201012291743.41213.jnareb@gmail.com>
 <201012291747.01288.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Tadeusz Sosnierz <tadzikes@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 30 00:53:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PY5pF-0007PZ-5x
	for gcvg-git-2@lo.gmane.org; Thu, 30 Dec 2010 00:53:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754203Ab0L2Xw4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Dec 2010 18:52:56 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39804 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754182Ab0L2Xw4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Dec 2010 18:52:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 82C8832C9;
	Wed, 29 Dec 2010 18:53:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=OYDu8PPDzMDc
	OZMK0iHi/H1RNJg=; b=Lx2a2GktANQWb17BosjJ3A/CCJ1+PtSsHdI0D+kjEfF3
	EpwmxosJ0hYZToKDyraOseKGEkfD0t7y4PaRrZUWVF2yyzAS83v7N3wT+NMPqiMQ
	21OMWiuMOFc702fan/QLaMh1fCL9PQC+VKtPg2FE1NQLOk8lwxDIQHNPMd+AtvI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ueeraH
	2wi81U6H6wYOZ/TkSHP2l9Ux0Ms+6jX3Gfpt/Il/5r0uwiU11bX9d0AUP/9D/yXH
	WhQBeb9ljQMxSZ5EWTG0uI280wQZfcEpoJ749ovcq/XpKxTzoA7RgY/r0MZiH8uS
	6Nn2dxkTerd9AjLQHNu0M5j7/SfnlzlQVBuqk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3E24D32C8;
	Wed, 29 Dec 2010 18:53:22 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AB0D232C4; Wed, 29 Dec 2010
 18:53:16 -0500 (EST)
In-Reply-To: <201012291747.01288.jnareb@gmail.com> (Jakub Narebski's message
 of "Wed\, 29 Dec 2010 17\:47\:00 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D18A11CE-13A6-11E0-8C3B-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164340>

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
> Junio, could you apply this before 1.7.4?  Thanks in advance.
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

I wonder if you meant qr{^/static/.*\\.(?:js|css|png)\$} here, to make
sure that these three tokens are file suffixes, not just random
substring.

>  		root =3D> "$root/",
>  		encoding =3D> 'utf-8'; # encoding for 'text/plain' files
>  	# convert CGI application to PSGI app
> --=20
> 1.7.3
