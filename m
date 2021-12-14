Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E96C433F5
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 12:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhLNMLN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 07:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhLNMLM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 07:11:12 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C46CC061574
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 04:11:12 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id b7so3031836edd.6
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 04:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=MeDj6otYeoYsqUzTlEiW16eW5CM7UYKtl/gamSe8IJA=;
        b=mWpLtAYLz9okQUASoKpnnBnksVRVq0BuOxsa8Pf46RKCAR8M38BGrA30IVhPWhJLmR
         9e37SqWTB98nVqKvj0hxjbR9IZcY3uBb54jiXEt6PUEI3p83GRxaoSgtN80Rd4zmvfnj
         UAlikMq2/3JZnV1HzByzhI/tXp5ZhD1YNNBqzyh/k0mUUl9w3hihl8crfSCnMWEQmsps
         cjYeTx/MWXhRQMN4/4zveqxOk1JnOqS//24rNDTXS7uYaDSaBt0I3GIGjpT1Wb9N2nZQ
         mYRdcTs8t4wezqCJ/8muBCVEemRKQLJuy3V+FmxBVmD/NTF5SgPN756AM/jgRgKpQ4bg
         +phw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=MeDj6otYeoYsqUzTlEiW16eW5CM7UYKtl/gamSe8IJA=;
        b=HZi+QotFAJZqAa0IU53FvGqwDmnbXBQdo3oN/JNyEcMa1564jEx209VQEzHliQBAhq
         hHTiPCyQBob7iC0V9YuCu4M9KOew+NgbU/uhdtWdQedF9b1tL45S8DEhXV/1pDOXwAVK
         N6SGrjZn6rQ7vtgEbVBkBmc5qwhElGiA4/npPXZA0f2PSSABDiiRVCsy/1nW19IN/34A
         I/U0oR2XuJEgKsHsQVJatLDA4WN/m0X8uz4ph0iBgjnEhyyMjvH69U+coRFfMXFxR/U7
         IE/oCyyB6n3Ub7CotU91Jfo76LQximSD0sCC/SIbw2vUafjdsJw5Lse8P4kPLKAfFwn8
         uCYw==
X-Gm-Message-State: AOAM531URxgns4I6xhqjhQnWJf2kbG9gfXBCZYOO52Z/NthU4bPOYqrg
        TNsPrirQyykXd1WDXbk26FA=
X-Google-Smtp-Source: ABdhPJx7s8VZLqdRd4otaJE2usUrktuxC0g7ZmGZkYKcD0jvl23P35mKpsZq8qc7niC+MFJqF+yOPA==
X-Received: by 2002:a17:907:3e8f:: with SMTP id hs15mr5266365ejc.251.1639483867058;
        Tue, 14 Dec 2021 04:11:07 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id 27sm912622ejm.41.2021.12.14.04.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 04:11:06 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mx6e9-00088j-ST;
        Tue, 14 Dec 2021 13:11:05 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jacob Vosmaer <jacob@gitlab.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] upload-pack.c: make output buffer size configurable
Date:   Tue, 14 Dec 2021 13:08:55 +0100
References: <20211213132345.26310-1-jacob@gitlab.com>
 <20211213132345.26310-2-jacob@gitlab.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20211213132345.26310-2-jacob@gitlab.com>
Message-ID: <211214.86y24nbd46.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 13 2021, Jacob Vosmaer wrote:

> Add a new compile time constant UPLOAD_PACK_BUFFER_SIZE that makes the
> size of the static buffer in output_state configurable.
>
> The current size of the buffer is 8192+1. The '+1' is a technical
> detail orthogonal to this change. On GitLab.com we use GitLab's
> pack-objects cache which does writes of 65515 bytes. Because of the
> default 8KB buffer size, propagating these cache writes requires 8
> pipe reads and 8 pipe writes from git-upload-pack, and 8 pipe reads
> from Gitaly (our Git RPC service). If we increase the size of the
> buffer to the maximum Git packet size, we need only 1 pipe read and 1
> pipe write in git-upload-pack, and 1 pipe read in Gitaly to transfer
> the same amount of data. In benchmarks with a pure fetch and 100%
> cache hit rate workload we are seeing CPU utilization reductions of
> over 30%.
>
> Signed-off-by: Jacob Vosmaer <jacob@gitlab.com>
> ---
>  upload-pack.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/upload-pack.c b/upload-pack.c
> index c78d55bc67..b799fbe628 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -42,6 +42,10 @@
>  #define ALL_FLAGS (THEY_HAVE | OUR_REF | WANTED | COMMON_KNOWN | SHALLOW | \
>  		NOT_SHALLOW | CLIENT_SHALLOW | HIDDEN_REF)
>  
> +#ifndef UPLOAD_PACK_BUFFER_SIZE
> +#define UPLOAD_PACK_BUFFER_SIZE 8192
> +#endif
> +
>  /* Enum for allowed unadvertised object request (UOR) */
>  enum allow_uor {
>  	/* Allow specifying sha1 if it is a ref tip. */
> @@ -194,7 +198,7 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
>  }
>  
>  struct output_state {
> -	char buffer[8193];
> +	char buffer[UPLOAD_PACK_BUFFER_SIZE+1];
>  	int used;
>  	unsigned packfile_uris_started : 1;
>  	unsigned packfile_started : 1;

Making this configurable obviousl has big impact in some cases, but I'm
a bit iffy on the faciltity to do so + it not being documented.

I don't think that the "static buffer" part here is important to anyone,
but the write() size is clearly important.

So doesn't it make more sense to have a uploadPack.bufferSize=8k
variable we can tweak, just make this "buffer" a "struct strbuf" instead
(i.e. it'll by dynamically grown), and then just flush it whenever we
hit the configured buffer size?
