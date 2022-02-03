Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A58C433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 23:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355764AbiBCXzs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 18:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiBCXzr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 18:55:47 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA93C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 15:55:47 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id r59so3891134pjg.4
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 15:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:references:user-agent:date:message-id
         :mime-version;
        bh=b8dmNyW+lIIOqUag155wRRFoqs7t/8G2zh3XRH+7zPc=;
        b=EW630vSI2uMiXaBtT2WdM2NZSHoksS0YeYCDV3U0+9cfQ2/dtAoIo2U59dMnS6xUDl
         AihbFK4zRTgf5QRun1Fj2uPR7HYnCDMWl0OsPrTRWVfu5kKk8ZCQQ4uLCBml3CifRS3a
         /0GjNrt9gH5QF91vPwSzjqjdBA+A4jiUkkjcVC+BWda6zV/plg9OKhpqK58DisviWoYU
         gmNFqe3ZSZlDxLaWPfFOiNMX6SwpkRg/pyhzzW263tnfsuDM+CdfoWSra0VWyEoSP2hg
         8d7UyvIT06cR326YBLnv1Psvyz6Rpy972mHotT4QCafn7AUQu0dJMwEc2FvCOr4Zckdo
         TnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:references:user-agent
         :date:message-id:mime-version;
        bh=b8dmNyW+lIIOqUag155wRRFoqs7t/8G2zh3XRH+7zPc=;
        b=Cum81it3BuzMv2TdWyHIqUjGvqq8O83ktaQjVKAJpGtvxJgVRtV6wblYak/m2JjMju
         R/sTfrvxNLBspHOGM4GA0WjfD6fKeWL1/o5CgLvh/H4G2VYxfDC9mRaHFFLYVPPWFdUG
         p0jngsTjG2VVHdm08W56ipWkt+muMKNYWdODK2E8uwPrJ5ft0kUGcbRuSchnNjCCJ3xm
         h6Z/uqIWHjT44kxk6kaedpBfgr6NkEbmpS5Uf8T9mA1ViJquJi9iLfI+xkKQXmftiurq
         FsSKReB1D2WPR5IoCWbkEt9c22sHurH44Gkq2za5bWl6PD9MD4DserDGmKtbglU+HF5j
         i60w==
X-Gm-Message-State: AOAM533RxJWvCCcdQi0jK2uQ1kQwNgmAa/v1OaAG3kXSOCUk+TJ9Pjhq
        ZVubLAI2HbwwE2puIVhdrwg=
X-Google-Smtp-Source: ABdhPJy9TKmfHlYDuTba4CLRVEvHvPvMtHstbrZiZYq+zkb4oTajvVhOqah9UicT+P2Z8i8aS7ad3Q==
X-Received: by 2002:a17:902:784b:: with SMTP id e11mr472391pln.167.1643932547183;
        Thu, 03 Feb 2022 15:55:47 -0800 (PST)
Received: from localhost ([2620:15c:289:200:b5c2:580b:9b41:56b2])
        by smtp.gmail.com with ESMTPSA id c7sm132031pfp.164.2022.02.03.15.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 15:55:46 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 10/13] merge-tree: provide a list of which files have
 conflicts
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
        <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
        <243134dc2478e21f67a6d9cb999d6754b616f6ee.1643479633.git.gitgitgadget@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date:   Thu, 03 Feb 2022 15:55:46 -0800
Message-ID: <xmqqmtj7pksd.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +Conflicted file list
> +~~~~~~~~~~~~~~~~~~~~
> +
> +This is a sequence of lines containing a filename on each line, quoted
> +as explained for the configuration variable `core.quotePath` (see
> +linkgit:git-config[1]).

Makes sense.  Ideally things like this should be discoverable by
inspecting the tree object shown as the result of the (conflicted)
merge, but since the design of the output is to show only a single
tree, there is nowhere to store such an extra piece of information
per path (grepping for markers in blobs of course does not count).

I guess an alternative to show four trees when conflicted instead of
one (i.e. the primary tree may either contain only the cleanly
merged paths _or_ also blobs with conflict markers for conflicted
paths; the three other trees record three stages that would be in
the index, if we were performing the same merge using the index),
but a machine-parseable list of paths is fine.

> +		merge_get_conflicted_files(&result, &conflicted_files);
> +		for (i = 0; i < conflicted_files.nr; i++) {
> +			const char *name = conflicted_files.items[i].string;
> +			if (last && !strcmp(last, name))
> +				continue;
> +			write_name_quoted_relative(
> +				name, prefix, stdout, line_termination);
> +			last = name;

OK.  The iteration used here makes casual readers wonder why the
helper doesn't make paths unique, but the string list item holds
in its util pointer a pointer to a structure with <stage, mode, oid>
tuple, so it is natural to make the consumer, who wants uniquified
list, responsible for deduping, like this loop.

> +		}
> +		string_list_clear(&conflicted_files, 1);

And the stage-info structure associated with these paths are
deallocated with this call.  Good.

> +	}

