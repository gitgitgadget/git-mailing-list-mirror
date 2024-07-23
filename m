Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2FE14A4C9
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 17:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721754559; cv=none; b=cVk7WKU6Lr2rr6wlPAc0eRuRDuy26ip67zbWjE/0kxS8aJ6Vu9dnNoRgnB0v27mDNpz8L+stX3i9W3vFrcQhLyjjqzP6FkZwHz8DGPRgSjXdPc7Jz3gKxZF0OnM8Cnk0UQSJffQBZGXaCGJ+1pryaXvwJr4m9kL0WUkoF1Yd2R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721754559; c=relaxed/simple;
	bh=FJlupa+kk8O1UiRjpOjuavFSis/vXrI/+sfHJ7B2z48=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MWCwbJ5q2OCiVDzj+43hrUo8nbEL0/qRXyWUxMoI6Rc/UhjpcKyuDtHCMKf51QOgtYFQe2bvy3ZesfRs13igS4vv0gFBJ7S7yca5wbELXKYfgbsYuuewOQJV445Kz3DfqczfrEy6O86o4YAc6Zkx6hQIuqfEJ8kv+o6lMNJwP+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y5h0sbkC; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y5h0sbkC"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0F3CB2D64D;
	Tue, 23 Jul 2024 13:09:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=FJlupa+kk8O1UiRjpOjuavFSis/vXrI/+sfHJ7
	B2z48=; b=Y5h0sbkC6DUTQCvUqQu6AIOmywDRus3oAQeX6Qg8NInx+aU/MqmOzz
	B+AnGp3YIrndY0y9BwPunSAgyyHEmX8jazrisnFDLJilFrRQ8SIe2LvChnrWBHcz
	/HzsuyNW1nqwdm0zks0H7vOFMgfEJtz/yAcAY0Roqa+1C2lvmZR7k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 062CB2D64C;
	Tue, 23 Jul 2024 13:09:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6B1EE2D64B;
	Tue, 23 Jul 2024 13:09:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [GSoC][PATCH v5 0/7] t: port reftable/pq_test.c to the unit
 testing framework
