Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34421C7618E
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 11:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240460AbjDZLlO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 07:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239947AbjDZLlN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 07:41:13 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EA549C9
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 04:40:47 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-18b10923c98so4898287fac.0
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 04:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682509246; x=1685101246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhS33Jb/JkvJRuOQkZRchWL0cjOPFBTGvFI1/VC5mrg=;
        b=VKt+vM5RUlET0h56AB+Yq9gq4fZwx2axIxX8SFWj3gMAzr1mHN891n7Gky95n5iHXG
         5LaGJwInvOH2XSAj+flV86r1K6WQVVIUM3oOafTLTeT+G9I+kSVVBFVWNYmEHf9aLhFO
         pt6DQsx/z5j3do8JjutWPdWOyv9Xjf6/krmd60ZlpDWXq4ZbydRKM1G92kXxqDEgSgkq
         h0t/mxMI/eDMTMaNNE59+wdH9DEzSZxtvh+0AstB2ItR3ltms6xkayIeUCBE0XKJtvUi
         dFBbqsYFn1ZUvDsFPBORJPy+UNFu6p9QivXyo6TJAP4F4S1UniFXxb6cVszTgmmJr543
         US0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682509246; x=1685101246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GhS33Jb/JkvJRuOQkZRchWL0cjOPFBTGvFI1/VC5mrg=;
        b=hVz90E/Gy9JHnZKjCK9VkLQEeF7SNax2rgwQ+5pDvXgBzrmgPICB41kAe9nmOXYjx4
         6AQs0D/FWfJll/aLYJ2A5wYVO6i7IGWGqRUG9GuKWEyhzRKlYZnsSldCbQUbXIz726bp
         DCBK8yQUGnrNDxZ/61WR9t1zOXG1igbR9AvmbtPjqSPXUgz8dGbG4re/Fw19ZbGYWuxh
         7Q+wqurd5fFNJwvBsrJICfyKluue1U3fGuvqXa3wDGv+3jtu/OsJLhDJSxzHQ5yiclDa
         SrIentdl1SrxrS7Uu9XN1CO5MO2rl9UojIn3nwt9Z8iuFEpfUrdI2eao/7gupeQ1eDRV
         kwXg==
X-Gm-Message-State: AAQBX9dPucV7By0SXTTAOZOQmvIIVKT/tBEJZ6kIBHopuYgsVUFbdeHl
        2h1UJH/0RdE5XcMfZDZf0YAhRmDDWbHoMryEAKUAtw==
X-Google-Smtp-Source: AKy350Z6ijXKy0QwzwvOHh5pocHxaSElYQAXS1uRNn+jKn6Nhvj1hzUhnyMSZKOSIJYgj1Db9xgbMNeEVYhPdakL1Ho=
X-Received: by 2002:a05:6870:2046:b0:187:8537:e43e with SMTP id
 l6-20020a056870204600b001878537e43emr12039459oad.2.1682509246785; Wed, 26 Apr
 2023 04:40:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230424022318.80469-1-hanxin.hx@bytedance.com>
 <cover.1682473718.git.hanxin.hx@bytedance.com> <935be72eb92cd2eda7aff43c8cc2306b78b2a146.1682473718.git.hanxin.hx@bytedance.com>
 <bf45bfe7-4a29-38d6-b8d7-811581aec82b@github.com>
In-Reply-To: <bf45bfe7-4a29-38d6-b8d7-811581aec82b@github.com>
From:   Han Xin <hanxin.hx@bytedance.com>
Date:   Wed, 26 Apr 2023 19:40:35 +0800
Message-ID: <CAKgqsWV==tgyz8EOs61_06+bX4Eq+0Su1bocZ+-s4oe+e0DdJA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 1/2] negotiator/default: avoid stack overflow
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, xingxin.xx@bytedance.com,
        jonathantanmy@google.com, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 26, 2023 at 7:13=E2=80=AFPM Derrick Stolee <derrickstolee@githu=
b.com> wrote:
>
> On 4/26/2023 12:05 AM, Han Xin wrote:
> > mark_common() in negotiator/default.c may overflow the stack due to
> > recursive function calls. Avoid this by instead recursing using a
> > heap-allocated data structure.
> >
> > This is the same case as [1].
> >
> > 1. 4654134976f (negotiator/skipping: avoid stack overflow, 2022-10-25)
>
> We would typically write this inline, such as:
>
>   This is the same case as 4654134976f (negotiator/skipping: avoid
>   stack overflow, 2022-10-25)
>

Make sense.

Thanks
-Han Xin
