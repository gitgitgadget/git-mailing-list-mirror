From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/3] t3700: avoid racy git situation
Date: Thu, 08 Nov 2007 12:42:40 -0800
Message-ID: <7vbqa431vj.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711081213580.4362@racer.site>
	<Pine.LNX.4.64.0711081414160.4362@racer.site>
	<47331E65.9010209@viscovery.net>
	<Pine.LNX.4.64.0711081511440.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	krh@redhat.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 08 21:43:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqEDT-0004po-2a
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 21:43:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760783AbXKHUmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 15:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754656AbXKHUmv
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 15:42:51 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:44606 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754177AbXKHUmu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 15:42:50 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 88B202FC;
	Thu,  8 Nov 2007 15:43:09 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id C7AD893923;
	Thu,  8 Nov 2007 15:43:04 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711081511440.4362@racer.site> (Johannes
	Schindelin's message of "Thu, 8 Nov 2007 15:16:17 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64068>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The problem is that the index has the same timestamp as the file "foo".
>
> Therefore, git cannot tell if "foo" is up-to-date in the index, since it 
> could have been modified (and indeed is) just a fraction of a second later 
> than the index was last updated.
>
> And since diff-index, as called from the test script, does not generate a 
> diff, but really only determines if the index information suggests that 
> the files are up-to-date, there is not really much you can do.
>
> This is our good old friend, the racy git problem.

That sounds very wrong.

What happened to the ce_smudge_racily_clean_entry() call that is
done from write_index()?

> NOTE: other scms do not have this problem, mostly because they are too 
> slow to trigger it.

I recall racy-hg mentioned on their development list twice, a
few months apart, and CVS has the "delay the return from a
commit to the next full second" or something to work around
problems in the timestamp recorded in CVS/Entries.
