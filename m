From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Merge with git-pasky II.
Date: Thu, 14 Apr 2005 02:10:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
References: <20050414002902.GU25711@pasky.ji.cz> <20050413212546.GA17236@64m.dyndns.org>
 <20050414004504.GW25711@pasky.ji.cz> <Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org>
 <7vfyxtsurd.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org>
 <7v64ypsqev.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, Christopher Li <git@chrisli.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 11:07:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM0It-0003s3-G4
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 11:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVDNJJB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 05:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbVDNJJB
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 05:09:01 -0400
Received: from fire.osdl.org ([65.172.181.4]:55021 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261458AbVDNJIf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 05:08:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3E98Ps4015546
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 14 Apr 2005 02:08:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3E98Ooa017877;
	Thu, 14 Apr 2005 02:08:24 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64ypsqev.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 14 Apr 2005, Junio C Hamano wrote:
> 
> I have to handle the following cases.  I think I currently do
> wrong things to them:
> 
>   5.1a both head modify to the same thing.
>   5.1b one head removes, the other does not do anything.
>   5.1c both head remove.
>   5.3 one head removes, the other head modifies.

There's another interesting set of cases: one side creates a file, and the
other one creates a directory. 

> I am not sure what to do with 5.3.

My very _strong_ preference is to just inform the user about a merge that
cannot be performed, and not let it be automated. BIG warning, with some 
way for the user to specify the end result.

The thing is, these are pretty rare cases. But in order to make people 
feel good about the _common_ case, it's important that they feel safe 
about the rare one.

Put another way: if git tells me when it can't do something (with some
specificity), I can then fix the situation up and try again. I might curse
a while, and maybe it ends up being so common that I might even automate
it, but at least I'll be able to trust the end result.

In contrast, if git does something that _may_ be nonsensical, then I'll
worry all the time, and not trust git. That's much worse than an 
occasional curse.

So the rule should be: only merge when it's "obviously the right thing".  
If it's not obvious, the merge should _not_ try to guess what the right
thing is. It's much better to fail loudly.

(That's especially true early on. There may be cases that end up being
obvious after some usage. But I'd rather find them by having git be too
stupid, than find out the hard way that git lost some data because it
thought it was ok to remove a file that had been modified)

			Linus
