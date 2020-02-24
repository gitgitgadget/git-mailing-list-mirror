Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB05C35DEB
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 23:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB872176D
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 23:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="um9hV7Hg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgBXXq7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 18:46:59 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33200 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgBXXq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 18:46:59 -0500
Received: by mail-pf1-f196.google.com with SMTP id n7so6200859pfn.0
        for <git@vger.kernel.org>; Mon, 24 Feb 2020 15:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rrJuXlXZKwjJVqkmF9m/4jRvYXebwHtnovXnlbus4xc=;
        b=um9hV7Hgc3AkPj6/XNywtjNKsAtk3y7Ig/A/aSqFdW66+J0jDnaOPYtowIQsYcLw95
         wdmh7ogDW/ayyFLhkaL9JmZ0fLOykMQRERvYpj2y6XgksvzchHK/FRhVwTANkpzDzP/j
         jCGtPf4dBlPgiZwY8rLEL2aC9cFrfJjuhrevRRL71z9HPOz/zB83ml2rMUW5/O6Xj1R+
         j1XMKrGQVcJ9Xhv031QnthUblVrbKpK5JEOKDjBkqS6CvNOaamFRA9MlPd1RcvDoDaDR
         Yu1npKtE1SwEcvQzaLFG63IRNW+WDGmXraMucJi/AIy/0rEZwBgM5v+FuYjRXDBBTKSe
         23kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rrJuXlXZKwjJVqkmF9m/4jRvYXebwHtnovXnlbus4xc=;
        b=UhnI7Mg26YLhJ26uOTciebybVj/I4Qe3kFpTlZXTBRFHYMWis4qguMk9/xeYhQbcOn
         IeihvVsby5ara4cd6zw2fLZzhDmor3ooUMpjqXPmePuQmO0Ctnf7TBfNdIVlZefZJ8Vo
         pCBw/oEGoHFuPyN9FrCwXTKXSW4b+FwXx+OYZg/zSWAOHDwt2qDt1Z1iVlWqzcqtmJtE
         IMUEhJ8gQVYjDiB/XCMjFa2Zewc2W9BTRF5ejAewzAvsS0XNbkZbILNovPhY/BYW+ys+
         ESXZpXRFvMFP5NCD0kE6yEraPeAmrcPZe6hDaiCNuPcIVOGoHgYaQ7P09HWt1ozTftv5
         ia9g==
X-Gm-Message-State: APjAAAXMEhx90UPRzsViSoelOq3M2rnhGtWr1sgOtQPMhYv1QMbhwkzE
        UhcNuGTqpohuCe7HjtmS7+5THA==
X-Google-Smtp-Source: APXvYqxlYRTFRsmm1dgMahl4GY9OlbSn3XmSMf4i+DNWPvLL0oCYdQo3Db6KQWmN00k7tRY/a71zEw==
X-Received: by 2002:a62:ce8b:: with SMTP id y133mr13382548pfg.172.1582588018903;
        Mon, 24 Feb 2020 15:46:58 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id q66sm712667pgq.50.2020.02.24.15.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 15:46:58 -0800 (PST)
Date:   Mon, 24 Feb 2020 15:46:54 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH v4 3/3] tag: use new advice API to check visibility
Message-ID: <20200224234654.GC255447@google.com>
References: <pull.548.v3.git.1582144442.gitgitgadget@gmail.com>
 <pull.548.v4.git.1582557199.gitgitgadget@gmail.com>
 <3cc0a17123dc2575deacb62f762a35fef5f2c185.1582557199.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cc0a17123dc2575deacb62f762a35fef5f2c185.1582557199.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 24, 2020 at 03:13:18PM +0000, Heba Waly via GitGitGadget wrote:
> From: Heba Waly <heba.waly@gmail.com>
> 
> Following the new helpers added to the advice library,
> replace the global variable check approach by the new
> API calls
> 
> Signed-off-by: Heba Waly <heba.waly@gmail.com>
> ---
>  advice.c       | 2 --
>  advice.h       | 1 -
>  builtin/tag.c  | 5 +++--
>  t/t7004-tag.sh | 1 +
>  4 files changed, 4 insertions(+), 5 deletions(-)

More deleted lines than added lines always makes me a little happier ;)

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>
