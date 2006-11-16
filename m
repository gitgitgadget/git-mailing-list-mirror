X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 08:23:08 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611160814560.3349@woody.osdl.org>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
 <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home>
 <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
 <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
 <455BBCE9.4050503@xs4all.nl> <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>
 <455C412D.1030408@xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 16 Nov 2006 16:23:45 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <455C412D.1030408@xs4all.nl>
X-MIMEDefang-Filter: osdl$Revision: 1.156 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31594>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gkk1N-0002v4-14 for gcvg-git@gmane.org; Thu, 16 Nov
 2006 17:23:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424269AbWKPQXR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 11:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424270AbWKPQXR
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 11:23:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39866 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1424269AbWKPQXQ (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 11:23:16 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAGGN9oZ010832
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 16
 Nov 2006 08:23:10 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAGGN8Vl029475; Thu, 16 Nov
 2006 08:23:09 -0800
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
Sender: git-owner@vger.kernel.org



On Thu, 16 Nov 2006, Han-Wen Nienhuys wrote:
> 
> This is not about CVS or SVN, so don't put them up as a strawman.
> If you want to argue that my brain is warped, use other distributed VCs as an
> example.

Your example has nothing at all to do with "pull" vs "fetch", though.

Your example is about something totally _different_, namely that under 
git, "git init-db" is _only_ for creating a _new_ project.

> The following
> 
>   mkdir x y
>   cd x
>   hg init
>   echo hoi > bla
>   hg add
>   hg commit -m 'yes, I am also too stupid to refuse explicit empty commit messages'
>   cd ../y
>   hg init
>   hg pull ../x
> 
> pretty much works the same in Darcs, bzr and mercurial.
> 
> With GIT, this is what happens
> 
> [hanwen@haring y]$ git pull ../x

Bzzt. This is where you went wrong, and you blamed "pull".

The way you do this in git is to NOT do "git init". Instead, you replace 
all the

	mkdir y
	cd ../y
	hg init
	hg pull ../x

with a simple

	git clone x y

and YOU ARE DONE.

Now, we could certainly _make_ "git pull" work on an empty git project, 
but that has _nothing_ to do with what people have been talking about.

In fact, the fact that "git fetch" kind of works is not exactly accidental 
(because "git fetch" _is_ meant to add new local branches too), but all 
the problems you have with it are due to the SAME issue. You started 
without any branch at all, because you started with an empty git repo, and 
you're simply not _supposed_ to do that.

So current rule (and this is not new, it's always been true): the ONLY 
time you use "git init-db" is when you are going to start a totally new 
project. Never _ever_ otherwise. If you want to track another project, use 
"git clone".

> This might not be typical GIT use, but it does show the typical GIT user
> experience, at least mine.

It's not that it isn't typical, it's that you are using the wrong model. 
Maybe it's not well documented, I can easily give you that, but ALL your 
problems come from that fundamental starting point: you shouldn't have 
used "git init-db" in the first place.

Somebody want to document it?

Alternatively, we certainly _could_ make "git pull" just accept an empty 
git repo, and make it basically create the current branch.

(And we probably should improve the error messahe)

> I don't want ANYTHING to really change, I just want a sane interface to it.

The sane interface _exists_. It's called "git clone".

