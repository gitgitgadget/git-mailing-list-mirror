Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82996C76196
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 01:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjDKB6l (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 21:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDKB6k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 21:58:40 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3028EE57
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 18:58:39 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-54f21cdfadbso81668417b3.7
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 18:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1681178318; x=1683770318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KfI//UUskaHlvjfdaQ/UGqS6oX+tn0saO8w0e21qAjU=;
        b=Xrvc5/e5gOt+0eV4/uKRIKcNyJVLw1dLvtnFW6IbfRClkKGovXA2lBOhsb8KVj+nsP
         56Gx/7A3GzKcQwTApIA1teyATp6yvQPaldg0vPwMWNCY2S93M4EHDTkUne5h0pdE1ooI
         GCZ5Y2ChH2rZ0kVJZmLxcGUeQQvddWhON0TgMx7OkCyl+h4z9XAwJpT27KxhnQGXGdw/
         spVmZZZoUkSQnlWJJ8SkLE741LfUeujPx8ecCKvu8KseSE/kV/Y8HGGd46npyqvRHIJ3
         vNQdOuCRktBSFWIp0wKcafYkrA7XZvEoO635XLb3r1Fx/J9mfXqPYHHW+/xNO+E4/ept
         YCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681178318; x=1683770318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfI//UUskaHlvjfdaQ/UGqS6oX+tn0saO8w0e21qAjU=;
        b=Z46QGHXYGURpJ2c7uFOVyeYasfv0Kn2DRuiwlHDctNP+NYVz1U8Gy/EueYpPbh1YMj
         IthwOsoJwW4xMu28lI7x8LKBDpGDkt8i+H9lUKtK2cqz9sLBgU9YoMHnfEBC9gLOXwDX
         T/D9Gm0S2X/KdSDaV95BMzqBfo9tmuiF+vHMW95vL6J2UubZ0qitzjWG9BhnL+HJHj0+
         Yi9FEp6UbSonm+h4eUP5ff5KIKQhQ2p8JhuaHtYr4hfeYjPHTWHybZHlKPiQJtsCH52S
         cp4LpcGLQqJfjnzkDbu8GpXgEmk7bkJRpeMIYYBGr5f0PYVd/U1LkJeg5LKI0myx7WvA
         f8fg==
X-Gm-Message-State: AAQBX9fTOS9TauXh2L5vT8I4i5QoTYMKjCUP8KD9C4aignRO+oSc3E+Q
        yZTHIzWfM8wYFrYgOEyZgICutw==
X-Google-Smtp-Source: AKy350bLkp+DFsqVBJDvZgCjtT1HFGB4e//nMySInl8DNyuE0w0XH4z9Bmar/URI+hcVcczuE+dipw==
X-Received: by 2002:a0d:db06:0:b0:54d:38d4:4f56 with SMTP id d6-20020a0ddb06000000b0054d38d44f56mr6669620ywe.26.1681178318221;
        Mon, 10 Apr 2023 18:58:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d187-20020a814fc4000000b00545a08184a5sm3195272ywb.53.2023.04.10.18.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 18:58:37 -0700 (PDT)
Date:   Mon, 10 Apr 2023 21:58:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v2] clone: error specifically with --local and symlinked
 objects
Message-ID: <ZDS+zJAilFqxMSqa@nand.local>
References: <pull.1488.git.git.1680652122547.gitgitgadget@gmail.com>
 <pull.1488.v2.git.git.1681165130765.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1488.v2.git.git.1681165130765.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 10, 2023 at 10:18:50PM +0000, Glen Choo via GitGitGadget wrote:
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 462c286274c..46f6f689c85 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -327,8 +327,17 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
>
>  	iter = dir_iterator_begin(src->buf, DIR_ITERATOR_PEDANTIC);
>
> -	if (!iter)
> +	if (!iter) {
> +		if (errno == ENOTDIR) {
> +			int saved_errno = errno;
> +			struct stat st;
> +			if (lstat(src->buf, &st) == 0 && S_ISLNK(st.st_mode))

I missed it on my first read, but you may want to consider "!lstat(...)"
instead of "lstat(...) == 0". Probably not worth a reroll, though.

Thanks,
Taylor
