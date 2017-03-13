Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3F831FC43
	for <e@80x24.org>; Mon, 13 Mar 2017 17:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752658AbdCMRvJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 13:51:09 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34374 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753413AbdCMRvH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 13:51:07 -0400
Received: by mail-pf0-f178.google.com with SMTP id v190so72148144pfb.1
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 10:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=R3UT3rh7Ts6MWLmWFx2MDPl/Sq4EA/F+r4kR6WZRd5A=;
        b=UKZiN14nOHTtcYAbkZAhHq+skWOb/UkeRi2v0OYcN90DFKzUlTtiup+m1vL0vNLWej
         dLDW5gHpTuyQuhDK8217FhEBAavrK9rW+wpMG3dNkR9Wy3R0+gnF8qNZnoPKuyvxbKiF
         +ZQWddclXLAXaW5TQmouXXw25J9Txm414HV69QsmFXV08JWcqalXSzjfPV2komapkcvU
         2rdyGplUVj6jIGGDYaheCDiGvp/8SMtniLzqFJFG4czAd3Z7eTa2cAjo5l3BGCQPWGT3
         UBIMWwP/u9Lt4lxJEY90+TTIGHxns2UfwTReEcXxyQACWawd5iZDrxZr4FwWpEbUZXM7
         EzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=R3UT3rh7Ts6MWLmWFx2MDPl/Sq4EA/F+r4kR6WZRd5A=;
        b=opheut45LJJxjiOPpLzSaHA8X0FQha/wxUy1Scp3MSh5iWiRlq9EF9RpJDsRUUPqAY
         cdiw//uEa4RvjcjX+MFl1Yjhzv0860HX3O4WXbZyi3MI1OqO0lWxO19vfdWOxyBJ5yPm
         bE2Gpf0n40vyuREkptBZ7rr2ULleOd3LAjhQ3slxVPxJG2SuHBaZ8olA3IBxv4cO1p6M
         Rfk9zHswl3oE+NEgDM5dIMKVEh2rfV6+jMzUYr/fHfkZU4gfnSXjHogAwh7BN+s8fmM5
         0rYRg/StDTcVaCaI/TcUgBV20krjgb7bKDtacxKtFxB1ssn8T634IJutkF6dE1N7xLrS
         sz5A==
X-Gm-Message-State: AMke39mRb3y4tnDA/aChL2F614zTLg/BZfEN3UbynjY2AuuIYhGpoJOyLiy5gFpHLL7dO/QHVYw5v5XJYdGK6xa9
X-Received: by 10.98.198.78 with SMTP id m75mr39263271pfg.160.1489427466050;
 Mon, 13 Mar 2017 10:51:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Mon, 13 Mar 2017 10:51:05 -0700 (PDT)
In-Reply-To: <1489180018.10192.45.camel@novalis.org>
References: <1489180018.10192.45.camel@novalis.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Mar 2017 10:51:05 -0700
Message-ID: <CAGZ79kZmWaobW9e4iPY05y0N6PLcFphGnZmDHtrGKeV0Up70vg@mail.gmail.com>
Subject: Re: bug?: git reset --mixed ignores deinitialized submodules
To:     David Turner <novalis@novalis.org>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 10, 2017 at 1:06 PM, David Turner <novalis@novalis.org> wrote:
> Git reset --mixed ignores submodules which are not initialized.  I've
> attached a demo script.
>
> On one hand, this matches the documentation ("Resets the index but not
> the working tree").  But on the other hand, it kind of doesn't: "(i.e.,
> the changed files are preserved but not marked for commit)".
>
> It's hard to figure out what a mixed reset should do.  It would be
> weird for it to initialize the submodule.  Maybe it should just refuse
> to run?  Maybe there should be an option for it to initialize the
> submodule for you?  Maybe it should drop a special-purpose file that
> git understands to be a submodule change?  For instance (and this is
> insane, but, like, maybe worth considering) it could use extended
> filesystem attributes, where available.
>
> #!/bin/bash
> mkdir demo
> cd demo
>
> git init main
>
> (
>         git init sub1 &&
>         cd sub1 &&
>         dd if=/dev/urandom of=f bs=40 count=1 &&

We prefer reproducability in tests, so if we take this into
a (regression) test later we may want to
    s/dd.../echo "determinism!" >f/

> # commit that change on main,  deinit the submodule and do a mixed
> reset
> (
>         cd main &&
>         git add sub1 &&
>         git commit -m 'update sub1' &&
>         git submodule deinit sub1 &&
>         git reset --mixed HEAD^ &&

As of now most commands (including reset)
are unaware of submodules to begin with.
They are ignored in most cases, i.e. git-status
has some tack-on to (pseudo-)report changes
in submodules, but it's not really builtin.

A submodule that is not initialized
( i.e. submodule.<name>.url is unset) ought
to not be touched at all. This is spelled out in
the man page for "submodule update" only at this
point.


>         git status # change to sub1 is lost

The change is not really lost, as you can get it via

    git checkout HEAD@{1}
    git submodule update --init

This works most of the time, but it is unreliable as the
submodule may have had some gc inbetween which
threw away important objects.

Steping back a bit, rereading the subject line,
what do you think is the bug here?

* git-status not reporting about uninitialized submodules?
* git reset --mixed not touching the submodule worktree
* lack of --recurse-submodules in git-reset? (and that not
  being default, see prior point)
* submodules being in detached HEAD all the time?

Thanks,
Stefan
