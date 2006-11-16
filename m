X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 20:07:59 -0800
Message-ID: <7vhcx0f2zk.fsf@assigned-by-dhcp.cox.net>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
	<87hcx1u934.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0611141518590.2591@xanadu.home>
	<87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
	<Pine.LNX.4.64.0611141633430.2591@xanadu.home>
	<7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142007010.2591@xanadu.home>
	<7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142306090.2591@xanadu.home>
	<Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
	<455BBCE9.4050503@xs4all.nl> <7vhcx0gnbq.fsf@assigned-by-dhcp.cox.net>
	<455BCD2B.6060603@xs4all.nl> <7vbqn8gjeo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 16 Nov 2006 04:08:19 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vbqn8gjeo.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 15 Nov 2006 19:27:59 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31556>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkYXs-0001bq-Ra for gcvg-git@gmane.org; Thu, 16 Nov
 2006 05:08:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162252AbWKPEIF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 23:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162270AbWKPEIE
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 23:08:04 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:48862 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S1162252AbWKPEIB
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 23:08:01 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061116040800.WPYC7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>; Wed, 15
 Nov 2006 23:08:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id nG861V00k1kojtg0000000; Wed, 15 Nov 2006
 23:08:07 -0500
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> Han-Wen Nienhuys <hanwen@xs4all.nl> writes:
>
>> Junio C Hamano escreveu:
>>>...
>>> Sigh indeed.
>>>
>>> Why don't you do the simple and obvious
>>>
>>> 	git pull url master
>>
>> It is not all evident from the git-pull man-page that this is the
>> obvious and most common usage.
>
> In the git user poll a few months ago, many people recommended
> "everyday git" as a good cheat sheet, and indeed it does not
> talk anything about ...

Sorry, I must have been very grumpy mood when I wrote the
message (cf. Pasky's utterance on #git a few days ago).  What I
wrote was a bit incoherent, so here is an attempt to clarify.

I should point out that the colon separated refspec pairs you
can give to "pull" was designed with considerable thought; it is
not a convenience hack that we give them to "pull" that "fetches
and merges".  Linus's and Michael's other messages in this
thread may seem to be saying that using tracking branches is not
a kosher way to use git, but I do not think that is a correct
interpretation of their messages.

The workflow that does not use any tracking branches is the
simplest and truly distributed way as Linus says.  The command
recommended in "everyday git" document:

	git pull $url $branchname

is the most natural way to express it, and simplest variant that
you do not have to say anything "colon" in it.

However that does not mean it is a bad practice to use tracking
branches.  Sometimes it is handy to be able to refer to what you
fetched from the remote the last time, possibly which is what
you merged into your branch if that last fetch was done via "git
pull", so that you can later examine its history without your
own development.  For that purpose, you need to store what you
fetched in your local refs/ namespace, and that is what tracking
branches are.

The workflow that fetches to tracking branches and then merges
within local repository as two separate steps loses the true
origin information ("Merge branch 'foo'" vs "Merge branch 'foo'
of git://git.bar.xz/foo.git").  That's the reason why not just
"git fetch" but also "git pull" take the colon separated refspec
pairs to direct git to update the tracking branches when "pull"
happenes.  The longhands are cumbersome to type all the time,
and we have shorthand, both to store URL: and Pull: lines in
remotes/ hierarchy, and also $branchname alone is a shorthand
for saying "${branchname}:", meaning "do not use a tracking
branch to store this".

So you have options to use or not to use tracking branches.
After cloning we happen to default to track all remote branches
with corresponding local tracking branches, but that is only
because may people on the list wanted to make life easier to CVS
migrants where following mostly static set of branches is the
norm ("set" is the static part: I do not mean the branches stay
still) and we wanted to make it easier for them.

