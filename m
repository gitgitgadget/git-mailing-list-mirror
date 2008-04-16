From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: fsck --full is Ok, but clones are not, "missing commits"?!
Date: Wed, 16 Apr 2008 15:22:04 +0200
Message-ID: <4805FD7C.5000206@viscovery.net>
References: <200804161334.17748.brian.foster@innova-card.com> <a537dd660804160448w5ba28f13m8c081ebc2a71db91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org
To: Brian Foster <brian.foster@innova-card.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 15:29:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jm7bE-0006xk-30
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 15:22:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759543AbYDPNWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 09:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755252AbYDPNWK
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 09:22:10 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:33131 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754713AbYDPNWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 09:22:09 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Jm7aP-0007Xp-5J; Wed, 16 Apr 2008 15:22:05 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id EC2FB6C4; Wed, 16 Apr 2008 15:22:04 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <a537dd660804160448w5ba28f13m8c081ebc2a71db91@mail.gmail.com>
X-Spam-Score: 2.2 (++)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5, PLING_QUERY=0.514
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79698>

Brian Foster schrieb:
> Dmitry Potapov <dpotapov@gmail.com> correctly deduced:
>>  I suspect your original git repository has info/grafts
> 
> hi Dmitry,
> 
>  bingo!  YES, it does:
...
>  the goal is to put things into a sane state so any new
>  clones are healthy.  there's only one(?) existing clone,
>  which may or may not be(? become?) an issue.

Just move info/grafts out of the way and you *may* be all set. Don't
delete it - there might be a reason that the file exists.

However!

You might observe one or more of the following:

- Parts of the history are missing. The reason is that the grafts were
used to "splice" histories that are actually independent.

- Previously unkown (to you) parts of the history are now visible. Then
the grafts were used to hide these parts.

- The repository is broken. Then 'git repack -f -d -a' was done while the
grafts were in effect (and obviously the grafts had hidden parts of the
history, which are now no longer available).

Your best bet is to run 'git filter-branch --tag-name-filter cat -- --all'
on *a copy* of your bare repository (with info/grafts in place). (Read the
warning about --tag-name-filter in the man page first.)

-- Hannes
