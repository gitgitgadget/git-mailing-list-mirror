From: Mark Nudelman <markn@greenwoodsoftware.com>
Subject: Re: [Announce] GIT v1.5.0-rc2
Date: Mon, 26 Mar 2007 17:07:55 -0700
Message-ID: <4608605B.7050105@greenwoodsoftware.com>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net> <eovccc$usc$1@sea.gmane.org> <Pine.LNX.4.63.0701211207500.22628@wbgn013.biozentrum.uni-wuerzburg.de> <17846.20498.635623.173653@lisa.zopyra.com> <Pine.LNX.4.64.0701231157430.32200@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Bill Lear <rael@zopyra.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Mar 27 02:13:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVzJC-0004OZ-SZ
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 02:13:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933786AbXC0AM6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 20:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933853AbXC0AM6
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 20:12:58 -0400
Received: from alnrmhc13.comcast.net ([204.127.225.93]:36876 "EHLO
	alnrmhc13.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933786AbXC0AM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 20:12:57 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Mar 2007 20:12:57 EDT
Received: from [192.168.1.143] (c-24-6-147-161.hsd1.ca.comcast.net[24.6.147.161])
          by comcast.net (alnrmhc13) with ESMTP
          id <20070327000754b13009lbite>; Tue, 27 Mar 2007 00:07:55 +0000
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
In-Reply-To: <Pine.LNX.4.64.0701231157430.32200@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43215>

Hi all,
I'm not sure if you are still interested in this, but I have posted a 
beta release of less (less-401) which I believe fixes both of these 
problems.  See http://www.greenwoodsoftware.com/less.  If you try it, 
let me know how it works for you.

--Mark


On 1/23/2007 12:32 PM, Linus Torvalds wrote:
> [ Added "less" author Mark Nudelman to Cc: ]
> 
> On Tue, 23 Jan 2007, Bill Lear wrote:
>> I can't seem to get this to work, no matter what I do, using the
>> latest 1.5.0-rc2 code.  I have the environment variables LESS, PAGER,
>> PAGER_FLAGS, and I can't seem to get 'git diff' to not plough through
>> my screen each time it is run, no matter the combinations...  Could
>> someone post the magic?
> 
> I think "less" is actually seriously buggy with -F.
> 
> There are two bugs:
> 
>  - it will always screw up the screen and move to the end. It does this 
>    even if you use -FX which should disable any init sequences, so it's 
>    not about that problem.
> 
>  - if you resize the terminal while less is waiting for input, less
>    will exit entirely without even showing the output. This is very
>    noticeable if you do something like "git diff" on a big and cold-cache 
>    tree and git takes a few seconds to think, and then you resize the 
>    window while it's preparing. Boom. No output AT ALL.
> 
> Both bugs are easily seen with this simple command line
> 
> 	clear ; (sleep 5 ; echo Hello) | less -F
> 
> where you would EXPECT that the "Hello" would show up at the first line of 
> the screen (since we cleared the screen and moved to the top left corner), 
> but in fact it doesn't.
> 
> And try resizing the terminal to make it bigger during the five-second 
> pause, and now you'll see less not show the "Hello" at _all_. It's just 
> gone (this is true even if the output was _more_ than a screen: try with
> 
> 	(sleep 10 ; yes ) | less -F
> 
> and resize the screen, and it will exit silently after 10 seconds - never 
> showing any output at all! Even though the output is obviously bigger than 
> a screen..
> 
> Tested with Kterm, gnome-terminal and xterm. They all behave the same for 
> me.
> 
> I don't know exactly what the bug is, but I find the "eof" handling very
> confusing in the less sources. It makes me suspect that there is something 
> that gets confused by the partial read, sets EOF (since we're on the last 
> line), and then thinks that it should quit, since EOF is set.
> 
> I dunno. Mark?
> 
> 		Linus
> 
