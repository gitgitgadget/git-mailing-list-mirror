From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Thu, 12 May 2005 12:20:23 -0400
Message-ID: <20050512162023.GA14010@delft.aura.cs.cmu.edu>
References: <1895.10.10.10.24.1115890333.squirrel@linux1> <1115890792.22180.306.camel@tglx> <3656.10.10.10.24.1115891188.squirrel@linux1> <1115896713.22180.314.camel@tglx> <3745.10.10.10.24.1115897090.squirrel@linux1> <1115898230.11872.8.camel@tglx> <20050512132922.GB20785@delft.aura.cs.cmu.edu> <2cfc4032050512084426ea3d4d@mail.gmail.com> <2cfc403205051208483132921@mail.gmail.com> <2cfc403205051208506249c9aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 12 18:14:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWGJC-0006SC-PA
	for gcvg-git@gmane.org; Thu, 12 May 2005 18:13:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbVELQUm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 12:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbVELQUm
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 12:20:42 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:62892 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S262076AbVELQU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 12:20:26 -0400
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 3.36 #1 (Debian))
	id 1DWGQB-0003uE-00; Thu, 12 May 2005 12:20:23 -0400
To: jon@blackcubes.dyndns.org
Mail-Followup-To: jon@blackcubes.dyndns.org,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2cfc403205051208506249c9aa@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, May 13, 2005 at 01:50:50AM +1000, Jon Seymour wrote:
> On 5/12/05, Jan Harkes <jaharkes@cs.cmu.edu> wrote:
> > On Thu, May 12, 2005 at 01:43:50PM +0200, Thomas Gleixner wrote:
> > ....
> > Your examples break if you consider additional merges where M syncs up a
> > couple of times (f.i. at Rn-2) before M is merged back into R.
...
> If committers always follow the convention that their previous local
> commit is nominated as the first (local) parent in the commit and
> commits from foreign repositories are listed after the first parent,
> can the chain of "local" parents be an effective proxy for repoid?
> 
> Consider first a graph where there are no more than 2 parents in a merge
> 
> Ln
> |     \
> Ln-1  Fn
> |         |
> Ln-2  Fn-1
> |       /
> Ln-3

It breaks when Fn was a pull from Ln-1, and Ln was a fast-forward to Fn.
Now the first parent is going to be Fn-1 and the history of the local
repository after the fast forward warps to

    Fn (== Ln)
    Ln-1
    Ln-2
    Fn-1
    Ln-3

And adding repoids doesn't help a bit. However if the local repo kept a
history of what the user has seen previously, it can be linearized
consistently. The history file would contain Ln-3...Ln-1 before the
fast-forward and would add Fn-1,Fn. We would end up with a history that
looks like,

    Fn (== Ln)
    Fn-1
    Ln-1
    Ln-2
    Ln-3

Which I believe is exactly what Thomas wants to see in this case. I
don't see how repoid's can be useful for this. It is a porcelain thing
where you need to track what you have seen before. Anything else doesn't
matter because most permutations of the history are perfectly valid
since the Fn and Ln changes in reality occured in parallel and as a
result can be arbitrarily interleaved.

In fact anyone else who branched at Ln-3 and merges again at Ln doesn't
really care in what order changes in the F and L branches occurred, only
that all modifications are included.

Jan

