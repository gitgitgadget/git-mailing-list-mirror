Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDEF81F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 06:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731684AbeKMP7Z (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 10:59:25 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52164 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731044AbeKMP7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 10:59:24 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1FD0320380;
        Tue, 13 Nov 2018 01:02:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+a/uqsPYcyRo
        LKVPf+FOW5TVT7Q=; b=O417+vp5X/qWVVStMTlF72JCSk/y+gIB6S2x9MbiSUc9
        1BUbdNg1lF9fNxZ0IafkFh8OCIZaNTLv7VP6vJ4DY/ggldvccEs0To2eB+6OPJDT
        mq8OYVlir2ui8Wyr157W1R+RxI72yU5JqhhB4Ms1WXwwX9mWXZFHlLk2Bv7zCOg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=sy44a/
        85K4ezRngdOQ0vSGNJtxGfj8PL4No5UGVxyBr2vEyfkmHn7kA0qiVnMqnpDyWQd2
        RHpwbhXMq5C95RqFAud65bvbIz98XkEzoijyqSheHdoFhjfVfW+KzSpxB+ToFCIG
        H0Dt0Sr37hVMoKdHQj5kFlAl9Xrh1epA/FlAA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1886D2037F;
        Tue, 13 Nov 2018 01:02:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0F3FE2037E;
        Tue, 13 Nov 2018 01:02:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rafael =?utf-8?Q?Ascens=C3=A3o?= <rafa.almas@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/2] refs: show --exclude failure with --branches/tags/remotes=glob
References: <20181112132545.31092-1-rafa.almas@gmail.com>
        <20181112132545.31092-2-rafa.almas@gmail.com>
