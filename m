Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 367652018E
	for <e@80x24.org>; Mon,  8 Aug 2016 17:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752425AbcHHRH1 (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 13:07:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56184 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752320AbcHHRH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 13:07:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E1DFC31DFC;
	Mon,  8 Aug 2016 13:07:24 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Odq9oBX2G2qKLXhPJ+NH9aNfDtw=; b=Yc0Mw4
	LECo+Ay2ddJUWNAADfd7O/OjvKpY9oteILOs0wazZ6/QLl09Ssitw1cPcWDFkYMx
	l8p3EoJf94I8JvAek3D1Ccj0NDhecm+NkF4e7dgRRvHGIVl8J2jWF+nMgQYdCozM
	SiByxIDoGXx71ABi2YD9ptUEo2JdoIVFlPo4U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SPMVv7BJyyFv4V6hXGh2BmPqaNvrQdxS
	k5dI5JgjS2Fx/uu4VbHt2XwzHvZDYvInK3QDgMM0htLqIqn37CmUGguQyRD8N2hJ
	qCEiqrv8ge2/FsASocKfPsTeE8UPf/1j69BPVtbwSAqfpwEVEIb+JuTZ/wSfWrVA
	trFXrV4ukXE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DA0EB31DFB;
	Mon,  8 Aug 2016 13:07:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 32C6731DFA;
	Mon,  8 Aug 2016 13:07:24 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff Hostetler <git@jeffhostetler.com>
Cc:	git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 9/9] status: unit tests for --porcelain=v2
References: <1470434434-64283-1-git-send-email-git@jeffhostetler.com>
	<1470434434-64283-10-git-send-email-git@jeffhostetler.com>
Date:	Mon, 08 Aug 2016 10:07:22 -0700
In-Reply-To: <1470434434-64283-10-git-send-email-git@jeffhostetler.com> (Jeff
	Hostetler's message of "Fri, 5 Aug 2016 18:00:34 -0400")
Message-ID: <xmqq4m6vgpf9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 93750F4A-5D8A-11E6-BA4A-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> +test_expect_success pre_initial_commit_0 '
> +	...
> +	git status --porcelain=v2 --branch --untracked-files=normal >actual &&
> +	test_cmp expect actual
> +'
> +
> +
> +test_expect_success pre_initial_commit_1 '
> +	git add file_x file_y file_z dir1 &&
> +	...
> +	cat >expect <<-EOF &&
> +	# branch.oid (initial)
> +	# branch.head master
> +	1 A. N... 000000 100644 100644 $_z40 $OID_A dir1/file_a
> +	...

This makes one wonder what would/should be shown on the "A." column
if one of these files are added with "-N" (intent-to-add).  I do not
see any test for such entries in this patch, but I think it should.

> +	git status --porcelain=v2 --branch --untracked-files=all >actual &&
> +	test_cmp expect actual
> +'

> +## Try -z on the above
> +test_expect_success pre_initial_commit_2 '
> +	lf_to_nul >expect <<-EOF &&
> +	...
> +	git status -z --porcelain=v2 --branch --untracked-files=all >actual &&
> +	test_cmp expect actual
> +'

"Try -z on the above" can and should be in the test title to help
those who are watching the test run.  Instead of trying to clarify
code with comments, clarify them by letting the code speak for
themselves.  I would have named the above three perhaps like this:

	test_expect_success 'before first commit, nothing added'
        test_expect_success 'before first commit, some files added'
        test_expect_success 'before first commit, some files added (-z)'

"pre-initial-commit-$number" is not very interesting; it does not
convey a more interesting aspect of these tests, like (a) _0 is
distinct (nothing added) among the three, (b) _1 and _2 are about
the same state, just expressed differently, and (c) _1 is LF
terminated, _2 is NUL terminated.  The same comment applies to the
remainder of the test.  For example:

> +##################################################################
> +## Create second commit.
> +##################################################################
> +
> +test_expect_success second_commit_0 '

This "_0" does not tell us anything, but you are testing "When fully
committed, we only see untracked files (if we ask) and branch info
(if we ask).

Having said all that, it is OK to fix their titles after the current
9-patch series lands on 'next'; incremental refinements are easier
on reviewers than having to review too many rerolls.

This is probably a good place to see what happens to these untracked
files and branch info if we do not ask the command to show them.
Otherwise, it tests exactly the same as "initial_commit_0" and is
not all that interesting, no?

> +##################################################################
> +## Ignore a file
> +##################################################################
> +
> +test_expect_success ignore_file_0 '
> +	echo x.ign >.gitignore &&
> +	echo "ignore me" >x.ign &&
> +	H1=$(git rev-parse HEAD) &&
> +
> +	## ignored file SHOULD NOT appear in output when --ignored is not used.
> + ...
> +	git status --porcelain=v2 --branch --untracked-files=all >actual &&
> +	test_cmp expect actual &&
> + ...
> +	git status --porcelain=v2 --branch --ignored --untracked-files=all >actual &&
> +	rm x.ign &&
> +	rm .gitignore &&

Arrange these files to be cleaned before you create them by having

	test_when_finished "rm -f x.ign .gitignore" &&

at the very beginning of this test before they are created.
Otherwise, if any step before these removal fail, later test that
assume they are gone will be affected.  You already do so correctly
in the upstream_fields_0 test below.

> +##################################################################
> +## Create some conflicts.
> +##################################################################
> +
> +test_expect_success conflict_AA '
> +	git branch AA_A master &&
> +	git checkout AA_A &&
> +	echo "Branch AA_A" >conflict.txt &&
> +	OID_AA_A=$(git hash-object -t blob -- conflict.txt) &&
> +	git add conflict.txt &&
> +	git commit -m "branch aa_a" &&
> +
> +	git branch AA_B master &&
> +	git checkout AA_B &&
> +	echo "Branch AA_B" >conflict.txt &&
> +	OID_AA_B=$(git hash-object -t blob -- conflict.txt) &&
> +	git add conflict.txt &&
> +	git commit -m "branch aa_b" &&
> +
> +	git branch AA_M AA_B &&
> +	git checkout AA_M &&
> +	test_must_fail git merge AA_A &&
> +
> +	HM=$(git rev-parse HEAD) &&
> +
> +	cat >expect <<-EOF &&
> +	# branch.oid $HM
> +	# branch.head AA_M
> +	u AA N... 000000 100644 100644 100644 $_z40 $OID_AA_B $OID_AA_A conflict.txt
> +	EOF

This is a small point, but doesn't the lowercase 'u' somehow look
ugly, especially because the status letters that immediately follow
it are all uppercase?

> +	git status --porcelain=v2 --branch --untracked-files=all >actual &&
> +	git reset --hard &&

This "reset" also may be a candidate for test_when_finished clean-up
(I won't repeat the comment but there probably are many others).

> +test_expect_success 'upstream_fields_0' '
> +	git checkout master &&
> +	test_when_finished rm -rf sub_repo &&

The "when-finished" argument are usually quoted like this, I think:

	test_when_finished "rm -rf sub_repo" &&

