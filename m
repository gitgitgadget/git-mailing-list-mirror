From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Handling large files with GIT
Date: Tue, 14 Feb 2006 11:52:26 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602141108050.3691@g5.osdl.org>
References: <46a038f90602080114r2205d72cmc2b5c93f6fffe03d@mail.gmail.com> 
 <87slqty2c8.fsf@mid.deneb.enyo.de> <46a038f90602081435x49e53a1cgdc56040a19768adb@mail.gmail.com>
 <Pine.OSX.4.64.0602131416530.25089@piva.hawaga.org.uk>
 <Pine.LNX.4.64.0602121939070.3691@g5.osdl.org> <Pine.LNX.4.64.0602122049010.3691@g5.osdl.org>
 <Pine.LNX.4.64.0602122058260.3691@g5.osdl.org> <43F113A5.2080506@f2s.com>
 <Pine.LNX.4.63.0602141953000.22451@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ian Molton <spyro@f2s.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 20:52:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F96EN-0007L8-4Y
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 20:52:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422770AbWBNTwe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 14:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422772AbWBNTwd
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 14:52:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3474 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422770AbWBNTwc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2006 14:52:32 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1EJqRDZ028268
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 14 Feb 2006 11:52:28 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1EJqQxK023773;
	Tue, 14 Feb 2006 11:52:27 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0602141953000.22451@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16163>



On Tue, 14 Feb 2006, Johannes Schindelin wrote:
> 
> Point is, if you want to read your email on different computers (like one 
> desktop and one laptop), you are quite well off managing them with git. Of 
> course, you could rsync them from/to the other computer. But rsync is slow 
> once you accumulated enough files, since it has to compare the hashes of 
> tons of files (or file chunks). Git knows if they have changed.

Yes. I actually think that git would be a _wonderful_ email tracking tool, 
but that may not mean that it's a wonderful tool for tracking all 
particular email layout possibilities. It clearly is _not_ a wonderful 
tool for tracking mbox-style email setups, for example ;)

I suspect we actually could make the "one linear directory" setup perform 
pretty well. It wouldn't be the best possible layout (by far), but I think 
our problems there are just because of some decisions we've (me, mostly) 
made that didn't take that layout into account. I don't think the problems 
are in any way fundamental.

That said, I think git could do much better if the layout was optimized 
for git. For example, in the maildir thing, there's two issues: the flat 
directory structure is sub-optimal, but the other thing seems to be that 
maildir apparently saves metadata in the filename.

Saving meta-data in the filename should actually work wonderfully well 
with git, but both merging and git-diff-tree consider the filename to be 
the "index", so they optimize for that. You could do indexing the other 
way around, and consider the contents to be the index (and the filename is 
the "status"), but that's obviously not sane for a sw project, even if it 
might be exactly what you want to do for mail handling.

		Linus
