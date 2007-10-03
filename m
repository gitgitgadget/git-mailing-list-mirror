From: David Kastrup <dak@gnu.org>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 03 Oct 2007 20:09:07 +0200
Message-ID: <85wsu4qddo.fsf@lola.goethe.zz>
References: <20070927023633.GA28902@coredump.intra.peff.net>
	<20071002041652.GA32133@coredump.intra.peff.net>
	<7vsl4up0tf.fsf@gitster.siamese.dyndns.org>
	<20071002050820.GA4261@coredump.intra.peff.net>
	<20071002051332.GA4462@coredump.intra.peff.net>
	<86ejge6o8b.fsf@lola.quinscape.zz>
	<20071002161114.GC6828@coredump.intra.peff.net>
	<86ve9p32cp.fsf@lola.quinscape.zz>
	<alpine.LFD.0.999.0710021916080.3579@woody.linux-foundation.org>
	<85641oy5ge.fsf@lola.goethe.zz>
	<20071003165927.GA25055@coredump.intra.peff.net>
	<alpine.LFD.0.999.0710031007340.3579@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Oct 03 21:10:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id9cU-0005mH-2M
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 21:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbXJCTKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 15:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753667AbXJCTKp
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 15:10:45 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:54969 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046AbXJCTKo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 15:10:44 -0400
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1Id9bT-0005RV-58; Wed, 03 Oct 2007 15:09:51 -0400
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 722821C4CE15; Wed,  3 Oct 2007 20:09:07 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.999.0710031007340.3579@woody.linux-foundation.org> (Linus Torvalds's message of "Wed\, 3 Oct 2007 10\:53\:27 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59866>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 3 Oct 2007, Jeff King wrote:
>>
>> Try profiling the code, and you will see that the creation of the hashes
>> is totally dwarfed by the comparisons. So yes, you might be able to
>> speed up the creation code, but it's going to have a minimal impact on
>> the overall run time.
>
> Yeah. Oprofile is your friend.

Well, and if -Oprofile has no strong opinion, I'd let wc -l pitch in.

When we are not actually going to use the hash tables as hash tables,
why create them as such?  If the first thing that actually looks at
the values of the hashes (except possibly for the optimization of not
storing the same hash twice in succession) is the sort, then there is
no code that can go out of whack when confronted with degenerate data.

Maybe it's not much of an optimization, but it certainly should be a
cleanup.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
