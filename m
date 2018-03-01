Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 820321FAE4
	for <e@80x24.org>; Thu,  1 Mar 2018 18:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033829AbeCASOd (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 13:14:33 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35708 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033762AbeCASOc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 13:14:32 -0500
Received: by mail-wm0-f65.google.com with SMTP id x7so13913421wmc.0
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 10:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=7iOR7hKeb8se+w0VP44lj2S3eOZgMUGvJkcA5qzWQOw=;
        b=Q6R+kfKATfhg+R5ExHR6nVtqqiAbvdSnX1n/Wwd6xT539w0TT+7aBT0B2e1ORPSFLU
         NzoCWQes1pzgCnYbcy+AeQvmILpK5ej3/BMu8yTAf7/ufpsfTW90ddgtWK3JaW47Zwu/
         114m1Wx8Ies7tpZadcW8OlT0t+Fvn7G1p4A0s8t8s20dErhbaTt+9KMUJvajnPFvv8ou
         uTHyIzaOQcoVC3l5IkpvZQ7m8R2i1eerUbYJkSE2INWGnEDvac7wW289sS01+cX43+Id
         QHDvo89cOMWOhLcvLVtPtTRMhoOvR7j5jUqV70xYdigJBTrb4L8sPq2O6iYvwR0HIl+d
         pzpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=7iOR7hKeb8se+w0VP44lj2S3eOZgMUGvJkcA5qzWQOw=;
        b=fuW0RfTFWO/d8v+R6sVksHbnD3gCQNCicAZv3IeTKRrrlF7OJqfDx/z+b81SCuEsvn
         5M/eRB1TaCAnYUqsMW0UEZQ6m0tud9U4ysnbneWrma1z6nemtwGG7p2i0QW9py2sFVfL
         fN1yi3NaZ1HtusIOysGtevZAAP/xYkSi/VmtJat8WN8rwJgIOS0VJUR3855nzFqhr6QG
         ZtUqAEJrmJ6QBQUOJkiOeOSj/AxsajNesdkQKgE+sIdKukkuMcHzAo4XnNPubParMuvk
         zqgDu6Y52DS5eElCZH3nYq+yYWSxrWDsEg8EbMqGQCHqC6TbUqcOBT3OMFOUL83h0VmN
         6i4A==
X-Gm-Message-State: AElRT7FJp1K+sWLPAwbWwT2TIcF6rN23X/5x7QtNyWY6/4Tkh4Grm/xA
        ANF5o12ur55dGa3WXP4t71E=
X-Google-Smtp-Source: AG47ELtdz4Bu8Q72CUoHa/KolRpMMlrsCEvXrvPOsUeOrwvPShSA2qLC7Ye0l1ihN3C1Wogev4NeYQ==
X-Received: by 10.28.32.202 with SMTP id g193mr2304556wmg.99.1519928070784;
        Thu, 01 Mar 2018 10:14:30 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 63sm4248291wmd.17.2018.03.01.10.14.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Mar 2018 10:14:30 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH/RFC 1/1] gc --auto: exclude the largest giant pack in low-memory config
References: <20180228092722.GA25627@ash>
        <20180301092046.2769-1-pclouds@gmail.com>
        <20180301092046.2769-2-pclouds@gmail.com>
Date:   Thu, 01 Mar 2018 10:14:29 -0800
In-Reply-To: <20180301092046.2769-2-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Thu, 1 Mar 2018 16:20:46 +0700")
Message-ID: <xmqqpo4nhddm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> pack-objects could be a big memory hog especially on large repos,
> everybody knows that. The suggestion to stick a .keep file on the
> largest pack to avoid this problem is also known for a long time.

Yup, but not that it is not "largest" per-se.  The thing being large
is a mere consequence that it is the base pack that holds the bulk
of older parts of the history (e.g. the one that you obtained via
the initial clone).

> Let's do the suggestion automatically instead of waiting for people to
> come to Git mailing list and get the advice. When a certain condition
> is met, gc --auto create a .keep file temporary before repack is run,
> then remove it afterward.
>
> gc --auto does this based on an estimation of pack-objects memory
> usage and whether that fits in one third of system memory (the
> assumption here is for desktop environment where there are many other
> applications running).
>
> Since the estimation may be inaccurate and that 1/3 threshold is
> arbitrary, give the user a finer control over this mechanism as well:
> if the largest pack is larger than gc.bigPackThreshold, it's kept.

If this is a transient mechanism during a single gc session, it
would be far more preferrable if we can find a way to do this
without actually having a .keep file on the filesystem.

