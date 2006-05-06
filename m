From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Unresolved issues #2
Date: Sat, 6 May 2006 10:20:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605061008340.16343@g5.osdl.org>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net> <7v4q065hq0.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0605041627310.6713@iabervon.org> <Pine.LNX.4.64.0605041715500.3611@g5.osdl.org>
 <7vhd43vgnm.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605060821430.16343@g5.osdl.org>
 <BAYC1-PASMTP10F63ADF30C26A29D070C5AEAA0@CEZ.ICE> <Pine.LNX.4.64.0605060923050.16343@g5.osdl.org>
 <BAYC1-PASMTP0824AA77198F95FE28B79DAEAA0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, barkalow@iabervon.org,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 06 19:20:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcQSF-0001Ia-LF
	for gcvg-git@gmane.org; Sat, 06 May 2006 19:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbWEFRU1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 13:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbWEFRU1
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 13:20:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63418 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750991AbWEFRU1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 May 2006 13:20:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k46HKGtH022013
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 6 May 2006 10:20:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k46HKFT1002359;
	Sat, 6 May 2006 10:20:16 -0700
To: sean <seanlkml@sympatico.ca>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <BAYC1-PASMTP0824AA77198F95FE28B79DAEAA0@CEZ.ICE>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19663>



On Sat, 6 May 2006, sean wrote:
>
> Okay, I mistook the scope of you comments to apply to all of git rather than
> as a reminder that we can't forget about the toolkit design.  So I take it
> you're not at all against git including higher level user commands; just so
> long as they're built on top of lower level toolkit commands that other
> porcelain can use as well.

Correct. I think we've been able to handle that balance particularly well 
so far. Or maybe the porcelains don't complain enough.

> In this particular case I see "git repo-config" as the low level command that
> any porcelain can use to access the remotes information and the proposed
> "git remotes" as a simple convenience wrapper on top of this.  Of course,
> everyone has to agree on the config file format; but that is true whether
> the human-friendly wrapper exists or not.

I agree, but my point is that in order for a porcelain to _use_ 
"repo-config", the config file format needs to be defined somewhere, and 
we need to tell people that it's not changing. Are we there yet?

That was my argument for why we should concentrate not on what the user 
wrapper should be named, but why we should look at what the low-level 
meaning of these things are.

Finally, I think "git repo-config" is buggy. Try with this .config file:

	[user]
		name = Bozo the Clown
		email = bozo@circus.com

	[core]
		filemode = true

	[merge]
		summary = true

and then do

	git repo-config core.gitproxy 'dummy example'

and look where it ends up. For me, it ends up at the end, in the "[merge]" 
section, which is obviously bogus.

So we'd really be screwing with porcelain if we made them use this ;)

		Linus
