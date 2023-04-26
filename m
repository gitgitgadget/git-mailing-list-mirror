Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41790C77B60
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 11:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240573AbjDZL4e (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 07:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240143AbjDZL4d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 07:56:33 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316A86583
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 04:56:01 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-18785f07525so2577673fac.3
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 04:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682510160; x=1685102160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iokvUctIiZjFPRTwuz9l5BJGvV5mRHI+nv4VSCRw2oY=;
        b=ZIuAHH4H6ai1pPlgzX2tjF2quArepAJTwB3606a35WCBoRh4SdqkGcYY5U1oTHiFyt
         kw09CyimxEl28W3acGNEhAHUlV33vJjs28sMl9rXIIVkhWVa9RIHXSU0B0U40yGVfPed
         DTMmqYBSN5SzRJrhqy21MRr4F3yF/yuNGQthlRm085y9gSIOHeeHkZdJhAnX6bYQ++jU
         fPResVgkEMJfCChHd5s7HtJlOnnx8c87mhvOeO6cjeadAEuB4xbzDpMW+PjTJ7Cg9ZTv
         ksbPRNqpuCGb/e3JpIjHqtJUEWndok1YiWuzvR3Aka199fjtinxyy/0xwW2pCRobSQ+9
         +4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682510160; x=1685102160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iokvUctIiZjFPRTwuz9l5BJGvV5mRHI+nv4VSCRw2oY=;
        b=GOq5SKVjOJae8gyQXKc0qeb65y8miac1SfGVQBe9eP5Uv5yK4GlcuamHaxaZtF1T9D
         2LJ0GkTjjnmAhHdD5UefIAJL8d469gCDHG/eHe5uWwOKEWtHnqY6ydqA/eKUU0v/lrbL
         VR+Q+g004KIN59VGMKvYN3MbrOJ6FwWGpTTo6tuwqlEuXHTkMqHjhrMRh7q5OXhIlRBM
         qI4meq1ohe8pdVg2WhPSSouOAaFfoOOGu5lvgZhaLvQhXdIIntTkdbSisWWROk0dUr5K
         YTInR5Jpxrs9P0OIJlCsIkYLM+WbXcdjtEOz3uF+yPK6OIOQcHGRzdUBwLT7Xdpvm4fD
         HuCQ==
X-Gm-Message-State: AC+VfDzfq8fRRvn5LFpsdyDVTUMSm2247lM6W5G+ftfzFAb2b5GmYULk
        ZQueqFWbWs36z0TaClrqQzK/H7aSt3RauDU7a+xWBg==
X-Google-Smtp-Source: AKy350bJaEpoYE59RgVhEekARLr7WtGFBYfpkf8T6r22JkVdYxIHxLqvOBEoNONpy9doY1pYexrQ9KDL3LGFq8zF1ho=
X-Received: by 2002:a05:6870:3310:b0:18e:b155:c418 with SMTP id
 x16-20020a056870331000b0018eb155c418mr5235462oae.55.1682510160118; Wed, 26
 Apr 2023 04:56:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230424022318.80469-1-hanxin.hx@bytedance.com>
 <cover.1682473718.git.hanxin.hx@bytedance.com> <abbb1bc0b35d03e13249ec2e5bb8229a0a123685.1682473718.git.hanxin.hx@bytedance.com>
 <41273b5d-f4f8-2dce-94d1-37a9b56ed1ea@github.com>
In-Reply-To: <41273b5d-f4f8-2dce-94d1-37a9b56ed1ea@github.com>
From:   Han Xin <hanxin.hx@bytedance.com>
Date:   Wed, 26 Apr 2023 19:55:49 +0800
Message-ID: <CAKgqsWXU0ZCuQtCPA+O+g-36SkF7w2vsgPxS4iQ7gu5V+XCHhQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 2/2] negotiator/skipping: fix some
 problems in mark_common()
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, xingxin.xx@bytedance.com,
        jonathantanmy@google.com, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 26, 2023 at 7:09=E2=80=AFPM Derrick Stolee <derrickstolee@githu=
b.com> wrote:
>
> On 4/26/2023 12:05 AM, Han Xin wrote:
> > Fixed the following problems:
>
> This might be a good time to reference the change from recursive to
> iterative:
>
>   The mark_common() method in negotiator/skipping.c was converted
>   from recursive to iterative in 4654134976f (negotiator/skipping:
>   avoid stack overflow, 2022-10-25), but there is some more work
>   to do:
>

Make sense.

> >       while ((c =3D prio_queue_get(&queue))) {
> >               struct commit_list *p;
> >               if (c->object.flags & COMMON)
> > -                     return;
> > +                     continue;
> >               c->object.flags |=3D COMMON;
> >               if (!(c->object.flags & POPPED))
> >                       data->non_common_revs--;
> >
> >               if (!c->object.parsed)
> > -                     return;
> > +                     continue;
> >               for (p =3D c->parents; p; p =3D p->next) {
> > -                     if (p->item->object.flags & SEEN)
> > +                     if (p->item->object.flags & SEEN || p->item->obje=
ct.flags & COMMON)
> >                               prio_queue_put(&queue, p->item);
>
> This is the incorrect check for the COMMON bit, because it is
> a positive check (we add the common bit after we pop a commit
> from the queue) _and_ because we could add a commit multiple
> times before it is first popped and that bit is added.
>

Yes, I introduced a silly thing.

> Instead, we need
>
>                         if ((p->item->object.flags & SEEN) &&
>                             !(p->item->object.flags & COMMON)) {
>                                 p->item->object.flags |=3D COMMON;
>                                 prio_queue_put(&queue, p->item);
>                         }
>
> and at the start of the loop we need to add the COMMON bit to
> the starting commit. We also need to remove this bit from the
> main section of the loop:
>
>                 if (c->object.flags & COMMON)
>                         continue;
>                 c->object.flags |=3D COMMON;
>
> because it does nothing if the COMMON bit is added before
> being added to the queue.
>

Make sense.
And with this, we should do return before loop:

                if (seen_commit->object.flags & COMMON)
                        return;

                prio_queue_put(&queue, seen_commit);
                while ((c =3D prio_queue_get(&queue))) {

> I'm very suspicious that this change did not trigger a test
> failure, since the behavior is quite different from the previous
> version. Of course, the recursive-to-iterative change was first
> to change the behavior, so I'm not surprised that it isn't caught
> by tests. What kind of tests can we introduce to harden our
> coverage here?
>

With "p->item->object.flags & COMMON", it takes more meaningless
walking, but doesn't seem to introduce any errors. I haven't found any
good way to avoid similar problems.

Thanks
-Han Xin
