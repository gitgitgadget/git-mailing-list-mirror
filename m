Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE68520282
	for <e@80x24.org>; Fri, 23 Jun 2017 20:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755141AbdFWU0d (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 16:26:33 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33788 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754945AbdFWU0b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 16:26:31 -0400
Received: by mail-pf0-f172.google.com with SMTP id e7so28163328pfk.0
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 13:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SyZJf4+PGHQeH8PXvWQEN4vjl1pwaPJkrGANooRVEZk=;
        b=YDQU5lwGGbsMdSrNdl00/20KfRKCVD5hjRtXPICbN9Ex5oY+Xzat5TtWUBB27H/5Pi
         BwWBQ7MautegQXZbQbxyW/R8Fprn5wIGwkBn238FCAFM4z1nNZXhK6aaWd0OF1N2Qw6H
         +bZoflTd482mKwaIorZ7d3PlZNjpKG8k5xnAMOwDZDqulnliWDN4XrbmvOXF144JaL7f
         h/E4mV8Gkk7ECI2KMO/i4ezV303zbkzh49dbTQ97yh1HlbkfcHzZzWEX2FSB7BzmaKMP
         ONonfNSP3PtHQiTnvp3sV6FNkSy7CJyWpgBJNadnBLrZIDcE0oIuVpXqOWi9V9LzTR/E
         f/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SyZJf4+PGHQeH8PXvWQEN4vjl1pwaPJkrGANooRVEZk=;
        b=nSY0fRlv+97xmDTMyLEV/gk9cWr/IAAjfArvtKhLH1EaFE4brtkbOEw6Agk9zufmpT
         dNd6hhQVwnIxB0Dx9dXu84DD8ADxM2f9UPYFYtFxGo8PshUjFywqIiRCgENWa5gqZoBW
         Oy8/ddovXpv5hSsx/QU8ahpYly9B56TWfj7/iL3t0sakttRhRCPyE7zr4xD7i5odah8u
         lC17/NJuaRkpkhPQS/0gky2UoK44sl9HvPW57HUehm+Xp/NadLNNeeisseeOsmTp62Ph
         dA270TrOiyD/UFC0nv7xcTz21KtXKj6pRzpLCT7ylBZ0JK/9fePDsywItAhy503XGXWC
         e9kA==
X-Gm-Message-State: AKS2vOzgzyW00FQzLb/vOS58YniVIGJ26fMiQ7mfghaOlXYj0GHxC24f
        kq1i20koTUgi1DtMcQtLsYD+YubJhWbo
X-Received: by 10.84.232.205 with SMTP id x13mr11114294plm.245.1498249590687;
 Fri, 23 Jun 2017 13:26:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.161.227 with HTTP; Fri, 23 Jun 2017 13:26:30 -0700 (PDT)
In-Reply-To: <20170623200427.26803-1-bmwill@google.com>
References: <20170623200427.26803-1-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 23 Jun 2017 13:26:30 -0700
Message-ID: <CAGZ79kZqjaXSrqawgDnxu58sSPWVm8kAhRxn69Sbo8_aP4rr6w@mail.gmail.com>
Subject: Re: [PATCH] submodule--helper: teach push-check to handle HEAD
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 23, 2017 at 1:04 PM, Brandon Williams <bmwill@google.com> wrote:
> In 06bf4ad1d (push: propagate remote and refspec with
> --recurse-submodules) push was taught how to propagate a refspec down to
> submodules when the '--recurse-submodules' flag is given.  The only refspecs
> that are allowed to be propagated are ones which name a ref which exists
> in both the superproject and the submodule, with the caveat that 'HEAD'
> was disallowed.
>
> This patch teaches push-check (the submodule helper which determines if
> a refspec can be propagated to a submodule) to permit propagating 'HEAD'
> if and only if the superproject and the submodule both have the same
> named branch checked out and the submodule is not in a detached head
> state.

cont'd:

We need this use case because Gerrit's documentation ingrains
this workflow in its users to use

    git push <remote> HEAD:refs/for/<target-branch>

And when both the submodule as well as the superproject
are still on a branch with the same name (and not detached) we'd
not be misunderstood by the user on the syntax.

More on the code later.
