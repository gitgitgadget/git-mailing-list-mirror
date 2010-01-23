From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/7] Documentation: emphasize when git merge terminates
 early
Date: Sat, 23 Jan 2010 03:44:17 -0600
Message-ID: <20100123094417.GF7571@progeny.tock>
References: <20100123092551.GA7571@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 10:45:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYcXW-0002Gy-Lj
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 10:44:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752971Ab0AWJoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 04:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752790Ab0AWJoS
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 04:44:18 -0500
Received: from mail-iw0-f186.google.com ([209.85.223.186]:42219 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960Ab0AWJoR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 04:44:17 -0500
Received: by iwn16 with SMTP id 16so820832iwn.33
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 01:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6WQ2xUA5BpSTiOfHyrVid6oYBBb9f2lK0e1K3+FADEA=;
        b=q7mfbFPQzeINCrb4FI6ikl662wOqz4oVVpBIb9h8KjYz15xPRRRU85XGbwvNlYQ6Th
         6HDF3xxiHBiQYazdBQ+Iw2ikCO0X07Kn/fQSVGbCWxxtaRx/UpmdEO8d1lrSXXwqTmu0
         Dak6SAneOc+WcQUAFoKVQZCvfX5xHelJl6K44=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qVylo97IL2vdvKwec+35d5hnQTGbkBdm0xjPzLv+uhOItwIH48RPeb10lxQitTlEi2
         Asw2bCsdWD2chaAEkn2Vtn2DaWLhCqzsWXV1yc2QwQj8uRTJ6YNLHiDZx1e030Nu9EFc
         EPYcSqaAeN9hOm4QeILGQmvLfSYSX7Y1yKsQ4=
Received: by 10.231.150.2 with SMTP id w2mr405538ibv.90.1264239856287;
        Sat, 23 Jan 2010 01:44:16 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm2437912iwn.2.2010.01.23.01.44.15
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 Jan 2010 01:44:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100123092551.GA7571@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137823>

A merge-based operation in git can fail in two ways: one that
stops before touching anything, or one that goes ahead and
results in conflicts.

As the 'git merge' manual explains:

| A merge is always between the current `HEAD` and one or more
| commits (usually, branch head or tag), and the index file must
| match the tree of `HEAD` commit (i.e. the contents of the last commit)
| when it starts out.

Unfortunately, the placement of this sentence makes it easy to
skip over, and its formulation leaves the important point, that
any other attempted merge will be gracefully aborted, unspoken.

So give this point its own section and expand upon it.

Probably this could be simplified somewhat: after all, a change
registered in the index is just a special kind of local
uncommited change, so the second added paragraph is only a
special case of the first.  It seemed more helpful to be explicit
here.

Inspired by <http://gitster.livejournal.com/25801.html>.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Too technical?

 Documentation/git-merge.txt |   31 +++++++++++++++++++++----------
 1 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index a7a40c6..3663d58 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -67,21 +67,32 @@ include::merge-options.txt[]
 	<commit> obviously means you are trying an Octopus.
 
 
+PRE-MERGE CHECKS
+----------------
+
+Before applying outside changes, you should get your own work in
+good shape and committed locally, so it will not be clobbered if
+there are conflicts.  See also linkgit:git-stash[1].
+'git pull' and 'git merge' will stop without doing anything when
+local uncommitted changes overlap with files that 'git pull'/'git
+merge' may need to update.
+
+To avoid recording unrelated changes in the merge commit,
+'git pull' and 'git merge' will also abort if there are any changes
+registered in the index relative to the `HEAD` commit.  (One
+exception is when the changed index entries are in the state that
+would result from the merge already.)
+
+If all named commits are already ancestors of `HEAD`, 'git merge'
+will exit early with the message "Already up-to-date."
+
 HOW MERGE WORKS
 ---------------
 
 A merge is always between the current `HEAD` and one or more
-commits (usually, branch head or tag), and the index file must
-match the tree of `HEAD` commit (i.e. the contents of the last commit)
-when it starts out.  In other words, `git diff --cached HEAD` must
-report no changes.  (One exception is when the changed index
-entries are already in the same state that would result from
-the merge anyway.)
-
-Three kinds of merge can happen:
+commits (usually a branch head or tag).
 
-* The merged commit is already contained in `HEAD`. This is the
-  simplest case, called "Already up-to-date."
+Two kinds of merge can happen:
 
 * `HEAD` is already contained in the merged commit. This is the
   most common case especially when invoked from 'git pull':
-- 
1.6.6
