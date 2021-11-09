Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00630C433F5
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 03:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D05B461156
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 03:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242390AbhKIDLT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 22:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242393AbhKIDLR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 22:11:17 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78C1C061570
        for <git@vger.kernel.org>; Mon,  8 Nov 2021 19:08:31 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id j9so13300882qvm.10
        for <git@vger.kernel.org>; Mon, 08 Nov 2021 19:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8goXp95sHr9Bz+v+vYNPsqD4lZSjZNSEBtxAl74hYe8=;
        b=m/Ossma2E2ooftnb3bnQq4a6iW/bspufUeG2R74kc4vMYJu7EKwjFB6lUChmSn80ik
         5lQEavXh2+XYN0cu6zrpM178UxqscPEgDEFAuyyYD3AdCNUl223guKLPoZ0pa+w+Foc9
         ejafg+42dzD4eh2s5A8Q+PPkw0YZeJ8dT6QepPynJles+HrbEGDCjfNpFs/f/jz9OhEG
         Z9z9bYf1RqWbUX/vpEB2iH13T6gd3CfxmA6L7zNCCZnrxEsrO1U/yb9/7UKRbsgyBJQF
         Pxg/Ya//9NAwGyKWOsvCcxJ/nnaB9HIJVlTrLVcuQztijHeDj4uKwpREBkbkOmj97H6j
         Z0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8goXp95sHr9Bz+v+vYNPsqD4lZSjZNSEBtxAl74hYe8=;
        b=64G/1lbfGRfPszXFrRExgLLbpoE5wZ1Q0pPwmwjcR/9oL2U3CnJPSEpmeUZTXkyFY7
         oEHqAs6WLX4x54ack5rpmL2u3dFXZgNy6SHRzxW30JTEN0Y0E7IGj/hefimjeeU2X6lq
         A+lSBhKKhbD8MLBGVGf9AX1h5Eo4uyropEmCNb0r6afW3ogt6BslkNVmzIJs6FlB5vw6
         jc9+tgAT7hiz5ep0HElmpCzTmTCKd115fOXXkc3XqZIByJYlrj51US7TWYO1CzedDGIS
         +ToOISKSTwKexDDnhuKCuJR+T2x2EKeT73xAhW1p4NbtuuuDPHXD2jXCSYuWRx5kb1RZ
         ZSCg==
X-Gm-Message-State: AOAM530u5vmh1tQzN5HYi/4KVuix34sKk5KRE+iqID2p7C1q4UtVDIvo
        nfeiG/rLYqSEIaNW8Eru28fV9i3P9UuqsvMK
X-Google-Smtp-Source: ABdhPJxrOTg5IwXNT6bNH8vPGqaltJ+AZHvQJwcCuwNHKOry5KUhK+Ezw3rwVIaid02XArzwoHUSGQ==
X-Received: by 2002:a0c:8e8e:: with SMTP id x14mr22788180qvb.67.1636427310911;
        Mon, 08 Nov 2021 19:08:30 -0800 (PST)
Received: from samxps.. (modemcable158.252-203-24.mc.videotron.ca. [24.203.252.158])
        by smtp.gmail.com with ESMTPSA id p18sm11767684qtk.76.2021.11.08.19.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 19:08:30 -0800 (PST)
From:   samuelyvon9@gmail.com
To:     avarab@gmail.com
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com, samuelyvon9@gmail.com
Subject: Re: [PATCH] builtin-commit: re-read file index before launching editor
Date:   Mon,  8 Nov 2021 22:08:04 -0500
Message-Id: <20211109030804.261493-1-samuelyvon9@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <211109.86wnlicaur.gmgdl@evledraar.gmail.com>
References: <211109.86wnlicaur.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Samuel Yvon <samuelyvon9@gmail.com>

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> The code you're moving around has a comment which seems to suggest that
> what you want *is* the desired behavior, i.e. we re-read it before
> invoking the editor, so we should have the updated diff, but just don't?

My understanding is that it was once the behaviour and has changed over time.
I am saying this based on
https://lore.kernel.org/git/xmqqk0yripca.fsf@gitster.c.googlers.com/t/#u

Specifically,

> Junio C Hamano <gitster@pobox.com> writes:
> Even before ec84bd00 (git-commit: Refactor creation of log message.,
> 2008-02-05), the code anticipated that pre-commit may touch the index
> and tried to cope with it.
> However, ec84bd00 moved the place where we re-read the on-disk index
> in the sequence, and updated a message that used to read:
> 
> -    /*
> -     * Re-read the index as pre-commit hook could have updated it,
> -     * and write it out as a tree.
> -     */
> 
> to:
> 
> +    /*
> +     * Re-read the index as pre-commit hook could have updated it,
> +     * and write it out as a tree.  We must do this before we invoke
> +     * the editor and after we invoke run_status above.
> +     */
> 
> Unfortunately there is no mention of the reason why we "must" here.

Looking at ec84bd00 (git-commit: Refactor creation of log message., 2008-02-05),
we can see that the editor is launched after the cache has been reset. The only
part that troubles me is the line in the comment that specifies that "we must do
this ... after we invoke run_status above". I have tested (with my limited knowledge
of the internals of git) and it seems to be of no consequence of flushing before
the call to run_status, but I might be missing something.

> The code you're moving around has a comment which seems to suggest that
> what you want *is* the desired behavior, i.e. we re-read it before
> invoking the editor, so we should have the updated diff, but just don't?

I think this is the case (based on the previously linked conversation).
