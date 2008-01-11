From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: CRLF problems with Git on Win32
Date: Fri, 11 Jan 2008 18:56:49 +0100
Message-ID: <930EC77A-73D1-4DDD-81D4-BF22B248FCB6@zib.de>
References: <C3AC3E6F.10D42%jefferis@gmail.com> <alpine.LFD.1.00.0801101556380.3148@woody.linux-foundation.org> <7EAB1DA8-627D-455E-AA23-C404FDC615D9@zib.de> <alpine.LFD.1.00.0801110756260.3148@woody.linux-foundation.org> <D36EB89D-11A3-4EAF-BC1C-6100383FCBFC@zib.de> <alpine.LFD.1.00.0801110924380.3148@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Gregory Jefferis <jefferis@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 11 18:58:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDO8y-0005wE-2C
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 18:58:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761499AbYAKR5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 12:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760766AbYAKR5q
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 12:57:46 -0500
Received: from mailer.zib.de ([130.73.108.11]:45705 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759542AbYAKR5p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 12:57:45 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0BHtkpX019249;
	Fri, 11 Jan 2008 18:55:46 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0BHtk3r009912
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 11 Jan 2008 18:55:46 +0100 (MET)
In-Reply-To: <alpine.LFD.1.00.0801110924380.3148@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70180>


On Jan 11, 2008, at 6:25 PM, Linus Torvalds wrote:

>
>
> On Fri, 11 Jan 2008, Steffen Prohaska wrote:
>>>
>>> No. What would it help?
>>
>> You may later decide that you want to check out your project on  
>> Windows.
>> In this case your repository should not contain CRLF.  autocrlf=input
>> ensures this.
>
> But under Unix, it would never do that *anyway*, unless the file  
> for some
> reason really needs it (which I cannot imagine, but I've never seen
> anything so craptastically stupid that some crazy person hasn't  
> done it)
>
> So your argument is bogus.

Ah sorry, I misunderstood you in [1].  I thought your last point
"Mixed Windows usage" meant what I have in mind:  A user working
in a mixed Windows/Unix environment who creates a file using
Windows tools and commits it in the Unix environment.  In this
case the CRLF file will be transferred from Windows to Unix
without git being involved.  The right thing for git on Unix is
to remove CRLF during a commit but still write only LF during
check out.  So autocrlf=input is the right choice.

[1] http://article.gmane.org/gmane.comp.version-control.git/70082

It happens that people working in a mixed environment do such things.
They just copy files from Windows to Unix and commit there.  Not very
often, but it happens.  So it would be nice if git would handle this
situation and it actually can by setting autocrlf=input.

My point is that perfect support for mixed environments requires
that git removes CRLF from any input on any platform.  However,
git should behave differently during checkout.  In this case the
native line ending should be written (LF on Unix, CRLF on
Windows).  The difference happens during check out; commit should
be handled identically.

	Steffen
