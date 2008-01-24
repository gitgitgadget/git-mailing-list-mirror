From: Andreas Ericsson <ae@op5.se>
Subject: Re: I'm a total push-over..
Date: Thu, 24 Jan 2008 11:39:16 +0100
Message-ID: <47986AD4.3070303@op5.se>
References: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org> <4796FBB6.9080609@op5.se> <20080123091558.GP14871@dpotapov.dyndns.org> <4797095F.9020602@op5.se> <20080123171004.GS14871@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 11:40:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHzVF-0006yW-3G
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 11:40:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754014AbYAXKjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 05:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754009AbYAXKjj
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 05:39:39 -0500
Received: from mail.op5.se ([193.201.96.20]:46143 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753466AbYAXKji (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 05:39:38 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 5F7521F08048;
	Thu, 24 Jan 2008 11:39:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zEJirwYFXac6; Thu, 24 Jan 2008 11:39:34 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id 8C0EC1F08045;
	Thu, 24 Jan 2008 11:39:34 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <20080123171004.GS14871@dpotapov.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71612>

Dmitry Potapov wrote:
> On Wed, Jan 23, 2008 at 10:31:11AM +0100, Andreas Ericsson wrote:
>> ---
>> FNV Hash
>>
>> I need to fill this in. Search the web for FNV hash. It's faster than my 
>> hash on Intel (because Intel has fast multiplication), but slower on most 
>> other platforms. Preliminary tests suggested it has decent distributions. 
>> ---
> 
> I believe that under words "my hash", Bob Jenkins meant lookup2, which
> was significant slower.
> 
>> My tests ran on Intel.
> 
> Please, could you specify your CPU model.
> 

>From /proc/cpuinfo. It's the best I can do without going to our purchase
department and asking for the spec so I can contact the vendor and get
the real thing. Dualcore shouldn't matter for this test, as it isn't
threaded.
Intel(R) Core(TM)2 Duo CPU     T7700  @ 2.40GHz

>> I also noticed I had a few hashes commented out when
>> doing the test, one of them being Paul Hsie's. For some reason, Jenkin's and
>> Hsie's didn't perform well for me last time I used the comparison thing (I
>> did a more thorough job back then, with tests running for several minutes
>> per hash and table-size, so I commented out the poor candidates).
> 
> I expected that Paul Hsieh's hash may not do well on some architecture,
> though it seems it did even worse than I expected.
> 

It doesn't do that well on certain types of data, in my experience. It does
have excellent dispersion, so with very long strings it's usually the
best to use, because collisions become so expensive.

>> I still believe that for this very simple case, the lookup3.c case is not
>> very practical, as the code is that much more complicated, which was my
>> main point with posting the comparison.
> 
> I would not describe lookup3 as impractical. It is widely used and well
> tested. Perhaps, for some Intel CPUs, the difference in speed is not so
> big, and FNV hash is much smaller and simpler, so FNV is a reasonable
> choice, but the hash is twice slower on my AMD processor and I suspect
> it may be even worse on other CPUs, where integer multiplication is slow.
> Besides, it may turn out that hashing filename may be not only case where
> a fast hash is needed.
> 

Ah well. I think once the patch is in master, it will be easy enough to
test and verify different algorithms. Since it's intended for in-memory
data only, it's no problem to have several algorithms and pick the one
most suitable for the architecture we're compiling for.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
