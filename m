Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23C661F462
	for <e@80x24.org>; Sat, 27 Jul 2019 16:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387691AbfG0QLz (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jul 2019 12:11:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64992 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbfG0QLy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jul 2019 12:11:54 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 689B9158B5E;
        Sat, 27 Jul 2019 12:11:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=qrJH4CgmoBCO
        sxODr+F7/tZpUnA=; b=OLv3NhhTEJ2X4a7MIiifTxsnqj3laDcwBYA6TBPuZHfA
        akhXgoQ2wUAqDePkzyGUSWzJwGl8q2VVP+bD57gg10I3FWiMU5V9FZGhKCZJKrnt
        kMiBJAKAOHYG5dW7NW5v/jbOrAoTa5dh0Y6soIQFZmrtgq2JLu4zTDu8rh/q9ks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=rClCyv
        Tw2nrpc1haJDOzC0/IJvIvdYpM/vdFLlJmXCKS9asHKLcggmGv0OixuOQl71WZj+
        tg6kp8FnqhKTkUsslbbjePXLJ1NVTi7T8qlhFdLPRQzGcgLvYrOiLUeApdilIePW
        caNIHzVmy0E1kN0QpffBpPnMknyAbSDrQCH8s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5EF3B158B5D;
        Sat, 27 Jul 2019 12:11:48 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C0C76158B5C;
        Sat, 27 Jul 2019 12:11:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Carlo Arenas <carenas@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] transport-helper: enforce atomic in push_refs_with_push
References: <20190702005340.66615-1-emilyshaffer@google.com>
        <20190709211043.48597-1-emilyshaffer@google.com>
        <CAPUEspgjSAqHUP2vsCCjqG8b0QkWdgoAByh4XdqsThQMt=V38w@mail.gmail.com>
        <xmqq8ssx53a0.fsf@gitster-ct.c.googlers.com>
        <20190718152234.GI20404@szeder.dev>
        <20190727084348.GO20404@szeder.dev>
Date:   Sat, 27 Jul 2019 09:11:46 -0700
In-Reply-To: <20190727084348.GO20404@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Sat, 27 Jul 2019 10:43:48 +0200")
Message-ID: <xmqq4l37mp8d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3C2C4910-B089-11E9-95DB-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> Junio,
>
> On Thu, Jul 18, 2019 at 05:22:34PM +0200, SZEDER G=C3=A1bor wrote:
>> Subject: [PATCH] travis-ci: build with GCC 4.8 as well
>
> This patch conflicts with topic 'js/trace2-json-schema', and the
> current conflict resolution in 'pu' is not quite correct.

Thanks.

"git diff ...MERGE_HEAD" during a merge of js/trace2-json-schema
gives me this patch:

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index cdd2913440..ec38bf379a 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -14,6 +14,8 @@ make
 make test
 if test "$jobname" =3D "linux-gcc"
 then
+	make -C t/trace_schema_validator
+	export GIT_TRACE2_EVENT=3D$(mktemp)
 	export GIT_TEST_SPLIT_INDEX=3Dyes
 	export GIT_TEST_FULL_IN_PACK_ARRAY=3Dtrue
 	export GIT_TEST_OE_SIZE=3D10
@@ -21,6 +23,10 @@ then
 	export GIT_TEST_COMMIT_GRAPH=3D1
 	export GIT_TEST_MULTI_PACK_INDEX=3D1
 	make test
+	t/trace_schema_validator/trace_schema_validator \
+		--trace2_event_file=3D${GIT_TRACE2_EVENT} \
+		--schema_file=3Dt/trace_schema_validator/strict_schema.json \
+		--progress=3D10000
 fi
=20
 check_unignored_build_artifacts

i.e. they want to run an extra make in that validator directory,
export another environment variable, and then run the validator
*after* running the normal "make test", in linux-gcc job.

>> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
>> index cdd2913440..ff0ef7f08e 100755
>> --- a/ci/run-build-and-tests.sh
>> +++ b/ci/run-build-and-tests.sh
>> @@ -11,9 +11,9 @@ windows*) cmd //c mklink //j t\\.prove "$(cygpath -a=
w "$cache_dir/.prove")";;
>>  esac
>> =20
>>  make
>> -make test
>> -if test "$jobname" =3D "linux-gcc"
>> -then
>> +case "$jobname" in
>> +linux-gcc)
>> +	make test
>
> This 'make test' here is important, but the confict resolution
> accidentally removed it.

Right.  Thanks for spotting.

I can see in "git diff pu~2 pu~1" that indeed the first 'make test'
that we want to run without any of these environment variables is
lost in the merge.  We want to run two tests, with or without these
environment variables, and the validator wants to piggyback on the
second one.

Will fix in the meantime, but I was expecting that this "validator
in CI" business to be redone differently, perhaps with a different
validator implementation and either in a separate job or just part
of an existing job but trace enabled only for some subset of the
tests and/or only for new tests specifically written for trace
coverage, so after that happens this may turn into a moot point.

The change the merge brings in to the file now reads like this.

Thanks, again.

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index ff0ef7f08e..35ff4d3038 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -14,6 +14,9 @@ make
 case "$jobname" in
 linux-gcc)
 	make test
+
+	make -C t/trace_schema_validator
+	export GIT_TRACE2_EVENT=3D$(mktemp)
 	export GIT_TEST_SPLIT_INDEX=3Dyes
 	export GIT_TEST_FULL_IN_PACK_ARRAY=3Dtrue
 	export GIT_TEST_OE_SIZE=3D10
@@ -21,6 +24,11 @@ linux-gcc)
 	export GIT_TEST_COMMIT_GRAPH=3D1
 	export GIT_TEST_MULTI_PACK_INDEX=3D1
 	make test
+
+	t/trace_schema_validator/trace_schema_validator \
+		--trace2_event_file=3D${GIT_TRACE2_EVENT} \
+		--schema_file=3Dt/trace_schema_validator/strict_schema.json \
+		--progress=3D10000
 	;;
 linux-gcc-4.8)
 	# Don't run the tests; we only care about whether Git can be
