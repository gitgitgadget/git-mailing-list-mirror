From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Implementing branch attributes in git config
Date: Mon, 8 May 2006 17:37:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605081731440.3718@g5.osdl.org>
References: <1147037659.25090.25.camel@dv> <Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
 <1147048587.17371.13.camel@dv> <Pine.LNX.4.64.0605071740550.3718@g5.osdl.org>
 <7vfyjli9vf.fsf@assigned-by-dhcp.cox.net> <BAYC1-PASMTP0334B471C6908E4E40BFD2AEA80@CEZ.ICE>
 <7vbqu9i6zl.fsf@assigned-by-dhcp.cox.net> <BAYC1-PASMTP110777A694DAF1D7623895AEA80@CEZ.ICE>
 <Pine.LNX.4.64.0605081905240.6713@iabervon.org> <BAYC1-PASMTP0453E2D70B10C6D116167EAEA80@CEZ.ICE>
 <Pine.LNX.4.63.0605090142280.5778@wbgn013.biozentrum.uni-wuerzburg.de>
 <BAYC1-PASMTP03ADC2F3E75E482ADC5CD3AEA90@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 02:37:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdGES-0000vA-K6
	for gcvg-git@gmane.org; Tue, 09 May 2006 02:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbWEIAhm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 20:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbWEIAhl
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 20:37:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18659 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750989AbWEIAhl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 May 2006 20:37:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k490bUtH008382
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 8 May 2006 17:37:30 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k490bTeA026753;
	Mon, 8 May 2006 17:37:29 -0700
To: sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP03ADC2F3E75E482ADC5CD3AEA90@CEZ.ICE>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19790>



On Mon, 8 May 2006, sean wrote:
> 
> One option, which I don't really like and comes with its own set of 
> problems, would be to do something like:
> 
> [branch1]
>     streetname = "p4/BrAnCH"
> [branch2]
>     streetname = "origin"

You don't actually need that.

We could easily do

	[branch]
		name = "p4/BrAnCH"
		url = git://git.kernel.org/...
		pull = master

	;
	; Repeating the "[branch]" section here isn't
	;  needed, but doesn't hurt either, and is
	; more readable
	;
	[branch]
		name = "origin"
		url = ...
		pull = ...

because the config file is always parsed linearly, and just 
trigger on "branch.name", and keep that around when parsing 
anything else.

The problem with _that_ is that "git repo-config" can't add this kind of 
setup sanely: it doesn't understand that kind of statefulness.

The above would work without any changes what-so-ever to the config format 
and readers - and old versions of git wouldn't react badly either. But the 
writer would need to be taught about state.

		Linus
