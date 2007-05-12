From: Jan Hudec <bulb@ucw.cz>
Subject: [PATCH] Minor fixup to documentation of hooks in git-receive-pack.
Date: Sat, 12 May 2007 23:43:11 +0200
Message-ID: <20070512214311.GA13381@efreet.light.src>
References: <7vd515wyue.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 12 23:44:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmzNe-0006ts-07
	for gcvg-git@gmane.org; Sat, 12 May 2007 23:43:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754888AbXELVnh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 17:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755903AbXELVnh
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 17:43:37 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:3031 "EHLO mail.bluetone.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754888AbXELVnf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 17:43:35 -0400
Received: from ([85.207.119.145])
	by mail.bluetone.cz with ESMTP with TLS id 5203017.198467;
	Sat, 12 May 2007 23:43:11 +0200
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1HmzMt-0003UO-7W; Sat, 12 May 2007 23:43:11 +0200
Content-Disposition: inline
In-Reply-To: <7vd515wyue.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-esp: ESP<0>=
	RBL:<0> 
	SHA:<0> 
	UHA:<0> 
	BAYES:<0> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47100>

Small additional changes to the cbb84e5d174cf33fd4dcf3136de50a886ff9a2e2
commit, which introduced documentation to pre-receive and post-receive:
 - Mention that stdout and stderr are equivalent.
 - Add one cross-section link and fix one other.
 - Fix information on advantages of post-receive over post-update.

Signed-off-by: Jan Hudec <bulb@ucw.cz>
---

Ok, here are incremental corrections:

 - IMHO mentioning that stdout and stderr are equal is useful, because when
   writing the script you often redirect stdout and than need stderr for the
   messages.
 - There was an error in one of the links (used [[]] instead of <<>>)
 - The paragraph in post-update was incorrect -- post-update is actually
   called just once with all refs as arguments, it just does not get the
   values (which it could get from reflog, if it's turned on, but it does not
   have to be).

Regards,

Jan

 Documentation/hooks.txt |   37 ++++++++++++++++++++-----------------
 1 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/Documentation/hooks.txt b/Documentation/hooks.txt
index 80ba670..aabb975 100644
--- a/Documentation/hooks.txt
+++ b/Documentation/hooks.txt
@@ -115,8 +115,9 @@ If the hook exits with non-zero status, none of the refs will be
 updated. If the hook exits with zero, updating of individual refs can
 still be prevented by the <<update,'update'>> hook.
 
-If you want to report something to the `git-send-pack` on the other end,
-you can simply `echo` your messages.
+Both standard output and standard error output are forwarded to
+`git-send-pack` on the other end, so you can simply `echo` messages
+for the user.
 
 [[update]]
 update
@@ -153,9 +154,9 @@ Another use suggested on the mailing list is to use this hook to
 implement access control which is finer grained than the one
 based on filesystem group.
 
-The standard output of this hook is sent to `stderr`, so if you
-want to report something to the `git-send-pack` on the other end,
-you can simply `echo` your messages.
+Both standard output and standard error output are forwarded to
+`git-send-pack` on the other end, so you can simply `echo` messages
+for the user.
 
 The default 'update' hook, when enabled--and with
 `hooks.allowunannotated` config option turned on--prevents
@@ -171,17 +172,20 @@ It executes on the remote repository once after all the refs have
 been updated.
 
 This hook executes once for the receive operation.  It takes no
-arguments, but gets the same information as the `pre-receive`
+arguments, but gets the same information as the
+<<pre-receive,'pre-receive'>>
 hook does on its standard input.
 
 This hook does not affect the outcome of `git-receive-pack`, as it
 is called after the real work is done.
 
-This supersedes the [[post-update]] hook in that it actually get's
-both old and new values of all the refs.
+This supersedes the <<post-update,'post-update'>> hook in that it get's
+both old and new values of all the refs in addition to their
+names.
 
-If you want to report something to the `git-send-pack` on the
-other end, you can simply `echo` your messages.
+Both standard output and standard error output are forwarded to
+`git-send-pack` on the other end, so you can simply `echo` messages
+for the user.
 
 The default 'post-receive' hook is empty, but there is
 a sample script `post-receive-email` provided in the `contrib/hooks`
@@ -205,12 +209,10 @@ the outcome of `git-receive-pack`.
 
 The 'post-update' hook can tell what are the heads that were pushed,
 but it does not know what their original and updated values are,
-so it is a poor place to do log old..new.
-
-In general, `post-receive` hook is preferred when the hook needs
-to decide its acion on the status of the entire set of refs
-being updated, as this hook is called once per ref, with
-information only on a single ref at a time.
+so it is a poor place to do log old..new. The
+<<post-receive,'post-receive'>> hook does get both original and
+updated values of the refs. You might consider it instead if you need
+them.
 
 When enabled, the default 'post-update' hook runs
 `git-update-server-info` to keep the information used by dumb
@@ -219,4 +221,5 @@ a git repository that is accessible via HTTP, you should
 probably enable this hook.
 
 Both standard output and standard error output are forwarded to
-`git-send-pack` on the other end.
+`git-send-pack` on the other end, so you can simply `echo` messages
+for the user.
-- 
1.5.1.4
