From: Gerrit Pape <pape@smarden.org>
Subject: Re: [PATCH] git-commit: don't add multiple Signed-off-by: from the same identity
Date: Sun, 8 Jul 2007 15:00:55 +0000
Message-ID: <20070708150055.7018.qmail@10e1f648410572.315fe32.mid.smarden.org>
References: <20070706144227.11736.qmail@046ba2bc1a0185.315fe32.mid.smarden.org> <7vy7hte717.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 08 17:00:43 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7YFe-0006zn-JP
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 17:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753705AbXGHPAk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 11:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753729AbXGHPAk
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 11:00:40 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:50169 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752965AbXGHPAj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 11:00:39 -0400
Received: (qmail 7019 invoked by uid 1000); 8 Jul 2007 15:00:55 -0000
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vy7hte717.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51889>

On Fri, Jul 06, 2007 at 11:11:48AM -0700, Junio C Hamano wrote:
> If you are trying to avoid a run of Signed-off-by: lines like this:
> 
> 	Signed-off-by: Original Author <oa@example.com>
> 	Signed-off-by: First Reviewer <fr@example.com>
> 	Signed-off-by: Second Reviewer <sr@example.com>
> 	Signed-off-by: Original Author <oa@example.com>
> 	Signed-off-by: Subsystem Integrator <si@example.com>
> 
> It is not a bug.  If the last signed-off-by is not from
> yourself, your signed-off-by is added when you ask with "-s",

This is what the patch does, it only checks against the final line,
sorry, the subject is incorrect.  The behavior currently is

 $ ./git-commit -m foo foo
 Created commit 2fad03e: foo
  0 files changed, 0 insertions(+), 0 deletions(-)
  create mode 100644 foo
 $ EDITOR=cat ./git-commit --amend -s foo |head -n4
 foo

 Signed-off-by: Gerrit Pape <pape@smarden.org>

 $ EDITOR=cat ./git-commit --amend -s foo |head -n4
 foo

 Signed-off-by: Gerrit Pape <pape@smarden.org>
 Signed-off-by: Gerrit Pape <pape@smarden.org>
 $ 

with the patch, iff the last line already was the signoff to be added,
it won't be added again.

> We have deliberately excluded what your other patch tries to do
> for a reason.  Even though these lines are not digitally signed,
> the intent of adding a Signed-off-by: line with your name is
> that you are certifying its origin, according to the definition
> of DCO (see Documentation/SubmittingPatches).  This should be a
> conscious act from the signer's part, and making it automatic
> with a config variable that you set once and forget makes it
> much less meaningful.

Okay, to me personally it would be convenient, for the git repository I
have no problem with, and want to simply singoff all commits, for other
repos none.

Regards, Gerrit.
