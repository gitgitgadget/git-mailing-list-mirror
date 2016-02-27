From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fetch-pack: fix unadvertised requests validation
Date: Sat, 27 Feb 2016 17:08:16 -0500
Message-ID: <20160227220816.GA17475@sigill.intra.peff.net>
References: <1456577034-6494-1-git-send-email-gabrielfrancosouza@gmail.com>
 <xmqqd1riggd7.fsf@gitster.mtv.corp.google.com>
 <20160227190712.GC12822@sigill.intra.peff.net>
 <20160227191943.GD12822@sigill.intra.peff.net>
 <CABaesJ+yNJ6_z=sFc+bDEPqDDsw9fkB5bYgxJaAkAMVqHNWwrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 23:08:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZn2K-0003Rp-NC
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 23:08:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756738AbcB0WIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 17:08:20 -0500
Received: from cloud.peff.net ([50.56.180.127]:50848 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755826AbcB0WIT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 17:08:19 -0500
Received: (qmail 8953 invoked by uid 102); 27 Feb 2016 22:08:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 27 Feb 2016 17:08:18 -0500
Received: (qmail 15578 invoked by uid 107); 27 Feb 2016 22:08:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 27 Feb 2016 17:08:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 27 Feb 2016 17:08:16 -0500
Content-Disposition: inline
In-Reply-To: <CABaesJ+yNJ6_z=sFc+bDEPqDDsw9fkB5bYgxJaAkAMVqHNWwrQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287731>

On Sat, Feb 27, 2016 at 05:28:55PM -0300, Gabriel Souza Franco wrote:

> On Sat, Feb 27, 2016 at 4:19 PM, Jeff King <peff@peff.net> wrote:
> > On Sat, Feb 27, 2016 at 02:07:12PM -0500, Jeff King wrote:
> >
> >> We expect whoever creates the "sought" list to fill in the name and sha1
> >> as appropriate. If that is not happening in some code path, then yeah,
> >> filter_refs() will not work as intended. But I think the solution there
> >> would be to fix the caller to set up the "struct ref" more completely.
> >>
> >> Gabriel, did this come from a bug you noticed in practice, or was it
> >> just an intended cleanup?
> 
> I was experimenting with uploadpack.hiderefs and uploadpack.allowTipSHA1InWant
> and couldn't get
> 
>         git fetch-pack $remote <sha1>
> 
> to work, and I traced the failure until that check. Reading more, I now see
> that currently it requires
> 
>        git fetch-pack $remote "<sha1> <sha1>"
> 
> to do what I want.

Ah, that makes sense. I do think the "<sha1> <sha1>" syntax is a bit
weird, and I think mostly because the pure-object fetch came much later
in git's life; at this point hardly anybody uses a manual fetch-pack.

It would probably make sense to "<sha1>" to set up the ref correctly.

> > I double-checked that the code for git-fetch does so. It's in
> > get_fetch_map()
> [...]
> 
> git fetch-pack doesn't use these code paths. I'll send a new patch
> shortly to allow
> bare sha1's in fetch-pack.

Right. Sounds like a good plan.

-Peff
