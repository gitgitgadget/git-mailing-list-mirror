From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Add js=1 before an URI fragment to fix line number links
Date: Mon, 26 Sep 2011 16:19:25 -0700 (PDT)
Message-ID: <m339fiq4dx.fsf@localhost.localdomain>
References: <1317060642-25488-1-git-send-email-peter@stuge.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Peter Stuge <peter@stuge.se>
X-From: git-owner@vger.kernel.org Tue Sep 27 01:19:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8KST-0002Ib-Nu
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 01:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974Ab1IZXT3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Sep 2011 19:19:29 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38935 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752959Ab1IZXT2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2011 19:19:28 -0400
Received: by fxe4 with SMTP id 4so6554266fxe.19
        for <git@vger.kernel.org>; Mon, 26 Sep 2011 16:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=gk79MtBP/TklziTwa4c/Q4VR0SiXktEKMeyrMoTzdpw=;
        b=j/i/y2hl0NeH26YoE51glOLueCZx9S1gGDCCYV/yDztiXQL+YRYsqnwUTh9d1yjTVR
         rBTVUGT1Jlmx5bGFIva5kH8EcRXNIhDXwG+bUC6vo04X00dHPh6XkU/YURUQVvi6z+Tc
         t86yPyjoZA3nzFIv2OwOb2qnZB9KhmTPZU38Y=
Received: by 10.223.40.28 with SMTP id i28mr442698fae.16.1317079166244;
        Mon, 26 Sep 2011 16:19:26 -0700 (PDT)
Received: from localhost.localdomain (abwm119.neoplus.adsl.tpnet.pl. [83.8.236.119])
        by mx.google.com with ESMTPS id j5sm19120434fac.25.2011.09.26.16.19.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 26 Sep 2011 16:19:25 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p8QNIoRK012908;
	Tue, 27 Sep 2011 01:19:00 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p8QNIYYZ012901;
	Tue, 27 Sep 2011 01:18:34 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1317060642-25488-1-git-send-email-peter@stuge.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182186>

Peter Stuge <peter@stuge.se> writes:

It really needs a proper commit message.  Perhaps something like this:

  The fixLinks() function in javascript-detection.js is supposed to
  add 'js' query parameter with a value of 1 to each link that does
  not have 'js' query parameter already.

  However it didn't take into account the fact that URI can have
  'fragment' part.  It meant that:

  1. URIs with fragment and 'js' query parameter, like e.g.

        ...foo?js=3D0#l199

     were not recognized as having 'js' query parameter already.
    =20
  2. The 'js' query parameter, in the form of either '?js=3D1' or ';js=3D=
1'
     was appended at the end of URI, even if it included a fragment
     (had a hash part).  This lead to the incorrect links like this

        ...foo#l199?js=3D1

     instead of adding query parameter as last part of query, but
     before the fragment part, i.e.

        ...foo?js=3D1#l199

> Signed-off-by: Peter Stuge <peter@stuge.se>

=46or what it is worth it

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>  gitweb/static/js/javascript-detection.js |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/gitweb/static/js/javascript-detection.js b/gitweb/static=
/js/javascript-detection.js
> index 93dd2bd..003acd1 100644
> --- a/gitweb/static/js/javascript-detection.js
> +++ b/gitweb/static/js/javascript-detection.js
> @@ -16,7 +16,7 @@
>   * and other reasons to not add 'js=3D1' param at the end of link
>   * @constant
>   */
> -var jsExceptionsRe =3D /[;?]js=3D[01]$/;
> +var jsExceptionsRe =3D /[;?]js=3D[01](#.*)?$/;
> =20
>  /**
>   * Add '?js=3D1' or ';js=3D1' to the end of every link in the docume=
nt
> @@ -33,9 +33,9 @@ function fixLinks() {
>  	var allLinks =3D document.getElementsByTagName("a") || document.lin=
ks;
>  	for (var i =3D 0, len =3D allLinks.length; i < len; i++) {
>  		var link =3D allLinks[i];
> -		if (!jsExceptionsRe.test(link)) { // =3D~ /[;?]js=3D[01]$/;
> -			link.href +=3D
> -				(link.href.indexOf('?') =3D=3D=3D -1 ? '?' : ';') + 'js=3D1';
> +		if (!jsExceptionsRe.test(link)) { // =3D~ /[;?]js=3D[01](#.*)?$/;
> +			link.href =3D link.href.replace(/(#|$)/,
> +				(link.href.indexOf('?') =3D=3D=3D -1 ? '?' : ';') + 'js=3D1$1');
>  		}
>  	}
>  }
> --=20
> 1.7.4.1.343.ga91df.dirty
>=20

--=20
Jakub Nar=EAbski                      mailto:jnareb@fuw.edu.pl
 ZTHiL IFT UW                       http://info.fuw.edu.pl/~jnareb/
