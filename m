Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FF8C27C76
	for <git@archiver.kernel.org>; Sat, 28 Jan 2023 11:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjA1LWu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Jan 2023 06:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjA1LWs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jan 2023 06:22:48 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243F22696
        for <git@vger.kernel.org>; Sat, 28 Jan 2023 03:22:46 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id j5so6987957pjn.5
        for <git@vger.kernel.org>; Sat, 28 Jan 2023 03:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yv+W0llx6SS0BUlliqKQyeP8P0rRGnpHJRogbLa5KJ0=;
        b=MNEllrTFm4bDlkM4mrcKAuu2QV8Oim95BXVdHfzS7Ns5Zwf/EbbS+N+1oH0JOORNAF
         eBSy9gdW64f6s1aCjH7MXpm829bezPZlKgZwYhyuMIilf9qIeYntijbXp6I1HNiQc11/
         jS+yIpPzk7HQwc5exNdNkLDqd2KM+qlrID5BCXr2CeE1fGLMJCpjJ/5IBNtWBwD58ScY
         NuQB1z1LpjAF75Tmb8qMes06mYHiFGUvN6LZN70FlzKsfWYm5obUMEbUrljXb1FH2jKz
         tsQRBe2mq8tRmElu3laS8zDi5V6PUYsoSYY70MAAA7ohypjSQ3AdeS1EJVeoEe6llsIO
         YPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yv+W0llx6SS0BUlliqKQyeP8P0rRGnpHJRogbLa5KJ0=;
        b=ga/a436Ud2XMFpomaQRbYKbOsL8SaZu2QexzSjJBv5dN8hgkBqE4kTG1SZ85UhXmT+
         JFMH+Ps440E0zKFLNZNpD3xJX+WSnCERs9xtP6ogSyJQYLVadzl2TLfIWY177/ctMWAz
         1Kt/tfUNbCoi4/iZFJIFtqQASQvuV4DfTIK68PIaVPXr1wEjxTifeSQvoWym/81c76NU
         IYsmO5SVQ3UZ9bBU9lxqGBeWghPVO+qhmeGIFtTpe0I4Ps7gQpzPW+jsakCyp3sUyNfe
         YZqYtlgTzo6CDoTZ8IQaPok9SGfyoEiFQ5UhV5m1ycqN9yjJv6/zdisek0OwAcnd/ufi
         zGkg==
X-Gm-Message-State: AO0yUKWDtpN67eXM8qdbQR0hQMaq7SYEs6OfPvu2YVWiZomtftJ33WZP
        0J4wgphPhdJXOZt1KdyJNs8pJNE1p/Vjs8Z7
X-Google-Smtp-Source: AK7set9e/L3Pykjrf6P02AsG1KeBfSIY2v7i3YDi9S9nDi0cCliLL7Dm9myG2JmAM6OTpy94g5MMGA==
X-Received: by 2002:a17:90a:4b:b0:219:9973:2746 with SMTP id 11-20020a17090a004b00b0021999732746mr2099242pjb.0.1674904965557;
        Sat, 28 Jan 2023 03:22:45 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.60])
        by smtp.gmail.com with ESMTPSA id t4-20020a17090ad14400b00219220edf0dsm4185789pjw.48.2023.01.28.03.22.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jan 2023 03:22:44 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     sunshine@sunshineco.com
Cc:     avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v4 1/5] notes.c: cleanup 'strbuf_grow' call in 'append_edit'
Date:   Sat, 28 Jan 2023 19:22:38 +0800
Message-Id: <20230128112238.56553-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.39.0.198.ga38d39a4c50
In-Reply-To: <CAPig+cQKJxJCwk1GWtQ=LNNA=z9tQxYUwn9CMcXE4R9g8eKU7A@mail.gmail.com>
References: <CAPig+cQKJxJCwk1GWtQ=LNNA=z9tQxYUwn9CMcXE4R9g8eKU7A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Jan 11, 2023 at 9:48 PM Teng Long <dyroneteng@gmail.com> wrote:
> > Let's cleanup the unnecessary 'strbuf_grow' call in 'append_edit'. This
> > "strbuf_grow(&d.buf, size + 1);" is prepared for insert a blank line if
> > needed, but actually when inserting, "strbuf_insertstr(&d.buf, 0,
> > "\n");" will do the "grow" for us.
> >
> > Signed-off-by: Teng Long <dyroneteng@gmail.com>
> > ---
> > diff --git a/builtin/notes.c b/builtin/notes.c
> > @@ -618,7 +618,6 @@ static int append_edit(int argc, const char **argv, const char *prefix)
> >                 char *prev_buf = read_object_file(note, &type, &size);
> >
> > -               strbuf_grow(&d.buf, size + 1);
> >                 if (d.buf.len && prev_buf && size)
> >                         strbuf_insertstr(&d.buf, 0, "\n");
>
> Indeed, it's not clear why that was there in the first place. Digging
> through history doesn't shed any light on it. It was introduced by
> 2347fae50b (builtin-notes: Add "append" subcommand for appending to
> note objects, 2010-02-13)[1], but there's no explanation as to why it
> was coded that way. Best guess may be that the author originally
> inserted "\n" manually by direct manipulation of the strbuf rather
> than employing a strbuf function, but then switched to strbuf_insert()
> before submitting the series and forgot to remove the now-unnecessary
> strbuf_grow().

Yes, I have the same opinion with you, maybe original idea to savesome array
creation overhead? I'm not sure, but I think the deletion here is OK.

Thanks.
