Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0C1C433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391615AbiDUS6C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391668AbiDUS56 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:57:58 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579F427E
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:54:52 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id e30so4162490eda.0
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=4xi69AGKeq2Bbq9NCZk1NJYf+MlMZJy3R0OqVKLd+cA=;
        b=fbeZ0GcHty9+pOUnr1gq2vufqv+d++c+x52+aYe/KjI1Uz2fM/z7K0OYOAN9J75zHX
         /lXxpIwhWqC9ELE747tEjFw9KI/wZz2H1BtkIl+m2tVCRLUFiiI+2lr9Ey8z6su96KMb
         h81lGHMz0Thdul/GXIjHjAfRxOWSPUcJu02Yae7L3J5sZUyzZTE78pXRL72QgVt86xhs
         GvFw06+DvCW+a/cn3sLxWjRY2zc+7J5NjXl9Kl5t/HVbFD6HS7n0Dhchdt6xTXwTStzX
         b44HnLi1e0yT6Te0Obyd3rn7zETDw9o37A4nB/9ROVDcypEOn+LH77ojUQELqbqUYHgK
         2Qqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=4xi69AGKeq2Bbq9NCZk1NJYf+MlMZJy3R0OqVKLd+cA=;
        b=Z3phQv+N9jEExa8riFHGMcGBoai5O1egf0rcaeXNSCg8/V9OzapbUoTp6RIMm3Bvn+
         pc8YLEDOq6BHrOyAfmHncxepXFE77NC1JEQ9Bppc3K1jfpYfz+6LcxTKBvws/81ZR5Yl
         YDVQyxY2Cn8/fohnnY35ceSwOZHxJhXYMIh3JaFhR2O8Nxkyet2fRmuggv1Ame8gf7qR
         VazaYVpvwmx0CKbjETjhGJA8g5tfix2jeBfSyxUgs++U6DB90tIjsubZhWAvW+7f0LtE
         qh/6dQtMB+a16z1ZC2uuibCDh6FVnl40VigmY6hc0vGpxxHM4pCe6WaQQceepQlaTOlg
         va3A==
X-Gm-Message-State: AOAM531znQ3xBq9TBX6iTJWutYHwk7U4H58eq9zvel5+Kty0+go6zKX4
        3Sb+LKRFySss5DNXps4QiSaOFehrjMze1A==
X-Google-Smtp-Source: ABdhPJxcsHeLJjRhZfW7IMZd+pzgJiKnQMRmctXjxA5QoHaoYAndY5VjUGj5XG4pJOSporB5VVq/nA==
X-Received: by 2002:a50:c014:0:b0:41d:5ee9:f354 with SMTP id r20-20020a50c014000000b0041d5ee9f354mr971576edb.257.1650567290518;
        Thu, 21 Apr 2022 11:54:50 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v7-20020a50d087000000b00424269f1c75sm2321551edd.96.2022.04.21.11.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:54:49 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nhbx3-0088yL-DH;
        Thu, 21 Apr 2022 20:54:49 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 0/6] hook API: connect hooks to the TTY again, fixes a
 v2.36.0 regression
Date:   Thu, 21 Apr 2022 20:50:25 +0200
References: <CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com>
 <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com>
 <xmqqmtgejq4o.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqmtgejq4o.fsf@gitster.g>
Message-ID: <220421.86bkwu6zd2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 21 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> This fixes the regression reported by Anthony Sottile[1] with hooks
>> not being connected to a TTY. See 6/6 for details.
>
> It is surprising that it takes 6 patches that rewrites ~100 lines
> and adds ~200 new lines, which would need to be treated as a new
> development with its own risk of regressions (hence going through
> the normal review cycle, starting out of 'next', and gradually
> getting merged down), instead of being able to be fast-tracked.

Yes, it's unfortunate. Perhaps there's some way I'm missing in coming up
with a smaller isolated fix, but I wasn't able to come up with one.

It's not just the pre-commit hook, that's just where the problem was
discovered, but the dozen or so other run_hook*() users (not all of whom
may be practically impacted).

Rewriting the hook.c API to use another "runner" would probably be the
smallest change, but even if that's going to be smaller by line-count
I'd think it's much bigger in terms of review time. Most of this series
is boilerplate changes, or changes where it's easy to review that no
caller of run-command.[ch] that isn't hook.c will be impacted by them...
