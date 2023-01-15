Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE0EC6379F
	for <git@archiver.kernel.org>; Sun, 15 Jan 2023 03:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjAODJU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 22:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjAODJT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 22:09:19 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E29A263
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 19:09:18 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id m12-20020a17090a4d8c00b002295ca9855aso1308271pjh.2
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 19:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hYulyC5K1h20j8v3PCboUfwwWpJXiYf4L/gdtBeQm88=;
        b=EhRn/Zvh4VTndXyeZCAMrjxutCUneK9JTRtIlCN6bIE7Lx1tdDG2GsdB/hYNsOji5f
         5uBqNj8q889VeLElobVvR02gdf/5p22LIj6dj1WGegT6/XJHVDF2X2lLLErEMaAOZBie
         tMcnHleJO9j6X1nWQEjH/LQT52guQOqfyMqE0cDz0vS2UPC8XKqah4OrMy5NLYgzK1WL
         4dagZqqs70yrOkJ0iTMjI57N+QH+1gZcuO3jSdrIWfcza8+4dqgqMPNAbpErcqrGoaxl
         gbdC0gpTgPzr7y98J+8vhlp3fykvaSU5jw/gXrSFY2bOoUKGFSqjmiMKYe8oWDqW2zH1
         oJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hYulyC5K1h20j8v3PCboUfwwWpJXiYf4L/gdtBeQm88=;
        b=Rk5RPzd8uWv3KK5bwLCVhxTQShQTVvhht6goNVflSZUtiXvehK8m8oAp84c2QD9JEt
         QV+zmcB8XWHlfbhR2ih4JuYEkZjRt6B1BUpfBcShOM8C4gaems0cRMXlYxRMQyIM93r6
         veo3nbVzkGbgJMQTQJHWws0GEO2oI8WeMNUykW1A8i7XvgUKJii3taQovhnksM2c5Yh6
         7BWSEUY0OM5B0ZGY0kFXvRzCp7VMUI3SYZd6IiAzsjMbHecqrlHlBhdVL9fGq0eTdjnp
         1S+R4agQesrsLgG/U8pHOKQXfYCbKh2m7jh1jXXlUN/hE9vDl5+04sxnZqY2nRIXBuWE
         bN9g==
X-Gm-Message-State: AFqh2kpsmhkVWrbftL+3W7U/GiEBcf1yCV7gZTxQ8YEvnpp62wDcIRud
        BhLq5nImMBv40/NMSfac0So=
X-Google-Smtp-Source: AMrXdXvRDgRIY+LjRfFkUvYgBdcAFg7E69O6zHuzkzRVrPHgKrjpT40JLV9KRbs1YhbTctv3LOLjfQ==
X-Received: by 2002:a17:902:7205:b0:194:62d9:129e with SMTP id ba5-20020a170902720500b0019462d9129emr10683944plb.22.1673752157674;
        Sat, 14 Jan 2023 19:09:17 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d17-20020a170902ced100b00168dadc7354sm16654869plg.78.2023.01.14.19.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 19:09:16 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v8 3/4] worktree add: add --orphan flag
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
        <20221104213401.17393-1-jacobabel@nullpo.dev>
        <20221110233137.10414-1-jacobabel@nullpo.dev>
        <20221212014003.20290-1-jacobabel@nullpo.dev>
        <20221220023637.29042-1-jacobabel@nullpo.dev>
        <20221228061539.13740-1-jacobabel@nullpo.dev>
        <20230107045757.30037-1-jacobabel@nullpo.dev>
        <20230109173227.29264-1-jacobabel@nullpo.dev>
        <20230109173227.29264-4-jacobabel@nullpo.dev>
        <e5aadd5d-9b85-4dc9-e9f7-117892b4b283@dunelm.org.uk>
        <20230114224715.ewec6sz5h3q3iijs@phi>
Date:   Sat, 14 Jan 2023 19:09:16 -0800
In-Reply-To: <20230114224715.ewec6sz5h3q3iijs@phi> (Jacob Abel's message of
        "Sat, 14 Jan 2023 22:47:31 +0000")
Message-ID: <xmqqo7r0ijdv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Abel <jacobabel@nullpo.dev> writes:

>> 	git worktree add --orphan -b topic main
>> 	git worktree add --orphan -B topic main
>
> I am hesitant to add these as they break away from the syntax used in
> `git switch` and `git checkout`.

Not that I care too deeply, but doesn't it introduce end-user
confusion if we try to be compatible with "git checkout --orphan
<branch>", while allowing this to be compatible with the default
choice of the branch name done by "git worktree add"?  "--orphan" in
"git checkout" behaves similar to "-b|-B" in that it always wants a
name, but "git worktree add" wants to make it optional.

By the way "--orphan" in checkout|switch wants to take a name for
itself, e.g.

	git checkout --orphan $name [$commit]
	git checkout -b $name [$commit]
	git checkout -B $name [$commit]

so it is impossible to force their "--orphan" to rename an existing
branch, which is probalby a design mistake we may want to fix.

In any case, as I said, I do not care too deeply which way you guys
decide to go, because I think the whole "orphan" UI is a design
mistake that instills a broken mental model to its users [*].

But let's wait a bit more to see which among

(1) git worktree add [[--orphan] -b $branch] $path
    This allows --orphan to act as a modifier to existing -b,

(2) git worktree add [(--orphan|-b) $branch] $path
    This allows --orphan to be another mode of -b, or

(3) git worktree add [--orphan [$branch]|(-b $branch)] $path
    This allows --orphan to default to $(basename $path)

people prefer.


[Footnote]

* I am not saying that it is wrong or useless to keep an unrelated
  history, especially one that records trees that have no relevance
  to the main history like created with "switch --orphan", in the
  same repository.  Allowing "git switch --orphan" to create such a
  separate history in the same repository blurs the distinction.  It
  would help newbies to form the right mental model if they start a
  separate repository that the separate history originates in, and
  pull from it to bootstrap the unrelated history in the local
  repository.
