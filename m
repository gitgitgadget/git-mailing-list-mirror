From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] modify/delete conflict resolution overwrites untracked
	file
Date: Mon, 15 Dec 2008 10:59:49 +0100
Message-ID: <20081215095949.GA7403@localhost>
References: <20081210201259.GA12928@localhost> <20081215004651.GA16205@localhost> <7v63lm1c76.fsf@gitster.siamese.dyndns.org> <7vmyeyyuuh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de, raa.lkml@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 11:00:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCAG2-0004dJ-FG
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 11:00:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291AbYLOJ7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 04:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753265AbYLOJ7l
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 04:59:41 -0500
Received: from postman.fh-hagenberg.at ([193.170.124.96]:18647 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753251AbYLOJ7k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 04:59:40 -0500
Received: from darc.dyndns.org ([84.154.114.217]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 15 Dec 2008 10:59:38 +0100
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1LCAEv-0002Tx-Rb; Mon, 15 Dec 2008 10:59:49 +0100
Content-Disposition: inline
In-Reply-To: <7vmyeyyuuh.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 15 Dec 2008 09:59:38.0523 (UTC) FILETIME=[D7806EB0:01C95E9B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103146>

On Sun, Dec 14, 2008 at 07:34:46PM -0800, Junio C Hamano wrote:
> merge-recursive: do not clobber untracked working tree garbage
> 
> When merge-recursive wanted to create a new file in the work tree (either
> as the final result, or a hint for reference purposes while delete/modify
> conflicts), it unconditionally overwrote an untracked file in the working
> tree.  Be careful not to lose whatever the user has that is not tracked.

This leaves the index in an unmerged state, however, so that a subsequent
git reset --hard still kills the file. And I just realized that the same
goes for merge-resolve. So I'd prefer to abort the merge, leave everything
unchanged and tell the user to clean up first.
