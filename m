From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] sha1_file: fix delta_stack memory leak in unpack_entry
Date: Fri, 21 Feb 2014 00:41:48 -0500
Message-ID: <20140221054148.GA24882@sigill.intra.peff.net>
References: <1392940067-4830-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 21 06:41:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGirz-0008E1-Qg
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 06:41:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913AbaBUFlv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Feb 2014 00:41:51 -0500
Received: from cloud.peff.net ([50.56.180.127]:54281 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752616AbaBUFlu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Feb 2014 00:41:50 -0500
Received: (qmail 3040 invoked by uid 102); 21 Feb 2014 05:41:50 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Feb 2014 23:41:50 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Feb 2014 00:41:48 -0500
Content-Disposition: inline
In-Reply-To: <1392940067-4830-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242458>

On Fri, Feb 21, 2014 at 06:47:47AM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> This delta_stack array can grow to any length depending on the actual
> delta chain, but we forget to free it. Normally it does not matter
> because we use small_delta_stack[] from stack and small_delta_stack
> can hold 64-delta chains, more than standard --depth=3D50 in pack-obj=
ects.
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Found when trying to see if making some objects loose at this phase
>  could help git-blame and how many objects will be loosened. Gotta go
>  soon, didn't really test it, but I bet it'll work.

This looks correct to me.

=46or fun, I measured "git fsck" on linux.git via massif. The peak memo=
ry
usage dropped from 368MB to 306MB. That's probably an extreme case
because it's a big repo and was packed with "--aggressive", but it's
still a nice improvement.

-Peff
