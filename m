From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Show submodules as modified when they contain a dirty
 work tree
Date: Wed, 13 Jan 2010 14:10:48 -0800
Message-ID: <7v6375lkpj.fsf@alter.siamese.dyndns.org>
References: <4B4BA096.5000909@web.de>
 <7vtyusb6rv.fsf@alter.siamese.dyndns.org> <4B4CA13F.6020505@web.de>
 <7vbpgyqy4a.fsf@alter.siamese.dyndns.org> <4B4E1817.1070202@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Lars Hjemli <hjemli@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jan 13 23:11:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVBQo-00086C-3X
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 23:11:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756591Ab0AMWLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 17:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756581Ab0AMWLJ
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 17:11:09 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48787 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756565Ab0AMWLH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 17:11:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E09CE9040C;
	Wed, 13 Jan 2010 17:11:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LMGTIrPVSDZ3QD4o68iP9ZWZXCQ=; b=wzucXD
	RF4yeDWKe8fl++VYuDwxYgwexxZFUkD5Ard+cHj67moC1UStDFxyC91aP4v0UR8g
	F0ReZMEOISD3EwWYy0hdzCiaGlNRKfI3vn4AjNaltKtUFOma4m99zD3UWVQ+RfUz
	G7cZKliAXatzo16CiJoofJbymujJm2S9J1/Lk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IqbJmGK3LPaYq1y+fVzUjBvSm67ru4wV
	A+UbX8x6lu2KftBzPYEbZut40VML5sBmPV2Qx1RmyifPKLfpYM3qwCI4mt6qNqZo
	5YkL6HxZCaLReindkpA8cdQcBHc1CrZF/cfVfvtVsN68i75Xkepq6cZZ3LvhHDvl
	yTg1mP92FBc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BB8F90407;
	Wed, 13 Jan 2010 17:10:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0AFF690404; Wed, 13 Jan
 2010 17:10:49 -0500 (EST)
In-Reply-To: <4B4E1817.1070202@web.de> (Jens Lehmann's message of "Wed\, 13
 Jan 2010 19\:59\:35 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8665A930-0090-11DF-9591-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136890>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Thanks for your review, here is the updated patch. Changes to the RFC
> version are:
>
>   - Removed check for a dangling HEAD (now the testsuite runs fine)
>   - Reworded the commit message
>   - Inlined is_submodule_working_directory_dirty() into
>     is_submodule_modified()
>   - The new code will only be called when refs did match (when they
>     didn't the submodule will already show up as modified)

Looking good.

I had to squash in '#include "submodule.h"' in diff-lib.c just after it
includes "refs.h", though.

And a patch to add:

>> * It doesn't give detailed output when doing a "git diff* -p" with or
>>   without the --submodule option. It should show something like
>> 
>>     diff --git a/sub b/sub
>>     index 5431f52..3f35670 160000
>>     --- a/sub
>>     +++ b/sub
>>     @@ -1 +1 @@
>>     -Subproject commit 5431f529197f3831cdfbba1354a819a79f948f6f
>>     +Subproject commit 3f356705649b5d566d97ff843cf193359229a453-dirty
>> 

would look like the attached.

I think a reasonable next step would be

 - Move the check for your condition (c) that we dropped from this round
   to wt-status.c;

 - Add wt_status_print_dangling_submodules() to wt-status.c, and use the
   above logic to produce a section "Submodules with Dangling HEAD" or
   something.

 - Call it in wt_status_print(), immediately before we check s->verbose
   and show the patch text under -v option.  "git status" now will warn
   about the condition (c).

 - Add a similar wt_shortstatus_print_dangling_submodules() and call it at
   the end of wt_shortstatus_print().

 - Update is_submodule_modified() in your patch thats reads the output
   from "status --porcelain", to *ignore* information about dangling
   submodules.  As we discussed, dangling submodules may be something the
   user cares about, but that is not something "diff" should.

-- >8 --
Subject: Teach diff that modified submodule directory is dirty

A diff run in superproject only compares the name of the commit object
bound at the submodule paths.  When we compare with a work tree and the
checked out submodule directory is dirty (e.g. has either staged or
unstaged changes, or has new files the user forgot to add to the index),
show the work tree side as "dirty".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c                    |    9 ++++++-
 t/t4027-diff-submodule.sh |   49 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 04beb26..750c066 100644
--- a/diff.c
+++ b/diff.c
@@ -2029,9 +2029,14 @@ static int populate_from_stdin(struct diff_filespec *s)
 static int diff_populate_gitlink(struct diff_filespec *s, int size_only)
 {
 	int len;
-	char *data = xmalloc(100);
+	char *data = xmalloc(100), *dirty = "";
+
+	/* Are we looking at the work tree? */
+	if (!s->sha1_valid && is_submodule_modified(s->path))
+		dirty = "-dirty";
+
 	len = snprintf(data, 100,
-		"Subproject commit %s\n", sha1_to_hex(s->sha1));
+		       "Subproject commit %s%s\n", sha1_to_hex(s->sha1), dirty);
 	s->data = data;
 	s->size = len;
 	s->should_free = 1;
diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index 5cf8924..bf8c980 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -32,7 +32,8 @@ test_expect_success setup '
 		cd sub &&
 		git rev-list HEAD
 	) &&
-	echo ":160000 160000 $3 $_z40 M	sub" >expect
+	echo ":160000 160000 $3 $_z40 M	sub" >expect &&
+	subtip=$3 subprev=$2
 '
 
 test_expect_success 'git diff --raw HEAD' '
@@ -50,6 +51,52 @@ test_expect_success 'git diff-files --raw' '
 	test_cmp expect actual.files
 '
 
+expect_from_to () {
+	printf "%sSubproject commit %s\n+Subproject commit %s\n" \
+		"-" "$1" "$2"
+}
+
+test_expect_success 'git diff HEAD' '
+	git diff HEAD >actual &&
+	sed -e "1,/^@@/d" actual >actual.body &&
+	expect_from_to >expect.body $subtip $subprev &&
+	test_cmp expect.body actual.body
+'
+
+test_expect_success 'git diff HEAD with dirty submodule (work tree)' '
+	echo >>sub/world &&
+	git diff HEAD >actual &&
+	sed -e "1,/^@@/d" actual >actual.body &&
+	expect_from_to >expect.body $subtip $subprev-dirty &&
+	test_cmp expect.body actual.body
+'
+
+test_expect_success 'git diff HEAD with dirty submodule (index)' '
+	(
+		cd sub &&
+		git reset --hard &&
+		echo >>world &&
+		git add world
+	) &&
+	git diff HEAD >actual &&
+	sed -e "1,/^@@/d" actual >actual.body &&
+	expect_from_to >expect.body $subtip $subprev-dirty &&
+	test_cmp expect.body actual.body
+'
+
+test_expect_success 'git diff HEAD with dirty submodule (untracked)' '
+	(
+		cd sub &&
+		git reset --hard &&
+		git clean -qfdx &&
+		>cruft
+	) &&
+	git diff HEAD >actual &&
+	sed -e "1,/^@@/d" actual >actual.body &&
+	expect_from_to >expect.body $subtip $subprev-dirty &&
+	test_cmp expect.body actual.body
+'
+
 test_expect_success 'git diff (empty submodule dir)' '
 	: >empty &&
 	rm -rf sub/* sub/.git &&
