Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB0EC433F5
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 22:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFE9B61029
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 22:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhJMWDA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 18:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhJMWC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 18:02:59 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6296C061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 15:00:55 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s66-20020a252c45000000b005ba35261459so4771394ybs.7
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 15:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tG194nxVqEo16I6rg9f+ZpSRyo3qkXVoaD1E058vPP4=;
        b=MzvpRlRb8sPsCUUz8L+fw0S5kz5vNV/snxvYMN443e47zBlyPpRZ+g+xR/PFKu720c
         OQaCnQGLRsSqJ4XNRuVipdsN3vqF6pUhlfa2lxhByMdKJm4MwTNcsyf6gjeJlNb8hcFL
         8A/t8d/YulMTWEyjYz/JyclCRoFB1VgK8s1Umxzqzxi1oozTlZgxCUvAvCac676bGl0b
         LnLDmBlRzxef14Btk/cDyX+FHAIg3vVJlfiRZ2or70l+/Hynlb4d8iTSPAIBcMscjAOU
         gE2HrYJ8/whPNBxWrH4++QYAqUzAKBiZ53XCSe5Hgu3SiXyn2fnu+vWxMKxM5owm8qGf
         Om3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tG194nxVqEo16I6rg9f+ZpSRyo3qkXVoaD1E058vPP4=;
        b=MC+76gdl2d5rYXD3RPQ4k9Y6TZTFh79u/I2G/GudOp71i+lg92dPyK8TDeSRIurjBE
         3Qm6hsWCJYx4HIzfyOWNxds8dEUB0mtI1Gm/SbT+hdu9vp6tFmJuHTml0Co3ras6A4Ve
         sK5slbp1TQN9hdaaWUTrJr2xI1tTqxzYAR6sr5B07KFcJed3y3BFeqNlZiCE/+AUYOfh
         BHpzw94bjXWtLy1Z/qjD7eDSs+Ek87uKP5RTfcDfoXjzI7QNCZufedi7evJgU0XNu99+
         VB5b55PuZ97+pPXiyViRgaAtAPrjAipqKsJOiq+SnW0BkwvK35p5Fq0ffaB6zo9dPj7G
         O8dQ==
X-Gm-Message-State: AOAM532Q0Tc023rd7EZ9cMzTSTUZiXyx0ANRb8gX+Sei00fXGaiPw/1P
        A4hhRfXrjc3/oHapeAsoJoE0zjVm4/qwng==
X-Google-Smtp-Source: ABdhPJxXjaY+uImzN5qC0yN6BR1C0GCXTwHsoIUtMOfqpwvsuqzkMwbJeRWkmHrhVo0imY+TdzvkTqIZgKbaEA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:da16:: with SMTP id
 n22mr2250474ybf.359.1634162455083; Wed, 13 Oct 2021 15:00:55 -0700 (PDT)
Date:   Wed, 13 Oct 2021 15:00:53 -0700
In-Reply-To: <xmqq8rywfz6x.fsf@gitster.g>
Message-Id: <kl6lr1co1t62.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1103.git.git.1633633635.gitgitgadget@gmail.com>
 <20211013193127.76537-1-chooglen@google.com> <xmqqtuhkfzw8.fsf@gitster.g> <xmqq8rywfz6x.fsf@gitster.g>
Subject: Re: [PATCH v2 0/3] remote: replace static variables with struct remote_state
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I am not you, so I can only speculate, but the real reason _could_
> be that it makes it simpler to formulate steps 2 and 3 mechanically.

This is somewhat true, however...

> I think that approach would make more work to get to the final
> state, though.

I found that if I were to add the backpointer, it would have been better
to add it early and avoid this extra work that you mention here :)
