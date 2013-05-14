From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 0/4] Coverage support revisited
Date: Tue, 14 May 2013 11:14:44 +0200
Message-ID: <87k3n16hyz.fsf@linux-k42r.v.cablecom.net>
References: <cover.1368479988.git.trast@inf.ethz.ch> <51916A2B.3060001@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue May 14 11:14:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcBJy-00036M-HS
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 11:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756632Ab3ENJOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 05:14:48 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:25867 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756433Ab3ENJOr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 05:14:47 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 14 May
 2013 11:14:42 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS12.d.ethz.ch (172.31.38.212) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 14 May 2013 11:14:44 +0200
In-Reply-To: <51916A2B.3060001@web.de> (Jens Lehmann's message of "Tue, 14 May
	2013 00:33:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224295>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 13.05.2013 23:27, schrieb Thomas Rast:
>> Jens asked me at git-merge if coverage support was still available.
>> Turns out it is, but there were some weirdnesses.  So this should fix
>> them.  It is reaaaally slow as you still have to run the tests one by
>> one; despite claims in the wild that it is multiprocess- safe but
>> thread-unsafe, I am in fact observing the opposite behavior pretty
>> clearly.  (As before, it switches to sequential tests automatically,
>> so you have to edit the Makefile if you want to try with parallel
>> tests.)
>
> Thx! That might explain why the coverage run I tried today didn't
> work (I saw bogus test failures).

Indeed it does.  I should have mentioned it in the cover letter; it's
fixed by this series but if you set DEFAULT_TEST_TARGET=prove like
everyone else, it ignored the (existing) force-to-sequential rule.

>> unpack-trees.c: verify_clean_submodule
>
> This is the one I was after. While discussing my recursive update
> code with Peff on Saturday we wondered if that function would ever
> be called. I'll check if the tests are missing some relevant cases,
> if that function can be removed or some refactoring is necessary.
>
> Hmm, while function coverage is already extremely useful me thinks
> lcov support would be really nice. We'd have line and branch coverage,
> which help me a lot in finding dead code and missing tests at $DAYJOB
> ... will look into that when I have the recursive update ready.

Actually if you run it, it generates submodule.c.gcov as an intermediate
step to the uncovered-functions list.  Of course you can also use any
other tool that can read gcov; the results are cleaned before the run,
not after, so they will remain in place.

Originally I hacked together an uncovered-functions list because that
list was so long that looking at things in even more detail seemed
extremely pointless.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
