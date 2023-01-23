Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9458DC05027
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 22:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbjAWWsR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 17:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjAWWsP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 17:48:15 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0202F792
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 14:48:14 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id 5so7656009plo.3
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 14:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjFE6KQgYQU09ecDxYYHXc5fCZ+QYX8LfgxmPS7LwvM=;
        b=YlcWK8SRSbgfDf4pdvdS7LSwCctBmMu/vJDBj7lpuLPQ0/GBpkgUb5eJyJq7HreVPX
         I42R2PtV9z0JMFAdYujjixhXMxZ2ltDcVHNaJ5LsWc4qCvtSfwAa48XuOho3j8l+qgCT
         QoylUtlpW+pKNpDf/90V+S9jjZWy3eVGmglhs413OmX9vgWa6yI/VR6WM+XqeBNSYh1t
         u1hsuDzmq5buNUJiCqOfvXVr3hmaZ0lTwNMt85tRFWg2u7ZcvoiZt9/aQJRrMrsa1Gq4
         uVpCG3abVEoUOMOjXqntzGySfZZNgvtMcu6mrESuxy8RSCcjlttJUNZYqCxZ2CYSeJXJ
         hxfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vjFE6KQgYQU09ecDxYYHXc5fCZ+QYX8LfgxmPS7LwvM=;
        b=NJDQrscVRJz2gyCkFC5x+uzUalLvb9bik4mpq20odU4lOvlsV4MYfnqu+5ZdvHZDRP
         iddHv4cBALGBRRPbNX7ciYurUBnJMqLXvb+iREhDR7VkOy98aN2ox0p7dVN3NYFztCFo
         dl5/oNkszrh0CvoCb5owEIMUCcbjOFdltKVgjZydXtAXJAUNOGf3yNslDLaG3eXaI3F2
         0EY5Svf1AaRcWXert+7IOmr8g5SfIJ61+2UXFIyWcKGCYXOHOdJI8eg4rXCyL5ezU6dj
         TpZ7/Qh9ZOKGq9QJnmlTLg2XUKVn9vTz7XzHTjwE8hN7jBnxLfFHCaeyisZYHPJRzgxD
         Jpjw==
X-Gm-Message-State: AFqh2kpyIihD8ud2GKAsjA8ebAM+wk7J3bOuHT33YwBk42T2BpHzEjeV
        aMJt7Vp0eTAaXSbp20w3g0M=
X-Google-Smtp-Source: AMrXdXvbpJcykXJhv7wrPGSy/OpnQVVq4jrKHFUsEnMVG+irbVbxKNxLhnke6/pGJqFZr1stwIdheA==
X-Received: by 2002:a17:902:7b98:b0:192:d58f:e5ff with SMTP id w24-20020a1709027b9800b00192d58fe5ffmr25582520pll.16.1674514094034;
        Mon, 23 Jan 2023 14:48:14 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id s16-20020a170902ea1000b00194b0074b25sm213616plg.160.2023.01.23.14.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 14:48:13 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>
Subject: Re: [PATCH 1/5] run-command.c: remove dead assignment in while-loop
References: <cover-0.5-00000000000-20230123T170550Z-avarab@gmail.com>
        <patch-1.5-351c6a55a41-20230123T170551Z-avarab@gmail.com>
Date:   Mon, 23 Jan 2023 14:48:13 -0800
In-Reply-To: <patch-1.5-351c6a55a41-20230123T170551Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 23 Jan
 2023 18:15:05 +0100")
Message-ID: <xmqqcz74lvf6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Remove code that's been unused since it was added in
> c553c72eed6 (run-command: add an asynchronous parallel child
> processor, 2015-12-15), the next use of "i" in this function is:
>
> 	for (i = 0; ...

And it has been updated to a different type, i.e.

	for (size_t i = 0; ...

so it doubly makes sense to kill that unused variable.

Makes sense.

> So we'll always clobber the "i" that's set here. Presumably the "i"
> assignment is an artifact of WIP code that made it into our tree.
>
> A subsequent commit will need to adjust the type of the "i" variable
> in the otherwise unrelated for-loop, which is why this is being
> removed now.

That, together with the earlier mention of the other i (which I
think came from the same source---perhaps the original topic this
was taken from had int->size_t change in it) are both stale.

Please proofread what you send out before submitting.

Thanks.

