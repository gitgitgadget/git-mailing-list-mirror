From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash completion: Fix the . -> .. revision range
	completion
Date: Sun, 13 Jul 2008 22:06:31 +0000
Message-ID: <20080713220631.GB12708@spearce.org>
References: <20080713111847.29801.8969.stgit@localhost> <7vskudpiqq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 00:07:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI9jB-0002Lm-7B
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 00:07:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754004AbYGMWGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 18:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753833AbYGMWGc
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 18:06:32 -0400
Received: from george.spearce.org ([209.20.77.23]:46042 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbYGMWGc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 18:06:32 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 81D0A3836B; Sun, 13 Jul 2008 22:06:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vskudpiqq.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88349>

Junio C Hamano <gitster@pobox.com> wrote:
> Petr Baudis <pasky@suse.cz> writes:
> > When Git sees a string with trailing dot on a place where revision
> > range could occur, it will unconditionally append another dot to
...
> > 	git log git-submodule.<tab>
...
> By the way, the above command line is another "dot" related frustration I
> always have.  If you try:
> 
> 	git log v1.5.6.<TAB>
> 
> the completion code adds a dot unconditionally when I want to choose from
> the list of v1.5.6.X tags.

This annoys me too Junio.  Its a bug I just never got around to fixing.
Based on Petr's comments and yours I'm wondering if this is just not the
better patch to apply here:

--8<--
bash completion: Don't offer "a.." as a completion for "a."

If the user is trying to complete "v1.5.3.<tab>" to see all of
the available maintenance releases for 1.5.3 we should not give
them an extra dot as the completion.  Instead if the user wants
a ".." or a "..." operator they should key the two dots out on
their own.  Its the same number of keystrokes either way.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 61581fe..9a1c66a 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -324,9 +324,6 @@ __git_complete_revlist ()
 		cur="${cur#*..}"
 		__gitcomp "$(__git_refs)" "$pfx" "$cur"
 		;;
-	*.)
-		__gitcomp "$cur."
-		;;
 	*)
 		__gitcomp "$(__git_refs)"
 		;;
-- 
1.5.6.2.393.g45096

-- 
Shawn.
