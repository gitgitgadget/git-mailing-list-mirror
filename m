From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-branch silently ignores --track on local branches
Date: Sat, 10 Nov 2007 10:43:28 -0800
Message-ID: <7vfxzelz5b.fsf@gitster.siamese.dyndns.org>
References: <20071110174557.GC1036@blorf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Wayne Davison <wayne@opencoder.net>
X-From: git-owner@vger.kernel.org Sat Nov 10 19:43:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqvJA-0004ki-6i
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 19:43:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204AbXKJSng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 13:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752349AbXKJSng
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 13:43:36 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:57630 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204AbXKJSnf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 13:43:35 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 6C0AB2F2;
	Sat, 10 Nov 2007 13:43:56 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id E17EA93EDE;
	Sat, 10 Nov 2007 13:43:51 -0500 (EST)
In-Reply-To: <20071110174557.GC1036@blorf.net> (Wayne Davison's message of
	"Sat, 10 Nov 2007 09:45:57 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64365>

Wayne Davison <wayne@opencoder.net> writes:

> ...  Is there
> a problem with local branches being supported when explicitly
> requested?

Maybe this one?

commit 6f084a56fcb3543d88d252bb49c1d2bbf2bd0cf3
Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Date:   Tue Jul 10 18:50:44 2007 +0100

    branch --track: code cleanup and saner handling of local branches
    
    This patch cleans up some complicated code, and replaces it with a
    cleaner version, using code from remote.[ch], which got extended a
    little in the process.  This also enables us to fix two cases:
    
    The earlier "fix" to setup tracking only when the original ref started
    with "refs/remotes" is wrong.  You are absolutely allowed to use a
    separate layout for your tracking branches.  The correct fix, of course,
    is to set up tracking information only when there is a matching
    remote.<nick>.fetch line containing a colon.
    
    Another corner case was not handled properly.  If two remotes write to
    the original ref, just warn the user and do not set up tracking.
    
    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

As a local branch does not have to be "fetched", the restriction
on "remote.<nick>.fetch" is sort of pointless.

Also why remote.<nick>.fetch needs a colon, I begin to wonder.
You can be keep fetching and merging from the same branch of the
same remote without keeping a remote tracking branch for that,
but the above "correct fix" forbids that.

Dscho, what were we smoking when we made this change?
