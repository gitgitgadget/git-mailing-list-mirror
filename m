From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git binary size...
Date: Thu, 12 Jan 2006 10:46:48 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601121033020.3535@g5.osdl.org>
References: <Pine.LNX.4.64.0601111021450.5073@g5.osdl.org>  <43C558FB.3030102@op5.se>
  <Pine.LNX.4.64.0601111134560.5073@g5.osdl.org> <2cd57c900601120215pdb5da27l@mail.gmail.com>
 <43C65E70.7090702@op5.se> <Pine.LNX.4.64.0601121013030.3535@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 12 19:47:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ex7TQ-0003Aq-81
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 19:47:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932650AbWALSqw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 13:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932656AbWALSqw
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 13:46:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32470 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932650AbWALSqw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jan 2006 13:46:52 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0CIknDZ004233
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 12 Jan 2006 10:46:49 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0CIkm8O032330;
	Thu, 12 Jan 2006 10:46:48 -0800
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <Pine.LNX.4.64.0601121013030.3535@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14576>



On Thu, 12 Jan 2006, Linus Torvalds wrote:
> 
> Repeat after me: "autoconf is crap".

.. which is not to say that some _other_ autoconf-like thing might not be 
good.

The problem I have with autoconf is that it adds absolutely horrendous 
#ifdef's etc all over the place, and the resulting makefile (and the 
config file itself) is just completely unreadable.

The reason autoconf sucks *ss is that it doesn't try to abstract out any 
of the differences between systems, it tries to basically "fix up" the 
differences.

A real abstraction library would be a lot more preferable than autoconf. 
It's kind of the way the git stuff works (ie using things like 
"gitstrcasestr()" and "gitfakemmap()"), but for many of the same reasons 
that autoconf never did a good job, git itself doesn't do a good job (it 
uses "#if" hackery to then do things like "#define mmap gitfakemmap").

But I think the git kind of hackish #ifdef thing is better than the 
_insitutionalized_ horrible autoconf hackery.

There are real abstraction layers out there, but they usually do a lot 
more than just simple autoconf things. They do full system abstraction, 
usually with support for graphical GUI stuff too: layers like Qt, 
wxVidgets, whatever..

Now THAT is a good approach. 

Sadly, for the git kind of area, I don't know of any sane toolkits like 
that. The "gnulib" project could have been something, but it has been 
corrupted by the autoconf disease, as far as I can tell.

Anyway, it _should_ be possible to make a nice "extended posix wrapper" 
with just a single

	#include "libposix.h"

and having a per-system "posix header" that resolves all the stupid header 
file differences, and a "posix library" that adds (or fixes) all the posix 
problems for each platform.

Instead, people still use autoconf ;(

                 Linus
