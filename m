Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C455C433E0
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 20:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E97D23998
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 20:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733252AbhAOUJV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 15:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbhAOUJU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 15:09:20 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FA5C0613D3
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 12:08:40 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id m6so6170991pfm.6
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 12:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DQZ81qMXXs/SJwRfaGjL7KXtNEfEIsSWPsLRTp2GaYc=;
        b=fE5Xyg0V5Sa0Q/VSxyiAHB5DG9ITXRP4v4E2S7muAiwJVFKqu7Kq6NUp1IRwX9ttTZ
         aDHtbbxjieFyJ8Rjm15r5OGDvo3vWesqTIniVMRTqG8PNdxHbADGXkSOieTDB08+bn3G
         Is7onMNQ50M5dqXQhTqUmaHCPH+GbCmmPeVeBfcKNnQXbE5UcqYjHCoAYu2FcMrvFtNb
         kn4KTb2F76qW/5oXT/fCy0Kh24fFksGhyOr6uIohTifBTMTNUcIZFNqDgm+zKre5nAyp
         iJM/+7lEt2zQoSVlDZ/YHEoGsJrvw7wVawX5ZGfmMq1QquH8Bl8X//aKnw5mUVuLiBS5
         1DlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DQZ81qMXXs/SJwRfaGjL7KXtNEfEIsSWPsLRTp2GaYc=;
        b=pwC4ya6Z/BZYM0qeL+7UVLJQuJCMzN3YQXg7ObtCDZSQ2wUhLR7ERlsOK8I6xHAml7
         7htwnZs1axpNshgPOofkbQV/OwjlWg2NwTbrBlo0auk4pp+yrFZ0oFKvDe1zqu7wlpWp
         mZBXJejI+AnKxqay563Zm+q5wu68QngaO+6TmA0TUCkJ9MxOtdJqkh5xC4oPaUl2Nu9M
         7McXeCUW5GPnmmP0hUBeZ/rxS6w3sPA7xYIMiOwDa7QKCK3VzM1jLMM3Z6N+rx9S1tkL
         JcNCrDoABLaaSfh/6t8tJJcdXmegiiOTK3YXDEBCTfMMejlQq/j8rREVfHHLzr5apQKB
         O1Tg==
X-Gm-Message-State: AOAM5316BxkKud2nILbk5lLpR7LFT8G5ypzgiPhIkCsczhI05itwY3im
        lsEJNqNcw5riCcP6OJtGXweNng==
X-Google-Smtp-Source: ABdhPJxrL0Fm/cN3Cb/5Ml5SX01pD80++JV9MutqXvKjIeYuEMdB8m1Qk4LQQDEKmNdYTT4hCBilPg==
X-Received: by 2002:a63:e049:: with SMTP id n9mr14370602pgj.339.1610741319884;
        Fri, 15 Jan 2021 12:08:39 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id q2sm110264pfj.32.2021.01.15.12.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 12:08:38 -0800 (PST)
Date:   Fri, 15 Jan 2021 12:08:33 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2021, #02; Fri, 8)
Message-ID: <YAH2Qc/ad+P9Pf26@google.com>
References: <xmqqk0sni68g.fsf@gitster.c.googlers.com>
 <YADOf41CcaRuToD7@google.com>
 <15237c6c-98eb-0d1f-e6d5-2dda91c0ce09@gmail.com>
 <xmqqr1mmu2nx.fsf@gitster.c.googlers.com>
 <xmqqmtxau2kj.fsf@gitster.c.googlers.com>
 <49a151f1-a04c-703b-cf18-90cc503b0c80@gmail.com>
 <xmqqturirnm5.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqturirnm5.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 15, 2021 at 11:44:50AM -0800, Junio C Hamano wrote:
> 
> Derrick Stolee <stolee@gmail.com> writes:
> 
> > Thanks for dealing with this fallout. Sorry for the mixup.
> >
> >> Helped-by: Emily Shaffer <emilyshaffer@google.com>
> >
> > Would it be appropriate to convert this to a Co-authored-by?
> 
> Or more like "Inspired-by-a-patch-by".  Also you three have about
> the same amount of input and deserve credit.
> 
> Sorry, but it already is on 'next', which will be discarded in a few
> months when the new cycle begins, so I am not sure if it is worth
> reverting and reapplying with updated credit trailers.
> 
> FWIW, I ended up redoing the merge and did "checkout -m" to recreate
> conflicts, and then looked for "config.*pwd" in the block of text
> that came from the "part-4" topic and fixed them up manually.  I
> then compared the result of this new merge with the earlier merge
> that had the issue.  The resulting diff is what went into the patch
> you are responding to.  It is good that we had Emily's input as a
> comparison material to see that both of us independently touched the
> same places to fix.

Thanks for the action on this, glad to see it resolved in 'next' when I
pull today.

 - Emily
