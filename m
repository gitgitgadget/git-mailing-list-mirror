From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Core and Not-So Core
Date: Wed, 11 May 2005 10:50:00 +1000
Message-ID: <2cfc403205051017505b57da72@mail.gmail.com>
References: <2cfc40320505100800426d38ca@mail.gmail.com>
	 <20050510225235.GD26384@pasky.ji.cz>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed May 11 02:43:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVfJV-0002jD-Oj
	for gcvg-git@gmane.org; Wed, 11 May 2005 02:43:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbVEKAuL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 20:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbVEKAuL
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 20:50:11 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:44993 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261862AbVEKAuA convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2005 20:50:00 -0400
Received: by rproxy.gmail.com with SMTP id j1so21530rnf
        for <git@vger.kernel.org>; Tue, 10 May 2005 17:50:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r50rBJ9lk4Xl0bnkzMkN+8OGzIpTHXc5bSEdlxryGcK2l05FqSrOdKA4cX4f7E3vpBgXrZadd7xFl/Qsh8LoWeDtD5uQosZbT4VhAPwsJGSwbs9q6OMUGcnixeMDUwaZootvnw90q5meAXTQPLICcbk+9AKTwkO3jtXDqMqFNZM=
Received: by 10.38.82.65 with SMTP id f65mr15730rnb;
        Tue, 10 May 2005 17:50:00 -0700 (PDT)
Received: by 10.38.104.59 with HTTP; Tue, 10 May 2005 17:50:00 -0700 (PDT)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050510225235.GD26384@pasky.ji.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 5/11/05, Petr Baudis <pasky@ucw.cz> wrote:
> Dear diary, on Tue, May 10, 2005 at 05:00:33PM CEST, I got a letter
> where Jon Seymour <jon.seymour@gmail.com> told me that...
> 
> Yes. And that's how it should be - the directory cache is just that - a
> _cache_. 

No argument there.

>  So unlike the objects database which has well-defined format and is
> supposed to be "public", you should view the directory cache as internal
> git tools' structure. If you want to mess with it too, either use the
> proper level of abstraction and call the git tools, or don't mess with
> it at all. And you need to care about it only if you want the git tools
> working on the same tree properly too - so in that case use the git
> tools too.

I agree in principle, though I'd like users to be able to easily
switch between the Eclipse and git tools view of the workspace if they
want to - who am I to say how a user should work? Eclipse does this
kind of thing quite well with CVS precisely because it shares the
workspace structures with the CVS command line tools rather than
"re-inventing" the wheel. Yes, separation of concerns has been lost
(two implementations of a CVS client), but the big win is that the
tools behave like the user wants them to behave.

The trickiest case here is when the user switches between toolsets
mid-merge. I guess what I can do is this:

user switch from eclipse -> to git-tools:
    1. blow away existing git tools index
    2. use git-read-tree to repeat the merge executed in eclipse (my
workspace will track parents)
    3. use git-update-cache --add/--remove to reflect merge actions
that have occurred since the workspace deviated from the HEAD.

Alternatively, I can just make Eclipse reflect cache changing actions
out onto the git-tools, via an exec of those tools, as and when they
occur.

Making use of the git tools index going the other way isn't so easy to
achieve because the git tools workspace as it stands doesn't track the
merges that have occurred (i.e. which parents were used to form the
current cache). However, that's not necessarily a big problem. I just
rebuild my "cache" from scratch based on the merges I know about and
treat every other difference from the HEAD as a user edit to the
workspace.
 
> 
> From your arguments, it's not clear to me what really is the big
> problem with the git tools. They are _designed_ for automatic use
> instead of human interaction - you can perceive them just as methods
> with funny (but actually friendly to your programs) calling convention.
> 

I am not really arguing that there is a big problem with the existing
git tools. However, what I am arguing is that the existing workspace
tools are just one way to manage the workspace (Eclipse might be
another, as an example) and it would be helpful to keep this in mind,
particularly when/if libification ever happens.

jon.
