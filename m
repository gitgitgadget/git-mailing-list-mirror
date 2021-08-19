Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA15C4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 23:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39B74610E5
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 23:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236854AbhHSXoA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 19:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbhHSXn7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 19:43:59 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E5BC061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 16:43:22 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id u15so4868348plg.13
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 16:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=T0KMsjJ9+OUMsU4MJFFF7FPnDuL0e8A+dMlNwo4uPaw=;
        b=Hy41vH0HLUcgrepXwJLQhYjQ2ClDZ/6sVq+RH1OLYfkyYqckxMUBzdBK79VAM0Tk93
         EqIWsf/Coxj00p34tHZ4YEk1n7MvF1BijHsweOp2i1kV2CZ8V89SE265HVzUHtZAD+Zk
         C+PCvU3UPvBDHLdyXriFXoMI/SJ//UwfatWff17s6bN2bf0Ljmk8zpkbFyFy3d+SR2EG
         mQxM0r9xdbq75RjChxApaBkCW9ZTR9zx6+aO+Vt18JPaA2OwaDBbzi1W0JnMaQ1XG8ql
         OOksR43pK1PNEhAmicVT0Jm+QbhPnF1PTGjIjAXicdbZyrGpyIfF8CI/0D9bdhhxnchq
         /d1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=T0KMsjJ9+OUMsU4MJFFF7FPnDuL0e8A+dMlNwo4uPaw=;
        b=JJO88wdH06O32FMlCjb8aFK7KQ/vqkSpKZ27eEuetO03FKvMFhf2qXSqjt3RFafW01
         EHAMHYp2EMCHMt0OH2KzuMnI0cqH2K90MuFvyhsiXdlGtYwBOb/xfBrFiIzPMaGuRCwJ
         TmHwxVIW2KcLx+E2j3d5rsstoD2xHmsc7UjxCLL+1sPbDvYqafCQGCkvVsQKw37919Kd
         K44nw2Le9lRc/3GwdaStSqTQHrnTCk48p+UqO7cRNMRzDuXwV8HRHMwvdCyxUkm4lr15
         AQL4INyF3wK+YNygplIqWYASwu/YR75JONmetDi+C6fUhOCW1WH0+HYy2fAu1tUH2j7J
         UaMg==
X-Gm-Message-State: AOAM53105N2i+wBC0wEKTsmQ4iO0MVOMlmVVXyPgDI327IaX50IHZ+VW
        XY88Oyc2MJeQ8/q0iKWc7zrvaA==
X-Google-Smtp-Source: ABdhPJxisQBKeTTxO50+giXdp7UliyrbYj5fG1o3jCIknHkqy73suQVBP38UYe2FXtTT1/fmjLtXSw==
X-Received: by 2002:a17:90a:2ecb:: with SMTP id h11mr1434196pjs.159.1629416601990;
        Thu, 19 Aug 2021 16:43:21 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:5c:aa12:af53:acbb])
        by smtp.gmail.com with ESMTPSA id y25sm3565053pfm.80.2021.08.19.16.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 16:43:21 -0700 (PDT)
Date:   Thu, 19 Aug 2021 16:43:14 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 5/6] hook: include hooks from the config
Message-ID: <YR7sko1vKy1rpJR/@google.com>
References: <20210819033450.3382652-1-emilyshaffer@google.com>
 <20210819033450.3382652-6-emilyshaffer@google.com>
 <xmqqo89txdo5.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqo89txdo5.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 19, 2021 at 03:39:06PM -0700, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > diff --git a/Documentation/config/hook.txt b/Documentation/config/hook.txt
> > index 96d3d6572c..c394756328 100644
> > --- a/Documentation/config/hook.txt
> > +++ b/Documentation/config/hook.txt
> > @@ -1,3 +1,21 @@
> > +hook.<name>.command::
> > +	A command to execute whenever `hook.<name>` is invoked. `<name>` should
> > +	be a unique "friendly" name which you can use to identify this hook
> > +	command. (You can specify when to invoke this command with
> > +	`hook.<name>.event`.) The value can be an executable on your device or a
> > +	oneliner for your shell. If more than one value is specified for the
> > +	same `<name>`, the last value parsed will be the only command executed.
> > +	See linkgit:git-hook[1].
> > +
> > +hook.<name>.event::
> > +	The hook events which should invoke `hook.<name>`. `<name>` should be a
> > +	unique "friendly" name which you can use to identify this hook. The
> > +	value should be the name of a hook event, like "pre-commit" or "update".
> > +	(See linkgit:githooks[5] for a complete list of hooks Git knows about.)
> > +	On the specified event, the associated `hook.<name>.command` will be
> > +	executed. More than one event can be specified if you wish for
> > +	`hook.<name>` to execute on multiple events. See linkgit:git-hook[1].
> 
> Looking much better.  It now gives enough information to readers to
> understand (if not enough to convince that it is a good idea) why an
> indirection with "friendly name" between the event and command is
> there.  In short, <name> names the command to be run and without
> indirection, you'd end up having to write:
> 
>     [hook "check-whitespace && spellcheck-log-message"]
> 	event = pre-commit
>     [hook "check-whitespace && spellcheck-log-message"]
> 	event = another-hookable-event
> 
> which may give the same expressiveness (and may even be workable if
> the configuration were machine generated) but it is typo-prone, and
> a single typo, or even an insignificant whitespace change in the
> command, would destroy the grouping of "this command fires upon
> these events".
> 
> It becomes much less typo prone with the indirection, i.e.
> 
>     [hook "logcheck"]
> 	command = check-whitespace && spellcheck-log-message
> 
>     [hook "logcheck"]
> 	event = pre-commit
> 
>     [hook "logcheck"]
> 	event = another-hookable-event
> 
> using the "friendly name", especially if these entries are spread
> across different configuration files.
> 
> My original question was primarily because I thought the
> second-level <name> corresponded to <event>.  If that were the case,
> it can trivially be made simpler without making it typo-prone, i.e.
> 
>     [hook "pre-commit"]
> 	command = check-whitespace && spellcheck-log-message
> 
>     [hook "another-hookable-event"]
> 	command = check-whitespace && spellcheck-log-message
> 
> since the name of the event would be much shorter than the command
> line.  But since we are not grouping per hookable event (to apply
> the "last one wins" rule to determine which single command is the
> one that gets to run).
> 

To be clear, the config schema did work the way you describe until this
revision. Ævar suggested the change and it seemed like a good idea to me
(and the rest of the Google folks) so I changed between v2 and v3 of the
restart.

 - Emily
