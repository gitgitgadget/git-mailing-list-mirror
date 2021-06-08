Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C349CC47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 05:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A3CF608FE
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 05:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhFHFjd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 01:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhFHFjc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 01:39:32 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3CCC061574
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 22:37:30 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id w127so20438201oig.12
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 22:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=3wWtu/Iz5ZjpjJRpSGOZzZrYDMpREUcxlUXtacblxEE=;
        b=VWTurbiDgARu+XQjVAEFuE8mc7eSlh7Y+acH9uysXra9ozmP8U41fWh7q4rDzL93fa
         vpkoO74xnrPZ3XaL+Ck2+pnQEbx4wuGH+F9/dMU7IQ8HG5dg7J7NoXc7kooGZ7no4zj/
         R9heYYCeMaE8zFyUvLLDOzcVmV7P5s/zCcuNLM/xE/dj/fv7Q98Mj32aPEQ0F2diZfKm
         aad/T5okZf8kcCN//zQV96VGm+s2e7v/w9/Ou4RV/ozoMZEG87/tnuPSR82X3RMlQPvc
         glLAApzMi8BP20g643YVcOGCVHmQfoeVzhxZyRwKl/dHTGoTGTuz6yGRq0vqs/buS93a
         SeeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=3wWtu/Iz5ZjpjJRpSGOZzZrYDMpREUcxlUXtacblxEE=;
        b=TAb+E2Q9j4PzIHCeHNn+TLT0kkbbnYah8QGPIpRb6x0Ei6L6KolwvuFhlXZm05UW1I
         KD2k4dQPva+hEbfDH9Wv1klqYJFEy8BX/zWcbWF16MLdNXVdakHpIDduMk3MnaTlB43z
         7XMhFYCkD9rwJKF261hD3jt5pF3UCqLR5QszcydSdIWCIhXC0Qz3TxYk6gEeVvRpMNnW
         VulL/nVAFhHr8YQS+9BQ1PiuKEG3c7+x32FoyK2SlNK3QMRdRnNEKsT2SFap/oiP7wMZ
         OVPnLAp1Ndq1jPssa5ktr1fzPxcv/idZfUYeQdW965VRSO51U3fk1LO90hwBke0rk+X0
         JHxw==
X-Gm-Message-State: AOAM5306wDUQyW4k4mMwAh3rCXM5Ed7e3eb+j1WZISpaeNLdCMybSvr0
        laqBg/a/ci6iWb7XDxI5d74=
X-Google-Smtp-Source: ABdhPJwu4Mgv4q/HhYBdQE5O3hDM6raa+SLA2X6/ihPgZIXoB8SA2t2Ua5IosSp6HCNKW07NH7V34Q==
X-Received: by 2002:aca:4bd7:: with SMTP id y206mr1812457oia.40.1623130649648;
        Mon, 07 Jun 2021 22:37:29 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id w4sm668939otm.31.2021.06.07.22.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 22:37:29 -0700 (PDT)
Date:   Tue, 08 Jun 2021 00:37:27 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60bf0217e0a90_198bd720828@natae.notmuch>
In-Reply-To: <20210608050115.GC6312@szeder.dev>
References: <20210608023807.907883-1-felipe.contreras@gmail.com>
 <20210608050115.GC6312@szeder.dev>
Subject: Re: [PATCH] completion: zsh: trivial improvement
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor wrote:
> On Mon, Jun 07, 2021 at 09:38:07PM -0500, Felipe Contreras wrote:
> > $words has basically all the words we need, except the first one: git=
.
> > =

> > Lets simply add that instead of passing the original, which contains
> > options we don't want to pass downstream (like --git-dir).
> =

> In our Bash completion script $words contains all words of the current
> command on the command line, including 'git -C tmp -c foo.bar=3Dbaz'.
> =

> Why should zsh completion behave differently?

Because we use the _arguments function [1]. It changes the $words array
and removes all the arguments it was able to parse. All that remains is
that which it didn't understand.

If you do:

  git --git-dir=3Dx show --<tab>

_arguments will remove 'git --git-dir=3Dx'. And there is no point in
passing '--git-dir=3Dx' to _git_show. It provides no useful information,
and it was already processed by __git_zsh_main and __git_dir is set.

__git_main doesn't need to change $words, but it does increase
__git_cmd_idx to match the position of the command.

But since in the zsh case _argments already modified $words, we can just
add 'git' to the start and always use __git_cmd_idx=3D1.

[1] https://zsh.sourceforge.io/Doc/Release/Completion-System.html#Complet=
ion-Functions

-- =

Felipe Contreras=
