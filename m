From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv3 0/5]rev-list and friends: --min-parents, --max-parents
Date: Thu, 24 Mar 2011 09:55:46 +0100
Message-ID: <4D8B0712.6010300@drmicha.warpmail.net>
References: <20110321105628.GC16334@sigill.intra.peff.net> <cover.1300872923.git.git@drmicha.warpmail.net> <20110324082108.GA30196@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 09:59:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2gOC-00015s-CL
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 09:59:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753816Ab1CXI70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 04:59:26 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:39301 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750892Ab1CXI7Y (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Mar 2011 04:59:24 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 56F3820B28;
	Thu, 24 Mar 2011 04:59:24 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 24 Mar 2011 04:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=R9rarxMGC2npkIyvInUYpkppaeg=; b=G5hhXKCRvQdwmj34wsGbEh7zRwMVH7SZANxOWki1337/NbAxEZbdtGs7voUhxT0vv8LLbstcx4KiuQoCuozjMhcj9a6Y8hx1nOCq0V/zLDXARDFltNtwE7WP5c/ZNgR5H6pxUDZ3REROfLVn1bfxeiz5qIOEF0iOAasXOvfgmRw=
X-Sasl-enc: j5IltS3y4w1pLhYpKSXeccCm1FsCVuE7OqrmQBmGZrHl 1300957164
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 99CE5402CAF;
	Thu, 24 Mar 2011 04:59:23 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <20110324082108.GA30196@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169907>

Jonathan Nieder venit, vidit, dixit 24.03.2011 09:21:
> Michael J Gruber wrote:
> 
>> Compared to what is currently in pu (which is v2+eps), v3 has:
> 
> Thanks.  I reviewed this by looking at what Junio queued in pu; it

OK, no more !fixup and !squash next time ;)

> looks very good.  With the following patch, it passes tests.

Uhm, it does so even without (for me) for bash and ksh, as you point out
below. What's the simplest way to run the tests so that they catch
non-POSIXisms?

> The use of "return" was surprising.  It seems this style has been
> intended to work ever since v0.99.5~24^2~4 (Trapping exit in tests,
> using return for errors, 2005-08-10).

I learned that from other tests and considered it safe therefore.

> It interacts poorly with test_when_finished but since these tests do
> not use that function, they should be safe.  test_when_finished could
> use some fixes to avoid future surprises but that's another story.
> 
> -- 8< --
> Subject: tests: avoid nonportable {foo,bar} glob
> 
> Unlike bash and ksh, dash and busybox ash do not support brace
> expansion (as in 'echo {hello,world}').  So when dash is sh,
> t6009.13 (set up dodecapus) ends up pass a string beginning with
> "root{1,2," to "git merge" verbatim and the test fails.

Thanks, I was afraid of a problem like that but then forgot about it.

> Fix it by introducing a variable to hold the list of parents for
> the dodecapus and populating it in a more low-tech way.
> 
> While at it, simplify a little by combining this setup code with the
> test it sets up for.

I thought it's considered bad style to mix setup and actual test?
Personally, I don't care either way. I just didn't want to have these 12
extra commits in the initial setup (forcing me to adjust all tests).

Michael
