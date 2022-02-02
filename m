Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188B3C433EF
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 21:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347627AbiBBVcz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 16:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347614AbiBBVcs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 16:32:48 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14178C06173E
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 13:32:48 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id z14-20020a17090ab10e00b001b6175d4040so8113172pjq.0
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 13:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=b8dmNyW+lIIOqUag155wRRFoqs7t/8G2zh3XRH+7zPc=;
        b=oBLPk2hq7i7wjiRXcrbpqW8nEIV2BIt7vC+le8YVZahZCSWl8YtI2CtsmKMSxfaymk
         ybeFN4twoM2q2OcpEh5zIWT/15wh0hpp/FwhNQ7HwapfebAZCyFs3UQzniz4023YzzvE
         dmBXvBxV5iPqn4OkMSxO5xbGwxUC4F2nDAkAh64c7l9GiLMtZZKZRLi6gEo1UAEmcp4l
         jvHtKZw9EcqPml8iRlIkdoypJY2bPWha7NNO8qDfAy4TH+YRAROlAZ6e7fsfuMOHwy5Z
         8p6vciATiCxZlVCmSgdqXcdSfKp77wEskatTJmKqOGv5Ju5sntPkUSB7nasEY+W/ZvLO
         DMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=b8dmNyW+lIIOqUag155wRRFoqs7t/8G2zh3XRH+7zPc=;
        b=OJehuhNwzusb9H1gtpFrgC5IOgIlRHynJWvT/V5WNFp033DujU5zF7zaM3+1yaefpq
         wZf+zV63wqy7OEyuIAdRun/LufY5SmKURH3BYSHydwmvQbgNFik5luElJAxH8B3GrTkr
         BlgxtjiGX1xutactoxZHCSmt8NEGqSJZ+jG0VN1aWLYdNYLAssLASOgHlX6wRHGTRrFm
         8QA7NyDtZ0dJL+nEKyISQgetPfCAV8N+ZhpWFIvJm1gKcHa4B3TntGR+HZ11aHWRozKR
         X/GQn34hxa8BxfFMTT3PdfTKcjgatikyzo0FgvvBgDcc0OSy5TMuUE9xX6brv99BFdgF
         DS7g==
X-Gm-Message-State: AOAM532rJ3fYoCaW30zkkpYE6QrNgOgGHSM/jDC/fa/DFQwoYfzDU5uZ
        IAUkSkjAFnwCCr18WvhX2lk=
X-Google-Smtp-Source: ABdhPJxGTKDiqt8eP8TpYBjW+BooQd9MV/PC0zGvOAJQOTW+fE6aFgplqny0A5Wn56wcJD8bC7srJg==
X-Received: by 2002:a17:902:da81:: with SMTP id j1mr33465782plx.14.1643837567393;
        Wed, 02 Feb 2022 13:32:47 -0800 (PST)
Received: from localhost ([2620:15c:289:200:da7f:76ba:d0d5:da44])
        by smtp.gmail.com with ESMTPSA id nh18sm7261166pjb.18.2022.02.02.13.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 13:32:47 -0800 (PST)
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
Date:   Wed, 02 Feb 2022 13:32:46 -0800
Message-ID: <xmqqwnidvts1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
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

