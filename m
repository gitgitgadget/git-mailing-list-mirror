From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] fix diff-tree --stdin documentation
Date: Tue, 05 Aug 2008 22:32:28 -0700
Message-ID: <7v7iauu2s3.fsf_-_@gitster.siamese.dyndns.org>
References: <20080805164839.GA3934@diana.vm.bytemark.co.uk>
 <7vwsivusy2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 06 07:33:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQbeU-0008ES-Ue
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 07:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752380AbYHFFcg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Aug 2008 01:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752230AbYHFFcg
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 01:32:36 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54977 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278AbYHFFcf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Aug 2008 01:32:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D8C425652C;
	Wed,  6 Aug 2008 01:32:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 27D595652A; Wed,  6 Aug 2008 01:32:31 -0400 (EDT)
In-Reply-To: <7vwsivusy2.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 05 Aug 2008 13:07:17 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1236C27A-6379-11DD-9C0B-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91484>

Long time ago, the feature of "diff-tree --stdin" to take a commit and =
its
parents on one line was broken, and did not support the common:

    git rev-list --parents $commits... -- $paths... |
    git diff-tree --stdin -v -p

usage pattern by Porcelains properly.  For diff-tree to talk sensibly
about commits, it needs to see commits, not just trees; the code was fi=
xed
to take list of commits on the standard input in 1.2.0.

However we left the documentation stale for a long time, until Karl
Hasselstr=C3=B6m finally noticed it very recently.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-t=
ree.txt
index 8c8f35b..1fdf20d 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -49,13 +49,13 @@ include::diff-options.txt[]
 --stdin::
 	When '--stdin' is specified, the command does not take
 	<tree-ish> arguments from the command line.  Instead, it
-	reads either one <commit> or a pair of <tree-ish>
+	reads either one <commit> or a list of <commit>
 	separated with a single space from its standard input.
 +
 When a single commit is given on one line of such input, it compares
 the commit with its parents.  The following flags further affects its
-behavior.  This does not apply to the case where two <tree-ish>
-separated with a single space are given.
+behavior.  The remaining commits, when given, are used as if they are
+parents of the first commit.
=20
 -m::
 	By default, 'git-diff-tree --stdin' does not show
