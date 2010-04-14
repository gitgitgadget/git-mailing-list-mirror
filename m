From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] Document gc.<pattern>.reflogexpire variables
Date: Wed, 14 Apr 2010 13:34:43 -0700
Message-ID: <7vljcppycc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 14 22:34:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O29IT-0000RB-E2
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 22:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756653Ab0DNUes (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 16:34:48 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58740 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756537Ab0DNUer (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 16:34:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EC1BAA2B1;
	Wed, 14 Apr 2010 16:34:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=n4p0
	tWBtPFuKMfL6bENYUn6e1vQ=; b=NgUyDfD0cTZfnbGpwidYXZcZTfTvmCiNkd8+
	XTaV7YI/ZoJeYltCwxBUUfEI4+dCf8RM9HFAZT+Zxzk3io/ruEd+4JJJ9XFRn/hQ
	o29voCewN3CaW22T0Pf62iY0jzfSzH5ppLetHdzx5aKzLryvvt+4yrXxDzBg5K0l
	ellEU+E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=vdG
	IL/h1Sf2vPdf26bqV2tA+sgjTiZWalm5tO3+t94PZVVYzvSdWpnWzx+9kNjI3k0q
	cD5KFSNYh8pa7LZiIaMHHkS89MPFtSDgut020n1T7m8sbZnYnVIToTUXO0QOE0fo
	BGKpoBW0OeqzNF41b2NNKxgOvpPz/0+2Sq+b4+/s=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 76EDCAA2AF;
	Wed, 14 Apr 2010 16:34:46 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E2956AA2AD; Wed, 14 Apr
 2010 16:34:44 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2A356968-4805-11DF-BDD4-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144907>

3cb22b8 (Per-ref reflog expiry configuration, 2008-06-15) added support
for setting the expiry parameters differently for different reflog, but
it was never documented.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This comes on top of b4ca1db (reflog --expire-unreachable: avoid
   merge-base computation, 2010-04-07).

 Documentation/config.txt |   10 ++++++++--
 Documentation/git-gc.txt |   10 ++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a1e36d7..4e7dab6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -885,13 +885,19 @@ gc.pruneexpire::
 	unreachable objects immediately.
 
 gc.reflogexpire::
+gc.<pattern>.reflogexpire::
 	'git-reflog expire' removes reflog entries older than
-	this time; defaults to 90 days.
+	this time; defaults to 90 days.  With "<pattern>" (e.g.
+	"refs/stash") in the middle the setting applies only to
+	the refs that match the <pattern>.
 
 gc.reflogexpireunreachable::
+gc.<ref>.reflogexpireunreachable::
 	'git-reflog expire' removes reflog entries older than
 	this time and are not reachable from the current tip;
-	defaults to 30 days.
+	defaults to 30 days.  With "<pattern>" (e.g. "refs/stash")
+	in the middle, the setting applies only to the refs that
+	match the <pattern>.
 
 gc.rerereresolved::
 	Records of conflicted merge you resolved earlier are
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 4cd9cdf..85d7111 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -88,6 +88,16 @@ commits prior to the amend or rebase occurring.  Since these changes
 are not part of the current project most users will want to expire
 them sooner.  This option defaults to '30 days'.
 
+The above two configuration variables can be given to a pattern.  For
+example, this sets non-default expiry values only to remote tracking
+branches:
+
+------------
+[gc "refs/remotes/*"]
+	reflogExpire = never
+	reflogexpireUnreachable = 3 days
+------------
+
 The optional configuration variable 'gc.rerereresolved' indicates
 how long records of conflicted merge you resolved earlier are
 kept.  This defaults to 60 days.
-- 
1.7.1.rc1.252.gce30c
