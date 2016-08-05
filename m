Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3975F2018E
	for <e@80x24.org>; Fri,  5 Aug 2016 18:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935860AbcHESMo (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 14:12:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63616 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S935194AbcHESMd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 14:12:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9659133ADF;
	Fri,  5 Aug 2016 14:12:31 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PH4lrbR048IKyDitawyzPS+4Bvs=; b=Q+DfH9
	Jr5Lx119L3/8Q5Z2rw/dqJPwedM8xkw/X7ArnORH/gyXqDw3WgSdrEiUlflUdZaD
	nT1PWqdqd8frxzt6t1Pk5NdPwSnlvHbqZovfXG7lxnaPqjUEo6VMdtDXLwoyScWz
	OtlHfBE/FrBNQUgKmabSC1PwQS6xpjQBMZH9k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tLFWJufxwyGjZNCjkl8qh/1FH3VYXlD6
	Aqy/c7Abrdy9zgpiwf1lOhpdfmRUKyVkI6tpuhTKtJWFlSHdezpQUKpZqJxvX0gQ
	Lri+KLhj/6HkyvzhhijlpLdW6uVTvhm+M0QRA8F+3psU5Ru+fXUBfOGfIIurFnoA
	nA8inycOCTI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D0E733ADD;
	Fri,  5 Aug 2016 14:12:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D746333ADB;
	Fri,  5 Aug 2016 14:12:30 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff Hostetler <git@jeffhostetler.com>
Cc:	git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 8/8] status: tests for --porcelain=v2
References: <1470147137-17498-1-git-send-email-git@jeffhostetler.com>
	<1470147137-17498-9-git-send-email-git@jeffhostetler.com>
Date:	Fri, 05 Aug 2016 11:12:28 -0700
In-Reply-To: <1470147137-17498-9-git-send-email-git@jeffhostetler.com> (Jeff
	Hostetler's message of "Tue, 2 Aug 2016 10:12:17 -0400")
Message-ID: <xmqq1t23xeyb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2CC70810-5B38-11E6-AFCF-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> +##################################################################
> +## Confirm output prior to initial commit.
> +##################################################################
> +
> +test_expect_success pre_initial_commit_0 '

Bikeshedding, but our codebase seems to prefer "expect" vs "actual".

    $ git grep -e 'test_cmp expect ' t/ | wc -l
    1882
    $ git grep -e 'test_cmp expected ' t/ | wc -l
    888

> +	cat >expected <<-EOF &&
> +	# branch.oid (initial)
> +	# branch.head master
> +	? actual
> +	? dir1/
> +	? expected
> +	? file_x
> +	? file_y
> +	? file_z
> +	EOF

Perhaps throw these two entries to .gitignore to allow new tests in
the future could also use expect.1 vs actual.1 and somesuch?

	cat >.gitignore <<-\EOF &&
	expect*
        actual*
        EOF

> +test_expect_success pre_initial_commit_1 '
> +	git add file_x file_y file_z dir1 &&
> +	SHA_A=`git hash-object -t blob -- dir1/file_a` &&
> +	SHA_B=`git hash-object -t blob -- dir1/file_b` &&
> +	SHA_X=`git hash-object -t blob -- file_x` &&
> +	SHA_Y=`git hash-object -t blob -- file_y` &&
> +	SHA_Z=`git hash-object -t blob -- file_z` &&

Please use $(commannd) instead of `command`.  Also "SHA" is probably
a bad prefix; either use "SHA_1" to be technically correct, or
better yet use "OID", as we are moving towards abstracting the exact
hash function name away.

> +	SHA_ZERO=0000000000000000000000000000000000000000 &&

I think we made $_z40 available to you from t/test-lib.sh.

> +## Try -z on the above
> +test_expect_success pre_initial_commit_2 '
> +	cat >expected.lf <<-EOF &&
> +	# branch.oid (initial)
> +	# branch.head master
> +	1 A. N... 000000 100644 100644 $SHA_ZERO $SHA_A dir1/file_a
> +	1 A. N... 000000 100644 100644 $SHA_ZERO $SHA_B dir1/file_b
> +	1 A. N... 000000 100644 100644 $SHA_ZERO $SHA_X file_x
> +	1 A. N... 000000 100644 100644 $SHA_ZERO $SHA_Y file_y
> +	1 A. N... 000000 100644 100644 $SHA_ZERO $SHA_Z file_z
> +	? actual
> +	? expected
> +	EOF
> +	perl -pe y/\\012/\\000/ <expected.lf >expected &&
> +	rm expected.lf &&

As you immediately remove expected.lf, the first "cat" process is
rather pointless.  You can redirect here text <<-EOF directly into
perl instead.  Also it would probably help to add a new helper
"lf_to_nul" in t/test-lib-functions.sh around the place where
nul_to_q, ..., tz_to_tab_space helpers are defined, which would
allow us to say

	lf_to_nul >expect <<-EOF &&
	...
        EOF

> +test_expect_success initial_commit_3 '
> +	git mv file_y renamed_y &&
> +	H0=`git rev-parse HEAD` &&
> +
> +	cat >expected.q <<-EOF &&
> +	# branch.oid $H0
> +	# branch.head master
> +	1 M. N... 100644 100644 100644 $SHA_X $SHA_X1 file_x
> +	1 D. N... 100644 000000 000000 $SHA_Z $SHA_ZERO file_z
> +	2 R. N... 100644 100644 100644 $SHA_Y $SHA_Y R100 renamed_yQfile_y
> +	? actual
> +	? expected
> +	EOF
> +	q_to_tab <expected.q >expected &&
> +	rm expected.q &&

The same comment applies (redirect directly into q_to_tab).

> +##################################################################
> +## Ignore a file
> +##################################################################
> +
> +test_expect_success ignore_file_0 '
> +	echo x.ign >.gitignore &&
> +	echo "ignore me" >x.ign &&
> +	H1=`git rev-parse HEAD` &&
> +
> +	cat >expected <<-EOF &&
> +	# branch.oid $H1
> +	# branch.head master
> +	? .gitignore
> +	? actual
> +	? expected
> +	! x.ign
> +	EOF
> +
> +	git status --porcelain=v2 --branch --ignored --untracked-files=all >actual &&
> +	rm x.ign &&
> +	rm .gitignore &&
> +	test_cmp expected actual
> +'

You do not seem to be checking a feature is not triggered when not
asked throughout this test, e.g. making sure the output does not
have the "# branch.*" lines when --branch is not given, "! x.ign"
is not shown when --ignored is not given, etc.

> +##################################################################
> +## Test upstream fields in branch header
> +##################################################################
> +
> +test_expect_success 'upstream_fields_0' '
> +	git checkout master &&
> +	git clone . sub_repo &&
> +	(
> +		## Confirm local master tracks remote master.
> +		cd sub_repo &&
> +		HUF=`git rev-parse HEAD` &&
> + ...
> +		git status --porcelain=v2 --branch --ignored --untracked-files=all >actual &&
> +		test_cmp expected actual
> +	) &&
> +	rm -rf sub_repo

It probably is a good idea to use test_when_finished immediately
before "git clone . sub_repo" to arrange this to happen even when
any test in the subshell fails.
