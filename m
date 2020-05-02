Return-Path: <SRS0=N0vB=6Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76603C3A5A9
	for <git@archiver.kernel.org>; Sat,  2 May 2020 06:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AFF4208DB
	for <git@archiver.kernel.org>; Sat,  2 May 2020 06:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFhn9sDU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgEBGgc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 02:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726520AbgEBGgb (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 2 May 2020 02:36:31 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5760C061A0C
        for <git@vger.kernel.org>; Fri,  1 May 2020 23:36:31 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id n11so5643823pgl.9
        for <git@vger.kernel.org>; Fri, 01 May 2020 23:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OF7M+WzyCSaL73s9cFg03NgY9zUnqH37D1zKJxog9H8=;
        b=NFhn9sDUPwyA6sYsdu2P7rxzxuDKTg7Pg2sMiqUtV8NZDx9FOkNvMOfhmKdbpDWmnF
         16HyTrdlz1XtkBuWw8XxxZ3lB9OS9fJyqK5hZ/7egn8AfZnUkfoousQ0O41lV7eaZbQZ
         obbBTk6crJ7VNp0gXafWV8WKbpc4vi/Fk/ldCxx8xQiyKoOhOcTH0U8nk8B43zJsfhys
         OSQERcVBOH4qIwPKXNMQlZizDB2YNg9y/2WFB6AVYSoyoRFNzs66wewOfKdAz8yVg7Dx
         1vH8oFH9Nlz+yCLvxzCaIfctJQdmdaGbNW6B0F18Ut9M0/u+urnCu85Jcna+VAuTA+ag
         cn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OF7M+WzyCSaL73s9cFg03NgY9zUnqH37D1zKJxog9H8=;
        b=rOTsvCLGVeN6dbNuy8SYkXmNKhNLWgW4tTXC+nvxbev1mCPaNZG39TLmhwoDf50wSj
         9gQz3xIqutMKI2m4rMbXQqSXgb9DXX8VBxC6FWkY/tSVKl+WE5g6QCFqq2SQlej2n4Ze
         +htSj3C6Fx8E+RxLyAuTBYZnUFC1EbF2XI6XsH5ZY8E+6YIS5QhMZFYrJUc88BbsHL6s
         +T+d31WJmhwFGB9EZ1slEHKoFtdmA0qnv0bndNKUdps/YLnqfnrFzhDoe6dApCV5BJGr
         o/SbJu7/VB5oJpcK8xgdzXwGcb3ZCrj3EQ1XJOBS+VfcKfAAX9W06wUMaTlrR+9N3EyG
         dcyQ==
X-Gm-Message-State: AGi0Puba+23FZ5E59jmXpaMIboHQEqMf0BdZWTUL4EWFw/MnKQXZl2WP
        /NKEykW6q74T9mxH7J+rRvA=
X-Google-Smtp-Source: APiQypKLvnCXic/Zwfz6Q0DFXemzI416ljlV7MWkWJmwTkXuw6sfB5Jaj6JfwbNYT4vtHR3ZhBtoCA==
X-Received: by 2002:a63:3306:: with SMTP id z6mr7385853pgz.440.1588401391023;
        Fri, 01 May 2020 23:36:31 -0700 (PDT)
Received: from konoha ([103.37.201.175])
        by smtp.gmail.com with ESMTPSA id q23sm3492401pgn.90.2020.05.01.23.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 23:36:30 -0700 (PDT)
Date:   Sat, 2 May 2020 12:06:24 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH v4 1/4] gitfaq: files in .gitignore are tracked
Message-ID: <20200502063624.GC5582@konoha>
References: <20200429093811.8475-1-shouryashukla.oo@gmail.com>
 <CABPp-BGkZOyyoFiK3hsJ3FQq8MEBPy5aganHjA66vKFE20Wk0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BGkZOyyoFiK3hsJ3FQq8MEBPy5aganHjA66vKFE20Wk0Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/04 09:16, Elijah Newren wrote: 
> Mostly looks good, but I can't help but nitpick several small items:
> The first sentence alone seems to slightly undercut the answer, so
> it'd be nice to make sure the first two sentences are just one.  Also,
> it doesn't explain how people get into this state, which is probably
> something users are curious about.  The "To ignore and untrack the
> files" lists multiple end results, making it unclear which parts of
> the end results the suggested steps are addressing.  There's also a
> "staging are" typo (should be "staging area").
> 
> How about something like:
> 
> The purpose of gitignore files is to ensure that certain files not
> tracked by Git remain untracked.  However, git allows people to
> override the `gitignore` rules by using the --force option to `git
> add`, and sometimes people started tracking a file unintentionally
> before adding a pattern covering it to the gitignore rules.  If you
> want to untrack a file, run `git rm --cached <file>` (and then
> commit).  See linkgit:gitignore[5] for details.

This seems better, will improve. :)
