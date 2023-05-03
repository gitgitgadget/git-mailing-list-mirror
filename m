Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B2CC77B7F
	for <git@archiver.kernel.org>; Wed,  3 May 2023 19:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjECTl2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 15:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjECTlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 15:41:25 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446A9768A
        for <git@vger.kernel.org>; Wed,  3 May 2023 12:41:24 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-3ef31924c64so528161cf.1
        for <git@vger.kernel.org>; Wed, 03 May 2023 12:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683142883; x=1685734883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XP6fa5tSF6YygPA0ivxBhpuwn6nlygSL4GI01J3iH0w=;
        b=0HzSBOXkmqWpW1xKGb1C+btaGxXKX0huYKETE2zRV1zU/2tjo2Iyrw6zRxFao35nwl
         cyDcEgwlTfn5mehKAXLQcMld+EAccNgJAFNVUAusX5BEpNG+7Y1PGp9+DpHKxdKC9Z+U
         G+myzbyBqjT/YdCtXQoZcfjtBESub0o/Zpb3gSQfxDu+Lr+czL9AXUAPaAQ7sp2eTzyO
         8OJ/P0m04UTOCRCXA0IZlqyfS32v5D0yI/VCJ8tYGkFMCFRMr8pBqz7qQD5W+UjsoNGX
         z0cho9/EkahikuBNux2PppS0zcSZUJZ8fLT/0FVW1URcHediPajC8E7FxqRt8cLKdREL
         KuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683142883; x=1685734883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XP6fa5tSF6YygPA0ivxBhpuwn6nlygSL4GI01J3iH0w=;
        b=jP3WBh7okCo6jO7P52NZmL2rYJeNjHpKen1/QQJuV+aSRNdnHIyk4bqJX4y8ODWb9D
         1ByL5+zkrszVctvXjnDRXNB9SF2jupCd0qql58zlDIb3KEE3UrDsc1IKade5gUzsS2CB
         lw4864vWFO/xyWCOFh6mCRVDoctD5+LwoI/dIdrErBxVKhLStNNJJV6TEc0tg6CucJyZ
         D1q9snj+5mTuBGI6TOKE4dErw/YjrklUHNNzoIwrnCpzOXeVLT3ct4emdL9a3bB1OOva
         LZxCX2kuirRXGY/t//VrkwMEa3xl9jffyP3/IC2J3VrCWpAQTVj7H/AeDm6AiqznTd4e
         9SkA==
X-Gm-Message-State: AC+VfDw/TR5XAgvglLwvEkb5wasgoAATuElfyQEVkKdJIYUjWRLtXkCQ
        BVwCX90Fmu98dsS18m0QO9Z5nCDx2cwyNA97LO8tUuSZu4Vkr50/rUU=
X-Google-Smtp-Source: ACHHUZ5Y/7LVVvUVQWdu5n2OWeK/YosjktO3issvyV271IzvHXHNSYFj/ZaJ7h4SdFJmKoNEYtc8ZoOpoRpZu6CMNBw=
X-Received: by 2002:a05:622a:107:b0:3ef:3361:75d5 with SMTP id
 u7-20020a05622a010700b003ef336175d5mr48648qtw.11.1683142883244; Wed, 03 May
 2023 12:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230503184849.1809304-1-calvinwan@google.com>
 <20230503185031.1810078-7-calvinwan@google.com> <xmqqednxqkun.fsf@gitster.g>
In-Reply-To: <xmqqednxqkun.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Wed, 3 May 2023 12:41:12 -0700
Message-ID: <CAFySSZDiQe+VRgc3wRk4gTwNxWiF_VmKjOu-UEop+D34+5JUXg@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] strbuf: remove environment variables
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, newren@gmail.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'll reword and reroll just this patch real quick.


On Wed, May 3, 2023 at 12:24=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Calvin Wan <calvinwan@google.com> writes:
>
> > As a library that only interacts with other primitives, strbuf should
> > not directly access environment variables within its
>
> "environment variables" is a misnomer, as there is no getenv()
> removed by this patch.
>
>     strbuf: stop depending on global 'comment_line_char'
>
> or something is what you meant, I think.  This patch is about only
> one single variable, not about many environment variables, right?
>
> > functions. Therefore, add an additional variable to function signatures
>
> These things that are enclosed in a pair of () after the function
> definition are usually called parameters.
>
> > for functions that use an environment variable and refactor callers to
> > pass in the environment variable.
>
> Likewise.
>
> > -                             strbuf_commented_addf(&buf, _(tag_templat=
e), tag, comment_line_char);
> > +                             strbuf_commented_addf(&buf, comment_line_=
char,
> > +                                   _(tag_template), tag,comment_line_c=
har);
>
> Style?
