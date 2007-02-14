From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Error converting from 1.4.4.1 to 1.5.0?
Date: Wed, 14 Feb 2007 10:42:15 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702141033400.3604@woody.linux-foundation.org>
References: <17875.13564.622087.63653@lisa.zopyra.com>
 <7vhctor78j.fsf@assigned-by-dhcp.cox.net> <17875.17647.74882.218627@lisa.zopyra.com>
 <Pine.LNX.4.64.0702140958440.3604@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Feb 14 19:42:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHP5J-0001jf-Ez
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 19:42:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbXBNSmU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 13:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbXBNSmU
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 13:42:20 -0500
Received: from smtp.osdl.org ([65.172.181.24]:38884 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932088AbXBNSmT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 13:42:19 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1EIgGhB011310
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Feb 2007 10:42:16 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1EIgFmm005486;
	Wed, 14 Feb 2007 10:42:16 -0800
In-Reply-To: <Pine.LNX.4.64.0702140958440.3604@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.408 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.117__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39723>



On Wed, 14 Feb 2007, Linus Torvalds wrote:
> 
> And if you can make the git history available to outsiders, I'd love to 
> see the corrupt tar-file (it doesn't have to be *public*, if you just can 
> trust me and perhaps a few other people with the data).

Side note: one reason why this is nice - even if you don't care about the 
corruption and can fix it other ways - is that the last time we had the 
one-bit corruption is also the reason why we now have the "-r" option to 
git-unpack-objects.

In other words, real-life corruption is not just a really nasty event, 
it's also a good way for *us* to verify that our recovery tools do as good 
a job as they possibly can. Maybe there are other things like that "-r" 
option where we could possibly do even better.

The git data structures are designed to be extremely robust, but there's 
nothing they can do about "corruption after the fact". The same way that a 
logging filesystem doesn't help if the disk itself starts getting read 
errors, the git data structures aren't going to guarantee that you can't 
lose data if you have actual disk or memory corruption going on. 

The things git can do is:

 - detection. The SHA1's should basically guarantee that you will never 
   ever have an _undetectable_ corruption anywhere (which is really really 
   easy with just about any other SCM)

 - make replication easy (so that once you've detected corruption, you 
   have mirrors you can trust).

 - and finally: in the absense of replication, we can do  our damndest to 
   try to figure out what the data was. But in many ways, the fact that we 
   are really really good at compressing data (people do love their small 
   repositories) also means that we have basically no redundancy anywhere, 
   because redundancy is what compression gets rid of (both delta- and 
   zlib compression do it - it's very fundamentally what any compression 
   is based on)

but it's always interesting to have real-life corruption cases to verify.

			Linus
