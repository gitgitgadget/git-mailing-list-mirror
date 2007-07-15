From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] lockfile.c: schedule remove_lock_file only once.
Date: Sun, 15 Jul 2007 10:35:21 +0200
Message-ID: <20070715083521.GB999MdfPADPa@greensroom.kotnet.org>
References: <20070713141450.GA8392MdfPADPa@greensroom.kotnet.org>
 <7vabu0noxg.fsf@assigned-by-dhcp.cox.net>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 15 10:35:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9zZp-00059I-AO
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 10:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755938AbXGOIfY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 04:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755077AbXGOIfY
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 04:35:24 -0400
Received: from psmtp02.wxs.nl ([195.121.247.11]:58322 "EHLO psmtp02.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752752AbXGOIfX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 04:35:23 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp02.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JL70090XP6X81@psmtp02.wxs.nl> for git@vger.kernel.org; Sun,
 15 Jul 2007 10:35:22 +0200 (MEST)
Received: (qmail 16387 invoked by uid 500); Sun, 15 Jul 2007 08:35:21 +0000
In-reply-to: <7vabu0noxg.fsf@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52532>

On Fri, Jul 13, 2007 at 11:23:07AM -0700, Junio C Hamano wrote:
> The reason we do not use lk->next but instead check lk->on_list,
> and the reason why we do not remove the lock from the list, are
> described in 1084b845.

I'm afraid I'm still missing something:

1084b845 commit message:
    We cannot remove the list element in commit_lock_file(); if we
    are interrupted in the middle of list manipulation, the call to
    remove_lock_file_on_signal() will happen with a broken list
    structure pointed by lock_file_list, which would cause the cruft
    to remain, so not removing the list element is the right thing
    to do.  Instead we should be reusing the element already on the
    list.

We have a list

list--->A--->B--->C

and we overwrite one next pointer to remove an element, say B

list--->A-------->C

At what point is the list structure broken?

If you are worried that the interrupt could happen in the middle
of writing the pointer (could it?), then shouldn't you worry
about adding elements too?

skimo
