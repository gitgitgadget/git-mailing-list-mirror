From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Fix t3701 if core.filemode disabled
Date: Tue, 20 May 2008 23:59:32 +0200
Message-ID: <20080520215932.GB10437@steel.home>
References: <20080518152337.GB3058@steel.home> <20080518190839.GC15506@sigill.intra.peff.net> <20080518200121.GA5789@steel.home> <20080519202342.GA9694@steel.home> <20080519205550.GA24246@sigill.intra.peff.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 21 00:00:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyZt0-0006RO-2S
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 00:00:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763762AbYETV7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2008 17:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763689AbYETV7h
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 17:59:37 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:13584 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763682AbYETV7g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 17:59:36 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarKZB1HUNA==
Received: from tigra.home (Faa97.f.strato-dslnet.de [195.4.170.151])
	by post.webmailer.de (fruni mo49) (RZmta 16.37)
	with ESMTP id Y06ecak4KIwJid ; Tue, 20 May 2008 23:59:32 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 804EB277BD;
	Tue, 20 May 2008 23:59:32 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 8611956D28; Tue, 20 May 2008 23:59:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080519205550.GA24246@sigill.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82508>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
Jeff King, Mon, May 19, 2008 22:55:50 +0200:
> On Mon, May 19, 2008 at 10:23:42PM +0200, Alex Riesen wrote:
> 
> > > I setting core.filemode _inside_ the test breaks it in exactly the
> > > same way (on Linux, I'm at home). I'll retest tomorrow
> > 
> > It is "git init" which sets core.filemode false (of course!)
> 
> Ah, of course. In that case, then your change makes sense; by definition,
> if core.filemode isn't set, those tests are meaningless. Though I think
> a final version should, as we discussed, omit those tests rather than
> ending the test script.
> 

Sure. I have explicitely test for core.filemode=false, because
some older setups (where git init did not set it) don't have
the setting and git config core.filemode reports nothing.

 t/t3701-add-interactive.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index f15be93..bd94ac6 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -65,6 +65,7 @@ test_expect_success 'revert works (commit)' '
 	git add -i </dev/null >output &&
 	grep "unchanged *+3/-0 file" output
 '
+if test "$(git config core.filemode)" != false ; then
 
 test_expect_success 'patch does not affect mode' '
 	git reset --hard &&
@@ -84,5 +85,6 @@ test_expect_success 'stage mode but not hunk' '
 	git diff          file | grep "+content"
 '
 
+fi
 
 test_done
-- 
1.5.5.1.354.g902c
