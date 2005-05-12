From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Fri, 13 May 2005 03:09:54 +1000
Message-ID: <2cfc403205051210093e1a396d@mail.gmail.com>
References: <1895.10.10.10.24.1115890333.squirrel@linux1>
	 <3656.10.10.10.24.1115891188.squirrel@linux1>
	 <1115896713.22180.314.camel@tglx>
	 <3745.10.10.10.24.1115897090.squirrel@linux1>
	 <1115898230.11872.8.camel@tglx>
	 <20050512132922.GB20785@delft.aura.cs.cmu.edu>
	 <2cfc4032050512084426ea3d4d@mail.gmail.com>
	 <2cfc403205051208483132921@mail.gmail.com>
	 <2cfc403205051208506249c9aa@mail.gmail.com>
	 <20050512162023.GA14010@delft.aura.cs.cmu.edu>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu May 12 19:03:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWH4p-0005pU-Ck
	for gcvg-git@gmane.org; Thu, 12 May 2005 19:02:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbVELRKA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 13:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbVELRKA
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 13:10:00 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:16952 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262080AbVELRJ4 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 13:09:56 -0400
Received: by rproxy.gmail.com with SMTP id i8so85684rne
        for <git@vger.kernel.org>; Thu, 12 May 2005 10:09:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Gk/U2Rtn5qFsF9QDht/L3fukaNmM0OYLUTLN5ozY+8gCgFhxnluR8QmYeIiyu+gHC510tFWQuTZ9tFB2uEFg7+d57YjwPiHO83u+9D+1OCmlPDc3G3itW6XeFDdIqfKpMgDy4HTNqTxPiwcnexHbYvMmUxFhTWz5mCbXB48cyRQ=
Received: by 10.38.208.40 with SMTP id f40mr289958rng;
        Thu, 12 May 2005 10:09:54 -0700 (PDT)
Received: by 10.38.104.37 with HTTP; Thu, 12 May 2005 10:09:54 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <20050512162023.GA14010@delft.aura.cs.cmu.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 5/13/05, Jan Harkes <jaharkes@cs.cmu.edu> wrote:
> >
> > Ln
> > |     \
> > Ln-1  Fn
> > |         |
> > Ln-2  Fn-1
> > |       /
> > Ln-3
> 
> It breaks when Fn was a pull from Ln-1, and Ln was a fast-forward to Fn.
> Now the first parent is going to be Fn-1 and the history of the local
> repository after the fast forward warps to
> 
>     Fn (== Ln)
>     Ln-1
>     Ln-2
>     Fn-1
>     Ln-3
> 

Yep, you are right.

> Which I believe is exactly what Thomas wants to see in this case. I
> don't see how repoid's can be useful for this. It is a porcelain thing
> where you need to track what you have seen before. Anything else doesn't
> matter because most permutations of the history are perfectly valid
> since the Fn and Ln changes in reality occured in parallel and as a
> result can be arbitrarily interleaved.
> 

I may be wrong, but I don't think Thomas is interested in his own
repository. I think he is interested in the history of commits found
in any public repository. Therefore, he needs an algorithm that
doesn't rely on locally cached information.

In otherwords, at each point in the commit graph, what did the
committer consider as "foreign" changes that needed to be merged into
the "local" repository to progress the repository forward. He wants to
derive that order only from the information in the repository itself -
everyone given the same commit graph should reach the same conclusion
as to what the committer saw as local and foreign at the time of the
commit.

My previous algorithm was incorrect, but I suspect it could probably
be fixed with a 2-pass algorithm that marked any nodes in the path
between the merge base and the merge head as local and then ensured
that nodes marked that way are sorted after any nodes reached via
"foreign" paths.
-- 
homepage: http://www.zeta.org.au/~jon/
blog: http://orwelliantremors.blogspot.com/
