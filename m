From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git-send-pack segfaulting on DebianPPC (was: Re: cg-clone, tag objects and cg-push/git-push don't play nice)
Date: Thu, 20 Oct 2005 12:23:11 +1300
Message-ID: <46a038f90510191623k4f1a7267m50d3bbbd6665a2a3@mail.gmail.com>
References: <46a038f90510190202n60101c5cgf27bd714dce00513@mail.gmail.com>
	 <Pine.LNX.4.64.0510190724000.3369@g5.osdl.org>
	 <46a038f90510191356w56b78413p6b9fe5b67fc9ee74@mail.gmail.com>
	 <20051019223743.GQ30889@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	"Penny @ Catalyst" <penny@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Thu Oct 20 01:23:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESNHA-0007nh-C3
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 01:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611AbVJSXXN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 19:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751634AbVJSXXN
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 19:23:13 -0400
Received: from qproxy.gmail.com ([72.14.204.207]:65028 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751609AbVJSXXM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 19:23:12 -0400
Received: by qproxy.gmail.com with SMTP id v40so210927qbe
        for <git@vger.kernel.org>; Wed, 19 Oct 2005 16:23:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OrW5aQl4ijweN0osPWPtIaeWJ1bfbBQyrRx3G2zLrVREjuDbkB4Ccis/xURCxKDmZd5x9tR7ieXorOUl4eASQhOq0+xDerRGHguZtOSYc5NHz/P6XKpQhiCDh+rZEVGGiQai6m/+oKNGzfyzR5WlNATWdN8iRLY6LE+nQnqCyfY=
Received: by 10.64.210.13 with SMTP id i13mr1011089qbg;
        Wed, 19 Oct 2005 16:23:11 -0700 (PDT)
Received: by 10.64.232.18 with HTTP; Wed, 19 Oct 2005 16:23:11 -0700 (PDT)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051019223743.GQ30889@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10324>

On 10/20/05, Petr Baudis <pasky@suse.cz> wrote:
> Dear diary, on Wed, Oct 19, 2005 at 10:56:35PM CEST, I got a letter
> where Martin Langhoff <martin.langhoff@gmail.com> told me that...
> > To recap: repo is slightly broken because cg-fetch has fetched tag
> > objects, but hasn't followed them through to the commit objects they
> > refer to.
>
> That must be leftover of some old fetch, before cg-fetch got fixed wrt.
> this issue.

Yes, I'm trying to figure out if I can fix it...

> > Internally cg-fetch is actually using git-ssh-fetch (I misreported it
> > using git-fetch-pack), which is working correctly. However, cg-fetch
> > attempts to optimize the fetch process, by not calling git-ssh-fetch
> > if it has the tagobj that the ref points to. How those tag objects get
> > there without commits in the first place I don't know. So I've removed
> > the optimization and life is much better.
>
> The "optimization" or something alike needs to be there at least for the
> user interface, so that we can actually say what tags are we
> downloading; besides, there can be a *lot* of tags. But I'm not sure how
> moot will this all be after Cogito moves to the remote peeking (Real
> Soon Now, promise ;-).
>
> > There is a second bug during the tag fetch. Some of the references
> > (created by git-cvsimport) are multiline, and break cg-fetch. It's
> > probably a bug in git-cvsimport, but I'm fixing cg-fetch to use head
> > -n1 instead of cat. I'll deal with git-cvsimport later.
>
> Eek. Did I miss something and are multiline refs meaningful now? If not,
> they are pretty bad and I'd imagine other parts of Cogito would be
> pretty confused about that. I'd call this a corrupted repository,
> tough. Perhaps a check should be added to fsck.

Actually, all the tagsrefs have only one line, but something is going
weird around tagid=$(cat $tag) as $tag ends up containing many
filenames. So I undid my initial change to "head -n1", and I'm trying
to fix the loop.

cheers,


martin
