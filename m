From: Jeff King <peff@peff.net>
Subject: Re: Git commit generation numbers
Date: Fri, 15 Jul 2011 20:42:32 -0400
Message-ID: <20110716004232.GB32230@sigill.intra.peff.net>
References: <69e0ad24-32b7-4e14-9492-6d0c3d653adf@email.android.com>
 <20110714203141.GA28548@sigill.intra.peff.net>
 <CA+55aFyDzr+SfgSzWMr9pQuQUXTw9mcjZ-00NZof74PKZzbGPA@mail.gmail.com>
 <20110715074656.GA31301@sigill.intra.peff.net>
 <CA+55aFzS3KDNvKt-dXvYpuAQwFwD3+GCj8y8bRQCycPvrynT8Q@mail.gmail.com>
 <20110715194807.GA356@sigill.intra.peff.net>
 <CA+55aFx0KyAZRsy7gZ3Z4woWC-uWcLu11gcUrR+9MJR5NOSkrA@mail.gmail.com>
 <CA+55aFzE-okH9gaEyuSFdorK-7v3odpsk65ZTqCMHFz80n65ug@mail.gmail.com>
 <CA+55aFwpVoqK7TaG0R3JJO07eOyWQ9pR1sHUGBQt0kmM0vk2bw@mail.gmail.com>
 <CA+55aFwSgYYaQ8gTQmCw6SNMyr-bz5rJPr0o9xoog-1aCqb5rA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jul 16 02:42:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qhsxr-0002b4-49
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jul 2011 02:42:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018Ab1GPAmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 20:42:35 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45575
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751739Ab1GPAme (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 20:42:34 -0400
Received: (qmail 29873 invoked by uid 107); 16 Jul 2011 00:43:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 15 Jul 2011 20:43:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jul 2011 20:42:32 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFwSgYYaQ8gTQmCw6SNMyr-bz5rJPr0o9xoog-1aCqb5rA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177247>

On Fri, Jul 15, 2011 at 04:36:40PM -0700, Linus Torvalds wrote:

> On Fri, Jul 15, 2011 at 4:16 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I have fewer branches than tags, but I get something similar for "git
> > branch --contains":
> 
> The time-based heuristic does seem to be important. If I just remove
> it, I get increasingly long times for things that aren't contained in
> my branches.
> 
> And in fact, I think that is why the code used the merge-base helper
> functions - not because it wanted merge bases, but because the merge
> base stuff will work from either end until it decides things aren't
> relevant any more. Because *without* the time-based heuristics, the
> trivial "is this a descendant" algorithm ends up working very badly
> for the case where the target doesn't exist in the branches. Examples
> of NOT having a date-based cut-off, but just doing the straightforward
> (non-merge-base) ancestry walk:
> 
>   time ~/git/git branch --contains v2.6.12
>   real	0m0.113s
> 
>   [torvalds@i5 linux]$ time ~/git/git branch --contains v2.6.39
>   real	0m3.691s

Yes, exactly. That is why my first patch (which goes to a recursive
search), takes about the same amount of time as "git rev-list --all"
(and I suspect your 3.691s above is similar). And then the second one
drops that again to .03s.

I think you are simply recreating the strategy and timings I have posted
several times now.

-Peff
