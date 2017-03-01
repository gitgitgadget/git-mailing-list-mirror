Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DDA32027B
	for <e@80x24.org>; Wed,  1 Mar 2017 22:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753477AbdCAWxQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 17:53:16 -0500
Received: from mail-it0-f43.google.com ([209.85.214.43]:34829 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753464AbdCAWxM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 17:53:12 -0500
Received: by mail-it0-f43.google.com with SMTP id 203so108300259ith.0
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 14:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xNf94alWc9ZyrjVF0DWXm6G+b3xkOfWIQfc9VLkssMk=;
        b=u69a8OKy2h1wmsjclfTbosD4r6/lmkSzhfwa9NWdmlZbw2Ua2AxTJVisrefpbRVtfF
         vuvNMdxZY0UIiCdqejx7x8cqlKyPIjbHuty7cb38wlInm2KVfNmgvbqzS9JWYYq0k33A
         4PAk+dProywdtlHS1sfaSGrbP1oSSvvkXX6YaGQAwWHiS4niP14WoHOam1Lt+tGxJ4jm
         VZYgqGAMspNvrCCbg4ylP8S6qBVqbaCPJac/sWGOGiLzjE31lbvL+kylfGjTrFEZ/oKd
         J1DxsaNnIanNQWXDAFohmHFQuSkd2EoOmm6OoB5DcR4SiRIU+eQ1PQ5BVRvrLrbuoqj8
         mHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xNf94alWc9ZyrjVF0DWXm6G+b3xkOfWIQfc9VLkssMk=;
        b=DqCTWgQ+m6L0Fd5UomJXkTCKy/WMsq0ahvxBwXmtBrWNHKksoEdc3Hvk30s0WQOEhm
         jliPYDIenJqz8+inipH0TANeAN1UT7cSeQDoWkOAfTadueGq6d27BEYene2wdglquyC5
         4JQLfzARM7/tgDj16niAUgMwFHbfyf6VhnE0ROlNt93sE+2X7REE7rUZ7zUE8Q3nEEVw
         E2S0EE5HSFHP1ExJxIuxjk9axouH/H6Y0Foal2bhEbr4PvakWh5TNI27tbQQk80h3szr
         sx0u/aMMeIfIYdtGl1HtOWc0lcPQ7rlwLr2rMRxPw064+ufdzB29kxHx4yWm1j+Kzchn
         aciQ==
X-Gm-Message-State: AMke39n5cJ92TPCE/jlF0ZaasG4S52jGcnaZmGa1j/4w56HhvZjVpWbML9jy7hyrA7O6Smw7mjeOdqVkz6umEu4G
X-Received: by 10.36.164.7 with SMTP id z7mr6440268ite.116.1488405198926; Wed,
 01 Mar 2017 13:53:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.13.1 with HTTP; Wed, 1 Mar 2017 13:53:18 -0800 (PST)
In-Reply-To: <20170301200230.GA30622@google.com>
References: <20170223234728.164111-1-bmwill@google.com> <20170223234728.164111-2-bmwill@google.com>
 <xmqq8tov1ev7.fsf@gitster.mtv.corp.google.com> <20170301200230.GA30622@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 1 Mar 2017 13:53:18 -0800
Message-ID: <CAGZ79kb9Fhb0z5AbygBx9wNyLr-ovb-74xeaD8p+C5Xz9Dekcw@mail.gmail.com>
Subject: Re: [PATCH 01/10] submodule: decouple url and submodule existence
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

IIRC most of the series is actually refactoring, i.e.
providing a central function that answers
"is this submodule active/initialized?" and then making use of this
function.

Maybe it would be easier to reroll these refactorings first without adding
in the change of behavior.

Off the list we talked about different models how to indicate that
a submodule is active.

Current situation:
submodule.<name>.URL is used as a boolean flag

Possible future A:
1) If submodule.active exists use that
2) otherwise go be individual .URL configs

submodule.active is a config that contains a pathspec,
i.e. specifies the group of submodules instead of marking
each submodule individually.

How to get to future A:
* apply this patch series

Possible future B:
1) the boolean submodule.<name>.exists is used
    if existent
2) If that boolean is missing we'd respect a grouping
   feature such as submodule.active
3) fallback to the .URL as a boolean indicator.

How to get to future B:
1) possibly take the refactoring part from this series
2) implement the .exists flag (that can solve the worktree
  problem, as then we don't have to abuse the .URL
  as a boolean indicator any more.)
3) implement the grouping feature that takes precedence
  over .URL, but yields precedence to the .exists flag.
  (This would solve the grouping problem)

By having two different series (2) and (3) we'd solve
just one thing at a time with each series, such that
this seems easier to understand and review.

The question is if this future B is also easier to use for
users and I think it would be, despite being technically more
complex.

Most users only have a few submodules. Also the assumption
is to have either interest in very few specific submodules
or all of them. For both of these cases the .exists is a good idea
as it is very explicit, but verbose.

The grouping feature would help in the case of lots of
submodules, e.g. to select all of them you would just give
an easy pathspec "." and that would help going forward
as by such a submodule spec all new submodules would
be "auto-on".

Possible future C:
Similar to B, but with branch specific configuration.
submodule.<branchname>.active would work as a
grouping feature. I wonder how it would work with
the .exists flag.

Stefan
