From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Implementing branch attributes in git config
Date: Mon, 8 May 2006 21:11:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605082100460.3718@g5.osdl.org>
References: <1147037659.25090.25.camel@dv> <Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
 <1147048587.17371.13.camel@dv> <Pine.LNX.4.64.0605071740550.3718@g5.osdl.org>
 <7vfyjli9vf.fsf@assigned-by-dhcp.cox.net> <BAYC1-PASMTP0334B471C6908E4E40BFD2AEA80@CEZ.ICE>
 <7vbqu9i6zl.fsf@assigned-by-dhcp.cox.net> <BAYC1-PASMTP110777A694DAF1D7623895AEA80@CEZ.ICE>
 <Pine.LNX.4.64.0605081905240.6713@iabervon.org> <BAYC1-PASMTP0453E2D70B10C6D116167EAEA80@CEZ.ICE>
 <Pine.LNX.4.63.0605090142280.5778@wbgn013.biozentrum.uni-wuerzburg.de>
 <BAYC1-PASMTP03ADC2F3E75E482ADC5CD3AEA90@CEZ.ICE> <Pine.LNX.4.64.0605081731440.3718@g5.osdl.org>
 <7virogc90u.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605081801360.3718@g5.osdl.org>
 <7v1wv4c7wk.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605081854190.3718@g5.osdl.org>
 <BAYC1-PASMTP04C9C4BF5B89E55B9D877AAEA90@CEZ.ICE> <Pine.LNX.4.64.0605082007100.3718@g5.osdl.org>
 <BAYC1-PASMTP05953E2B948CB07A171FD8AEA90@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 06:11:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdJZR-0006oy-Ce
	for gcvg-git@gmane.org; Tue, 09 May 2006 06:11:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbWEIELc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 00:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWEIELc
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 00:11:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36785 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751365AbWEIELb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 May 2006 00:11:31 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k494BPtH015028
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 8 May 2006 21:11:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k494BOWP030676;
	Mon, 8 May 2006 21:11:25 -0700
To: sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP05953E2B948CB07A171FD8AEA90@CEZ.ICE>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19814>



On Mon, 8 May 2006, sean wrote:
>
> [core]
>  ...
> [branch.core]
>  ...
> [remote.core]
>  ...

Ok. In that case, I would suggest a much more readable format:

	[core]
		...

	[branch "core"]
		...

	[remote "core"]
		...

and yes, enforce the <space>+<quoted name> format. We'd turn it internally 
into some random internal string format (probably replacing the space with 
a dot, and removing the quotes, so it would become "remote.core.<key>").

> But it's not just the config file, it's also how it ends up being used
> on the command line.. 

Actually, the command line migth as well allow any strange thing, and 
_add_ the quotes internally. So you could do something that does

	git repo-config set Remote.Core.Pull master

and we could just let that generate

	[remote "Core"]
		pull = master

or whatever.

I care about the _file_ being human-editable, but that means that I think 
it's perfectly fine to have some smarts in the tools that help us do so, 
and let them recognize the magic "remote" and "branch" prefixes.

		Linus
