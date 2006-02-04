From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: The merge from hell...
Date: Sat, 4 Feb 2006 11:42:57 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602041125440.3854@g5.osdl.org>
References: <Pine.LNX.4.64.0602012212200.21884@g5.osdl.org>
 <7v8xsuuto5.fsf@assigned-by-dhcp.cox.net> <17380.34301.584514.520465@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Marco Costalba <mcostalba@yahoo.it>,
	Aneesh Kumar <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 20:43:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5TJu-0007yU-Dn
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 20:43:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbWBDTnJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 14:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964792AbWBDTnJ
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 14:43:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59611 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964786AbWBDTnH (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Feb 2006 14:43:07 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k14JgxDZ030996
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 4 Feb 2006 11:42:59 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k14JgvWU004532;
	Sat, 4 Feb 2006 11:42:57 -0800
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17380.34301.584514.520465@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15598>



On Sat, 4 Feb 2006, Paul Mackerras wrote:
> 
> > But this is still interesting:
> > 
> > @@@@@@@@@@@@@ +308,35 @@@@@@@@@@@@@
> >             			goto end;
> >             		}
> >             	}
> >   --        	cx->usage++;
> >   --        
> >             
> >      +++    #ifdef CONFIG_HOTPLUG_CPU
> >      +++    	/*
> 
> Why is that interesting?  It seems to me that two independent changes
> were made that just happened to be within a couple of lines of each
> other, but didn't interact.

Correct. It's "interesting" only because the context of three lines 
overlapped. So _technically_ it's not that interesting.

> The reason that one change appears in two branches, and the other in 3, 
> is I think just related to where the branches start from.  So IMHO this 
> hunk isn't interesting.

I actually think that whenever there are edits this close (even if they 
aren't strictly overlapping) they actually _are_ interesting. Even if it 
merged automatically, you may well want to know that the automated merge 
did something like this.

Doing a 

	git-rev-list --parents HEAD |
		egrep '^.{90}' |
		cut -d' ' -f1 | 
		git-diff-tree --pretty --cc --stdin
		| less -S

on the kernel is actually interesting. It's interesting because it shows 
that out of 1391 merges, in the kernel, only _19_ actually had these close 
calls. Some - but certainly not all - of them actually did need manual 
fixup.

So I actually prefer the "show close misses" case. But I guess we could 
have a "-cN" line to tell how many lines of context to use..

		Linus
