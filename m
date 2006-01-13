From: sean <seanlkml@sympatico.ca>
Subject: Re: git-commit: allow From: line to be entered in commit message
Date: Thu, 12 Jan 2006 21:32:07 -0500
Message-ID: <BAYC1-PASMTP102ED7B30D2B48BEE601F5AE260@CEZ.ICE>
References: <BAYC1-PASMTP117A18814EAAFACFE0F31DAE270@CEZ.ICE>
	<7vzmm1mcfz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 03:36:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExEnq-0002Oy-5A
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 03:36:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161447AbWAMCgb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 21:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161455AbWAMCgb
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 21:36:31 -0500
Received: from bayc1-pasmtp10.bayc1.hotmail.com ([65.54.191.170]:40835 "EHLO
	BAYC1-PASMTP10.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1161447AbWAMCga (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 21:36:30 -0500
X-Originating-IP: [69.156.6.171]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.6.171]) by BAYC1-PASMTP10.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 12 Jan 2006 18:37:08 -0800
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 6567C644C23;
	Thu, 12 Jan 2006 21:36:28 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Message-Id: <20060112213207.05d76b28.seanlkml@sympatico.ca>
In-Reply-To: <7vzmm1mcfz.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 13 Jan 2006 02:37:08.0859 (UTC) FILETIME=[3FE7F4B0:01C617EA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 12 Jan 2006 12:13:52 -0800
Junio C Hamano <junkio@cox.net> wrote:

> Actually, I've considered this a couple of times in the past,
> but I ended up saying no.
> 
> If the workflow is driving "git commit" from a script (i.e. your
> own Porcelain), the script can set GIT_AUTHOR_* environment
> variables, so this is a non issue.

Yes, obviously if there is another wrapper this isn't needed because
that script could parse the From: line out of the text as well.

> Which means that this 'From: ' thing is coming from the end
> user.  Either you as the end user pasted it from some text file,
> or typed that line because you knew that the change was made by
> that person, not by you.
> 
> If you pasted that line from somewhere else, I wonder what that
> "somewhere else" file is -- and what else that file contained.
> If the change came in an e-mail message, we already have tools
> for that (am/applymbox), and they do not lose the author-date
> information as your change to git-commit does, so I think it is
> a non issue.

This idea came up because recently on tLKML there was someone who 
asked Linus to pull from him that had all the author names as his
own and a From: line in a bunch of the commit messages.
When I sent him an email asking why he explained that it was
just too cumbersome to bother setting up the proper author
using git environment variables.   Apparently he is more or less
hand munging mutliple cvs branches into a nice git package for 
Linus to pull.  He said that many of the patches don't apply as-is
and need some manual tweaking before committing.

 
> And I do not think of anything else that would have author name
> but does not have a patch text that you can feed git-apply with.
> Pasting from your address book just to save typing does not
> count as "pasting" --- that is still typing in this context.
> 
> If you typed that line, why somebody else's change ended up in
> your working tree is a mystery to me, but let's say an
> office-mate edited things for you and said "this should work.
> test it out and if it is OK commit it for me."  I have seen this
> kind of thing done in real life.
> 
> If that is what happened, then what you are adding is a more
> convenient way than setting two GIT_AUTHOR_* environment
> variables.  Maybe you forgot about preserving author date, in
> which case you would add 'Date: ' as well to your patch, and
> that would save your user from setting three environment
> variables.

Naw, I just don't think the date is as important or generally
cared about as much, but you're right maybe that'd help someone
too.

> So the matter really is how much this patch is better than
> setting GIT_AUTHOR_* environment variables, unless it simplifies
> things for other programs (one possibility I have not looked
> into is that we _might_ be able to use "git commit" with this
> modification from "git am/applimbox/revert/cherry-pick").
> 

Yeah, i wondered about that too.

I think something like this patch, or as someone else suggested
one that accepts the author on the command line, is needed.
Having to set environment variables for this information just
doesn't make much sense if you ever need to change it in a manual
way, which is bound to happen from time to time.

Cheers,
Sean
