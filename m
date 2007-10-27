From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/9] git-hash-object: Add --stdin-paths option
Date: Fri, 26 Oct 2007 18:02:05 -0700
Message-ID: <7vlk9pv08i.fsf@gitster.siamese.dyndns.org>
References: <1193307927-3592-1-git-send-email-aroben@apple.com>
	<1193307927-3592-2-git-send-email-aroben@apple.com>
	<1193307927-3592-3-git-send-email-aroben@apple.com>
	<1193307927-3592-4-git-send-email-aroben@apple.com>
	<1193307927-3592-5-git-send-email-aroben@apple.com>
	<1193307927-3592-6-git-send-email-aroben@apple.com>
	<1193307927-3592-7-git-send-email-aroben@apple.com>
	<7vy7dpwpz4.fsf@gitster.siamese.dyndns.org>
	<20071026231902.GC2519@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Roben <aroben@apple.com>, git@vger.kernel.org
To: bdowning@lavos.net (Brian Downing)
X-From: git-owner@vger.kernel.org Sat Oct 27 03:02:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ila4L-0000zl-Gn
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 03:02:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbXJ0BCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 21:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751950AbXJ0BCO
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 21:02:14 -0400
Received: from rune.pobox.com ([208.210.124.79]:56023 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751432AbXJ0BCN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 21:02:13 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id D32B014E99C;
	Fri, 26 Oct 2007 21:02:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 26A3B14E780;
	Fri, 26 Oct 2007 21:02:28 -0400 (EDT)
In-Reply-To: <20071026231902.GC2519@lavos.net> (Brian Downing's message of
	"Fri, 26 Oct 2007 18:19:02 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62459>

bdowning@lavos.net (Brian Downing) writes:

> On Fri, Oct 26, 2007 at 02:00:47PM -0700, Junio C Hamano wrote:
>> In addition, if you are enhancing cat-file to spew chunked
>> output out, I suspect that there should be a mode of operation
>> for hash-object that eats that data format.  IOW, this pipe
>> 
>> 	git-cat-file --batch <list-of-sha1 |
>>         git-hash-object --batch
>> 
>> should be an intuitive no-op, shouldn't it?
>
> I think that's an obviously good thing to do.  However, given your
> suggested output format (which I also like):
>
>>    * git-cat-file --batch <list-of-sha1
>> 
>>      outputs a record of this form
>> 
>>           <sha1> SP <type> SP <size> LF <contents> LF
>> 
>>      for each of the input lines.
>
> What should the input behavior be?  Obviously the sha1 will probably
> not be known on the input side.  Should that simply be optional (i.e.
> it will accept either "<sha1> SP <type> SP <size>" or "<type> SP <size>"
> or should it only accept the latter, and a dummy sha1 will need to be
> filled in if the sha1 is not known (presumably "000...000")?

Yeah, you caught me ;-)

Either making it optional or requiring a dummy value would work.
If a non-dummy value is given, we could use it to validate it.

But that would not be a useful application anyway.  So perhaps
just the sequence of "<type> SP <size> LF <contents> LF" would
be the most sensible thing to do.
