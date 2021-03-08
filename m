Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE56FC433E6
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 20:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92A20652A8
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 20:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbhCHU2v (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 15:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbhCHU2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 15:28:25 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC47C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 12:28:22 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id t13so7181371qta.11
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 12:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6gT52hujsPQglxVMHQ+HqZkHga6J/QqPCckeuCgJCVo=;
        b=gwLPAdC8BGAKzk3q3i9QklmGRZGggY53AZLTVxARWavNZhjadpYw+3W0LwmnCdze/H
         USPoPf1kqbPtv83GQQcU035eoVKvhK9lcgdKnvh0tD8Vmu9tLrkmQJFj7nPR5HMxUjWA
         ApUI+RjECdeBiCcHu8beNReq2uBdZxtIZArLZZ3l7pbhkTnkbdblBiE2iFyvLTNCwjDX
         ZIoQwPDmZEqU3SITEXHhOaOTxWX2y4ES1+ZUVl1/+lZMSs1kAvVuwXilvhgW4Uh33dcA
         DWArkrw5SGYHLknUZQKypYtJkMoRMPnbN06MNtWSTbGmgSparsrb8ynRd9hr3Tgi9R3Q
         5E7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6gT52hujsPQglxVMHQ+HqZkHga6J/QqPCckeuCgJCVo=;
        b=XfKuk1meXpWszwLyz6DvC5IJpUWLJ/uq3gXi79d61W2G8ETAat6lbBtVFHXn4qBL49
         Kl6UZXPaFlp+0zMXSDOzHPWPhrBjtGO/F1Nz6TlH+SsaluAHWOH+ued0DAvoH7l0clhx
         FhbztqaSZiAUi1lk4YU4LzklY6QolujF+lNZCft/1UcVu1mfzxOrWl1SSH+R049EzDpv
         AsYAHVuXs4NyOUc1jsNGHxpvufr1G73sfeDow5t2h/Id1BjVLRp98wYk/rMh17qd+XXp
         8RwBCBgIGWKt+ZVuAzspnx0UfzcbVe+r68hF+ISKQkbOHNC35RcK+Ytgw0bkmKPHTntv
         sGVg==
X-Gm-Message-State: AOAM533DDf9s65NNuzupmPkjBPSwRdLzp2+sxgMQCuQiC/o5VRh3Eis/
        H+S+RVtp0ScDpZThRZwpCQqkhA==
X-Google-Smtp-Source: ABdhPJzjbvivJh0QLvD6SiTdoOTF930MIaOdWAr8wJcW8yJMBeAkCBVzeHj4UdDWXzDJ1vNLCh4u7Q==
X-Received: by 2002:a05:622a:54b:: with SMTP id m11mr22726639qtx.150.1615235302062;
        Mon, 08 Mar 2021 12:28:22 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:d4a3:1166:858b:6d61])
        by smtp.gmail.com with ESMTPSA id 7sm8730984qkm.64.2021.03.08.12.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 12:28:21 -0800 (PST)
Date:   Mon, 8 Mar 2021 15:28:20 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Fabien Terrani <terranifabien@gmail.com>, git@vger.kernel.org
Subject: Re: remote.<name>.merge missing from the git-config man page?
Message-ID: <YEaI5JIobsbtBQO1@nand.local>
References: <CAOuwed4HJLTgk48Fre5vGYjYanqD6hu8yZM73CpcAmF1ajiTnA@mail.gmail.com>
 <xmqqlfax7dya.fsf@gitster.c.googlers.com>
 <YEZwY0721KvQNkK+@nand.local>
 <87pn092yja.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pn092yja.fsf@igel.home>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 08, 2021 at 09:14:33PM +0100, Andreas Schwab wrote:
> On Mär 08 2021, Taylor Blau wrote:
>
> > diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> > index ab103c82cf..a953c7c387 100644
> > --- a/Documentation/git-push.txt
> > +++ b/Documentation/git-push.txt
> > @@ -600,7 +600,7 @@ EXAMPLES
> >
> >  `git push origin`::
> >  	Without additional configuration, pushes the current branch to
> > -	the configured upstream (`remote.origin.merge` configuration
> > +	the configured upstream (`branch.<name>.merge` configuration
> >  	variable) if it has the same name as the current branch, and
> >  	errors out without pushing otherwise.
>
> That doesn't say what <name> is.  Is that supposed to be <branch>?
> Also, what is "it" referring to in "if it has the same name"?

<name> refers to the currently-checked-out branch's local name. (That's
how it's used in Documentation/config/branch.txt).

The antecedent is "the current branch", so I think that this one may
already be quite clear if you read past the parenthesis.

Thanks,
Taylor
