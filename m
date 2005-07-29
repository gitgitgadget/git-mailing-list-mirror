From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: [PATCH] document git-rev-list better
Date: Fri, 29 Jul 2005 20:10:46 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.07.29.18.10.41.948607@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Fri Jul 29 20:17:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyZQ2-0007dB-3j
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 20:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262693AbVG2SPF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 14:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262697AbVG2SPF
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 14:15:05 -0400
Received: from main.gmane.org ([80.91.229.2]:61367 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262693AbVG2SNz (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 14:13:55 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DyZKN-0006pX-5L
	for git@vger.kernel.org; Fri, 29 Jul 2005 20:11:23 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Jul 2005 20:11:23 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Jul 2005 20:11:23 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Document new (and not-so-new) flags of git-rev-list.

Signed-off-By: Matthias Urlichs <smurf@smurf.noris.de>
---
diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -9,14 +9,35 @@ git-rev-list - Lists commit objects in r
 
 SYNOPSIS
 --------
-'git-rev-list' [ *--max-count*=number ] [ *--max-age*=timestamp ] [ *--min-age*=timestamp ] [ *--merge-order* [ *--show-breaks* ] ] <commit>
+'git-rev-list' [ *--max-count*=number ] [ *--max-age*=timestamp ] [ *--min-age*=timestamp ] [ *--bisect* ] [ *--pretty* ] [ *--objects* ] [ *--merge-order* [ *--show-breaks* ] ] <commit> [ <commit> ...] [ ^<commit> ...]
 
 DESCRIPTION
 -----------
 Lists commit objects in reverse chronological order starting at the
-given commit, taking ancestry relationship into account.  This is
+given commit(s), taking ancestry relationship into account.  This is
 useful to produce human-readable log output.
 
+Commits which are stated with a preceding '^' cause listing to stop at
+that point. Their parents are implied. "git-rev-list foo bar ^baz" thus
+means "list all the commits which are included in 'foo' and 'bar', but
+not in 'baz'".
+
+If *--pretty* is specified, print the contents of the commit changesets
+in human-readable form.
+
+The *--objects* flag causes 'git-rev-list' to print the object IDs of
+any object referenced by the listed commits. 'git-rev-list --objects foo
+^bar' thus means "send me all object IDs which I need to download if
+I have the commit object 'bar', but not 'foo'".
+
+The *--bisect* flag limits output to the one commit object which is
+roughly halfway between the included and excluded commits. Thus,
+if "git-rev-list --bisect foo ^bar ^baz" outputs 'midpoint', the output
+of "git-rev-list foo ^midpoint" and "git-rev-list midpoint ^bar ^baz"
+would be of roughly the same length. Finding the change which introduces
+a regression is thus reduced to a binary search: repeatedly generate and
+test new 'midpoint's until the commit chain is of length one.
+
 If *--merge-order* is specified, the commit history is decomposed into a
 unique sequence of minimal, non-linear epochs and maximal, linear epochs.
 Non-linear epochs are then linearised by sorting them into merge order, which
