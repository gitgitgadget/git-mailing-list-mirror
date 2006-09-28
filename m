From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git and time
Date: Thu, 28 Sep 2006 11:01:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609281043380.3952@g5.osdl.org>
References: <20060928173350.95443.qmail@web51004.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Rogan Dawes <discard@dawes.za.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 20:02:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT0Cw-0001TV-5k
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 20:02:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbWI1SB7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 14:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751964AbWI1SB7
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 14:01:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21212 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751966AbWI1SB6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Sep 2006 14:01:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8SI1unW023159
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 28 Sep 2006 11:01:56 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8SI1tKE017136;
	Thu, 28 Sep 2006 11:01:56 -0700
To: Matthew L Foster <mfoster167@yahoo.com>
In-Reply-To: <20060928173350.95443.qmail@web51004.mail.yahoo.com>
X-Spam-Status: No, hits=-0.46 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.154 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28027>



On Thu, 28 Sep 2006, Matthew L Foster wrote:
> 
> It should be possible to export git data, through say a web interface, 
> in a such a way that local time order is consistent with commit order.

I really don't think the thing you ask for exists.

Don't get me wrong. You _can_ have a local time for each commit that 
tracks "when did this commit show up in this particular branch". Git 
already supports that, even if gitweb cannot show it, and in fact showing 
it would be very hard (since the exact same commit can often exist in 
multiple different branches, you'd have to show multiple times: in Junios 
"git" tree you often have a commit that showed up in the "next" branch 
three weeks ago, but in the "master" branch only yesterday).

The _problem_ with this is that it makes the whole concept of time 
meaningless. It's pointless. You can do it, but I guarantee you that once 
you actually use it for a while, you'll want to go back. There are several 
reasons for that:

 - it means that the -same- exact project, when looked at frm two 
   different sites that mirror it, have totally different times. In other 
   words, the times have become pointless for something like gitweb.

 - it means that all times will be seriously "compressed", in that you'll 
   find hundreds (or thousands) of commits that just have the same 
   timestamp. You could try to "spread them out" by just making up some 
   totally arbitrary mapping function, but that would basically have 
   absolutely no basis in anything that has any relationship to "reality"

So it just doesn't make any sense.

The only thing that makes sense is that in your private repository (that 
is _not_ exported to others through "gitweb" or something like that), you 
can ask yourself the question:

	"What did my tree look like yesterday before I went out for a 
	 beer, and came back drunk as a toad, and screwed everything up?"

And the thing is, you can do that already. Just say

	git log "master@{18 hours ago}"

and git will hopefully show you (assuming you had enabled ref-logging as 
described earlier in this thread) exactly what you wanted.

See? 

But it does not make sense in _any_ other setting. Certainly not gitweb.

			Linus
