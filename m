Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4DCC6FA82
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 00:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiI0ASw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 20:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiI0ASu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 20:18:50 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E121A3455
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 17:18:49 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id d8so6564421iof.11
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 17:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ZmfCkPcKscJ4ciNIBFwnW9vd6Ln2VnkcVDUXvqF7pVI=;
        b=kFL40RERO0XCCqfiDtD5hp9vIldjEA/0XNgGsyiBRQjWijAh2c/5thJFJHh6WMV1ik
         COnDYCz8vtdbOddCcPZKRExCkjnpusxnL80MgFTdH7Vs0XMdUjty1ev60nqldkg3TMvA
         x139IATiWleUWP/2vdskq+16aSi1zebTAtO2i/F2vAn0klpvqRxY1ttqbDnI/dOwawBy
         apmBcnFBmEKWFBGUABcs5f6yZJZ1dZks9DjuAO0AJ8CORfI0ct5jzGhY1/zM9MmbagOi
         vUke91a/rPd3g/AZdP/MwjqFgMhAtrOlbUxnDPkfK9LRi1Q1YAbRtnCIsTy11e0hwzOW
         KMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ZmfCkPcKscJ4ciNIBFwnW9vd6Ln2VnkcVDUXvqF7pVI=;
        b=SQDAc8hyQZD2wKHVRGtQr5vYogqP+EUy2RxzTv34P0lsKDn829ysunvuciPR1FVUYK
         K0RlO+ICJgScpfXc6VBRp87hwkJaoOCzOyxwx50dWBhjGVcOVfzjHovk0cxD1ekuE6mL
         IRJ0zFJPuIS20GBpHCeb6ranbDeltjB2M7N2fmK7tk+zPGv3usfwzZCojP7xbmhS8oB8
         YjDze92iLc+xDNoIXeC/ya9TeTvBVaXM9Bw39vB4TSjVgUsoQ/p2va5hXlS73kg+7nq8
         NPzbreilDPg0rnPWyDreJMnKJTg3OVhgEiPBi4aHzKMAyPovHcVHNBhfYrHlEUlSXR9j
         wFGw==
X-Gm-Message-State: ACrzQf1eeJgHc1OxSyzFPp5s6/5ncZZ78N0u5Wg+EvmZuEug4diL4whD
        DqOUSAWlaOu9XqFC2+BaxdWBCQ==
X-Google-Smtp-Source: AMsMyM6ENadiKmH4e2vcUUt0d4RU5G36dG1CU5egU6Ohnc/6YlQ/TzlsupV/tH44B+A3RXdSTwHuSA==
X-Received: by 2002:a02:866e:0:b0:35a:1c86:2a5c with SMTP id e101-20020a02866e000000b0035a1c862a5cmr13054366jai.265.1664237928791;
        Mon, 26 Sep 2022 17:18:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o18-20020a927312000000b002f68a98e1c2sm93460ilc.50.2022.09.26.17.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 17:18:48 -0700 (PDT)
Date:   Mon, 26 Sep 2022 20:18:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] tmp-objdir: do not opendir() when handling a signal
Message-ID: <YzJBZ9QJWIv0hpXb@nand.local>
References: <pull.1348.git.git.1664236383785.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1348.git.git.1664236383785.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[+cc Peff as the author of tmp-objdir]

On Mon, Sep 26, 2022 at 11:53:03PM +0000, John Cai via GitGitGadget wrote:
> One place we call tmp_objdir_create() is in git-receive-pack, where
> we create a temporary quarantine directory "incoming". Incoming
> objects will be written to this directory before they get moved to
> the object directory.

Right, calling opendir() will allocate memory, so we'll get stuck in a
deadlock if the signal arrives while libc's allocator lock is held. So
we can't safely call opendir() there.

It does make me a little uneasy leaving the quarantine directory around
via this path. So I wonder if we should be optimistically opening up the
DIR handle? Calling unlink() in a signal is perfectly fine, so I'd think
as long as we have an open DIR handle we could call readdir_r(), but I
don't think we've discussed it before.

> @@ -3261,7 +3261,10 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
>  	}
>
>  	flag &= ~REMOVE_DIR_KEEP_TOPLEVEL;
> -	dir = opendir(path->buf);
> +
> +	if ((flag & REMOVE_DIR_SIGNAL) == 0)

Comparing to the zero value is discouraged. Consider:

    if (!(flag & REMOVE_DIR_SIGNAL))

instead.


> @@ -498,6 +498,9 @@ int get_sparse_checkout_patterns(struct pattern_list *pl);
>  /* Remove the_original_cwd too */
>  #define REMOVE_DIR_PURGE_ORIGINAL_CWD 0x08
>
> +/* Indicates a signal is being handled */
> +#define REMOVE_DIR_SIGNAL 0x16
> +

Perhaps REMOVE_DIR_IN_SIGNAL would be slightly more descriptive.

> @@ -49,7 +50,11 @@ static int tmp_objdir_destroy_1(struct tmp_objdir *t, int on_signal)
>  	 * have pre-grown t->path sufficiently so that this
>  	 * doesn't happen in practice.
>  	 */
> -	err = remove_dir_recursively(&t->path, 0);
> +
> +	if (on_signal)
> +		flags = flags | REMOVE_DIR_SIGNAL;

I'm nitpicking, but you could just write "flags |= REMOVE_DIR_SIGNAL",
or even:

    err = remove_dir_recursively(&t->path,
                                 on_signal ? REMOVE_DIR_SIGNAL : 0);

Thanks,
Taylor
