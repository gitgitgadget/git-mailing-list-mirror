From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Implementing branch attributes in git config
Date: Mon, 8 May 2006 18:05:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605081801360.3718@g5.osdl.org>
References: <1147037659.25090.25.camel@dv> <Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
 <1147048587.17371.13.camel@dv> <Pine.LNX.4.64.0605071740550.3718@g5.osdl.org>
 <7vfyjli9vf.fsf@assigned-by-dhcp.cox.net> <BAYC1-PASMTP0334B471C6908E4E40BFD2AEA80@CEZ.ICE>
 <7vbqu9i6zl.fsf@assigned-by-dhcp.cox.net> <BAYC1-PASMTP110777A694DAF1D7623895AEA80@CEZ.ICE>
 <Pine.LNX.4.64.0605081905240.6713@iabervon.org> <BAYC1-PASMTP0453E2D70B10C6D116167EAEA80@CEZ.ICE>
 <Pine.LNX.4.63.0605090142280.5778@wbgn013.biozentrum.uni-wuerzburg.de>
 <BAYC1-PASMTP03ADC2F3E75E482ADC5CD3AEA90@CEZ.ICE> <Pine.LNX.4.64.0605081731440.3718@g5.osdl.org>
 <7virogc90u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 03:05:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdGfC-000065-QY
	for gcvg-git@gmane.org; Tue, 09 May 2006 03:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWEIBFT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 21:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWEIBFT
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 21:05:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42730 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751234AbWEIBFR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 May 2006 21:05:17 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4915DtH009200
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 8 May 2006 18:05:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4915DWU027285;
	Mon, 8 May 2006 18:05:13 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virogc90u.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19800>



On Mon, 8 May 2006, Junio C Hamano wrote:
> >
> > The problem with _that_ is that "git repo-config" can't add this kind of 
> > setup sanely: it doesn't understand that kind of statefulness.
> 
> Wait a minute...  Statefulness is not the issue, I think.

Well, it does end up being..

> How would you tell your updated repo-config what to update and
> what to look up?
> 
> 	- I want the url for branch whose name is "origin"
> 
> 	- I want to fetch their "for-linus" branch when fetching
>           from the branch whose name is "jgarzik" from now on.

Exactly, git repo-config would have to know about this magic thing, and 
have a special argument like

	--state=branch.name

that says that "state" is to be taken from the "branch.name" variable when 
seen.

Then, in addition to the regexp, you would have a way to trigger on the 
"state" variable.

> Now, how would that compare with:
> 
>         [branch.jgarzik]
>                 url = git://git.kernel.org/...
>                 fetch = for-linus
> 
> or
> 	[branch."JGarzik"]
>                 url = git://git.kernel.org/...
>                 fetch = for-linus

It would be _able_ to do all the same things, but thanks to statefulness 
you'd be able to keep the section (and key) names the way they are.

> On a related topic, I have always been torn about the "for"
> convention.

I agree. And I think it's actually very much the same thing. It adds 
state, but it adds it to each _value_, instead of adding it once "before" 
the values.

		Linus
