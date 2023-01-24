Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B8FC54E94
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 17:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbjAXRQF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 12:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbjAXRQC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 12:16:02 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937FC298E2
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 09:16:01 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id b10so15691319pjo.1
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 09:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=omzwjVD04r1xh6++tHMwD0t/v6OXACsqZjEgqD5Si4k=;
        b=qALYBLoA6ebsNb30GqjataGaKE38X8EsjrY8TOWaOViPDD8Ue9NTAqYXCCTPmUn6wy
         4g717YkwEHh3tLMwxSbyfkhg+P/26TfFedUryRSY6q4/2TQIu1qqttOKczaRV03iXd0f
         UyPi1wpu/on2gujFefzo+GLscL/UvXRTZc0K0iGQGgZ6P3flaFQddDqBGRhfnD3yjpov
         7XTFQEwnN759/c/hBQmdLeM+4bRGcTZbOznmWewY/gkWxgi26DJH0LUYz+wqs7T9SA+x
         vDgLZemeSGVbGJkQyZ/tCtFSL7yAR5RebpxtFzxkqmUeGtswsWcLkeAVIryWVoc/QwBi
         KmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=omzwjVD04r1xh6++tHMwD0t/v6OXACsqZjEgqD5Si4k=;
        b=ZwmMcFJ1FIIzaKi+Mfab1KE88tsO4hPgEGdtZwVF2J/ey7q67tc8pGrMxkdTj6Qp4U
         ud5YWsaeE0iitwv7ETI+Uob651BOQED9kVwUquCd1uIejnywWdFOv73kcqJlHwbLmurP
         OlGdVr28lwBbUbLRSUpsSzsvCfyLGKRofQ975XwNG1buZAu6hQLv0OvYGAfjXBFg+xiu
         S2bZoplBQXDjOr0mSSLcIVjxKL1GqtZxIBT4Lz4ALmVYgNLN77UvHA+4xACKXwsKDshW
         r8lWLUmZ0GJQz64B7Pv/GJAiW5j/JT96jchN4yxrDcn+QxiMjmmdK/jUjCd/TCbd6LLV
         5Zlw==
X-Gm-Message-State: AFqh2krt/RhxuE3ZSTZHXTcOEZwnz4sgL+JaakW2KB+nthe1uINRq7QC
        BRvAprsTen+LY6r9uKQFzo35TPmrFbs=
X-Google-Smtp-Source: AMrXdXuKVpOkjbXj34X2MKbq4ghCJFW/OV7aPH/Si1t4iI6Qhb1Yrq14xh/e1p0FWNwbV0Ve5oKD1w==
X-Received: by 2002:a17:902:dad2:b0:194:6f0e:987 with SMTP id q18-20020a170902dad200b001946f0e0987mr41263565plx.61.1674580560836;
        Tue, 24 Jan 2023 09:16:00 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id b14-20020a170902650e00b00183c67844aesm1922706plk.22.2023.01.24.09.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 09:16:00 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        avarab@gmail.com, steadmon@google.com, chooglen@google.com
Subject: Re: [PATCH v2.5 01/11] bundle: test unbundling with incomplete history
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
        <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
        <b3828725bc8f8887b9b4777a0e3d84224a427f31.1674487310.git.gitgitgadget@gmail.com>
        <xmqqsfg1m8l6.fsf@gitster.g>
        <eae85534-89c9-6eff-69d5-7d4b2be85fb6@github.com>
        <xmqqilgxm2ky.fsf@gitster.g> <xmqqtu0glw81.fsf@gitster.g>
        <771a2993-85bd-0831-0977-24204f84e206@github.com>
        <01f97aff-58a1-ef2c-e668-d37ea513c64e@github.com>
