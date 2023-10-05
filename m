Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F47CE9271B
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 17:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjJERmI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 13:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjJERmE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 13:42:04 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DFC9B
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 10:42:02 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-4194c3cf04aso7712061cf.3
        for <git@vger.kernel.org>; Thu, 05 Oct 2023 10:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696527721; x=1697132521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x5ujkpqp9dqX3s0sySle9RxDktyEIaXVVYsVn6dYqkI=;
        b=iWStTLkdDcoS6MKOu5V27gAHE8PJHeW28lvhLyzWmUKjMylQ4zqMNyKHksTi8XCHBF
         8abEkLg2br0i6Ls6EWABlOFH5SCoP0w467jmmyaSPMdpGixigOJQAG87BgOuWZjSTQmb
         Z7RH4zOV8YWI6lLg4m3YbJOrBAHgSGcLneHVxNQ7uxtXxpuWIQg/0mON5uW3qSJIXtca
         MKI+7lS3TR0AT/trFVQhEbqeAW+Y2orcv5t99JO7lT2Wdkm0JpvcZLR4yRT/kdhsqm0s
         /ASeqhPlGsIx6wi7hH7BezjB/QNOpW75h9I/gzW4PcPtcXBhArs3cf3n+BQKD31u9l/f
         uqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696527721; x=1697132521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5ujkpqp9dqX3s0sySle9RxDktyEIaXVVYsVn6dYqkI=;
        b=T/4dM58HxgT+8DNb60sg3BZGym1+s7Vkq7vC713wKjd9ZwdWRS+mLAgbpQ/5i94VrE
         bWgag3kvc51bJNVVBUYT+bv8jGC6hHAHkg8nQrZjli0oXuieMVuIRqeuosYLtXqH6JT2
         eCcCj0DKNE3f03QKi1sl+GEwGMnVynsDmEInRusJnVSp+WnJY7QaOOGywdxXyTwrKSRW
         X04XhqEHavPmqqwKZGXh1WXKqKtzK2rr7hGPUi2ABccPhDYMDgGP08D6WRWLbPNlMTRB
         HBn8sFIFBpcvz7ILgetQquQmdw+zgEjY0GpGxm5gO4b7pYLyQudXX6/2ZfDSvR3uGLOC
         E3Ag==
X-Gm-Message-State: AOJu0Yx/W038vherZUmmHaN2Y6c1Pu2ZsmzRwAXEAgGKMBjK104lHt1W
        5xOss4Pt41k1C7zVuQURirzn75Hm4AHNHEYLN1YLeg==
X-Google-Smtp-Source: AGHT+IE5rhdMeN6s8RVJCerWw50oE4nbCvEICylUbIthZg+6uUIYQ+G9HjHn/GIUkz4CNoP5oPX/vg==
X-Received: by 2002:a05:6214:5b0f:b0:655:ddd7:fcab with SMTP id ma15-20020a0562145b0f00b00655ddd7fcabmr6128951qvb.49.1696527721662;
        Thu, 05 Oct 2023 10:42:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q27-20020a05620a039b00b007757eb88172sm647858qkm.21.2023.10.05.10.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 10:42:01 -0700 (PDT)
Date:   Thu, 5 Oct 2023 13:42:00 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 03/10] merge: free result of repo_get_merge_bases()
Message-ID: <ZR71aA4RMoi2TcOJ@nand.local>
References: <20231003202504.GA7697@coredump.intra.peff.net>
 <20231003202724.GC7812@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231003202724.GC7812@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 03, 2023 at 04:27:24PM -0400, Jeff King wrote:
> We call repo_get_merge_bases(), which allocates a commit_list, but never
> free the result, causing a leak.
>
> The obvious solution is to free it, but we need to look at the contents
> of the first item to decide whether to leave the loop. One option is to
> free it in both code paths. But since the commit that the list points to
> is longer-lived than the list itself, we can just dereference it
> immediately, free the list, and then continue with the existing logic.
> This is about the same amount of code, but keeps the list management all
> in one place.
>
> This lets us mark a number of merge-related test scripts as leak-free.

Wow, getting 10 newly leak-free tests for half as many lines of code is
terrific. Woohoo!

Thanks,
Taylor
