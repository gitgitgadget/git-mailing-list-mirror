From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'git fast-export' is crashing on the gcc repo
Date: Wed, 12 Dec 2007 00:32:56 -0800
Message-ID: <7v3au89utj.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.0.99999.0712111509270.555@xanadu.home>
	<alpine.LFD.0.99999.0712111703380.555@xanadu.home>
	<20071212013828.GC19857@steel.home>
	<alpine.LFD.0.99999.0712112045040.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Dec 12 09:33:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2N26-0001Am-42
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 09:33:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756111AbXLLIdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 03:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755541AbXLLIdK
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 03:33:10 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57083 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755542AbXLLIdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 03:33:09 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 406215C6C;
	Wed, 12 Dec 2007 03:33:02 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A3FEA5C6B;
	Wed, 12 Dec 2007 03:32:58 -0500 (EST)
In-Reply-To: <alpine.LFD.0.99999.0712112045040.555@xanadu.home> (Nicolas
	Pitre's message of "Tue, 11 Dec 2007 20:45:40 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68013>

Nicolas Pitre <nico@cam.org> writes:

> On Wed, 12 Dec 2007, Alex Riesen wrote:
>
>> Nicolas Pitre, Tue, Dec 11, 2007 23:06:42 +0100:
>> > 
>> > Well, ignore the above.  It seems that most of stdio doesn't set errno 
>> > so the above is crap.
>> > 
>> 
>> Well, it had no reason to in this case. It's not an error.
>> It does not even have to do a syscall.
>
> Which is why I later agreed with your patch.

Still, I like your swapping of size and nmemb parameters, regardless of
the "don't bother calling fwrite(3) if size is zero" fix.

We are writing 1 element of size n-byte and expecting the call to return
1.  It may be argued that writing one element of size 0-byte should
always write 1 element (without actually having to go down to write(2),
obviously) successfully and returning 0 from fwrite(3) is a bug ;-)

No, I am just kidding.  I checked with POSIX and it clearly says it
should return 0 if size or nmemb is zero.
