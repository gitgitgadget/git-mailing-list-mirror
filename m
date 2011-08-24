From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] submodule: Demonstrate known breakage during recursive
	merge
Date: Wed, 24 Aug 2011 22:27:22 +0200
Message-ID: <20110824202721.GF45292@book.hvoigt.net>
References: <680d2679c3275c01152500760311b5f96a93ea62.1314193375.git.brad.king@kitware.com> <20110824191438.GA45292@book.hvoigt.net> <7vty96obo9.fsf@alter.siamese.dyndns.org> <20110824194618.GD45292@book.hvoigt.net> <4E5558BB.4040307@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Wed Aug 24 22:27:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwK2r-0000Qq-7z
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 22:27:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752697Ab1HXU1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 16:27:25 -0400
Received: from darksea.de ([83.133.111.250]:42672 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751826Ab1HXU1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 16:27:24 -0400
Received: (qmail 5474 invoked from network); 24 Aug 2011 22:27:22 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 24 Aug 2011 22:27:22 +0200
Content-Disposition: inline
In-Reply-To: <4E5558BB.4040307@kitware.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180036>

On Wed, Aug 24, 2011 at 04:02:03PM -0400, Brad King wrote:
> On 8/24/2011 3:14 PM, Heiko Voigt wrote:
> > thanks for finding this subtle bug!
>
> Thanks for looking at it!
>
> On 8/24/2011 3:46 PM, Heiko Voigt wrote:
>> For the merge search we do not take the bases into
>> account so the outcome will not change.
>
> The test case creates history like this:
>
> >     b---bc
> >    / \ /
> >   o   X
> >    \ / \
> >     c---cb
>
> where b, c, bc, and cb all reference different submodule commits.
>
> Isn't the merge search asked to search for a descendant of "b:sub" and "c:sub"
> during the recursive part of the merge and then "bc:sub" and "cb:sub" during
> the primary merge?  Might those results be different?

The merge is quite simple. All it does is check whether both changes
base->a or base->b point forward in the submodule. Then it checks
whether a is contained in b or the other way around. This is the only
case in which it will succeed automatically.

Supposing you merge bc into cb:
If I understand the situation correctly, the above is done first with
a := cb:sub, b := bc:sub, base := b:sub and then another time with
base := c:sub.

For the suggestion part only bc and cb are taken into account. That is
we search for the first commit in the submodule refs which contains both
bc:sub and cb:sub.

>
> As for the UI part, I think the user would be interested only in the search
> results for the primary merge between HEAD and MERGE_HEAD.  Results from the
> intermediate merges might not make sense.

As stated above since bc:sub and cb:sub will not change in between two
searches the result for the suggestion will be the same. What I meant
was that the same result would be output twice (or more).

Cheers Heiko
