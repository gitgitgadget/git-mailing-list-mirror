Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2773CC433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 07:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0391A6120E
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 07:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237809AbhDMHSi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 03:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbhDMHSh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 03:18:37 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB0AC061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 00:18:18 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x4so18187371edd.2
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 00:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=gV9R6sgv3IgbMrcouHdpZEMgb/b8KCUjIKKiQ0G1JmU=;
        b=K9SYzTMfMBp75SUEKQUarljBP5TvWPWFphzTTwg+pyoIZPv9vCjYLJsv9GKTH+c8GK
         BdibZbrUZEq7boXv5gY9KmART/j7OirkqyD8Js6ZD4S3E3kZE7SWlMnh1TEJlLBej6Av
         36RxYnYZiSxKaGDzowk+7oOLFCbz1YA9s9uEZKJwyUrYrCXJyGpGk/2mmpSDp+xF6AiL
         yHJjEnUNMu+FWeLM227tjmInOrHn2/PPYi3In2zAWKl94W9dVugeLYoqGl8YousLinc0
         uyzAyVg9I2DesH9BfZmE1htR+ijw9Qfbq/jEdWchfQwgMkP3bWsF9QlvOg2HeGu4Ews4
         k0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=gV9R6sgv3IgbMrcouHdpZEMgb/b8KCUjIKKiQ0G1JmU=;
        b=rR1LnpD6bjcFPa7O8LZkh0+ml9EOdKFRRsgWI8yMb4YPotQde6ZbAfLKDDPzfpRXW4
         RfkPsMM4Vj+aEw5sn88lh7mHbD+B8UjzurD/995BFX9WAk/JktqO0cFRP4TKMc7MED2C
         9HT5WneHMrqXmv9iHzqpHDzWsWNvdsbpuXsxpBVJoJq8ym0jK6i+XJ4ocjI1SwbesuZx
         WJIdqlwRnNr7vUvU4smYl5UNxr+Nl65dgrHawBkkgQPYUSi1I4T4Lpwc1FPCSKosz1Le
         Ga70MbaLXZXFVj58shGv4A1yjYqru4XLsOJRGpRQF9m1fvcOdz0vcxZtWIVggnVn9nSj
         qQ3A==
X-Gm-Message-State: AOAM530fjGFcLy/kauyfyznLlx7R4Bvdi/x3Dz1/VqXbpBirML6bqMjq
        +y17/UrERX49rHdQU61J59FnpykKAW0XJw==
X-Google-Smtp-Source: ABdhPJw+zlPdNmxeR4uK8stPgPH1bA5+N7ciOPnsC6cX5rp7Ba7PrtHEtxMWQ3O6y3+Uj9GS9ed8MA==
X-Received: by 2002:a50:d7d7:: with SMTP id m23mr32779262edj.378.1618298296860;
        Tue, 13 Apr 2021 00:18:16 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id p9sm8548353edu.79.2021.04.13.00.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 00:18:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v6 18/20] Reftable support for git-core
References: <pull.847.v5.git.git.1615580397.gitgitgadget@gmail.com>
 <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
 <2dc73bf2ec96acae12a17c719083d11401775bc3.1618255553.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <2dc73bf2ec96acae12a17c719083d11401775bc3.1618255553.git.gitgitgadget@gmail.com>
Date:   Tue, 13 Apr 2021 09:18:15 +0200
Message-ID: <87im4qejpk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 12 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> It can be activated by passing --ref-storage=reftable to "git init", or setting
> GIT_TEST_REFTABLE in the environment.
> [...]
> +const char *default_ref_storage(void)
> +{
> +	const char *test = getenv("GIT_TEST_REFTABLE");
> +	return test ? "reftable" : "files";
> +}

Nit: use git_env_bool() here. So GIT_TEST_REFTABLE=true is true, but
GIT_TEST_REFTABLE= is not.

Not a nit: are these tests supposed to work / do they work for you? For
me there's a *lot* of failures, e.g. t6120-describe.sh fails for reasons
you might expect, manually tweaking things in the FS-refstore, but
e.g. t5510-fetch.sh segfaults.

t0001-init.sh fails with:

    git: refs/reftable-backend.c:194: git_reftable_init_db: Assertion `refs->worktree_reftable_dir == NULL' failed.

This is on an amd64 Debian w/Linux 4.19, so nothing exotic.

> [...re-arranged a bit...]
>
> +if test -n "$GIT_TEST_REFTABLE"
> +then
> +  test_set_prereq REFTABLE
> +fi
> +
>  ( COLUMNS=1 && test $COLUMNS = 1 ) && test_set_prereq COLUMNS_CAN_BE_1
>  test -z "$NO_PERL" && test_set_prereq PERL
>  test -z "$NO_PTHREADS" && test_set_prereq PTHREADS

Ah, so here's the (seemingly underused) prereq, but:

> --- a/t/t1450-fsck.sh
> +++ b/t/t1450-fsck.sh
> @@ -8,6 +8,12 @@ test_description='git fsck random collection of tests
>  
>  . ./test-lib.sh
>  
> +if test_have_prereq REFTABLE
> +then
> +  skip_all='skipping tests; incompatible with reftable'
> +  test_done
> +fi
> +

I understand that getting this series to land has been a pain, but this
sort of thing doesn't inspire confidence.

Manually running it under reftable anyway I have 17 out of 81 tests
failing. A lot of tests won't run under reftable because they're of the
form:

	test_when_finished "remove_object $tag" &&
	echo $tag >.git/refs/tags/wrong &&
	test_when_finished "git update-ref -d refs/tags/wrong" &&

I.e. we have some hack to get around update-ref guarding things for us.

I would think that a better approach here would be to start with some
(per-se unrelated) series to teach update-ref some mode like
hash-object's --literally, i.e. "YOLO this ref update".

Then adjust our various tests that move, clobber, or intentionally
corrupt things in the refstore to use that helper/option.

At that point we can actually run things like t1450-fsck.sh, maybe we
simply have to skip some of them because we think the sort of corruption
we're testing/worried about is impossible with reftable, but that in
itself is *very* interesting.

I.e. do we not have to handle certain edge cases at all in fsck and
friends because of inherent properties of the reftable backend (e.g. I'd
assume, but don't know, that we're not likely to get one corrupt ref
entry with it), but of course we can have a ref pointing to a loose
object that then gets removed, and is thus corrupt.

Anyway. I'm speculating, but that's also my point, that I'm having to
speculate. That comes down to us having a new GIT_TEST_* mode that
doesn't pass the test suite._
