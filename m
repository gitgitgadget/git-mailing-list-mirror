From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] commit, status: #comment diff output in verbose mode
Date: Thu, 17 Mar 2011 03:37:19 -0400
Message-ID: <20110317073719.GJ11931@sigill.intra.peff.net>
References: <1299787140-21472-1-git-send-email-icomfort@stanford.edu>
 <20110310225233.GH15828@sigill.intra.peff.net>
 <7vvczq1o4l.fsf@alter.siamese.dyndns.org>
 <20110311012318.GB15377@sigill.intra.peff.net>
 <20110311053107.GB16605@sigill.intra.peff.net>
 <4D79E21A.3040007@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ian Ward Comfort <icomfort@stanford.edu>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Mar 17 08:44:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q07sQ-0004bP-7s
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 08:44:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128Ab1CQHoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 03:44:06 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40008
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752118Ab1CQHoF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 03:44:05 -0400
Received: (qmail 21396 invoked by uid 107); 17 Mar 2011 07:37:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 17 Mar 2011 03:37:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Mar 2011 03:37:19 -0400
Content-Disposition: inline
In-Reply-To: <4D79E21A.3040007@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169220>

On Fri, Mar 11, 2011 at 09:49:30AM +0100, Michael J Gruber wrote:

> > I do still think I prefer the "#" as comment lines, though. Editors
> > understand that concept pretty well. For example, one thing that happens
> > to me a lot is that I write a paragraph, then edit it, then ask the
> > editor to re-wrap it. Inevitably it buts against the "#" lines, and
> > those get re-wrapped, too. I could fix it, of course, but I don't bother
> > because the editor knows that the stuff on "#" lines should remain on
> > "#" lines. So as it is now, the git-status output gets scrambled, but I
> > don't have to care. With a special "# Lines below this one..." line, I
> > will have mangled it and get extra cruft in my commit message.
> 
> As long as we match for the first n characters of that line with n<60 or
> so the rewrapping will do no harm (assuming you leave it to start a new
> paragraph, i.e. "^#Lines..." stays "^#Lines...").

Yeah, that would work in my case.

> > But I admit that this is one pretty bizarre personal anecdote and might
> > not affect anyone else.
> 
> What affects me more is when when I track files in a different encoding
> (latin1, say), the diff triggers that encoding for vim and I end up with
> encoding issues for the commit message (which is supposed to be utf8)...

Yuck. You may be literally feeding different charsets into a single
buffer of the editor. The best you could do is something like:

  au BufNewFile,BufRead COMMIT_EDITMSG set fenc=utf-8

and then for an empty commit message, vim will read in the latin1, and
then convert it to utf-8 on output. You will not have munged the "diff"
line, so git will still recognize it and remove everything after. But if
you are amending, then you will feed it a utf-8 commit message along
with a latin1 diff. And vim will screw that up when reading it in.

-Peff
