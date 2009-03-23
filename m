From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Respect core.autocrlf when preparing temporary files for
 external diff
Date: Sun, 22 Mar 2009 17:39:47 -0700
Message-ID: <7vljqx9ing.fsf@gitster.siamese.dyndns.org>
References: <cover.1237635609u.git.johannes.schindelin@gmx.de>
 <8cb424b16f21164ddc26d0be3f6f7727254b3506.1237635609u.git.johannes.schindelin@gmx.de> <7vocvuekjb.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0903220053260.10279@pacific.mpi-cbg.de> <7v8wmybf06.fsf@gitster.siamese.dyndns.org> <7vzlfe9ynj.fsf@gitster.siamese.dyndns.org> <20090322061046.GA14765@coredump.intra.peff.net> <7v63i281py.fsf@gitster.siamese.dyndns.org> <20090322074643.GA4826@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Sebastian Schuberth <sschuberth@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 23 01:41:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlYEJ-00007a-8Q
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 01:41:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756719AbZCWAj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 20:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754889AbZCWAj5
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 20:39:57 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45433 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753698AbZCWAj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 20:39:57 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C617DA4F06;
	Sun, 22 Mar 2009 20:39:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E5B8DA4F04; Sun,
 22 Mar 2009 20:39:48 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 20C75DEE-1743-11DE-83EF-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114214>

Jeff King <peff@peff.net> writes:

> On Sun, Mar 22, 2009 at 12:18:33AM -0700, Junio C Hamano wrote:
>
>> Ok.  Although I already queued the removal to 'pu' for tonight's pushout
>> and it is way too late to revert that, I think I didn't have to remove the
>> function.  The codepath that lets you cheat by borrowing from the checkout
>> runs convert_to_git() when it borrows, and if you are seeing a meaningful
>> optimization even with that overhead, perhaps it would be worth keeping.
>
> I certainly haven't done exhaustive tests. Obviously the one I did was a
> bit contrived. I just think it makes sense to have numbers rather than
> saying "this probably doesn't do anything anymore".
>
>> While the purist in me says #1 above is the right argument to make for
>> feeding "clean" version, I suspect that the textconv or extdiff tools more
>> often are not made from scratch and ported across platforms than are
>> cobbled up together out of tools the script writer finds on his platform.
>> I suspect that Dscho's "a tempfile should look like a checkout" would be
>> much friendlier to them in practice for this reason.
>
> I think you and I have about the same feeling on this, then. As somebody
> who does not actually use smudge/clean filters at all, I am willing to
> defer to Dscho's opinion, which is based on practical experience.

Thanks for a sanity check.

I've split these as two unrelated issues, and have queued

 (1) Dscho's patch, that always feeds smudged representation to the
     external diff and textconv filter;

 (2) A change to reuse_worktree_file() that says "don't reuse" for paths
     with CE_VALID set.

in 'pu'.
