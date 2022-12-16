Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08285C4332F
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 10:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiLPKHE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Dec 2022 05:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiLPKG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 05:06:56 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1C118386
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 02:06:56 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id fy4so2033875pjb.0
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 02:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FlaQQ6TACwi4/Qpm84hJZFel4/9ckzb/wxT5m/0fwVc=;
        b=NPnXlv3ghlZAC8JLn6ZtXrKUzEyg2ga/h9zK0tNy+6/Tc4b6KhG0PmWU1X/K1acBUd
         DBi8HTAOfU6EL6EmSVT2mrqOIA9+/CzMhBvglzQz7KgugCywUbvHIA8dSEHN9+s2mWYL
         w1yvjy+o5g+H0TbQyFEKqKFPOddNyf8Uf3xnz9pC4J08wigDxXQYgr6oUeDKgiVnUd+1
         tclrwXpGJsDaAktJtrQODmhGyiefBE2oTztOZfnkD1U/y8ackHDfnP8nWEAmW2GuO7w5
         g0TDI3RGd8CFU4O5S81s+sqsXjvRMpCBBkj+2cO0vo8W+WtTlSuG625Swdh1pzoJzqPd
         JA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FlaQQ6TACwi4/Qpm84hJZFel4/9ckzb/wxT5m/0fwVc=;
        b=s1+x/W4YT23n7T7INQ5H++Nw5bRBNjZCBoATY8qxAiznDfShGa4rmZ6W68K3g2I7FY
         XvwyS9uAMxgmroW3F33gyYBsNhezjB4JdKmgwTqHubHOUYpFpjEsxTqpOwVI3oXager+
         EgYUDT1BjEOFbZnxIM65gm7AzDtA78gKpGB9t1PLqqhe8aqR0k6gL70kICEbf/7eR2ny
         ILZ5Llf3F+9SkYqPvv4F4nv3kiYF2vZQkdQn1F+jASM1rY0iL1qw8Y4N0vkO9NiiJ9LZ
         wY3jV7xkEdiu0ctKg6hfH7bYd/c8XX+N9Ez8OeIAQ3CvqxC0rIV9VJzDDsMhc/eI6vp1
         KhXg==
X-Gm-Message-State: ANoB5pkuVKaH/bMLJuflXUKBT9g+i7ZHplBx7dqZcaEETXE+NG7eqjUU
        d9SRKSwqo/jq/c+zO6axWq8=
X-Google-Smtp-Source: AA0mqf67oeql/hW8A5ys4sxZKDOYDwsc2Avja6QahNsZvAvupbwScFZHYySYozyaf6U9bSgkBYL/ZA==
X-Received: by 2002:a05:6a20:d2c3:b0:a3:7fcc:465a with SMTP id ir3-20020a056a20d2c300b000a37fcc465amr38400615pzb.49.1671185215359;
        Fri, 16 Dec 2022 02:06:55 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090aee8a00b00219752c8ea5sm1042426pjz.37.2022.12.16.02.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 02:06:54 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Chris. Webster via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, "Chris. Webster" <chris@webstech.net>
Subject: Re: [PATCH 1/2] Make `check-whitespace` failures more helpful
References: <pull.1444.git.1671179520.gitgitgadget@gmail.com>
        <67f60e4e5cbb470bbf3f556f962403af5dd5938c.1671179520.git.gitgitgadget@gmail.com>
Date:   Fri, 16 Dec 2022 19:06:54 +0900
In-Reply-To: <67f60e4e5cbb470bbf3f556f962403af5dd5938c.1671179520.git.gitgitgadget@gmail.com>
        (Chris. Webster via GitGitGadget's message of "Fri, 16 Dec 2022
        08:31:59 +0000")
Message-ID: <xmqqo7s3mzlt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Chris. Webster via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Subject: Re: [PATCH 1/2] Make `check-whitespace` failures more helpful

People usually make changes to the system to make it "more useful"
and/or "more helpful", and almost never to make it "less helpful".
Phrases you would use to explain why the failures become more
helpful with this change (compared to without) would help to promote
it in the "git shortlog --no-merges" output for the next release.
E.g. "make X failures stand out more", "make X failures gramatically
correct", "show X failures more concisely", etc.

> diff --git a/.github/workflows/check-whitespace.yml b/.github/workflows/check-whitespace.yml
> index ad3466ad16e..3a99073bc33 100644
> --- a/.github/workflows/check-whitespace.yml
> +++ b/.github/workflows/check-whitespace.yml
> @@ -13,38 +13,57 @@ jobs:
>    check-whitespace:
>      runs-on: ubuntu-latest
>      steps:
> -    - uses: actions/checkout@v2
> +    - uses: actions/checkout@v3

I think we saw changes to upgrade actions/checkout@ in another
topic, and it seems that we have missed this one even though we
should have upgraded it the same way as other files in the same
directory?  Shouldn't this hunk be a separate topic on its own,
or at least a separate patch on its own in the series?

>        with:
>          fetch-depth: 0
>  
>      - name: git log --check
>        id: check_out
>        run: |
> -        log=
> +        problems=()

Is it safe to assume we run Bash here, or can GitHub start using
other shells that lack the Bash-ism shell arrays and we should
protect against such future?

I suspect that we are already depend on <<< Bash-ism, so one more
dependency to Bash-ism is not a problem here?  I dunno.

Thanks.
