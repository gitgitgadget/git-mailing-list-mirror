From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/5] MSVC: Windows-native implementation for subset of Pthreads API
Date: Wed, 13 Jan 2010 19:40:43 +0100
Message-ID: <201001131940.43868.j6t@kdbg.org>
References: <cover.1262895936.git.j6t@kdbg.org> <201001122213.38287.j6t@kdbg.org> <20100113125312.GD10586@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: kusmabite@gmail.com, msysgit <msysgit@googlegroups.com>,
	git@vger.kernel.org, "Andrzej K. Haczewski" <ahaczewski@gmail.com>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 19:41:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV8A8-0006V0-BJ
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 19:41:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504Ab0AMSlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 13:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402Ab0AMSlm
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 13:41:42 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:39913 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750908Ab0AMSll (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 13:41:41 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id F04E9A7F30;
	Wed, 13 Jan 2010 19:41:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 6721119F5F2;
	Wed, 13 Jan 2010 19:40:44 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <20100113125312.GD10586@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136854>

On Mittwoch, 13. Januar 2010, Dmitry Potapov wrote:
> On Tue, Jan 12, 2010 at 10:13:38PM +0100, Johannes Sixt wrote:
> > In particular, it doesn't say that it is atomic WRT reads such as we have
> >
> > here:
> > > >> +     /* we're done waiting, so make sure we decrease waiters count
> > > >> */ +     EnterCriticalSection(&cond->waiters_lock);
> > > >> +     --cond->waiters;
> > > >> +     LeaveCriticalSection(&cond->waiters_lock);
>
> and these lines should be replaced with
>
>   InterlockedDecrement(&cond->waiters)

Ah, yes, of course. I quoted the wrong section, sorry. By "atomic WRT reads" I 
meant this snippet:

>> +     EnterCriticalSection(&cond->waiters_lock);
>> +     have_waiters = cond->waiters > 0;
>> +     LeaveCriticalSection(&cond->waiters_lock);

Is there "InterlockedRead()"? I suppose no, but I would get confirmation that 
a simple memory mov instruction is atomic WRT Interlocked* functions.

-- Hannes
