From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Blame in reverse
Date: Thu, 03 Apr 2008 12:47:23 -0700
Message-ID: <7v1w5m201g.fsf@gitster.siamese.dyndns.org>
References: <7v4paj486a.fsf@gitster.siamese.dyndns.org>
 <47F4BE98.8060209@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Apr 03 21:48:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhVQ5-0007j4-Db
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 21:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755788AbYDCTre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 15:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756885AbYDCTre
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 15:47:34 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59855 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755770AbYDCTrd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 15:47:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 27AB3339F;
	Thu,  3 Apr 2008 15:47:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 75742339E; Thu,  3 Apr 2008 15:47:26 -0400 (EDT)
In-Reply-To: <47F4BE98.8060209@viscovery.net> (Johannes Sixt's message of
 "Thu, 03 Apr 2008 13:25:12 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78771>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Junio C Hamano schrieb:
>> Usual "git blame" starts from the latest revision and finds where each
>> line came from (i.e. who came up with that brilliant idea, or more often
>> who introduced that bug).  This new mode starts from an old revision, and
>> annotates in reverse --- up to which point each line survived, before it
>> got replaced with something else. 
>
> Nice!! Is the result somehow different from
>
> 	$ git rev-list --reverse HEAD > /tmp/blame.revs
> 	$ git blame -S /tmp/blame.revs foo.c

Doesn't -S read from a graft-like file, where each line shows a commit and
then its parents?

Come to think of it, I probably should have done:

	git rev-list --children

which is a mirror image of "git rev-list --parents".  Unlike the
additional "child" header in the output of the log-tree family, that would
not have any controversial format or UI design issues.  Also the resulting
output from such command can then be fed via -S to blame.

However, as I mentioned in the message of [4/4], I think showing the
commit that "introduced" the line is not useful when blame runs in
reverse; blame needs to have a switch to tell it which commit to show
(either "the guilty party" or "the ones the guilty party tried to pass
blame on") anyway, so even though feeding an upside-down topology to the
command via its "-S" can try to mimic what it does, it does not
reallysolve what I wanted to do.
