From: Jeff King <peff@peff.net>
Subject: Re: Additional plumbing commands
Date: Wed, 7 Jan 2015 03:04:09 -0500
Message-ID: <20150107080408.GA1301@peff.net>
References: <CA+SVznFFPED+ms=4abNpvNQx-nt6imDMJtYKuNBTTLzCJ547Vw@mail.gmail.com>
 <CAP8UFD1OZ1QjHRyNGVs0Vm52=Ue-ta1gBzNxLpX25NSCbtu9EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Charles Rudolph <charles.w.rudolph@gmail.com>,
	git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 09:07:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8lbE-0008KL-9J
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 09:04:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239AbbAGIEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 03:04:12 -0500
Received: from cloud.peff.net ([50.56.180.127]:59930 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751451AbbAGIEL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 03:04:11 -0500
Received: (qmail 15315 invoked by uid 102); 7 Jan 2015 08:04:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Jan 2015 02:04:11 -0600
Received: (qmail 19191 invoked by uid 107); 7 Jan 2015 08:04:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Jan 2015 03:04:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Jan 2015 03:04:09 -0500
Content-Disposition: inline
In-Reply-To: <CAP8UFD1OZ1QjHRyNGVs0Vm52=Ue-ta1gBzNxLpX25NSCbtu9EQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262128>

On Tue, Jan 06, 2015 at 06:37:34PM +0100, Christian Couder wrote:

> On Tue, Jan 6, 2015 at 5:05 PM, Charles Rudolph
> <charles.w.rudolph@gmail.com> wrote:
> > I am writing some higher level git commands for
> > https://github.com/Originate/git-town and would like some additional
> > plumbing commands that can tell me
> >
> > 1. is there a merge in progress?
> > 2. is there a rebase in progress?
> > 3. is there a cherry-pick in progress?
> > 4. are there unmerged paths?
> >
> > Currently the only way I know how to do this is with "git status" and
> > looking for specific text.
> 
> You may have a look at how "contrib/completion/git-prompt.sh" does it.
> [...]

The prompt code is rather long and knows a lot about the internal state
of $GIT_DIR. I do not think it would be a bad thing for git-status to
expose a machine-readable version of the state it discovers, and then at
least we can keep the logic in one place.

Charles, if you are interested in adding that, the wt_status_state code
in wt-status.c is the right place to start looking.

Though I think in many cases that discovering which state we are in is
only half the story that a caller wants. Knowing what each state _means_
and what operations are meaningful to perform is much trickier (e.g., if
we are in a rebase, you probably do not want to start a new rebase. But
is it wrong to cherry-pick?).

It would be nice if we could find a way to generalize in-progress
operations and what they mean for starting new operations, but that is
a much harder problem (if it is even possible at all).

-Peff
