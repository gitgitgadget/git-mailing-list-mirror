Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73636C433E0
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 00:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 413302078E
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 00:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAhlRR/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387687AbgFXAqP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 20:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729700AbgFXAqN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 20:46:13 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EFAC061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 17:46:12 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b5so272968pfp.9
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 17:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bLYwr7hCR3FFW1NIBxYQu/CpcwH9X+On5Uel/TFH9oE=;
        b=aAhlRR/YNs5nE/iGRlWJzm0oGSHhbm1Q09Hee1HFeVyufIGRi8+tOUGGGoG7Ig2coJ
         NXRWLUwb6CIQnnAZ0OYAFkVlfqi3W4c+hPAlWFlSI8EBg/cIc9VbglSFW3pHd3vRs6Dz
         dhojXFC5e4oLVlvRPko1z10eIwtjd0Qry6MnFTBFAMd27PkROH7Yt/iOQblbM5RXhFfk
         DQWrol9hWZxcwilTdYLyrfQ7Q3nSF5vCPuOAFlLJZ5KpzuYeHcdiXFc07Ue16YG03HaQ
         Wo0+Fx20w8JmbK/Df2hBVb7o6Gs3Vwxg4IlO9NyltyDebBHFTZqjWU3IVTc4jc88adNl
         B5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bLYwr7hCR3FFW1NIBxYQu/CpcwH9X+On5Uel/TFH9oE=;
        b=sbxQGNBLWBpCmrdVW3L9E8k+Bgznx/ldluxxdlru5+YgCRuZwQ9Y6ZV1WsOFJO73eW
         lK6pwWrnKtof3zim4wV/FxwHXRRZUj4XrnRJ9f8jGJsJKLjDQRT6BjgglIDySe4RbNxu
         m5B1gLnSSbLbTH6hNWP2Ee27RyY1q2B/haA9Diwl+GUC8bQp9zlIAs1tldVGCvvb+3mu
         h3ji6wtPscjUGK8cJ50zdirebeQVh6HzglntTAeov7hs4WnlDolLPEc1Ax4x3Ms2qG7d
         3SMk1aTAbCn4iQHGhytBF4Jj3LkFDXhU3DqGHJmnWrY4YdJ52fOGL0E7U/hGfD4AAmob
         G6VA==
X-Gm-Message-State: AOAM532D6YsviDZToTWyiK8I8xhJzbcRlX2P2vfZ5Zwul7C0cAa5CXMj
        6qnqoguC/G4iteCUc+eVlDseHj8i
X-Google-Smtp-Source: ABdhPJwHo7ms6jNUubZzHSu2oytD+c5XeiZgxk//kbqZUZEV67Mr8We6AVVED5euCQe2AZ6f++2XZg==
X-Received: by 2002:a63:e114:: with SMTP id z20mr851311pgh.300.1592959571531;
        Tue, 23 Jun 2020 17:46:11 -0700 (PDT)
Received: from localhost ([2402:800:6375:9968:2644:616c:71ad:c7e6])
        by smtp.gmail.com with ESMTPSA id i14sm17769057pfo.14.2020.06.23.17.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 17:46:10 -0700 (PDT)
Date:   Wed, 24 Jun 2020 07:46:08 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/3] docs: adjust for the recent rename of `pu` to `seen`
Message-ID: <20200624004608.GA17052@danh.dev>
References: <pull.668.git.1592924655.gitgitgadget@gmail.com>
 <dc6f97129019e9176d91c77576a84549c00a74b5.1592924655.git.gitgitgadget@gmail.com>
 <20200623153106.GB20455@danh.dev>
 <xmqq5zbhd1em.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq5zbhd1em.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-06-23 12:31:45-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Đoàn Trần Công Danh  <congdanhqx@gmail.com> writes:
> > On 2020-06-23 15:04:13+0000, Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com> wrote:
> >> diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
> >> index 0a5c8b7d493..492e573856f 100644
> >> --- a/Documentation/git-ls-remote.txt
> >> +++ b/Documentation/git-ls-remote.txt
> >> @@ -101,9 +101,9 @@ f25a265a342aed6041ab0cc484224d9ca54b6f41	refs/tags/v0.99.1
> >>  7ceca275d047c90c0c7d5afb13ab97efdf51bd6e	refs/tags/v0.99.3
> >>  c5db5456ae3b0873fc659c19fafdde22313cc441	refs/tags/v0.99.2
> >>  0918385dbd9656cab0d1d81ba7453d49bbc16250	refs/tags/junio-gpg-pub
> >> -$ git ls-remote http://www.kernel.org/pub/scm/git/git.git master pu rc
> >> +$ git ls-remote http://www.kernel.org/pub/scm/git/git.git master seen rc
> >
> > rc is not with us anymore.
> >
> > Should we replace it with next, too?
> 
> I do not think so.  I think we never had 'rc'.

You're right.
Actually, I didn't read the context after the diff but went to
215a7ad1ef (Big tool rename., 2005-09-07) instead.

In that tree, there's a line for refs/heads/rc:

	b1d096f2926c4e37c9c0b6a7bf2119bedaa277cb        refs/heads/rc

Not sure why it was there in the past but it's fixed in
6077d36299 (ls-remote doc: fix example invocation on git.git,
2013-06-22)


> I think what the above example is demonstrating is this.
> 
>     SYNOPSIS calls the last command line arguments <refs>; they are
>     actually mere patterns (which is how these command line
>     arguments are described in the documentation).  It is *not* an
>     error if no refs match a particular pattern.
> 
> And because we have no refs that match the pattern "rc", we only see
> "master" and "pu" (now "seen") from the command.
> 
> I see a couple of possible improvements here:
> 
>  - The "<refs>...::" documentation should explain what kind of
>    pattern match is performed here.  I recall these originally were
>    just tail matches, but the rule might have been made more
>    flexible over time.
> 
>  - The example should first explain the setting.  The first sample
>    depends on the current (./.) repository having these tags or it
>    would not work (showing the sample upfront and explaining the
>    outcome shown in the sample would work well in this case,
>    e.g. "we can see that in the current repository, there are tags
>    X, Y and Z").  The second one at least needs to say two things:
>    the sample repository does not have a branch called 'rc' and that
>    is why it is not shown, and it is not an error for patterns to
>    produce no match.

I guess this is a leftover from 6077d36299 (ls-remote doc: fix example
invocation on git.git, 2013-06-22), if this was documented together
with said commit, it'll be less confusing.

> 
> Thanks.
> 
> >
> >>  5fe978a5381f1fbad26a80e682ddd2a401966740	refs/heads/master
> >> -c781a84b5204fb294c9ccc79f8b3baceeb32c061	refs/heads/pu
> >> +c781a84b5204fb294c9ccc79f8b3baceeb32c061	refs/heads/seen
> >>  $ git remote add korg http://www.kernel.org/pub/scm/git/git.git
> >>  $ git ls-remote --tags korg v\*
> >>  d6602ec5194c87b0fc87103ca4d67251c76f233a	refs/tags/v0.99

-- 
Danh