In-Reply-To: <20240723143032.4261-1-chandrapratap3519@gmail.com> (Chandra
	Pratap's message of "Tue, 23 Jul 2024 19:47:10 +0530")
References: <20240614095136.12052-1-chandrapratap3519@gmail.com>
	<20240723143032.4261-1-chandrapratap3519@gmail.com>
Date: Tue, 23 Jul 2024 10:09:14 -0700
Message-ID: <xmqq5xsw2fyd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4A303CE4-4916-11EF-B907-34EEED2EC81B-77302942!pb-smtp1.pobox.com

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> The reftable library comes with self tests, which are exercised
> as part of the usual end-to-end tests and are designed to
> observe the end-user visible effects of Git commands. What it
> exercises, however, is a better match for the unit-testing
> framework, merged at 8bf6fbd0 (Merge branch 'js/doc-unit-tests',
> 2023-12-09), which is designed to observe how low level
> implementation details, at the level of sequences of individual
> function calls, behave.
>
> Hence, port reftable/pq_test.c to the unit testing framework and
> improve upon the ported test. The first two patches in the series
> are preparatory cleanup, the third patch moves the test to the unit
> testing framework, and the rest of the patches improve upon the
> ported test.
>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
>
> ---
> Changes in v5:
> - Rebase the branch on top of the  latest master branch

If you need to perform this rebase, please say _why_ you are
rebasing.

"A new rc was tagged so I rebased" is *not* a good reason.

"I wanted to use that new feature that was merged to 'master'
recently, which was not available when I wrote the previous
iteration of this series, hence I rebased" is a very good reason.

"Since I wrote the previous iteration, other unit test topics have
graduated, so there are trivial conflicts in Makefile when merging
this topic" is usually not a good reason, especially when the same
conflicts with these other unit test topics are already resolved
when your previous iteration is merged to 'seen'.

If there isn't a reason worth mentioning why you are rebasing, then
please do not rebase.  It is distracting.

> - Rename tests according to unit-tests' conventions
> - remove 'pq_test_main()' from reftable/reftable-test.h
>
> CI/PR for v5: https://github.com/gitgitgadget/git/pull/1745

By the way, I still haven't got any answer to a question I asked
long ago on this series, wrt possibly unifying this pq and another
pq we already use elsewhere in our codebase.  If we are butchering
what we borrowed from elsewhere and store in reftable/. directory
and taking responsibility of maintaining it ourselves, we probably
should consider larger refactoring and cleaning up, and part of it
we may end up discarding this pq implementation, making the unit
testing on it a wasted effort.

Thanks.

> Chandra Pratap(7):
> reftable: remove unncessary curly braces in reftable/pq.c
> reftable: change the type of array indices to 'size_t' in reftable/pq.c
> t: move reftable/pq_test.c to the unit testing framework
> t-reftable-pq: make merged_iter_pqueue_check() static
> t-reftable-pq: make merged_iter_pqueue_check() callable by reference
> t-reftable-pq: add test for index based comparison
> t-reftable-pq: add tests for merged_iter_pqueue_top()
>
> Makefile                     |   2 +-
> reftable/pq.c                |  29 +++-----
> reftable/pq.h                |   1 -
> reftable/pq_test.c           |  74 ---------------------
> reftable/reftable-tests.h    |   1 -
> t/helper/test-reftable.c     |   1 -
> t/unit-tests/t-reftable-pq.c | 155 +++++++++++++++++++++++++++++++++++++++++++
> 7 files changed, 166 insertions(+), 97 deletions(-)
>
> Range-diff against v4:
> <rebase commits>
>   1:  d3c5605ea2 = 382:  acd9d26aaf reftable: remove unncessary curly braces in reftable/pq.c
>   2:  3c333e7770 = 383:  2e0986207b reftable: change the type of array indices to 'size_t' in reftable/pq.c
>   3:  bf547f705a ! 384:  df06b6d604 t: move reftable/pq_test.c to the unit testing framework
>     @@ Commit message
>          t: move reftable/pq_test.c to the unit testing framework
>
>          reftable/pq_test.c exercises a priority queue defined by
>     -    reftable/pq.{c, h}. Migrate reftable/pq_test.c to the unit
>     -    testing framework. Migration involves refactoring the tests
>     -    to use the unit testing framework instead of reftable's test
>     -    framework.
>     +    reftable/pq.{c, h}. Migrate reftable/pq_test.c to the unit testing
>     +    framework. Migration involves refactoring the tests to use the unit
>     +    testing framework instead of reftable's test framework, and
>     +    renaming the tests to align with unit-tests' standards.
>
>          Mentored-by: Patrick Steinhardt <ps@pks.im>
>          Mentored-by: Christian Couder <chriscool@tuxfamily.org>
>          Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
>
>       ## Makefile ##
>     -@@ Makefile: THIRD_PARTY_SOURCES += sha1dc/%
>     - UNIT_TEST_PROGRAMS += t-ctype
>     - UNIT_TEST_PROGRAMS += t-mem-pool
>     +@@ Makefile: UNIT_TEST_PROGRAMS += t-oidmap
>     + UNIT_TEST_PROGRAMS += t-oidtree
>       UNIT_TEST_PROGRAMS += t-prio-queue
>     + UNIT_TEST_PROGRAMS += t-reftable-basics
>      +UNIT_TEST_PROGRAMS += t-reftable-pq
>     + UNIT_TEST_PROGRAMS += t-reftable-record
>       UNIT_TEST_PROGRAMS += t-strbuf
>       UNIT_TEST_PROGRAMS += t-strcmp-offset
>     - UNIT_TEST_PROGRAMS += t-trailer
>     -@@ Makefile: REFTABLE_TEST_OBJS += reftable/basics_test.o
>     +@@ Makefile: REFTABLE_OBJS += reftable/writer.o
>       REFTABLE_TEST_OBJS += reftable/block_test.o
>       REFTABLE_TEST_OBJS += reftable/dump.o
>       REFTABLE_TEST_OBJS += reftable/merged_test.o
>      -REFTABLE_TEST_OBJS += reftable/pq_test.o
>     - REFTABLE_TEST_OBJS += reftable/record_test.o
>       REFTABLE_TEST_OBJS += reftable/readwrite_test.o
>       REFTABLE_TEST_OBJS += reftable/stack_test.o
>     + REFTABLE_TEST_OBJS += reftable/test_framework.o
>     +
>     + ## reftable/reftable-tests.h ##
>     +@@ reftable/reftable-tests.h: license that can be found in the LICENSE file or at
>     + int basics_test_main(int argc, const char **argv);
>     + int block_test_main(int argc, const char **argv);
>     + int merged_test_main(int argc, const char **argv);
>     +-int pq_test_main(int argc, const char **argv);
>     + int record_test_main(int argc, const char **argv);
>     + int readwrite_test_main(int argc, const char **argv);
>     + int stack_test_main(int argc, const char **argv);
>
>       ## t/helper/test-reftable.c ##
>      @@ t/helper/test-reftable.c: int cmd__reftable(int argc, const char **argv)
>     - 	record_test_main(argc, argv);
>     + 	/* test from simple to complex. */
>       	block_test_main(argc, argv);
>       	tree_test_main(argc, argv);
>      -	pq_test_main(argc, argv);
>     @@ t/unit-tests/t-reftable-pq.c: license that can be found in the LICENSE file or a
>       	}
>       }
>
>     - static void test_pq(void)
>     +-static void test_pq(void)
>     ++static void t_pq(void)
>       {
>      -	struct merged_iter_pqueue pq = { NULL };
>      +	struct merged_iter_pqueue pq = { 0 };
>     @@ t/unit-tests/t-reftable-pq.c: static void test_pq(void)
>       {
>      -	RUN_TEST(test_pq);
>      -	return 0;
>     -+	TEST(test_pq(), "pq works");
>     ++	TEST(t_pq(), "pq works");
>      +
>      +	return test_done();
>       }
>   4:  7dd3a2b27f = 385:  40745ab18e t-reftable-pq: make merged_iter_pqueue_check() static
>   5:  c803e7adfc ! 386:  ee8432ac4a t-reftable-pq: make merged_iter_pqueue_check() callable by reference
>     @@ t/unit-tests/t-reftable-pq.c: license that can be found in the LICENSE file or a
>       	}
>       }
>
>     -@@ t/unit-tests/t-reftable-pq.c: static void test_pq(void)
>     +@@ t/unit-tests/t-reftable-pq.c: static void t_pq(void)
>       		};
>
>       		merged_iter_pqueue_add(&pq, &e);
>   6:  0b03f3567d ! 387:  94a77f5a60 t-reftable-pq: add test for index based comparison
>     @@ t/unit-tests/t-reftable-pq.c: static void merged_iter_pqueue_check(const struct
>       	}
>       }
>
>     --static void test_pq(void)
>     -+static void test_pq_record(void)
>     +-static void t_pq(void)
>     ++static void t_pq_record(void)
>       {
>       	struct merged_iter_pqueue pq = { 0 };
>       	struct reftable_record recs[54];
>     -@@ t/unit-tests/t-reftable-pq.c: static void test_pq(void)
>     +@@ t/unit-tests/t-reftable-pq.c: static void t_pq(void)
>       	merged_iter_pqueue_release(&pq);
>       }
>
>     -+static void test_pq_index(void)
>     ++static void t_pq_index(void)
>      +{
>      +	struct merged_iter_pqueue pq = { 0 };
>      +	struct reftable_record recs[14];
>     @@ t/unit-tests/t-reftable-pq.c: static void test_pq(void)
>      +
>       int cmd_main(int argc, const char *argv[])
>       {
>     --	TEST(test_pq(), "pq works");
>     -+	TEST(test_pq_record(), "pq works with record-based comparison");
>     -+	TEST(test_pq_index(), "pq works with index-based comparison");
>     +-	TEST(t_pq(), "pq works");
>     ++	TEST(t_pq_record(), "pq works with record-based comparison");
>     ++	TEST(t_pq_index(), "pq works with index-based comparison");
>
>       	return test_done();
>       }
>   7:  0cdfa6221e ! 388:  9a76f87bd1 t-reftable-pq: add tests for merged_iter_pqueue_top()
>     @@ t/unit-tests/t-reftable-pq.c: static void merged_iter_pqueue_check(const struct
>      +	return !reftable_record_cmp(a->rec, b->rec) && (a->index == b->index);
>      +}
>      +
>     - static void test_pq_record(void)
>     + static void t_pq_record(void)
>       {
>       	struct merged_iter_pqueue pq = { 0 };
>     -@@ t/unit-tests/t-reftable-pq.c: static void test_pq_record(void)
>     +@@ t/unit-tests/t-reftable-pq.c: static void t_pq_record(void)
>       	} while (i != 1);
>
>       	while (!merged_iter_pqueue_is_empty(pq)) {
>     @@ t/unit-tests/t-reftable-pq.c: static void test_pq_record(void)
>       		check(reftable_record_type(e.rec) == BLOCK_TYPE_REF);
>       		if (last)
>       			check_int(strcmp(last, e.rec->u.ref.refname), <, 0);
>     -@@ t/unit-tests/t-reftable-pq.c: static void test_pq_index(void)
>     +@@ t/unit-tests/t-reftable-pq.c: static void t_pq_index(void)
>       	}
>
>       	for (i = N - 1; !merged_iter_pqueue_is_empty(pq); i--) {
>     @@ t/unit-tests/t-reftable-pq.c: static void test_pq_index(void)
>       		check(reftable_record_type(e.rec) == BLOCK_TYPE_REF);
>       		check_int(e.index, ==, i);
>       		if (last)
>     -@@ t/unit-tests/t-reftable-pq.c: static void test_pq_index(void)
>     +@@ t/unit-tests/t-reftable-pq.c: static void t_pq_index(void)
>       	merged_iter_pqueue_release(&pq);
>       }
>
>     -+static void test_merged_iter_pqueue_top(void)
>     ++static void t_merged_iter_pqueue_top(void)
>      +{
>      +	struct merged_iter_pqueue pq = { 0 };
>      +	struct reftable_record recs[14];
>     @@ t/unit-tests/t-reftable-pq.c: static void test_pq_index(void)
>      +
>       int cmd_main(int argc, const char *argv[])
>       {
>     - 	TEST(test_pq_record(), "pq works with record-based comparison");
>     - 	TEST(test_pq_index(), "pq works with index-based comparison");
>     -+	TEST(test_merged_iter_pqueue_top(), "merged_iter_pqueue_top works");
>     + 	TEST(t_pq_record(), "pq works with record-based comparison");
>     + 	TEST(t_pq_index(), "pq works with index-based comparison");
>     ++	TEST(t_merged_iter_pqueue_top(), "merged_iter_pqueue_top works");
>
>       	return test_done();
>       }
