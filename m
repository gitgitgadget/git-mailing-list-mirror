From: Junio C Hamano <gitster@pobox.com>
Subject: Re: make test Unexpected passes
Date: Wed, 27 Apr 2016 15:05:57 -0700
Message-ID: <xmqqoa8u7lmi.fsf@gitster.mtv.corp.google.com>
References: <571A8404.5030200@ramsayjones.plus.com>
	<CABPp-BFdzu4stEfbGAiqDwRAXt7EcvYBEVz1kChJaR4udC5SXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, ben.woosley@gmail.com,
	GIT Mailing-list <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 00:06:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avXaz-0005ui-Oj
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 00:06:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752615AbcD0WGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 18:06:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51474 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752447AbcD0WGD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 18:06:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 95FD216DB3;
	Wed, 27 Apr 2016 18:06:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Clch5dM4S49ltB+LvZrtEn8ZBWk=; b=roVoUp
	IOh1DXYolM53hehj2b8XxRa0UkHCkKY4U8zVXt0EM7mhP2riVkhJRvq86tQfisvf
	jwUykks0stBUvnAMI0XQAldZaRZSyaLfmIKz7zbmQO9NVNqLw04tiiXBGkL3rWxi
	LFoi9yF3JEo8sOUZnPsuUbRh88fxjnQcKPuS0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WigAI2dL7aU7CxgAhQFwlf4OIm34NLRy
	FQX1aMKMCOVQB9mmDLGyCbogYkpO90xKRoe3MQsBLK/H2hMo45k2sAGcxEe6PqGZ
	Cssvtq1bPitRD5kWl4xj0PREJnireYsR0bxOg1YBnXToqmmmidgVsHJ37aRyyVqX
	6hIxHoJqzrM=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4874A16DB2;
	Wed, 27 Apr 2016 18:06:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 02A0A16DB1;
	Wed, 27 Apr 2016 18:05:59 -0400 (EDT)
In-Reply-To: <CABPp-BFdzu4stEfbGAiqDwRAXt7EcvYBEVz1kChJaR4udC5SXA@mail.gmail.com>
	(Elijah Newren's message of "Fri, 22 Apr 2016 15:19:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 399094E8-0CC4-11E6-846F-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292833>

Elijah Newren <newren@gmail.com> writes:

> Yeah, the t6036 testcase 'git detects conflict w/
> criss-cross+contrived resolution' could be made to pass by tweaking
> the conflict markers.  In fact, any tweak would make it appear to
> pass, but the test could be updated to still fail by updating the
> contrived resolution of a previous merge to use the newer conflict
> marker style as well.

Isn't what the test expects bogus in the first place?  I'd suggest
removing the test as "pointless waste of resource".

Comments?

-- >8 --
Subject: [PATCH] t6036: remove pointless test that expects failure

One test in t6036 prepares a file whose contents contain these
lines:

	<<<<<<< Temporary merge branch 1
	C
	=======
	B
	>>>>>>> Temporary merge branch 2

and uses recursive merge strategy to run criss-cross merge with it.

Manual merge resolution by users fundamentally depends on being able
to tell what is the tracked contents and what is the separator lines
added by "git merge" to tell users which block of lines came from
where.  You can deliberately craft a file with lines that resemble
conflict marker lines to make it impossible for the user (here, the
outer merge of merge-recursive also counts as a user of the internal
merge) to tell which part is which, and write a test to demonstrate
that with such a file that "git merge" fundamentally cannot work
with and has to fail on.  It however is pointless and waste of time
and resource to run such a test that asserts the obvious.

In real life, people who do need to track files with such lines that
have <<<< ==== >>>> as their prefixes set the conflict-marker-size
attribute to make sure they will be able to tell between the tracked
lines that happen to begin with these (confusing) prefixes and the
marker lines that are added by "git merge".

Remove the test as pointless waste of resource.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t6036-recursive-corner-cases.sh | 83 ---------------------------------------
 1 file changed, 83 deletions(-)

diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index cc1ee6a..c7b0ae6 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -304,89 +304,6 @@ test_expect_success 'git detects conflict merging criss-cross+modify/delete, rev
 	test $(git rev-parse :3:file) = $(git rev-parse B:file)
 '
 
-#
-# criss-cross + modify/modify with very contrived file contents:
-#
-#      B   D
-#      o---o
-#     / \ / \
-#  A o   X   ? F
-#     \ / \ /
-#      o---o
-#      C   E
-#
-#   Commit A: file with contents 'A\n'
-#   Commit B: file with contents 'B\n'
-#   Commit C: file with contents 'C\n'
-#   Commit D: file with contents 'D\n'
-#   Commit E: file with contents:
-#      <<<<<<< Temporary merge branch 1
-#      C
-#      =======
-#      B
-#      >>>>>>> Temporary merge branch 2
-#
-# Now, when we merge commits D & E, does git detect the conflict?
-
-test_expect_success 'setup differently handled merges of content conflict' '
-	git clean -fdqx &&
-	rm -rf .git &&
-	git init &&
-
-	echo A >file &&
-	git add file &&
-	test_tick &&
-	git commit -m A &&
-
-	git branch B &&
-	git checkout -b C &&
-	echo C >file &&
-	git add file &&
-	test_tick &&
-	git commit -m C &&
-
-	git checkout B &&
-	echo B >file &&
-	git add file &&
-	test_tick &&
-	git commit -m B &&
-
-	git checkout B^0 &&
-	test_must_fail git merge C &&
-	echo D >file &&
-	git add file &&
-	test_tick &&
-	git commit -m D &&
-	git tag D &&
-
-	git checkout C^0 &&
-	test_must_fail git merge B &&
-	cat <<EOF >file &&
-<<<<<<< Temporary merge branch 1
-C
-=======
-B
->>>>>>> Temporary merge branch 2
-EOF
-	git add file &&
-	test_tick &&
-	git commit -m E &&
-	git tag E
-'
-
-test_expect_failure 'git detects conflict w/ criss-cross+contrived resolution' '
-	git checkout D^0 &&
-
-	test_must_fail git merge -s recursive E^0 &&
-
-	test 3 -eq $(git ls-files -s | wc -l) &&
-	test 3 -eq $(git ls-files -u | wc -l) &&
-	test 0 -eq $(git ls-files -o | wc -l) &&
-
-	test $(git rev-parse :2:file) = $(git rev-parse D:file) &&
-	test $(git rev-parse :3:file) = $(git rev-parse E:file)
-'
-
 #
 # criss-cross + d/f conflict via add/add:
 #   Commit A: Neither file 'a' nor directory 'a/' exists.
