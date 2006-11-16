X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 19:27:59 -0800
Message-ID: <7vbqn8gjeo.fsf@assigned-by-dhcp.cox.net>
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
	<455BCD2B.6060603@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 16 Nov 2006 03:28:14 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <455BCD2B.6060603@xs4all.nl> (Han-Wen Nienhuys's message of "Thu,
	16 Nov 2006 03:30:03 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31551>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkXv5-000373-4e for gcvg-git@gmane.org; Thu, 16 Nov
 2006 04:28:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030964AbWKPD2D (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 22:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031073AbWKPD2D
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 22:28:03 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:19848 "EHLO
 fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP id S1030964AbWKPD2A
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 22:28:00 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061116032800.QRLA27894.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>; Wed, 15
 Nov 2006 22:28:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id nFU61V00B1kojtg0000000; Wed, 15 Nov 2006
 22:28:06 -0500
To: hanwen@xs4all.nl
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys <hanwen@xs4all.nl> writes:

> Junio C Hamano escreveu:
>>...
>> Sigh indeed.
>>
>> Why don't you do the simple and obvious
>>
>> 	git pull url master
>
> It is not all evident from the git-pull man-page that this is the
> obvious and most common usage.

In the git user poll a few months ago, many people recommended
"everyday git" as a good cheat sheet, and indeed it does not
talk anything about directing the underlying git-fetch to
manipulate tracking branches by giving explicit refspec pairs to
git pull.  You are obviously tripped by both the overeager
manpage (but manpage should strive to be complete so you cannot
really blame it) and less than optimally organized tutorial
style documents.

I myself do prefer, when learning a new tool, to use longhand
until I understand the shorthand, but that attitude requires a
true commitment to learn the tool, and most people do not go
that route.  Tutorial style documents tend to give the commonly
used shorthand first for that exact reason.

Shorthand to give only the branch name to fetch and merge
immediately without using a tracking branch is equivalent to
longhand "branch:" as you found out, so if that was what was
desired then people with the attitude "before understanding what
longhand does I prefer using shorthand" like myself and you
would have liked to learn "git pull url branch:" notation from
Tutorial.  But I think we _are_ minority.  People would not want
to see that seemingly useless colon there.

> To me it's very unlogical that
>
>   master:current-branch
>
> doesn't work,

That shows that you did not understand what fetch does.  Maybe
you do now, but a very natural consequence of directing fetch to
update tracking branches with the colon notation is:

 - "pull url master:master", while on master, is almost always
   wrong and not something you would want to do, ever.

   "fetch --update-head-ok url +master:master; reset --hard HEAD"

   may make sense but never "pull".

> I use the remote:local syntax, because I started using GIT in scripted
> compiles from copied branches of remote repositories. There the
> explicit remote:local statements are necessary because there is no
> default branch.

If you perhaps wanted to ask "is there a better way to do what
I've been doing?", then I am willing to think with you to come
up with an answer.  Unfortunately, however, I do not understand
the above paragraph, so I'd refrain from commenting on it in
this response.


