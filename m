From: Jeff King <peff@peff.net>
Subject: Re: Git 2.7.0 gitignore behaviour regression
Date: Wed, 6 Jan 2016 21:04:06 -0500
Message-ID: <20160107020406.GA9358@sigill.intra.peff.net>
References: <4B0F686D-3DF9-4E5D-971D-DB106C6573FD@mikemcquaid.com>
 <20160105150602.GA4130@sigill.intra.peff.net>
 <CACsJy8AQ9s4VkFn+TNJLD55xJc40+-54BTYbC4Os71uSkL1QSA@mail.gmail.com>
 <5E517AD0-CD4E-4F85-8FEB-89B7A0183967@mikemcquaid.com>
 <CACsJy8CvPqYGRXB845+4fHjkXH_kSAWG684CoxtWAnXE-gM6ag@mail.gmail.com>
 <CAPc5daX+uGQfKEteT2dqax-m9dR76Gkg1YeiFjVU9dsTqnHDmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Mike McQuaid <mike@mikemcquaid.com>,
	Git Mailing List <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@dwim.me>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 03:04:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGzwV-0000hS-Rz
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jan 2016 03:04:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246AbcAGCEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 21:04:30 -0500
Received: from cloud.peff.net ([50.56.180.127]:49710 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752163AbcAGCEK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2016 21:04:10 -0500
Received: (qmail 7735 invoked by uid 102); 7 Jan 2016 02:04:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 06 Jan 2016 21:04:09 -0500
Received: (qmail 455 invoked by uid 107); 7 Jan 2016 02:04:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 06 Jan 2016 21:04:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Jan 2016 21:04:06 -0500
Content-Disposition: inline
In-Reply-To: <CAPc5daX+uGQfKEteT2dqax-m9dR76Gkg1YeiFjVU9dsTqnHDmw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283464>

[+cc Carlos and Shawn for libgit2/JGit talk]

On Wed, Jan 06, 2016 at 10:58:37AM -0800, Junio C Hamano wrote:

> On Wed, Jan 6, 2016 at 2:03 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > Yeah.. it looks like libgit2's gitignore support was written new, not
> > imported from C Git, so behavior differences (especially in corner
> > cases) and even lack of some feature ("**" support comes to mind). For
> > isolated features like gitignore, perhaps we can have an option to
> > replace C Git code with libgit2 and therefore can test libgit2 against
> > C Git test suite. It could be a good start for libgit2 to invade C
> > Git. Not sure if anybody's interested in doing it though.

Yeah, libgit2 is in the difficult position of trying to hit a moving
target. There's a good chance that it _was_ the same as git's behavior
when it was written. :)

JGit is in the same boat, and I wouldn't be surprised if they don't
handle "**" either (I didn't check). Note that git inherited that
feature (and probably some others) by importing a GPLv2 version of
wildmatch. That certainly isn't an option for JGit (because it's not
pure Java), and probably not for libgit2 (which would need the wildmatch
authors to grant the linking exception).

> Yup, an area that is reasonably isolated from the remainder of the system like
> this might be a good starting point. But I suspect that the invasion needs to
> happen in the opposite direction in this particular case before it happens.
> That is, if libgit2's implementation does not behave like how we do, it needs to
> be fixed, possibly by discarding what they did and instead importing code from
> us. After the behaviour of libgit2 is fixed, we can talk about the
> invasion in the
> opposite direction.

Unfortunately, "importing code from us" is not so easy. :(

They'll either need to contact the wildmatch authors, or rewrite
wildmatch from scratch.

-Peff
