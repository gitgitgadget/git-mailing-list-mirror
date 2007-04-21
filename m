From: David Lang <david.lang@digitalinsight.com>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Sat, 21 Apr 2007 16:31:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0704211620250.5655@qynat.qvtvafvgr.pbz>
References: <200704171041.46176.andyparkins@gmail.com> 
 <"200704171803.58940.andyparkins"@gmail.com> 
 <200704172012.31280.andyparkins@gmail.com><alpine.LFD.0.98.0704171530220.45
  04@xanadu.home><Pine.LNX.4.63.0704171244450.1696@qynat.qvtvafvgr.pbz> 
 <alpine.LFD.0.98.0704171624190.4504@xanadu.home><Pine.LNX.4.63.070417130220
 0.1696  @qynat.qvtvafvgr.pbz><alpine.LFD.0.98.0704171708360.4504@xanadu.home><7vy7k
 qlj5r.fsf@assigned-by-dhcp.cox.net><Pine.LNX.4.63.0704201605580.4634@qynat.
 qvtvafvgr.pbz> <7vbqhiwky4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Nicolas Pitre <nico@cam.org>, Andy Parkins <andyparkins@gmail.com>,
	git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 22 02:05:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfPZc-0002Ck-Ij
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 02:05:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbXDVAE5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 20:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752324AbXDVAE5
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 20:04:57 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:48758 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751690AbXDVAE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 20:04:57 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Sat, 21 Apr 2007 17:04:56 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Sat, 21 Apr 2007 17:04:24 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <7vbqhiwky4.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45198>

On Fri, 20 Apr 2007, Junio C Hamano wrote:

> David Lang <david.lang@digitalinsight.com> writes:
>
>>> But with keyword expansion and fancier "external tools" whose
>>> semantics are not well defined (iow, defined to be "do whatever
>>> they please"), does it still make sense to consider two blobs
>>> that appear in totally different context "the same" and omit
>>> checking out (and causing the external tools hook not getting
>>> run)?  I already pointed out to Andy that the branch name the
>>> file was taken from, if it were to take part of the keyword
>>> expansion, would come out incorrectly in his printed svg
>>> drawing.
>>
>> this is part of the rope you are handing out. the external tool could
>> do a lot of things that don't make sense. you could have the tool
>> include the serial number of the cpu you happen to be running on at
>> the moment, it wouldn't make sense to do this, but it could be
>> done. the fact that the rope could be used to hang someone doesn't
>> mean that you should outlaw rope.
>
> I do not think you understand, especially after reading the part
> you say "Andy and I both...".

sorry for not being clear

> The point of my comment was that with Andy's definition of when
> the "external tools" should trigger, that CPU serial number
> embedder would _NOT_ trigger for a path when you switch branches
> that have the same contents at that path.  External tools can do
> stupid things and that is what you are calling the rope.  But
> the case I am talking about is that we deliberately do _not_
> call external tools, so even if external tools can do sensible
> things if given a chance to, they are not given a chance to do
> so, and deciding not to call them in some cases is made by us.
> I think that's different from "we gave you rope, you hang
> yourself and that is not our problem".

the cpu serial number would be different for each cpu in a system, so you could 
get different answers, even in the same branch (let alone on different systems, 
which is what I was thinking of when I wrote that example)

my point was that while it's possible to define external tools that will cause 
problems (my having effectvly random changes to the files), and when external 
tools are used it will slow things down (how much depends on the tools), it's 
also possible to define external tools that only have well defined, easily 
reversable effects, that only touch a few files, and so don't cause a huge 
performance hit.

> People have every right to say "if you consistently call these
> external tools, they behave sensibly, but you only call them
> when you choose, and that is where the idiocy is coming from".
> How would you respond to that?

consistantly calling the external tools is not the same thing as calling them 
for every possible thing that refrences the file, it's calling them every time a 
particular type of access to the file is made (and it helps to have well defined 
and well documented rules for when they are used)

I think the basic rule of 'git commands work against the checked-in version of 
the file' is a solid basis to work from. This means that you can't optimize by 
sometimes looking at the checked-out version, and there may still be some corner 
cases to explain/clarify/define (like the git-diff against the working tree 
mentioned in other messages)

David Lang
