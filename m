From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 2/7] move setting of object->type to alloc_* functions
Date: Sun, 13 Jul 2014 20:27:51 +0100
Message-ID: <53C2DDB7.2070708@ramsay1.demon.co.uk>
References: <20140711084141.GA5521@sigill.intra.peff.net> <20140711084611.GB5625@sigill.intra.peff.net> <53C149B6.7010705@ramsay1.demon.co.uk> <20140712180539.GA13806@sigill.intra.peff.net> <20140713064116.GA4768@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jul 13 21:28:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6PRI-0003wb-HD
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 21:28:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbaGMT15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2014 15:27:57 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:48324 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751284AbaGMT14 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 15:27:56 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 3EEC7128094;
	Sun, 13 Jul 2014 20:27:47 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id F1388128076;
	Sun, 13 Jul 2014 20:27:46 +0100 (BST)
Received: from [192.168.254.1] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta009.tch.inty.net (Postfix) with ESMTP;
	Sun, 13 Jul 2014 20:27:46 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140713064116.GA4768@sigill.intra.peff.net>
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253456>

On 13/07/14 07:41, Jeff King wrote:
> On Sat, Jul 12, 2014 at 02:05:39PM -0400, Jeff King wrote:
> 
>>> I don't particularly like 'flag' here. (not a massive dislike, mind you:)
>>>
>>> Perhaps: flag->object_type, type->node_type?
>>> Or, if that's too verbose, maybe just: flag->type, type->node?
>>
>> Me either, but as you noticed, type was taken. Your suggestions seem
>> fine. We could also just do away with the macro as discussed earlier (we
>> already do in the commit_node case, anyway...).
> 
> Thinking on this more, writing out the definitions is the only sane
> thing to do here, now that alloc_commit_node does not use the macro.
> Otherwise you are inviting people to modify the macro, but fail to
> notice that the commit allocator also needs updating.

Hmm, well I could argue that using the macro for all allocators, apart
from alloc_commit_node(), clearly shows which allocator is the odd-man
out (and conversely, that all others are the same)! :-P

No, I don't think this is a telling advantage; I don't think it makes
that much difference. (six of one, half-a-dozen of the other).

BTW, I tested the previous series on Linux 32-bit, Cygwin 32-bit, MinGW
32-bit and Cygwin 64-bit. (I can't test on Linux 64-bit, since I can't
get Linux installed on my new laptop :( ). Admittedly, the testing on
MinGW and Cygwin was only fairly light (it takes *hours* to run the full
testsuite, and I just don't have the time).

I was slightly concerned, when reading through this new series, that the
alloc_node() function may no longer be inlined in the new allocators.
However, I have just tested on Linux (only using gcc this time), and it
was just fine. I will test the new series on the above systems later
(probably tomorrow) but don't expect to find any problems.

> 
> Here's a re-roll. The interesting bit is the addition of the second
> patch (but the rest needed to be rebased on top).

Yep, this looks good. Thanks!

> 
>   [1/8]: alloc.c: remove the alloc_raw_commit_node() function
>   [2/8]: alloc: write out allocator definitions
>   [3/8]: move setting of object->type to alloc_* functions
>   [4/8]: parse_object_buffer: do not set object type
>   [5/8]: add object_as_type helper for casting objects
>   [6/8]: alloc: factor out commit index
>   [7/8]: object_as_type: set commit index
>   [8/8]: diff-tree: avoid lookup_unknown_object

ATB,
Ramsay Jones
