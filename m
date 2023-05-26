Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD35C77B7A
	for <git@archiver.kernel.org>; Fri, 26 May 2023 04:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241979AbjEZEwq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 May 2023 00:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241981AbjEZEwo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2023 00:52:44 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D3E199
        for <git@vger.kernel.org>; Thu, 25 May 2023 21:52:42 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64d2e8a842cso412433b3a.3
        for <git@vger.kernel.org>; Thu, 25 May 2023 21:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685076762; x=1687668762;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xGpHyr0SaswKkXP9oO3vUIYLW0YA+wYMZkydird2rV8=;
        b=rAJqYxXNjC9ZwkcZyn7TsrPIqX3GQfBu3i16lVvMtZ14kkwG+kfj/fUEYsOJPTHN5E
         Ek/h4i9ZNH+C4rgqggDe5KX1CwXWLRvV5KEHeOqQ8EsSlmZVLZOpxBFeVOzfqtesSiJU
         MlmM8c03z/TPasSL6Wv1UfFkTYVrZc2AaLWzAPpZRplRZGpMKqDhcV3J5HSiZD4KVkaX
         fNfb/UvsWNWju7k/hUxCJ3DIy/UR0WRoi0XCKq4YAvbdQ0dwVGL1OJbeauVX37wsglvD
         osSGSF3ENFfnfMbubnYIvjdaVB+Z8I8tUedebbAZOBlow6aUC8yN3rCF46BL9CGGECVt
         tFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685076762; x=1687668762;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xGpHyr0SaswKkXP9oO3vUIYLW0YA+wYMZkydird2rV8=;
        b=R4hscp8FXXcYdRzCfXTnSFuFcMlQPxDyIjxYe8exUbwuTS9fiB2DTF506lKq5/YP9m
         7Fng/BaktNjlvvoOHtCdjHtptpjeUpeUPcgCQK6RsNXL/MV4nOZsuAvlRipC11NK9DMi
         NaXyqE8CIiMJcyfc17vDvTEwkQwHlYMQB1YExUw/EqCYVcNi8e8F15KC5kKAxWIbw5DS
         vRwXEk8/a+PXN48Ynsk7NU6uBJuRD8Vu7UGLeEzf9CovpMKKdsMBaXyQIeEWWcRAnHy2
         pvHjoQKtpF/IeTrcdJzRqzfTkT1xPo4yvT45GqLPoBhC9gdEc0crS2KYJ3zspRFhCsOd
         DOEQ==
X-Gm-Message-State: AC+VfDzDCR+DPVTujGJsRR0LgE5V4icuRlyAczUfMDjzL5OG9a176+D9
        qVQ1FCK4hnNzTRqxcUee2Mc=
X-Google-Smtp-Source: ACHHUZ6KOoRu3zJoiDLO9W7C0nQ2s85jGQWFfDB9eysgC01m+hX4WvjwZHVMJBjmizdL3w09Eb9iiA==
X-Received: by 2002:a05:6a20:244f:b0:10b:5347:304 with SMTP id t15-20020a056a20244f00b0010b53470304mr962717pzc.7.1685076762138;
        Thu, 25 May 2023 21:52:42 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902ce8c00b0019aaab3f9d7sm2233118plg.113.2023.05.25.21.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 21:52:41 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        "Randall S . Becker" <randall.becker@nexbridge.ca>
Subject: Re: [PATCH] trace2 tests: fix PTHREADS prereq
References: <20230525031218.3554586-1-tmz@pobox.com>
Date:   Fri, 26 May 2023 13:52:41 +0900
In-Reply-To: <20230525031218.3554586-1-tmz@pobox.com> (Todd Zullinger's
        message of "Wed, 24 May 2023 23:12:07 -0400")
Message-ID: <xmqqo7m7elt2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> The prereq guard added in 14903c8e92 (trace2 tests: guard pthread test
> with "PTHREAD", 2022-11-24) lacks the S in PTHREADS, causing it to never
> be satisfied.  Fix the spelling of the prereq.

Nice spootting.  Thanks.
