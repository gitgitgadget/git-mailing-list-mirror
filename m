From: "guo tang" <tangguo77@gmail.com>
Subject: Re: out of memory problem
Date: Wed, 24 Sep 2008 09:45:44 -0700
Message-ID: <4120f6ec0809240945t7b9313eagb1aa53f67ba9a76c@mail.gmail.com>
References: <alpine.LFD.2.00.0809211556030.19373@homelinux>
	 <48D749F7.3030008@op5.se>
	 <4120f6ec0809220828i3b38eda3tfc4974df8a2568cb@mail.gmail.com>
	 <48D89FB7.3000509@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git mailing list" <git@vger.kernel.org>
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Sep 24 18:47:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiXVw-0001Gf-4l
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 18:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537AbYIXQpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 12:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752549AbYIXQpr
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 12:45:47 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:63248 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419AbYIXQpq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 12:45:46 -0400
Received: by gxk9 with SMTP id 9so5886429gxk.13
        for <git@vger.kernel.org>; Wed, 24 Sep 2008 09:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=0PlwsxNmpVdo63lpe6wxSWADtB2mMI2CePZxe63/ChQ=;
        b=rI2pGujraSNAaTwwC1fBDsmRILWR36cy5FjC/cHcGoIKykk+7yoombiRhJ3dYm4tYa
         Le2oaZRUirJIj0Myu9xhZE+vdYOhEYgzkXMo2kgzN4ImtEf88uwkJHLIYTmpO0hsbVLD
         hM6lMp863uRbs9V5beT1IKZArsSMVzzcVMPgs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=VXbdI8YP2tQ/gYRqn/7MEfKKOjImnGXRjiOzAJISipbcCDKIVUu+WXJovmGJW+HUWo
         04N83WoLvI5bIcylvK89vpT/OiN0IC77WDWUSQ4wUL0+LvSeqW2VjRV/Olp4Gzxnvzm2
         iPFs8J1VECcelYnT9j9CJgI2YfBIXnlP9PlRA=
Received: by 10.100.42.4 with SMTP id p4mr6065516anp.26.1222274744764;
        Wed, 24 Sep 2008 09:45:44 -0700 (PDT)
Received: by 10.101.71.6 with HTTP; Wed, 24 Sep 2008 09:45:44 -0700 (PDT)
In-Reply-To: <48D89FB7.3000509@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96662>

It happened again. I cannot make a copy of repository and try bisect.
The repository is 2.5GB, too time consuming to make a copy.

When I tried bisect without start from fresh. The bisect failed to
find the bad commit since the bad commit it found out can work now
once the repository is packed.

I did notice 3 things.

1. When I have memory trouble, "git gc" cannot finish the count
objects stage. It appears to be in an infinite loop.
2. When I ran "git count-objects -v", it reported there is an error: 1
garbage object found. The garbage object is named something like
.git/objects/35/tmp_xxx.  Even if "git gc" finished without error, it
won't delete that garbage object. I guess there might be some
difference on how garbage object is handled between v1.5.5.1 and
v1.6.2
3. If I manually remove that garbage object using "rm", everything
seems still fine.

I will give valgrid a shoot next time I am in trouble.

Thanks,
Guo

On Tue, Sep 23, 2008 at 12:50 AM, Andreas Ericsson <ae@op5.se> wrote:
> guo tang wrote:
>>
>> On Mon, Sep 22, 2008 at 12:32 AM, Andreas Ericsson <ae@op5.se> wrote:
>>
>>> Guo Tang wrote:
>>>
>>>> Gentlemen,
>>>>
>>>> I try to run "git gc" on linux kernel tree. The virtual memory keeps
>>>> going
>>>> up until over 3GB, then crash. Tried twice with the v1.6.0.2, same
>>>> result.
>>>> Then I used the git coming with FC9 (v1.5.5.1), the peak virutal memory
>>>> usage is about 1.5GB. "git gc" finished without any trouble.
>>>> Could there be a memory leak in v1.6.0.2?
>>>>
>>>>
>>> There could be, but most likely it's commit
>>> 38bd64979a2a3ffa178af801c6a62e6fcd658274 (Enable threaded delta
>>> search on BSD and Linux). Do you have multiple cpu's in the
>>> computer where 'git gc' was running? If so, and if you've set
>>> pack.threads = 0, or --threads=0 it will autodetect the number
>>> of CPU's you have and then saturate all of them with work. Each
>>> thread will however consume memory close to that of a single
>>> process running the repack, so for large repositories you might
>>> want to set pack.threads = 1 in such large repositories.
>>
>>
>> It is a Pentium M single core machine. But I am not sure whether it is
>> using
>> just a single thread or
>> multiple threads. I will  try setting pack.threads parameter next I run
>> into
>> trouble.
>>
>
> Unless you explicitly told it to run multiple threads (which
> would be a bit silly on a single-core machine), it just ran
> one thread.
>
>>> It's a shame you didn't save the unpacked repository, or this could
>>> have been properly debugged. While it's possible there is a memory
>>> leak, it's a dismal project trying to locate it by staring at the
>>> code, and the time it takes to repack huge repositories with memory
>>> intensive parameters is sort of prohibitive for finding the possible
>>> leak by bisection.
>>
>>
>> Yes, the repository is already packed now. One question, beside the
>> bisecting method, do we have
>> this ability built into kernel:
>> 1. Turn a flag on for a process.
>> 2. OS will keep track off process malloc(), free() calls and the call
>> stack.
>>
>> 3. For the malloc() calls without the the free() call (a memory leak), OS
>> will keep it count based on malloc() call stack.
>> 4. After some time, be able to dump this information out based on biggest
>> leak spot.
>>
>
> No, there's not. The kernel isn't the one handing out the memory when you
> call malloc(). That's handled by the C library, which can (and usually does)
> allocate a larger area of memory than the application needs, so that it
> doesn't have to run a system call for every malloc() call you do.
>
> You can pre-load a different memory allocator though, which can do whatever
> it wants with calls to malloc(), including ofcourse logging which function
> called them and how much memory was requested.
>
> Google for "memory leak check linux" and you'll get something like 750000
> results.
>
>
>> The complain when I ran out of memory if from mmap failure. Is it the same
>> as malloc() failure?
>>
>
> Sort of. Read 'man 2 mmap' for a more exhaustive description.
>
>> This kind of tool is available in Windows with its umdh (user mode heap
>> dump) tool.
>>
>
> There are a number of tools to detect leaks under Linux/Unix as well.
> valgrind is probably the most frequently used of all such leak checkers.
>
> --
> Andreas Ericsson                   andreas.ericsson@op5.se
> OP5 AB                             www.op5.se
> Tel: +46 8-230225                  Fax: +46 8-230231
>
