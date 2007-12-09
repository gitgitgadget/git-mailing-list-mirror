From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Something is broken in repack
Date: Sun, 09 Dec 2007 00:05:43 -0800
Message-ID: <7vprxgs36w.fsf@gitster.siamese.dyndns.org>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
	<alpine.LFD.0.99999.0712072032410.555@xanadu.home>
	<7vodd0vnhv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 09 09:06:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1HBD-00016h-UG
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 09:06:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbXLIIGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 03:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbXLIIGF
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 03:06:05 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:46797 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410AbXLIIGE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 03:06:04 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 748C953D4;
	Sun,  9 Dec 2007 03:05:58 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id EAF9D53D3;
	Sun,  9 Dec 2007 03:05:54 -0500 (EST)
In-Reply-To: <7vodd0vnhv.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 08 Dec 2007 14:18:52 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67603>

Junio C Hamano <gitster@pobox.com> writes:

> Nicolas Pitre <nico@cam.org> writes:
>
>> On Fri, 7 Dec 2007, Jon Smirl wrote:
>>
>>> Starting with a 2GB pack of the same data my process size only grew to
>>> 3GB with 2GB of mmaps.
>>
>> Which is quite reasonable, even if the same issue might still be there.
>>
>> So the problem seems to be related to the pack access code and not the 
>> repack code.  And it must have something to do with the number of deltas 
>> being replayed.  And because the repack is attempting delta compression 
>> roughly from newest to oldest, and because old objects are typically in 
>> a deeper delta chain, then this might explain the logarithmic slowdown.
>>
>> So something must be wrong with the delta cache in sha1_file.c somehow.
>
> I was reaching the same conclusion but haven't managed to spot anything
> blatantly wrong in that area.  Will need to dig more.

Does this problem have correlation with the use of threads?  Do you see
the same bloat with or without THREADED_DELTA_SEARCH defined?
