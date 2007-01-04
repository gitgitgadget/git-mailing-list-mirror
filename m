From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 5/5] git-add: add ignored files when asked explicitly.
Date: Thu, 04 Jan 2007 14:58:57 +0100
Message-ID: <459D0821.10204@op5.se>
References: <7vbqlskz2u.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.63.0612251443230.19693@wbgn013.biozentrum.uni-wuerzburg.de> <7vslf3khsc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 04 14:59:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2T7Y-0003jb-Sb
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 14:59:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbXADN7A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 08:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbXADN7A
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 08:59:00 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:53032 "EHLO
	smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964858AbXADN67 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 08:58:59 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 3CE496BCC4; Thu,  4 Jan 2007 14:58:58 +0100 (CET)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslf3khsc.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35931>

Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> On Mon, 25 Dec 2006, Junio C Hamano wrote:
>>
>>>     $ git add foo.o
>>>     $ git add '*.o'
>> Most people do
>>
>> 	$ git add *.o
>>
>> instead, where bash expands the expression. Maybe this new behaviour 
>> should be hidden between a "-f" option?
> 
> When would anybody do "git add *.o"?
> 

Make that "git add *.c" then, in a directory normally containing a lot 
of generated C-files.

> 
> An alternative is to use the mechanism I added here to _detect_
> the attempt to add an ignored file with explicitly spelled out
> pathspec, and issue an info message that says something like:
> 
> 	Path 'xyzzy/filfre.o' is not being ignored by one of
> 	your .gitignore files.  If you really want to add it,
> 	please add this entry to .gitignore file:
> 
>         !/xyzzy/filfre.o
> 

Sounds very sensible to me, although I assume you meant "path 
xyzzy/filfre.o is being ignored" (ie, "is not being ignored" (sic) was a 
typo).


> One advantage of this is that it would help guiding the user in
> the right direction, giving a reusable piece of knowledge,
> without changing the behaviour of the command (what is refused
> is refused).  But I can already see people's complaints: if the
> tool knows how to fix that situation why forces the user to do
> so?
> 
> Although the reason why the alternative does not do so is "The
> user earlier said *.o files are uninteresting but came back with
> a conflicting request to add xyzzy/filfre.o, which could be a
> mistake.  We ask for a confirmation", which is very sensible,

Very sensible indeed. If you tell a cabdriver "go-left-go-right" (very 
fast) he'll (hopefully) stop and ask you where you really wanted to go.

> another alternative would be to add the path anyway and issue an
> warning, like this:
> 
> 	$ ls xyzzy
>         filfre.c	filfre.o
> 	$ git add xyzzy/filfre.?
> 	added ignored path xyzzy/filfre.o
> 

I like the "you did something weird. Education served" option better.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