Date:   Tue, 24 Jan 2023 09:16:00 -0800
In-Reply-To: <01f97aff-58a1-ef2c-e668-d37ea513c64e@github.com> (Derrick
        Stolee's message of "Tue, 24 Jan 2023 09:14:36 -0500")
Message-ID: <xmqqv8kvhmzz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> In order to construct a broken history, perform a shallow clone of a
> repository with a linear history, but whose default branch ('base') has
> a single commit, so dropping the shallow markers leaves a complete
> history from that reference. However, the 'tip' reference adds a
> shallow commit whose parent is missing in the cloned repository. Trying
> to unbundle a bundle with the 'tip' as a prerequisite will succeed past
> the object store check and move into the reachability check.

It makes it sound convoluted set-up for tests, but I guess it is the
most direct way to get to the state you want to test, which is good.

In practice, the problem would appear when you create a multi-commit
branch, which then is discarded.  GC then decides to expire the
older part of the commit chain while leaving the commits near the
tip still in the object store.  So the problem can happen without
users doing anything esoteric, and is very much worth testing.

> +test_expect_success 'verify catches unreachable, broken prerequisites' '
> +	test_when_finished rm -rf clone-from clone-to &&

OK, so my understanding of what happens is ...

> +	git init clone-from &&
> +	(
> +		cd clone-from &&
> +		git checkout -b base &&
> +		test_commit A &&
> +		git checkout -b tip &&
> +		git commit --allow-empty -m "will drop by shallow" &&
> +		git commit --allow-empty -m "will keep by shallow" &&
> +		git commit --allow-empty -m "for bundle, not clone" &&
> +		git bundle create tip.bundle tip~1..tip &&

... there is a single strand of pearls

	A---D---K---B tip

where D is with "will drop by shallow" message.  The bundle
is prepared to give a history leading to B while requiring K.

> +		git reset --hard HEAD~1 &&
> +		git checkout base

Then B is thrown away before the history is cloned.

> +	) &&
> +	BAD_OID=$(git -C clone-from rev-parse tip~1) &&
> +	TIP_OID=$(git -C clone-from rev-parse tip) &&
> +	git clone --depth=1 --no-single-branch \
> +		"file://$(pwd)/clone-from" clone-to &&
> +	(
> +		cd clone-to &&

The cloned repository should have

	A---d---K

where D is missing behind the shallow boundary, origin/tip pointing
at K.

> +		# Set up broken history by removing shallow markers
> +		git update-ref -d refs/remotes/origin/tip &&

But we remove origin/tip, so K (and its trees and blobs) is totally
disconnected.

> +		rm .git/shallow &&

And then this removes the shallow info that makes us to pretend that
K does not have D (missing) as its parent.  Now we lack the required
parent D if we start traversing from K.

> +		# Verify should fail
> +		test_must_fail git bundle verify \
> +			../clone-from/tip.bundle 2>err &&

verify_bundle() wants to see traversal from "--all" to hit the
prerequisite objects and K certainly cannot be reached by any ref.

OK.  So we ended up with a repository where we are on 'base' branch,
and origin/HEAD and origin/base remote-tracking refs exist, all of
these refs pointing at A.  Plus K exists but not D, but it is fine
because K is not referenced by any ref.

This is perfectly constructed test case that checks a very
interesting scenario.  It is as if the commit chain D---K was
discarded (via "git branch -D") and then D got expired for being too
old but K is not old enough.

We want to ensure "git bundle verify" and "git fetch ./bundle.file"
in this healthy repository, where its refs do honor the promise, but
its object store has unconnected commits (like "K") that are not
complete, behaves sensibly.  If we loosen "prerequisites must be
reachable from refs" to "prerequisites must exist", it will lead to
repository corruption if we allow the bundle to be unbundled and its
tips made into our refs, because these new refs point at incomplete
objects.

Excellent.

> +		# Unbundling should fail
> +		test_must_fail git bundle unbundle \
> +			../clone-from/tip.bundle 2>err &&
> +		grep "Could not read $BAD_OID" err &&
> +		grep "Failed to traverse parents of commit $TIP_OID" err
> +	)
> +'
