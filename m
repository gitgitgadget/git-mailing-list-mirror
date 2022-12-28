Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F9DC4167B
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 12:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiL1MzD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Dec 2022 07:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiL1MzB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2022 07:55:01 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D5BC27
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 04:55:00 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id f3so10527044pgc.2
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 04:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3fSON1hMayndfMvV/ItPawU2Zc6U1g92hvIohPosQ90=;
        b=R/SuMUXI4dXQ4LMPTb/yPgv3pEjR8LqP6XChZMUI8JW+LZyGVGlFxrODzd5K15nynC
         ZYI7ItIORmHFrLNxf3+fZVPYyJVsWfPz6y+z0tdH0y1p5KayaI+RjXjnqMHRyB8ta9d9
         XiLlj4LR4uYihd22hPJxDdDoPdLcrP7PgnF9y4SHQKtr9ny3AK4B8fWjS1IG0QEA2QVn
         kbZrOny5Np8Y+XwYs/ZuM+vdcvFwdlDEndRMaDV2lFJdpzn9rkhxoyuzmo7b5XZZGSEz
         nMWkcauyEjKZd9z8h9R9iq3XmMpRWM4iZV5oySks5ynS+mdoNJIbSkQc5pobVllu/uIB
         OWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3fSON1hMayndfMvV/ItPawU2Zc6U1g92hvIohPosQ90=;
        b=VrJZzZtTggRKpbgi7Qr1nXVIi+uLi0vwyz6irp932hx8k/rGa/b1v+GyVhd/fALCXG
         NCrGJriiHX2euGYdw/shTcafp4LkVucn+LjnoiXaeDEcnY5ev6WDLyK/mj7ztM2dn9C8
         RWahWcsJHTN1bBL1IGtPgwqliswjSL2ICynDk+PuQZ+QgeGM/qMNjG38p9z3feGsoaBB
         VZjIC7qVPFCv8eSZSpeA1sQ89q9qh8/YCIWx/qq9glqrJS00eK3fK7pjeFc1VvdCspYD
         Vqgr9IYVuzi9MJuOhTM56crNRuZze2WhvyJaKQPFwgXrZR2Gs8tG8K2iYCsgu1zhvNKG
         KlTg==
X-Gm-Message-State: AFqh2kq31kZrvKWybuLQ1J4JuIpyFZWY1IqGaaVFUhDOSr1JpxVSw8Ba
        L8ifkR5PfIl2VxM3hdTLGSOA/rAT4iU6Ug==
X-Google-Smtp-Source: AMrXdXtK+2UvtGSAUL9J6zPM1DqjyZsh+GOaxplX4Nc75zNHCt8S+glAXlRWinlh3S7X1BrV+9YV3w==
X-Received: by 2002:a05:6a00:1885:b0:580:9a80:6e37 with SMTP id x5-20020a056a00188500b005809a806e37mr25970365pfh.25.1672232099819;
        Wed, 28 Dec 2022 04:54:59 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id n14-20020a056a00212e00b0056bb4bbfb9bsm10554774pfj.95.2022.12.28.04.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 04:54:59 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v6 2/4] worktree add: refactor opt exclusion tests
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
        <20221104213401.17393-1-jacobabel@nullpo.dev>
        <20221110233137.10414-1-jacobabel@nullpo.dev>
        <20221212014003.20290-1-jacobabel@nullpo.dev>
        <20221220023637.29042-1-jacobabel@nullpo.dev>
        <20221228061539.13740-1-jacobabel@nullpo.dev>
        <20221228061539.13740-3-jacobabel@nullpo.dev>
Date:   Wed, 28 Dec 2022 21:54:59 +0900
In-Reply-To: <20221228061539.13740-3-jacobabel@nullpo.dev> (Jacob Abel's
        message of "Wed, 28 Dec 2022 06:16:57 +0000")
Message-ID: <xmqq5ydvpu1o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Abel <jacobabel@nullpo.dev> writes:

> +# Saves parameter sequence/array as a string so they can be safely stored in a
> +# variable and restored with `eval "set -- $arr"`. Sourced from
> +# https://stackoverflow.com/a/27503158/15064705

Please do not copy from source with unknown licensing terms.

Isn't it sufficient to stringify "$*" and let it later split at $IFS
boundary for the particular purpose of this test anyway?
