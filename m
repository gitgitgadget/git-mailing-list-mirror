From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: CRLF problems with Git on Win32
Date: Fri, 11 Jan 2008 08:10:25 +0100
Message-ID: <7EAB1DA8-627D-455E-AA23-C404FDC615D9@zib.de>
References: <C3AC3E6F.10D42%jefferis@gmail.com> <alpine.LFD.1.00.0801101556380.3148@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Gregory Jefferis <jefferis@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 11 08:10:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDE1f-0001o2-2h
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 08:09:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757274AbYAKHJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 02:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757310AbYAKHJc
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 02:09:32 -0500
Received: from mailer.zib.de ([130.73.108.11]:40221 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756831AbYAKHJb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 02:09:31 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0B79LZL013466;
	Fri, 11 Jan 2008 08:09:22 +0100 (CET)
Received: from [192.168.178.21] (brln-4db96e40.pool.einsundeins.de [77.185.110.64])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0B79KA4028230
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 11 Jan 2008 08:09:21 +0100 (MET)
In-Reply-To: <alpine.LFD.1.00.0801101556380.3148@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70127>


On Jan 11, 2008, at 1:02 AM, Linus Torvalds wrote:

>
>
> On Thu, 10 Jan 2008, Gregory Jefferis wrote:
>>
>> So this is what has to be accommodated.  But instead of having  
>> autocrlf
>> always set on Windows and always converting to LF in the  
>> repository, why not
>> do nothing by default [ .. ]
>
> Why? You can screw yourself more, and much more easily (and much more
> subtly), by leaving CRLF alone on Windows.
>
> The thing is, 99.9% of all people will be *much* better off with
> autocrlf=true on Windows than with it defaulting to off (or even  
> fail).
>
> Isn't *that* the whole point of having a default? Pick the thing  
> that is
> the right thing for almost everybody?

Are you also for "autocrlf=input" as the default on Unix?  This
is the second half of the solution to the cross-platform problem ...


> And no, "but think of the children.." is not a valid argument.  
> Sure, you
> *can* corrupt binary imags with CRLF conversion. But it's really quite
> hard, since the git heuristics for guessing are rather good. You  
> really
> have to work at it, and if you do, you're pretty damn likely to  
> know about
> the issue, so that 0.1% that really needs to not convert (and it's  
> usually
> one specific file type!) would probably not even turn off CRLF, but  
> rather
> add a .gitattributes entry for that one filetype!

... and then Windows and Unix users would have the same chance of
data corruption.

Which is very low, yes, but unfortunately it already hit me once
and I didn't immediately recognized what happend.  I guess that
less experienced git used would have a harder time to understand.
However, I don't have a test case at hand.  I should probably
better go and find one.  So for now, you may just want to ignore
this comment.

Yet, I'm a bit paranoid about the potential data corruption.  The
way data would be corrupted during commit can't be easily fixed.
You only have a chance for fixing this if you recognize the
problem before you delete the file in your work tree.  But
because git is extremely good at preserving your data once you
committed a file, I tend to feel _very_ safe after I committed and
I am teaching all people that once they committed data to git
they'll not loose it until the reflog expires (well and obviously
they must not delete .git).


> (Side note: if there are known filetype extensions that have  
> problems with
> the git guessing, we sure as heck could take the filename into account
> when guessing! There's absolutely nothing that says that we only  
> have to
> look at the contents when guessing about the text/binary thing!)

Looking on the content seems the right thing to do.  The filetype
extension could be misleading.

Maybe a mechanism similar to the file command would be more
valuable.  I guess a stripped down variant should be sufficient.

	Steffen
