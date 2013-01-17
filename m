From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] fix some clang warnings
Date: Thu, 17 Jan 2013 10:24:27 +0000
Message-ID: <20130117102427.GC4574@serenity.lan>
References: <CALWbr2z4TiynwOR3Lk4005dbZaLtcHK3J01ZF73wp8Q7Rm6YBA@mail.gmail.com>
 <20130116171809.GA2476@farnsworth.metanate.com>
 <7FDA1B56-731E-4BA2-8FE5-196B965FFFDB@quendi.de>
 <20130116175057.GB27525@sigill.intra.peff.net>
 <20130116180041.GC27525@sigill.intra.peff.net>
 <20130116181203.GB2476@farnsworth.metanate.com>
 <20130116181558.GA4426@sigill.intra.peff.net>
 <20130116182240.GC2476@farnsworth.metanate.com>
 <20130116182449.GA4881@sigill.intra.peff.net>
 <20130116190137.GD2476@farnsworth.metanate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Max Horn <max@quendi.de>, Antoine Pelisse <apelisse@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 17 11:25:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tvmeg-0001TY-Kb
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 11:25:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759510Ab3AQKYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 05:24:45 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:52885 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759493Ab3AQKYn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 05:24:43 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id D45D722BBE;
	Thu, 17 Jan 2013 10:24:42 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NF5ehA6NeWA5; Thu, 17 Jan 2013 10:24:39 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by hyena.aluminati.org (Postfix) with ESMTP id D26CA22F97;
	Thu, 17 Jan 2013 10:24:38 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 9E3CE161E556;
	Thu, 17 Jan 2013 10:24:38 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ol5k6XTU3+gH; Thu, 17 Jan 2013 10:24:38 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 971C5161E52B;
	Thu, 17 Jan 2013 10:24:29 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20130116190137.GD2476@farnsworth.metanate.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213846>

On Wed, Jan 16, 2013 at 07:01:37PM +0000, John Keeping wrote:
> On Wed, Jan 16, 2013 at 10:24:49AM -0800, Jeff King wrote:
> > On Wed, Jan 16, 2013 at 06:22:40PM +0000, John Keeping wrote:
> > 
> > Thanks for checking. I'd rather squelch the warning completely (as in my
> > re-post of Max's patch from a few minutes ago), and we can loosen it
> > (possibly with a version check) later when a fix is widely disseminated.
> 
> I checked again with a trunk build of clang and the warning's still
> there, so I've created a clang bug [1] to see if they will change the
> behaviour.
> 
> [1] http://llvm.org/bugs/show_bug.cgi?id=14968

Well, that was quick!  This warning is now gone when using a fresh trunk
build of clang.

>From [2], it looks like this will become version 3.3 (in about 5
months).  So should we change the condition to:

#if defined(__GNUC__) && (!defined(__clang__) ||
	__clang_major__ > 3 || \
        (__clang__major == 3 && __clang_minor__ >= 3)


[2] http://llvm.org/docs/HowToReleaseLLVM.html


John
