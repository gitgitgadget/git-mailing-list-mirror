From: david@lang.hm
Subject: Re: Article about "git bisect run" on LWN
Date: Thu, 5 Feb 2009 18:42:16 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0902051838180.5340@asgard.lang.hm>
References: <200902050747.50100.chriscool@tuxfamily.org> <20090205141336.GA28443@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <ae@op5.se>, Jeff Garzik <jeff@garzik.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Bill Lear <rael@zopyra.com>,
	Jon Seymour <jon.seymour@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Fri Feb 06 02:40:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVFhf-0007da-FS
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 02:40:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754167AbZBFBif (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 20:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754002AbZBFBif
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 20:38:35 -0500
Received: from mail.lang.hm ([64.81.33.126]:41890 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752301AbZBFBie (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 20:38:34 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n161bqB8007624;
	Thu, 5 Feb 2009 17:37:52 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20090205141336.GA28443@elte.hu>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108645>

On Thu, 5 Feb 2009, Ingo Molnar wrote:

> * Christian Couder <chriscool@tuxfamily.org> wrote:
>
>> Hi,
>>
>> For information, an article from me, 'Fully automated bisecting with "git
>> bisect run"' has been published in today's edition of LWN on the
>> development page:
>>
>> http://lwn.net/Articles/317154/
>
> Nice article!
>
> In terms of possible future enhancements of git bisect, here's a couple of
> random ideas that would help my auto-bisection efforts:
>
> - Feature: support "Bisection Redundancy"
>
>   This feature helps developers realize if a bug is sporadic. This happens
>   quite often in the kernel space: a bug looks deterministic, but down the
>   line it becomes sporadic. Sometimes a boot crash only occurs with a 75%
>   probability - and if one is unlucky it can cause a _lot_ of wasted
>   bisection time. The wrong commit gets blamed and the wrong set of
>   developers start scratching their heads. It's a reoccuring theme on lkml.
>
>   What git could do here is to allow testers to inject a bit of extra
>   "redundancy" automatically, and use the redundant test-points to detect
>   conflicts in good/bad constraints.
>
>   It would work like this:
>
>      git bisect start --redundancy=33%
>
>   It would mean that for every third bisection points, Git would
>   _not_ chose the ideal (estimated) 'middle point' from the set of "unknown
>   quality" changes that are still outstanding - but would intentionally
>   "weer outside" and select one commit from the _known_ set of commits.
>
>   If such a redundant re-test of the known-good or known-bad set yields a
>   nonsensical result then Git aborts the bisection with a "logic
>   inconsistency detected" kind of message - and people could at this point
>   realize the non-determinism of the test.
>
>   ( Git can do this when a "redundant" test point is marked as 'bad' -
>     despite an earlier bisection already categorizing that test point as
>     'good' - or if it's the other way around. Git will only continue with
>     the bisection if the test point has the expected quality. )
>
>   This essentially means an automated re-test - but it's much better than
>   just a repeated bisection - i've often met non-deterministic bugs that
>   yield the _exact same_ nonsensical commit even on repeat bisections. That
>   happens when a timing bug depends on the exact kernel layout, or a
>   miscompilation or linker bug depends on the exact kernel layout, etc.
>
>   It's also faster than a re-done bisection: 33% more testpoints is better
>   than twice as many test-points. Also, auto-bisection can deal with
>   redundancy just fine - it does not really matter whether i have to wait
>   20 or 30 minutes for a test result since there's no manual intervention
>   needed - but it _very_ much matters whether i can trust the validity of
>   the bisection result.

when you gave this the title of redundnancy and described the problem I 
assumed that you would then propose running the test multiple times (so 
"git bisect run X --redundancy 5" would run each test 5 times, it would 
pass IFF it passed the test all 5 times. that would seem to be a better 
match for the name, as well as being a better test

David Lang
