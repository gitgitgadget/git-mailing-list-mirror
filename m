From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: kompare won't parse git diffs
Date: Wed, 2 Aug 2006 10:19:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608021006150.4168@g5.osdl.org>
References: <200608021107.43485.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 02 19:20:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8KO1-0006TS-HR
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 19:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWHBRT5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 13:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWHBRT5
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 13:19:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63197 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751278AbWHBRT4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Aug 2006 13:19:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k72HJpnW016700
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 2 Aug 2006 10:19:53 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k72HJomZ026719;
	Wed, 2 Aug 2006 10:19:50 -0700
To: Andy Parkins <andyparkins@gmail.com>
In-Reply-To: <200608021107.43485.andyparkins@gmail.com>
X-Spam-Status: No, hits=-0.477 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.141 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24659>



On Wed, 2 Aug 2006, Andy Parkins wrote:
>
> Kompare just shows blank for diffs redirected from git. [ snip ]
> 
> As you can see, it's a simple addition of the line "blah".  Kompare shows this 
> diff as blank.  Now if I modify the file so that the "---" and "+++" lines 
> both have "<tab>(something)" added:

I'd definitely call this a pure kompare bug.

Not only is the git patch format perfectly standard and accepted by other 
tools, it's much better designed than the brain-damaged syntax that GNU 
patch uses (which adds a tab and a timestamp after the filenames). In 
particular, with git patches it is easy to get filenames that have spaces 
and tabs in them right. 

Now, if the kompare people can show that every single other patch 
generator adds the stupid tab + date format, I guess we could do it too, 
but
 (a) there is no valid date in general to use, so it's a fundamentally 
     broken notion and
 (b) I'm pretty sure that the kompare people only ever actually tested 
     with GNU patch or other very modern patches, because when I did the 
     patch apply logic (and designed the extended git format), I looked 
     around at things like "diffstat" that have been around a long time, 
     to see what they accept, and the whole thing is an unholy mess wrt 
     filenames.

The git format really is the best patch format I've seen by _far_, partly 
because it's designed to be totally unambiguous even in the presense of 
file renames (and new/deleted files, and file modes), but partly because 
it's also designed to be both extensible and detectable (ie the marker 
"diff --git " is there, so that you can _know_ and _depend_ on the git 
format, unlike, for example, the GNU patches that don't have a good fixed 
format).

I'm hoping that people will some day just wake up and notice that the git 
extended patches are really worth doing even for other projects. I was 
going to send in patches to GNU patch to try to make it at least 
understand them, but I got lazy.

		Linus
