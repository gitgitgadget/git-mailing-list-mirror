From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Optional shrinking of RCS keywords in git-p4
Date: Mon, 15 Sep 2008 15:22:33 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0809151354040.19665@iabervon.org>
References: <16219.81556.qm@web95005.mail.in2.yahoo.com> <20080915063521.GA1533@linode.davidb.org> <7vy71tetvt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Brown <git@davidb.org>, dhruva <dhruva@ymail.com>,
	GIT SCM <git@vger.kernel.org>, Simon Hausmann <simon@lst.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 21:23:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfJfp-0002DH-6E
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 21:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752605AbYIOTWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 15:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752974AbYIOTWf
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 15:22:35 -0400
Received: from iabervon.org ([66.92.72.58]:34458 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751707AbYIOTWe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 15:22:34 -0400
Received: (qmail 22637 invoked by uid 1000); 15 Sep 2008 19:22:33 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Sep 2008 19:22:33 -0000
In-Reply-To: <7vy71tetvt.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95929>

On Mon, 15 Sep 2008, Junio C Hamano wrote:

> David Brown <git@davidb.org> writes:
> 
> > ...  As far as I can tell, P4 completely
> > ignores whatever the $Id: ...$ headers happen to be expanded to at the
> > time of checking.  You can put garbage there, and it check in fine.
> > ...
> > I guess it isn't a problem to make this optional in git-p4, but I
> > don't think this patch is solving the right problem.
> 
> Hmm.  I do not do p4, but what I am guessing is that there probably is a
> configuration switch on the p4 side that lets you check in files with
> "$Id: garbage $" in them, while dhruva hasn't turned that switch on.

Actually, the problem seems to be that git-p4 tries to create the modified 
file by applying the git-generated diff to the p4-provided file, and this 
fails if the context for the git-generated diff contains a keyword, since 
the p4-provided file has it expanded and git has it collapsed.

I think the right solution is for git-p4 to check that p4 thinks the file 
is the correct file and then simply replace it rather than trying to 
generate the right result by patching. To be a bit more careful, git-p4 
could check that the contents it's replacing actually would exactly match 
the git contents if the keywords were callapsed (if the p4 setting is to 
use keywords in this file).

	-Daniel
*This .sig left intentionally blank*
