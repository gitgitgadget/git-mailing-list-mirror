Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CA7C7EE2C
	for <git@archiver.kernel.org>; Sat,  3 Jun 2023 01:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236923AbjFCBmb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 21:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235954AbjFCBm3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 21:42:29 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8574E42
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 18:42:28 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-654f8b56807so48571b3a.1
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 18:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685756548; x=1688348548;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4tYXyKpp5T10tflgsMVzX6MrIuAfwRkX9DraaQVMk5c=;
        b=m9d0b9IR87y1PFWevzA10qqhhJMGELbH6kWaShhDM1SqOwvaUiuP97JxVCCt60AgRz
         jFXApDg0vQBDfPh3Xw+EhYxQuLRKssclcd0uScycieWYGm03GXZuOmgfHtk9EQ7jRYYi
         4DMCVNCDhqrwdypKNTKR9m9Wdsr+Vc03uznUY/HbjMhlgxHuKCqEwu20MkuV7jo9KCiR
         yWBoXXowrLxL/aQ9/71THJ6fLGSs4kcLaPAhLUJv2dRRbBPxlbMXUVIburXrfV0tbgy9
         z9inhWhbDzRVT34vDzRfHMj9kL7/6QzYukxksA1O9crBAvp4LygDknJzdXqrV2otuea0
         9eLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685756548; x=1688348548;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4tYXyKpp5T10tflgsMVzX6MrIuAfwRkX9DraaQVMk5c=;
        b=kpM2Jz2+SGkMoVbT+VhoBcpWC0ReyGKwgI0tAKfZHYgO8hS1VlN3FgZEOQsY6JVlJZ
         cU2jWKeq3oJKL+xkQz4tVJKhBAfdapArD2WRDzWBGOR6EAzYevDpu7xtB9rw3pju/PUO
         3wTI0ZND8LcGwjPDxMEB300ZpYIO2lLzSQFZg8JYiN3mH0I0a2Waj9iRI7dlAkFFJ+CU
         g5hB6lKj6M8+xBGVJu/K1kW8pPP+ZuV0EsUJWwr8wKVgOgmzOUvlBX3WjwocHpgIdBql
         JOUkEOftEuOJTKjSXA/BeoN4hATCTCkgidyMTmJDCiIfycgootxAFPju7c7cTbBsvR0I
         kBYQ==
X-Gm-Message-State: AC+VfDzlA/CkvPfn+/at8zr5iNBHG+JWdZiRlh9DEn792TpFmFaHWup1
        YyU5zOgkEQIHcW+r60IJB1Oo+E1Ilx37fA==
X-Google-Smtp-Source: ACHHUZ4O2zBIJgc/y+Ts68BwI7YcluXU6GScoRDpLkdctOr6FHofYhVn/jFKCk3HZmtavrusA0Wrpg==
X-Received: by 2002:aa7:888e:0:b0:64d:2da5:4d2d with SMTP id z14-20020aa7888e000000b0064d2da54d2dmr17369100pfe.25.1685756548282;
        Fri, 02 Jun 2023 18:42:28 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id x7-20020aa793a7000000b006475f831838sm1553436pff.30.2023.06.02.18.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 18:42:27 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH v3 00/15] Introduce new `git replay` command
References: <20230509175347.1714141-1-christian.couder@gmail.com>
        <20230602102533.876905-1-christian.couder@gmail.com>
Date:   Sat, 03 Jun 2023 10:42:27 +0900
In-Reply-To: <20230602102533.876905-1-christian.couder@gmail.com> (Christian
        Couder's message of "Fri, 2 Jun 2023 12:25:18 +0200")
Message-ID: <xmqqr0qt724c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> # Changes between v2 and v3
>
> Thanks to Elijah and Junio for their suggestions on the previous
> version! The very few and minor changes compared to v2 are:
>
> * The patch series was rebased onto master at v2.41.0.

It is good to say this than not to say it, but without "in order to
..." it does not help very much.  I was hoping "by rebasing, we can
avoid unnecessary conflicts with what happened in the upstream in
the meantime, namely, modify-remove conflict of X is now gone" or
something like that.

