From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: Re: [PATCH] Bug: failed octopus merge does not create MERGE_HEAD
Date: Sun, 14 Mar 2010 20:24:24 +0100
Message-ID: <87r5nmzoyf.fsf@steelpick.localdomain>
References: <1268402835-12992-1-git-send-email-sojkam1@fel.cvut.cz> <7vr5no7xlo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 14 20:24:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqtQZ-00034b-VA
	for gcvg-git-2@lo.gmane.org; Sun, 14 Mar 2010 20:24:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752429Ab0CNTYa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Mar 2010 15:24:30 -0400
Received: from max.feld.cvut.cz ([147.32.192.36]:43516 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751589Ab0CNTY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Mar 2010 15:24:29 -0400
Received: from localhost (unknown [192.168.200.4])
	by max.feld.cvut.cz (Postfix) with ESMTP id 94C4019F364F;
	Sun, 14 Mar 2010 20:24:28 +0100 (CET)
X-Virus-Scanned: IMAP AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.4]) (amavisd-new, port 10044)
	with ESMTP id xBq+TvzbDpyF; Sun, 14 Mar 2010 20:24:26 +0100 (CET)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id B718A19F33A8;
	Sun, 14 Mar 2010 20:24:25 +0100 (CET)
Received: from steelpick.localdomain (unknown [213.29.198.144])
	(Authenticated sender: sojkam1)
	by imap.feld.cvut.cz (Postfix) with ESMTPSA id 778EDFA003;
	Sun, 14 Mar 2010 20:24:25 +0100 (CET)
Received: from wsh by steelpick.localdomain with local (Exim 4.71)
	(envelope-from <sojkam1@fel.cvut.cz>)
	id 1NqtQG-0003xW-Uj; Sun, 14 Mar 2010 20:24:24 +0100
In-Reply-To: <7vr5no7xlo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142148>

On Sat, 13 Mar 2010, Junio C Hamano wrote:
> Hmm.
> 
> When it detects conflicts, and refuses to make a merge, the octopus
> backend says "should not be doing an octopus".  As far as I can tell,
> MERGE_HEAD is useful only when resolving conflicts, and the octopus

There is also another use - see below.

> strongly discourages recording anything but the simplest conflict-free
> merges.

How can I know in advance that the merge will be conflict free? I have a
script which merges a bunch of (simple) topic branches which usually
merge without conflict, but from time to time some branch evolves and
conflicts.

> That makes me think that not writing the file out would be the more
> correct thing to do.

> 
> One possibility I can think of is that we try to prevent user mistakes by
> checking the existence of MERGE_HEAD (i.e. "can't do this, you are still
> during a merge"), and not writing MERGE_HEAD in this case, but still
> potentially leaving the index unmerged, may allow some operations that we
> should prevent from being invoked to proceed.  Is that the issue you are
> trying to address?  Or is there something else?  Why do you want to have
> MERGE_HEAD?

I'm using zsh and vcs_info which shows me git repo status in my prompt
(see e.g. http://www.jukie.net/~bart/blog/pimping-out-zsh-prompt).
vcs_info tests for existence of MERGE_HEAD to signalize that you are in
the middle of merge. If MERGE_HEAD is not created I do not see a big red
waning in my prompt and I expect the merge to be successful.

In my experiments I found that octopus creates MERGE_HEAD in several
situations but not in the one when a branch modifies the file and
another deletes it. Therefore I think it is a bug.

-Michal
