Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6BCC433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 23:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbiC2XDx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 19:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240229AbiC2XDP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 19:03:15 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624A26C947
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 16:01:31 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id q11so22831721iod.6
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 16:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qYmrGht8a3UzWPHBLnYo4IBNUBjpXOzBDagv9fDE2sA=;
        b=8ER2wlEBghuVkGJ/wUjZRnVx9m+DHuq+Lg530n5q0cGQ17rr8Kk+T+Hz97ty9vsJqy
         7bvQhSf+j87Z/QLn95loc/G/OhW9P2uCHjcsqTLdmzf7kXKZ6eJI5FK2EeSbT+KLVAul
         zPXUEHsPUgHWVKDl3rQPjfTbiSDneJtK22n1/FgsePWRJ8jO3z1D7RKNnxVO75GLhdB8
         ckZJU3AK/bnugcbk0yQjKNcXXYvZqwhMENPe/4QCVwsu3d1dZBjS9MYTG4nJ29KGn8xt
         e2YYMJ9rSCMNm3o0zc+nrWPudW0Ms1reZqo00FNGBwNTzRNDmei664ap4S45/zOU208i
         pQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qYmrGht8a3UzWPHBLnYo4IBNUBjpXOzBDagv9fDE2sA=;
        b=vYsgC5AyhfwZEdLU+vEJ4fH31fSfLGLy9r8Dmedx2lQQ1ipCx0lrKc15A3WRCdjqy2
         lE6akdh5dewt/3pXJAHHgOsLXZ9FAWafdiQQS5slJg1FZKOFjcJDflmaLZcHGE4FM46y
         KZd0iPviY8qUmxjmkz2jZkBC7oIJYrchvQwZUX/Iov26LDeO0GZa8HFav/bJBb9JTwhT
         ybY4kcBs3/m9Ebs4mYODLZYAkecKtS+NYQ/vNq9iLL4HDke4Tv+3YWkyopF/il9qUovg
         EqGlj1PhO6sJe5plGYbCHzwXixaxS3Er1GjKodrl7nUaH+4ycG9gPIYI/8mBwKBg+qkF
         apFQ==
X-Gm-Message-State: AOAM532eZMPSi6eYquY1k8Hc2KvgE+bfNErx/+1aeKFM070iabr0oUtd
        1zw+aM0aYZPgCKykdX/gW8b7US2uQXtMKzkr
X-Google-Smtp-Source: ABdhPJyvVLfi69RXVEzoyMGyC9Z05B6hffhvHkDa4xPjccmPCF+paJQc7KpAu56uaRI8oLGvdiV8/A==
X-Received: by 2002:a05:6602:15cf:b0:614:52d4:952 with SMTP id f15-20020a05660215cf00b0061452d40952mr10077856iow.185.1648594890739;
        Tue, 29 Mar 2022 16:01:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j13-20020a056e02014d00b002c98acb8d32sm6618044ilr.45.2022.03.29.16.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 16:01:30 -0700 (PDT)
Date:   Tue, 29 Mar 2022 19:01:29 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com
Subject: Re: [PATCH v3 1/3] fetch-pack: refactor packet writing and fetch
 options
Message-ID: <YkOPyc9tUfe2Tozx@nand.local>
References: <20220208235631.732466-1-calvinwan@google.com>
 <20220328191112.3092139-1-calvinwan@google.com>
 <20220328191112.3092139-2-calvinwan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220328191112.3092139-2-calvinwan@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 28, 2022 at 07:11:10PM +0000, Calvin Wan wrote:
> A subsequent commit will need to write capabilities for another
> command, so refactor write_fetch_command_and_capabilities() to be able
> to used by both fetch and future command.

Makes obvious sense, and this was something that jumped out to me when I
looked at the first and second versions of this patch. I'm glad that
this is getting factored out.

> Move fetch options set in `FETCH_CHECK_LOCAL` from the fetch state
> machine to above the state machine so it is set by default. The
> initial state of the state machine is always `FETCH_CHECK_LOCAL` so
> this does not affect any current functionality. This change prepares
> for a subsequent commit that doesn't need to check the local state, but
> still requires those options to be set before sending the fetch request.

This took a little more thinking, but I agree that this is behaviorally
equivalent. The key points are (and here I'm basically restating what
you already wrote):

  - when the state machine in do_fetch_pack_v2() is in
    FETCH_CHECK_LOCAL, we set a few v2-specific defaults

  - it will be helpful for a future patch to have these defaults set
    _before_ we enter the main loop

  - and we can safely make that change, since the initial state is
    always FETCH_CHECK_LOCAL anyway, so we're guaranteed to hit that
    code whether it's in the loop or not.

So this seems safe to me, too. I'll have to see why this is necessary,
but I suspect we'll find out in subsequent patches, so let's read on...

Thanks,
Taylor
