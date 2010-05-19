From: Marcus Comstedt <marcus@mc.pp.se>
Subject: Re: [PATCH 2/2] Accept the timezone specifiers [+-]hh:mm and [+-]hh in addition to [+-]hhmm
Date: Wed, 19 May 2010 19:21:51 +0200
Message-ID: <yf9ocgbkdsg.fsf@chiyo.mc.pp.se>
References: <1274123231-18482-1-git-send-email-marcus@mc.pp.se>
	<1274123231-18482-3-git-send-email-marcus@mc.pp.se>
	<7v632karpe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 19 19:22:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEmy1-0006jL-3E
	for gcvg-git-2@lo.gmane.org; Wed, 19 May 2010 19:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753665Ab0ESRV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 May 2010 13:21:56 -0400
Received: from ua-85-227-1-6.cust.bredbandsbolaget.se ([85.227.1.6]:59335 "EHLO
	bahamut.mc.pp.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252Ab0ESRVz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 May 2010 13:21:55 -0400
Received: from chiyo.mc.pp.se (chiyo [192.168.42.32])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bahamut.mc.pp.se (Postfix) with ESMTPS id 74E5AE48D;
	Wed, 19 May 2010 19:21:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mc.pp.se; s=hedgehog;
	t=1274289713; bh=c+Vma+hRZh+wxTVdmy9my3irPV+XZAAmICHhZ6L8qfQ=;
	h=To:Cc:Subject:References:From:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=zXjSjK6KtayOhhdxQL1J5+oRXMajhTiYlw5s1
	WYO1zn/oKt3Sye+UmbodurDnY4fUOQdzL7doI1QrAPV0PEpEiK+oxbZu3eA1SshwtfX
	rOCmwFOWLHGzoxIpqfCbMl3wkFNYS5kbIASJS/bjeXA2hgCrQQHkMH37KQH988NUpWc
	=
Received: from marcus by chiyo.mc.pp.se with local (Exim 4.71)
	(envelope-from <marcus@mc.pp.se>)
	id 1OEmxs-0006QE-3B; Wed, 19 May 2010 19:21:52 +0200
In-Reply-To: <7v632karpe.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Wed, 19 May 2010 07:31:25 -0700")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) XEmacs/21.4.22 (linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147336>


Hi Junio.

Thanks for reviewing this patch.


Junio C Hamano <gitster@pobox.com> writes:

> I don't recall seeing in ISO 8601 that +hh or -hh without minute
> resolution was allowed, but I don't have my copy of ISO 8601 with me (they
> are packed and are still in transit with my household goods) so I'll take
> your word for it for now [*1*].

In the final draft of 8601:2000 (which is the only version I have),
section 5.3.4.1 states that "[...] the representation of the difference
can be expressed in hours and minutes, or hours only."  Examples of
this then follow in that section and the next one.  Maybe they changed
it in the final version (or it differs from another release of the
standard)?  I wish you could "git log -S" ISO standards...  :-)
Wikipedia also agrees that it is allowed by the standard though.


> But the placement of this second hunk is somewhat curious.  Why doesn't the
> updated function look like this?
[...]

I was perhaps treading a bit over-cautiously.  The placement allowed
me to leave the existing code both syntactically and semantically
unaltered.  After all, there was nothing wrong with the old code per
se, I was just adding new functionality.  I also wanted the two
changes independent, in case you wanted one but not the other.

I can concede that your variant leaves a more appealing end result
though.  (Except for the fact that "n == 2" is needlessly tested in
the inner if. ;)

One thing though:  Shouldn't 1 be returned for bad crap rather than 0?
Seems to me parse_date will get stuck otherwise, because the sign will
never be consumed.  In fact, the old code would consume both the sign
and the initial sequence of digits in the crap case.  Consuming just
the sign would leave the digits to be handled by match_digit, which
may or may not regard it as non-crap.  Good or bad, I don't know.  But
it might cause regressions.

I'll play around a little with the code and perform some new unit
tests, and then resubmit a new patch with the suggested structure.


  // Marcus
