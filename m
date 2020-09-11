Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9702BC43461
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 16:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E770221EB
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 16:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="koxhExSD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgIKQve (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgIKQv3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 12:51:29 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D29C061573
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 09:51:28 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id f18so7797994pfa.10
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 09:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M2pYaXchMQzW4688aAjdQEboMTwi22TIJzJ35sJDMcA=;
        b=koxhExSDUDpHCRqcnEAMVJYbxF5Wuveq7wrRR4quYftruzNJCQeRvdM2Seel+K0gkw
         074NqvCpRxlckbrK2WczRufwbJdj547Dq+go0Temui97JRr0wChoCwNOpd6iT4SVVkM/
         cg9vYuv8opo17dy8S9KVFe8Lq7ALtl7o1rs7YILK/W+/6Kmv6h5oWzC49P2riuIB/cyg
         /Gk7Hhj7L6MU4dkx+dEvwm3DoswdKQZ2lXnT5stSvpdHFgGIZUuDo+UfH4pW4cCNjeQX
         J8q3qPVtnrCI/nEUqHuiikOgVwpG2gYzV9sRMKO5kKGeEBiNwx0OUsR8FLTQkhSyzai7
         gS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M2pYaXchMQzW4688aAjdQEboMTwi22TIJzJ35sJDMcA=;
        b=hw8VJY4Lyoj6+1V57tNNifwUuc2uOno8QOzYpe1vFm3dPMeQ3caLE9z+MJtBe/xIM+
         9+vFgdpjPtpPoigTS2vcfelq/l8IuJ3XjAkJovxWmzxzumnTnMMc1ZTAC2z8RQzaCeMd
         1AqGMTYoxqnPSoD4jo/d+xuW8OCCd1jmrt7eAF4o1N0QQVY6KMu1qr1W+Aa0Of5FMGBo
         /Fh3Tk4dfSqJ0pJgMGFsvT8hLu5YUgoguJ7aQG+e1w4shX1HKN9EzEYseMmirdB0jkXd
         T/LD5/xZzREl5qeuCOwnMSF5js1f513bJt7vXWj4P2HHTNs3E0fMXr7MTiM//G36llqf
         WdEw==
X-Gm-Message-State: AOAM531NdXOQ53YIcPeVJrespSFZtGMFIrDqpzeYxn5Wd9OnpUgNvi4M
        KBFw3xdF4v1E9HeQWOIw9NH1yyIiQyFgEw==
X-Google-Smtp-Source: ABdhPJyGDWeKbj1+76C00sbHlKCDv+u34xw2vBO+xwf2GmR6QYRjJ7R5zHdkc761rVX2lyuGRoZEOQ==
X-Received: by 2002:a17:902:c253:: with SMTP id 19mr2829685plg.65.1599843088181;
        Fri, 11 Sep 2020 09:51:28 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id gj6sm2489254pjb.10.2020.09.11.09.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 09:51:27 -0700 (PDT)
Date:   Fri, 11 Sep 2020 09:51:23 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 3/9] hook: add list command
Message-ID: <20200911165123.GE331156@google.com>
References: <20200909004939.1942347-1-emilyshaffer@google.com>
 <20200909004939.1942347-4-emilyshaffer@google.com>
 <9146d342-7b3c-091f-4904-e7d8696544be@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9146d342-7b3c-091f-4904-e7d8696544be@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 11, 2020 at 02:27:42PM +0100, Phillip Wood wrote:
> 
> Hi Emily
> 
> > +Global config
> > +----
> > +  [hook "post-commit"]
> > +    command = "linter"
> > +    command = "~/typocheck.sh"
> > +
> > +  [hookcmd "linter"]
> > +    command = "/bin/linter --c"
> > +----
> > +
> > +Local config
> > +----
> > +  [hook "prepare-commit-msg"]
> > +    command = "linter"
> > +  [hook "post-commit"]
> > +    command = "python ~/run-test-suite.py"
> > +----
> 
> I think it would be helpful to have a couple of lines explaining what the
> example configuration sets up

Sure.

> 
> > +COMMANDS
> > +--------
> > +
> > +list <hook-name>::
> > +
> > +List the hooks which have been configured for <hook-name>. Hooks appear
> > +in the order they should be run, and note the config scope where the relevant
> > +`hook.<hook-name>.command` was specified, not the `hookcmd` (if applicable).
> 
> Thanks for clarifying that it is the origin of the hook.<hook-name>.command
> that is printed. An example of the output of the config above would be
> useful I think.

Oh, that's a good idea - you're absolutely right. I'll do that.

> > +/*
> > + * NEEDSWORK: a stateful hook_head means we can't run two hook events in the
> > + * background at the same time - which might be ok, or might not.
> > + *
> > + * Maybe it's better to cache a list head per hookname, since we can probably
> > + * guess that the hook list won't change during a user-initiated operation. For
> > + * now, within list_hooks, call clear_hook_list() at the outset.
> > + */
> > +static LIST_HEAD(hook_head);
> 
> I can see a cache might be useful for the sequencer which needs to run the
> prepare-msg hook for each commit (it should probably not be running the
> post-commit hook but does at the moment) and for am which runs some hooks
> for each patch but until then I'm not sure why we need a global variable
> here, can't we just declare `hook_head` in `list_hook()`?

Yeah, I agree. I'll make that change with the next reroll.

Thanks for reading.
 - Emily
