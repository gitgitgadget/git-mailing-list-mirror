Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF36EC4321E
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 23:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiK3X4v (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 18:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiK3X4u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 18:56:50 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FC81024
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 15:56:49 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id w79so310680pfc.2
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 15:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zuJpO2r41VIYbiCRIe8dzpv98f7N2HDxHoq3u9tCcr0=;
        b=Rf5Tg/KFnkoW56zhqvyG9dnCt6p9xd8s5nLLxez0oqPskCwjASJwXjV83L66X7vS1n
         +FIVVc42TW0BAb0kb5I86F0S3vXoW2rJebDmYyaaDLA2HPQR2uiHxws39ecu5V4q7DMV
         BSASCN81diUDJrgL+klswVhEJYI7N5XT5mNPz3x4LZBR2mlKa8vJeJtbsr7qKVl6huD5
         4dznof5to81NJ4cVT7M5owlkeF8eX4Owo7Yg6iHMMBs6SWoMWa8p1dcb4LQNq9t3dNkY
         7a1eSju0IEJ43i8KFrXqGmz38fn2WabOJAlRowGurjzPiawPRttd/f9pm3pc4KOJpskZ
         2qyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zuJpO2r41VIYbiCRIe8dzpv98f7N2HDxHoq3u9tCcr0=;
        b=HFsznJ5i9Jmg+tpVuFLvQr42HZ9JIs5zZYNZKyTXC2bUvpR9lARjdvcJjeGStHhlvn
         Y81qIi7V3oqp921FSsHIE1nrV/P/72dbaVUvQW3/zOpV1HY4gFedghNJ7VQKGS+PwsMi
         yAe71E1QHyULGgwbw3VYfh2bimgORcgoB9Td68bhXIG3vwO6afFoSyx9/eb/QcpLVTJl
         Ofw/otA9OItGbRNG3LBYWAKmZEKEiVGW6hV8JV7fVq9JNnleMGkvkIpvixet88IQau0U
         lcpGhLI3xvfowtSl1MGh/nZEkuBquFs055eiyelZT8xxH6oDeemoYdYc/pSEg4LecvYy
         UQbw==
X-Gm-Message-State: ANoB5plp8dqMaE15HrCPKs0UJ3rsWeZp3W202cxgv+GNmqkjiEO/UUmu
        z6otEtb8TrxHSbIeyeol9rnZJcRfKiUlNA==
X-Google-Smtp-Source: AA0mqf4X7fmmqxas91a04CptaRk0nw3SYH+ykzyntK+80eyC9A5bQstCA2FXBQGSsiZQ83qgDb8aUA==
X-Received: by 2002:a62:1c49:0:b0:575:b4c0:f664 with SMTP id c70-20020a621c49000000b00575b4c0f664mr8428445pfc.56.1669852608694;
        Wed, 30 Nov 2022 15:56:48 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id o17-20020a170902d4d100b00186cf82717fsm2074443plg.165.2022.11.30.15.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 15:56:47 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/4] commit: don't lazy-fetch commits
References: <cover.1669839849.git.jonathantanmy@google.com>
        <6af8dcebd14d803fc8d2a01fbcc7f42ff380719d.1669839849.git.jonathantanmy@google.com>
Date:   Thu, 01 Dec 2022 08:56:47 +0900
In-Reply-To: <6af8dcebd14d803fc8d2a01fbcc7f42ff380719d.1669839849.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Wed, 30 Nov 2022 12:30:49 -0800")
Message-ID: <xmqq5yewuhc0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> When parsing commits, fail fast when the commit is missing or
> corrupt, instead of attempting to fetch them. This is done by
> inlining repo_read_object_file() and setting the flag that
> prevents fetching.
>
> This is motivated by a situation in which through a bug (not
> necessarily through Git), there was corruption in the object store
> of a partial clone. In this particular case, the problem was
> exposed when "git gc" tried to expire reflogs, which calls
> repo_parse_commit(), which triggers fetches of the missing
> commits.

The assumption is that there will never be a filtering mode that
says "give us tags and we will lazy-fetch everything reachable from
it when we need it", with which the "solution" will break down, I
think, and I would say it is probably good enough.
