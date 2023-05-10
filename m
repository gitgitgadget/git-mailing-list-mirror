Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72111C77B7D
	for <git@archiver.kernel.org>; Wed, 10 May 2023 22:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjEJWc2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 18:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236161AbjEJWc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 18:32:26 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959332114
        for <git@vger.kernel.org>; Wed, 10 May 2023 15:32:25 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64115eef620so53644590b3a.1
        for <git@vger.kernel.org>; Wed, 10 May 2023 15:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683757945; x=1686349945;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hQnVMeyOZoD2utfRavPN8q/g949X5mAW7ju4Vcl3Jdc=;
        b=rHVlIKl+3Abp+U129zns5FRgQuKyWBWSLopfcBL8vjwJQT4mZcQLF9lcVgRVTKw+lJ
         e10wdcnU13BhdneRzfpOS8lU0pl/mszNwr3uCdrEl7F5ec+4+3YEOQxUO/xzPHkHvsi/
         eMk/X/oXllkqoHbv18mAmLuWBd/LDRf11qt5wmxeK+Ct93LScGiEpsZItDLYFHbefpUd
         crHsspDfDbjqz3xyhCs+ZnP0PL2dxpd81qE+t4UsZuRSpxfAEPJg/RrUk4HYu/x2xE/u
         TpjuRoD5H275OyQJcjxqXJm3PvTEks7dVQsDGdRAhRcCIrJBu4Q0qOnTuLkNi6Y55agu
         vgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683757945; x=1686349945;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hQnVMeyOZoD2utfRavPN8q/g949X5mAW7ju4Vcl3Jdc=;
        b=CPxkDvVcGlUeeaHY3wzO0kqTApeBac+oA0bPWAzmmlJQOjhxBiRwhNDTT1yEFY/BcA
         JJtXuW0BD4oEc2U17LC2vVNA/jA5zvSI+M0xpVw/0f11aKD0F2JFUa8QbOymWG769MCN
         r8qE2XgHLT9pNknaKa0Fx83oK7p585Hq91THN2PZSnQCLFx/7eKBBqBtQi8+/Pl2WyYQ
         AS1/jQJR5WG7H1++/4drVymNvHxrQS44O040SLLQeGBPcaCkx8iS0EMa8YBZpyF9pgyk
         hMd/7C6uUNfnBoybbr0+5CvHgwdeb7JwqWiod8lJR60nmTmO6UxKnfCkR3rZnX8SI5l4
         CHmw==
X-Gm-Message-State: AC+VfDy0FBsGWQbW9BXKcHcTVnw4WsACIezlNrGFFQsf1aOpVwJ2dLWU
        kHxySb7k3hDCJa/VcAOScn5rAQP+0Hc=
X-Google-Smtp-Source: ACHHUZ5aJo4zQxdKrP0K8QL4eCcglaXTJHeI6dgbwezU9fOeteovPCMoLuEOYXHJndaz0gTHxXAiBQ==
X-Received: by 2002:a05:6a20:8f25:b0:f2:bb0:4622 with SMTP id b37-20020a056a208f2500b000f20bb04622mr22691633pzk.12.1683757945007;
        Wed, 10 May 2023 15:32:25 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id 20-20020aa79214000000b00640dbbd7830sm4170852pfo.18.2023.05.10.15.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 15:32:24 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, christian.couder@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] merge-tree: load default git config
References: <pull.1530.git.1683745654800.gitgitgadget@gmail.com>
Date:   Wed, 10 May 2023 15:32:24 -0700
In-Reply-To: <pull.1530.git.1683745654800.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Wed, 10 May 2023 19:07:34
        +0000")
Message-ID: <xmqq5y8z3jif.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The fix is simple: load the default Git config in cmd_merge_tree().
> This may also fix other behaviors that are effected by reading default
> config. The only possible downside is a little extra computation time
> spent reading config. The config parsing is placed after basic argument
> parsing so it does not slow down usage errors.

Presumably merge-tree wants to serve a low-level machinery that
gives reliable reproducible result, we may want to keep the
configuration variables we read as narrow as practical.  The
default_config() callback may still be wider than desirable from
that point of view, but I guess that is the most reasonable choice?

Thanks.


