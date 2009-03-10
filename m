From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: [PATCH/RFD] builtin-revert.c: release index lock when cherry-picking an empty commit
Date: Tue, 10 Mar 2009 19:25:19 +0100
Message-ID: <B9753A8E-43EB-4FA7-B573-14AEE78DD5BD@dbservice.com>
References: <1236418251-16947-1-git-send-email-chris_johnsen@pobox.com> <20090308144240.GA30794@coredump.intra.peff.net> <7v8wnflrws.fsf@gitster.siamese.dyndns.org> <20090310181730.GD26351@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v930.4)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Chris Johnsen <chris_johnsen@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 10 21:08:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh8Cz-0006dl-1J
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 21:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755293AbZCJUEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 16:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755667AbZCJUEH
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 16:04:07 -0400
Received: from office.neopsis.com ([78.46.209.98]:37457 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754636AbZCJUEG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 16:04:06 -0400
X-Greylist: delayed 1824 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Mar 2009 16:04:05 EDT
Received: from [192.168.0.132] ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES128-SHA (128 bits));
	Tue, 10 Mar 2009 20:33:33 +0100
In-Reply-To: <20090310181730.GD26351@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.930.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112845>


On Mar 10, 2009, at 7:17 PM, Jeff King wrote:

> On Sun, Mar 08, 2009 at 12:45:55PM -0700, Junio C Hamano wrote:
>
>> If this part from your analysis is true for a shell:
>>
>>> eval 'false
>>>
>>> '
>>> echo status is $?
>>>
>>> generates:
>>> ...
>>>  status is 0
>>
>> I would be very tempted to declare that shell is unfit for any  
>> serious
>> use, not just for test suite.  Removing the empty line at the end  
>> of a
>> scriptlet that such a broken shell misinterprets as an empty command
>> that is equivalent to ":" (or "true") might hide breakages in the  
>> test
>> suite, but
>>
>> (1) eval "$string" is used outside of test suite, most notably "am"  
>> and
>>     "bisect".  I think "am"'s use is safe, but I wouldn't be  
>> surprised if
>>     the scriptlet "bisect" internally creates has empty lines if  
>> only for
>>     debuggability; and more importantly
>>
>> (2) who knows what _other_ things may be broken in such a shell?
>
> OK, good points. I was just hoping not to cause people on FreeBSD  
> undue
> pain. What is the best way to make such a declaration? I can think of:
>
>  1. A mention in the release notes.
>
>  2. A test in the Makefile similar to the $(:) test.
>
>  3. Getting in touch with the freebsd ports maintainer for git and
>     suggesting a dependency on bash (and/or seeing if he wants to push
>     through a fix for /bin/sh).
>
>     I don't know if the same problem exists on other BSD-influenced  
> systems,
>     or how closely they share the ports collection (it's been quite a
>     while since I've really admin'd a freebsd box). For that matter, I
>     wonder if this is also a problem on OS X. Can somebody with an  
> OS X
>     box try:
>
>       $ /bin/sh
>       $ eval 'false
>
>         '
>       $ echo $?
>
>     It should print '1'; if it prints '0', the shell is broken.

prints '1' here (10.5.6)

tom
