Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608CAC61DA3
	for <git@archiver.kernel.org>; Fri,  3 Mar 2023 22:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbjCCWXk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Mar 2023 17:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbjCCWXK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2023 17:23:10 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E05C6B334
        for <git@vger.kernel.org>; Fri,  3 Mar 2023 14:15:45 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id ky4so4289495plb.3
        for <git@vger.kernel.org>; Fri, 03 Mar 2023 14:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RTd7Bo85lQAooZXMzacIvo+B9PFqeZVU8YzBdZvj5TI=;
        b=Z6WkjOWQuNLXjOI5k6O2WX+m9eWQ+RVFgCFJnJdYFzHMSswlZE6gkId9fNLeW2uRVc
         FRVGd8WW+b0bhHLTm59+BES4ADGInIZzFZiFwP5ZVD7+53dk9dxOZDOVP3BZjmtilEgK
         RHb2h4CrciUq3lMYcpVeABja9bnWK5M5TNm681clCSWvmL/on+TYBiGaf6eXxGLpbGFA
         Y112uzPUSO25usjaPUsByBsCVv+3ONYpLTefxrkzzuufKKRwqJGbONSJewKgwrUhU4I9
         /qaaoooTmEbqfVK7nEfLfcGKLNIf7PuZiSxQEsNScECa9l2KuYrzd+fYO1WOyX1MVS9u
         dJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RTd7Bo85lQAooZXMzacIvo+B9PFqeZVU8YzBdZvj5TI=;
        b=P0igW+t8X4vE3BVjjkGh3CDzgedJIb1Op6FK7r1uVpuy7OXbtstXWTSDAK7nBbKXCZ
         QrlhjxLjmsOr/z0jBPbqU6z09vuFmlQafvKRMtlalXjZgrCUf55+UOVS9PGOGi0UEHRs
         QYpMXyqsG3/zWoc66OhdKpwyP+2qZkdmXKt0odYwixIiqltYtonihlllIJbqyuTCOKFQ
         dJ/Jy65uL0sgJjB0eoOpwvaJiXRLuE4RN7ZBEnjf4triOMdZqqcJMmtCiTzmts2iIVXC
         BrCG4D5jBBtNCijKfMy461sPsEwJxGJM2CXOHGCfJSa7CgvHaHzCElScl1tqZPx1gVJJ
         ygVg==
X-Gm-Message-State: AO0yUKVquqnK8DdOFGzFOUZq/FaIaaEj+19YSSYbaQU7GEVxnpJZ3Qu8
        eUyj19LtkR6mXO5TIkLNThwyq/S3Bgo=
X-Google-Smtp-Source: AK7set/MTFcvDORfQXVhaNYhTJhfXJ8hu+E0QTSVOjf5oXOc4Ad5VmgQGnBbupRDMk6ikPSuux4f7g==
X-Received: by 2002:a17:90a:19d:b0:233:ab9b:f86a with SMTP id 29-20020a17090a019d00b00233ab9bf86amr3331468pjc.8.1677880932364;
        Fri, 03 Mar 2023 14:02:12 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id y17-20020a17090abd1100b002349fa0300asm3794863pjr.48.2023.03.03.14.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 14:02:11 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3] range-diff: support reading mbox files
References: <pull.1420.v2.git.1668899471058.gitgitgadget@gmail.com>
        <pull.1420.v3.git.1669108102092.gitgitgadget@gmail.com>
Date:   Fri, 03 Mar 2023 14:02:10 -0800
In-Reply-To: <pull.1420.v3.git.1669108102092.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Tue, 22 Nov 2022 09:08:21
        +0000")
Message-ID: <xmqq8rgdebod.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Another thing I forgot to mention.

> Let's offer a way to read those patches from pre-prepared MBox files
> instead when an argument "mbox:<filename>" is passed instead of a commit
> range.
> ...
> +	const char *path;
> +
> +	if (skip_prefix(range, "mbox:", &path))
> +		return read_mbox(path, list);

Shouldn't this take the prefix into account, similar to how option
of OPTION_FILENAME type does using parse-options.c::fix_filename()?

A test that starts "range-diff" in a subdirectory and refer to a
mbox file elsewhere may be a good way to prevent such a bug from
happening and regression after the change hits a release.

