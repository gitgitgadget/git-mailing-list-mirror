X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Restore a single file in the index back to HEAD
Date: Fri, 27 Oct 2006 03:02:38 -0700
Message-ID: <7vac3igjpd.fsf@assigned-by-dhcp.cox.net>
References: <200610261641.11239.andyparkins@gmail.com>
	<81b0412b0610260842x52413570k3971bcdc54b3ccb5@mail.gmail.com>
	<200610270827.17659.andyparkins@gmail.com>
	<20061027073834.GC29057@spearce.org> <4541BE8E.5050605@op5.se>
	<20061027081545.GF29057@spearce.org>
	<81b0412b0610270245w6c29b3c3va7967991f53db298@mail.gmail.com>
	<4541D670.6000900@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 27 Oct 2006 10:03:42 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <4541D670.6000900@op5.se> (Andreas Ericsson's message of "Fri, 27
	Oct 2006 11:50:40 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30321>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdOYV-0005en-PU for gcvg-git@gmane.org; Fri, 27 Oct
 2006 12:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946307AbWJ0KCl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 06:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946308AbWJ0KCl
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 06:02:41 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:136 "EHLO
 fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP id S1946307AbWJ0KCk
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 06:02:40 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061027100239.CHMG13992.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>; Fri, 27
 Oct 2006 06:02:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id fN2j1V00C1kojtg0000000 Fri, 27 Oct 2006
 06:02:44 -0400
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

Andreas Ericsson <ae@op5.se> writes:

> Alex Riesen wrote:
>>>> >Which leads us to the always interesting, fun and exciting:
>>>> >
>>>> >    git ls-tree -r HEAD | git update-index --index-info
>>>> >
>>>> >which will undo everything except 'git add' from the index, as
>>>> >ls-tree -r is listing everything in the last commit.
>>>> >
>>>>
>>>> ... and also shows The Power of the Pipe, which Daniel@google was
>>>> missing in recent versions of git. ;-)
>>>>
>>>> Btw, this is most definitely not a documented thing and requires a bit
>>>> of core git knowledge, so perhaps the "shell-scripts were good for
>>>> hackers to learn what to pipe where" really *is* a very important point.
>>>
>>> Agreed.
>>
>> Still, it is very impressive, it is supported (and will be
>> supported, I assume),
>> and as such - worth mentioning at least in these examples everyone keeps
>> dreaming about. Until that happened, why not mention that the output
>> of "git ls-tree" is compatible with --index-info of "update-index"?
>
> +1. Me likes, although I would amend the command-line that Shawn sent
> and describe what it does. Examples > descriptions everywhere else in
> the git docs, so it would be concise to do so.

I do not like the one that does the whole tree that much.  I
would think "git-read-tree -m HEAD" would be simpler and more
efficient if you are reverting the whole tree.

On the other hand, I designed --index-info to be compatible with
ls-tree output (it is not an accident, it was designed).  In

	git ls-tree HEAD frotz | git update-index --index-info

"frotz" part does not have to be the exact path but can be a
directory name.  It means "revert everything in this directory".

This is quite heavy-handed and you would probably want to run
update-index --refresh afterwards.
