Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668BEC433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 21:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236429AbhLUVV1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 16:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhLUVV1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 16:21:27 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE312C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 13:21:26 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id f5so308668edq.6
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 13:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=hzsXlqW6H0ytigpBTNyYWYxuyvKlSjFW7f6JQQTpF4c=;
        b=atmykmOZbkABZfGV/+J1kugyGTozUhQkgwSwxHZKL9+zp9Ugze84zujYVSw+PIM5CZ
         CmdZvK4Qok6AImozhuO/rRMeYkgXZvBFFRF1BA0JEwRRBPuu+gcyGqQKoVStx3bpYopu
         W5XdAVOgNW4N1KGD8SHEiOfNBy7XzPVkUysxcKbqAgRge4M+GhFafll5Ct+aBDgqVypp
         HZJpuZM7VzKJ6tEHH3rJGUJfvZfvCRX8lKo2TKQooWgEpXt+3JwFHG7s/f2TQjWcslZY
         uwXBm5QEYTosNcV8R0GiBbO9sr7h4PCEJJyNakedvQNa+oEW6ekHWJCsaaD2pZeAxD61
         SqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=hzsXlqW6H0ytigpBTNyYWYxuyvKlSjFW7f6JQQTpF4c=;
        b=RG774FQEW7Mvdxxj9fx1bEcPTx4U1jX5IT0s3swIbSSTL2YmSsWAcW4mxKLUKyLWYT
         S89o4nJZMOjMDvUeF0o1OGydc2VKn4UvxfjfK/UHa+uqtPT5bFCZtnwfu9upFEKGP/+k
         gDzvWReRZPDBP4ACVoTlpD/6Begm6xYn0k+wMzlj56Q4koH41vCD7O5qWvMNpBPSXNai
         Z4q5kcpYNmAfPv+K1NNH4cmQeIRBIJGIjc0jZXss6DFDoUmA+1Vu5KU9Q7HkAnq0TTsj
         IDnN4F5w0WCdjAchYzI31d9bzqzpYnEFtkY9ssXDLs78xdvh6W2q6f0ah82nrVkHwJEi
         UocQ==
X-Gm-Message-State: AOAM531o+6WuLyKuXcI7ic+HrRYLzayxw6ZfSlHOUghaeMqYDKiiOgiq
        tVgV4EFjfwHRhx6mGDT3P82OLTxuNUY=
X-Google-Smtp-Source: ABdhPJzmrsdA+YzlDk7bFUdfdJyWUCl3Lkevd7fINjsA2JtdzOADBFji6QBaYDe5COsj+FrC1KAkUw==
X-Received: by 2002:a17:906:c156:: with SMTP id dp22mr151870ejc.36.1640121684923;
        Tue, 21 Dec 2021 13:21:24 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id c11sm367ede.32.2021.12.21.13.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 13:21:24 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mzmZX-000wrZ-QV;
        Tue, 21 Dec 2021 22:21:23 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/9] ll-merge: make callers responsible for showing
 warnings
Date:   Tue, 21 Dec 2021 22:19:48 +0100
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
 <d022176618d76943743940da0787291d51c9b4f0.1640109948.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <d022176618d76943743940da0787291d51c9b4f0.1640109948.git.gitgitgadget@gmail.com>
Message-ID: <211221.868rwdr6wc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 21 2021, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>

> +	if (status == LL_MERGE_BINARY_CONFLICT)
> +		warning("Cannot merge binary files: %s (%s vs. %s)",
> +			"base", "ours", "theirs");

This & other messages in the series have warning/BUG etc. starting with
upper-case.
