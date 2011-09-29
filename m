From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v4] send-email: auth plain/login fix
Date: Thu, 29 Sep 2011 08:01:14 -0700
Message-ID: <1317308474.1854.8.camel@Joe-Laptop>
References: <20110929141616.GU10763@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org, peff@peff.net
To: Zbigniew =?UTF-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Thu Sep 29 17:01:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9I6y-0003oO-3j
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 17:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756705Ab1I2PBQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Sep 2011 11:01:16 -0400
Received: from perches-mx.perches.com ([206.117.179.246]:40521 "EHLO
	labridge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754863Ab1I2PBP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 11:01:15 -0400
Received: from [173.60.85.8] (account joe@perches.com HELO [192.168.1.155])
  by labridge.com (CommuniGate Pro SMTP 5.0.14)
  with ESMTPA id 18209450; Thu, 29 Sep 2011 08:01:14 -0700
In-Reply-To: <20110929141616.GU10763@in.waw.pl>
X-Mailer: Evolution 3.1.92- 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182404>

On Thu, 2011-09-29 at 16:16 +0200, Zbigniew J=C4=99drzejewski-Szmek wro=
te:
> git send-email was not authenticating properly when communicating ove=
r
> TLS with a server supporting only AUTH PLAIN and AUTH LOGIN. This is
> e.g. the standard server setup under debian with exim4 and probably
> everywhere where system accounts are used.
>=20
> The problem (only?) exists when libauthen-sasl-cyrus-perl
> (Authen::SASL::Cyrus) is installed. Importing Authen::SASL::Perl
> makes Authen::SASL use the perl implementation which works
> better.
[]
> diff --git a/git-send-email.perl b/git-send-email.perl
[]
> @@ -1098,6 +1098,10 @@ X-Mailer: git-send-email $gitversion
>  		}
> =20
>  		if (defined $smtp_authuser) {
> +			eval {
> +				require Authen::SASL;
> +				Authen::SASL->import(qw(Perl));
> +			};

Thanks for keeping at this.

One comment:

This is a workaround for a nominal defect.

As such, I think the code should be commented
to note why it exists.

How about adding a comment like:

 		if (defined $smtp_authuser) {
			# Workaround AUTH PLAIN/LOGIN interaction defect
			# with Authen::SASL::Cyrus
			eval {
				require Authen::SASL;
