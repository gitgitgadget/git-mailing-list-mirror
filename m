From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] send-email: auth plain/login fix
Date: Tue, 27 Sep 2011 17:48:17 -0400
Message-ID: <20110927214817.GD5176@sigill.intra.peff.net>
References: <m3fwjjp69m.fsf@localhost.localdomain>
 <1317159419-23166-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, joe@perches.com, git@vger.kernel.org
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Tue Sep 27 23:48:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8fVo-0006Hi-JJ
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 23:48:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502Ab1I0VsU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Sep 2011 17:48:20 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45519
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751883Ab1I0VsT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 17:48:19 -0400
Received: (qmail 28940 invoked by uid 107); 27 Sep 2011 21:53:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 Sep 2011 17:53:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Sep 2011 17:48:17 -0400
Content-Disposition: inline
In-Reply-To: <1317159419-23166-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182269>

On Tue, Sep 27, 2011 at 11:36:59PM +0200, Zbigniew J=C4=99drzejewski-Sz=
mek wrote:

>  v2: - added sign-off as requested, although the patch is as trivial
>        as it gets
>      - the import is performed only if it will be used

Nice, it's much better not to make the dependency required by people wh=
o
are not using smtp auth, but...

> diff --git a/git-send-email.perl b/git-send-email.perl
> index 37dfbe7..5a22d18 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1098,6 +1098,8 @@ X-Mailer: git-send-email $gitversion
>  		}
> =20
>  		if (defined $smtp_authuser) {
> +			require Authen::SASL;
> +			Authen::SASL->import(qw(Perl));

What about people who are using smtp auth, but don't need or have
Authen::SASL? I.e., shouldn't this be:

  eval {
    require Authen::SASL;
    Authen::SASL->import(qw(Perl));
  }

and if we hit an error, just ignore it and continue without Authen::SAS=
L
loaded?

-Peff
