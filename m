From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] modify/delete conflict resolution overwrites untracked
	file
Date: Thu, 11 Dec 2008 09:07:52 +0100
Message-ID: <20081211080752.GA26709@localhost>
References: <20081210201259.GA12928@localhost> <7vzlj3ycr4.fsf@gitster.siamese.dyndns.org> <20081210211147.GA13624@localhost> <7voczjy55g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alex Riesen <raa.lkml@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 09:09:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAgbm-0001Om-9p
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 09:09:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbYLKIHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 03:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbYLKIHy
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 03:07:54 -0500
Received: from postman.fh-hagenberg.at ([193.170.124.96]:26640 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbYLKIHx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 03:07:53 -0500
Received: from darc.dyndns.org ([84.154.80.98]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 11 Dec 2008 09:07:51 +0100
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1LAgaO-00073x-Sj; Thu, 11 Dec 2008 09:07:52 +0100
Content-Disposition: inline
In-Reply-To: <7voczjy55g.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 11 Dec 2008 08:07:51.0688 (UTC) FILETIME=[9043A080:01C95B67]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102787>

On Wed, Dec 10, 2008 at 03:36:11PM -0800, Junio C Hamano wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
> >
> > "merge -s resolve" fails with
> >
> > Trying really trivial in-index merge...
> > error: Merge requires file-level merging
> > Nope.
> > Trying simple merge.
> > Simple merge failed, trying Automatic merge.
> > ERROR: c1.c: Not handling case ae9304576a6ec3419b231b2b9c8e33a06f97f9fb ->
> > -> 8173b675dc61bb578b411c769c9fb654625a7c4e
> > fatal: merge program failed
> > Automatic merge failed; fix conflicts and then commit the result.
> >
> > and therefore passes the test.
> 
> Are you saying that:
> 
>  (1) the step should result in conflict and the merge should fail, but it
>      should not clobber c1.c nevertheless; and
> 
>  (2) resolve fails to merge (as expected), and it does not clobber c1.c
>      (as expected); therefore it passes the test.

The latter.

> If so, then you now established that it is a bug in merge-recursive,
> right [implementors of recursive-in-C CC'ed]?

Correct.

> Or are you saying that the step should not fail to begin with?

No. IMO, merge should fail and abort. That is, it should not modify the
working tree at all and tell the user that an untracked file is in the way.

The tests check that merge returns an error code and c1.c is not modified.
Test number 5 fails, unless the merge strategy resolve is used. While this
indicates a bug in the recursive strategy, I am not satisfied with the error
output of the resolve strategy either. It should output

"error: Untracked working tree file '...' would be overwritten by merge."

just like test number 2 does.
