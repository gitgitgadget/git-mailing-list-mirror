From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [3/5] Add http-pull
Date: Sun, 17 Apr 2005 14:49:11 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504171412350.30848-100000@iabervon.org>
References: <20050417181054.GB1461@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 20:46:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNElX-00074G-JH
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 20:45:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbVDQSs5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 14:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbVDQSs5
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 14:48:57 -0400
Received: from iabervon.org ([66.92.72.58]:55557 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261405AbVDQSsx (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 14:48:53 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DNEpT-00059c-00; Sun, 17 Apr 2005 14:49:11 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050417181054.GB1461@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 17 Apr 2005, Petr Baudis wrote:

> > Index: Makefile
> > ===================================================================
> > --- d662b707e11391f6cfe597fd4d0bf9c41d34d01a/Makefile  (mode:100644 sha1:b2ce7c5b63fffca59653b980d98379909f893d44)
> > +++ 157b46ce1d82b3579e2e1258927b0d9bdbc033ab/Makefile  (mode:100644 sha1:940ef8578cf469354002cd8feaec25d907015267)
> > @@ -35,6 +35,7 @@
> >  
> >  LIBS= -lssl -lz
> >  
> > +http-pull: LIBS += -lcurl
> >  
> >  $(PROG):%: %.o $(COMMON)
> >  	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
> 
> Whew. Looks like an awful trick, you say this works?! :-)
> 
> At times, I wouldn't want to be a GNU make parser.

Yup. GNU make is big on the features which do the obvious thing, even when
you can't believe they work. This is probably why nobody's managed to
replace it.

> > Index: http-pull.c
> > ===================================================================
> > --- /dev/null  (tree:d662b707e11391f6cfe597fd4d0bf9c41d34d01a)
> > +++ 157b46ce1d82b3579e2e1258927b0d9bdbc033ab/http-pull.c  (mode:100644 sha1:106ca31239e6afe6784e7c592234406f5c149e44)
> > +	url = malloc(strlen(base) + 50);
> 
> Off-by-one. What about the trailing NUL?

I get length(base) + "object/"=8 + 40 SHA1 + 1 for '/' and 1 for NUL = 50.

> I think you should have at least two disjunct modes - either you are
> downloading everything related to the given commit, or you are
> downloading all commit records for commit predecessors.
> 
> Even if you might not want all the intermediate trees, you definitively
> want the intermediate commits, to keep the history graph contignuous.
> 
> So in git pull, I'd imagine to do
> 
> 	http-pull -c $new_head
> 	http-pull -t $(tree-id $new_head)
> 
> So, -c would fetch a given commit and all its predecessors until it hits
> what you already have on your side. -t would fetch a given tree with all
> files and subtrees and everything. http-pull shouldn't default on
> either, since they are mutually exclusive.
> 
> What do you think?

I think I'd rather keep the current behavior and add a -c for getting the
history of commits, and maybe a -a for getting the history of commits and
their tress.

There's some trickiness for the history of commits thing for stopping at
the point where you have everything, but also behaving appropriately if
you try once, fail partway through, and then try again. It's on my queue
of things to think about.

	-Daniel
*This .sig left intentionally blank*

