Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01307C47089
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 00:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbiLFAlV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 19:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbiLFAlE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 19:41:04 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB2955A8
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 16:40:15 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id c13so5942891pfp.5
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 16:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2hoPIXKZkub8v17IXUaok1HJkbQ9d5dM3bhXG1tPL2M=;
        b=ASH2KUgMOTAjO8Kuqo+EcgdwtfAfQnSrU7llkHyuXBE6TpR6sqdbwMocn4NocaKAlm
         jIxKQ3m02tB6S/hEIFcikwrr8p9RS3CBmd7tjqN9Q5sMzJ2LFrC6zbIFQLThN6D7Usqn
         BRfcnbIBUTzJ5IN/HaEhzt3TpLTpbaIz4lpy0GR9A/5/n9vVEH9ll/gY7w9dg92nMD+j
         450sdWn7Ij1pIoHOWQ6PFY7rn45W7WbqTA7WVIHv1TYTMhX70uunLKjbi988P4EGNZ4I
         VpSBGLo96K+HXX/Rj3K54N5CyhwkQcm/TQ5UGBQeUjaO8pNV7rUBkBJjjNuNdhOMTpXA
         ZMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2hoPIXKZkub8v17IXUaok1HJkbQ9d5dM3bhXG1tPL2M=;
        b=PNPRFn4m/KYuS6OMGzLaN4a9K4blrYa7GBZ+1jUbf6oXT9wefsosnw/v96/ugxegCK
         FVkZmj8LdHws365HFygvLFos60mI1gp21bJ7lVy96C7y5K0IbC2iZpuGmTEa2ykPZwXi
         ECwOZDyONuZcez93OpqNzpJzt1YzE82qAL2tDNudnVdTf8GE3/Sv4hpQ/z8vyHHHDpND
         O2wGi188NediKSVwl2pr16+m/9UlJpN7GQXaBOwmJYPIHmQg+gO71nLTddZmZNA+cS2F
         tULOgrrYMmtkIfmKfGc35FxUszRM9Ty0GCWfC+mMJObqSpZffIG3paw6TVV9Kg2uWvYI
         lknw==
X-Gm-Message-State: ANoB5plbbUNne3n5L1zoQf5kS8/bJRsxNeynlswpyR8XkdIVf2CPAQBk
        BC38ArA/JBw0PzMo4bmGHzSrzN/+fAcNwg==
X-Google-Smtp-Source: AA0mqf4nFjin+kg1X4i0DkOkUPL9rgOe44JINCfYvIDC/sRzvpj4MnCm5YI/mrpFsEetcTM6qlUfjQ==
X-Received: by 2002:a63:5b45:0:b0:478:b792:dea6 with SMTP id l5-20020a635b45000000b00478b792dea6mr7099033pgm.445.1670287214603;
        Mon, 05 Dec 2022 16:40:14 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id a6-20020aa794a6000000b0056bb6dc882fsm10455868pfl.130.2022.12.05.16.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 16:40:14 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] setup: avoid unconditional open with write flags
References: <20221205190019.52829-1-cgzones@googlemail.com>
        <Y453yiYAifv/oV5n@nand.local> <xmqq7cz5pf1w.fsf@gitster.g>
        <Y46NaUjc+eqzSExR@nand.local>
Date:   Tue, 06 Dec 2022 09:40:13 +0900
In-Reply-To: <Y46NaUjc+eqzSExR@nand.local> (Taylor Blau's message of "Mon, 5
        Dec 2022 19:31:37 -0500")
Message-ID: <xmqq359tpdoy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> But it's still no better than the patch here in the happy case, since we
> still have to perform three fcntl() checks to figure out that all three
> descriptors are initialized as-expected (versus just one open() and
> close()).
>
> So I think your version is a slight improvement on Christian's, but I
> would just as soon stick with what we have.

I am OK as long as there is a workaround available to Christian's
use case without changing "git" at all.  If Christian can tighten
the environment into somewhat unnatural "opening writable FD is a
failure" way, I suspect such a jail can be augmented to further to
allow opening /dev/null and other "selected" files writable, so I
wouldn't worry too much if we dropped this patch entirely.

Thanks.

