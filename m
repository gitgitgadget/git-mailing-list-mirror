From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] Re: [PATCH/RFC] mingw: implement PTHREAD_MUTEX_INITIALIZER
Date: Tue, 25 Oct 2011 23:13:34 +0200
Message-ID: <4EA7267E.1080103@kdbg.org>
References: <1319554509-6532-1-git-send-email-kusmabite@gmail.com> <4EA6D594.90402@viscovery.net> <CABPQNSZ8wesy-px-n1LYbVwFT3gBNcrHfe+_553sinTferqsog@mail.gmail.com> <4EA716FC.2010804@kdbg.org> <CABPQNSY6-j7iNagsJc3WKVZ94=yZHdfBswA-v0XY7vH+RxyjYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org,
	johannes.schindelin@gmx.de
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Oct 25 23:13:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIoJb-0003gi-5H
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 23:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753517Ab1JYVNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Oct 2011 17:13:38 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:19245 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753446Ab1JYVNh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2011 17:13:37 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id EE6AEA7EBB;
	Tue, 25 Oct 2011 23:13:40 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id F17A019F4A8;
	Tue, 25 Oct 2011 23:13:34 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.23) Gecko/20110920 SUSE/3.1.15 Thunderbird/3.1.15
In-Reply-To: <CABPQNSY6-j7iNagsJc3WKVZ94=yZHdfBswA-v0XY7vH+RxyjYQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184239>

Am 25.10.2011 22:51, schrieb Erik Faye-Lund:
> On Tue, Oct 25, 2011 at 10:07 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> HOWEVER, when it continues, there is NO [*] guarantee that it will also
>> see the values that InitializeCriticalSection() has written, because
>> there were no memory barriers involved. When it continues, there is a
>> chance that it calls EnterCriticalSection() with uninitialized values!
>>
> 
> Thanks for pointing this out, I completely forgot about write re-ordering.
> 
> This is indeed a problem. So, shouldn't replacing "mutex->autoinit =
> 0;" with "InterlockedExchange(&mutex->autoinit, 0)" solve the problem?
> InterlockedExchange generates a full memory barrier:
> http://msdn.microsoft.com/en-us/library/windows/desktop/ms683590(v=vs.85).aspx

That should do it.

>> [*] If you compile this code with MSVC >= 2005, "No guarantee" is not
>> true, it's exactly the opposite because Microsoft extended the meaning
>> of 'volatile' to imply a memory barriere.
> 
> Do you have a source for this? I'm not saying it isn't true, I just
> never heard of this, and would like to read up on it :)

http://msdn.microsoft.com/en-us/library/ms686355%28VS.85%29.aspx

-- Hannes
