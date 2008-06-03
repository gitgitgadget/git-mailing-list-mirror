From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase --interactive: Compute upstream SHA1 before
 switching branches
Date: Mon, 02 Jun 2008 19:28:49 -0700
Message-ID: <7vbq2j5k0u.fsf@gitster.siamese.dyndns.org>
References: <4843FD44.90905@viscovery.net>
 <alpine.DEB.1.00.0806021628260.13507@racer.site.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 03 04:29:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3MHd-0005t0-8e
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 04:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753760AbYFCC3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 22:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752687AbYFCC3E
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 22:29:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42720 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627AbYFCC3D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 22:29:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 369F63961;
	Mon,  2 Jun 2008 22:28:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 55B653960; Mon,  2 Jun 2008 22:28:55 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0806021628260.13507@racer.site.net> (Johannes
 Schindelin's message of "Mon, 2 Jun 2008 16:29:17 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D28644B6-3114-11DD-9044-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83612>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> BTW, methinks, this checkout is unnecessary, since before the rebase 
>> begins, there is a 'git checkout $ONTO', and the branch switching is 
>> certainly not needed to compute the todo list...
>
> It is needed to determine which branch to update after finish.

I'll apply Hannes's patch for now as I do not want to leave an obvious fix
out of -rc1.

I think Hannes is referring to the same issue as the one dealt with with
0cb0664 (rebase [--onto O] A B: omit needless checkout, 2008-03-15) for
the non-interactive codepath.

You certainly "need to determine which branch to update after finish", and
you do need to remember what branch you were on (if you were not called
with the <branch> parameter), or what branch were given from the command
line (if you got one as <branch> parameter) in order to do so, but the way
to remember these values does not have to involve an extra checkout.

By doing an extra checkout of "the original HEAD", before switching to a
detached HEAD state at the $ONTO commit to "clean the slate" to apply the
sequence on top, more work tree entries will be smudged, forcinging more
recompilations than necessary if the tracked contents are "source" files.
