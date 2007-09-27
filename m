From: David Kastrup <dak@gnu.org>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 27 Sep 2007 08:08:44 +0200
Message-ID: <854phgfxn7.fsf@lola.goethe.zz>
References: <7v1wdcch06.fsf@gitster.siamese.dyndns.org>
	<7v1wd1d0le.fsf@gitster.siamese.dyndns.org>
	<7vfy11yyxk.fsf@gitster.siamese.dyndns.org>
	<20070927023633.GA28902@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 27 08:09:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IamYW-0000eL-8L
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 08:09:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581AbXI0GIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 02:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752521AbXI0GIx
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 02:08:53 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:43689 "EHLO
	mail-in-08.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750761AbXI0GIx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Sep 2007 02:08:53 -0400
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id 7A3692F3211;
	Thu, 27 Sep 2007 08:08:51 +0200 (CEST)
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net [151.189.21.53])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id 63C8913EA48;
	Thu, 27 Sep 2007 08:08:51 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-013-116.pools.arcor-ip.net [84.61.13.116])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 39A6F22D163;
	Thu, 27 Sep 2007 08:08:47 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id D48381C0039C; Thu, 27 Sep 2007 08:08:44 +0200 (CEST)
In-Reply-To: <20070927023633.GA28902@coredump.intra.peff.net> (Jeff King's message of "Wed\, 26 Sep 2007 22\:36\:33 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4411/Wed Sep 26 23:43:35 2007 on mail-in-13.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59267>

Jeff King <peff@peff.net> writes:

> On Wed, Sep 26, 2007 at 01:05:59PM -0700, Junio C Hamano wrote:
>
>> * jk/diff-rename (Tue Sep 25 15:29:42 2007 -0400) 1 commit
>>  + diffcore-rename: cache file deltas
>> 
>> Parked in 'next' for now but is 'master' material.
>
> My tests after this patch show that spanhash_find is responsible for
> a large portion of the processing time in large renames, so I am going
> to look into speeding that up.

In itself, it does not look like there is all too much room for
optimization.  One can remove the temporary pointer "optimization" and
see whether this makes strength reduction possible for the compiler.
Making this an endless loop wrapped around a loop on bucket might also
help the compiler in that effect.

But there is really not all too much leeway, and it might be better
spent in the caller.  For example, the search will take something like
r/(1-r) iterations on average where r is the fill ratio of the hash
array.  So one would not want to, say, let r grow above 0.75 or
something like that.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
