From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] git-mv: Keep moved index entries inact
Date: Sun, 20 Jul 2008 21:36:57 -0700
Message-ID: <7vd4l7yhsm.fsf@gitster.siamese.dyndns.org>
References: <20080721002354.GK10151@machine.or.cz>
 <20080721002508.26773.92277.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jul 21 06:38:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKn9z-0001OS-V9
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 06:38:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbYGUEhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 00:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752210AbYGUEhH
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 00:37:07 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57425 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724AbYGUEhG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 00:37:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 14BCC3532B;
	Mon, 21 Jul 2008 00:37:05 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D08313532A; Mon, 21 Jul 2008 00:36:59 -0400 (EDT)
In-Reply-To: <20080721002508.26773.92277.stgit@localhost> (Petr Baudis's
 message of "Mon, 21 Jul 2008 02:25:56 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AB715CC2-56DE-11DD-96DF-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89300>

Petr Baudis <pasky@suse.cz> writes:

> This patch introduces rename_index_entry_at() into the index toolkit,
> which will rename an entry while removing any entries the new entry
> might render duplicate. This is then used in git mv instead
> of all the file queues, resulting in a major simplification
> of the code and an inevitable change in git mv -n output format.
>
> A new test has been added to the testsuite to reflect this change.
> Also, based on suggestion by Junio about desired symlink behaviour
> of git mv, I have added two tests for that; however, I do not have
> need or desire to spend time fixing this, so they are expected
> to fail for now until someone gets around to fixing that.

I haven't looked into the builtin-mv changes to see how involved that fix
would be yet (and I do not use "mv" and this is somewhat lower priority
for me myself), but I did look at changes to read-cache.c.  I've queued a
fixed up version in 'pu' for now but I am hoping that we can see some
comments from more competent people on the patch and move the review
result to 'next' shortly.

This may be a change in semantics, but after thinking about it a bit more,
I think this can even go into maintenance series.  IOW, it is really a
fix.  Nobody sane should have been relying on the old behaviour that new
contents of dirty paths are staged in the index sometimes, which was
simply just crazy.
