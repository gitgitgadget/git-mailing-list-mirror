Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06A9C43381
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 16:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8891623A53
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 16:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbhAUQuQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 11:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731410AbhAUP6I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 10:58:08 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C201C061353
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 07:55:34 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id n6so3047841edt.10
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 07:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Mt/WLRw5oUpdtIVMVNDhiSGydgQaYDmCc21Gx8onE8I=;
        b=Q4p1k5ZsbL30BQSoUsVLLmbWwn32X1ByNwlTUvZVXmlS6wlSocLTsZLMFnIaJbpQ2Z
         6dM7sTx81ub6MKDgiwyMKU+VRFsnhT9Rx+P+UUziv4tHcQAMWsmc63XmYhIpiTp4Ckse
         ifHotCmsWikaVNID6yVMLW/B3TgmietvU218C19G60n7nhToActEtnb5IlJg1mWXvkbF
         Vcnj8ZMSE1Oa0+hy3tPGnrCzic9sNUEsSj40ULpwfkupMTa+A1ORwUmt3u9UK7r0JE1d
         /U9HkGsShc98ByTgO6b84Fg4FlcNSNKTcSck9X3yE42ykqB+pzU84afMR7TdZF8owxy7
         P4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Mt/WLRw5oUpdtIVMVNDhiSGydgQaYDmCc21Gx8onE8I=;
        b=NcPuPEO/hZI5Ab/N9FOAHbRrfp4ZAGcZvBtwGEPD08OIAsVFgUJjKt9y9JGJwXwInD
         7e/TlaNxGYaUTypDTcYg3YIQux0gK7miD/0TxPk9koDyALC5PBR7K8gyEG5txwC+gAgx
         JCTZRCBJPOpj6FuYVSsdZZg9XZWhw+0DH7ngTMz3YgJQ3lAYXasIs8vjWNphQQg8fkTg
         Jp6mJuxebpTBdrElfj0RCBAe6XyruNr5AYeMiixmppnzGkmH5Ft51JRLcc0mkBWk2pQ/
         n/8BjQnhJblvKxhrjy3nM/wo6+hD6E9GXA/dZwA7kTUGfXEwSxJp+n6aftp5JXjEZOkP
         oVBg==
X-Gm-Message-State: AOAM532nLrdoICpRoroOnWPrRMGTJsSK44FAWxkra5cSGlvZBK8QGWGg
        +XYmHKnDbQ1N9J9sMjHefkOdH5itMqINmg==
X-Google-Smtp-Source: ABdhPJwYI4+fQwzTVUb0GWwrtW6oFzFM1Z5/205qAbcmGumJh0DgX5biyzT256PgxB0DZyO/gocoTg==
X-Received: by 2002:a05:6402:2207:: with SMTP id cq7mr12268588edb.272.1611244532980;
        Thu, 21 Jan 2021 07:55:32 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id br6sm511852ejb.46.2021.01.21.07.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 07:55:32 -0800 (PST)
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
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v4 13/15] Reftable support for git-core
References: <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com>
 <pull.847.v4.git.git.1607522429.gitgitgadget@gmail.com>
 <d57023d9f13d178dc95d7a74751923b80d1a5939.1607522429.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.14
In-reply-to: <d57023d9f13d178dc95d7a74751923b80d1a5939.1607522429.git.gitgitgadget@gmail.com>
Date:   Thu, 21 Jan 2021 16:55:31 +0100
Message-ID: <871ree8eto.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 09 2020, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
> [...]
>  refs.c                                        |   27 +-
>  refs.h                                        |    3 +
> [...]
>  refs/reftable-backend.c                       | 1435 +++++++++++++++++
> [...]
> +static int git_reftable_read_raw_ref(struct ref_store *ref_store,
> +				     const char *refname, struct object_id *oid,
> +				     struct strbuf *referent,
> +				     unsigned int *type)
> +{
> +	struct git_reftable_ref_store *refs =
> +		(struct git_reftable_ref_store *)ref_store;
> +	struct reftable_stack *stack = stack_for(refs, refname);
> +
> +	struct reftable_ref_record ref = { NULL };
> +	int err = 0;
> +	if (refs->err < 0) {
> +		return refs->err;
> +	}
> +
> +	/* This is usually not needed, but Git doesn't signal to ref backend if
> +	   a subprocess updated the ref DB.  So we always check.
> +	*/
> +	err = reftable_stack_reload(stack);
> +	if (err) {
> +		goto done;
> +	}
> +
> +	err = reftable_stack_read_ref(stack, refname, &ref);
> +	if (err > 0) {
> +		errno = ENOENT;
> +		err = -1;
> +		goto done;
> +	}
> +	if (err < 0) {
> +		errno = reftable_error_to_errno(err);
> +		err = -1;
> +		goto done;
> +	}
> +
> +	if (ref.value_type == REFTABLE_REF_SYMREF) {
> +		strbuf_reset(referent);
> +		strbuf_addstr(referent, ref.value.symref);
> +		*type |= REF_ISSYMREF;
> +	} else if (reftable_ref_record_val1(&ref) != NULL) {
> +		hashcpy(oid->hash, reftable_ref_record_val1(&ref));
> +	} else {
> +		*type |= REF_ISBROKEN;
> +		errno = EINVAL;
> +		err = -1;

I've been chasing down some edge cases in refs.c as part of another WIP
series I have and found that for this particular "errno" stuff we don't
have any test coverage. And with master & hanwen/reftable if I apply:

    diff --git a/refs.c b/refs.c
    index af0d000082..8ac57908ea 100644
    --- a/refs.c
    +++ b/refs.c
    @@ -1589,3 +1589,2 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
                        !refname_is_safe(refname)) {
    -                       errno = EINVAL;
                            return NULL;
    @@ -1649,3 +1648,2 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
                                !refname_is_safe(refname)) {
    -                               errno = EINVAL;
                                    return NULL;
    @@ -1657,3 +1655,2 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
     
    -       errno = ELOOP;
            return NULL;
    diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
    index e98d22c826..e09ae21965 100644
    --- a/refs/reftable-backend.c
    +++ b/refs/reftable-backend.c
    @@ -1343,3 +1343,2 @@ static int git_reftable_read_raw_ref(struct ref_store *ref_store,
            if (err < 0) {
    -               errno = reftable_error_to_errno(err);
                    err = -1;
    @@ -1355,3 +1354,2 @@ static int git_reftable_read_raw_ref(struct ref_store *ref_store,
                    *type |= REF_ISBROKEN;
    -               errno = EINVAL;
                    err = -1;

All tests pass on both.

Anyway, in the case of the code sitting on "master" I find that less
concerning. It's some code that's drifted apart over the years blah blah
blah. Boring details but for various reasons we don't use some/any of
that error handling logic anymore, or to the extent that we do I'll need
to improve the tests.

I must say I do find it a bit more concerning in the case of the
reftable series. I.e. the git_reftable_read_raw_ref() function seems
like a faithful copy of the general logic (at least this part) of the
refs_resolve_ref_unsafe() function in refs.c.

That I can remove error checking/handling from this place means existing
general logic was faithfully copied without checking that we have a test
for it, or adding one. Or perhaps given the history of this codebase
there's out-of-tree tests for it somewhere?
