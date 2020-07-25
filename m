Return-Path: <SRS0=cPh9=BE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E25C433DF
	for <git@archiver.kernel.org>; Sat, 25 Jul 2020 01:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55F7B206C1
	for <git@archiver.kernel.org>; Sat, 25 Jul 2020 01:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="vNwpdMtJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgGYBwn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 21:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgGYBwm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 21:52:42 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF27C0619D3
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 18:52:42 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id s15so554905qvv.7
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 18:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xuxIUs9FKguAH+gkyTk7ytRaoJCI0j/Ti+Mtb/XS71Q=;
        b=vNwpdMtJZEKQ/lkFrMh/uEQV6krLC+7hJoB0lcziOzxD3viTK+qYF7gkkah2TiuiwA
         SIi7Ec83vpT3cZqWrTwJ7lgqzptwZcfncq0dm7IYUi9jKTH9GmdDB5Zh29o/8xRSXiWG
         plCPSZkEBmEh8lleO58pwx1blApve7ONEcgw25uNXrEhx1UHsoeMGhIsBfrck3QRkrsV
         yyb0AOBvrTE5dbNvY3PmI3XYU2QtTXys1fZQ9g89F8uKgvEyqp0UEI/spXxRYcTmBYEu
         pu5etGqgMtshOnata5cpVii5lJsJOk3RI7S36YGUwa7F9Xyah/0bennfWvwqJHIR7SmZ
         qOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xuxIUs9FKguAH+gkyTk7ytRaoJCI0j/Ti+Mtb/XS71Q=;
        b=DpBJoHKhf34SPPikrLetN+fVh38H2RJHCaIdRaQsy+IFWyBMeEhA8XsVEfOOt3JRzH
         UDcAeKBw4hZppTUXinoU8T6pmlo/sPBsOsyJNm7ps/JkGeuE5DEK9s6EfvjhiQ/pwgmb
         33/l0nWDi6gj9C1YEtOgTi+/DRfwq3u0pXne7LaaWJEUY4k0rEf1P41j8z1eP0IyOZ5A
         g97pvfv1lLMjXR/viL0bzeYc9KayUnMZ2qzDvzS147v7SxnFX1Uwa3yRULfSjWc6XZtD
         HPU+AAxJKhUHIzY3DuVoOhZiL2DBs5GdNNnKFDq/yY8nypoHcapi/5afHyte6tTV3ZJg
         Si4A==
X-Gm-Message-State: AOAM531eQZTDV+hVUuSHUrqQ6vEnCROzP9E4MCgu0tFCIMFGfcT/kUXp
        Bk6TvoEnyRZXYaVHJ463ojRHog==
X-Google-Smtp-Source: ABdhPJxhS3JwQ4h77z7hd3suk2EmLk9jue7j8k/ZI6CMeGjo9dLJXRqHPK9RzqUdSXNCgePd4ugN1g==
X-Received: by 2002:ad4:5748:: with SMTP id q8mr11422148qvx.1.1595641961693;
        Fri, 24 Jul 2020 18:52:41 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:348b:af05:525a:6ad])
        by smtp.gmail.com with ESMTPSA id v5sm1800610qtb.4.2020.07.24.18.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 18:52:41 -0700 (PDT)
Date:   Fri, 24 Jul 2020 21:52:40 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 05/18] maintenance: add commit-graph task
Message-ID: <20200725015240.GD35171@syl.lan>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <04552b1d2ed751a11eb7c50f6898cbc078b552b4.1595527000.git.gitgitgadget@gmail.com>
 <xmqq4kpyq8wh.fsf@gitster.c.googlers.com>
 <b0bc5d89-52fa-e0f4-e3af-5eb6c76d312e@gmail.com>
 <xmqqy2n8lmq3.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy2n8lmq3.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 24, 2020 at 12:47:00PM -0700, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
> > But you are discussing here how the _behavior_ can change when
> > --auto is specified. And specifically, "git gc --auto" really
> > meant "This is running after a foreground command, so only do
> > work if necessary and do it quickly to minimize blocking time."
> >
> > I'd be happy to replace "--auto" with "--quick" in the
> > maintenance builtin.
> >
> > This opens up some extra design space for how the individual
> > tasks perform depending on "--quick" being specified or not.
> > My intention was to create tasks that are already in "quick"
> > mode:
> >
> > * loose-objects have a maximum batch size.
> > * incremental-repack is capped in size.
> > * commit-graph uses the --split option.
> >
> > But this "quick" distinction might be important for some of
> > the tasks we intend to extract from the gc builtin.
>
> Yup.  To be honest, I came to this topic from a completely different
> direction.  The field name "auto" alone (and no other field name)
> had to have an extra cruft (i.e. "_flag") attached to it, which is
> understandable but ugly.  Then I started thinking if 'auto(matic)'
> is really the right word to describe what we want out of the option,
> and came to the realization that there may be better words.

I wonder what the quick and slow paths are here. For the commit-graph
code, what you wrote here seems to match what I'd expect with passing
'--auto' in the sense of running 'git gc'. That is, I'm leaving it up to
the commit-graph machinery's idea of the normal '--split' rules to
figure out when to roll up layers of a commit-graph, as opposed to
creating a new layer and extending the chain.

So, I think that makes sense if the caller gave '--auto'. But, I'm not
sure that it makes sense if they didn't, in which case I'd imagine
something quicker to happen. There, I'd expect something more like:

  1. Run 'git commit-graph write --reachable --split=no-merge'.
  2. Run 'git commit-graph verify'.
  3. If 'git commit-graph verify' failed, drop the existing commit graph
     and rebuild it with 'git commit-graph --reachable --split=replace'.
  4. Otherwise, do nothing.

I'm biased, of course, but I think that that matches roughly what I'd
expect to happen in the fast/slow path. Granted, the steps to rebuild
the commit graph are going to be slow no matter what (depending on the
size of the repository), and so in that case maybe the commit-graph
should just be dropped. I'm not really sure what to do about that...

> > Since the tasks are frequently running subcommands, returning
> > 0 for success and non-zero for error matches the error codes
> > returned by those subcommands.
>
> As long as these will _never_ be called from other helper functions
> but from the cmd_foo() top-level and their return values are only
> used directly as the top-level's return value, I do not mind too
> much.
>
> But whenever I am writing such a code, I find myself not brave
> enough to make such a bold promise (I saw other people call the
> helpers I wrote in unintended ways and had to adjust the semantics
> of them to accomodate the new callers too many times), so I'd rather
> see the caller do "return !!helper_fn()" to allow helper_fn() to be
> written more naturally (e.g. letting them return error(...)).
>
> Thanks.

Thanks,
Taylor
