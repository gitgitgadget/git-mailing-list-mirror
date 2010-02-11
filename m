From: Jeff King <peff@peff.net>
Subject: Re: git cherry-pick --continue?
Date: Thu, 11 Feb 2010 17:27:14 -0500
Message-ID: <20100211222714.GA12805@coredump.intra.peff.net>
References: <fabb9a1e1002101237i60a0b2c5j6d1e52b33dacbaa2@mail.gmail.com>
 <20100210210419.GA7728@coredump.intra.peff.net>
 <20100210212408.GB7728@coredump.intra.peff.net>
 <7v63644uoq.fsf@alter.siamese.dyndns.org>
 <7vbpfw3f6t.fsf@alter.siamese.dyndns.org>
 <20100211193248.GA27072@coredump.intra.peff.net>
 <7vfx5733x7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 11 23:27:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfhVH-0000Uh-21
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 23:27:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757210Ab0BKW1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 17:27:13 -0500
Received: from peff.net ([208.65.91.99]:37606 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756937Ab0BKW1N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 17:27:13 -0500
Received: (qmail 22391 invoked by uid 107); 11 Feb 2010 22:27:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 11 Feb 2010 17:27:21 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Feb 2010 17:27:14 -0500
Content-Disposition: inline
In-Reply-To: <7vfx5733x7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139636>

On Thu, Feb 11, 2010 at 12:36:52PM -0800, Junio C Hamano wrote:

> > Do you just want to pick up my patch from earlier in the thread, or do
> > you have further comments? The only thing I could think to change would
> > be that we may not want to even bother advertising --continue in the
> > usage message (conversely, we could go a step further and actually
> > advertise it in the manpage).
> 
> I would say our eventual goal should be to make "--continue" the primary
> word the end users would see.  It would bring us closer to that goal to
> start advertising --continue early.

OK. Then I think my patch is fine. But we could also do this if we
wanted to push it further now:

-- >8 --
Subject: [PATCH] am: switch --resolved to --continue

Rebase calls this same function "--continue", which means
users may be trained to type it. There is no reason to
deprecate --resolved (or -r), so we will keep it as a
synonym.

Signed-off-by: Jeff King <peff@peff.net>
---
Between this and the previous patch, I don't have a strong preference.
You can decide.

 Documentation/git-am.txt |    3 ++-
 git-am.sh                |    5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index c3e4f12..c66c565 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -15,7 +15,7 @@ SYNOPSIS
 	 [--whitespace=<option>] [-C<n>] [-p<n>] [--directory=<dir>]
 	 [--reject] [-q | --quiet] [--scissors | --no-scissors]
 	 [<mbox> | <Maildir>...]
-'git am' (--skip | --resolved | --abort)
+'git am' (--continue | --skip | --abort)
 
 DESCRIPTION
 -----------
@@ -107,6 +107,7 @@ default.   You can use `--no-utf8` to override this.
 	Skip the current patch.  This is only meaningful when
 	restarting an aborted patch.
 
+--continue::
 -r::
 --resolved::
 	After a patch failure (e.g. attempting to apply
diff --git a/git-am.sh b/git-am.sh
index c8b9cbb..3c08d53 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -25,7 +25,8 @@ p=              pass it through git-apply
 patch-format=   format the patch(es) are in
 reject          pass it through git-apply
 resolvemsg=     override error message when patch failure occurs
-r,resolved      to be used after a patch failure
+continue        continue applying patches after resolving a conflict
+r,resolved      synonyms for --continue
 skip            skip the current patch
 abort           restore the original branch and abort the patching operation.
 committer-date-is-author-date    lie about committer date
@@ -318,7 +319,7 @@ do
 		scissors=t ;;
 	--no-scissors)
 		scissors=f ;;
-	-r|--resolved)
+	-r|--resolved|--continue)
 		resolved=t ;;
 	--skip)
 		skip=t ;;
-- 
1.7.0.rc2.37.g157e8.dirty
