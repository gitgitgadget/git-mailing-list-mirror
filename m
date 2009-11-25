From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] grep: --full-tree
Date: Wed, 25 Nov 2009 16:00:34 -0500
Message-ID: <20091125210034.GC18487@coredump.intra.peff.net>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org>
 <20091125203922.GA18487@coredump.intra.peff.net>
 <7viqcytjic.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 22:00:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDOyf-0001oe-6G
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 22:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759771AbZKYVA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 16:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759762AbZKYVA0
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 16:00:26 -0500
Received: from peff.net ([208.65.91.99]:40704 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755515AbZKYVA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 16:00:26 -0500
Received: (qmail 16264 invoked by uid 107); 25 Nov 2009 21:04:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 25 Nov 2009 16:04:57 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Nov 2009 16:00:34 -0500
Content-Disposition: inline
In-Reply-To: <7viqcytjic.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133674>

On Wed, Nov 25, 2009 at 12:52:11PM -0800, Junio C Hamano wrote:

> So I think the posted patch alone without changing anything else would be
> the approach to give the most benefit with the least impact to existing
> users, at least for now.

Yes, I meant to say in my original message but forgot to: I think
--full-tree is an important first step, no matter what happens next. It
gives people a way to do what they want without typing the right number
of ".."s, and it opens up --no-full-tree if the default changes later.

But I do worry about it being a command-line option. You are asking the
user to remember to type --full-tree every time. I can't count the
number of times I have been in a subdirectory and done "git grep foo",
spent some time analyzing and doing something with the results, only for
my palm to hit my forehead when I realize that I was missing half of the
results I wanted. In other words, I not only have to remember to use the
option, but when I forget, I may get punished very annoyingly by results
which are subtly different from what I want.

So I am in favor of taking it further, but even if we do, the
command-line option is the right thing to be doing _now_.

> "git grep -e frotz .." will work in your "from linux/subproject/t look for
> everywhere in linux/subproject", but if "/t" part were much longer and
> variable (iow you need to chdir around inside linux/subproject to scratch
> your itch) compared to "linux/subproject" part that is much shorter and
> static (to your work), it may make sense to give us a mode to specify
> pathspec from the top of the tree.
> 
>     $ cd linux/subproject
>     $ cd foo
>     $ cd bar
>     $ cd baz
>     $ git grep --absolute-pathspec -e frotz -- linux/subproject
> 
> As "git grep" never takes absolute paths, we _might_ be able to also do
> 
>     $ git grep -e frotz -- /linux/subproject
> 
> to achieve the same.

Certainly I think that would be an improvement. But again, it suffers
from the "you must remember to do this" as above. I really want "git
grep" to Do What I Mean.

I have to wonder: is "git grep" really plumbing or porcelain? It is
really just a wrapper for

  git ls-files | xargs grep

Do people actually use it in their scripts? Should they be?

-Peff
