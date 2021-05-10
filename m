Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C3FC43460
	for <git@archiver.kernel.org>; Mon, 10 May 2021 13:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69ABF6143B
	for <git@archiver.kernel.org>; Mon, 10 May 2021 13:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237503AbhEJNmJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 09:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235468AbhEJNDb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 09:03:31 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A6DC061761
        for <git@vger.kernel.org>; Mon, 10 May 2021 06:02:23 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l4so24363877ejc.10
        for <git@vger.kernel.org>; Mon, 10 May 2021 06:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=e5FzrP8EgDfSZTXWjSt+/VxzI1vsRd1vY09htA9JB1I=;
        b=Ugpjc8tKs4TQnr6GbxX1enZppISLFWqMxrywvypzAuXqzYRTqu3gYEDa7MHZIwoMhR
         AAyB6QJFpLjfemlCSngl3KAPOeca6gXZA+p0/OnHMleEPXmiLk2LAkiepaM0bV7KNAFs
         8j59lQaD4baiCuC3iSA6Adlq5+wnHnxJ7H4C17gmXLyUmGycVEmbdDduPZgcMBrmzV7N
         b9Za2o8SECveUqUilY+rMcmWyAVzB0tY3J4bLFAbtZFuC4ttiCiUlBBASlcG6TgZMTZl
         Yf3hrPxWNLGSxZXtJJJTa43LUB2I6GlyFDr8tMTpGoi6m4gxBZ5yKjWk0EQwLz5AS3jL
         hCtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=e5FzrP8EgDfSZTXWjSt+/VxzI1vsRd1vY09htA9JB1I=;
        b=S804qFFJmQTaszZQYhsDnp0Qncdzc5tymDNOCASZxS1idlPV9zrNfcy/T1GK3RGOK8
         oBLx4LcQtLvi7PLTrk3MIX5y8FI62bDWl6D+rHfZH9pTtE7NlqE3BkRdNx4rIjjfPdsX
         Q+wWTzVWB72fZpxGzYf9z9NN2LuPucNbuzq6urWeWCdxT3OCsRHvS1Z6rltjlrZrCShw
         GhvsCYa1WWQpirBAu/Nuf6+DLhIBZjBFoHK2Fcc7tSQa6fQxBWt/+b56JrWP2FXXtdBo
         mIAwf3QBC/hyUZYOYS1sHdwfe4LkyMcIUmP12kxIV9tlh1GEAiRX8irW9jW0UrfaRWrL
         UpBA==
X-Gm-Message-State: AOAM532Qn57nX0PZww3uJSmeNWfaEjdBp0W/XrqHcHw8jA41RZIbdXSL
        i4eH7a1hn94q/EQ3d0OkKrc=
X-Google-Smtp-Source: ABdhPJzoIqtt2pcOii9lYL3C7vXDQfR5d/IUr/oyDHYu3fhS5bQhBA3D6xUo0FjQIPzlYElSBPDuZw==
X-Received: by 2002:a17:906:4809:: with SMTP id w9mr22641200ejq.401.1620651742311;
        Mon, 10 May 2021 06:02:22 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id u1sm11234661edv.90.2021.05.10.06.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 06:02:21 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] tr2: log parent process name
Date:   Mon, 10 May 2021 14:29:15 +0200
References: <20210507002908.1495061-1-emilyshaffer@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210507002908.1495061-1-emilyshaffer@google.com>
Message-ID: <87im3qu4gy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 06 2021, Emily Shaffer wrote:

> It can be useful to tell who invoked Git - was it invoked manually by a
> user via CLI or script? By an IDE? Knowing where the Git invocation came
> from can help with debugging to isolate where the problem came from.

Aside from the portability concerns others have raised, I don't really
see why you'd need this.

We already have the nest-level as part of the SID, so isn't it
sufficient (and portable) at the top-level to log what isatty says + set
the initial SID "root" in the IDE (which presumably knows about git).

Wouldn't this log passwords in cases of e.g.:

    some-script --git-password secret # invokes "git"

In older versions of linux reading e.g. smaps from /proc/self would
stall the kernel while the read was happening, I haven't checked whether
cmdline is such a thing (probably not), but it's a subtle thing to have
in mind for this / follow-ups if it's made portable (is that an issue on
other OS's?).

All that being said I've got nothing fundamentally against this.
