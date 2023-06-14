Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1D4EB64D7
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 00:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241048AbjFNAcU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jun 2023 20:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjFNAcT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2023 20:32:19 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3791732
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 17:32:18 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-25bec2512f3so2056296a91.0
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 17:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686702737; x=1689294737;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x0FEnHFcVXXwqQT908WZH1fmerFrPYyreU+UANik0g8=;
        b=EX0TbjWUiR/yjOjWIKs+Ox+28+ZopeqL/xxiDaU/KICXjqIoPTfTCeAypOvNO/fTIV
         LLJCKogAM2MhsBI6lYJGQ8wpV0mjLE1ZfO5qCnYcc8MlDcIOezSqpWKSZGGbI4RE7TA0
         LP4N/rg5FaC6QY9fEkSplklYOg5nhIbjr9CjoEoSdJCMbTJnrB/baSmS58tL4f2iFR+u
         MfcZHk1vNW1KHyH8exRx5PR8ZHXeFoADb0UrppfAjFpcvG9GFvPfscFImTVvyd2gwpt0
         nShNnkLwq1jUmZrsmFnu0WtaSBICU2Ar25JsJ7nEB7j3cehFyqRKUBhCi6hOlApXKkbO
         nvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686702737; x=1689294737;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x0FEnHFcVXXwqQT908WZH1fmerFrPYyreU+UANik0g8=;
        b=FlEmIT3BXHRyUIjlokCZQ2ydoTx3WP55Ev6jXXsPJzh7gWY53e0LQAnKLKzGdK9mnl
         KjqLOItMC3dIN0MilU123h4uUhJFjPYfdMzdWlOGbcodpSBkPt6FwNRlrz2UhNQJOvEy
         noPE5cpps5J3GdLF8zPSVs1vuBIlhK+9OKC6BuiY41kOFs5iwtZ3hiCHkkjHR9S8S94j
         RBI8yp9SezCeVWFWa5cDkjRq1H3fWbmSM1g3VaEhYs8fk86HnHpJcR12rUPJ+lB097Ij
         7iiV0X5jF1waIdLoyDty3tTbBbIvzqDYLFMUMLE9waH9Nv2QYyMwfscj/Nhlv55q0HUT
         vMjg==
X-Gm-Message-State: AC+VfDyAmZdp8KTI5vKyFrktGrR6s/CuJ4xkt1Oc3vIAUBn7v9aCX/F0
        F6tMxarIcwHaVaVdjPzPm20=
X-Google-Smtp-Source: ACHHUZ6qSfjKD96obQOUBYQfHhrnzF+2hTb7IjbHcKxcVXNtmmnB4Zc7GQYBhzixYZKZtH87sZmXPA==
X-Received: by 2002:a17:90b:4b0b:b0:25c:2a59:fb2d with SMTP id lx11-20020a17090b4b0b00b0025c2a59fb2dmr134286pjb.8.1686702737561;
        Tue, 13 Jun 2023 17:32:17 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id 28-20020a17090a191c00b0025bfdc93d73sm3212808pjg.14.2023.06.13.17.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 17:32:17 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 10/16] refs/packed-backend.c: add trace2 counters for
 jump list
References: <cover.1683581621.git.me@ttaylorr.com>
        <cover.1686134440.git.me@ttaylorr.com>
        <3c045076a95fab9d050a312114c9aca712eb7141.1686134440.git.me@ttaylorr.com>
Date:   Tue, 13 Jun 2023 17:32:16 -0700
In-Reply-To: <3c045076a95fab9d050a312114c9aca712eb7141.1686134440.git.me@ttaylorr.com>
        (Taylor Blau's message of "Wed, 7 Jun 2023 06:41:42 -0400")
Message-ID: <xmqqttva28a7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> +assert_jumps () {
> +	local nr="$1"
> +	local trace="$2"
> +
> +	grep -q "name:jumps_made value:$nr" $trace
> +}

You may expect 1 hit and the test will pass if trace had 10 or 12 hits.

