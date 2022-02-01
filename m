Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD58C433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 09:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbiBAJfm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 04:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbiBAJfm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 04:35:42 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075F3C061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 01:35:42 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id j2so32625074edj.8
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 01:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=uClK3BNFiXnkqL1eDILwDtmXjoJzpqvCpFsNy6Pym9w=;
        b=McJbcNwMPQKw2CUTJqbzYVcT27Z75aJto1ZrHjckLqZwW1ep20z8ypetDrzdzzYqkZ
         4Osd5Ko12itHHm9PBdDsYr9Y2cx///zSYculNdKn5A7ulLZSjmurl6WUmJqBLqSmPcBB
         fsbX2+jhSIsuVMTD1jb3ujEy2+v6kynpF43eFuzZTDxTN319NvGUjxYiPGHZD9ak8gC4
         pX+/K2ZcFtF7XPuk2RpP1U+G+VXbydvng9qnArQJUDMNMJ+SkN4Le2CXLPpQBSPfTlg0
         4hExTgB7f045DzLcY1WKO4gIAc2Gk0uQ5N0cU4UkhWqOnKEo+aJ2yrAaXKF7qWS81AB8
         5sLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=uClK3BNFiXnkqL1eDILwDtmXjoJzpqvCpFsNy6Pym9w=;
        b=Ne/OhzwGCRwdOD4OlbnG2n60nbeBAxA0HHAHrA0zbP4KbFMjfK/Hq2Qo/RyUHz32nl
         u+ksD7taVS1elVsFmekwKcDkwY9TgGyx4wLLvOy1rljAzrjbHxnFviqbvjGOTtoY7h/5
         LvGQasYPl6Y0hkeOugyVIVZqyopAZHidmZ76uTaeaOINBYSzu5C6MZ8C6Q/qYz+UuIm1
         y9XjWo7OmNNgv/jap2mJ6n+ATu7tL6ua9qrZ/CZqS8n5uPT5VM1Xpbk1gFmh0AmEQ0sG
         rkChMPF38teY+sB64Ygk9ivvsjnUwkwskZlQsVpP5Wr7lfaVYzJi4YlcGr2UtgnX9boY
         Lodg==
X-Gm-Message-State: AOAM531s+FKhLwqr7Isx3rld5ZMy1wHGgBVYdf2xro0oKPYkLJuWLq5J
        O2RHHVJdRr6xyPrpPAKvrGXI8jbjT9E=
X-Google-Smtp-Source: ABdhPJwX997nLVNF9K4tP1ETvA58cGuP8FmiLD1fvNw0lxtD7JNKI5o0+AJ6L8PFgjdjZAIBxJRFyA==
X-Received: by 2002:aa7:c04e:: with SMTP id k14mr23958792edo.131.1643708140125;
        Tue, 01 Feb 2022 01:35:40 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s7sm14313912ejo.212.2022.02.01.01.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 01:35:39 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nEpZa-003yHz-QJ;
        Tue, 01 Feb 2022 10:35:38 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 01/10] show, log: provide a --remerge-diff capability
Date:   Tue, 01 Feb 2022 10:09:39 +0100
References: <pull.1103.v3.git.1640907369.gitgitgadget@gmail.com>
        <pull.1103.v4.git.1642792341.gitgitgadget@gmail.com>
        <0b94724311df34dd10debd43c466695ed406d790.1642792341.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <0b94724311df34dd10debd43c466695ed406d790.1642792341.git.gitgitgadget@gmail.com>
Message-ID: <220201.86zgnb9bf9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 21 2022, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
> [...]
>  ifdef::git-log[]
> ---diff-merges=(off|none|on|first-parent|1|separate|m|combined|c|dense-combined|cc)::
> +--diff-merges=(off|none|on|first-parent|1|separate|m|combined|c|dense-combined|cc|remerge|r)::
>  --no-diff-merges::
>  	Specify diff format to be used for merge commits. Default is
>  	{diff-merges-default} unless `--first-parent` is in use, in which case
> @@ -64,6 +64,14 @@ ifdef::git-log[]
>  	each of the parents. Separate log entry and diff is generated
>  	for each parent.
>  +
> +--diff-merges=remerge:::
> +--diff-merges=r:::
> +--remerge-diff:::
> +	With this option, two-parent merge commits are remerged to
> +	create a temporary tree object -- potentially containing files
> +	with conflict markers and such.  A diff is then shown between
> +	that temporary tree and the actual merge commit.
> ++

Re some previous discussion. I really think we should add something like
this paragraph to this:
    
    The output emitted when this option is used is subject to change, and so
    is its interaction with other options (unless explicitly
    documented). I.e. many of the same caveats as the "OUTPUT STABILITY" in
    the linkgit:git-range-diff[1] documentation describes apply here. In
    particular other diff filtering options, pathspec limitations etc. may
    not produce the expected results, as some of those may apply to the
    "real" diff of the merge, and not on the generated "remerge-diff".

I think that would nicely give us permission to develop this further
without having to think about all the option interaction etc.

This is really useful right now, but I'd hate for it to get merged with
some bug/behavior that's not obvious to us now, and it being hard to fix
that because we'd have to consider the implicitly promised backwards
compatibility.

>  	int saved_dcctc = 0;
> +	struct tmp_objdir *remerge_objdir = NULL;
> +
> +	if (rev->remerge_diff) {
> +		remerge_objdir = tmp_objdir_create("remerge-diff");
> +		if (!remerge_objdir)
> +			die(_("unable to create temporary object directory"));

I guess the s/die_errno/die/ here is better for now as we won't report
the wrong errno, but also lose the common case of errno being right. But
that can be fixed up with some other series to the tmp-objdir API.

> [...]
> +# This test is ort-specific
> +test "${GIT_TEST_MERGE_ALGORITHM:-ort}" = ort || {
> +	skip_all="GIT_TEST_MERGE_ALGORITHM != ort"
> +	test_done
> +}

FWIW this is still on a more complex pattern that it needs to be, see
this v1 discussion (which you seemed to ack):

https://lore.kernel.org/git/CABPp-BE+4rZNP-5mT2MNOWR6y6BgEG6mt1r_qcrZtarom6aGsw@mail.gmail.com/
