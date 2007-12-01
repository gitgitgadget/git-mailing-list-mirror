From: Junio C Hamano <gitster@pobox.com>
Subject: Re: To push into a non-bare repository, or not to push into it...
Date: Fri, 30 Nov 2007 18:37:22 -0800
Message-ID: <7v63zj87j1.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711290122440.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Dec 01 03:38:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyIF1-0003xI-Ss
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 03:38:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758708AbXLACh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 21:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758695AbXLACh2
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 21:37:28 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:40369 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758681AbXLACh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 21:37:27 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id B4C5C2F0;
	Fri, 30 Nov 2007 21:37:48 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 4C4EB9BA13;
	Fri, 30 Nov 2007 21:37:46 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66689>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> how about resolving this recurring subject of discussion by introducing a 
> config variable, say "branch.allowPushingIntoHEAD".  We'd teach git-init 
> to set it to "false", and receive-pack would refuse to update HEAD if it 
> is "false", _unless_ core.bare = true.
>
> Of course, we would default the value to "false" to leave existing setups 
> functional.

Perhaps that could be a reasonable compromise, except that it does not
feel right to assume that new repositories are used by new users.
People who have been been trained to expect "git push" to checked out
branches always work (and they know "git reset --hard" or have
equivalent post-update hook) will wonder why their push into a new clone
does not work while their push into existing ones does.

But with a good diagnosis to pushers when receive-pack refuses a push
for this reason, I do not think that should be too much of a problem.

Upon REF_STATUS_REMOTE_REJECT, the message on "ng " line will be given
by send-pack to the pusher, so the infrastructure to do so is already
there, I think.  We need to utilize it when we implement your
suggestion.