Date:   Tue, 13 Nov 2018 15:02:46 +0900
In-Reply-To: <20181112132545.31092-2-rafa.almas@gmail.com> ("Rafael
        =?utf-8?Q?Ascens=C3=A3o=22's?= message of "Mon, 12 Nov 2018 13:25:43
 +0000")
Message-ID: <xmqqd0r9wm49.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BFA43A54-E709-11E8-9BE6-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rafael Ascens=C3=A3o <rafa.almas@gmail.com> writes:

> The documentation of `--exclude=3D` option from rev-list and rev-parse
> explicitly states that exclude patterns *should not* start with 'refs/'
> when used with `--branches`, `--tags` or `--remotes`.
>
> However, following this advice results in refereces not being excluded
> if the next `--branches`, `--tags`, `--remotes` use the optional
> inclusive glob.
>
> Demonstrate this failure.
>
> Signed-off-by: Rafael Ascens=C3=A3o <rafa.almas@gmail.com>
> ---
>  t/t6018-rev-list-glob.sh | 60 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 57 insertions(+), 3 deletions(-)

For a trivially small change/fix like this (i.e. the real fix in 2/2
is just 4 lines), it is OK and even preferrable to make 1+2 a single
step, as applying t/ part only to try to see the breakage (or
"am"ing everything and then "diff | apply -R" the part outside t/
for the same purpose) is easy enough.

Often the patch 2 with your method ends up showing only the test
set-up part in the context by changing _failure to _success, without
showing what end-user visible breakage the step fixed, which usually
comes near the end of the added test piece.  For this particular
test, s/_failure/_success/ shows everything in the verification
phase, but the entire set-up for these tests cannot be seen while
reviewing 2/2.  Unlike that, a single patch that gives tests that
ought to succeed would not force the readers to switch between
patches 1 and 2 while reading the fix.

Of course, the above would not apply for a more involved case where
the actual fix to the code needs to span multiple patches.

> diff --git a/t/t6018-rev-list-glob.sh b/t/t6018-rev-list-glob.sh
> index 0bf10d0686..8e2b136356 100755
> --- a/t/t6018-rev-list-glob.sh
> +++ b/t/t6018-rev-list-glob.sh
> @@ -36,7 +36,13 @@ test_expect_success 'setup' '
>  	git tag foo/bar master &&
>  	commit master3 &&
>  	git update-ref refs/remotes/foo/baz master &&
> -	commit master4
> +	commit master4 &&
> +	git update-ref refs/remotes/upstream/one subspace/one &&
> +	git update-ref refs/remotes/upstream/two subspace/two &&
> +	git update-ref refs/remotes/upstream/x subspace-x &&
> +	git tag qux/one subspace/one &&
> +	git tag qux/two subspace/two &&
> +	git tag qux/x subspace-x
>  '

Let me follow along.

We add three remote-tracking looking branches for 'upstream', and
three tags under refs/tags/qux/.


> +test_expect_failure 'rev-parse --exclude=3Dglob with --branches=3Dglob=
' '
> +	compare rev-parse "--exclude=3Dsubspace-* --branches=3Dsub*" "subspac=
e/one subspace/two"
> +'

We want to list all branches that begin with "sub", but we do not
want ones that begin with "subspace-".  subspace/{one,two} should
pass that criteria, while subspace-x, other/three, someref, and
master should not.  Makes sense.

> +
> +test_expect_failure 'rev-parse --exclude=3Dglob with --tags=3Dglob' '
> +	compare rev-parse "--exclude=3Dqux/? --tags=3Dqux/*" "qux/one qux/two=
"
> +'

We want all tags that begin with "qux/" but we do not want qux/
followed by just a single letter.  qux/{one,two} are in, qux/x is
out.  Makes sense.

> +test_expect_failure 'rev-parse --exclude=3Dglob with --remotes=3Dglob'=
 '
> +	compare rev-parse "--exclude=3Dupstream/? --remotes=3Dupstream/*" "up=
stream/one upstream/two"
> +'

Similarly for refs/remotes/upstream/ hierarchy.

> +test_expect_failure 'rev-parse --exclude=3Dref with --branches=3Dglob'=
 '
> +	compare rev-parse "--exclude=3Dsubspace-x --branches=3Dsub*" "subspac=
e/one subspace/two
> +'

This is almost a repeat of the first new one.  As subspace-* in
branches only match subspace-x, this should give the same result as
that one.

> +test_expect_failure 'rev-parse --exclude=3Dref with --tags=3Dglob' '
> +	compare rev-parse "--exclude=3Dqux/x --tags=3Dqux/*" "qux/one qux/two=
"
> +'

Likewise.

> +test_expect_failure 'rev-parse --exclude=3Dref with --remotes=3Dglob' =
'
> +	compare rev-parse "--exclude=3Dupstream/x --remotes=3Dupstream/*" "up=
stream/one upstream/two"
> +'

Likewise.

> +test_expect_failure 'rev-list --exclude=3Dglob with --branches=3Dglob'=
 '
> +	compare rev-list "--exclude=3Dsubspace-* --branches=3Dsub*" "subspace=
/one subspace/two"
> +'

And then the same pattern continues with rev-list.

> +test_expect_failure 'rev-list --exclude=3Dglob with --tags=3Dglob' '
> +	compare rev-list "--exclude=3Dqux/? --tags=3Dqux/*" "qux/one qux/two"
> +'
> +
> +test_expect_failure 'rev-list --exclude=3Dglob with --remotes=3Dglob' =
'
> +	compare rev-list "--exclude=3Dupstream/? --remotes=3Dupstream/*" "ups=
tream/one upstream/two"
> +'
> +
> +test_expect_failure 'rev-list --exclude=3Dref with --branches=3Dglob' =
'
> +	compare rev-list "--exclude=3Dsubspace-x --branches=3Dsub*" "subspace=
/one subspace/two"
> +'
> +
> +test_expect_failure 'rev-list --exclude=3Dref with --tags=3Dglob' '
> +	compare rev-list "--exclude=3Dqux/x --tags=3Dqux/*" "qux/one qux/two"
> +'
> +
> +test_expect_failure 'rev-list --exclude=3Dref with --remotes=3Dglob' '
> +	compare rev-list "--exclude=3Dupstream/x --remotes=3Dupstream/*" "ups=
tream/one upstream/two"
> +'
> +

With the ordering of these tests, it is fairly clear that you are
exhaustively testing all the combinations=20
=09
for command in rev-parse rev-list:
	for exclude in glob ref:
		for specifc in glob ref:
			for kind in branches tags remotes:
				compare $command exclude=3D$exclude --$kind=3D$specific

which is very good.  No, I am not suggesting to write a shell loop
to drive these tests; I am saying that the list of tests are in the
same order as such a nested loop would invoke compare, which makes
it predictable for the readers who pay attention, and it is a good
thing.


>  test_expect_success 'rev-list --glob=3Drefs/heads/subspace/*' '
> =20
>  	compare rev-list "subspace/one subspace/two" "--glob=3Drefs/heads/sub=
space/*"
> @@ -233,7 +287,7 @@ test_expect_success 'rev-list --tags=3Dfoo' '
> =20
>  test_expect_success 'rev-list --tags' '
> =20
> -	compare rev-list "foo/bar" "--tags"
> +	compare rev-list "foo/bar qux/x qux/two qux/one" "--tags"

Of course, you'd need to compensate for new stuff here ...

> =20
>  '
> =20
> @@ -292,7 +346,7 @@ test_expect_success 'shortlog accepts --glob/--tags=
/--remotes' '
>  	  "master other/three someref subspace-x subspace/one subspace/two" \
>  	  "--glob=3Dheads/*" &&
>  	compare shortlog foo/bar --tags=3Dfoo &&
> -	compare shortlog foo/bar --tags &&
> +	compare shortlog "foo/bar qux/one qux/two qux/x" --tags &&

... and here.

>  	compare shortlog foo/baz --remotes=3Dfoo

All makes sense.  Will queue.

