Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212EEC43331
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1BC664ECF
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355340AbhCCGeT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 01:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1835358AbhCBTDV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Mar 2021 14:03:21 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF42C061788
        for <git@vger.kernel.org>; Tue,  2 Mar 2021 11:02:39 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id bh3so3601847qvb.5
        for <git@vger.kernel.org>; Tue, 02 Mar 2021 11:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wQqIz+xPnVHcopYSRJV9g26/SlSG5sRF1WNLow6fI8c=;
        b=Tdfb5TvYQOTm+MhgMIvVAuX2DEc2yzE/BQmlgTN6QjcdejhqkJifocCUwQgY4eaWo/
         IuyV+G/6Qp4XLdfKeyVZlPtVRk80QVICDuRvm957pjmcHaJVcKDvCbtwR8q5tEesEV6P
         2miqU0qHUy2GpG4PMsUEV61Rvy4aV74+P910qzxdO+30hthOa1VnPQQ7nkucehxkBpaZ
         kPOd/6DdsErkqKCmDEbiCy++yM/m6DzxmqcQY2aIg4uKN7GEApdm0PwaWs9ljwy6ndiL
         nklLVcmaTM4ZdZfOtG7yyR5yW9E+0gzpiyg9qn2Jc/XFJKR3RrgGSMvwFbxKeHPkNdl/
         I3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wQqIz+xPnVHcopYSRJV9g26/SlSG5sRF1WNLow6fI8c=;
        b=JLnxCC5hZ94Z+DQHF8StCLHh2dGgs7x/1Olx5p8Srjbtsldk+QGEI5nU5nQ+aN0Y2S
         XchFsyaiCEJiqxDeB5wyNcbHUlHPR9d/RKLpN2GXtsWjppxBdyb7zFrdLHE7exTjGx8h
         c6nhgEChdZTL1XCS/dnsJKpIcy8WXxe/hCgdfHzrvZMcuDdQ2hcUie2FL5wWQU4ENIwh
         eqlB9ox8NiJ0Jhk+cwHTdyArL9UNZ8ovAclxpJ9/Zz/skIkKoTYEe482ioCO5jf+ObhO
         i2Pi33SDBjOHzvMd8foaF7zIfFvqJKnmj0vmGcji4dzzFK616T0S1msiUkDFkMeNsXOv
         +NTQ==
X-Gm-Message-State: AOAM533bf0//sUrJlABXA90FKLrDmhNOrYlPbV19JpLSI0c1SJJGLdXZ
        RCVEqi0doppcd3S0SbdA6eeKvg==
X-Google-Smtp-Source: ABdhPJxh9jIvbQSb14fX8NM4lb9VaMmsdLmFDvf+NIOhpFxcQvXQ5dG46XiZrVCklFpZIxqGz3iOWg==
X-Received: by 2002:a0c:fd63:: with SMTP id k3mr4947385qvs.30.1614711758577;
        Tue, 02 Mar 2021 11:02:38 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:1582:4add:dc39:710a])
        by smtp.gmail.com with ESMTPSA id g17sm3375588qtp.50.2021.03.02.11.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 11:02:37 -0800 (PST)
Date:   Tue, 2 Mar 2021 14:02:35 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        avarab@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v2 04/15] builtin/multi-pack-index.c: split sub-commands
Message-ID: <YD6Ly6EIcz4PT6uB@nand.local>
References: <bc42b56ea2c3ac7ead1cad2a95ac01a7adfbb28f.1614193703.git.me@ttaylorr.com>
 <20210302040625.4035284-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210302040625.4035284-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 01, 2021 at 08:06:25PM -0800, Jonathan Tan wrote:
> > +static char const * const builtin_multi_pack_index_write_usage[] = {
> >  #define BUILTIN_MIDX_WRITE_USAGE \
> >  	N_("git multi-pack-index [<options>] write")
> > +	BUILTIN_MIDX_WRITE_USAGE,
> > +	NULL
> > +};
>
> I think this way of writing is vulnerable to confusing errors if a
> missing or extra backslash happens, so I would prefer the #define to be
> outside the variable declaration.

Yeah, I can't say that I disagree with you. Of course, having the
#define's outside of the declaration makes the whole thing a little more
verbose, which isn't a huge deal.

But I was mirroring what Ævar was doing in the sub-thread he started at:

    https://public-inbox.org/git/20210215184118.11306-1-avarab@gmail.com/

Unless you feel strongly, I think that what we have isn't so bad here.

> > +static int cmd_multi_pack_index_repack(int argc, const char **argv)
> > +{
> > +	struct option *options;
> > +	static struct option builtin_multi_pack_index_repack_options[] = {
> >  		OPT_MAGNITUDE(0, "batch-size", &opts.batch_size,
> >  		  N_("during repack, collect pack-files of smaller size into a batch that is larger than this size")),
> >  		OPT_END(),
> >  	};
> >
> > +	options = parse_options_dup(builtin_multi_pack_index_repack_options);
> > +	options = add_common_options(options);
>
> I looked for where this was freed, but I guess freeing this struct is
> not really something we're worried about (which makes sense).

Right.

Thanks,
Taylor
