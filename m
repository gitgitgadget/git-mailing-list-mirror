From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH 2/2] push: --ignore-stale option
Date: Thu, 15 Dec 2011 12:47:11 -0500
Message-ID: <4EEA329F.1020201@xiplink.com>
References: <7vobvct58u.fsf@alter.siamese.dyndns.org> <20111215073816.GD1327@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 15 18:47:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbFOq-0001SV-Pw
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 18:47:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758995Ab1LORrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 12:47:16 -0500
Received: from smtp132.iad.emailsrvr.com ([207.97.245.132]:35905 "EHLO
	smtp132.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758942Ab1LORrP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 12:47:15 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp33.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id DCB0C305E1;
	Thu, 15 Dec 2011 12:47:14 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp33.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id A5276305CF;
	Thu, 15 Dec 2011 12:47:14 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20111124 Thunderbird/8.0
In-Reply-To: <20111215073816.GD1327@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187216>

On 11-12-15 02:38 AM, Jeff King wrote:
> 
> But I still see this as solving the wrong problem, and encouraging a
> dangerous workflow. Why are you using ":" to push matching branches if
> you don't want to push topic1? I think a much more likely scenario is:
> 
>   $ git clone <<origin>>
>   $ git checkout -b topic1 origin/topic1
>   $ work work work
>   $ : hmm, it's not ready yet
>   $ git checkout -b topic2 origin/topic2
>   $ work work work
>   $ : looking good, let's ship it!
>   $ git push  ;# we default to matching!
> 
> I.e., the user is not actually intending to push all matching branches,
> but does so accidentally because "matching" is the default. And they
> have accidentally just pushed non-ready work to topic1, which would
> happen even with --ignore-stale.
> 
> IOW, I am not convinced that people are actually consciously choosing
> the workflow you outlined above, and are instead interested in
> --ignore-stale as a convenient way of guessing which branches should be
> pushed during a matching push. But it's only a guess, and as I showed
> above, it can still cause problems. I think the right solution is to
> switch the default away from matching, which is the root cause of the
> confusion.

100% agree.

In my experience, people are confused by any magic that happens when a local
ref name matches a remote's ref name.  I find folks have a much easier time
with git once they embrace the notion that a remote's branches are distinct
from their local clone's, and that explicitly saying
	push origin <local>:<remote>
is the clearest way of making sure git does what you want.

It's convenient for advanced users to take advantage of the shortcuts any
ref-matching magic provides, but I find novice users tend to make mistakes as
often as not.

		M.
