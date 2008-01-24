From: Andreas Ericsson <ae@op5.se>
Subject: Re: I'm a total push-over..
Date: Thu, 24 Jan 2008 11:24:53 +0100
Message-ID: <47986775.7010603@op5.se>
References: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org>	 <4796FBB6.9080609@op5.se> <20080123091558.GP14871@dpotapov.dyndns.org>	 <4797095F.9020602@op5.se> <e51f66da0801230601n6edd2639lff70415afa9f9026@mail.gmail.com> <4797518A.3040704@op5.se> <F23CA352-416C-49EC-8132-688784CF3C18@vicaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Marko Kreen <markokr@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Luke Lu <git@vicaya.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 11:27:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHzIQ-0002v4-Nj
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 11:26:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753464AbYAXKZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 05:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753441AbYAXKZX
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 05:25:23 -0500
Received: from mail.op5.se ([193.201.96.20]:57960 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753440AbYAXKZV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 05:25:21 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 7E4E51F08070;
	Thu, 24 Jan 2008 11:25:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oe-l+W2Hhtb5; Thu, 24 Jan 2008 11:25:14 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id C33DA1F0806F;
	Thu, 24 Jan 2008 11:25:12 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <F23CA352-416C-49EC-8132-688784CF3C18@vicaya.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71611>

Luke Lu wrote:
> On Jan 23, 2008, at 6:39 AM, Andreas Ericsson wrote:
>> Marko Kreen wrote:
>>> On 1/23/08, Andreas Ericsson <ae@op5.se> wrote:
>>>> Dmitry Potapov wrote:
>>>>> On Wed, Jan 23, 2008 at 09:32:54AM +0100, Andreas Ericsson wrote:
>>>>>> The FNV hash would be better (pasted below), but I doubt
>>>>>> anyone will ever care, and there will be larger differences
>>>>>> between architectures with this one than the lt_git hash (well,
>>>>>> a function's gotta have a name).
>>>>> Actually, Bob Jenkins' lookup3 hash is twice faster in my tests
>>>>> than FNV, and also it is much less likely to have any collision.
>>>>>
>>>> >From http://burtleburtle.net/bob/hash/doobs.html
>>>> ---
>>>> FNV Hash
>>>>
>>>> I need to fill this in. Search the web for FNV hash. It's faster 
>>>> than my hash on Intel (because Intel has fast multiplication), but 
>>>> slower on most other platforms. Preliminary tests suggested it has 
>>>> decent distributions.
>>> I suspect that this paragraph was about comparison with lookup2
>>
>>
>> It might be. It's from the link Dmitry posted in his reply to my original
>> message. (something/something/doobs.html).
>>
>>> (not lookup3) because lookup3 beat easily all the "simple" hashes
>>
>> By how much? FNV beat Linus' hash by 0.01 microseconds / insertion,
>> and 0.1 microsecons / lookup. We're talking about a case here where
>> there will never be more lookups than insertions (unless I'm much
>> mistaken).
>>
>>> If you don't mind few percent speed penalty compared to Jenkings
>>> own optimized version, you can use my simplified version:
>>>   
>>> http://repo.or.cz/w/pgbouncer.git?a=blob;f=src/hash.c;h=5c9a73639ad098c296c0be562c34573189f3e083;hb=HEAD 
>>>
>>
>> I don't, but I don't care that deeply either. On the one hand,
>> it would be nifty to have an excellent hash-function in git.
>> On the other hand, it would look stupid with something that's
>> quite clearly over-kill.
>>
>>> It works always with "native" endianess, unlike Jenkins fixed-endian
>>> hashlittle() / hashbig().  It may or may not matter if you plan
>>> to write values on disk.
>>> Speed-wise it may be 10-30% slower worst case (in my case sparc-classic
>>> with unaligned data), but on x86, lucky gcc version and maybe
>>> also memcpy() hack seen in system.h, it tends to be ~10% faster,
>>> especially as it does always 4byte read in main loop.
>>
>> It would have to be a significant improvement in wall-clock time
>> on a test-case of hashing 30k strings to warrant going from 6 to 80
>> lines of code, imo. I still believe the original dumb hash Linus
>> wrote is "good enough".
>>
>> On a side-note, it was very interesting reading, and I shall have
>> to add jenkins3_mkreen() to my test-suite (although the "keep
>> copyright note" license thing bugs me a bit).
> 
> Would you, for completeness' sake, please add Tcl and STL hashes to your 
> test suite?

I could do that. Or I just publish the entire ugly thing and let someone
else add them ;-)

> The numbers are quite interesting. Is your test suite 
> available somewhere, so we can test with our own data and hardware as 
> well.

Not yet, no. I usually munge it up quite a lot when I want to test hashes
for a specific input, so it's not what anyone would call "pretty".

> Both Tcl hash and STL (from SGI probably HP days, still the 
> current default with g++) string hashes are extremely simple (excluding 
> the loop constructs):
> 
> Tcl: h += (h<<3) + c;     // essentially *9+c (but work better on 
> non-late-intels)
> STL: h = h * 5 + c;    // worse than above for most of my data
> 

They sure do look simple enough. As for loop constructs, I've tried to
use the same looping mechanics for everything, so as to let the algorithm
be the only difference. Otherwise it gets tricky to do comparisons. The
exceptions are ofcourse hashes relying on Duff's device or similar
alignment trickery.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
