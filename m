From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0 of 7] [resend] - Improve handling remotes, origin,
 submodules
Date: Mon, 4 Feb 2008 20:47:26 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802042027470.8543@racer.site>
References: <1202059867-1184-1-git-send-email-mlevedahl@gmail.com> <alpine.LSU.1.00.0802032237320.7372@racer.site> <47A68C01.9000600@gmail.com> <alpine.LSU.1.00.0802041443420.7372@racer.site> <30e4a070802040924g550671ccsb11108c71c99e378@mail.gmail.com>
 <7vbq6wjxx1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 21:48:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM8F6-0003JY-QL
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 21:48:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756532AbYBDUsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 15:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756493AbYBDUsH
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 15:48:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:56507 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755369AbYBDUsE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 15:48:04 -0500
Received: (qmail invoked by alias); 04 Feb 2008 20:48:03 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp024) with SMTP; 04 Feb 2008 21:48:03 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19+Yess/p9+YeKO8ugd0JssznMDw97z9qlxz4Oy84
	aWAQy8zqDlmPXl
X-X-Sender: gene099@racer.site
In-Reply-To: <7vbq6wjxx1.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72561>

Hi,

On Mon, 4 Feb 2008, Junio C Hamano wrote:

> I would agree 100% with Dscho on this point, if we did not have "clone 
> -o".

AFAICT "clone -o" was meant _only_ for this scenario:

You have a slow connection, but someone can provide you with a thumb 
drive, having the current repository.

You clone it from the thumb drive, but of course you want to use your 
(slow) connection for subsequent updates (i.e. you want to have a 
different default remote).

What you do is

	$ git clone -o thumbdrive /media/usbdisk/that-repository.git/

Then, to be able to update from your preferred remote quickly, you add the 
proper remote:

	$ git remote add --fetch origin git://git.kernel.org/shlub.git/

In my understanding, this scenario is the only reason to live for clone's 
-o option, and it would be actively wrong for it to change the _name_ of 
the default remote to "thumbdrive".

Now, Steffen understood that Mark tries to avoid the use of "origin".  
But why, then, does he wish for _the same_ kettle, but call it chair?

I mean, I can understand if you want to update your submodules from 
another server.  What I do then, is to go into that subdirectory, fetch 
from that other server, and that's it.

I can even understand that you have to update your submodules sometimes 
from here, sometimes from there.

Fine.  You just add remotes for the different servers, cd into the 
submodules, and fetch from them.

I could even see (but not use it myself) that you want to fetch a set of 
submodules from server A on Mondays, from server B on Tuesdays, and from 
server C on Wednesdays, and want to have a nice shortcut for that.  Of 
course, I'd use aliases.  But I can see that people want a "--remote" 
option to "git submodule update".

However, what I cannot see _at all_ is that you have a default remote in a 
set (or all) submodules, and wish to change a perfectly fine terminology 
[*1*].

I cannot see why you want to have a default remote to fetch from, and not 
call it "origin", which would keep things easy and simple.  "What is the 
remote called that 'git fetch' fetches from, by default?" -- "origin".

Simple.  Nice.  Consistent.

My understanding is that a patch is needed for _git-submodule_, to support 
that workflow (the one with servers A, B and C), even if I would not use 
that option.

What we do not need is to confuse git users, what with all those 
complaints that git is too complicated.

Hopefully I finally made myself clear.

Ciao,
Dscho

*1*: I heard the argument put forth that giving the default remote a 
different name, so that people know what server they pull from.  That's 
just, uh, unbelievable.  If it is the default remote the user is fetching 
from, all the user will call is "git fetch", and not even _know_ the 
nickname.

Besides, if you call it "berlin", the _url_ can still point to 
git://git.beijing.cn/great-wall.git/.

Another besides: if you ask the user to look up the nickname of the 
default remote, you can as well ask the user to look up the url of 
"origin".

There is _no need_ to complicate git for a workflow that could be solved 
in a more elegant and less error-prone way to begin with.

P.S.: sorry for this long mail.  I usually like to make a concise point.  
But in this discussion, it got me misunderstood, ignored, or both.
