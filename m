Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4706DC54FCB
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 16:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19F5021473
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 16:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qXoqCQsl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgDVQly (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 12:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgDVQlx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 12:41:53 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F34EC03C1A9
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 09:41:53 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id np7so1239105pjb.1
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 09:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cZooQ5/s/rmrWMY9oL5+RuQGjQ5Ph64bCpWoMCmvXtA=;
        b=qXoqCQslFqSPbjucBL6YB6bYd1xLSwd2KODEDhfJcD1L+9b55NkyPqDGqG3rOdkdhd
         fbWXtP1/KCb73h1lCyAQxqoCxhV7XxYVfGF37VvDPvuqYgQE6BAqQ1LEuXPUANl3jRoj
         zPmJ/KtxIC8Vi6A5FLd99bkUqxKbzHOzF5ObRYKKZEMaZ4qfM+u3j6npEuDdXzWP0JII
         Qiw5uRMYBjl7iyJcZbX7jsNWC8gPGgWhwIg2GdOOVe78tvIn/thP47Y2Kjv9RHBH2/s1
         +kE8mxbdTulcgv6WnyBYXX5ipUfVvJnSUSUxw9bjmCn+GvEDLLYef7aVzXQUpyQRVOVc
         osqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cZooQ5/s/rmrWMY9oL5+RuQGjQ5Ph64bCpWoMCmvXtA=;
        b=PTcKvZKfIONLh/HJ1waETqE07Rku+0AnYKoia74OdhAEaSELrWMHW8yl4/SJrXu9t+
         pzJylpOx3PZI1Vk3DfmtWXZ99QnXjwejbqDoDC0pPMA47dsXpqchdFpPnuijgyewTjoF
         1OKzDVHNOop4AAcNA7dgaN4D3qLPth0OlBPt4QK/IRkN7DvEL1K6Ykj4bZCHxQa1Rq/4
         bhk4AjY8GeZlSH7GzZeETSznrIj56kEe/T00oos/LIJOj8tLXxO9erNS9/yIcOsxiuAI
         uFf8NBLzvuV427tsUy75qJVIU74+eNUaDUZ30bHmL0KlDVnGMhgopf0+nUX9v2HEurQd
         Z6pQ==
X-Gm-Message-State: AGi0PubHpve0BLt5o6mRZh6PCh/yHoAh00boMQJ/lXSKp7Uffd0gR6Rn
        Yqa42O1aZzWDL5DBSvwVq+o=
X-Google-Smtp-Source: APiQypJwRQjsKxMcagb0tiL42qOTjGdMym1WcRJMC+rmqbc3ekXbiA194lpaS9JlRjmwq78slcTZ4A==
X-Received: by 2002:a17:90a:9f92:: with SMTP id o18mr12928664pjp.180.1587573712972;
        Wed, 22 Apr 2020 09:41:52 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id e22sm5538109pgh.14.2020.04.22.09.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 09:41:52 -0700 (PDT)
Date:   Wed, 22 Apr 2020 09:41:50 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH] config.mak.uname: Define FREAD_READS_DIRECTORIES for
 GNU/Hurd
Message-ID: <20200422164150.GA140314@google.com>
References: <20200422153347.40018-1-jrtc27@jrtc27.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422153347.40018-1-jrtc27@jrtc27.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jessica Clarke wrote:

> GNU/Hurd is another platform that behaves like this. Set it to
> UnfortunatelyYes so that config directory files are correctly processed.
> This fixes the corresponding 'proper error on directory "files"' test in
> t1308-config-set.sh.
>
> Thanks-to: Jeff King <peff@peff.net>
> Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
> ---
>  config.mak.uname | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Thanks.

> diff --git a/config.mak.uname b/config.mak.uname
> index 0ab8e00938..3e526f6b9f 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -308,6 +308,7 @@ ifeq ($(uname_S),GNU)
>  	NO_STRLCPY = YesPlease
>  	HAVE_PATHS_H = YesPlease
>  	LIBC_CONTAINS_LIBINTL = YesPlease
> +	FREAD_READS_DIRECTORIES = UnfortunatelyYes
>  endif

I wonder why we set up this knob this way.  A lot of operating systems
support fopen(..., "r") of a directory --- wouldn't it make sense for
FREAD_READS_DIRECTORIES to be the default and for users on stricter
platforms to be able to set FREAD_DOES_NOT_READ_DIRECTORIES if they
want to speed Git up by taking advantage of their saner fread?

Thanks,
Jonathan
