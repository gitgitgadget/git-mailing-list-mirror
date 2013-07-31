From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: What's cooking in git.git (Jul 2013, #09; Mon, 29)
Date: Wed, 31 Jul 2013 18:48:45 +0100
Message-ID: <51F94DFD.5020101@ramsay1.demon.co.uk>
References: <7vk3k9yol3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, tboegi@web.de, mhagger@alum.mit.edu,
	mlevedahl@gmail.com, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 31 20:02:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4ajO-0008FU-Nb
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 20:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974Ab3GaSCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 14:02:32 -0400
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:51490 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752358Ab3GaSCb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 14:02:31 -0400
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id E42016F85D4;
	Wed, 31 Jul 2013 19:02:29 +0100 (BST)
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id F3EB26F85A9;
	Wed, 31 Jul 2013 19:02:28 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP;
	Wed, 31 Jul 2013 19:02:24 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <7vk3k9yol3.fsf@alter.siamese.dyndns.org>
X-MDF-HostID: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231440>

Junio C Hamano wrote:
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.
> 
> The shape of the upcoming release is pretty much known by now; all
> the topics that are marked for 'master' in this issue will likely to
> be in the final, and others will cook during the pre-release freeze
> period.
> 
[ ... ]
> 
> * rj/cygwin-clarify-use-of-cheating-lstat (2013-07-18) 1 commit
>  - cygwin: Remove the Win32 l/stat() implementation
> 
>  Cygwin port added a "not quite correct but a lot faster and good
>  enough for many lstat() calls that are only used to see if the
>  working tree entity matches the index entry" lstat() emulation some
>  time ago, and it started biting us in places.  This removes it and
>  uses the standard lstat() that comes with Cygwin.
> 
>  I am personally in favor of this simpler solution.  Comments?

I had expected this to me marked for 'master'.

Has this simply been overlooked, or do you have reservations about
applying this patch? If so, then I need to find another solution
very quickly [1] (before v1.8.4).  At this time, despite passing the
test suite [2], the cygwin build is still very much broken.

ATB,
Ramsay Jones

[1] I do have another patch, patch #0 actually, which I said I didn't
want applied! :-P

[2] I ran the test suite on v1.8.4-rc0 + 1 patch, like so:

$ GIT_SKIP_TESTS='t0061.3' make test >test-outp16 2>&1

$ tail -17 test-outp16
[22:33:53] t9902-completion.sh ................................ ok    13650 ms
[22:34:26] t9903-bash-prompt.sh ............................... ok    33468 ms
[22:34:26]
All tests successful.

Test Summary Report
-------------------
t7008-grep-binary.sh                             (Wstat: 0 Tests: 23 Failed: 0)
  TODO passed:   12
Files=639, Tests=10291, 9581 wallclock secs ( 2.75 usr  1.41 sys + 9421.84 cusr
4551.31 csys = 13977.31 CPU)
Result: PASS
make clean-except-prove-cache
make[2]: Entering directory `/home/ramsay/git/t'
rm -f -r 'trash directory'.* 'test-results'
rm -f -r valgrind/bin
make[2]: Leaving directory `/home/ramsay/git/t'
make[1]: Leaving directory `/home/ramsay/git/t'
$

This was over 30 minutes faster than the last full test suite run, but it also
ran more tests (420 test files ran faster and 16 new test files were run).
I've *never* had the test suite run faster before! (I'm not going to celebrate
too much; it still took  9581s = 2h39m41s).
