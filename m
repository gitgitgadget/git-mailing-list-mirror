From: Franck <vagabon.xyz@gmail.com>
Subject: Re: [RFC] shallow clone
Date: Tue, 31 Jan 2006 10:00:16 +0100
Message-ID: <cda58cb80601310100o6ca1f0a3g@mail.gmail.com>
References: <7voe1uchet.fsf@assigned-by-dhcp.cox.net>
	 <43DF1F1D.1060704@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 31 10:00:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3rN7-0003yI-P8
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 10:00:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWAaJAT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 04:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbWAaJAS
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 04:00:18 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:55449 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750712AbWAaJAR convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 04:00:17 -0500
Received: by zproxy.gmail.com with SMTP id 14so1254649nzn
        for <git@vger.kernel.org>; Tue, 31 Jan 2006 01:00:17 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q+ahkBEkWgGnxpAULi4WbbjBeYuOkLCT5o8wKLSbWrcNkaVkD/S3QMZSiEONno4KK1Pt4cRyP6yWeOC/tRj8w0GCSJF2zsdjN9ggfkeVC6OxHihLhntCPS4m8OnZl3sQYB6y9qIpUjfrkGKLryoHgavaPtCWf7yi015MOYtD5Go=
Received: by 10.36.42.5 with SMTP id p5mr5555385nzp;
        Tue, 31 Jan 2006 01:00:16 -0800 (PST)
Received: by 10.36.49.12 with HTTP; Tue, 31 Jan 2006 01:00:16 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <43DF1F1D.1060704@innova-card.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15305>

2006/1/31, Franck Bui-Huu <fbh.work@gmail.com>:
> Junio C Hamano wrote:
> > Shallow History Cloning
> > =======================
> >
> > One good thing about git repository is that each clone is a
> > freestanding and complete entity, and you can keep developing in
> > it offline, without talking to the outside world, knowing that
> > you can sync with them later when online.
> >

could we be able to make a public repository from such repo ?

> > It is also a bad thing.  It gives people working on projects
> > with long development history stored in CVS a heart attack when
> > we tell them that their clones need to store the whole history.
> >

yeah and I haven't survive :)
I didn't notice that other people were asking for this feature, that's great !

> > There was a suggestion by Linus to allow a partial clone using a
> > syntax like this:

[snip]

> >
> > There are some issues.
> >
> > . In the fetch above to obtain everything after v2.6.14, and
> >   future runs of `git fetch origin`, if a blob that is in the
> >   commit being fetched happens to match what used to be in a
> >   commit that is older than v2.6.14 (e.g. a patch was reverted),
> >   `upload-pack` running on the other end is free to omit sending
> >   it, because we are telling it that we are up to date with
> >   respect to v2.6.14.  Although I think the current `rev-list
> >   --objects` implementation does not always do such a revert
> >   optimization if the revert is to a blob in a revision that is
> >   sufficiently old, it is free to optimize more aggressively in
> >   the future.
> >

oops, I wasn't aware of that. I still can resolve this issue by hand, no ?

> > . Later when the user decides to fetch older history, the
> >   operation can become a bit cumbersome.
> >

[snip]

> >
> > Design
> > ------
> >
> > First, to bootstrap the process, we would need to add a way to
> > obtain all objects associated with a commit.  We could do a new
> > program, or we could implement this as a protocol extension to
> > `upload-pack`.  My current inclination is the latter.

is the document in "Documentation/technical/pack-protocol.txt"
uptodate ? I can't find anything on multi_ack for example.

> >
> > When talking with `upload-pack` that supports this extension,
> > the downloader can give one commit object name and get a pack
> > that contains all the objects in the tree associated with that
> > commit, plus the commit object itself.  This is a rough
> > equivalent of running the commit walker with the `-t` flag.

[snip]

> >
> >
> > Anybody want to try?
> >

well, you made almost the job with your analysis, but I've never took
a look to git deep internals and with my lack of time, it would take
too much time...

Thanks
--
               Franck
