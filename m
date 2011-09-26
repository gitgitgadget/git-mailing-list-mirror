From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] send-email: auth plain/login fix
Date: Mon, 26 Sep 2011 10:24:21 -0700 (PDT)
Message-ID: <m3fwjjp69m.fsf@localhost.localdomain>
References: <7vzkjn16n6.fsf@alter.siamese.dyndns.org>
	<1316879367-1182-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, joe@perches.com, git@vger.kernel.org
To: =?iso-8859-4?q?Zbigniew_J=EAdrzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Mon Sep 26 19:24:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8Eur-0000A5-61
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 19:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542Ab1IZRYY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Sep 2011 13:24:24 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54386 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474Ab1IZRYY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2011 13:24:24 -0400
Received: by bkbzt4 with SMTP id zt4so6020412bkb.19
        for <git@vger.kernel.org>; Mon, 26 Sep 2011 10:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=hMTUfJryb2WsbVFTHcVWrVYnxtFDZN2t7f9/dudtynk=;
        b=jaXgXb4gkk3jwFWH93S0W/dhzTLqh0GIwqS0AkOeXvSMCeIaPGNhMJQLGgOghkZO4U
         UyrSjVQRzcU2N9oRoTALB3hFXAItSTfTiNh4UdPPycO7S+gdLHkzkqHl9G8MTitreh+v
         GFVPa5y7zXkw4rTD2Fc2E5KztI/Cm++pLLI1M=
Received: by 10.204.157.132 with SMTP id b4mr4362172bkx.164.1317057862911;
        Mon, 26 Sep 2011 10:24:22 -0700 (PDT)
Received: from localhost.localdomain (abwm119.neoplus.adsl.tpnet.pl. [83.8.236.119])
        by mx.google.com with ESMTPS id x4sm8871307fad.1.2011.09.26.10.24.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 26 Sep 2011 10:24:21 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p8QHNelG008613;
	Mon, 26 Sep 2011 19:23:50 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p8QHNHlN008606;
	Mon, 26 Sep 2011 19:23:17 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1316879367-1182-1-git-send-email-zbyszek@in.waw.pl>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182137>

Zbigniew J=EAdrzejewski-Szmek <zbyszek@in.waw.pl> writes:

> git send-email was not authenticating properly when communicating ove=
r
> TLS with a server supporting only AUTH PLAIN and AUTH LOGIN. This is
> e.g. the standard server setup under debian with exim4 and probably
> everywhere where system accounts are used.
>=20
> The solution comes from this forum thread:
> http://www.perlmonks.org/?node_id=3D904354

Signoff?

> ---
>  git-send-email.perl |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>=20
> diff --git git-send-email.perl git-send-email.perl
> index 37dfbe7..100fbd9 100755
> --- git-send-email.perl
> +++ git-send-email.perl
> @@ -27,6 +27,7 @@ use Term::ANSIColor;
>  use File::Temp qw/ tempdir tempfile /;
>  use File::Spec::Functions qw(catfile);
>  use Error qw(:try);
> +use Authen::SASL qw(Perl);
>  use Git;
>  use MIME::Base64;

Shouldn't we load Authen::SASL only when it is necessary (on demand),
rather than forcing everybody who use send-email (even if via
sendmail, or with other authentication support)?

We load Net::SMTP::SSL only on demand. =20

It would be:

   require Authen::SASL;
   Authen::SASL->import(qw(Perl));

--=20
Jakub Nar=EAbski
