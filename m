From: Guido Ostkamp <git@ostkamp.fastmail.fm>
Subject: Re: [PATCH] Fix Solaris Workshop Compiler issues
Date: Thu, 15 Nov 2007 00:21:55 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0711150011020.4135@bianca.dialin.t-online.de>
References: <Pine.LNX.4.64.0711142125460.17530@bianca.dialin.t-online.de>
 <20071114204732.GE3973@steel.home> <7vprycfrk6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Guido Ostkamp <git@ostkamp.fastmail.fm>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 00:22:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsRZ6-0003qB-HR
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 00:22:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756077AbXKNXWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 18:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755274AbXKNXWB
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 18:22:01 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:50135 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756086AbXKNXWA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Nov 2007 18:22:00 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 02FC647D42;
	Wed, 14 Nov 2007 18:21:59 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 14 Nov 2007 18:22:00 -0500
X-Sasl-enc: h5JOepsYx9WEk1wa/eNsHxa5JZgKI5Sl3omKTL2R15VK 1195082518
Received: from [192.168.2.101] (p549A183B.dip0.t-ipconnect.de [84.154.24.59])
	by mail.messagingengine.com (Postfix) with ESMTP id 5C1EBDFF5;
	Wed, 14 Nov 2007 18:21:58 -0500 (EST)
In-Reply-To: <7vprycfrk6.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65024>

On Wed, 14 Nov 2007, Junio C Hamano wrote:

> Alex Riesen <raa.lkml@gmail.com> writes:
>
>> Guido Ostkamp, Wed, Nov 14, 2007 21:31:13 +0100:
>>> ...
>>> cc: acomp failed for diff-delta.c
>>> make: *** [diff-delta.o] Error 2
>>>
>>> This is because 'struct delta_index' is declared with no size in delta.h
>>> and with size in diff-delta.c which does not fit.
>>
>> Huh?! Ever heard of forward declaration?
>
> We are not the first people who pass around a pointer to an opaque 
> struct in the API to hide away the implementation.  It would be 
> surprising if the Workshop Compiler chokes on this and not other 
> projects.

You got the original error report from Sun's compiler included in my 
earlier email. This happens with at least Sun Forte 6.1 (Solaris 8) and 
Sun Workshop 11 (Solaris 10), IIRC.

The function declarations regarding create_delta() in delta.h and 
diff-delta.c are identical with respect to the type names of the parameter 
(only some internal names e.g. like 'buf' vs. 'trg_buf' are slightly 
different, but this has no effect).

The main difference is that the 'struct delta_index' is opaque in delta.h 
and non-opaque in diff-delta.c; the patch clearly shows it solves the 
error. So we've got a solution.

If you feel we could try something else, please let me know and I'll check 
it out.

Please keep me on CC, as I'm not subscribed to the list, thanks.

Regards

Guido
