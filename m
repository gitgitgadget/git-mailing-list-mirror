From: Jeff King <peff@peff.net>
Subject: Re: Breaking "git status" (was Re: [PATCH 5/5] shortstatus: a new
 command)
Date: Thu, 6 Aug 2009 12:42:47 -0400
Message-ID: <20090806164247.GA1073@coredump.intra.peff.net>
References: <1249463746-21538-1-git-send-email-gitster@pobox.com>
 <1249463746-21538-2-git-send-email-gitster@pobox.com>
 <1249463746-21538-3-git-send-email-gitster@pobox.com>
 <1249463746-21538-4-git-send-email-gitster@pobox.com>
 <1249463746-21538-5-git-send-email-gitster@pobox.com>
 <1249463746-21538-6-git-send-email-gitster@pobox.com>
 <20090806153339.GC1970@coredump.intra.peff.net>
 <7vljlwnc6j.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 18:43:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ63Q-0007Bp-PX
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 18:43:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756128AbZHFQmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 12:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756052AbZHFQmw
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 12:42:52 -0400
Received: from peff.net ([208.65.91.99]:47147 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753275AbZHFQmv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 12:42:51 -0400
Received: (qmail 311 invoked by uid 107); 6 Aug 2009 16:45:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 06 Aug 2009 12:45:02 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Aug 2009 12:42:47 -0400
Content-Disposition: inline
In-Reply-To: <7vljlwnc6j.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125091>

On Thu, Aug 06, 2009 at 09:23:48AM -0700, Junio C Hamano wrote:

> As I said, this was more of technology demonstration with an iffy UI.
> 
> I've been wondering if this should be "git status -T" (a la "ls-files -t",
> but nice short-and-sweet -t is taken for rarely used --template).

If the output format is the only change, then that probably makes sense,
but I think there is a desire for a command that is more substantially
different.

> Here is a possible transition plan.  I am not married to it, but throwing
> it out as a discussion starter:
> 
>  * Introduce "git commit --dry-run", that takes place of the current
>    "git status".
> 
>    We will keep "git commit --dry-run" forever so that people can simply
>    do a "s/git status/git commit --dry-run/" to keep their own scripts
>    that currently run "git status" before deciding to run "git commit" (or
>    runs their own re-implementation of "git commit") working.

That makes sense.

>  * Introduce "status.traditional" configuration.  In 1.6.5
> 
>    - When set to true, "git status" behaves as "git commit --dry-run";
> 
>    - When set to false, "git status" uses a new semantics (TBD);
> 
>    - When unconfigured, the user gets a big incompatibility warning.
> 
>    and in 1.7.0, we will flip the default (i.e. unconfigured case) to
>    false.

I wonder if introducing such a configuration option is not going to
cause more confusion in the long run than simply switching. As a
script-writer, you are not helping me at all because I can't make any
assumptions about how the user has set the variable.

I guess you are helping those who want to keep "git status" as-is
forever for their own typing. I'm not sure that such people exist, but I
guess it is better to be conservative.

>  * Implement "git status" that is not a preview of "git commit".  Its new
>    semantics would include:
> 
>    - Reject any parameter that traditional "git status" ignored (i.e. -m);
> 
>    - Pathspecs are not about "git commit -o" anymore.  They are path
>      limiters.
> 
>    - One of the options, -t, gives the "shortstatus".

Makes sense.

> If we go a route like this, we do not want to add "shortstatus" as a
> standalone command.

It may make sense to do it anyway, just to give a playground for people
to try out and refine the new interface. In other words, do:

  - introduce shortstatus (or newstatus, or whatever you want to call
    it)

  - wait a few cycles for it to prove itself

  - proceed with transition plan you described above

  - explain transition as "status is now newstatus, old status is now
    commit --dry-run".

-Peff
