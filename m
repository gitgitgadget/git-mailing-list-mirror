From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Implementing branch attributes in git config
Date: Wed, 10 May 2006 08:37:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605100823350.3718@g5.osdl.org>
References: <1147037659.25090.25.camel@dv> <e3p5om$djs$1@sea.gmane.org> 
 <Pine.LNX.4.63.0605091321350.7652@wbgn013.biozentrum.uni-wuerzburg.de> 
 <7vzmhr3wje.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.64.0605091215340.3718@g5.osdl.org>
  <BAYC1-PASMTP02C02EAC2F64AC00BB5801AEA90@CEZ.ICE> 
 <BAYC1-PASMTP04D623089E043F1C792A37AEA90@CEZ.ICE>  <Pine.LNX.4.64.0605091543100.3718@g5.osdl.org>
  <BAYC1-PASMTP037EBB0237B35C5F92FB0BAEAE0@CEZ.ICE> 
 <Pine.LNX.4.64.0605091854380.3718@g5.osdl.org>
 <46a038f90605100019q3b44b87kf49e456668f2e249@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: sean <seanlkml@sympatico.ca>, junkio@cox.net,
	Johannes.Schindelin@gmx.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 10 17:37:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fdqkz-0007IM-N1
	for gcvg-git@gmane.org; Wed, 10 May 2006 17:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbWEJPhn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 May 2006 11:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbWEJPhn
	(ORCPT <rfc822;git-outgoing>); Wed, 10 May 2006 11:37:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28902 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751486AbWEJPhm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 May 2006 11:37:42 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4AFbGtH000638
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 10 May 2006 08:37:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4AFbDOW016051;
	Wed, 10 May 2006 08:37:14 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90605100019q3b44b87kf49e456668f2e249@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19885>



On Wed, 10 May 2006, Martin Langhoff wrote:
> 
> Good one. I'm following this thread with interest, but it feels we've
> been attacked by the 'bike shed bug' in the act of redesigning
> Windows.ini.

Sure. It clearly _is_ a bike shed, which is why I posted patches: I think 
the way to resolve bike sheds is to "just do it". In the kernel, the 
general rule ends up being "he who writes the code gets to choose how it 
gets done", because it turns out that there are a lot more people willing 
to _argue_ about code than there are people willing to _write_ it, and 
thus that "real code wins" rule actually works very well in practice.

I don't think I've ever really seen an argument where you ended up having 
seriously competing patches. Yes, you can have patches to do things 
different ways, but once you have that, it tends to be pretty easy for the 
maintainer to just draw a line in the sand. And once one patch has been 
accepted, it's all over.

So the real problem with "bike sheds" is actually when you have a culture 
of arguing, and not enough of a culture of "just do it".

If you have a "just do it" culture, bike sheds are often good things. If 
it really _is_ that easy, a bike shed is a perfect opportunity for 
somebody who isn't all that deeply into a project to make a contribution 
and start feeling more comfy about it. It obviously didn't happen here, 
but it's definitely true that a lot of people in the kernel get introduced 
to doing patches through various "trivial" things.

So don't knock the bike sheds. It's a BSD term, and I think there's a 
_reason_ why it's a BSD term. Those people seem to sometimes like to argue 
about theoretical things (or about anything else, for that matter) more 
than actually getting the damn job done.

> As an end-user, I have personally stayed away from the increasingly
> complex scheme for remotes waiting for it to settle, and stuck with
> the old-styled .git/branches stuff which is slam-dunk simple and it
> just works.

It does work, and I think it's nice in many ways. It was certainly a good 
way to prototype things.

At the same time, especially with moving things more to C (or almost any 
other language, for that matter - shell is really pretty special in making 
it _easier_ to have things in individual files), it's in many ways nicer 
to have a more structured representation that has a nice fixed interface 
and a library and known access methods behind it.

And I'm personally actually pretty fed up with the .git/branches/ and 
.git/remotes/ thing, partly because I can never remember which file is 
which. I had to look at the code of git-parse-remote.sh to remind me which 
had what semantics. We could remove the old one entirely, of course (and 
no, I don't remember which is which now either), and avoid that particular 
problem, but it kind of soured me on it. 

And if we truly have separate files, we should go all the way, and have 
the good old "one file, one value" rule. Which we don't, and which I think 
everybody admits would be horrible for this case for users (even if it 
might be very nice for scripting).

		Linus
