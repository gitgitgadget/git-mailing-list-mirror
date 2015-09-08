From: Jeff King <peff@peff.net>
Subject: Re: Bug: git-upload-pack will return successfully even when it can't
 read all references
Date: Tue, 8 Sep 2015 18:06:11 -0400
Message-ID: <20150908220611.GE24159@sigill.intra.peff.net>
References: <CACBZZX6ZYDEPrQorg=pVh734ua+x55SYoKKvSZ_h0GQaR=m+8w@mail.gmail.com>
 <20150908065347.GG26331@sigill.intra.peff.net>
 <CACBZZX6Ag5pjx_AhS_aN=rvJBcy+Nh+PXfdeEqxFdgxvL3NMbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Duy =?utf-8?B?Tmd1eeG7hW4=?= <pclouds@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 09 00:06:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZR1t-0007MR-O9
	for gcvg-git-2@plane.gmane.org; Wed, 09 Sep 2015 00:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740AbbIHWGP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Sep 2015 18:06:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:56487 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752643AbbIHWGO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2015 18:06:14 -0400
Received: (qmail 19611 invoked by uid 102); 8 Sep 2015 22:06:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Sep 2015 17:06:13 -0500
Received: (qmail 25977 invoked by uid 107); 8 Sep 2015 22:06:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Sep 2015 18:06:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Sep 2015 18:06:11 -0400
Content-Disposition: inline
In-Reply-To: <CACBZZX6Ag5pjx_AhS_aN=rvJBcy+Nh+PXfdeEqxFdgxvL3NMbw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277528>

On Tue, Sep 08, 2015 at 02:16:03PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> I wonder if --upload-pack=3D"GIT_REF_PARANOIA=3D1 git-upload-pack" sh=
ould
> be the default when running fetch if you have --prune enabled. There'=
s
> a particularly bad edge case now where if you have permission errors
> on the master repository and run --prune on your backup along with a
> --mirror clone to mirror the refs, then when you have permission
> issues you'll prune everything from the backup.
>=20
> But yeah, a proper fix needs protocol v2. Because among other things
> that --upload-pack hack will only work for ssh, not http.

Right. There is no real way to flip the flag from the client side,
because we cannot reliably communicate it. Once we have such a
mechanism, it might actually make sense to _always_ flip on paranoia.
That is, we would rather an operation fail and be retried with in a
"loose" mode explicitly. That's safer. It's less convenient when you
have a broken repo, but surely that's the exception, right?

-Peff
