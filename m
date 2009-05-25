From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC PATCH] am: do not do any reset on --abort
Date: Mon, 25 May 2009 14:17:48 +0200
Message-ID: <4A1A8C6C.5020009@viscovery.net>
References: <20090525104308.GA26775@coredump.intra.peff.net> <alpine.DEB.1.00.0905251348050.4288@intel-tinevez-2-302> <20090525120019.GA1740@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 25 14:18:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8Z7x-00016G-V5
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 14:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866AbZEYMRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 08:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751711AbZEYMRw
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 08:17:52 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:60705 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbZEYMRw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 08:17:52 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1M8Z7n-0001gQ-Iv; Mon, 25 May 2009 14:17:52 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 1DF8954D; Mon, 25 May 2009 14:17:51 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <20090525120019.GA1740@coredump.intra.peff.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119931>

Jeff King schrieb:
> On Mon, May 25, 2009 at 01:49:18PM +0200, Johannes Schindelin wrote:
> 
>>> We really have no idea what state the tree is in at this
>>> point, and whether the user might have done useful work on
>>> top of it. So let's err on the side of keeping the user's
>>> data intact.
>>>
>>> The downside is that if they do have cruft to get rid of, or
>>> want to pretend as if earlier parts of the series that were
>>> applied did not exist, they must manually "git reset --hard"
>>> now.
>> Hmm.  I think I would revert that patch after merging git.git right away.
> 
> You know, you can just say you don't like it. ;)
> 
>> Can you at least check for a dirty tree and reset --hard if it is clean?
> 
> No, that would defeat the purpose. The problem is that we have no idea
> what has happened since the initial "git am". The user may have made
> commits they want to keep, and we don't want to reset those away. They
> may even have pulled, which means ORIG_HEAD can no longer be trusted for
> a reset.

I wonder why we have this problem (and do something about it) with git-am,
but not with git-rebase. Is it perhaps that the usual case were people
were bitten by the old behavior is:

   $ git am mbox
   .... stops with conflicts
   .... oops, wrong branch
   $ git checkout other-branch
   $ git am mbox
   error: git am is already in progress
   $ git am --abort
   OUTCH! other-branch was reset!

rebase is not used in this manner, and even though it does reset --hard,
it doesn't hurt (that often).

-- Hannes
