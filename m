Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61234CCA48A
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 21:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237374AbiGYV2c (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 17:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237383AbiGYV2B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 17:28:01 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75B124F3A
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 14:27:34 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-10d83692d5aso16451868fac.1
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 14:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0Jvbc65tF+mfzq3yDGIPbmtdfFPlDyTuTAKZEW9UcMc=;
        b=aZ+lOqEF5iVKrCyfqtbljEj949v2xug1rIdNQQrAPnlxNvb9THqYOKzBldOjSIenxf
         0JuOpLhCr8m3lVBtw1gDsTBc5Xo12ARhK159s1nSoPYb8ysOks4+BwZCad01mecOfEcu
         kYsBnBFSg2Dr1A/NgJd1DC9JTQMVmFiSTSuamgBVUFYs5VnSdg4uZ5rw2sq6TaBM1eRy
         lTUXDtFlmI6WbVtPZJrLMP/ndrvofEqVGjIBp3HBLFkgvvWO3+uxecjkGrS4iarKTBVt
         tLcDSam/0/CRhKdZV7gLOh4iKMoLLGfJO1Rg9P/f0maiUvfI9VwHkfhpyRtwz2bK76Af
         TCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0Jvbc65tF+mfzq3yDGIPbmtdfFPlDyTuTAKZEW9UcMc=;
        b=1kZGi30jGo+RhKkOQllQ0BuFqsyxZPdIbr9jZZ3rBUWMxIbhS+3XYwraq61W+tZ8Im
         KDQv/mesO0cP+TXyrOjAEIFVz6sHcbeSiE7dXXAVC2afUPqMjLow8rMOEcKgP5ExCzl3
         KPeHu6BjkyQPEnKjgorglF7zzYaOM81S35XFFDyLeuHQQ4XUeo0fDBU5RGwu5xa+XA+N
         EwyEwZIvtPnZKspz9ZIOzCKR11/xq2RWZuYhk5gvOEcy+5A7AyfztNeBdL3IQYlTkRwR
         ef5PI+kBfO3i6BlS8fe+u/rMktI325uuBjM0o+Y9IgiSCOH7xeV2XA6lIGb0PlrlVYtR
         SVAA==
X-Gm-Message-State: AJIora9oWeFau5Scy1bLmzyxBS5byP45Id8fOosVZDwHsYmNgj+ne+jU
        /cGVcf2ngHFGkyYD0yo+P1wENsF5OiNgnFep7BRL3w==
X-Google-Smtp-Source: AGRyM1tfWdCTMe8n1lrX88uQgQEMNGoeqTAFIGSN3ucWPLmwxIOsF6tNmIalQe/Ixmoi/Tt6M430rikxwbpz+9kkEoo=
X-Received: by 2002:a05:6870:c0d2:b0:10d:7752:e02e with SMTP id
 e18-20020a056870c0d200b0010d7752e02emr7255616oad.236.1658784452680; Mon, 25
 Jul 2022 14:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220712231935.2979727-1-calvinwan@google.com>
 <20220718214349.3379328-1-calvinwan@google.com> <220725.86v8rlpdix.gmgdl@evledraar.gmail.com>
In-Reply-To: <220725.86v8rlpdix.gmgdl@evledraar.gmail.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Mon, 25 Jul 2022 14:27:21 -0700
Message-ID: <CAFySSZD+kofhqYmxOnoNi49XSps6z44Ym8=qMBYjwOKJR3Mymw@mail.gmail.com>
Subject: Re: [PATCH v5] submodule merge: update conflict error message
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, chooglen@google.com, gitster@pobox.com,
        newren@gmail.com, levraiphilippeblain@gmail.com,
        Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi =C3=86var,

> Whereas we want this, surely?;
>
>  - one
>    one continued
>  - two
>    two continued
>
> I.e. we're using " - " to mark list items, but then not indenting the
> items.

Yes we surely do!

> I think you can borrow a bit from ba5e8a0eb80 (object-name: make
> ambiguous object output translatable, 2022-01-27) here, i.e.:
>
>  1. Just translate a message like "go to submodule ...\nor update to
>     an", have another variant for the "resolution exists".

I am removing the "resolution exists" variant because the text that
came with it was unclear to begin with.

> per ba5e8a0eb80 you should explain
> any addition of magical formatting like " %s" with a TRANSLATORS
> comment.

ack

>  - A trailing  " " before a \n?

ack

>    It's quite odd to tell a user to run a command with the `` syntax,
>    which is used for interpolation. Let's instead suggest:
>
>         blah blah blah run:
>
>                 git add foo \
>                         bar \ [...]
>                         baz
>
>    I.e. use \ at the end of lines to note a multi-line command, not wrap
>    the whole thing in ``-quotes.

That looks much better than what I currently have.

>  - If a message must always end in a \n just add it between _()'s,
>    instead of making it part of the _() string.

ack
