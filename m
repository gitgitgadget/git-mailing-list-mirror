From: eschvoca <eschvoca@gmail.com>
Subject: Re: How do I clear the directory cache
Date: Fri, 21 Oct 2005 16:40:07 -0400
Message-ID: <2b05065b0510211340y9551767i53fe53c0dc14460a@mail.gmail.com>
References: <2b05065b0510170720n5333f03l1941e84c1288fc5d@mail.gmail.com>
	 <20051020085931.GW30889@pasky.or.cz>
	 <2b05065b0510202023i62ab7c03uea1381d76535dcc7@mail.gmail.com>
	 <20051021105235.GF30889@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 22:41:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ET3gU-0005nx-4h
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 22:40:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965155AbVJUUkK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 16:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965156AbVJUUkK
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 16:40:10 -0400
Received: from qproxy.gmail.com ([72.14.204.198]:55455 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965155AbVJUUkI convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2005 16:40:08 -0400
Received: by qproxy.gmail.com with SMTP id m21so67019qbe
        for <git@vger.kernel.org>; Fri, 21 Oct 2005 13:40:07 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PhkQFvarQ9sbY9vYzqBWBFnxgtNIfhjZMWehLe1gSkVdfVZQBR/NRyMI7g2sOUskbWiIw/sQQN9AVDwxJTFwatqe3DFpaEDGaG0czAZwJgrwAj8gBphPgjsbwfDT7u6BmwJrg5IfYrCbbQPe8k27Q3UcJlNdcsWjyNFyIbsGC9M=
Received: by 10.65.206.6 with SMTP id i6mr2306795qbq;
        Fri, 21 Oct 2005 13:40:07 -0700 (PDT)
Received: by 10.65.44.2 with HTTP; Fri, 21 Oct 2005 13:40:07 -0700 (PDT)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051021105235.GF30889@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10446>

On 10/21/05, Petr Baudis <pasky@suse.cz> wrote:
> Dear diary, on Fri, Oct 21, 2005 at 05:23:28AM CEST, I got a letter
> where eschvoca <eschvoca@gmail.com> told me that...
> > Yes, "cg-reset --adds-removals" is what I want (how do I do this with
> > pure git?).
>
>         git-read-tree HEAD
>         git-update-cache --refresh

Thanks, it solves my problem.

> > I would like to clear/reset the index because I've screwed it all up.
> > I don't think I can do as you suggested because of the way I got into
> > this mess.
> >
> > I'm using git/cogito to version control my hard drive and I've been
> > gradually adding more entries into the .gitignore file because some
> > files change too frequently or I don't want them backed up.  The OS
> > modified a bunch of files, I cg-rm'd 1/4 of them, then I changed my
> > mind and added them back, also did some genuine cg-adds, etc. and now
> > I'm all confused (it's a whole hard drive).
>
> Well, cg-status should show you what you effectively did, and then you
> could just do something like:
>
>         cg-status -w | grep ^D | tr '\n' '\0' | xargs -0 cg-add
>         cg-status -w | grep ^A | tr '\n' '\0' | xargs -0 cg-rm

This is the right idea (and what I like to do) but you would have to
remove the status flag (1st 2 chars) otherwise it gets included as part
of the filename.  I think most shells have some pretty small command
length limits so i prefer to pipe into a loop rather than use xargs.

> > If other people are interested in doing this I can pass on the lessons
> > I learned.
> >
> > What I found it git is amazingly fast!  cg-status only takes a few
> > seconds.  I think there are some problems if you try to do:
> >
> > cd /
> > cg-add -r usr
> > cg-commit -m "take a long break"
> >
> > It seems that cg-add-ing and cg-commit-ing smaller chunks is faster
> > than one big chunk.
>
> Interesting. I cannot spot anything which would bog it down in Cogito.
> Is both cg-add and cg-commit significantly slower? (That is, if it takes
> longer than sum of the smaller chunks.) Perhaps it's a cache issue, not
> everything from the chunk fits into your cache during cg-add, so
> cg-commit has to reread it from the disk.

I'll do some tests when I have time; currently this is just a gut feeling.

> > I think commands for the following should be added to cogito:
>
> I'd prefer:
>
> > cg-status -<status_flag>  # list files with given status flag (without
> > status flag in column 1)
> >   git-ls-files [--others|--deleted|etc] --exclude-per-directory=/.gitignore
>
> All right, this might be useful. Implemented as cg-status -s '?' and such,
> thanks for the idea.

This is great but it would be easier to work with if there was another
switch to turn off printing
out the status flag.  Otherwise you have to 'sed' or 'awk' out the
status flag which is a pain, especially when files have spaces in
them.

> > cg-add [-r] -<status_flag> # add files with a given status flag
> >   git-ls-files [--others|--deleted|etc]
> > --exclude-per-directory=/.gitignore | while read i; do cg-add "$i;
> > done
> >
> > cg-rm [-r] -<status_flag> # you get the idea.
> >
> > cg-addremove  # recursively add new files, remove deleted files
>
> I implemented the cg-reset --adds-removes option, but I don't feel
> comfortable with the cg-add change - just -r would be enough to add new
> files, and if you are in mess big enough, you can just cg-reset. It
> would be useful to make cg-rm symmetric to cg-add, though. Then you
> could do just
>
>         cg-add -r . && cg-rm -r .
>
> and it would be equivalent to cg-addremove.

Yes, that would be better -- more modular without being too much extra.

Also, the "cg-add -r" exits when a file is bad.  It would have saved
me a few hours if it would keep not exit on a failure (and add the bad
files to .gitignore ... but that is probably asking for too much).

> > I use "while read i" so it will work with spaces in filenames.
>
> And break with leading spaces unless you modified $IFS properly. Note
> that those people having filenames starting by spaces are either
> seriously sick or script kiddies who just rooted you (or warez kiddies
> on your FTP server with anonymously-writable incoming).

Yeah, spaces are a nuisance and quite useless at the beginning of a
file...CrossOver Office had some spaces in directory names.
