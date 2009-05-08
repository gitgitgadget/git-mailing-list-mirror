From: Jeff King <peff@peff.net>
Subject: Re: Bug: 'git am --abort' can silently reset the wrong branch
Date: Fri, 8 May 2009 05:12:18 -0400
Message-ID: <20090508091218.GC29737@coredump.intra.peff.net>
References: <20090506191945.GG6325@blackpad> <20090508082826.GA29737@coredump.intra.peff.net> <7v7i0s0y03.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eduardo Habkost <ehabkost@raisama.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 08 11:12:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2M87-0005fR-SK
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 11:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757365AbZEHJMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 05:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756255AbZEHJMS
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 05:12:18 -0400
Received: from peff.net ([208.65.91.99]:38232 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754441AbZEHJMR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 05:12:17 -0400
Received: (qmail 17274 invoked by uid 107); 8 May 2009 09:12:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 08 May 2009 05:12:36 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 08 May 2009 05:12:18 -0400
Content-Disposition: inline
In-Reply-To: <7v7i0s0y03.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118594>

On Fri, May 08, 2009 at 02:01:16AM -0700, Junio C Hamano wrote:

> > Switching branches and clobbering some other branch
> > with --abort is just _one_ thing you can do to screw yourself. You could
> > also have been doing useful work on the _same_ branch, and that would
> > get clobbered by --abort.  However, I'm not sure if we have a good way
> > of telling the difference between "work which I did to try to get these
> > patches to apply, but which should be thrown away when I abort" and
> > "work which I did because I forgot I had an active git-am".
> 
> I think I've said this already, but honestly speaking, I think --abort
> should not do --reset at all, but just remove the $dotest directory.  Or
> perhaps introduce a --clear option to do so.

I assumed that people actually liked the current "reset" behavior, so I
didn't want to propose getting rid of it.  Personally, I hate it. So I
would be very happy to see it ripped out entirely, and then that neatly
solves the problem (i.e., it now errs on the side of not throwing away
work).

> What I sometimes see to my users happen is to try applying to the oldest
> integration branch the patch (the users think) ought to apply, see it fail
> to apply, switch to a bit newer branch and run "am" again (trusting that
> it will pick up the material from $dotest), repeat the above and then give
> up with "git am --abort".  I do not think anybody can offhand explain to
> which branch and to what state the command takes the user back to in such
> a situation without looking at what the code actually does X-<; even
> though I think it should take the user back to the original branch, I do
> not think that is what the code does.

No, the current code clobbers whatever is in the current HEAD with
ORIG_HEAD. So not only might you set another random branch back to the
originally am'd branch, but if you did a pull in between you can pick up
some random commit.

-Peff
