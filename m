From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: dangling commits and blobs: is this normal?
Date: Wed, 22 Apr 2009 11:53:45 -0500
Message-ID: <W0cjdA0pSHr_AbT2c-k5hDf7LyNvwkc38qIIhTtJJRwFnGBxaBsEiw@cipher.nrlssc.navy.mil>
References: <450196A1AAAE4B42A00A8B27A59278E70ACE0502@EXCHANGE.trad.tradestation.com> <20090422152719.GA12881@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: John Dlugosz <JDlugosz@TradeStation.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 22 18:55:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwfjM-0007cP-NU
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 18:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753968AbZDVQxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 12:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753833AbZDVQxz
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 12:53:55 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:60674 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753602AbZDVQxy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 12:53:54 -0400
Received: by mail.nrlssc.navy.mil id n3MGrkms027382; Wed, 22 Apr 2009 11:53:46 -0500
In-Reply-To: <20090422152719.GA12881@coredump.intra.peff.net>
X-OriginalArrivalTime: 22 Apr 2009 16:53:45.0730 (UTC) FILETIME=[E6775620:01C9C36A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117217>

Jeff King wrote:
> On Tue, Apr 21, 2009 at 05:46:16PM -0400, John Dlugosz wrote:
> 
>> Immediately after doing a git gc, a git fsck --full reports dangling
>> objects.  Is this normal?  What does dangling mean, if not those things
>> that gc finds?
> 
> gc will leave dangling loose objects for a set expiration time
> (defaulting to two weeks). This makes it safe to run even if there are
> operations in progress that want those dangling objects, but haven't yet
> added a reference to them (as long as said operation takes less than two
> weeks).
> 
> You can also end up with dangling objects in packs. When that pack is
> repacked, those objects will be loosened, and then eventually expired
> under the rule mentioned above. However, I believe gc will not always
> repack old packs; it will make new packs until you have a lot of packs,
> and then combine them all (at least that is what "gc --auto" will do; I
> don't recall whether just "git gc" follows the same rule).

'git gc' (without --auto) always creates one new pack.

I've often wondered whether a plain 'git gc' should adopt the behavior
of --auto with respect to the number of packs.  If there were few packs,
then 'git gc' would do an incremental repack, rather than a 'repack -A -d -l'.

I'm still on the fence about it.  I think 'git gc' is supposed to be a
do-the-right-thing command, so in that sense I think it would be good
behavior and it would probably be what most less experienced users want.
But, 'git gc' is also used by experienced users who may expect the historical
behavior and may _want_ the "pack into one pack" behavior.  It could also be
that the more experienced users who want the "pack into one pack" behavior
are actually the only users of 'git gc', and others just rely on the automatic
'git gc --auto' calling.

Not sure.

-brandon
