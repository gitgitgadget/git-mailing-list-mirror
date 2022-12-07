Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7258C4708D
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 22:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiLGWNc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 17:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiLGWNb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 17:13:31 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9C75B5B8
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 14:13:30 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id o13so8476264ilc.7
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 14:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GPxtWOXxLWX0wAlx9Ar3vYzY6vWUdHB8GI63reWx0no=;
        b=hIOvpRJh1smGxO3YqP/fGbxS58Jt66VUHL7TLvMX/xtCMOyiW8hUC+kvtQnzwDV3Tz
         EYX3G0ikxdRDgp3xcIZSAYu0rR1Q6xWL8HxnfwK/k3wxn3ZTa07yo1fsaKBECPk4z3xG
         0pC8sqA+CnHI8iylZcHDUfZYcUCLnZKgdccKqdFoRMwfkWNStOWPJrjFFpST1wHWaeIl
         glorqpPyVOOYCTi3kq4aPEXitHJWqAdRwAw27IgIxuIBw237BJxIaKsdt0+s1NxCbnIq
         /cSGTqInZZq7msY4A71HpuO0T4qbcYARQ8ZM5WxQ2Wr5KZrIEwi4j7Q+RGd908lHN2SU
         Me1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPxtWOXxLWX0wAlx9Ar3vYzY6vWUdHB8GI63reWx0no=;
        b=duQvorFROQ28BgJtC+3oPrq8IO0L94uYJbG6vThjQaRrGbl3DDr1vqS8ZCdH9dFdPU
         tblohKaegL9VjbLeueLTbDsQ6i83dEbEU9l7kJ+OVZNrABguD1290ZlRRjYVqTyW4pqg
         +cj/qwQU3Qb/qbZ1p89zCuebgIoGovdFi9TqvjfzDo2DSdM2n02ymJd9FrZbxF0FSfDE
         1hHNyH7qPsr+NOZuv7jFCqBeD0GDa+2Hn5oMKHlBi0zQJRWOTltrkJNz8L24LNiCrkuW
         BNwHW+V8ew/ULfCFqqxYBLhAwgMIkQsA72QOp3G6v0sDU/PNi/ptN3FDAFqh8CJ/XnVj
         Zg0Q==
X-Gm-Message-State: ANoB5pl4zYRaM37T6olyptnDRcHhIrXCY5wlfgp4z8rdrnhzo+Un8Iur
        zI444jQS4lG50a0euUj78D/pDAG9rC7d2Nrp
X-Google-Smtp-Source: AA0mqf5Jk/dnCBxnHqdmsYZu6I+RhmieGGCRvWw90J4mKBZvLGfLa4/Nm8PwIHIMPaV77q6PE2zAUw==
X-Received: by 2002:a92:130d:0:b0:300:ce7b:8bc3 with SMTP id 13-20020a92130d000000b00300ce7b8bc3mr599108ilt.13.1670451209959;
        Wed, 07 Dec 2022 14:13:29 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a5-20020a056638004500b0038a47afa8eesm3569304jap.96.2022.12.07.14.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 14:13:29 -0800 (PST)
Date:   Wed, 7 Dec 2022 17:13:28 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     David Caro <dcaro@wikimedia.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Skipping adding Signed-off-by even if it's not the last on git
 commit
Message-ID: <Y5EQCD4XCsN10HO+@nand.local>
References: <20221206170646.6lnpr6h7oprziy5b@vulcanus>
 <Y4/xSObs9QXvE+xR@nand.local>
 <xmqqlenj7t0b.fsf@gitster.g>
 <20221207084027.7dhyaatkzaawrg4g@vulcanus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221207084027.7dhyaatkzaawrg4g@vulcanus>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 07, 2022 at 09:40:27AM +0100, David Caro wrote:
> On 12/07 13:11, Junio C Hamano wrote:
> > Taylor Blau <me@ttaylorr.com> writes:
> >
> > >> I propose enabling it for commit, merge and am.
> > >
> > > So I think that there are some legitimate uses outside of 'format-patch'
> > > that we may want to keep the existing behavior. So I don't think we
> > > should necessarily change the default to have other commands outside of
> > > 'format-patch' start passing APPEND_SIGNOFF_DEDUP.
> > >
> > > But I could see a future where we add a new option that controls whether
> > > or not we pass that flag, perhaps:
> > >
> > >     $ git commit --signoff[=[no-]dedup]
> >
> > That sounds sensible.
>
> Agree, I will implement this then for commit for now, thanks!

Thanks, I look forward to seeing your work. It would be nice to
standardize on this `--signoff[=[no-]dedup]` thing throughout all of the
different commands that support it.

According to:

    $ git grep -- '--signoff' -- Documentation/git-*.txt

that list is: `git am`, `git cherry-pick`, `git format-patch`, `git
rebase`, and `git revert`. But there are others, too, via an include of
`signoff-option.txt`, so that is `git commit`, `git merge`, and `git
pull`.

Phew ;-).

Thanks,
Taylor
