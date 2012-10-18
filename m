From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] status: refactor output format to represent
 "default"
Date: Wed, 17 Oct 2012 22:03:08 -0400
Message-ID: <20121018020308.GA24484@sigill.intra.peff.net>
References: <1350404569-9787-1-git-send-email-pclouds@gmail.com>
 <1350525480-30395-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 04:03:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOfSE-0007dD-DO
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 04:03:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753484Ab2JRCDL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Oct 2012 22:03:11 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57119 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753243Ab2JRCDK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 22:03:10 -0400
Received: (qmail 32088 invoked by uid 107); 18 Oct 2012 02:03:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 17 Oct 2012 22:03:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Oct 2012 22:03:08 -0400
Content-Disposition: inline
In-Reply-To: <1350525480-30395-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207950>

On Thu, Oct 18, 2012 at 08:57:59AM +0700, Nguyen Thai Ngoc Duy wrote:

> From: Jeff King <peff@peff.net>
>=20
> When deciding which output format to use, we default an
> internal enum to STATUS_FORMAT_LONG and modify it if
> "--porcelain" or "--short" is given. If this enum is set to
> LONG, then we know the user has not specified any format,
> and we can kick in default behaviors. This works because
> there is no "--long" which they could use to explicitly
> specify LONG.
>=20
> Let's expand the enum to have an explicit STATUS_FORMAT_NONE,
> in preparation for adding "--long". Then we can distinguish
> between LONG and NONE when setting other defaults. There are
> two such cases:
>=20
>   1. The user has asked for NUL termination. With NONE, we
>      currently default to turning on the porcelain mode.
>      With an explicit --long, we would in theory use NUL
>      termination with the long mode, but it does not support
>      it. So we can just complain and die.
>=20
>   2. When an output format is given to "git commit", we
>      default to "--dry-run". This behavior would now kick in
>      when "--long" is given, too.
>=20
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Two die()s with --long are moved to the next patch where --long is
>  introduced.

I think that is fine to split it like this, but you would want to updat=
e
the commit message above. Probably just remove those two cases and say
something like:

  Note that you cannot actually trigger STATUS_FORMAT_LONG, as we do
  not yet have "--long"; that will come in a follow-on patch.

And then move the reasoning for how "--long" works with each case into
the commit message of the next patch.

Other than that, the patches look OK to me.

-Peff
