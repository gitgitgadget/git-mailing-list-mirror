From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Re: importing cvs logical modules
Date: Thu, 25 May 2006 15:32:55 +0930
Message-ID: <93c3eada0605242302x24ca1272xd7bfc3a677b32845@mail.gmail.com>
References: <93c3eada0605242148u4656bc31p96d84a16703f0fe0@mail.gmail.com>
	 <7vslmyzoit.fsf@assigned-by-dhcp.cox.net>
Reply-To: geoff@austrics.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 08:03:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fj8w1-0001Nh-JH
	for gcvg-git@gmane.org; Thu, 25 May 2006 08:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965055AbWEYGC5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 02:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbWEYGC5
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 02:02:57 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:4111 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965054AbWEYGC4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 02:02:56 -0400
Received: by wr-out-0506.google.com with SMTP id i7so61036wra
        for <git@vger.kernel.org>; Wed, 24 May 2006 23:02:55 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jDN9JLbkGjfgjHqP6bX6KbBICGwyJQsSB/IpPH3rHk4KCrGcPKyyyzl/kAkZ13lYXvp/8kfvh5muCia2PE72OVtNw/lB1xFpz4Q8UwvDrwOk0GWDaQTFUaXZ6kIX72ot9TH7ywBFwHfuj8wbyPRZQnl4YZqFowHglrlqkcmDZXw=
Received: by 10.54.103.2 with SMTP id a2mr184039wrc;
        Wed, 24 May 2006 23:02:55 -0700 (PDT)
Received: by 10.70.32.19 with HTTP; Wed, 24 May 2006 23:02:55 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vslmyzoit.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20729>

On 5/25/06, Junio C Hamano <junkio@cox.net> wrote:
> "Geoff Russell" <geoffrey.russell@gmail.com> writes:
>
> > I'd like to make 1 git repository Progs with xxxx and yyyy as child trees.
> >
> >           Progs/.git
> >           Progs/xxxx
> >           Progs/yyyy
> >
> > Does this sound useful to anyone else, or is it already possible?
>
> I would do it like this:
>
>            Progs/.git
>            Progs/xxxx/.git
>            Progs/yyyy/.git
>
> I do not know what you have in Progs/ hierarchy -- if it is just
> scaffolding to house subdirectories and nothing else you may not
> even need Progs/.git repository.
>
> This is a very useful and handy structure, and you do not need
> any tool support once you have these as separate repositories.
> If you want a single distribution point, you can push from these
> separate repositories into separate branches of a single
> distribution point repository [*1*].
>
> One potential disadvantage is that you would not get revision
> linkage between these "modules", but not having tight linkage is
> the point of modular structure, so depending on your workflow it
> probably may not matter.

The tight linkage is absolutely essential.

When we tag the system, we
want to tag everything (not individually tag all 300 programs)
so that later we can to branch at that tag. Very few of our
programs are self contained, they generally make heavy use
of one or more libraries --- which must also be part of the
tree. The full structure should end up looking like:

        Top/.git
        Libraries/libx
        Libraries/liby
        Libraries/boost
        Libraries/...
        Programs/xxx
        Programs/yyy
        Programs/...
        ...etc.

When we build a full system, we want to tag that point so
we can know exactly what went into that build.

We used to do it the "other" way.

         cvsroot/xxx
         cvsroot/yyy
         cvsroot/liby
         cvsroot/libx
         etc

But then when we did a system build, someone always forgot
to tag something. So we got cvs to build a build logical tree
and then cvs was quite happy to tag the lot with one go and
nothing got forgotten. So now we are trying to pull the
lot into git as one big tree.

Cheers,
Geoff.


>
>
> [Footnote]
>
> *1* In fact, my git working area has the "master", "next" or
> "pu" branch checked out in /path/to/work/area/git (and the
> repository is in /path/to/work/area/git/.git directory), and I
> check out the "todo" branch in /path/to/work/area/git/Meta
> directory, with /path/to/work/area/git/Meta/.git directory as
> its repository.
>
>
