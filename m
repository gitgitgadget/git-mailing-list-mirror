From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] fetch: optionally store the current remote information in the config
Date: Sun, 30 Apr 2006 15:21:57 -0700
Message-ID: <7v1wveya9m.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0604301524080.2646@wbgn013.biozentrum.uni-wuerzburg.de>
	<BAYC1-PASMTP08069B2CE6005391A1AFF9AEB00@CEZ.ICE>
	<Pine.LNX.4.63.0604301743370.3641@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 01 00:22:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaKIr-0002my-Sw
	for gcvg-git@gmane.org; Mon, 01 May 2006 00:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWD3WWA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Apr 2006 18:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWD3WWA
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 18:22:00 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:39145 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751228AbWD3WV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Apr 2006 18:21:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060430222158.QZBF25666.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 30 Apr 2006 18:21:58 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0604301743370.3641@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 30 Apr 2006 17:49:06 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19361>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sun, 30 Apr 2006, sean wrote:
>
>> Well I agree with you that doing something like this is important.  We
>> should take this moment of moving things to the config file to correct
>> the terminology and help make things clear.  We're not storing "Pull:"
>> information, we're storing config/remote.$NICK.fetch data.  It's really
>> used just by fetch, pull just happens to call fetch.
>
> I have no strong feelings either way.

I have a strong feeling that naming them "Pull: " was a mistake
to begin with and they should have been called "Fetch: " ;-).

>> Along that same line of reasoning, it seems more appropriate to use 
>> git fetch --store ...  rather than git pull --store ... to set this
>> information.
>
> Both works.

I'd rather not see --store added to either fetch nor pull.

While I would agree --store would appear to be a convenient
short-hand for first timers, I strongly suspect this will cause
more confusion and complexity down the line.  If a topic that
interests you appears today at the remote, and you start
following it by adding --store when you fetch from it, and later
when the topic disappears at the remote in two weeks because it
is fully cooked and merged into somewhere else, you would need
to have a way to --unstore it somehow, and at that time the
first timer needs to learn repo-config to deal with that failure
anyway.  Or you need to teach git-fetch that fetch failure of a
branch is actually OK as long as all of the following holds
true:

 - the branch was added with --store in the past; the user is
   not actively asking for it in the current request, saying "I
   want to fetch from there THIS TIME".

 - the fetch failed only because the remote repository droped
   the branch (IOW you need to tell connection and protocol
   failure from "branch disappeared"case),

 - the fetch is not being done to merge it into the current branch,

or something complicated like that, and unstore it automatically
for the user.

Other than that, I do not have strong feelings against using the
standard .git/config to store what we store in .git/remotes/*
currently, and I also suspect doing so would be a prerequiste
first step to do "per local branch configuration" (e.g. "when on
this branch, merge from this branch by default") some people
seem to want.
