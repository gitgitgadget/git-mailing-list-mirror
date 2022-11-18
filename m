Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1590C433FE
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 00:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240703AbiKRAzr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 19:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbiKRAzp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 19:55:45 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B438E15A03
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 16:55:44 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id t25so9333186ejb.8
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 16:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5xLrLPDchErdqWFNUwK84wUDrcBpNQQsInSWGbXvb+U=;
        b=pWC2txcknm8XisKoi5wp28KAnDut4HNw4lWqooRjuuUiWnJLfvIPVVPK3lud8xZ5pv
         FU7YO+FaQeeGvpshoipoRrUis6D4WLyTvicHEwe1i+RJO+WNvV0itFhQd5KhhzK3GdcB
         bDVwd5F+9b9ocZ2BV1AMCzlaD1EKyoXwZmR+RlI8W7YIN9Jplx/bVk6WkMZhUoSIt6IS
         Av4D1laPySBCDrdHWEsWcApoSTS/AuT1Y1LfI/QH12N2j1t+tbf0ewyIJq77B/DjI3rU
         FwFNQmC5ZPAuY/TOHxpQQ3gZ4tFiOtXQB7ZI6WjjVz8Z9beD6fCZCuYLyy3WeP7SQXTz
         LSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xLrLPDchErdqWFNUwK84wUDrcBpNQQsInSWGbXvb+U=;
        b=QcPTxLlupGQK2PO17uq8ji3ykAmGMovpxvVqKder5adyO/xHel/Cim7q8RdxCF/oCi
         Hadx0lmHOMRssV6jnOWLr1j6oDSZpXBSeu0zX26iTiPyNRTVlFk5wlqhGQaU7nNi8EJE
         ZrIhnWPbVQ8al4azRbIZw40nXn6+9bmObA980o1opTIvfyftCBBe4kkA42scT1XdaTNp
         mqQNvpmsb9Z/ZGx0mncnPACcQcnS84oWLu6NkYLwHCuePaOtygqtBujNjY97X7/2wMgB
         xC5E5CYxwbZ25Zvm1c7GInRZZ+qXLO+bIx0Er86/nH5qWqFRDq3ey5zpaySSSL8grUf/
         pnyg==
X-Gm-Message-State: ANoB5plvKDFCdpG1V+0Rw4gX4c0YzjACuB28oPGKDLP/B5rPcVYwmSJ5
        Wfkv38FP3MC65lmRxLDVeKw=
X-Google-Smtp-Source: AA0mqf5vnRyIYhek2sARJ9sM16ld05KF/eYqG9J1mfVlaHxs+o+3Yi9dKLfqKXjwKhvMO3TDLAVkdg==
X-Received: by 2002:a17:906:547:b0:7ad:9028:4b17 with SMTP id k7-20020a170906054700b007ad90284b17mr4127908eja.366.1668732943053;
        Thu, 17 Nov 2022 16:55:43 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906329100b007aa3822f4d2sm1037018ejw.17.2022.11.17.16.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 16:55:42 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ovpfR-00589y-30;
        Fri, 18 Nov 2022 01:55:41 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Kousik Sanagavarapu <five231003@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] parse_object(): check on-disk type of suspected blob
Date:   Fri, 18 Nov 2022 01:36:23 +0100
References: <Y3a3qcqNG8W3ueeb@coredump.intra.peff.net>
 <Y3a4jKzsHSooYFqj@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y3a4jKzsHSooYFqj@coredump.intra.peff.net>
Message-ID: <221118.86cz9lgjxu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 17 2022, Jeff King wrote:

