Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A8CC432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 20:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4B9360F6C
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 20:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236481AbhH3VAE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 17:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236453AbhH3VAD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 17:00:03 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D141CC061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 13:59:09 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 17so14651968pgp.4
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 13:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UraZnwMDGbB6CN5JX1JDKImNz4rfFz4WgPNDZxgz+To=;
        b=JqKBw2WVOjtR+4HK+kcbPY6CEkviXSoDvWwFMi8ws+cMRwV0CytB8GefuLs7atYJ8t
         Q+8aRI724tEbPN293UEOXP5VoVsCl2zgFc1my8IwzHpH83jIboxd/9Mu95/S97bXRDLA
         ubnQm9ADK1dprN2t+PIpyhbCOiFP1Vj5pPEDOs0XPwTh7huFBBx0MDOTeJhRjiLqtMxD
         nckTmI8y3YWvyvyGGNHh8cNBDv/+TS3q0Jc+52g7gSI0RMN7w32uBs8e3jLIgsBg69qN
         FQtyP7St31PHyJkm3ICI643wr44ZzuCCJpfF5feV59yq07EMw4rkV8rUiQqjF11xCkNN
         HJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UraZnwMDGbB6CN5JX1JDKImNz4rfFz4WgPNDZxgz+To=;
        b=Ml3tF4moEFzjbgsOukDF3czXFrqTHdEOTCJqrMsrLN7rG440eD0dQc4MgJKA8fx4L/
         bhD+fRy4nQYsVkAauEIXSsP/q9XFOcVneTr/ddaU3Ejsb2Tcdx4T5J2seqeJvlOcRHVK
         8mbjM3antSuv8n/JBDa9RLUrdp/BwM7iPszX5pA3Br7ed+fe8v9GJw/+Cuya2MsYH+Ch
         +HgLW2jnWIQIRAwvMQUosFvXRtJykriDic4gxSINeMlu9guvmoqeTMusgZnUiS3ZbzyM
         Xf06Ivh5CXdDpr6OCwj7f8W3CH90AOHtpBDolONC0o+kvUV5a1xVckuBi3e58R4VWObb
         +rEQ==
X-Gm-Message-State: AOAM531uJ6bwQpyBWDF4mhTWJonWngekZlx2YEuq15vqFOpNE5S1KVUQ
        9BfNItoonUWW3tDB++MCe/Yru8mA33ABPQ==
X-Google-Smtp-Source: ABdhPJyhWnesHEEoGUaABrpJ9ImH8gWPJZ84DxtFC7uNb4TXLR5o8E6rEYJYetjSaoIumL2WE/8Wbw==
X-Received: by 2002:a62:5e02:0:b0:3ef:81bc:be25 with SMTP id s2-20020a625e02000000b003ef81bcbe25mr25252641pfb.11.1630357149179;
        Mon, 30 Aug 2021 13:59:09 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:3413:270:ef7d:5dd0])
        by smtp.gmail.com with ESMTPSA id x8sm5211668pfj.128.2021.08.30.13.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 13:59:08 -0700 (PDT)
Date:   Mon, 30 Aug 2021 13:59:02 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Mahi Kolla via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] fixup! clone: set submodule.recurse=true if
 submodule.stickyRecursiveClone enabled
Message-ID: <YS1Glp/U4WPu6XCp@google.com>
References: <pull.1006.v5.git.1628736366133.gitgitgadget@gmail.com>
 <pull.1006.v6.git.1628903396783.gitgitgadget@gmail.com>
 <xmqqy293ucju.fsf@gitster.g>
 <YRw/8tThN7djNE+E@google.com>
 <xmqqk0ki5xwk.fsf@gitster.g>
 <xmqqa6le5x1f.fsf_-_@gitster.g>
 <YR6Xr3SMZjlJ1ZaK@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YR6Xr3SMZjlJ1ZaK@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 19, 2021 at 10:41:03AM -0700, Emily Shaffer wrote:
> 
> On Wed, Aug 18, 2021 at 01:15:56PM -0700, Junio C Hamano wrote:
> > 
> > Narrow the scope of a temporary variable used only once and
> > immediately die, and rename it to a shorter, throw-away name.
> > 
> > Also lose a {} around a single statement block.
> > 
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Acked-by: Emily Shaffer <emilyshaffer@google.com>
> 
> Thanks.

Having not heard from Mahi last week, if you are happy with the
patch+squash, I think it would be OK to take this without waiting longer
for her. Up to you of course.

 - Emily
