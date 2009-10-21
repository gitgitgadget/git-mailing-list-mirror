From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git checkout --no-guess
Date: Wed, 21 Oct 2009 15:35:42 -0700
Message-ID: <7vtyxsxtmp.fsf_-_@alter.siamese.dyndns.org>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>
 <alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de>
 <7vzl7pyvzl.fsf@alter.siamese.dyndns.org>
 <7v63adxh9a.fsf_-_@alter.siamese.dyndns.org>
 <81b0412b0910180540u7030c22br7efcaf7f51df771d@mail.gmail.com>
 <7v7huspjg0.fsf@alter.siamese.dyndns.org>
 <32541b130910211029x2f4295c3w40dd13b3cdc7762c@mail.gmail.com>
 <20091022062145.6117@nanako3.lavabit.com>
 <7vskdcz973.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 22 00:40:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0jml-0006bE-5W
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 00:36:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755607AbZJUWfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 18:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755195AbZJUWfx
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 18:35:53 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60596 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765AbZJUWfw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 18:35:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 138C0617D8;
	Wed, 21 Oct 2009 18:35:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yy01ISyAfmvLciPlzniGd9+k89Y=; b=Zx6SpC
	aww+CFGiNwPesjWbDLr3gUlY7NHekv7t3d1pzDL8hl6+7BOM5Um4n9zYqhLmQofR
	otBIdx1afxcQbY9vKpvCRFQ/ZcBNGK+uEL48Y/gnkvFoF+ms2aBfuvQcrVkVHyDl
	szXjByrnf0RKOA7KwysRu4id/yUZxgKr9bx5w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CUYrHUvZlOFXdo9xI8wKov0JPLZzTh4I
	gsRP/OsL3wQNBLd0/p7Mu1i+aH9hl1lteO0qOkQRiTNVpFIu5L4+kW/SgXNqtXL+
	O2wu0dAi7nFz+lZscbBz+1N05P2VsFiqYbMhNstClt3bshK7farjtfKadkPgD8en
	DOTpL/NeaBM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AE829617C2;
	Wed, 21 Oct 2009 18:35:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 897B5617C1; Wed, 21 Oct
 2009 18:35:43 -0400 (EDT)
In-Reply-To: <7vskdcz973.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 21 Oct 2009 15\:14\:08 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 15BC66DC-BE92-11DE-825B-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130979>

Porcelains may want to make sure their calls to "git checkout" will
reliably fail regardless of the presense of random remote tracking
branches by the new DWIMmery introduced.

Luckily all existing in-tree callers have extra checks to make sure they
feed local branch name when they want to switch, or they explicitly ask to
detach HEAD at the given commit, so there is no need to add this option
for them.

As this is strictly script-only option, do not even bother to document it,
and do bother to hide it from "git checkout -h".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Junio C Hamano <gitster@pobox.com> writes:

 > Nanako Shiraishi <nanako3@lavabit.com> writes:
 >
 >> As Junio asked for helping hands, let's try to be helpful and constructive.
 >>
 >> Maybe "don't second-guess" explains it better?
 >
 > Perhaps --no-guess, as --no-second-guess is rather hard to read even in scripts.

 builtin-checkout.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index fb7e68a..da04eed 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -616,6 +616,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	struct tree *source_tree = NULL;
 	char *conflict_style = NULL;
 	int patch_mode = 0;
+	int dwim_new_local_branch = 1;
 	struct option options[] = {
 		OPT__QUIET(&opts.quiet),
 		OPT_STRING('b', NULL, &opts.new_branch, "new branch", "branch"),
@@ -631,6 +632,9 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "conflict", &conflict_style, "style",
 			   "conflict style (merge or diff3)"),
 		OPT_BOOLEAN('p', "patch", &patch_mode, "select hunks interactively"),
+		{ OPTION_BOOLEAN, 0, "guess", &dwim_new_local_branch, NULL,
+		  "second guess 'git checkout no-such-branch'",
+		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
 		OPT_END(),
 	};
 	int has_dash_dash;
@@ -715,6 +719,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			if (has_dash_dash)          /* case (1) */
 				die("invalid reference: %s", arg);
 			if (!patch_mode &&
+			    dwim_new_local_branch &&
 			    opts.track == BRANCH_TRACK_UNSPECIFIED &&
 			    !opts.new_branch &&
 			    !check_filename(NULL, arg) &&
-- 
1.6.5.1.107.gba912
