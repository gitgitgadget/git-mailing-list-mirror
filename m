Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755F9C433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 21:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46A526120D
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 21:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbhIPVem (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 17:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbhIPVej (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 17:34:39 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5AEC061756
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 14:33:18 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id g9so9646520ioq.11
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 14:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=d/GpbinD5vmUDX6T4+2V8ju0cQkFbvjUtpPCr84MTXs=;
        b=LO1qVGKAXueHN3F93Hfi5Yp3qo1FKLzl5RJY3uOCBM48iAt+B1wUH4h6H2qeKORmB9
         20cHrcCNSoCahTqjf7dyfPKbX+ItLTrX26rE/pp7npwnhjECOLG6BLc10pBK+YUoikxg
         wY3olY/ZmDp1Fz4DLbIRl8RgCXkcg6pgwYwDh3nMTuPZwmS0NoyVnv71aWO7Q19DAW2l
         KSJV9mmWC6S1QNt1MGbaGB+p8jVrjFNo43P02XPVcoRlzF65uLJLkpcn2dx6GUvz3M8l
         yjp+YHFdu2MInQGY7oYSbS51ujW5csZRG4RfNx6lILVE2+tVDNXvqUYZB0TMd9sOpQh8
         m12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=d/GpbinD5vmUDX6T4+2V8ju0cQkFbvjUtpPCr84MTXs=;
        b=7X5PwqTPQnRa7gk15WG8kxhOzqtuKr/X8vxsa/aCeDD2I7jh2PAFdEwN7mec3MIeNf
         TJlLc17n4vgNZvMDUA3BQBuc5CE9LMif7teIAhH/KByU6HhKWSQzFYPFQoROc0UWM9mN
         Nh72E8F2VS1FqUO4zw0sF6bZIOHtPfd+Qk9wJRX/Z6HxbGS7n6xo7adAN9dco4bGAwgb
         X6XPnT2ZRMa+N82yjlSeESjPhOoEb+xWDkuEHQAbtzePg8nA9zGA2BJ4/lmUQJh73A/q
         GfqW59qcfq3sNNLfLpJv7Sb4xnICVvfKImjsM7E4m+SXcPQHKe4UqsqQVpQVjx4uoR/j
         2Htw==
X-Gm-Message-State: AOAM531G0mnhXGaPlxNPOVaeSVH1RaaLH3Kwx8pnluJoxns3c/nnWlFx
        N7SGL79qxJrLzObxHmwW5n6epg==
X-Google-Smtp-Source: ABdhPJyFL3vNycpW1NBAg5IEqoowZ7Ky3E5I1GffaNvmDciAGsIcrEDC/3T0oEsynS/UWxk1MZ8EAg==
X-Received: by 2002:a6b:e917:: with SMTP id u23mr6055837iof.19.1631827998283;
        Thu, 16 Sep 2021 14:33:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i15sm2358852ilb.30.2021.09.16.14.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 14:33:18 -0700 (PDT)
Date:   Thu, 16 Sep 2021 17:33:17 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v6 09/22] cache.h: move object functions to object-store.h
Message-ID: <YUO4HTcONhu15CSB@nand.local>
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
 <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
 <patch-v6-09.22-5b9278e7bb4-20210907T104559Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v6-09.22-5b9278e7bb4-20210907T104559Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 07, 2021 at 12:58:04PM +0200, Ævar Arnfjörð Bjarmason wrote:
> Move the declaration of some ancient object functions added in
> e.g. c4483576b8d (Add "unpack_sha1_header()" helper function,
> 2005-06-01) from cache.h to object-store.h. This continues work
> started in cbd53a2193d (object-store: move object access functions to
> object-store.h, 2018-05-15).

This builds with DEVELOPER=1, likely as a result of all of the includes
on object-store.h added in cbd53a2193d.

> diff --git a/cache.h b/cache.h
> index d23de693680..11a04a93436 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1313,16 +1313,6 @@ char *xdg_cache_home(const char *filename);
>
>  int git_open_cloexec(const char *name, int flags);
>  #define git_open(name) git_open_cloexec(name, O_RDONLY)
> -int unpack_loose_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz);
> -int parse_loose_header(const char *hdr, unsigned long *sizep);
> -
> -int check_object_signature(struct repository *r, const struct object_id *oid,
> -			   void *buf, unsigned long size, const char *type);
> -
> -int finalize_object_file(const char *tmpfile, const char *filename);
> -
> -/* Helper to check and "touch" a file */

I'm fine to drop this comment, by the way, since it does not add any
explanation to what a function called check_and_freshen_file() might do
;).

> -int check_and_freshen_file(const char *fn, int freshen);

Everything else looks fine, although it's unclear how this is related to
the rest of your series.

Thanks,
Taylor
