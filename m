From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] git-merge: forbid fast-forward and up-to-date when
 --no-commit is given
Date: Thu, 22 Oct 2009 15:26:03 -0700
Message-ID: <7vaazjf4lg.fsf@alter.siamese.dyndns.org>
References: <200910201947.50423.trast@student.ethz.ch>
 <alpine.LNX.2.00.0910201912390.14365@iabervon.org>
 <20091021030608.GA18997@atjola.homenet>
 <7vk4ypb71j.fsf@alter.siamese.dyndns.org> <20091021172123.GB27495@localhost>
 <7v3a5c2zrr.fsf@alter.siamese.dyndns.org>
 <7vpr8g1l2a.fsf_-_@alter.siamese.dyndns.org>
 <20091022192145.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Clemens Buchacher <drizzd@aon.at>,
	Bjorn Steinbrink <B.Steinbrink@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 00:26:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1671-0000ew-Cw
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 00:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbZJVW0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 18:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbZJVW0Q
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 18:26:16 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64592 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbZJVW0P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 18:26:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 86E0E821CC;
	Thu, 22 Oct 2009 18:26:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bG3gTUGQkissXXHQEG2Wl2du9EA=; b=GS72pW
	4CixC2QVVlOh4b2NKGn7kzFshnPFFYr9VwDP7yUqXMykbaraBJ12bg6be9m+Ahwe
	o2whh3LidiZ/E6Wp5ac+BFGymZnPRk6+YwbPJUydlo7MCqicatcKuJeUh0/mEQLp
	a4DRvQDI454dxMjrNx6oV7907fRwI+/Vc63lM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NkGM6M7ZK/Rl31JwwwXYl92oH4g7ZtRj
	4HwvHn1H5+Bo/Jx7jgpYKDMLwS6ij4DMwkPtmJ9Qd0BHEI2BO7RcbyevdNdPJEnb
	A2Cpt9tHSCRlC2PfA3SkgBDZ1R+az/XLd8XCnu/0LcuFmTvhwEL8WHHUqCD4Xs0E
	Osxnx3xBuV8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3488A821CA;
	Thu, 22 Oct 2009 18:26:13 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0E10B821C6; Thu, 22 Oct 2009
 18:26:04 -0400 (EDT)
In-Reply-To: <20091022192145.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Thu\, 22 Oct 2009 19\:21\:45 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E7EC8A0C-BF59-11DE-9A9F-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131071>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> the change breaks --squash to merge a branch, doesn't it?
>
>     % git checkout feature  # from your master branch
>     % work; git commit; work; git commit
>     % git checkout master  # go back to your master branch
>     % git merge --squash feature
>
> This is a useful way to clean up changes that were built
> in small steps that turned out to be worth only a commit.

Incidentally we seemed to have seen an end user request for exactly this
workflow.

A reroll has been queued, as below, with an update to a test script that
expects --no-commit to be a no-op for fast-forward.

-- >8 --

Traditionally "git merge --no-commit" meant just that: do not create a new
commit even when a merge succeeds.  But this leads to confusion when the
merged commit is a descendant of the current commit, in which case we
succeed the merge by fast-forwarding and without creating a new commit.

Also when the merged commit is already a part of the history, we succeeded
without doing anything.

Error out when --no-commit is given but the merge would result in a
fast-forward or an up-to-date.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-merge.c  |   11 +++++++++++
 t/t7600-merge.sh |    4 +---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index b6b8428..2149aed 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -829,6 +829,12 @@ static int evaluate_result(void)
 	return cnt;
 }
 
+static void check_no_commit(const char *msg)
+{
+	if (!option_commit)
+		die("The merge will %s but --no-commit was given.", msg);
+}
+
 int cmd_merge(int argc, const char **argv, const char *prefix)
 {
 	unsigned char result_tree[20];
@@ -996,6 +1002,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		 * If head can reach all the merge then we are up to date.
 		 * but first the most common case of merging one remote.
 		 */
+		check_no_commit("be a no-op because you are up-to-date");
 		finish_up_to_date("Already up-to-date.");
 		return 0;
 	} else if (allow_fast_forward && !remoteheads->next &&
@@ -1006,6 +1013,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		struct object *o;
 		char hex[41];
 
+		if (allow_fast_forward && !squash)
+			check_no_commit("fast forward");
+
 		strcpy(hex, find_unique_abbrev(head, DEFAULT_ABBREV));
 
 		if (verbosity >= 0)
@@ -1074,6 +1084,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			}
 		}
 		if (up_to_date) {
+			check_no_commit("be a no-op because you are up-to-date");
 			finish_up_to_date("Already up-to-date. Yeeah!");
 			return 0;
 		}
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index e5b210b..86b0537 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -265,9 +265,7 @@ test_debug 'gitk --all'
 
 test_expect_success 'merge c0 with c1 (no-commit)' '
 	git reset --hard c0 &&
-	git merge --no-commit c1 &&
-	verify_merge file result.1 &&
-	verify_head $c1
+	test_must_fail git merge --no-commit c1
 '
 
 test_debug 'gitk --all'
-- 
1.6.5.1.124.g746fb6
