From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] archive.c: use OPT_BOOL()
Date: Tue, 27 Sep 2011 16:59:01 -0700
Message-ID: <7vy5x9tu4a.fsf@alter.siamese.dyndns.org>
References: <7v39fhv8se.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 28 01:59:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8hYQ-00088x-4j
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 01:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854Ab1I0X7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 19:59:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59910 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751638Ab1I0X7H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 19:59:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DBECE57D2;
	Tue, 27 Sep 2011 19:59:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mtRviJFn/t4ZJMP32sklklrBCi4=; b=Q0OkGE
	TOcosdPI8gwBHcmg9G+SNUFrsHs3mw+q1uRX1hHkvWeh1wbCNddjtsndlDZdmI5T
	BzINg4jE1SCuXeRXAJfWdpfbMyQyiaqdIGN0LIDLXxPqG4+cWhPKi+th+tsPY4o4
	Fa6HXdL8vd95ScJzFKslNN++r5SKmzK51j06I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kZnb2qNdwAATEfynXM7Y+ssOcg5hHQuI
	kFMGS4U/WgGbacPc8iu7T7Lc3AMKwXP8nmPCBFKmfVkSOMtLtSAEuk/JRM5J4RKt
	PYidDPGvNioYWUokKlZwcZ7ZsIsJW993pCM79S63KeLjROJFJLb/FHnViPURZggL
	k85XxtjkLzI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D413E57D1;
	Tue, 27 Sep 2011 19:59:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E1C257D0; Tue, 27 Sep 2011
 19:59:03 -0400 (EDT)
In-Reply-To: <7v39fhv8se.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 27 Sep 2011 16:56:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AD42B0F2-E964-11E0-97C2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182279>

The list variable (which is OPT_BOOLEAN) is initialized to 0 and only
checked against 0 in the code, so it is safe to use OPT_BOOL().

The worktree_attributes variable (which is OPT_BOOLEAN) is initialized to
0 and later assigned to a field with the same name in struct archive_args,
which is a bitfield of width 1. It is safe and even more correct to use
OPT_BOOL() here; the new test in 5001 demonstrates why using OPT_COUNTUP
is wrong.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This is an example of "the remaining clean-up tasks" I mentioned.

 archive.c               |    4 ++--
 t/t5001-archive-attr.sh |    9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/archive.c b/archive.c
index 3fd7f47..2ae740a 100644
--- a/archive.c
+++ b/archive.c
@@ -318,7 +318,7 @@ static int parse_archive_args(int argc, const char **argv,
 			"prepend prefix to each pathname in the archive"),
 		OPT_STRING('o', "output", &output, "file",
 			"write the archive to this file"),
-		OPT_BOOLEAN(0, "worktree-attributes", &worktree_attributes,
+		OPT_BOOL(0, "worktree-attributes", &worktree_attributes,
 			"read .gitattributes in working directory"),
 		OPT__VERBOSE(&verbose, "report archived files on stderr"),
 		OPT__COMPR('0', &compression_level, "store only", 0),
@@ -332,7 +332,7 @@ static int parse_archive_args(int argc, const char **argv,
 		OPT__COMPR_HIDDEN('8', &compression_level, 8),
 		OPT__COMPR('9', &compression_level, "compress better", 9),
 		OPT_GROUP(""),
-		OPT_BOOLEAN('l', "list", &list,
+		OPT_BOOL('l', "list", &list,
 			"list supported archive formats"),
 		OPT_GROUP(""),
 		OPT_STRING(0, "remote", &remote, "repo",
diff --git a/t/t5001-archive-attr.sh b/t/t5001-archive-attr.sh
index 02d4d22..f47d871 100755
--- a/t/t5001-archive-attr.sh
+++ b/t/t5001-archive-attr.sh
@@ -57,6 +57,15 @@ test_expect_missing	worktree/ignored
 test_expect_exists	worktree/ignored-by-tree
 test_expect_missing	worktree/ignored-by-worktree
 
+test_expect_success 'git archive --worktree-attributes option' '
+	git archive --worktree-attributes --worktree-attributes HEAD >worktree.tar &&
+	(mkdir worktree2 && cd worktree2 && "$TAR" xf -) <worktree.tar
+'
+
+test_expect_missing	worktree2/ignored
+test_expect_exists	worktree2/ignored-by-tree
+test_expect_missing	worktree2/ignored-by-worktree
+
 test_expect_success 'git archive vs. bare' '
 	(cd bare && git archive HEAD) >bare-archive.tar &&
 	test_cmp archive.tar bare-archive.tar
