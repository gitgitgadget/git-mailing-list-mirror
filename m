Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A9BC7EE22
	for <git@archiver.kernel.org>; Thu, 11 May 2023 18:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239008AbjEKSbK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 14:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238620AbjEKSbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 14:31:09 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2164819BE
        for <git@vger.kernel.org>; Thu, 11 May 2023 11:31:08 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f22908a082so7085598e87.1
        for <git@vger.kernel.org>; Thu, 11 May 2023 11:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683829866; x=1686421866;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gHbhEMDrIGd3L5f1YORD2GP04hinTsmC/Crfh2sSAiY=;
        b=LKwDODMHqu4FpnlMd7a+URI+soz/5u50PlurFAKQuxRwEvflnPnzRX7OeYYy0IX27l
         VCAiFMqRUWiHtVXBLTYoP7VOkrv/mzRpqJG+0+yKaqib/W6GMWbjO/JvHPLwYU4UHiNL
         nIh5XTOt2pi5kiST1J3i4HUuFRMM8sqx2PMNvZQngSx5hGZyzrTEkf4t+Z+ek9Obyqfz
         4SCfzB8+rPLsQ591/BAq/JPP0dwkNn9J7bBUICt4+GR9tbtGJ1GNThctPsyunu0Pc4i8
         lnx5KBeGCLjgImv4T2h925rRX/0K9FPBgeeCXWn07bS7cRKbWbnUc9SLgPKz9doyu5nG
         n3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683829866; x=1686421866;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHbhEMDrIGd3L5f1YORD2GP04hinTsmC/Crfh2sSAiY=;
        b=KNba9KGyD7GCNS0FnPgyXDgdTpHnV/7SR5Yg3oN6k+j9By50h+UCWg3+9wYfWdTk5O
         4KTSuwKWfdRaG7qLYPbfpB3fVbIgj0rJbeD0ehIAA9582juuWJJgLNYIqJDjQK/DM5ol
         /pLRohYKFuoZsZodPzXZzH1FPktoR6W/lkD99m6Q1/d0JYHxxrKcG0Gbe6L81WFljcV4
         2EnmjAWlYhtx2DdwzAQaQQ8guvVQa/c9xAXiRLNwCshDYgtKaIUSK6z7gTIaja+/rruD
         HlSN9nhd9gpJ4IqfLlqDqMQj4ghLgaSGrNyQQ2iiyaFttL8DLufKr58F9Hh7OQih6PAm
         6n9g==
X-Gm-Message-State: AC+VfDwBDSAekoRy30mn/ogBn5uzfUThxyUyE1HshyHPj88CsQEqQaHv
        wer30jC0gwT9sDRQoLJqvUt6IZ0x/dE=
X-Google-Smtp-Source: ACHHUZ7gZOPWgXQH1skPA2Gh7QvusXEpDzlFkZNt2ypuv2rJxUi0HqVCwyLycj2Gj0t2cKrOaRNm2Q==
X-Received: by 2002:ac2:5a0f:0:b0:4f2:5d79:f490 with SMTP id q15-20020ac25a0f000000b004f25d79f490mr2397052lfn.36.1683829866132;
        Thu, 11 May 2023 11:31:06 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id j8-20020ac253a8000000b004db3e330dcesm1189390lfh.178.2023.05.11.11.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 11:31:05 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Matthieu Moy <matthieu.moy@univ-lyon1.fr>
Subject: Re: Can we clarify the purpose of `git diff -s`?
References: <645c5da0981c1_16961a29455@chronos.notmuch>
        <871qjn2i63.fsf@osv.gnss.ru>
        <645d28e112294_26011a294b2@chronos.notmuch>
Date:   Thu, 11 May 2023 21:31:05 +0300
In-Reply-To: <645d28e112294_26011a294b2@chronos.notmuch> (Felipe Contreras's
        message of "Thu, 11 May 2023 11:41:53 -0600")
Message-ID: <877cte200m.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Sergey Organov wrote:
>
>> I'd rather think about generic interface for setting/clearing
>> (multiple) bits through CI than resorting to such convenience
>> tricks. Once that is in place, one will be able to say "I need these
>> bits only", "I need to turn these bit(s) on", and "I need to turn
>> these bit(s) off" conveniently and universally in any part of Git CI
>> where it's needed.
>
> It's possible to achieve both.
>
> Imagine your ideal explicit interface. In that interface the default
> is no output, so you *have* to specify all the bits, for example:
>
>   git show --patch

No, that's not what I meant. There is no point in making "git show" to
have no output by default, please see below.

>
> Or:
>
>   git show --raw
>
> In this ideal interface it's clear what the user wants to do, because
> it's explicit.
>
>   git show --patch --raw --no-patch
>
> Agreed?
>
> My proposal achieves your ideal explicit interface, except when no
> format is specified (e.g. `git show`), a default format is chosen for
> the user, but that's *only* if the user hasn't specified any format.

My point is that the default format should be selected as if it has been
provided by existing options, rather than by some magic hidden in the
code.

>
> If you explicitely specify the output format that you want, then the
> default is irrelevant to you, thus you have your ideal explicit
> interface.

That's not what I had in mind, sorry. It'd rather be something like:

  --raw: set "raw" bit and clear all the rest
  --+raw set "raw" bit  (== current --raw)
  ---raw clear "raw" bit (== --no-raw)

In this model

  git show

would be just an alias for

  git log -n1 --patch --cc

and no support for a separate command would be need in the first place.

  git show --raw

would then produce expected output that makes sense due to the common
option processing rules, not because somebody had implemented some
arbitrary "defaults" for the command.

Then one can even think about supporting some niceties like

  git log --patch+raw

In other words, if we provide full orthogonal access to (the diff
output) bits using CL options, no special code wold be ever needed to
implement some niceties and shortcuts.

Disclaimer: please keep this with a grain of salt as this is not a
carefully thought-through proposal. Not yet anyway. Just me thinking
aloud.

For *nix guys, the closest analogy to the above is probably:

    chmod og-wx

Thanks,
-- Sergey Organov
