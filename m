Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B2EC433DB
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 08:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81DC3619F3
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 08:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbhCXIqb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 04:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbhCXIqD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 04:46:03 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E74BC061763
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 01:46:03 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id l123so16823074pfl.8
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 01:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Kuk/20ZXwQoj/mhC0waVTvieSOs8GzbCcVj0+2dmoJY=;
        b=YF/KlzcCywm/wT+BizwzHNY/hV6Bc4F2T+dSWecnzLV3pKKhf93vZAhU0J7wHtosTK
         WwJceUz4L741d2eZkf4YjAE6mKA/mTHq7mesw2YsxOk3OvUDPn+rAMLxJxwCJpyXhVhX
         kwzXPpbmE82dOL0Rx4UsojvtnZmsKCO//OCo2+qusFl7+ZI/ZlOpvQXgjPZRS61x8eIm
         mH+SI37jA3FKlynicvKR8TgchtXnzNTGvbrzfsSk59X1vApEirH61jxMy1+zfF3eNpnE
         pws3tf76PtbU7KBMypA97tBhai6KYT+0clFDqulFtl0huVQ1wFzlYNhzQoO4ivIxU2Rw
         dIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kuk/20ZXwQoj/mhC0waVTvieSOs8GzbCcVj0+2dmoJY=;
        b=EHVwb00C5XtXi9zOVktsd04AxBuf2tE1LFMWs1nm1/3jJuCDkk7JG1tgwRKyG+lQ21
         o+pFOhUn2uvjNlF+48U8qBibync3yGy8OwZRcLK34WHXnKDGBQuSDq6ln6SoEop67HBB
         w5AnjQR1R5B2+SURGU8+ZZzLIBpujzZF7j8OsgyoPr1Tz+R9SZH6agN5BoU6u0mGyvQN
         kqZawqjOEFEYZh6bK6tZqwN4VVXDxxSINbuvxigBVE5o2VC/9JYKKIx3uZss1lEjD3Zt
         WIIsNiqLAwKtDpRJ96oU0O2t2Q8FgrCKApmc+M5CuHyj8999txoG3Ae7yZla8Y82FFfg
         YOBQ==
X-Gm-Message-State: AOAM530zfVkDfRDrO48fKpkA3LDn6D3csHBnX57+/utRjDjHGldCu/ZR
        7tlWjBc1oe7EjICQYe6rv1o=
X-Google-Smtp-Source: ABdhPJxmCqV7AJt5hKRdj+O59a8dt51//esw7oslyN70oysCHTkDXeSG2GZMJubfPXaVKeoU2RJa/g==
X-Received: by 2002:a63:e5d:: with SMTP id 29mr2060794pgo.450.1616575562969;
        Wed, 24 Mar 2021 01:46:02 -0700 (PDT)
Received: from generichostname ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id j35sm1697704pgj.45.2021.03.24.01.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 01:46:02 -0700 (PDT)
Date:   Wed, 24 Mar 2021 01:46:00 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v8] format-patch: allow a non-integral version numbers
Message-ID: <YFr8SBRuwfqHriA1@generichostname>
References: <pull.885.v7.git.1616152884317.gitgitgadget@gmail.com>
 <pull.885.v8.git.1616252178414.gitgitgadget@gmail.com>
 <CAPig+cQBATCe4XFt1k0_EfYvb61_RVgTO0NGy6Ykg7frNPbtpQ@mail.gmail.com>
 <xmqqpmztcb6r.fsf@gitster.g>
 <CAPig+cSzapSDP1OZuFBPooEEChd4kBZtBbEx5YpsX3p0xzTooQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cSzapSDP1OZuFBPooEEChd4kBZtBbEx5YpsX3p0xzTooQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 21, 2021 at 01:54:15AM -0400, Eric Sunshine wrote:
> On Sun, Mar 21, 2021 at 1:45 AM Junio C Hamano <gitster@pobox.com> wrote:
> > Eric Sunshine <sunshine@sunshineco.com> writes:
> > > To protect against that problem, you may need to call
> > > format_sanitized_subject() manually after formatting "v%s-". (I'm just
> > > looking at this code for the first time, so I could be hopelessly
> > > wrong. There may be a better way to fix it.)
> >
> > Yes, slash is of course very problematic, but what we've been doing
> > to the patch filenames was to ensure that they will be free of $IFS
> > whitespaces and shell glob special characters as well, and we should
> > treat the "reroll count" just like the other end-user controlled
> > input, i.e. the title of the patch, and sanitize it the same way.
> >
> > So I am pretty sure format_sanitized_subject() is the right way to
> > go.
> 
> The pathname sanitization would also deserve a test.
> 
> Denton's seemingly simple feature request[1] has turned out to be
> quite a little project.

Sorry I've been quite busy the past couple of weeks so I haven't had the
bandwidth to review the patches as they've come up. Thanks for
implementing my feature request, ZheNing. And thanks for the careful
reviews, Eric.

> [1]: https://github.com/gitgitgadget/git/issues/882
