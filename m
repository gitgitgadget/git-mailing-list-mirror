Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B44C677F1
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 17:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjAMRqa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 12:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjAMRqA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 12:46:00 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5D193C39
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 09:34:28 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id r18so15437560pgr.12
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 09:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BCy/HoFmqzS4ibei9ugK1Hml0y/t8n6LX6QaXKZ6ql4=;
        b=C1t9YoLvOvRbezzG3zB5AkRdmEgalFBS42QJVAjSGAlQwsuV8/Hx8UzyxNn2KP3OaA
         jT0rlic4fVkg2gma0UfCLVsJUxvEYXCaryOU9coEeC0PHzaRBMRUJSRLtvA1CJMr9KDi
         LVFQ0NNUbKRajdZZ9vw42eWV7464TYNcpYBSzzXoU90XVe0lkR2/xju+AFfajfA634JR
         uDtUClbf7MTxhSVWNs4Wunv7GAE/vZvJsQ8yLZURZLWI9qx1Tr1nxrgQ8gFhFxGlQxou
         n4O5cyFmDgDO5HgHw7uf/yhNlSreu6zTcmLdNN9tpp1EXp6db31iT9NOnnrvoD8bjnPV
         0hoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BCy/HoFmqzS4ibei9ugK1Hml0y/t8n6LX6QaXKZ6ql4=;
        b=sfwwURiZTy8UyEIaTB8Ug6qeMNyDEYC210VF1MTSAvYFpDJTsUUVLiFb7fLIb0ufhH
         phRGsVc0PZFXjrKERIJNdOTVK8M9aqaqHaMracMEPCwy0VIO9Zs6n8TWBSVK0kLsylcj
         fX3gA65HYSvKmXCfIUPW5xgvpvhWc9MkHqBNvdg8xeAaBtYgwJ2EIZCIENa6+fS2sUFS
         fEoBiKPs5vbhJeBh+fuvWy+B+u18xz0aSCFJbXm/U5RnPVadXzaLYGaBMmQQy5nnni/a
         RuRt7tlq4T+Od+ZV7PUaIohC1QOtF0zs/hi154q/QgfOObfa61deHceGSPJka3axO0mp
         Drtg==
X-Gm-Message-State: AFqh2krqASyUSj+pZBMbC0WwuQVJNXseEgqRDH/XWvxRd3BOY2Il85DS
        pcwZBbbWawYlEJ9GE/0eOH0=
X-Google-Smtp-Source: AMrXdXtxtbgX018kb+422ZEZXsTtJ6egw0hzamxEg3MJT6gZPL3httwTfoKGH355rsJUUQtOtV7Adw==
X-Received: by 2002:a05:6a00:4149:b0:576:5a71:454a with SMTP id bv9-20020a056a00414900b005765a71454amr11963292pfb.2.1673631267573;
        Fri, 13 Jan 2023 09:34:27 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id a7-20020aa795a7000000b00575d1ba0ecfsm4361338pfk.133.2023.01.13.09.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 09:34:27 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jacob Abel <jacobabel@nullpo.dev>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v8 0/4] worktree: Support `--orphan` when creating new
 worktrees
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
        <20221104213401.17393-1-jacobabel@nullpo.dev>
        <20221110233137.10414-1-jacobabel@nullpo.dev>
        <20221212014003.20290-1-jacobabel@nullpo.dev>
        <20221220023637.29042-1-jacobabel@nullpo.dev>
        <20221228061539.13740-1-jacobabel@nullpo.dev>
        <20230107045757.30037-1-jacobabel@nullpo.dev>
        <20230109173227.29264-1-jacobabel@nullpo.dev>
        <230109.86eds31plo.gmgdl@evledraar.gmail.com>
Date:   Fri, 13 Jan 2023 09:34:27 -0800
In-Reply-To: <230109.86eds31plo.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 09 Jan 2023 20:20:28 +0100")
Message-ID: <xmqqwn5q49uk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> I've looked this & previous iterations over carefully, and this now
> looks good to me. Thanks for sticking with this so long.
>
> For what it's worth (if Junio would like to add it):
>
> Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Thanks, but Phillip's point of -B/-b deserves consideration, I would
say.  It seems that the required change is just a syntax sugar
without having to change anything deeper?
