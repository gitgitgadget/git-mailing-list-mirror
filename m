From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Add tests for git-sh-setup's require_clean_work_tree()
Date: Wed, 20 Jan 2016 15:59:46 -0800
Message-ID: <xmqqbn8f3iq5.fsf@gitster.mtv.corp.google.com>
References: <1448376345-27339-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Jan 21 00:59:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aM2fK-0003Bd-8a
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 00:59:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753062AbcATX7v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jan 2016 18:59:51 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56261 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752466AbcATX7t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jan 2016 18:59:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9AF6C3ED55;
	Wed, 20 Jan 2016 18:59:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=BsioEP2tqqLb
	lkN7K4V+t/22iTQ=; b=a2tJfB5JhEiJTJx7nlQoyXUdBe8wwe+clmr9ovBlVFcz
	eKlREAR0ijSB70gvmYcoKawTALuPDHdh7S1SFA4GuvEwsqWMs3MELipZ0zyWVGiB
	9CpTKnopAcfPkMOjgKW8JIGJM9vVGZOFGWwRaiSDYIWLLVWCsjtN8I3jzH/5wAo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dUz/iq
	M/uhD5DgZti1LvN42sv6oc2Uy1aWC87sp5+OaxxwgrlNw7xcU016B7Bgi0Ee2y4N
	LxV1TMAwwufrezLqmfQbvd0/LKrLRwhLj/2GURsWjRGf8jwn0sVDgP7+S+Mdaeav
	1To2Ftc0Wa+k4DNpdxYl2iavpi03yxUtNxJds=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 925323ED54;
	Wed, 20 Jan 2016 18:59:48 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F02193ED53;
	Wed, 20 Jan 2016 18:59:47 -0500 (EST)
In-Reply-To: <1448376345-27339-1-git-send-email-szeder@ira.uka.de> ("SZEDER
	=?utf-8?Q?G=C3=A1bor=22's?= message of "Tue, 24 Nov 2015 15:45:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E2DE4742-BFD1-11E5-BCF5-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284487>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> Add tests that check require_clean_work_tree() in the common cases,
> i.e. on a branch with all combinations of clean and dirty index and
> worktree, and also add tests that exercise it on an orphan branch.
>
> require_clean_work_tree()'s behavior in the orphan branch cases is
> questionable, as it exits with error on an orphan branch independentl=
y
> from whether the index and worktree are clean or dirty (and it does s=
o
> because of the invalid HEAD, meaning that even when it should exit
> with error, it does so for the wrong reason).  As scripts might rely
> on the current behavior, we err on the side of compatibility and
> safety, and expect the current behavior as success.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
> ---

I see this was queued while I was not around, but has been in "Needs
review" bucket in "What's cooking" report forever, without getting
reviews.

> +test_description=3D'require_clean_work_tree'
> +
> +. ./test-lib.sh
> +
> +run_require_clean_work_tree () {
> +	(
> +		. "$(git --exec-path)"/git-sh-setup &&
> +		require_clean_work_tree "do-something"

"do-something"?  What are the typical thing to write here in real
scripts?  A name of the operation that wanted to ensure that the
working tree is clean, with an optional hint string?

Perhaps you want to take them as arguments to this helper function?
That way you do not have to decide what to pass here, i.e.

-		require_clean_work_tree "do-something"
+		require_clean_work_tree "$@"

> +	)
> +}
> +
> +test_expect_success 'setup' '
> +	test_commit initial file
> +'
> +
> +test_expect_success 'success on clean index and worktree' '
> +	run_require_clean_work_tree

=2E.. and if you want to, you can give the comment here, e.g.

	run_require_clean_work_tree "verify clean after init"

or something.

> +'
> +
> +test_expect_success 'error on dirty worktree' '
> +	test_when_finished "git reset --hard" &&
> +	echo dirty >file &&
> +	test_must_fail run_require_clean_work_tree

I think this should be

	! run_require_clean_work_tree

> +'
> +
> +test_expect_success 'error on dirty index' '
> +	test_when_finished "git reset --hard" &&
> +	echo dirty >file &&
> +	git add file &&
> +	test_must_fail run_require_clean_work_tree
> +'

Likewise.

> +test_expect_success 'error on dirty index and worktree' '
> +	test_when_finished "git reset --hard" &&
> +	echo dirty >file &&
> +	git add file &&
> +	echo dirtier >file &&
> +	test_must_fail run_require_clean_work_tree
> +'
> +
> +test_expect_success 'error on clean index and worktree while on orph=
an branch' '
> +	test_when_finished "git checkout master" &&
> +	git checkout --orphan orphan &&
> +	git reset --hard &&
> +	test_must_fail run_require_clean_work_tree
> +'

The title is wrong.  Immediately after creating and getting on an
orphan branch, you have stuff in the index that is not committed to
the branch, so your index cannot be clean by definition.  The
contents of the working tree may or may not be clean immediately
after getting on a new orphan branch, but you are doing "reset
--hard" to make the index and the working tree agree, so this is
testing the "clean working tree" case, I think.

> +test_expect_success 'error on dirty index while on orphan branch' '
> +	test_when_finished "git checkout master" &&
> +	git checkout --orphan orphan &&
> +	test_must_fail run_require_clean_work_tree
> +'

Assuming that the previous test succeeded and this test started with
a clean index and the working tree, checkout --orphan would give you
a dirty-index with clean working tree state.  So both the title and
the expectation of the test are correct, I think.

But it would be better not to rely on the effect of
test-when-finished of the previous test too much.  "git checkout
master && git reset --hard" at the beginning would be easier to read
the test and reason about it in isolation.

> +test_expect_success 'error on dirty index and work tree while on orp=
han branch' '
> +	test_when_finished "git checkout master" &&
> +	git checkout --orphan orphan &&
> +	echo dirty >file &&
> +	test_must_fail run_require_clean_work_tree
> +'

Likewise.

Thanks.
