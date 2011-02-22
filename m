From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/2] revlist.c: introduce --left/right-only for
 unsymmetric picking
Date: Mon, 21 Feb 2011 17:19:02 -0800
Message-ID: <7vlj18g92x.fsf@alter.siamese.dyndns.org>
References: <4D625972.4090500@drmicha.warpmail.net>
 <a3224c4269b26c366bb5b5df691f22f17b767f83.1298304396.git.git@drmicha.warpmail.net> <7vvd0cgahg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Feb 22 02:19:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrguK-0007iU-B0
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 02:19:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634Ab1BVBTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 20:19:12 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41332 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248Ab1BVBTK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 20:19:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D5A224A4C;
	Mon, 21 Feb 2011 20:20:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JfGhgVZJtH2BbkmRV4nUPZf3YRg=; b=V8P2Ul
	IUV/SfIXXLMjUEcUc3CeUBZRYEl3HFgm4uq9dJH9SgGJW434v9uaXyIxxhcA9xtD
	zZ+xRplL2qpsCzmlwumGDbb8dq8KnjI9HUWC0cEM1cxYlGrifnIjjto92Obi7h5/
	G5ThqzUXj21FLsrLl2y76t0UvLNOwv0QvxXjs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FCq/8s3sm/y2tbF7RHdrO9TnHaUoFiMD
	lu4xZzlU039xaCm96GESirPSfse6vXIXqFpuCK5KmBtVyDY8b4kcKP/2+S0K2Xip
	ir2+0SF29EwwndNi8ALo8zs2/wRv0YMTECbW+DEMk/4dhlFEZmy54L3FmeyHXhhW
	TITFsV0gDkk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B32E74A4B;
	Mon, 21 Feb 2011 20:20:18 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9201F4A46; Mon, 21 Feb 2011
 20:20:15 -0500 (EST)
In-Reply-To: <7vvd0cgahg.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 21 Feb 2011 16\:48\:43 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E91B0546-3E21-11E0-A80B-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167522>

Junio C Hamano <gitster@pobox.com> writes:

>>     It could be followed up by introducing --cherry as equivalent to
>>     --cherry-pick --right-only --no-merges.
>
> Yeah, I think that is a good idea.

-- >8 --
Subject: [PATCH] log --cherry: a synonym

At the Porcelain level, because by definition there are many more contributors
than integrators, it makes sense to give a handy short-hand for --right-only
used with --cherry-pick.  Make it so.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * We would want to add some tests, but I thought at least I owe you
   the final patch to bring the handy short-hand after this back and
   forth first, so here it is.

 Documentation/rev-list-options.txt |    7 +++++++
 revision.c                         |    9 ++++++++-
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index cebba62..3068dc3 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -332,6 +332,13 @@ commits from `B` which are in `A` or are patch-equivalent to a commit in
 More precisely, `--cherry-pick --right-only --no-merges` gives the exact
 list.
 
+--cherry::
+
+	A synonym for `--right-only --cherry-pick --no-merges`; useful to
+	limit the output to the commits on our side that have not been
+	applied to the other side of a forked history with `git log --cherry
+	upstream...mybranch`.
+
 -g::
 --walk-reflogs::
 
diff --git a/revision.c b/revision.c
index 1fcaeb7..f747526 100644
--- a/revision.c
+++ b/revision.c
@@ -1285,12 +1285,19 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->left_right = 1;
 	} else if (!strcmp(arg, "--left-only")) {
 		if (revs->right_only)
-			die("--left-only is incompatible with --right-only");
+			die("--left-only is incompatible with --right-only"
+			    " or --cherry");
 		revs->left_only = 1;
 	} else if (!strcmp(arg, "--right-only")) {
 		if (revs->left_only)
 			die("--right-only is incompatible with --left-only");
 		revs->right_only = 1;
+	} else if (!strcmp(arg, "--cherry")) {
+		if (revs->left_only)
+			die("--cherry is incompatible with --left-only");
+		revs->cherry_pick = 1;
+		revs->right_only = 1;
+		revs->limited = 1;
 	} else if (!strcmp(arg, "--count")) {
 		revs->count = 1;
 	} else if (!strcmp(arg, "--cherry-pick")) {
-- 
1.7.4.1.107.ga7184
