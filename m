Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24BFC76196
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 21:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239609AbjDFVPC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 17:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjDFVPB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 17:15:01 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3C0900C
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 14:15:00 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5491fa028adso267091217b3.10
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 14:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1680815699; x=1683407699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e8QJeyY7bIXYN0L7xyNXTAR8SFWFZ0W2IWVgt7f/7M8=;
        b=grqAqoJXv6pBLWSPA/211OuxN9KqM5huB6S0IS332hV/Uz8KHTg5tqbDjXlQPzzMf6
         3CKo+Vjc1KfJQ9SdJhBulT480xA9CzerpbMf5A5zmpBF4GT3rfwHA4h2Jzi09q0MnZZp
         eUZhYQBo38oOeT1rBmfZQSrodAtkyd4PdavUQkR/6kl+CI0MELkgq42TYma24zIGeuwQ
         +WzmJQCFLQjaEj5KcANEMzKv/PfXhpZdAVHBDycKOo9ez+h6CD+kmWG8IjJRO7WtA0NS
         TTEl/YrkX2yB7MYdNBj9M1mjDzjopZV1Se77RchxaC4cW16KVWdC8+gbr4oBG3Smvbs4
         qYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680815699; x=1683407699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8QJeyY7bIXYN0L7xyNXTAR8SFWFZ0W2IWVgt7f/7M8=;
        b=auluUs2d1c4CdQPd4qKLCv3ZD5/zAk7aVdMwatPSG/0AxDDBwy1JT0K8wkXnhbTZWd
         Ut/Qe5j3ynccE+4RxMhFnhVPMjlEpb4kNOAMj7kHtYYTB1S7n1A2GEIooN1GQgO2cNcH
         ZZtUE1jdLXu55kH5Xb/9o/qnXOR9/LrBnsd9eeOai8l4+rkBN1IryRVUBKrTvGU6dmEy
         NoT4rkSzNQFWa0mJzmhhJyhgJE5L6XLCMbUH7BUb/0uNXwL1aI7TxLi1mKq0RoaNAvsK
         c/Al1joqZH/Z5JyT5a9OMPHKPw4hxdXc60NGERDCFX7we8iRUZ8Sw2ky5KZqOEEtEZ4a
         mcrw==
X-Gm-Message-State: AAQBX9dzUjM2KHxRjl7eShkyIBdzZOlemc+zy103Je+W7O8u+i8Eypkj
        GZrfMlgWktanXvowsGB06c9Qfw==
X-Google-Smtp-Source: AKy350aO0hGv1h8h+Ao4Lv/BP50OyQEJHgOFAA403Lw6rxILRtDQ9QqYfWJ0MfH4tL+O74WNqtvJsQ==
X-Received: by 2002:a81:928f:0:b0:546:209d:ee81 with SMTP id j137-20020a81928f000000b00546209dee81mr10476370ywg.2.1680815698918;
        Thu, 06 Apr 2023 14:14:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g37-20020a81ae65000000b0054c26b34e8bsm132978ywk.144.2023.04.06.14.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 14:14:58 -0700 (PDT)
Date:   Thu, 6 Apr 2023 17:14:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, "Emily Shaffer [ ]" <emilyshaffer@google.com>,
        Linus Arver <linusa@google.com>
Subject: Re: [PATCH] MyFirstContribution: render literal *
Message-ID: <ZC82US7vQpKKpOtF@nand.local>
References: <pull.1510.git.1680661709616.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1510.git.1680661709616.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 05, 2023 at 02:28:29AM +0000, Linus Arver via GitGitGadget wrote:
> ---
>
>  Documentation/MyFirstContribution.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

For what it's worth, I think that this change is very reasonable and I'd
be happy to see it go forward as-is.

Thanks,
Taylor
