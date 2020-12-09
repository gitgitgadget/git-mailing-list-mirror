Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC81C433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 19:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F25C923BC6
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 19:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387984AbgLITpt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 14:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387991AbgLITpY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 14:45:24 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985A4C0613CF
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 11:44:43 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id j10so3850243lja.5
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 11:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oxvdFRlHUVo1b0LNwORLNuaFGlFlBRMKUqeiWeRUPFg=;
        b=i+UT1Mb5sVfGUSK3q0x92b/GRP3qZQWXbIazed9tiKbW480SfguUUEydGWttjef5Zh
         XJxgIqBnCI8qvt3LEzp3xLZtowRP4rEQiK0o9E6LGT8SzPIj1VsM4iZn/70HeQcMOnre
         2DiYGamPm01GjsjpNPBHJ1oaRpJLkl2USl3gPNZyZXIF0ClglWgOi1R526gbBNMMEtaE
         i8eG56b/2JJZyL9qDZQp+SyI16I4xVzqYCcJOchOtuPd9tu5suBakkpHOREFoY8cefJo
         MGrcLmIktHOpUZIIgusQ79HHKaYs8Di1XPvpOQEZT1Kcy7t0ODBLnDWZxfabJqeMe8lF
         DyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=oxvdFRlHUVo1b0LNwORLNuaFGlFlBRMKUqeiWeRUPFg=;
        b=lmaNHk6dsoP9m9ShKC31mP673RUT1lQwcnTxJrdmnqN7F4xdXgLr5aGPSD3zXY8UKu
         kVWQu+4wpc99y4i/s6Ffc1AClNM4UU88ZYVoK7Wr7hC1E/hGL0f0N1aqE8nrp6YjAQua
         WPuIBxpRsrL2RuN7kBeRIBrVRlPHCuGdNQLXRXtUaM6qiQ50ouglI10XeqSO2la7N9K+
         vcBgiCEd0CVOSslkA5fnck5dxWS2fzSW9Jr7EUNQIwE+ok0I7GLKpCHLGfVpqWDOovA7
         5oRnTmw0B5O+cmio3q2vJwEuDtIhZAF4B4n+kSEXuzexyrDDQJM+/0citWVvPdC/fXO2
         uarA==
X-Gm-Message-State: AOAM531DuzIbNLsMICg7pAvkvdNC3aEEg/OS0NwJrMj072Gr13JVTnXF
        eQuAxDorVP5R1IgWEvhXjnMjKHgC9U4=
X-Google-Smtp-Source: ABdhPJwi6x1w9gj0CuJ2xv9trWUPp4a7BnjIjdOHKCNh8sfacmiaVyE6xWzfCCv0H2PEFcQ/VfWiEg==
X-Received: by 2002:a2e:9cd8:: with SMTP id g24mr1595719ljj.32.1607543081757;
        Wed, 09 Dec 2020 11:44:41 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id j21sm266734lfe.83.2020.12.09.11.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 11:44:38 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 00/26] git-log: implement new --diff-merge options
References: <20201101193330.24775-1-sorganov@gmail.com>
        <87y2i8dptj.fsf@osv.gnss.ru>
        <CABPp-BGuLX8Msghbo6L7vB2Wqys=Xg_uvV2Aui-1q4-+ijuNEw@mail.gmail.com>
        <87y2i8c4mr.fsf@osv.gnss.ru>
        <CABPp-BE3D7ifQx6MZCT_ntRnG0QZm1Ga10SJ=DN+6bpF6mX2GQ@mail.gmail.com>
        <xmqqtusv4w2g.fsf@gitster.c.googlers.com>
        <CABPp-BHCtrKAWR1v3OrUgX8iSfxvDwN8p+yiJy=G1BFfnSopjw@mail.gmail.com>
        <xmqq7dpr4qa0.fsf@gitster.c.googlers.com>
        <CABPp-BHWhiUZ=wCSz1f0oxtHiRzAKCPVmoUYDf+mvvm63ykCEw@mail.gmail.com>
        <xmqq360f4npg.fsf@gitster.c.googlers.com>
        <CABPp-BEAmB9DA7RXrf6vJGbHfGU37V4sE0d1CW+2vRwp_uAudw@mail.gmail.com>
        <xmqqtusv362t.fsf@gitster.c.googlers.com>
        <xmqqpn3j32ka.fsf@gitster.c.googlers.com>
Date:   Wed, 09 Dec 2020 22:44:37 +0300
In-Reply-To: <xmqqpn3j32ka.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 08 Dec 2020 22:40:05 -0800")
Message-ID: <87k0tqdasa.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

[...]

> By the time the change to make "--cc" imply "-p" was introduced, it
> was pretty much given that "-m -p" was useful to anybody, unless you
> are consuming these individual patches in a script or something like
> that.  So simply I didn't even think of making "-m" imply "-p".  It
> would be logical to make it so, but it would not add much practical
> value, I would have to say.

I need some help here.

Looking at the code and trying to follow the flow, I can't figure what
rev->diff flag is for? Why rev->diffopt.output_format, that actually
affects the output, is not enough?

My confusion originates from the fact that the code in revision.c sets
rev->diff to 1 for -c/--cc , while it doesn't set it for -m, and this
was the case *before* -c/--cc started to imply -p and -m.

It seems that the only place where rev->diff is tested is at the start
of log_tree_diff(), and even there its absence could be ignored when
rev->diffopt.flags.exit_with_status is set.

Is rev->diff an optimization, does it play another significant role, or
is it a remnant?

Thanks,
-- Sergey
