From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] shortstatus v1
Date: Tue, 10 Feb 2009 13:10:52 -0500
Message-ID: <20090210181052.GA19634@coredump.intra.peff.net>
References: <1234227067-56666-1-git-send-email-tuncer.ayaz@gmail.com> <20090210110330.GB12089@coredump.intra.peff.net> <7vwsbynv0o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tuncer Ayaz <tuncer.ayaz@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 19:13:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWx79-0000ky-3h
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 19:13:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753851AbZBJSK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 13:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753434AbZBJSK4
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 13:10:56 -0500
Received: from peff.net ([208.65.91.99]:39591 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752457AbZBJSKz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 13:10:55 -0500
Received: (qmail 16188 invoked by uid 107); 10 Feb 2009 18:11:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 10 Feb 2009 13:11:11 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Feb 2009 13:10:52 -0500
Content-Disposition: inline
In-Reply-To: <7vwsbynv0o.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109286>

On Tue, Feb 10, 2009 at 07:58:47AM -0800, Junio C Hamano wrote:

> >   2. Why do staged changes get a letter marking what happened, but
> >      unstaged changes do not?
> 
> Bug?   FWIW, the original patch from October shows:
> 
>     M changed
> M   M changed-again
> M     changed-staged
>     D deleted
> D     deleted-staged
> 
> (where changed-again has both staged changes and further changes in the
> work tree).
> 
> The gap between these two are to show the rename similarity index, which
> we could do without.

OK, that makes more sense. And your example shows a good answer to my
earlier question: why is just sorting the output of the the three
commands (diff, diff --cached, and ls-files -o) not as nice. The answer
is that we need to actually combine lines when files are appear in
multiple places.

> The output mimicked what was in Shawn's "repo" tool announcement IIRC.
> 
> My patch was supposed to give interested parties hint to base a patch like
> Tuncer's on (I think this answers your last question, too).

I went back and read some of the background. I think having this work
with the wt-status machinery is reasonable, then. My concerns with
Tuncer's patch are still:

  - this should not be part of builtin-commit.c; it doesn't use any of
    the same code except that which has already been lib-ified in
    wt-status.[ch].

  - I don't think the "mini" status is really related to this. The novel
    thing here is collating the outputs into a single sorted list. But
    the "mini" output is not about that at all:

      1. It doesn't care about full output, so it should be able to exit
         early from the diff, avoid rename detection, etc, so that it is
         as quick as possible.

      2. It doesn't collate the output at all. It is about three
         separate symbols for the three separate lists.

-Peff




> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
