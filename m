From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git rebase is confuse if conflict resolution doesn't
 produce diff
Date: Fri, 15 Aug 2008 11:41:26 -0700
Message-ID: <7vzlne9l49.fsf@gitster.siamese.dyndns.org>
References: <1218819643.6345.57.camel@cass-lpt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Guillaume Desmottes <guillaume.desmottes@collabora.co.uk>
X-From: git-owner@vger.kernel.org Fri Aug 15 20:42:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU4Fw-00019c-Dn
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 20:42:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753599AbYHOSld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 14:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753868AbYHOSld
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 14:41:33 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45276 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680AbYHOSld (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 14:41:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E17D45A2DA;
	Fri, 15 Aug 2008 14:41:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2E2265A2D9; Fri, 15 Aug 2008 14:41:28 -0400 (EDT)
In-Reply-To: <1218819643.6345.57.camel@cass-lpt> (Guillaume Desmottes's
 message of "Fri, 15 Aug 2008 18:00:43 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C799DA58-6AF9-11DD-A751-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92507>

Guillaume Desmottes <guillaume.desmottes@collabora.co.uk> writes:

> To reproduce:
> - Rebase a branch "foo" on a branch "bar" in a way that there is a
> conflict that you have to manually resolve.
> - Run git diff and see the conflict
> - Edit the conflicted file and remove all the conflicting bits (that
> could be a valid resolution of the conflict)
> - Now git diff produces an empty diff
> - git add $CONFLICTED_FILE  as you have resolve the conflict
> - git rebase --continue

I think you would need a bit more than that to trigger this "behaviour".
Your resolution needs to be such that it is identical to the HEAD where
the rebased change is applied to, iow, among the series of commits, the
final effect chosen by you from this particular one is not to do
anything.  So, not just "Now git diff produces an empty diff" in the above
sequence, which merely means that the three-way --cc diff between the
conflicted parties are resolved by taking from one side, after that "git
add", "git diff HEAD" will have to be empty, for you to see the message.

In essence, the final effect chosen by you is to skip this commit.  You
might want to say "git rebase --skip" here if that is the case.
