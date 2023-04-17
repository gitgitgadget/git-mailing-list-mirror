Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26773C77B76
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 22:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjDQWQS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 18:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjDQWP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 18:15:56 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B9255BF
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 15:15:55 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n17so11656309pln.8
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 15:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681769754; x=1684361754;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sETS6CccaiBADEfoTwfDq/GDMbFh8Ih8Q5ezpoBVGJA=;
        b=nzs3nKiO2Cq/ijTfToA5g5/I7d124giJOcTdXLyT3FvRxImUk+owaexjzW0c7DkX7x
         YCHlulSto5+xqo0BEZuhiFNk2XUDAWhuF9DoV37wq5iO6dgeAxneEixQUsjE814u9Wma
         Pc1Egd7BEvMhkYC6kt6RgUuSTU1UsdVUgdb/k9o+LZYs49mnp7Z19qHDBNAoZGZQTfOQ
         nzA+PYhNxes7QlWuoVfqe2mqFgzWkejx6BZkLJzaknCLMZ3KT6oC3S+IfUEh20Y/vhWQ
         EXr0003xHgdZMcVfXcljBrZDEDwlBjXmK0zdOX4HESBDsGvA+yPzhbKJ9pb/yOZo/WFU
         f6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681769754; x=1684361754;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sETS6CccaiBADEfoTwfDq/GDMbFh8Ih8Q5ezpoBVGJA=;
        b=XX+O1BBtzQGPlFQPAY0vk4J9xfr1hUP7sPpSO9zLaGgNJ7hwliYcL7SjPfdjU26gNg
         ITYz/UU4yyrNA6juUA5r9xjcV4qodsYNVNjL2Wl/wbg8doOCTO3j1imWZ6yvjZMBOUm2
         KlTm6GN8Rilu7fvlYgNy0hkJwI1qvjsbEa5MfmeWtlP1A8AJBnwyhhgQ549Bbq9A5LBz
         +NXtcwEiEIFYnGbstLhEUle2B8bW7k4S5+xvU1GqV9DEf0oxRWESFtklr+YRrEB77VcE
         25k2ycznVyJ9SiDQ3SD0lgaUziE0VpLbt2ZKXqEnf4+Ac31dLxh8vZvXCsJ8rjkQ2cLh
         R1bg==
X-Gm-Message-State: AAQBX9dalKWJy1+Lwxf6RZyDLyzBMEyGEoQUEqp2Vo7Yu8ky4hYRaHEy
        oa/jaKZ2Ow6cCLMGHG9pT5N3mr3u9pk=
X-Google-Smtp-Source: AKy350a2LgwCehQO2kbqWmIkj9rxnbwXdthTwJ/8EqFBsdUp87F3syCVqXhetouYw44ho3sndB1eRQ==
X-Received: by 2002:a05:6a20:3ca4:b0:f0:4dbf:3b99 with SMTP id b36-20020a056a203ca400b000f04dbf3b99mr2913434pzj.5.1681769754534;
        Mon, 17 Apr 2023 15:15:54 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id h3-20020aa786c3000000b0063d375ca0cbsm171241pfo.151.2023.04.17.15.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 15:15:54 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/4] fsck: check rev-index checksums
References: <pull.1512.git.1681748502.gitgitgadget@gmail.com>
        <7db4ec3e327ed3695f4f5409cb2dc80c72688758.1681748502.git.gitgitgadget@gmail.com>
Date:   Mon, 17 Apr 2023 15:15:54 -0700
In-Reply-To: <7db4ec3e327ed3695f4f5409cb2dc80c72688758.1681748502.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 17 Apr 2023
        16:21:39 +0000")
Message-ID: <xmqqwn2ai291.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +corrupt_rev_and_verify () {
> +	(
> +		pos="$1" &&
> +...
> +		grep "$error" err
> +	)
> +}

Curious.  Would it work equally well to write

	corrupt_rev_and_verify () (
		pos="$1" &&
		...
		grep "$error" err
	)

without an extra level of indentation?
