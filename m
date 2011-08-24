From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] submodule: Demonstrate known breakage during recursive
	merge
Date: Wed, 24 Aug 2011 23:32:05 +0200
Message-ID: <20110824213205.GI45292@book.hvoigt.net>
References: <680d2679c3275c01152500760311b5f96a93ea62.1314193375.git.brad.king@kitware.com> <20110824191438.GA45292@book.hvoigt.net> <7vty96obo9.fsf@alter.siamese.dyndns.org> <20110824194618.GD45292@book.hvoigt.net> <4E5558BB.4040307@kitware.com> <20110824202721.GF45292@book.hvoigt.net> <4E5561D2.2080206@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Wed Aug 24 23:32:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwL3V-0006zP-SP
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 23:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753569Ab1HXVcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 17:32:08 -0400
Received: from darksea.de ([83.133.111.250]:50803 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752042Ab1HXVcH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 17:32:07 -0400
Received: (qmail 5629 invoked from network); 24 Aug 2011 23:32:05 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 24 Aug 2011 23:32:05 +0200
Content-Disposition: inline
In-Reply-To: <4E5561D2.2080206@kitware.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180044>

Hi,

On Wed, Aug 24, 2011 at 04:40:50PM -0400, Brad King wrote:
> On 8/24/2011 4:27 PM, Heiko Voigt wrote:
>>>>      b---bc
>>>>     / \ /
>>>>    o   X
>>>>     \ / \
>>>>      c---cb
> [snip]
>> Supposing you merge bc into cb:
>> If I understand the situation correctly, the above is done first with
>> a := cb:sub, b := bc:sub, base := b:sub and then another time with
>> base := c:sub.
>
> When merging bc and cb there are two merge bases: b and c.  The recursive
> merge strategy first performs a "virtual" merge between b and c and uses
> the result as a fictional merge base between bc and cb.  Currently the
> submodule merge search runs during the "virtual" merge and gives advice.
> Then it later dies while trying to search during the "real" merge.

But what happens if this "virtual" merge of b and c does not succeed
like in our case?

> After applying my patch, try this:
>
>  $ cd t && ./t7405-submodule-merge.sh --verbose
>  ...
>  Merging:
>  8cbd0fb cb
>  virtual top-bc
>  found 2 common ancestor(s):
>  f6b4d5a b
>  4d9cfab c
>    Merging:
>    f6b4d5a b
>    4d9cfab c
>    found 1 common ancestor(s):
>    a2ff72f a
>  warning: Failed to merge submodule sub (multiple merges found)
>   806049692f8921101f2e7223852e3bd74f7187c8: > Merge branch 'sub-c' into sub-bc
>   db70dfacda48ce55365256a58eaf89b7da87cbe7: > Merge branch 'sub-b' into sub-cb
>    Auto-merging sub
>    CONFLICT (submodule): Merge conflict in sub
>  fatal: --ancestry-path given but there are no bottom commits

Yeah I have seen this and it looked to me as if those two commits are
bc:sub and cb:sub since the commit message talks about c:sub merged into
bc:sub and vice versa.

> One can see that the advice given talks about merging "b:sub" and "c:sub"
> and the suggested commits are actually "bc:sub" and "cb:sub".  This advice
> is not useful to someone mergeing bc and cb.

In this case we should only output the advice of the last merge of
course. It will have the same result in this case though since the merge
of bc:sub and cb:sub still has just these two candidates.

Cheers Heiko
