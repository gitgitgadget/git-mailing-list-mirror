Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A62C4363D
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 09:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACC65207F7
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 09:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Imr+WAAz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgJEJyv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 05:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJEJyv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 05:54:51 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91007C0613CE
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 02:54:51 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id q123so6525212pfb.0
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 02:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lQGJ3bqheAJf7lXYDt09ikDh0yIhXGgoWp0hQQ6rwz0=;
        b=Imr+WAAzCMN4iInYRXPdhbhUvSVT0LVCho2iCQaoKRpGsoHHe6V8WFcJQluCHkDEKw
         H22DfHYw9L0n5zghyKLfi07CpJ+9gXQtc9a17MS7mEAkvmpXUYgNnzIaUiMq+Wbeuwbo
         4BTPeentOlpkOIFkp99N6QR3ClZ28P+H4tcXDv6buV7T96QUALV5S7F9BFjAc+ZAtu+C
         nGlstv530+SpWcWJqFFABtdr4dlbM+DZyAbf4qgfF6JMgpRu+/NCqFQuWVtbL95ckVVK
         OyCVnQli/JKHi5JZfKvEy7qGw8hSDaRw//4axkqw1hqur65CSgRGYCBg33q+AFe0YKaN
         lWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lQGJ3bqheAJf7lXYDt09ikDh0yIhXGgoWp0hQQ6rwz0=;
        b=RNRwdHdHCkOcweEWcd1qKZxOg/bAFto74ZuWDB3wH4neF8zvPza3BRoTp/q80szGgz
         +hSQaEXi2PcHCTdwi+3awrxuDy4dVn78r2HgdLejGRqJpPSK6RwsJE7XKyemTAXFfU5A
         hn2sP+cVT3TIwxqq8S/haecp0ZnqtskVxf7jBevZxoBKZ7mK4coMWnvTQM3UFQd5nfAr
         mUgQkA3Quhs3fIl9EGcxe/k6gl2RaEHm394l7mH/1KGfMzpy6XZzlP7N0osRTzsxIpGB
         XRdL5AqdL+BN1zQkz6erxmOskO6JN4Q65NPsq+2baCh8LPUx/+e1m/JNO7XHCRkjSuQC
         5ltw==
X-Gm-Message-State: AOAM530iuDbPmQCq9/6nOUSBIXqCs1hh18h33Wflb4WdjpWVuWJVo6fs
        5gIacYwFl93hKBbXII5kJzQ=
X-Google-Smtp-Source: ABdhPJw3BaKReHQCCU+D93JY3T8fA65cZpS0qD7dct81M2wtkfj5mSKy/64EvBhLbYlY5I6+RAfEbg==
X-Received: by 2002:a63:2246:: with SMTP id t6mr4218451pgm.103.1601891691146;
        Mon, 05 Oct 2020 02:54:51 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id i1sm12164138pfk.21.2020.10.05.02.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 02:54:50 -0700 (PDT)
Date:   Mon, 5 Oct 2020 02:54:48 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] t1415: avoid using `main` as ref name
Message-ID: <20201005095448.GN1166820@google.com>
References: <pull.743.git.1601888196.gitgitgadget@gmail.com>
 <d3f7b39a2f11f4b05195f62190f75c84475c237d.1601888196.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3f7b39a2f11f4b05195f62190f75c84475c237d.1601888196.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Johannes Schindelin wrote:

> In preparation for a patch series that will change the fall-back for
> `init.defaultBranch` to `main`, let's not use `main` as ref name in this
> test script.

Interesting.  I assume the issue is this line?

	-	git -C fer1/repo for-each-ref --format="%(refname)" | grep main >actual &&

I.e., it's not actually that naming a worktree "main" will break
anything, but just that the test catches refs/heads/main in the same
net when it does grepping?

If the commit message explains that, then this patch looks good to me.
Without such an explanation, it would make me fear that we have some
underlying bug in "git worktree".

Thanks,
Jonathan
