Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D46C77B7D
	for <git@archiver.kernel.org>; Wed, 10 May 2023 21:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236051AbjEJVjc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 17:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235455AbjEJVj3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 17:39:29 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E663C33
        for <git@vger.kernel.org>; Wed, 10 May 2023 14:39:25 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6ab094a7c04so1616839a34.3
        for <git@vger.kernel.org>; Wed, 10 May 2023 14:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683754765; x=1686346765;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3c+z2JxgmuNM7nTzQb9hFh3+4DJMwVTu07crkoHKIY=;
        b=OYBLnndKMt4Ev4BOGGjFmuaRvAhuXkiWSrcZAHr+ZfElhKEs3+8d5wx5GxDQUVtop4
         gEJFx3i1BTEgzlLsJctmuP+G6LspPO4yQY4B8lGkt/aQUsYaFRuVmGHTUtPgQEjCZQIO
         fx2QJwNj8HTkt3LfR04kzfo3tNPnCnZoQDaDUM+2qeUgqq03jindPb1ofAVmDn43GKiK
         xoiezwenZEwg5r6ulOA6Uj7X4mLAlCXt12jyClEaxipurtbOjCnNnldyWxW7B9yZb0fr
         ZAF2JQpJvEllr3esqlKPpevuVy4Cs2rYz/uhTnABTzUQm5mnkY4aceuqDhtpF/OA/8s2
         9gQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683754765; x=1686346765;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D3c+z2JxgmuNM7nTzQb9hFh3+4DJMwVTu07crkoHKIY=;
        b=E4h4zzj4TSwDkB9kvEqH9bMBlwL1Bo5Ua33wj76mqEKS7ogJza16BcHq1dIua2GhIF
         N4Dcc7mAltWq4lYRsYWq9rC3IQ+dvHB1TjKwnO/d+S6AKDqaRsWgTGOL4GY03LBYaLWe
         g2/oDVh8LsnkIyvVb+KUxWDaQuuNLzWhSnm1H4o6SYnKYI/DPetTUxu6KusoL5ZIn4Ep
         mY0uigUqTw+GXS7ye0gzXLzYG0uOsdovB05jImKLw99yfASIQG8/cFqJbrlqpIfHAKeu
         wHKamFNzpp8c7i8O0yAl+NN2VIa3kPguiocU3he4MZ/NKuYWm5FDKRaeLgpGJOK52v7c
         VEkw==
X-Gm-Message-State: AC+VfDx/iWos8TRfYxL90v83NyMVRnO82AOaICkuBVdHRm3FmM4JbKMG
        exasbaXyv8WpJBKixfgsCUQi61OGXS4=
X-Google-Smtp-Source: ACHHUZ5MU2uhDiHnO2ASycJfZcmYFfwB85VqO3F2iteCFXsT4RCiXb02GW2WY7+TUFkR6SYhG94v/g==
X-Received: by 2002:a9d:6396:0:b0:6a5:f792:dbe5 with SMTP id w22-20020a9d6396000000b006a5f792dbe5mr3848698otk.22.1683754764861;
        Wed, 10 May 2023 14:39:24 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id n17-20020a9d7411000000b006ab0981ef17sm3225349otk.64.2023.05.10.14.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 14:39:24 -0700 (PDT)
Date:   Wed, 10 May 2023 15:39:23 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <645c0f0b9ba51_7b63e2943@chronos.notmuch>
In-Reply-To: <87wn1ggv8s.fsf@osv.gnss.ru>
References: <20230503134118.73504-1-sorganov@gmail.com>
 <xmqqsfcdtkt0.fsf@gitster.g>
 <xmqq1qjwj7go.fsf@gitster.g>
 <64599cc234708_7c6829426@chronos.notmuch>
 <87wn1ggv8s.fsf@osv.gnss.ru>
Subject: Re: [PATCH] t4013: add expected failure for "log --patch --no-patch"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Junio C Hamano wrote:
> >> Junio C Hamano <gitster@pobox.com> writes:
> >> > Sergey Organov <sorganov@gmail.com> writes:
> >> >
> >> >> --patch followed by --no-patch is to be a no-op according to the "git
> >> >> log" manual page.
> >> >
> >> > I briefly wondered if it is a bug in the documentation.
> >> > ... when "git log -p --raw" shows both patch and raw, I do not
> >> > think of a reason why "git log -p --raw --no-patch" should not
> >> > behave similarly.
> >> 
> >> So, to tie the loose ends, "log -p --raw --no-patch" and "log -p
> >> --stat --no-patch" do behave similarly.  Where my reaction was
> >> mistaken was that I did not read the manual page myself that clearly
> >> said it is the same as "-s" that suppresses diff output (where "diff
> >> output" is not limited to "patch"---diffstat is also output of "diff"),
> >> and incorrectly thought that "--no-patch" would countermand only
> >> "--patch" and nothing else.
> >
> > If Sergey, you, and me all agreed on what `--no-patch` should do
> > (without reading the manpage), isn't that an indication that that is the
> > expected behavior?
> >
> > The fact that the documentation documents some unexpected behavior,
> > doesn't mean it isn't a bug.
> >
> > I would say it's a documented bug.
> 
> Yep, it is. Chances are this will end-up in the "won't fix" category
> though, similar to unfortunate '-m'.

Probably.

> In which case I think it's better to explicitly mark it in the documentation
> as such: won't fix.

Agreed.

-- 
Felipe Contreras
