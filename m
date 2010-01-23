From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 6/7] Documentation: merge: add a section about fast-forward
Date: Sat, 23 Jan 2010 03:45:33 -0600
Message-ID: <20100123094533.GG7571@progeny.tock>
References: <20100123092551.GA7571@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 10:45:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYcYk-00035D-Vc
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 10:45:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974Ab0AWJpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 04:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751695Ab0AWJpf
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 04:45:35 -0500
Received: from mail-iw0-f186.google.com ([209.85.223.186]:35946 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051Ab0AWJpe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 04:45:34 -0500
Received: by iwn16 with SMTP id 16so821272iwn.33
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 01:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=/L0wOJm2LTfYutERAsa1Jaze6+6zomxZtu52wKU8UFk=;
        b=ESAM9nQcj8jFEoxiYfqWohZg0/LS37tliOvD8IoY/lQLdTEUyq1CW7DU0HyHwC0KNP
         8vq/DCex1E3LjHbDrDF5cPx9pl+UDGt6tSKkMNywLNNz6cCndwSKDm4yxmpMsY3e4YQl
         ttgp15NjKKNeH31jAnakQ+Qjcdaq0RPSV12Lw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FFdpq6OsLcFmL/0eRa77D3g8TmFngha3SezqlUF2gq9bemc8bw+0BKgr9JXfDM7ojd
         JJi+pet55QKYRkMfK4+ZHIrUbzJOOMXZ4s1GmHSrUj2oxXK/W/3IeuQRC5blC1NJCFLt
         GBnTIuCQWiasuRYXmvayVPYyDdMWWTsnjmmFw=
Received: by 10.231.148.16 with SMTP id n16mr2010052ibv.37.1264239931638;
        Sat, 23 Jan 2010 01:45:31 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm2592747iwn.5.2010.01.23.01.45.30
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 Jan 2010 01:45:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100123092551.GA7571@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137824>

Novices sometimes find the behavior of 'git merge' in the
fast-forward case surprising.  Describe it thoroughly.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Sometimes people ask on IRC.

 Documentation/git-merge.txt |   31 ++++++++++++++++++-------------
 1 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 3663d58..0b86f2b 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -86,25 +86,30 @@ would result from the merge already.)
 If all named commits are already ancestors of `HEAD`, 'git merge'
 will exit early with the message "Already up-to-date."
 
+FAST-FORWARD MERGE
+------------------
+
+Often the current branch head is an ancestor of the named commit.
+This is the most common case especially when invoked from 'git
+pull': you are tracking an upstream repository, you have committed
+no local changes, and now you want to update to a newer upstream
+revision.  In this case, a new commit is not needed to store the
+combined history; instead, the `HEAD` (along with the index) is
+updated to point at the named commit, without creating an extra
+merge commit.
+
+This behavior can be suppressed with the `--no-ff` option.
+
 HOW MERGE WORKS
 ---------------
 
 A merge is always between the current `HEAD` and one or more
 commits (usually a branch head or tag).
 
-Two kinds of merge can happen:
-
-* `HEAD` is already contained in the merged commit. This is the
-  most common case especially when invoked from 'git pull':
-  you are tracking an upstream repository, have committed no local
-  changes and now you want to update to a newer upstream revision.
-  Your `HEAD` (and the index) is updated to point at the merged
-  commit, without creating an extra merge commit.  This is
-  called "Fast-forward".
-
-* Both the merged commit and `HEAD` are independent and must be
-  tied together by a merge commit that has both of them as its parents.
-  The rest of this section describes this "True merge" case.
+Except in a fast-forward merge (see above), the branches to be
+merged must be tied together by a merge commit that has both of them
+as its parents.
+The rest of this section describes this "True merge" case.
 
 The chosen merge strategy merges the two commits into a single
 new source tree.
-- 
1.6.6
