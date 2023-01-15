Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE56AC3DA78
	for <git@archiver.kernel.org>; Sun, 15 Jan 2023 07:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjAOHCj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Jan 2023 02:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjAOHCe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2023 02:02:34 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A2BA272
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 23:02:33 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id q5so96264pjh.1
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 23:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RYN0n7y4qVwNWwNMUOKnjpL8ibe6BvT4aswa3Kf9Zb8=;
        b=d58bt2w8Kj8/UvYcTBSGtX5BGkfMbazvx0uGfk9i7rnVn/d/i44LvPN9fYjBySlb43
         PYy/UAulE81z321HJshN6CJzKmPbMDqYWRMJCrwPjQNQxEM0xaL4zvLF5jh2ZArNYpsJ
         THB05D2U5yTa/ZEu9sj5m9zGqmJN3+ffVhDpgCP+JZk04XFGbIr+zwbyFA+hScoh5yvd
         chYIfypP2FTOoBZjzziJ5CyIhnJMeQl8EhahRZ8M5TTJWvJEFO7QjfGk+BZsVhSM+JeA
         ttIdVA4s6I5r7/LunvNd3/aJ1cfzbGIeszFLCf5ih5vt/aKos0KtrhZ0aex07E8uvq/G
         1Ajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RYN0n7y4qVwNWwNMUOKnjpL8ibe6BvT4aswa3Kf9Zb8=;
        b=2J355mbDkBKzwvoODGIHLeMrBGs5fVFXaAkjGkcC7ft+T4icpes0pJcTq6AvtR06rV
         YSbT81w6lw11iFl2EPanz0lCCyKSX5/wlJRFhqWbFEAq6YxR6cZ6+vUM3s6wSARGjteS
         LzN9ZSpQdLyhjBwx2PtaOO8XGtlLOSztJ/bqMAAiiWMKohhBsKW7cFBY/6oMlZc/QyUX
         IMhIqJHpKtmakukug5PgVevtTDikcqSLg+iAuE2iWtzCZQN6NQ1oOoN/kFiYFoXEJhGb
         PG+NJxI8lBqRkydi0JMAp+nWPKoMN08+qWhJgnpzuiHUYlVdTJqDkyv4GF6zjWqkk3Mm
         fBag==
X-Gm-Message-State: AFqh2kqGLbXE8cC3KJwgCTna5syZr1q0AUMoP+nfCJLrTZcR8RtzDbUu
        B+E5FdRO/CYNBYeEpQFvklIvrOt/g8I=
X-Google-Smtp-Source: AMrXdXujSIqUYzbxwlWXxUBKK5in/444UvcexAct9RXZUKoApGtMHxTY8kzwTJ9ocnuCsVqnSJ+7lw==
X-Received: by 2002:a05:6a20:d38c:b0:af:a276:2f94 with SMTP id iq12-20020a056a20d38c00b000afa2762f94mr107293271pzb.35.1673766153112;
        Sat, 14 Jan 2023 23:02:33 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id s32-20020a635260000000b004b1fef0bf16sm11346074pgl.73.2023.01.14.23.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 23:02:32 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] ci: do not die on deprecated-declarations warning
References: <xmqqv8l9n5fj.fsf@gitster.g>
        <Y8LAim4D3g6qnZdq@coredump.intra.peff.net>
        <xmqqilh9kqdy.fsf@gitster.g>
Date:   Sat, 14 Jan 2023 23:02:32 -0800
In-Reply-To: <xmqqilh9kqdy.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
        14 Jan 2023 08:55:05 -0800")
Message-ID: <xmqqzgakgu0n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> But anyway, let's use CURL_DISABLE_DEPRECATION first to see how it
> goes.

The "DEVELOPER_CFLAGS += -Wno-error=deprecated-declarations" version
was merged to 'next', only because I wanted to see the commit
cleanly pass the tests (and it does), but I do think in the longer
term (like, before the topic hits 'master'), it probably is better
to do this for everybody, not just for those who use DEVELOPER=Yes.

So, further patches on top are very much welcomed.

Thanks.


