Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2A4C433F5
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 20:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350726AbiDZUQ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 16:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354789AbiDZUQO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 16:16:14 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA011A325D
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 13:12:55 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id t85so8895145vst.4
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 13:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rZC8gwhXPL6QjizzEdrrBKKil/S1L7E5+YvPZ5kT6Pc=;
        b=Acg30qt4DMH7alDVItrbCXJ/MldKdJPwMmuHqNxaV7QKAh4O2Hvcp03BcsAVeeDROS
         Jw4qTVpzf+eLZDzAQ1qLA81Ecfbx6dW++vcdK6XffEmB/m15sna2B7Fm6muIzaIwmW2a
         wwVg3XIk0vTjDzyeTzPOZ3E87Ck7kyVkIbtGuYrIA0ofH1QtioQ67kE2iQDnuByoARbu
         /3cTTmA775zp8R4AjEPEs6LlplUnb8pUZCJYhPB5qgDG5j4OcIjLohfFInMk/qRY09d2
         fdzReiAV1XiVQiC5oItRh//UNPlH/t7HySwYMQRWf6VSSwa3OoO3TkVt131LwPJwc/je
         Vtaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rZC8gwhXPL6QjizzEdrrBKKil/S1L7E5+YvPZ5kT6Pc=;
        b=Zns0KuA5tkfTcyO3J6BeyJLLtdNXQsSNOvTvcNHBnq+4ki3pXWB8PHc0vPj3chnf26
         tXMq+HpKsrj7HBMszIlr+ARSqb25M7UzBddsy6OnOz7oU4qviB6iSqH/fk/1Npo5S5vW
         FElaRixqcv2ohzLss5PqtMqVfz5Q53NRnXcPK1FQk86aUdsNCQFWTz/hg4yJWnufDzu3
         kbT0b3hz+0OIyadAPtZTAm3jbwtUC64HrPOy8HUhKInlHF3cjFeEGhQl7N5AC5LxNmlP
         A2ZHwqEX2FFq6fFN9L1+VvLD/KtQXwyRIgciF1sLqGAwGHWWiKafZjfa0oA7G9immwUW
         9jQg==
X-Gm-Message-State: AOAM531aYzLBSNzGjZewIyq2bA+nnYczIuwUNDpSWy1Ls1fLDmibKYj2
        xcc4kqT70qmkM2TL6N2aDVigOp38+OtdY+EhnqA=
X-Google-Smtp-Source: ABdhPJwb0U/ElScNpYSf7HUCKaZA3GRXxdLjImdRnqM9exFdTzqW3pV1suwEtywkcf965+AK7M9gO+Kb3hZ9NrJU4sE=
X-Received: by 2002:a67:1a02:0:b0:320:a51f:8067 with SMTP id
 a2-20020a671a02000000b00320a51f8067mr7711228vsa.38.1651003974560; Tue, 26 Apr
 2022 13:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220426183105.99779-1-carenas@gmail.com> <9658dea7-d421-b238-113d-c7b83eca4569@github.com>
 <xmqqlevrr53n.fsf@gitster.g>
In-Reply-To: <xmqqlevrr53n.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 26 Apr 2022 13:12:43 -0700
Message-ID: <CAPUEspizQ5hkhnNURNLyhzucUfD1tS99cfH5NhQKF+47NzKMPg@mail.gmail.com>
Subject: Re: [RFC PATCH] git-compat-util: avoid failing dir ownership checks
 if running priviledged
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        philipoakley@iee.email, me@ttaylorr.com,
        Guy Maurel <guy.j@maurel.de>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 26, 2022 at 12:56 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> How much do we really want to trust SUDO_UID or DOSA_UID are telling
> the truth, though?

IMHO since we are only trusting this if the EUID is root it would require that
the root account was compromised already or running in a tampered environment.

for the absolutely paranoid we could trace back the process tree to make sure
the current session was indeed created by that tool, but if we are going that
way I think that trusting the ownership of the pty as was proposed[1] originally
would be simpler and is indeed how other tools (like who) deal with
that problem.

The advantage of trusting these variables is that we can keep the more common
case simpler and avoid the reported regression.

Carlo

[1] https://lore.kernel.org/git/20220425084003.nf267feurpqyvmsd@carlos-mbp.lan/
