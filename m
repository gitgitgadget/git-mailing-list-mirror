Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360F4C07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 08:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17D46613AF
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 08:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238389AbhGNIQl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 04:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbhGNIQk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 04:16:40 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC65C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 01:13:49 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 37so1660600pgq.0
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 01:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BTBNq3aKysblLIsAmjRySL2QKJwB6Z/h+4wSELY/bUQ=;
        b=qBhrB9t/fUxMuYlYl/DTxu3Se2hbnsAI6+/15I4PlnkMSEIwpPWqASFEJosgH2Kfyz
         fc6IDo0qYGfV/a/v6QOMo1l0jmNu+k+ZD1FhhxoYFH4NhVa6b7L7heKhFRLf0q80KJyi
         +UoK3gtrZggCaFZG76E1/uz9XxoIfw9ffa8l5hMABwiGxNeCIMey2wjJiYxOqtYdLQ25
         SjhPUjbIt1dhTsukT+vvURrK2vMVxUZlV2vVm1a88e/jRDiikxZhFlk06kMw22DDZqov
         9mLQ9xOvoYiIryQRDEnAqbt/roH2u90rfBiQ8n482QADhjGHkHLdebJvXvCPGMIKQBqb
         frDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BTBNq3aKysblLIsAmjRySL2QKJwB6Z/h+4wSELY/bUQ=;
        b=sO5YP874oVQnwPzkAuHWllt1gU64KHhq11X9CWFAQYvrZqveehDTnQpfg4G8LvtHUI
         4pqhgzm3cOCCW2W1jmvWwnxUlQEzjEYGwPcsDrJ3ljabNYfGbILEcgVKAVXgSMxYMwuj
         +mucIvwNq7N7mDjOm+SrRf1sshv7NN94fs+ulf3kkO+4HVACUwguIIntfRQNIhvLDOmG
         lZv0Utk9Q0t0fYzhaUN5i358bmwGEyX5jnsfKSNQ7SXQOTstH/kjsOKqo0kZBL7dzHfH
         uKeZUdAJvPs1L2bUvSk2KPE3foYRu2YxjN7K414C7xnpXNUOsrDwiTDvVQsep+SrCDLv
         XQgw==
X-Gm-Message-State: AOAM533tzSxGjNKUCUS61hcd9zjLJ/ADi9tbUx74IBZQKpCnsC6s1RCY
        B/NiKiAqCt9NLSzJd8yp0WNR/+0mf7phvArq/Ao=
X-Google-Smtp-Source: ABdhPJxyOTVvz/q7TCTfT8ZfUJezxWix28D6OdQ3/Rl6IZjmQb5A7B5G0Tf/m7Sx5sTxoQhIJXno4KK4ipwa+8vUnCM=
X-Received: by 2002:a62:830a:0:b029:32b:43a4:10b0 with SMTP id
 h10-20020a62830a0000b029032b43a410b0mr8879167pfe.38.1626250429477; Wed, 14
 Jul 2021 01:13:49 -0700 (PDT)
MIME-Version: 1.0
References: <YOzY+qNFM2GsgKMO@coredump.intra.peff.net> <20210713074018.232372-1-martin.agren@gmail.com>
 <YO1GNWjMol8JV8MR@coredump.intra.peff.net> <xmqqpmvl29ry.fsf@gitster.g>
 <YO4FObgRvpt1nVr0@coredump.intra.peff.net> <xmqqlf6928qv.fsf@gitster.g>
 <CAN0heSqCFVqC9Ncn5r3b4dKOE80byDt_XRM3pnswixX4jFcLFA@mail.gmail.com> <YO4SEp/B4826sc+j@coredump.intra.peff.net>
In-Reply-To: <YO4SEp/B4826sc+j@coredump.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 14 Jul 2021 10:13:38 +0200
Message-ID: <CAN0heSp1eJmeMTq-ECMUVh=hBPRTEkQeU0-3YXvtaDdZtU1sSA@mail.gmail.com>
Subject: Re: [PATCH v2] load_ref_decorations(): fix decoration with tags
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 14 Jul 2021 at 00:22, Jeff King <peff@peff.net> wrote:
>
> On Tue, Jul 13, 2021 at 11:52:53PM +0200, Martin =C3=85gren wrote:
>
> > > Totally forgot about that one; thanks.
> >
> > Do you have any suggestions for how this could be explained better? I
> > waffled on whether to add that paragraph to the commit message and when
> > I finally did, it seems it got a little bit too succinct.
> >
> > I'm about to check out for today. Maybe in the morning I can think of
> > some clarification.
>
> My attempt is below. Most of the new explanation is near the end, but I
> tweaked a few other things.
>
> Your original said:
>
>   The reason this happens is in the loop where we try to peel the tags,
>   we won't necessarily have parsed that first object. If we haven't, its
>   `tag` will be NULL, so nothing will be displayed, and its `tagged`
>   will also be NULL, so we won't peel any further.
>
> and my earlier explanations were not thinking of the "tag" field at all,
> which made me worried there was another subtle bug in not parsing the
> tag earlier. But I don't think so. We don't look at the "tag" field for
> setting the annotation; it always comes from the refname. So the
> paragraph above should not mention "tag" at all.

Thanks for correcting that. The parsed-ness of "obj" affects whether the
decoration is shown at all. I originally concluded that when the
decorations are eventually displayed, it was something like "if ->tag is
non-NULL, display it". But that's obviously not the case. It's more like
"->tagged is NULL, so I have no idea where to place this decoration".

> I also beefed up the test a bit. All this talk of parsing made me want
> to make sure we were covering tags-of-tags correctly (which I think we
> are both before and after the patch). After adding that, the expected
> decoration output was getting quite cluttered. So I tweaked the test to
> make a new commit, give the tags sensible names, and just look at that
> one commit.

> From: Martin =C3=85gren <martin.agren@gmail.com>

At this point, I think it's fair to say that you've done most of the
authoring here. I wouldn't be at all offended if you took the credit for
this patch. It's your code diff, it's your test, and now it's even your
*updated* test, plus half the commit message. :)

Here's that added half of the message:

> The simplest way to do this is to just conditionally parse before the
> loop:
>
>   if (obj->type =3D=3D OBJ_TAG)
>           parse_object(&obj->oid);
>
> But we can observe that our tag-peeling loop needs to peel already, to
> examine recursive tags-of-tags. So instead of introducing a new call to
> parse_object(), we can simply move the parsing higher in the loop:
> instead of parsing the new object before we loop, parse each tag object
> before we look at its "tagged" field.
>
> This has another beneficial side effect: if a tag points at a commit (or
> other non-tag type), we do not bother to parse the commit at all now.
> And we know it is a commit without calling oid_object_info(), because
> parsing the surrounding tag object will have created the correct in-core
> object based on the "type" field of the tag.
>
> Our test coverage for --decorate was obviously not good, since we missed
> this quite-basic regression. The new tests covers an annotated tag
> (showing the fix), but also that we correctly show annotations for
> lightweight tags and double-annotated tag-of-tags.

Very well described.

> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>

If you take authorship of this, I think this could be something like

Reported-by: Martin =C3=85gren <martin.agren@gmail.com>
Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
Reviewed-by: Martin =C3=85gren <martin.agren@gmail.com>

Martin
