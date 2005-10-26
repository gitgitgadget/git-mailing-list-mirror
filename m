From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 0.99.9 on Saturday next week.
Date: Wed, 26 Oct 2005 10:55:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510261046570.10477@g5.osdl.org>
References: <7vvezpetpv.fsf@assigned-by-dhcp.cox.net> <tnx64rlrjux.fsf@arm.com>
  <7virvlh6m5.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.64.0510251033310.10477@g5.osdl.org>
 <b0943d9e0510260450k624268aav@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 19:59:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUpVH-0008Vp-U7
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 19:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbVJZRzx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 13:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbVJZRzx
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 13:55:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44416 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964846AbVJZRzx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Oct 2005 13:55:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9QHtkFC005761
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 26 Oct 2005 10:55:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9QHtiNK006794;
	Wed, 26 Oct 2005 10:55:45 -0700
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <b0943d9e0510260450k624268aav@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10684>



On Wed, 26 Oct 2005, Catalin Marinas wrote:
> 
> I use Python for StGIT and it has support for parsing .ini syntax, no
> need to use GIT for this (unless the syntax you chose would diverge
> too much).

The syntax differences I'm aware of:

 - the git ".ini" parser is case-insensitive in the variable names. I 
   don't know if this is true in general. I do know a lot of people use 
   MixedCase things, but I don't know if it's because they care, or 
   because they think it's so pretty.

 - the git parser accepts either ";" or "#" as comments, and anywhere on a 
   line (not just at the beginning). Again, others may or may not do the 
   same.

 - the git parser wants a "=" for the assignment. I think the Python one 
   also accepts ":". If people care, we could make the git parser allow 
   either.

 - duplicate entries. The git parser allows them, and will just pass them 
   on multiple times. In fact, I had a patch (that I threw out) that 
   depended on this, and allowed you to rewrite hostnames for git_connect 
   with something like

	[host]
		rewrite = "host.com:" "git://git.host.com/"
		rewrite = "other.org:" "rsync://rsync.other.org/"

   and the git config file parser happily just parses this as two 
   different entries for "host.rewrite"

 - quoting. This is likely the big one. The git parser thinks only the 
   regular '"' character ("rabbit ears") is a quote, and passes single- 
   ticks through unmolested. I don't have a clue what others do, if 
   anything.

In the absense of quotes, most should be trivial to handle by just being 
careful.

		Linus
