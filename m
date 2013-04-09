From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH 3/4] gitweb: Don't append ';js=(0|1)' to external links
Date: Tue, 09 Apr 2013 17:16:37 +0200
Message-ID: <516430D5.6030201@gmail.com>
References: <m2wqscbx83.fsf@blackdown.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?SsO8cmdlbiBLcmVpbGVkZXI=?= <jk@blackdown.de>
X-From: git-owner@vger.kernel.org Tue Apr 09 17:16:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPaHv-0002uF-DO
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 17:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934971Ab3DIPQo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Apr 2013 11:16:44 -0400
Received: from mail-ee0-f51.google.com ([74.125.83.51]:46857 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934797Ab3DIPQm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 11:16:42 -0400
Received: by mail-ee0-f51.google.com with SMTP id c4so2908706eek.10
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 08:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=9wGDMfHqm7awBbV/RXXPWNsNP2c4RpwunaLHkDyaV0Y=;
        b=DFXvFAevbLH1Uk94ES8tp93zkma8WI0BL6R+oUiOfdXvz2pGbM26sq2yANzLZDQKiQ
         ryf5NnAhtfvdpEjJeeBckOM16DOMeIFH9FI2xux7y3RZCFlrk/KowxjyYGpC3wTMvmDd
         3yg2rW5KOBuype84Cd7vYD5OtmdZ5MKvXeqNKEmy+LySn27FCRe8f8KassqN5U+afyaE
         wdniFmDjmTzJp8cId4FNhrHiLcK7BX3Iu/iMLg5IxIMuGJZwZTNiUh0VdTSvaNx3Phuo
         NEZeXtTw2HBSpSMf2eTGT0nKNXNuDJ8FZdxIZBvu8DOhbYNMaXXJ5cRoOjkeY9lrxzLr
         BCAw==
X-Received: by 10.15.27.195 with SMTP id p43mr26052021eeu.8.1365520601357;
        Tue, 09 Apr 2013 08:16:41 -0700 (PDT)
Received: from [192.168.1.14] (eis221.neoplus.adsl.tpnet.pl. [83.21.134.221])
        by mx.google.com with ESMTPS id bj2sm13781739eeb.1.2013.04.09.08.16.39
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 09 Apr 2013 08:16:40 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
In-Reply-To: <m2wqscbx83.fsf@blackdown.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220575>

J=C3=BCrgen Kreileder wrote:

> Don't add js parameters to links outside of gitweb itself.

Hmmm... this limits adding ';js=3D(0|1)' to only links which begin with
$my_url, i.e. absolute links beginning with gitweb's base URL.

Wouldn't that mean that most internal gitweb-generated links wouldn't
get ';js=3D(0|1)'?  href(..., -full =3D> 1) is not the default...

> Signed-off-by: J=C3=BCrgen Kreileder <jk@blackdown.de>
> ---
>  gitweb/gitweb.perl                       |    2 +-
>  gitweb/static/js/javascript-detection.js |    4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 1309196..f0912d7 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -4165,7 +4165,7 @@ sub git_footer_html {
>  		print qq!<script type=3D"text/javascript">\n!.
>  		      qq!window.onload =3D function () {\n!;
>  		if (gitweb_check_feature('javascript-actions')) {
> -			print qq!	fixLinks();\n!;
> +			print qq!	fixLinks('$my_url');\n!;
>  		}
>  		if ($jstimezone && $tz_cookie && $datetime_class) {
>  			print qq!	var tz_cookie =3D { name: '$tz_cookie', expires: 14, pa=
th: '/' };\n!. # in days
> diff --git a/gitweb/static/js/javascript-detection.js b/gitweb/static=
/js/javascript-detection.js
> index fa2596f..36964ad 100644
> --- a/gitweb/static/js/javascript-detection.js
> +++ b/gitweb/static/js/javascript-detection.js
> @@ -29,11 +29,11 @@ var jsExceptionsRe =3D /[;?]js=3D[01](#.*)?$/;
>   *
>   * @globals jsExceptionsRe
>   */
> -function fixLinks() {
> +function fixLinks(baseurl) {
>  	var allLinks =3D document.getElementsByTagName("a") || document.lin=
ks;
>  	for (var i =3D 0, len =3D allLinks.length; i < len; i++) {
>  		var link =3D allLinks[i];
> -		if (!jsExceptionsRe.test(link)) {
> +		if (!jsExceptionsRe.test(link) && !link.href.indexOf(baseurl)) {
>  			link.href =3D link.href.replace(/(#|$)/,
>  				(link.href.indexOf('?') =3D=3D=3D -1 ? '?' : ';') + 'js=3D1$1');
>  		}
>=20


--=20
Jakub Nar=C4=99bski
