From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] fix some clang warnings
Date: Wed, 16 Jan 2013 18:12:03 +0000
Message-ID: <20130116181203.GB2476@farnsworth.metanate.com>
References: <1358348003-11130-1-git-send-email-max@quendi.de>
 <20130116160410.GC22400@sigill.intra.peff.net>
 <7vk3rdxe5y.fsf@alter.siamese.dyndns.org>
 <CALWbr2z4TiynwOR3Lk4005dbZaLtcHK3J01ZF73wp8Q7Rm6YBA@mail.gmail.com>
 <20130116171809.GA2476@farnsworth.metanate.com>
 <7FDA1B56-731E-4BA2-8FE5-196B965FFFDB@quendi.de>
 <20130116175057.GB27525@sigill.intra.peff.net>
 <20130116180041.GC27525@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Max Horn <max@quendi.de>, John Keeping <john@keeping.me.uk>,
	Antoine Pelisse <apelisse@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 16 19:12:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvXTV-0006dd-BC
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 19:12:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756736Ab3APSMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 13:12:12 -0500
Received: from dougal.metanate.com ([90.155.101.14]:14514 "EHLO metanate.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756392Ab3APSML (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 13:12:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=metanate.com; s=stronger;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=cTRes4NtDZwXlBkAJ+ShClf3idaQD5eJn0AoqhpZcpE=;
	b=qFNU3inxjNSUp4PvUdJRCZ25LXSoWZhzHySSO2ygjPVvz55focHXD5hnu83Hsh2wvbLi3RPIBwRzeJTKAWTYnq9hzgsiCEKodF9B4m83NLWDR/g6hcHmsOowFmp4BCvCGaY+E6cgi+WNuFjJzEAkC986j8qFB5c/IE+fdNDMekGS5HS8R4iA8nHOADThivvzsMH38Kj1QhU9CtXHR21G8oWviZV2brKztPEmAiBlDKByViCdDMner5CyyoLUowfA8VdY8p5yqWhpofi4OSNcY8m/sTQQ6NXayMhMKqjzlC2X2mo9T0Q3o0nTCynonEKsC6cMzIj2krcnT8Yi8SLV9w==;
Received: from brian.metanate.com ([192.168.88.1] helo=farnsworth.metanate.com)
	by shrek.metanate.com with esmtps (TLSv1:DHE-RSA-AES128-SHA:128)
	(Exim 4.80.1)
	(envelope-from <john@keeping.me.uk>)
	id 1TvXT2-0004tz-1j; Wed, 16 Jan 2013 18:12:04 +0000
Content-Disposition: inline
In-Reply-To: <20130116180041.GC27525@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213788>

On Wed, Jan 16, 2013 at 10:00:42AM -0800, Jeff King wrote:
> It is not about the macro itself, but rather the callsites that do not
> return error, but call it for its printing side effect. It seems that
> clang -Wunused-value is OK with unused values from functions being
> discarded, but not with constants. So:
> 
>   int foo();
>   void bar()
>   {
>     foo(); /* ok */
>     1; /* not ok */
>     (foo(), 1); /* not ok */
>   }
> 
> The first one is OK (I think it would fall under -Wunused-result under
> either compiler). The middle one is an obvious error, and caught by both
> compilers. The last one is OK by gcc, but clang complains.

I wonder if this would be changed in clang - the change in [1] is
superficially similar.

[1] http://llvm.org/bugs/show_bug.cgi?id=13747
