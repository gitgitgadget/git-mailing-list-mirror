From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Switching from CVS to GIT
Date: Tue, 16 Oct 2007 15:50:18 +0200
Message-ID: <26554F2D-B44D-4691-A696-9B6924E08599@zib.de>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org> <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr> <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site> <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site> <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org> <Pine.LNX.4.64.0710151859590.7638@iabervon.org> <uodezisvg.fsf@gnu.org> <471448D0.6080200@op5.se> <2EA3BEC9-5B13-44D3-B190-CA77499F642C@zib.de> <Pine.LNX.4.64.0710161331440.25221@racer.site> <4D822762-D344-465E-B77D-90A64D61F5A9@zib.de> <Pine.LNX.4.64.0710161419140.25221@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Eli Zaretskii <eliz@gnu.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Alex Riesen <raa.lkml@gmail.com>, tsuna@lrde.epita.fr,
	Andreas Ericsson <ae@op5.se>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 16 15:50:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhmoA-0003cA-UJ
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 15:50:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbXJPNtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 09:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932642AbXJPNtz
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 09:49:55 -0400
Received: from mailer.zib.de ([130.73.108.11]:55737 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932640AbXJPNty (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 09:49:54 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9GDmnYo021140;
	Tue, 16 Oct 2007 15:49:46 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9GDmmgU023899
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 16 Oct 2007 15:48:48 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0710161419140.25221@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61172>


On Oct 16, 2007, at 3:21 PM, Johannes Schindelin wrote:

> Hi,
>
> On Tue, 16 Oct 2007, Steffen Prohaska wrote:
>
>> On Oct 16, 2007, at 2:33 PM, Johannes Schindelin wrote:
>>
>>>> Maybe we need a configuration similar to core.autocrlf (which  
>>>> controls
>>>> newline conversion) to control filename comparison and  
>>>> normalization?
>>>>
>>>> Most obviously for the case (in-)sensitivity on Windows, but I also
>>>> remember the unicode normalization happening on Mac's HFS  
>>>> filesystem
>>>> that caused trouble in the past.
>>>
>>> Robin Rosenberg has some preliminary code for that.  The idea is  
>>> to wrap
>>> all filesystem operations in cache.h, and do a filename  
>>> normalisation
>>> first.
>>
>> At that point we could add a safety check. Paths that differ only by
>> case, or whitespace, or ... (add general and project specific  
>> rules here)
>> should be denied. This would guarantee that tree objects can  
>> always be
>> checked out. Even if the filesystem capabilities are limited.
>
> This would be an independent change.  The method I talked about  
> only ever
> looks at one filename, never what is already there.

Oh, hmm ... obviously, ... if I think about it ;)


> What you want would probably be all too easy with a pre-commit  
> hook.  No
> need to clutter the git-core with code that is usually not needed  
> (you'd
> only ever activate it on Linux when other developers use Windows or
> MacOSX).

Personally, I'd be very happy if git enforced the minimal consent  
between
(supported) filesystems and provided a system to guarantee that I can  
only
create tree objects that can be checked out on all (supported)  
filesystems.

I'd _always_ switch on such a mechanism. I think the idea of relying on
filenames that only differ by whitespace or case is insane  
independent of
the capabilities of the filesystem used. Humans hardly see such  
differences.
There may be other characters that should be avoided purely for  
technical reasons. If git checked this, too, I'd be happy.

An update hook is only very loosely coupled to git. I'd prefer a tighter
integration. 'git add <something>' should immediately report the  
problem.
But, maybe I'll try a commit hook first.

	Steffen
