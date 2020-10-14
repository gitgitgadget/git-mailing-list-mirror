Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07371C43457
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 01:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA10822257
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 01:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSvvilL6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388673AbgJOB3q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 21:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732256AbgJOB3j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 21:29:39 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440CDC05111F
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 16:01:23 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id y16so1749839ila.7
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 16:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QHzGd8p2d8B/hWuc8OXtYl3chqh5k9cIUu5Ocoa33rU=;
        b=kSvvilL6GEn1G3Kbt6f4d2fOK7Oe5rJRZOvfkmUsOlsCJks93lTpFuBC2PXmAtpWjL
         ZtebCfUyBQykf9tz0sy4O19WnUwQ42zjyQxmruVQdx77rnTXjy5xgzHIG+6ZNPJE6nkM
         la2v6A9tkXUG62YNZowfP9PtQuBT9JwnHuk5vBCxwfvfaccaFpD2rOXdfIYp8LRT6pjY
         XByhVC3kN/sy3LQ5jM/Wd7dT8hInjbXi2Vgu2v5WCecu1cvWo5XK2pHDa92szczbW53F
         J3SQXjBTrFzUS/KLetHs5bCq+LsYqvX2H8uId4QsAY3jpGHjdj38fP9mk24NMm2UtWm4
         T43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=QHzGd8p2d8B/hWuc8OXtYl3chqh5k9cIUu5Ocoa33rU=;
        b=hxcZ4rsztnIl5rlg77SK6NOdBSc1p9Plcb0b+3FPWoV0eTDro1Sfxq6jZyGk+pTnsh
         dqy5dnBPG6DFDq5SrUgveGAkZ27kqoiuh21f1sLSqX2bBtEoYTPIDkgmbRuRE24kaK4F
         /kftChYTGmZqPE49NCqZSOyugEK8eqyEh9K2SREQNHsKFvHoPq4fGmkfZwV8fTSSkTrW
         N5BsDrqJB+cQY55MMWcpNDP5T8rW1Y0twV7dvk+cL59Ry+L2lF240MtFeRlIBq8fSRe3
         h9VdHafJCNt4HkIhCK5rBeBY+hUp18ju62Gfy49tXh32kMs4e8+wb9V0X+qf3QZBXI5G
         DdIg==
X-Gm-Message-State: AOAM533Ai4zChxnzVQzB+o4TYbHNwu981M5WxOMXpvV3fRLyUPGOC7YY
        rmko1rpnlIdgy1loNfX2ndY=
X-Google-Smtp-Source: ABdhPJzD6n4ZfQJYnWNn+JwWkcMU419hh7Oa9Fqgk9bi+LXInTtin0MOl/4kGtxo2Q3IAWqlzWGW4g==
X-Received: by 2002:a05:6e02:547:: with SMTP id i7mr1200156ils.0.1602716482453;
        Wed, 14 Oct 2020 16:01:22 -0700 (PDT)
Received: from flurp.local (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id z9sm679773iln.87.2020.10.14.16.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 16:01:21 -0700 (PDT)
Sender: Eric Sunshine <ericsunshine@gmail.com>
Date:   Wed, 14 Oct 2020 19:01:15 -0400
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Michael J Gruber <git@grubix.eu>,
        Matthieu Moy <git@matthieu-moy.fr>,
        John Keeping <john@keeping.me.uk>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff King <peff@peff.net>, Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: [PATCH v3 1/3] t: add lib-crlf-messages.sh for messages
 containing CRLF
Message-ID: <20201014230115.GA14306@flurp.local>
References: <pull.576.v2.git.1583807093.gitgitgadget@gmail.com>
 <pull.576.v3.git.1602526169.gitgitgadget@gmail.com>
 <f17d182c3bf5e758490441801423cdb0da17060d.1602526169.git.gitgitgadget@gmail.com>
 <20201012224706.GA4318@flurp.local>
 <CC87B74C-5EC2-4129-82A5-2CD0C81188B9@gmail.com>
 <CAPig+cR3gsqmyM9k1F4waBc8R5Tqj0thw2_7E8Sun-FGV8b1SQ@mail.gmail.com>
 <FA717D92-3798-44C0-8671-83596429C388@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <FA717D92-3798-44C0-8671-83596429C388@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 14, 2020 at 9:52 AM Philippe Blain <levraiphilippeblain@gmail.com> wrote:
> > Le 14 oct. 2020 à 09:45, Eric Sunshine <sunshine@sunshineco.com> a écrit :
> >>> Le 12 oct. 2020 à 18:47, Eric Sunshine <sunshine@sunshineco.com> a écrit :
> >>>  create_crlf_ref () {
> >>>    branch=$1
> >>>    cat >.crlf-message-$branch.txt &&
> >>>    sed -n "1,/^$/p" <.crlf-message-$branch.txt | sed "/^$/d" | append_cr >.crlf-subject-$branch.txt &&
> >>>    sed -n "/^$/,\$p" <.crlf-message-$branch.txt | sed "1d" | append_cr >.crlf-body-$branch.txt &&
> >
> > The code I proposed is very explicit about using CRLF terminators. The
> > here-doc fed to create_crlf_ref() contains only the normal LF, but
> > then create_crlf_ref() explicitly converts those to CRLF by calling
> > append_cr().
>
> Sorry, I missed that. I'll try to see if I can make it simpler using
> this approach then.

By the way, if you also need .crlf-message-$branch.txt to have CRLF
line endings, then you'll probably want to use a temporary file (for
instance, .crlf-orig-$branch.txt), perhaps like this:

    create_crlf_ref () {
        branch=$1 &&
        cat >.crlf-orig-$branch.txt &&
        append_cr <.crlf-orig-$branch.txt >.crlf-message-$branch.txt &&
        sed -n "1,/^$/p" <.crlf-orig-$branch.txt | sed "/^$/d" | append_cr >.crlf-subject-$branch.txt &&
        sed -n "/^$/,\$p" <.crlf-orig-$branch.txt | sed "1d" | append_cr >.crlf-body-$branch.txt &&
        ...
    }
