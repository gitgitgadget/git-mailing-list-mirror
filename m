Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5BBC433F5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 21:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76EDA60F14
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 21:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbhJKV5i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 17:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbhJKV5h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 17:57:37 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5C2C061570
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 14:55:36 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id j21so61588378lfe.0
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 14:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lFlJmZYHJ/HUJXs3fm+Z/RMUf1bUOrkdQBrjuFUH6b8=;
        b=Ak3CFMP0qgblFK340Df77iqoDGRHItWVKKtMsvS4YJoah5gegP9+87V6IPpI1v7RfB
         nyJTIDavKukJ8QpEN32KJWSZUyKXC3uha3wv30/IL+F3f9rB38YfUWoKD3J+V8vVM8Gn
         bvMIJv5b899l+S9g5qdTku6aTWTvrsbNKsTlUqXJ+el2dosphLBmmwk0xNU+GQngfeq8
         yMMcdYgi2LE+Sh+NswNyDHut4BOwxgXEssWfiX1ua/qj88aS3ydt1OmmSEExqP6vRuZU
         4osNxzT5erJExeGhNS3Rfs9BKyqkGeFuQHQ9v+tQvaJEqrCZHzLtEJMCxPYfSDzDtq8K
         +39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=lFlJmZYHJ/HUJXs3fm+Z/RMUf1bUOrkdQBrjuFUH6b8=;
        b=xpDQYCIgi0sR+0dJaoaE8wXuLcXccO2L4g+7Yb2kuzQP7KNUP+BaRlx/IkK5Gp96TA
         4bvPpQ7zr9Iql8t8lX+vPbicaZzrHTXyxdmy9en2FrTNy1b/P99b5zqkk+euz94ZNfyG
         w3visPS6qHeWqEBE0yn75aXXK1c2EHYSDoMWyFGNn9sTBimery1p609NU/tT8tgpkNeI
         aEYiS7z/aqKu1ZQ2kQmfiBJhO/ufVS0wJYgV+Q9Bb53c03cU4KEC+D/qOL4HrVJg1quE
         vyxYjntU6xphYmt1LVbD1B0IlPks0VxNSyDD0q36CXTiBwMzwkSRY39bcFBrHjx084et
         Y7jg==
X-Gm-Message-State: AOAM532nZsordb3Ah+22laXdsGoYPfco4DJ2ocAr7oFqGb6JcFkkir4n
        pmXiODqJ95dVsvJWZArUIa/Ok1G1V3E=
X-Google-Smtp-Source: ABdhPJzmxhHgbR6Dlf+llZj5VYByHr5KBfYgXzzqpQqyTd5IeNMUD2o2+0nUUpD5J3qmEOaE+ySrzg==
X-Received: by 2002:a05:6512:b93:: with SMTP id b19mr16790861lfv.443.1633989335008;
        Mon, 11 Oct 2021 14:55:35 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id w1sm842170lfl.16.2021.10.11.14.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 14:55:34 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH RFC v1] stash: implement '--staged' option for 'push'
 and 'save'
References: <875yugcs3l.fsf@osv.gnss.ru> <87lf2zz59w.fsf@osv.gnss.ru>
        <CAPig+cQgZX5U0KThgSKjmgvOvEZWxPF_BovYYe=VfjDvUE5c9Q@mail.gmail.com>
Date:   Tue, 12 Oct 2021 00:55:33 +0300
In-Reply-To: <CAPig+cQgZX5U0KThgSKjmgvOvEZWxPF_BovYYe=VfjDvUE5c9Q@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 11 Oct 2021 17:21:54 -0400")
Message-ID: <87fst7z0oa.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> /On Mon, Oct 11, 2021 at 4:17 PM Sergey Organov <sorganov@gmail.com> wrote:
>> Stash only the changes that are staged.
>>
>> This mode allows to easily stash-out for later reuse some changes
>> unrelated to the current work in progress.
>>
>> Unlike 'stash push --patch', --staged supports using of any tool to
>> select the changes to stash-out, including, but not limited to 'git
>> add --interactive'.
>
> s/using of any/use of any/
> ...or...
> s/using of any/using any/

Will fix, thanks!

>
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>> diff --git a/builtin/stash.c b/builtin/stash.c
>> @@ -1656,6 +1716,8 @@ static int save_stash(int argc, const char **argv, const char *prefix)
>> +               OPT_BOOL('S', "staged", &only_staged,
>> +                        N_("stash in patch mode")),
>>                 OPT_BOOL('p', "patch", &patch_mode,
>>                          N_("stash in patch mode")),
>>                 OPT__QUIET(&quiet, N_("quiet mode")),
>
> Copy/paste error in new help/description string?

Yep.

Thanks,

-- Sergey Organov
