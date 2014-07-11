From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 0/7] ensure index is set for all OBJ_COMMIT objects variable
Date: Fri, 11 Jul 2014 11:31:48 +0100
Message-ID: <53BFBD14.3070607@ramsay1.demon.co.uk>
References: <53BF28F4.8050704@ramsay1.demon.co.uk> <20140711003053.GB11360@sigill.intra.peff.net> <20140711084141.GA5521@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 11 12:31:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5Y7R-0000Gn-1P
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 12:31:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140AbaGKKbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 06:31:53 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:54231 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753095AbaGKKbw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 06:31:52 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 4BE7B1280CC;
	Fri, 11 Jul 2014 11:31:46 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 073741280C7;
	Fri, 11 Jul 2014 11:31:46 +0100 (BST)
Received: from [192.168.254.1] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta009.tch.inty.net (Postfix) with ESMTP;
	Fri, 11 Jul 2014 11:31:45 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140711084141.GA5521@sigill.intra.peff.net>
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253270>

On 11/07/14 09:41, Jeff King wrote:
> Here's a series to address the bug I mentioned earlier by catching the
> conversion of OBJ_NONE to OBJ_COMMIT in a central location and setting
> the index there.
> 
> I've included your patch 1/2 unchanged in the beginning, as I build on
> top of it (and your patch 2/2 is no longer applicable).  The rest is
> refactoring leading up to patch 6 to fix the bug. Patch 7 is a bonus
> cleanup.

I have just read this series in my email client (I will apply and test
them later), but this looks very good to me. :)

Only one patch gave me slight pause; see later.

> 
> I'd hoped to cap off the series by converting the "type" field of
> "struct commit" to a "const unsigned type : 3", which would avoid any
> new callers being added that would touch it without going through the
> proper procedure.  However, it's a bitfield, which makes it hard to cast
> the constness away in the actual setter function. My best attempt was to
> use a union with matching const and non-const members, but that would
> mean changing all of the sites which read the field (and there are many)
> to use "object->type.read".
> 
> There may be a clever solution hiding in a dark corner of C, but I
> suspect we are entering a realm of portability problems with older
> compilers (I even saw one compiler's documentation claim that "const"
> was forbidden on bitfields, even though C99 has an example which does
> it).

Yes, I've come across such compilers too; I wouldn't go there! ;-P

ATB,
Ramsay Jones
