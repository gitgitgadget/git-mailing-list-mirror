From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] Add default merge options for all branches
Date: Fri, 06 May 2011 13:36:35 -0700
Message-ID: <7v7ha3zhv0.fsf@alter.siamese.dyndns.org>
References: <20110503090351.GA27862@elie> <4DC1CE16.5030808@dailyvoid.com>
 <7vsjsuc704.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Michael Grubb <devel@dailyvoid.com>
X-From: git-owner@vger.kernel.org Fri May 06 22:36:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIRlb-00080B-GW
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 22:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932589Ab1EFUgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 16:36:46 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65513 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756624Ab1EFUgp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 16:36:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2707157A3;
	Fri,  6 May 2011 16:38:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=9YVHcS4KRTo73c+ihbZnTY2jyFQ=; b=nAK1+Pd6YYDRevAe7HqH
	mJEy9+smUJgyvU7u4RW18d15V+Nq2MTHxqTnhleFu2WhXlOnwHDadG0nQQKqi77T
	cvXbxqFB8fi2soSviAYpSjH41SZ/rQ4K1BGNkkvoAkZmnbwjXQu2DcZehN1JVEaI
	bRLCSht+vHzCqGiefTctsIs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=SlVqFNCkiBDl3lREL5oiOyl7Ot/ZLDP10uWdk+/OgtXzW/
	1wdMEKHKYJ+EdHtqzr26bErlvXi0SJAY7lXL/39WhDrz2v8tV3hqYCUOUpuJaKT3
	yUj8Q/mWBgCSYRGxBio/WbkHkAv9i+6gYTEuQuME5OkAYkbDGNxH0A5Bj2uoE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E3C4957A2;
	Fri,  6 May 2011 16:38:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5679357A1; Fri,  6 May 2011
 16:38:40 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D62AEBB6-7820-11E0-B78F-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173007>

Junio C Hamano <gitster@pobox.com> writes:

> In any case, your test exposed an ancient breakage ever since the
> per-branch mergeoptions was introduced back when git-merge was a shell
> script (aec7b36 (git-merge: add support for branch.<name>.mergeoptions,
> 2007-09-24).
>
> -- >8 --
> Subject: [PATCH] merge: fix branch.<name>.mergeoptions
> ...

And then on top of that fix, we can do this.

I have a seemingly unrelated change to the existing test but that was
because it only made sure that the --ff-only option made the command fail
when it should fail, without making sure that it does not interfere when
it should succeed.  A typical symptom of "showing off shiny new toy
because I am too excited" developer disease, I would guess.  I didn't want
to forget to fix it.

-- >8 --
Subject: [PATCH] merge: introduce merge.ff configuration variable

This variable gives the default setting for --ff, --no-ff or --ff-only
options of "git merge" command.

Helped-by: Michael Grubb <devel@dailyvoid.com>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * If we were doing the command line option of "merge" from scratch today,
   we probably would have done --ff, --ff=no, and --ff=only, instead of a
   separate --ff-only.  We could still add the latter two as a consistency
   synonyms without deprecating anything, though.

 Documentation/merge-config.txt |   10 +++++++++
 builtin/merge.c                |    9 ++++++++
 t/t7600-merge.sh               |   43 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index 8920258..861bd6f 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -16,6 +16,16 @@ merge.defaultToUpstream::
 	to their corresponding remote tracking branches, and the tips of
 	these tracking branches are merged.
 
+merge.ff::
+	By default, git does not create an extra merge commit when merging
+	a commit that is a descendant of the current commit. Instead, the
+	tip of the current branch is fast-forwarded. When set to `false`,
+	this variable tells git to create an extra merge commit in such
+	a case (equivalent to giving the `--no-ff` option from the command
+	line). When set to `only`, only such fast-forward merges are
+	allowed (equivalent to giving the `--ff-only` option from the
+	command line).
+
 merge.log::
 	In addition to branch names, populate the log message with at
 	most the specified number of one-line descriptions from the
diff --git a/builtin/merge.c b/builtin/merge.c
index 4fa789a..1c3ff13 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -550,6 +550,15 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 		if (is_bool && shortlog_len)
 			shortlog_len = DEFAULT_MERGE_LOG_LEN;
 		return 0;
+	} else if (!strcmp(k, "merge.ff")) {
+		int boolval = git_config_maybe_bool(k, v);
+		if (0 <= boolval) {
+			allow_fast_forward = boolval;
+		} else if (v && !strcmp(v, "only")) {
+			allow_fast_forward = 1;
+			fast_forward_only = 1;
+		} /* do not barf on values from future versions of git */
+		return 0;
 	} else if (!strcmp(k, "merge.defaulttoupstream")) {
 		default_to_upstream = git_config_bool(k, v);
 		return 0;
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 5463f87..4f1d4eb 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -225,12 +225,28 @@ test_expect_success 'merge c1 with c2 and c3' '
 
 test_debug 'git log --graph --decorate --oneline --all'
 
-test_expect_success 'failing merges with --ff-only' '
+test_expect_success 'merges with --ff-only' '
 	git reset --hard c1 &&
 	test_tick &&
 	test_must_fail git merge --ff-only c2 &&
 	test_must_fail git merge --ff-only c3 &&
-	test_must_fail git merge --ff-only c2 c3
+	test_must_fail git merge --ff-only c2 c3 &&
+	git reset --hard c0 &&
+	git merge c3 &&
+	verify_head $c3
+'
+
+test_expect_success 'merges with merge.ff=only' '
+	git reset --hard c1 &&
+	test_tick &&
+	test_when_finished "git config --unset merge.ff" &&
+	git config merge.ff only &&
+	test_must_fail git merge c2 &&
+	test_must_fail git merge c3 &&
+	test_must_fail git merge c2 c3 &&
+	git reset --hard c0 &&
+	git merge c3 &&
+	verify_head $c3
 '
 
 test_expect_success 'merge c0 with c1 (no-commit)' '
@@ -447,6 +463,29 @@ test_expect_success 'merge c0 with c1 (no-ff)' '
 
 test_debug 'git log --graph --decorate --oneline --all'
 
+test_expect_success 'merge c0 with c1 (merge.ff=false)' '
+	git reset --hard c0 &&
+	git config merge.ff false &&
+	test_tick &&
+	git merge c1 &&
+	git config --remove-section merge &&
+	verify_merge file result.1 &&
+	verify_parents $c0 $c1
+'
+test_debug 'git log --graph --decorate --oneline --all'
+
+test_expect_success 'combine branch.master.mergeoptions with merge.ff' '
+	git reset --hard c0 &&
+	git config branch.master.mergeoptions --ff
+	git config merge.ff false
+	test_tick &&
+	git merge c1 &&
+	git config --remove-section "branch.master" &&
+	git config --remove-section "merge" &&
+	verify_merge file result.1 &&
+	verify_parents "$c0"
+'
+
 test_expect_success 'combining --squash and --no-ff is refused' '
 	test_must_fail git merge --squash --no-ff c1 &&
 	test_must_fail git merge --no-ff --squash c1
-- 
1.7.5.1.268.gce5bd
