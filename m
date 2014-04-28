From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] poll/select: prevent busy-waiting
Date: Mon, 28 Apr 2014 17:05:47 +0200
Message-ID: <535E6E4B.6070308@viscovery.net>
References: <20140428083931.GA10257@camelia.ucw.cz> <CABPQNSaC30p7TEOvc85u=+skjrFj17182vWWSL=QNVuvzVFE=w@mail.gmail.com> <20140428113815.GA10559@camelia.ucw.cz> <20140428114224.GA11186@camelia.ucw.cz> <CABPQNSbDkE+Vff=4MmPO9oMfjRay6Oin51zZRoZ8mOEhGoaD3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Stepan Kasal <kasal@ucw.cz>,
	GIT Mailing-list <git@vger.kernel.org>,
	Theodore Leblond <theodore.leblond@gmail.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Apr 28 17:06:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wen8F-0007Lz-3f
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 17:06:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbaD1PF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 11:05:58 -0400
Received: from so.liwest.at ([212.33.55.14]:45824 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756602AbaD1PFy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 11:05:54 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Wen7s-0003XQ-ES; Mon, 28 Apr 2014 17:05:49 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id E14CE16613;
	Mon, 28 Apr 2014 17:05:47 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <CABPQNSbDkE+Vff=4MmPO9oMfjRay6Oin51zZRoZ8mOEhGoaD3Q@mail.gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247353>

Am 4/28/2014 13:44, schrieb Erik Faye-Lund:
> On Mon, Apr 28, 2014 at 1:42 PM, Stepan Kasal <kasal@ucw.cz> wrote:
>> From: Paolo Bonzini <bonzini@gnu.org>
>> Date: Mon, 21 May 2012 09:52:42 +0200
>>
>> Backported from Gnulib.
>>
>> 2012-05-21  Paolo Bonzini  <bonzini@gnu.org>
>>
>>         poll/select: prevent busy-waiting.  SwitchToThread() only gives away
>>         the rest of the current time slice to another thread in the current
>>         process. So if the thread that feeds the file decscriptor we're
>>         polling is not in the current process, we get busy-waiting.
>>         * lib/poll.c: Use SleepEx(1, TRUE) instead of SwitchToThread().
>>         Patch from Theodore Leblond.
>>         * lib/select.c: Split polling out of the loop that sets the output
>>         fd_sets.  Check for zero result and loop if the wait timeout is
>>         infinite.
>>
>> Signed-off-by: Stepan Kasal <kasal@ucw.cz>
>> ---
>>  compat/poll/poll.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/compat/poll/poll.c b/compat/poll/poll.c
>> index 31163f2..a9b41d8 100644
>> --- a/compat/poll/poll.c
>> +++ b/compat/poll/poll.c
>> @@ -605,7 +605,7 @@ restart:
>>
>>    if (!rc && timeout == INFTIM)
>>      {
>> -      SwitchToThread();
>> +      SleepEx (1, TRUE);
>>        goto restart;
>>      }
>>
>> --
>> 1.9.2.msysgit.0.158.g6070cee
>>
> 
> Thanks for taking the effort!
> 
> Acked-by: Erik Faye-Lund <kusmabite@gmail.com>

The patch text has my ACK, too (I've been using it since 2 years now), but
I very much prefer the commit message of the earlier post. GNU standards
w.r.t. commit messages are simply sub-par. ;-)

-- Hannes
