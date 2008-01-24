From: Andreas Ericsson <ae@op5.se>
Subject: Re: I'm a total push-over..
Date: Thu, 24 Jan 2008 17:00:51 +0100
Message-ID: <4798B633.8040606@op5.se>
References: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org>	 <4796FBB6.9080609@op5.se> <20080123091558.GP14871@dpotapov.dyndns.org>	 <4797095F.9020602@op5.se>	 <e51f66da0801230601n6edd2639lff70415afa9f9026@mail.gmail.com>	 <4797518A.3040704@op5.se> <e51f66da0801240519u4c8e6ddfrb7af8df34552252a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Marko Kreen <markokr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 17:02:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI4WX-0006pS-JX
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 17:01:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892AbYAXQBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 11:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752877AbYAXQBS
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 11:01:18 -0500
Received: from mail.op5.se ([193.201.96.20]:46004 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752642AbYAXQBR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 11:01:17 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 108AD1F08006;
	Thu, 24 Jan 2008 17:01:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 74PbwkbUe9UD; Thu, 24 Jan 2008 17:01:13 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id 4D91E1F0803A;
	Thu, 24 Jan 2008 17:01:12 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <e51f66da0801240519u4c8e6ddfrb7af8df34552252a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71626>

Marko Kreen wrote:
> On 1/23/08, Andreas Ericsson <ae@op5.se> wrote:
>> Marko Kreen wrote:
>>> (not lookup3) because lookup3 beat easily all the "simple" hashes
>> By how much? FNV beat Linus' hash by 0.01 microseconds / insertion,
>> and 0.1 microsecons / lookup. We're talking about a case here where
>> there will never be more lookups than insertions (unless I'm much
>> mistaken).
> 
> FNV is around 40% slower than lookup3 on my Intel Core CPU, on 4byte aligned
> input. See below for more detailed info.
> 

But the tests surely need to check for unaligned cases, as that's what
we're likely to hash, no?

>>> If you don't mind few percent speed penalty compared to Jenkings
>>> own optimized version, you can use my simplified version:
>>>
>>>   http://repo.or.cz/w/pgbouncer.git?a=blob;f=src/hash.c;h=5c9a73639ad098c296c0be562c34573189f3e083;hb=HEAD
>> I don't, but I don't care that deeply either. On the one hand,
>> it would be nifty to have an excellent hash-function in git.
>> On the other hand, it would look stupid with something that's
>> quite clearly over-kill.
> 
> Jenkins hash is fast because it does not look at individual bytes.
> If you _do_ want to look at them for unrelated reasons, (case-insensitive,
> unicode-juggling), then it obiously loses the point.  That is, if you
> want to process the string in one go.
> 

I believe the ability to add unicode-juggling was a major point
with the patch, so perhaps Jenkins' isn't such a good option.

I'm not familiar with data-mangling the way Linus (or Theo Tso
is), so I hadn't even considered that aspect of unrolled hashes.

>> It would have to be a significant improvement in wall-clock time
>> on a test-case of hashing 30k strings to warrant going from 6 to 80
>> lines of code, imo. I still believe the original dumb hash Linus
>> wrote is "good enough".
> 
> Well, ad-hoc dumb hashes may have horrible worst-cases that you cant
> see with light testing.  Therefore I'd still suggest some better
> researched dumb hash (eg. FNV or OAT).
> 

True. FNV is used in both MySQL and PostgreSQL. I'd say it's safe to
assume it's fairly well tested.

>> On a side-note, it was very interesting reading, and I shall have
>> to add jenkins3_mkreen() to my test-suite (although the "keep
>> copyright note" license thing bugs me a bit).
> 
> Sorry.  I just used template boilerplate.  Considering all the
> hard work was done by other people, it not proper to put under
> my own license.  I tagged the file as 'public domain' and pushed out.
> 

Thanks. I'll see if I can add it, although it'll probably have to
wait until I have reason to dig into it at work again. I've added
the hash to the code-base, but not yet incorporated it into the
test-case.

> Btw, the reason I started cleaning lookup3 was that at first I was
> scared of the complexity of Jenkins code and decided to go with
> Hsieh hash.  Then I found out that Hsieh code is under totally
> werdo license (http://www.azillionmonkeys.com/qed/weblicense.html)
> so I could not use it.
> 

True. I was in contact with him a while back since I wanted to use it
in an opensource project, but the licensing issues made me go with
another one instead. The patch got turned down anyways, so it was a
non-issue in the end, but... Ah well.

> 
> Here is my raw-speed test of different hashes.  Input is 4-byte
> aligned which should be common case for malloc()-ed strings.

Unless arena allocated, like we do in git.

I'm not surprised that this test favours Jenkin's and Hsie's.
That's to be expected as those benefit far more than simpler
hashing algorithms for long strings. The overhead when trying
shorter strings (say, between 3 and 15 chars, and not necessarily
4-byte aligned) sometimes make them quite a lot slower though.

> This also is best case for original lookup3(), on unaligned
> input the memcpy variants beat it easily.  Input string
> length varies randomly in range 0..64.
> 

Well, memcpy() isn't very interesting to compare against
hashes, as they test vastly different parts of the hardware's
parts' performance. memcpy() should also perform exactly the
same no matter what the test-data, which isn't always true for
hashes.

What *would* be interesting would be something along the lines
of "duff_cpy()": ie, an unrolled loop that aligns itself and
copies each byte to the same address each time.

The bytewise equivalence would ofcourse be

magic_cpy(unsigned char *k, int len)
{
	unsigned char magic;
	do {
		magic = *k++;
	} while (--len);
}

> own_memcpy - last 12-byte memcpy() calls out to libc
> memcpy_hack - last memcpy is inlined bytewise copy loop:
> 
>   while (len--) *dst++ = *src++;
> 
> Note that is is raw-speed test, if you benchmark larger code the
> hash difference probably matters less.
> 
> --------------------------------------------------------------------
> 
> Testing: seed=34 align=4 minlen=0 maxlen=64 trycnt=2 duration=10
> 
> lookup3 : try=0: ... 247.4880 MB/s
> lookup3 : try=1: ... 247.6154 MB/s
> own_memcpy: try=0: ... 223.5508 MB/s
> own_memcpy: try=1: ... 223.5830 MB/s
> memcpy_hack: try=0: ... 241.2241 MB/s
> memcpy_hack: try=1: ... 241.2492 MB/s
> lookup2 : try=0: ... 190.2697 MB/s
> lookup2 : try=1: ... 190.3283 MB/s
> fnv     : try=0: ... 153.0318 MB/s
> fnv     : try=1: ... 153.0178 MB/s
> hsieh   : try=0: ... 234.0468 MB/s
> hsieh   : try=1: ... 234.0426 MB/s
> oat     : try=0: ... 154.7804 MB/s
> oat     : try=1: ... 154.8226 MB/s
> elf     : try=0: ... 125.5892 MB/s
> elf     : try=1: ... 125.5734 MB/s
> 
> Results compared to reference:
> 
> lookup3         : 100.000 %
> own_memcpy      :  90.311 %
> memcpy_hack     :  97.449 %
> lookup2         :  76.872 %
> fnv             :  61.815 %
> hsieh           :  94.544 %
> oat             :  62.533 %
> elf             :  50.729 %
> 
> 

Interesting output, but not very surprising. Do you have the code
available somewhere?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
