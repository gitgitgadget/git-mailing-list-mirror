Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02B2C6FD1B
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 17:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjCGRVi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 12:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjCGRVL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 12:21:11 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD399964D
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 09:16:20 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id m20-20020a17090ab79400b00239d8e182efso17197473pjr.5
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 09:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678209380;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iIYtLlHoKq+TVRyysPZN3B7GOcaUlSAqRdsTo0KhMTA=;
        b=P86+bd48/5FW3+HZym3Ez19jSPkYgmE9PRohCx9U9uK0TGeOhcll5gG7ORYu6/QT9Z
         iqilutegIpzLMpXVSYtNsOQeGk+e1XDCa7KlONsm8+dwaue25pX1oLW+mn8CtQd0ShMH
         Mn5UPw6zp5f07zKAPgRvd4oYnwf1Yx4V+ZhpflSgJhLt+K+3Ah0gBG34MSyUsRTt1N+M
         o+MtD6HRJO31os6sUvHQNUFOqZ0aJslHxPdokxA/Aq2XRwHNb/WOARMxd6NyWrXKMvZz
         CYuzPgZS7aSVEMP9GrpAbofsTcwpb8N1m6r6Hd50a49iuGg3GT0UuKuRv8i+NG/Yh7LQ
         S04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678209380;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iIYtLlHoKq+TVRyysPZN3B7GOcaUlSAqRdsTo0KhMTA=;
        b=ZlFJ7LUg2nqIPbd2T9eoIkiuFwMGlSq8w8DnynZMSBiG6cP1Wc/V5a61hptc0chIy0
         CFe17ZjHytprXzkpIyiabCAawdBPQpwWZdbtUf/YAIzXFgmewqeBXxFhJuujVdyouoh/
         gWXlRwdvuD7Uu86tQE6OEubPDD0EhLwOfnr1KoOhRtH3xYa7GdYqcR5Y2sfwm6+BGbTN
         Udt26mstirYGf2YownOdcvWA/QaGDu2XJFt7w8C/7YyFJX+5tLeBQQqBHiSsW9yVGh2i
         kHHACKIxuWcbgij1XnHraxXW3th+w6rNuty17vjoNjAPgFQIeUFOq5yt5jBNeUWLeToX
         9g0g==
X-Gm-Message-State: AO0yUKU3HFbEjyxPCRYbKp/pT69xrFeWryJx76Z84W1p/MUePu/CdFxv
        s75wIYl53NtjdoKrJvnlUA4=
X-Google-Smtp-Source: AK7set8wcRkqUnMDkGjETrloI/3UAXC7/9TzwmCZeBwnZxuwnA2cw7IdD9o5noAz6Km0m1EAhI5GaA==
X-Received: by 2002:a17:902:e5c2:b0:19e:7d67:84e6 with SMTP id u2-20020a170902e5c200b0019e7d6784e6mr20009873plf.0.1678209379869;
        Tue, 07 Mar 2023 09:16:19 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902ec8f00b001994554099esm8630714plg.173.2023.03.07.09.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 09:16:19 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] object-file: reprepare alternates when necessary
References: <pull.1490.git.1678136369387.gitgitgadget@gmail.com>
        <xmqqy1o97apj.fsf@gitster.g> <ZAaFQJm6UGYH4YIi@nand.local>
        <901299ac-e543-b7e5-0a1a-c90e667a947d@github.com>
Date:   Tue, 07 Mar 2023 09:16:18 -0800
In-Reply-To: <901299ac-e543-b7e5-0a1a-c90e667a947d@github.com> (Derrick
        Stolee's message of "Tue, 7 Mar 2023 09:52:19 -0500")
Message-ID: <xmqq4jqw32jh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> The prepare_alt_odb() call only _adds_ to the linked odb list.

Ah, thanks.  That was what I missed and led to the question.
