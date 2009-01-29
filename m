From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Jan 2009, #07; Wed, 28)
Date: Wed, 28 Jan 2009 23:02:54 -0500
Message-ID: <20090129040254.GD11836@coredump.intra.peff.net>
References: <7vwscej26i.fsf@gitster.siamese.dyndns.org> <20090129035138.GC11836@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 05:05:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSO9F-0007hq-Ol
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 05:05:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753313AbZA2EC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 23:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753249AbZA2EC7
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 23:02:59 -0500
Received: from peff.net ([208.65.91.99]:32945 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753166AbZA2EC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 23:02:58 -0500
Received: (qmail 28598 invoked by uid 107); 29 Jan 2009 04:03:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 28 Jan 2009 23:03:06 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Jan 2009 23:02:54 -0500
Content-Disposition: inline
In-Reply-To: <20090129035138.GC11836@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107627>

On Wed, Jan 28, 2009 at 10:51:38PM -0500, Jeff King wrote:

> But:
> 
>   $ (cd child && git pull)
>   You asked me to pull without telling me which branch you
>   want to merge with, and 'branch.master.merge' in
>   ...
> 
> So it's not quite seamless. The problem is that we're not setting up the
> branch.master.* config on the empty clone. Nor do we set up
> refs/remotes/origin/HEAD.

Hrm. I was thinking we checked out "master" as a branch yet to be born,
but of course that doesn't work because we don't even know that the name
"master" exists on the other side (to do that, we would need an
extension to transmit symref information for a ref yet to be born).

We could always assume the remote side is going to eventually put
content on "master" (we know they aren't using another branch _now_, or
the repo wouldn't be empty, so we are just guessing they will follow the
usual convention). That feels a bit hack-ish, though.

So the current behavior is probably sane. But it is not obvious to a
user how to extend their repo one the upstream isn't empty. Maybe the
"empty repo" warning could mention "git fetch && git checkout -b master
origin/master" (which is the most obvious way I can think of)?

-Peff
