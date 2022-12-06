Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8620CC352A1
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 23:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiLFXjn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 18:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiLFXji (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 18:39:38 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE69B46664
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 15:39:36 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id t18so5669850pfq.13
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 15:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gi6FDOk/t+6khCtvcTpUvY8yu1zVZOIst4fjVWDbLWs=;
        b=WFgHNv+BO2culxLormgFLpeOqR8St3OueXYXD376ZaGn+4K9Ir4xJq9fGBIu3mFZOW
         kGoj1muwYpm3aGVK9j+BrZhTPG6sJFRZhzrj1FM4wKIc2KD9mk6cqQP5dSA3/5jde4Tj
         rkdnWtJGONMeX7P4PbFN5eUe7MVBtNLPmVtN+LEHX3DtzjpLNVHNrYjRtCfEzlusb9bG
         h/y53gP4HdjCikQP/anGu56Cgbq1c/e+dpdjK3VhC3hwfGInFP9/sYN4jctbi/InbNCZ
         o5RM8ez9QPPDPiJPmzCA6HGREaMMxBVsQHeuiHjghZloTt+YWYuQhCiB7yyZXimet3Uq
         6xcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gi6FDOk/t+6khCtvcTpUvY8yu1zVZOIst4fjVWDbLWs=;
        b=n/+LbRVmeuvvJWdntrCjas9Ml0ry8mvd686/cYH7E3EpfoXDc/YNNFgb0vOdaGUHdY
         DmgsXj+lfrQ1mAzZ0mpS1EEGU5VHUXo4kXBFbaCU7/ccxLBryf7/X7TWzuDD7O9jScIb
         L7QmFgu3cAKG9VQHJDGo/7BV/DR3HcsBldzCW9bz5SuTo+v/jErM9Y+8V7qPMN521ZUZ
         uiFlZjm+xPfDayogbj4IIxvqNzrGZ4i/hHzPVIhgpSE9uZlWrgI7HkGuzM2p4MhTqEIb
         WTv9DN/wzxK03uYCY3uSGH6P8ul1sDJh5K5WOM9eRSXnXvlx+a5AfgViSeKnq36tYCbY
         mXow==
X-Gm-Message-State: ANoB5pniRR+7ffCkS5uiicNQQEEBvHAiQZPsjIiUZI4rJist7fCRCCpS
        2Ww0Zo0BlKVwQwKKXCnktrU=
X-Google-Smtp-Source: AA0mqf4O+jkGa10996A5biHlXLWaMZhfBv7bE6O/jBSIROVou2J9Np0xhRdVlKWlNsi3juCXPxcCiw==
X-Received: by 2002:a63:1a07:0:b0:477:cb5a:ad48 with SMTP id a7-20020a631a07000000b00477cb5aad48mr52986384pga.63.1670369976219;
        Tue, 06 Dec 2022 15:39:36 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id h2-20020a625302000000b00576b603a913sm1792940pfb.0.2022.12.06.15.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 15:39:35 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] setup: avoid unconditional open with write flags
References: <20221205190019.52829-1-cgzones@googlemail.com>
        <f49b915e-46d1-7e53-ae4f-b01c2028b70d@web.de>
Date:   Wed, 07 Dec 2022 08:39:35 +0900
In-Reply-To: <f49b915e-46d1-7e53-ae4f-b01c2028b70d@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 6 Dec 2022 20:47:09 +0100")
Message-ID: <xmqqr0xc85l4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Can opening /dev/null (or NUL on Windows) multiple times instead of dup'ing
> cause issues?  Can we e.g. lock ourselves out?

258e93a1 (daemon: if one of the standard fds is missing open it to
/dev/null, 2006-07-13) unfortunately does not explain why it was
done this way.

Given that "command </dev/null >/dev/null 2>/dev/null" should work fine,
I suspect that the "once we open a throw-away descriptor, instead of
opening the same file again, dup the fd and reuse" was done not for
correctness but for performance, under the assumption that open() is
more expensive?
