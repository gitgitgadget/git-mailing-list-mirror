Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4AFC2D0E4
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 10:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 807DA22201
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 10:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mtj2Ky7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgK0KWr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Nov 2020 05:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgK0KWr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Nov 2020 05:22:47 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AABC0613D1
        for <git@vger.kernel.org>; Fri, 27 Nov 2020 02:22:46 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id q3so5122456edr.12
        for <git@vger.kernel.org>; Fri, 27 Nov 2020 02:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=zLpF2d4GMfPz4DQUOwGSmWLhUknea/2I5OllLwcfa8E=;
        b=Mtj2Ky7Sp5atpM/KxiqMUkkbHlRTKFm7buGlUpGurL6D3YAvexO7juHSZzHKlnvzs4
         MmRMMWrSx9UNw/97KXRwFsSUiD1SIWxcqJgoko5XZ/Aor6do61bZTBAbPW/5mGqAWNU3
         4BtE3Y2IAjyUefRy/H2eKDpFWRrcBVAsdTJVLtLr3+nDbuvlJiSCqpv2v6OAeFDXZcJk
         slJgj3GFqDoDK6k4E+CBwEC62Hdz0Vu2bYaRynkJKEFidv+rGeLj9BNlw3/aZMvnuYJ/
         IF3msAJhKWaXnJBqlA3fZNiS79Ci6Iccltnr2S99dRcjZddYSCycxzgYlZXzHmo1Xx8S
         jdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=zLpF2d4GMfPz4DQUOwGSmWLhUknea/2I5OllLwcfa8E=;
        b=sE+T/FLz9TESLBr1lxWcpuEoI6AheAyqQRuXsXuXKu9cpNompxkNvWBGzNzvCbBJWz
         9TZ+cY8EWt/KIVhuBq2EuJeLIf72HkF7CgfRhkRMPkHLaG/z8ZOjs27h8/tA0l1iQe6x
         ofZywajwGaYspjEIhyzduqU3UtckuH+W8v8veKtv147Zye195va90UeDnO3zAvFYtvYs
         Rik8XnE4QaqzUaZxSljx8TJZtbB34CapWRnE6vVAwlXPvARY0zj8dGQliP09VmrNNv1e
         RQFFqIEYfTvPHx1jbrvAIHwP096CdJa6fcnCIuM+xWkaCetdGs6Gc163wR3+mgCAUH7W
         6cwg==
X-Gm-Message-State: AOAM532sUsNzx9pnUb5wzA/PfBfoWBWKok72qEMMRKMlX9Ot305p0eJ0
        K66ODk/hfTEaaZyuBwBl0wkGJlJdQVFMLQ==
X-Google-Smtp-Source: ABdhPJz4ys41QphsyPwur63tRwpeXjt2SpG57vXzk0mcEnwfkPIGipG9J95Y83EQbysNYASmRiAUzw==
X-Received: by 2002:a05:6402:1ac4:: with SMTP id ba4mr6848792edb.383.1606472565018;
        Fri, 27 Nov 2020 02:22:45 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id e10sm4713606eds.8.2020.11.27.02.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 02:22:44 -0800 (PST)
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
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v3 02/16] init-db: set the_repository->hash_algo early on
References: <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com> <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com> <cf667653dff437cee4c0d04e8c061a8b9ccc46a7.1606419752.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <cf667653dff437cee4c0d04e8c061a8b9ccc46a7.1606419752.git.gitgitgadget@gmail.com>
Date:   Fri, 27 Nov 2020 11:22:42 +0100
Message-ID: <87o8jjnlot.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 26 2020, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> The reftable backend needs to know the hash algorithm for writing the
> initialization hash table.
>
> The initial reftable contains a symref HEAD => "main" (or "master"), which is
> agnostic to the size of hash value, but this is an exceptional circumstance, and
> the reftable library does not cater for this exceptional. It insists that all

rephrase: "does not cater to this exception" maybe?

