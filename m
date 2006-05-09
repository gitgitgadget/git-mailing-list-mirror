From: sean <seanlkml@sympatico.ca>
Subject: Re: Implementing branch attributes in git config
Date: Mon, 8 May 2006 20:49:33 -0400
Message-ID: <BAYC1-PASMTP02A6C811EC4FA46BBD95DDAEA90@CEZ.ICE>
References: <1147037659.25090.25.camel@dv>
	<Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
	<1147048587.17371.13.camel@dv>
	<Pine.LNX.4.64.0605071740550.3718@g5.osdl.org>
	<7vfyjli9vf.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP0334B471C6908E4E40BFD2AEA80@CEZ.ICE>
	<7vbqu9i6zl.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP110777A694DAF1D7623895AEA80@CEZ.ICE>
	<Pine.LNX.4.64.0605081905240.6713@iabervon.org>
	<BAYC1-PASMTP0453E2D70B10C6D116167EAEA80@CEZ.ICE>
	<Pine.LNX.4.63.0605090142280.5778@wbgn013.biozentrum.uni-wuerzburg.de>
	<BAYC1-PASMTP03ADC2F3E75E482ADC5CD3AEA90@CEZ.ICE>
	<Pine.LNX.4.64.0605081731440.3718@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Johannes.Schindelin@gmx.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 02:54:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdGUv-0006ls-Sv
	for gcvg-git@gmane.org; Tue, 09 May 2006 02:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWEIAyl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 20:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbWEIAyl
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 20:54:41 -0400
Received: from bayc1-pasmtp02.bayc1.hotmail.com ([65.54.191.162]:38703 "EHLO
	BAYC1-PASMTP02.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1750999AbWEIAyk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 May 2006 20:54:40 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP02.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 8 May 2006 17:54:40 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 486AA644C28;
	Mon,  8 May 2006 20:54:39 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
Message-Id: <20060508204933.539ddd8b.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.64.0605081731440.3718@g5.osdl.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 09 May 2006 00:54:40.0628 (UTC) FILETIME=[27315B40:01C67303]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 8 May 2006 17:37:29 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> We could easily do
> 
> 	[branch]
> 		name = "p4/BrAnCH"
> 		url = git://git.kernel.org/...
> 		pull = master
> 
> 	;
> 	; Repeating the "[branch]" section here isn't
> 	;  needed, but doesn't hurt either, and is
> 	; more readable
> 	;
> 	[branch]
> 		name = "origin"
> 		url = ...
> 		pull = ...
> 
> because the config file is always parsed linearly, and just 
> trigger on "branch.name", and keep that around when parsing 
> anything else.

That was pretty much what I was suggesting although i overlooked 
the fact that you don't actually need to number the sections.

> The problem with _that_ is that "git repo-config" can't add this kind of 
> setup sanely: it doesn't understand that kind of statefulness.

Shouldn't be too hard to deal with.  So we would allow the following
command to make the url entry above:

    $ git repo-config branch.p4/BrAnCH.url git://git.kernel.org/...

> The above would work without any changes what-so-ever to the config format 
> and readers - and old versions of git wouldn't react badly either. But the 
> writer would need to be taught about state.

Well it seems like maybe the best compromise, and it avoids having to put
files and directories into section names which Johannes was objecting to.

Sean