> I reworked the conditional a bit so that instead of:
>
>   if ((suspected_blob && oid_object_info() == OBJ_BLOB)
>       (no_clue && oid_object_info() == OBJ_BLOB)
>
> we have the simpler:
>
>   if ((suspected_blob || no_clue) && oid_object_info() == OBJ_BLOB)
> [...]
> @@ -286,8 +286,8 @@ struct object *parse_object_with_flags(struct repository *r,
>  			return &commit->object;
>  	}
>  
> -	if ((obj && obj->type == OBJ_BLOB && repo_has_object_file(r, oid)) ||
> -	    (!obj && oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
> +	if ((!obj || (obj && obj->type == OBJ_BLOB)) &&
> +	    oid_object_info(r, oid, NULL) == OBJ_BLOB) {
>  		if (!skip_hash && stream_object_signature(r, repl) < 0) {
>  			error(_("hash mismatch %s"), oid_to_hex(oid));
>  			return NULL;

But why:

	if ((!x || (x && x->m)) && ...)

Instead of:

	if ((!x || x->m)) && ...)

If "!obj" is false then "obj" must be non-NULL, so you don't need to
check it again and can lose the "obj &&".

> [...]
> So this fixes one of the lingering expect_failure cases from 0616617c7e
> (t: introduce tests for unexpected object types, 2019-04-09).  That test
> works by peeling a tag that claims to point to a blob (triggering us to
> create the struct), but really points to something else, which we later
> discover when we call parse_object() as part of the actual traversal).
> Prior to this commit, we'd quietly check the sha1 and mark the blob as
> "parsed". Now we correctly complain about the mismatch.

I applied this on top of "master", and adjusted your test to be this
instead:

	test_expect_success 'traverse unexpected non-blob tag (lone)' '
		cat >expect <<-EOF &&
		error: object $commit is a blob, not a commit
		fatal: bad object $commit
		EOF
		test_must_fail git rev-list --objects $tag >out 2>actual &&
		test_must_be_empty out &&
		test_cmp expect actual
	'

Which passes, showing that we're still not correctly identifying it, but
we are doing it for the purposes of erroring out, but the incorrect type
persists.

Now, this all does seem quite familiar... :) :
https://lore.kernel.org/git/patch-10.11-a84f670ac24-20210328T021238Z-avarab@gmail.com/

I.e. that's the rest of the fix for this issue. I applied this change on
my local branch with that, and they combine nicely. the "test_must_fail"
here works as intended, *and* we'll correctly report & store the type.

> As an aside, I found the "this test is marked as success but testing the
> wrong thing" pattern here confusing to deal with (since I had to dig in
> history to understand what was going on and what the test was _supposed_
> to say).
>
> It comes from cf10c5b4cf (rev-list tests: don't hide abort() in
> "test_expect_failure", 2022-03-07). I'm skeptical that it was worth
> switching those tests for leak detection purposes.

It's not just for leak detection purposes that it was a good idea to
switch it away from test_expect_failure, but also that we've been
ensuring that this didn't turn into a segfault all this time by not
using "test_expect_failure".

> But more importantly, it looks like pw/test-todo would provide us with a
> much nicer pattern there. It seems to be stalled on review, so let's see
> if we can get that moving again.

The "TODO (should fail!)" didn't stand out? But yeah, having a "todo" or
"test_expect_todo" or "test_expect_failure" not suck would be nice.

FWIW I think
https://lore.kernel.org/git/221006.86v8owr986.gmgdl@evledraar.gmail.com/
outlines a good way forward for it that I think should make everyone
happy.

> diff --git a/t/t6102-rev-list-unexpected-objects.sh b/t/t6102-rev-list-unexpected-objects.sh
> index 4a9a4436e2..9350b5fd2c 100755
> --- a/t/t6102-rev-list-unexpected-objects.sh
> +++ b/t/t6102-rev-list-unexpected-objects.sh
> @@ -121,8 +121,8 @@ test_expect_success 'setup unexpected non-blob tag' '
>  	tag=$(git hash-object -w --literally -t tag broken-tag)
>  '
>  
> -test_expect_success 'TODO (should fail!): traverse unexpected non-blob tag (lone)' '
> -	git rev-list --objects $tag
> +test_expect_success 'traverse unexpected non-blob tag (lone)' '
> +	test_must_fail git rev-list --objects $tag
>  '

I think you'll either want the test_cmp I noted above, or to do that in
a subsequent test_expect_failure.

I know that your stance is that you prefer not to "test the bad
behavior" as it were. Personally I thought an all-caps TODO comment
might make it less confusing, but anyway.

In this case your commit message claims you're happy with the end
result, so I think you'd want to test what we actually emit on stderr,
as it's quite ... unintuative.

Or, which I think probably makes more sense, add that as a subsequent
test_expect_failure or whatever. FWIW this somewhat un-idiomatic pattern
will get around the current caveats with it:

	test_expect_success .... '
		... >actual.non-blob-tag
	'
	test_lazy_prereq HAVE_NON_BLOB_TAG 'test -e actual.non-blob-tag'
	test_expect_failure HAVE_NON_BLOB_TAG '...' '
		cat >expect.non-blob-tag <<-\EOF &&
		...
		EOF
		test_cmp expect.non-blob-tag actual.non-blob-tag
	'

I.e. peel off the 'test_cmp" that should have a known-good state from
the already-good status code.
