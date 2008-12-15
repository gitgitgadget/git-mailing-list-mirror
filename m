From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] modify/delete conflict resolution overwrites untracked
 file
Date: Mon, 15 Dec 2008 02:22:28 -0800
Message-ID: <7vskopwxej.fsf@gitster.siamese.dyndns.org>
References: <20081210201259.GA12928@localhost>
 <20081215004651.GA16205@localhost>
 <7v63lm1c76.fsf@gitster.siamese.dyndns.org>
 <7vmyeyyuuh.fsf@gitster.siamese.dyndns.org> <20081215095949.GA7403@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de, raa.lkml@gmail.com
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Dec 15 11:24:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCAcJ-0003SS-AJ
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 11:23:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596AbYLOKWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 05:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752606AbYLOKWk
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 05:22:40 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36581 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343AbYLOKWj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 05:22:39 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2B1371A4E8;
	Mon, 15 Dec 2008 05:22:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id F35951A4E7; Mon,
 15 Dec 2008 05:22:29 -0500 (EST)
In-Reply-To: <20081215095949.GA7403@localhost> (Clemens Buchacher's message
 of "Mon, 15 Dec 2008 10:59:49 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4CB0256A-CA92-11DD-BB21-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103152>

Clemens Buchacher <drizzd@aon.at> writes:

> On Sun, Dec 14, 2008 at 07:34:46PM -0800, Junio C Hamano wrote:
>> merge-recursive: do not clobber untracked working tree garbage
>> 
>> When merge-recursive wanted to create a new file in the work tree (either
>> as the final result, or a hint for reference purposes while delete/modify
>> conflicts), it unconditionally overwrote an untracked file in the working
>> tree.  Be careful not to lose whatever the user has that is not tracked.
>
> This leaves the index in an unmerged state, however, so that a subsequent
> git reset --hard still kills the file. And I just realized that the same
> goes for merge-resolve. So I'd prefer to abort the merge, leave everything
> unchanged and tell the user to clean up first.

That is unfortunately asking for a moon, I am afraid.

It needs a major restructuring of the code so that the recursive works
more like the way resolve works, namely, changing the final "writeout"
into two phase thing (the first phase making sure nothing is clobbered in
the work tree, and then the second phase actually touching the work tree).
