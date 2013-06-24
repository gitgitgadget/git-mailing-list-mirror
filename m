From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] push: give early feedback
Date: Mon, 24 Jun 2013 15:39:24 -0400
Message-ID: <20130624193924.GA27344@sigill.intra.peff.net>
References: <1372095662-24527-1-git-send-email-artagnon@gmail.com>
 <20130624182809.GA15296@sigill.intra.peff.net>
 <CALkWK0=d1wkKWngH+6gBd-2svj7r_tgC5=+zUbgJRDfUCzupSw@mail.gmail.com>
 <20130624185546.GA25306@sigill.intra.peff.net>
 <CALkWK0mEWkXpsaUtMLc4r6vufDdSSdsX_PARwmObCSPW1mgAmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 21:39:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrCbt-0002nw-Dy
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 21:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078Ab3FXTj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 15:39:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:41007 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750784Ab3FXTj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 15:39:27 -0400
Received: (qmail 5783 invoked by uid 102); 24 Jun 2013 19:40:29 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Jun 2013 14:40:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Jun 2013 15:39:24 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0mEWkXpsaUtMLc4r6vufDdSSdsX_PARwmObCSPW1mgAmQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228907>

On Tue, Jun 25, 2013 at 12:54:17AM +0530, Ramkumar Ramachandra wrote:

> Jeff King wrote:
> > Leaving aside the transport API for a minute, you are always going to
> > have this lack-of-information versus time problem. A refspec like ":"
> > says nothing particularly useful, but it can only be expanded once
> > contact is made with the other side (which is what takes time).
> 
> Right, and ':' is special in that aspect; it does not warrant slowing
> down the expansion of refs/heads/*, for instance.  Besides, I suspect
> ':' can be resolved much faster than using push --dry-run.

I think ":" (or "push.default=matching") is the only thing that needs to
actually contact the other side to decide which refs _might_ be pushed.
But to know which refs would _actually_ be pushed (and which ones would
be fast-forwards), you need to know where the remote refs are, which
involves contacting the other side.

In both cases, you could potentially fake it with remote-tracking refs,
if they are available (after all, that is what "git status" is reporting
with its ahead/behind counts, so there is certainly precedent). But it
is important to note that what you see in the preview is not necessarily
what is about to happen in the push, as we get new information on the
remote tips during the push.

> > Yes. I do not have any interest in such an interactive push, but the
> > point is that a potential first step to any confirmation scheme, no
> > matter what you want it to look like, is a hook. You don't seem to want
> > a confirmation scheme, though, due to the wait (and I cannot blame you,
> > as I would not want it either; but then I would not want the extra
> > refspec message you propose, either).
> 
> I'm trying to figure out how to determine what a push will do without
> actually pushing (or --dry-run, which is almost as expensive).  You
> might like to put that information in your prompt instead of stdout,
> but do you agree that the information is worth getting?

To me personally, no, it is not interesting. But that does not mean it
is not interesting to others. I didn't mean to dissuade you from
pursuing the topic, but rather only to qualify the my statements with "I
am probably not the user you are targeting with this feature".

-Peff
