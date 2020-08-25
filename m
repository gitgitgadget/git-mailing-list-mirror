Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6801FC433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 19:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D5412076C
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 19:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BZ3SL98a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgHYTmS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 15:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgHYTmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 15:42:16 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CF7C061574
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 12:42:16 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id kx11so17889pjb.5
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 12:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZRq5TqL7kIjLAu+WnVw10wLkzWqKyOjbs9r+KAX1EXU=;
        b=BZ3SL98a+QBR4HIwKAzVR3f7UQVYJCRSpxI23OS0XkkoJrk19HC4oDhB5bJnkNP89i
         rRMa6eOBEhJUxZWoOZ2IboyFGsD7mtq4CyEiUjbZ5C41M0mcwKamXdpZRcvRiNOVWFHj
         Qlofeisj2f05XP7j3J7iRmleCJ+QVNY7Ue3zgZeiGwFeh4LSzI+yopr1z9lBbuilOSiE
         bAt1U3fxhg5YrAXakBlbQb/0FMIJuuFpMR84jqaFSTSrFEquP7FJZnwDHJP96zriO36N
         9jfCdbyrUDfxQ17dh+Zw1j/iD1wqWQRFzjPEUedrKPGVJ9TRGO/6Acizt0ZiskZxTwsL
         1z+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZRq5TqL7kIjLAu+WnVw10wLkzWqKyOjbs9r+KAX1EXU=;
        b=RpTPkd1k9bPxINyWEPAWHkoAh9eq/6iz86qzetUtI8Aa5HOavZKHSY/K1IWyI7xcvB
         1AZyJ47R0OddouZF1d9C+lhSxF8kmwFkXxGg9orGAKiR+5Wogv1oNZ4wioEqLcEU0uov
         mRnw5mn3fgMIPjuGBGOPciIGDAn7nvkJWs2mh0IFf8lBj669AM57JzjqxgqBquBYVfi8
         oX/FX2aE0rzCGjkVutL8NbN5lVQDeVMAHFK8YtnQszgDQYdUYRJCmMjiMwZR52C8mTui
         ffSouBqn3QXo3PblB6tdwxbb2PFWhjlbFpNWPmNT5iH6gyZbEYW2pm93vfwKhqqd28NP
         y1SA==
X-Gm-Message-State: AOAM533Dm7E7mHJM2NJp9/eX+CHO7Ad1ZtrSYnej0kE5TMYgF04AADZU
        P78r9gHbW45julyGa8oFxZOu3A==
X-Google-Smtp-Source: ABdhPJx1tNLgaRIjEM14jbQdnO0ha401dyut1ZTbMYsILl3+llb4nZ2AXdR0qyIYoYtpfvZkPyQPgA==
X-Received: by 2002:a17:90a:4382:: with SMTP id r2mr888829pjg.144.1598384535351;
        Tue, 25 Aug 2020 12:42:15 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id t19sm20725pfq.179.2020.08.25.12.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 12:42:14 -0700 (PDT)
Date:   Tue, 25 Aug 2020 12:42:09 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2020, #06; Mon, 24)
Message-ID: <20200825194209.GB331156@google.com>
References: <xmqq7dtn3785.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7dtn3785.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * es/config-hooks (2020-07-30) 6 commits
>  - hook: add 'run' subcommand
>  - parse-options: parse into argv_array
>  - hook: add --porcelain to list command
>  - hook: add list command
>  - hook: scaffolding for git-hook subcommand
>  - doc: propose hooks managed by the config
> 
>  The "hooks defined in config" topic.
> 
>  Expecting a reroll.
>  Now jk/strvec is in 'master', we may want to see the topic reworked
>  on top of it.  Are there unresolved issues, or does the topic need
>  a round of detailed review?

I have it reworked locally to use strvec instead. I see in
https://lore.kernel.org/git/xmqqsgd8606c.fsf@gitster.c.googlers.com that
you were waiting for another jk/strvec reroll and it looks like that's
happened now, so I'll rebase this series against 'master' once more.

I'm ready for the first four (five?) of the series to receive a detailed
review, but I think it's premature for the 6th to be considered before
I've seen what the conversion process looks like for existing hook
callers. That's my main focus right now, although it tends to be bumped
by concerns for the summit next month as well as pesky life events.

 - Emily
