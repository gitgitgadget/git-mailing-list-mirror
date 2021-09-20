Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C4AC433EF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 16:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28F5660F38
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 16:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238115AbhITQnp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 12:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhITQno (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 12:43:44 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2785BC061574
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 09:42:17 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id m11so22990332ioo.6
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 09:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b8dNjunK0BbUYN4IDfnBKjydoUSr2T3LheWaNxXWgk0=;
        b=DFmGmDgA/+vIUEjK2F97VEKVjQ+nCo1DPXUtRddQLDXRJQLlrFgzDHID+ZAQ0blNds
         jevvPMRjd3P719+8o27fgUDkCDN53h/nvX+tFLKW7oZOFvMuF2NUOtrPGWe8ds5sTC9S
         W6Ymqn6sfkA1dlJagsNWlUEL+e5YRZ+eP7YB18BZv2spWnAlcF89msZ2s58ESOu+2KRA
         LrwHGDVSAMZKhv2MdSTdIl8075Jq+RseBZE+96Az7qcA2AdBgKUB2H0Y1uYuRGxnEbr/
         rSQFsxxoPnXAMpwTfvpxMlQV/pjr1F/IjIGqca5WQ0EeOZzIEYvybzWuSwqUlxdIiaEf
         EWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b8dNjunK0BbUYN4IDfnBKjydoUSr2T3LheWaNxXWgk0=;
        b=wRAZhvizZaNarM5S2JTBDar1ajTsfTTEln7bVv+6ElgdueopBf8Ieo7k9XM+jzbliR
         JkDeoiK7EOCfLVxwmnNev4AZq9F28KbxnL/c62UE4H1jj4LfX4lKWLc1ABPzTae1tmso
         HAzV3C0kMI/RnUIrYcymT5e/BkDHXUcgOkOwpvZmA4q4joIc+tvNa9BRJFRKUOZROwPA
         esuK9xkG7tgWSd7TBjEAbczS5tQOt/sD5JwUdYScSWqGcCAFYuwr5Mc1+jcgt5rcx2CN
         wNZsjiNqnJzYg17c1RX4HXUqD3hl5C8KchRwAJ8CzLChGdqqYDJ9539/IjteGaE2VpYe
         0jbg==
X-Gm-Message-State: AOAM531R9erWpFfqQitWg3xpQQ8732nEz3sXAY1wrhxMAR6dYu89PcJS
        TyD0kXYLntUR0419aQzNZjp6fA==
X-Google-Smtp-Source: ABdhPJxNzj59mtB5j51QlH1J4rl6DYDVzfO77Icmt90FiY8cCmXSjtkpYCe+8VEx3/TU+06ClG4wEw==
X-Received: by 2002:a6b:7104:: with SMTP id q4mr11190023iog.29.1632156136540;
        Mon, 20 Sep 2021 09:42:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p14sm9365427ilc.78.2021.09.20.09.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 09:42:16 -0700 (PDT)
Date:   Mon, 20 Sep 2021 12:42:15 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Calbabreaker <calbabreaker@gmail.com>, git@vger.kernel.org
Subject: Re: Memory leak with sparse-checkout
Message-ID: <YUi55/3L9nizTVyA@nand.local>
References: <CAKRwm5a9PyqffEC5N__urSpNcZ-d5vz9GBM2Ei16eGS25B=-FQ@mail.gmail.com>
 <YUiuWSXO1P3JwerH@nand.local>
 <8a0ddd8e-b585-8f40-c4b1-0a51f11e6b84@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8a0ddd8e-b585-8f40-c4b1-0a51f11e6b84@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 20, 2021 at 12:29:36PM -0400, Derrick Stolee wrote:
> > So I think the problem really is that we need to drop existing patterns
> > when re-initializing the sparse-checkout in cone mode. We could try to
> > recognize that existing patterns may already constitute a cone (and/or
> > create a cone that covers the existing patterns).
> >
> > But I think the easiest thing (if a little unfriendly) would be to just
> > drop them and start afresh when re-initializing the sparse-checkout in
> > cone mode.
>
> This isn't sufficient, as a user can modify their .git/info/sparse-checkout
> file whenever they want, so we should fix this bug regardless. We could add
> a "Your existing patterns are not in cone mode" error.
>
> It might still be a good idea to let "git sparse-checkout init --cone"
> overwrite the sparse-checkout file _if the file is not already in cone
> mode_.

I'm not sure how helpful such an error message might be to a user in
this scenario without extra information. After seeing just "this isn't a
cone", it's not clear what they should do other than drop their
sparse-checkout configuration and start over.

It would be nice to have an intermediate step between seeing realizing
that the existing patterns don't form a cone and dropping them.

Perhaps we could include an error message and say something like:

    warning: your sparse-checkout patterns do not from a cone
       hint: to reinitialize your sparse-checkout configuration
       hint: try running:
       hint:
       hint:   git sparse-checkout init --cone --reinitialize

Where `--reinitialize` means to drop existing patterns. I suppose it
could be the default when transitioning from non-cone to cone mode, but
that would defeat the purpose of the warning.

We would probably want to perform this check both during initialization,
and when adding patterns in cone mode. It may also be worthwhile to
check the validity of the cone before running 'list' or 'reapply', too.

Thanks,
Taylor
