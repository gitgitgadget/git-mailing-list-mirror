From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] sha1_file: use strncmp for string comparison
Date: Mon, 30 Jun 2014 12:45:17 -0400
Message-ID: <20140630164517.GA11906@sigill.intra.peff.net>
References: <53AED59B.1020209@web.de>
 <CACsJy8B_DAjLRcMe4ys2LGkLOcKuW-PL_WNHyFB8Ry3Uv38LCw@mail.gmail.com>
 <53AFA775.1090900@web.de>
 <53AFAA89.6050200@web.de>
 <20140630134317.GB14799@sigill.intra.peff.net>
 <CACsJy8A5Dq6MP8kH7R3POSjXoJjYvWF695fKj1YgTdscF5xYxA@mail.gmail.com>
 <20140630142232.GC14799@sigill.intra.peff.net>
 <53B193B7.6020407@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 30 18:45:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1eho-0003rd-R4
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 18:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755259AbaF3QpT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jun 2014 12:45:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:53616 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751017AbaF3QpS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 12:45:18 -0400
Received: (qmail 6898 invoked by uid 102); 30 Jun 2014 16:45:18 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 30 Jun 2014 11:45:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Jun 2014 12:45:17 -0400
Content-Disposition: inline
In-Reply-To: <53B193B7.6020407@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252680>

On Mon, Jun 30, 2014 at 06:43:35PM +0200, Ren=C3=A9 Scharfe wrote:

> Am 30.06.2014 16:22, schrieb Jeff King:
> >On Mon, Jun 30, 2014 at 08:59:53PM +0700, Duy Nguyen wrote:
> >
> >>On Mon, Jun 30, 2014 at 8:43 PM, Jeff King <peff@peff.net> wrote:
> >>>>diff --git a/sha1_file.c b/sha1_file.c
> >>>>index 394fa45..8adab14 100644
> >>>>--- a/sha1_file.c
> >>>>+++ b/sha1_file.c
> >>>>@@ -1207,7 +1207,8 @@ static void prepare_packed_git_one(char *ob=
jdir, int local)
> >>>>               if (has_extension(de->d_name, ".idx")) {
> >>>>                       /* Don't reopen a pack we already have. */
> >>>
> >>>If we don't follow my suggestion above, we still have this
> >>>has_extension. This is a reimplementation of ends_with, isn't it? =
We can
> >>>probably drop it and just use ends_with.
> >>
> >>This calls for another patch if we just want to kill has_extension(=
)
> >>in favor of ends_with(). There are 12 call sites of it.
> >
> >Yes. Some of those would want to become ends_with, and some would
> >actually want to become strip_suffix. I'm working up a series now.
>=20
> NB: has_extension is almost the same as ends_with, but it also checks=
 if the
> string is longer than just the extension:
>=20
> 	ends_with("x", "x") =3D> 1
> 	has_extension("x", "x") =3D> 0

Thanks, I didn't notice that. I don't think the distinction is
important in any callers, but I'll double check.

-Peff
