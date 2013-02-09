From: Jeff King <peff@peff.net>
Subject: Re: segfault for git log --graph --no-walk --grep a
Date: Fri, 8 Feb 2013 19:27:10 -0500
Message-ID: <20130209002710.GA5570@sigill.intra.peff.net>
References: <201302090052.22053.thom311@gmail.com>
 <7vsj56xsg5.fsf@alter.siamese.dyndns.org>
 <7vobfuxrns.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Haller <thom311@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 01:27:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3yI4-0007VD-1b
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 01:27:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947402Ab3BIA1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 19:27:13 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42665 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947333Ab3BIA1M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 19:27:12 -0500
Received: (qmail 1843 invoked by uid 107); 9 Feb 2013 00:28:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 08 Feb 2013 19:28:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Feb 2013 19:27:10 -0500
Content-Disposition: inline
In-Reply-To: <7vobfuxrns.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215831>

On Fri, Feb 08, 2013 at 04:22:15PM -0800, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Thomas Haller <thom311@gmail.com> writes:
> >
> >> it happens in file revision.c:2306 because "commit->buffer" is zero:
> >>
> >>                 retval = grep_buffer(&opt->grep_filter,
> >>                                      commit->buffer, strlen(commit->buffer));
> >
> > I think this has been fixed at be5c9fb9049e (logmsg_reencode: lazily
> > load missing commit buffers, 2013-01-26); I haven't merged it to any
> > of the maintenance releases, but the tip of 'master' should have it
> > already.
> 
> Ah, no, this shares the same roots as the breakage the said commit
> fixed, and the solution should use the same idea, but not fixed.

Yeah, I think this needs separate treatment. However, this is a perfect
example of the "case-by-case" I mention in the final two paragraphs
there.

What's the right encoding to be grepping in? The original, what we will
output in, or even something else? IOW, I wonder if this should be using
logmsg_reencode in the first place (the obvious reason not to want to do
so is speed, but logmsg_reencode is written to only have an impact in
the case that we do indeed need to reencode).

-Peff
