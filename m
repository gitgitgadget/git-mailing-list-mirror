Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA7EC2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 22:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23D8F2086A
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 22:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrDAi4sS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388762AbgKXWB6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 17:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388264AbgKXWB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 17:01:57 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70928C0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 14:01:57 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id r17so23924029wrw.1
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 14:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RltnNg7u9mr034YzxoId1lDwuy0uRMNm1q2EfjjGi3E=;
        b=ZrDAi4sSxHK/9WoECLgqm3MVhVGz53TlC/OtPELPgfcsKv88x8kMulFhwnHBgsRPhk
         aorJI5cVjvB9tyTLQbEloWhGQ1Oj03EdwSTe2UQapMR/lxGRqybCa17kk+KDpJzZgZnj
         yhJpSgYvUqE5JsSmjDANcUpWX0SA8zhjW3nWYtLygt4ct6pxsePqEEdsmDjRpXC8Vsws
         NoBzs8Q26LjCajp4duJXPbrQTSMj/npjFLr6PN/Z3qCQUet4XfHBRuiVlOoUx5AM9MJU
         y346qgL3cyVeo/OuVqAb0+nlMtNJhXOwkag/sRIOH8IFCahBUf7rObCbXCu7xvJT7TYb
         EcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RltnNg7u9mr034YzxoId1lDwuy0uRMNm1q2EfjjGi3E=;
        b=dBymM2rceNvYoSVU1DlMRxnTEsOjKICYpyXnKZinXMsVSdP40eYkFT8KTBC1tAhYBl
         bvW/28h2klCOZrTXCvhUOGtHP78Mo/t+uXLnUaUAGzWWGh3J/ER0fumbGvUbqqSchNHN
         ipN2N9uklqVePHPF2DGBg0O8lKO9RCAGvrNiRvsvkv8mUwBItsxekuu/ASJ3tkIdmAfZ
         iZDOq4ofPNjxNHQH8rsp9prmcGgTcszoQFXzeJAZAn0LWx6ImjyfhupdHr12sIp51+w3
         6FRMc2kcrp9AqfDhLeUuVlGtqz3N7mq8WlDWhGHsfGfbubdu+vDX9QKrmmTwjla+4S0t
         JljA==
X-Gm-Message-State: AOAM532eqp+g+Bq1lXqoOH6e1yhkTrxhjRUttu3cx0kHyeefCdG8GQ9h
        Ow2DOjv7Fmfe81lRdsKK09VQ2TldHbbBGMbiQPc=
X-Google-Smtp-Source: ABdhPJyAKToJ923FZtGBFZ12XqWpLlq+f0FERr1WAh2o48MK3nyr1ZYirBIF1XDInUhkJ/X2R6YI6qGtkSR4oSMe9SU=
X-Received: by 2002:a5d:67c2:: with SMTP id n2mr583839wrw.139.1606255316219;
 Tue, 24 Nov 2020 14:01:56 -0800 (PST)
MIME-Version: 1.0
References: <20201122164641.2091160-1-felipe.contreras@gmail.com>
 <X7y5Wxu1eY4k6753@coredump.intra.peff.net> <xmqqlfeqjzi1.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqlfeqjzi1.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 24 Nov 2020 16:01:45 -0600
Message-ID: <CAMP44s0PwJ8qEuCCpavshpm0GqV8p37rF8McR2=gdCk2kj+JiQ@mail.gmail.com>
Subject: Re: [PATCH] refspec: make @ a valid refspec
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git <git@vger.kernel.org>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 24, 2020 at 2:01 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > I wondered if there was a good place to mention this in the refspec
> > documentation, but it may just be an obvious fallout of the "@ is a
> > shortcut for HEAD" definition in gitrevisions(7). The only change is
> > that we're resolving the shortcut sooner so that more code can take
> > advantage of it.
>
> I too find that "@ is a shortcut for HEAD" looks ugly both at the UI
> level and at the implementation level [*1*], but as long as we have
> it, it is good to try to be consistent and allow "@" everywhere
> where one would write "HEAD" in places where it is syntacitically
> infeasible---at least we would be consistently ugly that way ;-).

Beauty is in the eye of the beholder.

I find HEAD to be an eyesore.

> The title of the change may want to be clarified to help readers of
> "git shortlog".  It's not like it is only changing "@" and no other
> variants valid refspec, but it forces readers to make sure that the
> author did not forget to deal with ":@", "src:@", "@:dst", etc.
> "make @ a synonym to HEAD in refspec" or something along the line,
> perhaps.

Right. I didn't notice it changed the semantics of those.

Given that, your suggested title makes more sense.

Cheers.

-- 
Felipe Contreras
