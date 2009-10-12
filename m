From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] bash completion: complete refs for git-grep
Date: Mon, 12 Oct 2009 11:00:09 +0200
Message-ID: <9f58ba1e7db9702d1b0594a8016c204e3d50b72f.1255337776.git.trast@student.ethz.ch>
References: <200910071727.50770.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 12 11:04:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxGpW-0007XQ-T6
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 11:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755130AbZJLJBj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 05:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755057AbZJLJBi
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 05:01:38 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:21667 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754655AbZJLJBh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 05:01:37 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Mon, 12 Oct
 2009 11:00:49 +0200
Received: from localhost.localdomain (129.132.208.114) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Mon, 12 Oct
 2009 11:00:48 +0200
X-Mailer: git-send-email 1.6.5.61.g35405
In-Reply-To: <200910071727.50770.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129997>

Before the --, always attempt ref completion.  This helps with
entering the <treeish> arguments to git-grep.  As a bonus, you can
work around git-grep's current lack of --all by hitting M-*, ugly as
the resulting command line may be.

Strictly speaking, completing the regular expression argument (or
option argument) makes no sense.  However, we cannot prevent _all_
completion (it will fall back to filenames), so we dispense with any
additional complication to detect whether the user still has to enter
a regular expression.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Sorry for taking so long; I was swamped all weekend by, well, the
weekend. ;-)

I wrote:
> Shawn O. Pearce wrote:
> > > This is still RFC because, as you can see in the code below, I tried
> > > to avoid completing at all while the user still needs to supply a
> > > regex.  Sadly, bash turns the COMPREPLY=() into filename completion
> > > anyway.  Is there a way to prevent this?
> > 
> > Not that I know of.  You can turn off default filename completion
> > when you register the completion function, but that then breaks
> > like every other git command for completion support because a lot
> > of them do want to complete filenames.
> 
> So I'll roll a simpler patch that just always (before --) completes
> refs instead, if that's ok.

So that's what this patch does.


 contrib/completion/git-completion.bash |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6fd7e1d..b08cd77 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1048,7 +1048,8 @@ _git_grep ()
 		return
 		;;
 	esac
-	COMPREPLY=()
+
+	__gitcomp "$(__git_refs)"
 }
 
 _git_help ()
-- 
1.6.5.61.g35405
