Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFAEC77B73
	for <git@archiver.kernel.org>; Sat,  8 Apr 2023 01:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjDHBAA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 21:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDHA76 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 20:59:58 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97CFE1AE
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 17:59:56 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-517c5c2336eso26508a12.2
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 17:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680915595; x=1683507595;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=swp9T2GnCmWBxBNAYdp8SwpeKObBtREfdK3puRVgI8Y=;
        b=RAno1NHyCobc4yI96oZMu78IowHfuNt9yWO+3+Sr0Fg41wnA8K4+fIfvpS43kfQ3cO
         uj2YCRC+OMUTCYYzeiDX/0G419BoUIQvRBUN9QT++FVeDBoRqoSMKv3dEvYbwja9tDz0
         JSsxi7gNbkotH9x+9Ny5+si8TwfGjp2z/WBDO1ucT8L//btwWfztEnl3stch5kppZEx5
         8GLGorTzSUKRTIK14wDWPlLGDR0tG9WV+9xdwzdYV9N/LQb1LEY0hgFFJGzRU1EKsRFm
         EHP1ZzvdF7STwfUYUa1Mw5L+msJk54hhQjaYDhT5jTNyy1EzcVmdJCPEbgOu6ltAsvoG
         bi0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680915595; x=1683507595;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=swp9T2GnCmWBxBNAYdp8SwpeKObBtREfdK3puRVgI8Y=;
        b=DFZ963qIr+qk4dYHs5Xk6D9WtKs+ErbFDjCQFSh5yaWG/w0/+KHdFj/lUcVvFNG/fc
         KIcMWvCAV8J95kQTxdn9lTezqhDBZuOo+HrRU879y5VzG3iJeqVIwZ5z74ejtg1XulYG
         CXYpS7yDWD7+BuEQY0BZiEYFFSCLmMiW4oPaMStghjMuSogMf35fFy2Tm5NHhEQp9JEg
         wkjkcY1UkNT+5jBiJw4tO9R4uja4CRZzPvtRA0SidZCmslAp0KGRTAWS/LPhT5QgswU+
         zpIbZIAxYrETWy/0oEdGGPUDqF1edEoFhtRUhblMTaOB5j5I6gPxIYG7TMdgYSctsWu1
         YMcQ==
X-Gm-Message-State: AAQBX9cwTAt+HL8LF8bb2QA4Gm/0f99Y9tftBsSnPSmD4q2OTGwNObtI
        DrlnUZnjxBwpDQeHiA8pa0c=
X-Google-Smtp-Source: AKy350ZZp0IU8G5LhdRh/EWu3HNJKiwJOXztQ+6R4WjHihxr8Yb5PRRuNwcyYzh/8+axs00DZA0dzQ==
X-Received: by 2002:aa7:9e48:0:b0:628:cff:1440 with SMTP id z8-20020aa79e48000000b006280cff1440mr3957868pfq.28.1680915595179;
        Fri, 07 Apr 2023 17:59:55 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id d20-20020a630e14000000b0050a0227a4bcsm3198190pgl.57.2023.04.07.17.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 17:59:54 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <nasamuffin@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] usage: clarify --recurse-submodules as a boolean
References: <ZDCWrl4GhgYKYFYG@google.com> <xmqqcz4fi7bd.fsf@gitster.g>
        <xmqqy1n3gryw.fsf@gitster.g> <ZDCztVHuZoCstNar@google.com>
Date:   Fri, 07 Apr 2023 17:59:53 -0700
In-Reply-To: <ZDCztVHuZoCstNar@google.com> (Emily Shaffer's message of "Fri, 7
        Apr 2023 17:22:13 -0700")
Message-ID: <xmqqy1n3fat2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <nasamuffin@google.com> writes:

> I think we do because config_update_recurse_submodules is static to
> submodule.c - that is, builtin/checkout.c and friends don't have access
> to set it manually with OPT_BOOL. Using the callback just to set static
> state we don't naturally have access to is pretty awful, though, so I'd
> be in favor of plumbing it through like other options we might be
> passing to the submodule machinery.

Yes, the cleanest way to interface into that part of the submodule
machinery that wants to use a hidden static state would be to

 (1) implement a setter interface in the submodule machinery for
     that hidden static state, and

 (2) use the bog-standard OPT_BOOL() on an on-stack variable of
     cmd_checkout() and friends, and use that setter interface after
     parse_options() returns.

Then you can avoid the "pretty awful" arrangement today's code has.

Note that such a clean-up can be done independent of how an option
that yields a Boolean value can be spelled, i.e. whether we'd accept
--frotz=yes or only take --[no-]frotz.
