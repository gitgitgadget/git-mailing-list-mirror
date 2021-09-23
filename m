Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AEFC433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 03:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A69D60F23
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 03:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238957AbhIWDLW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 23:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238905AbhIWDLV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 23:11:21 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B504DC061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 20:09:50 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id r75so6273165iod.7
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 20:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NZ10GndQaOo0tDkI5qNB1NC92cRZrJIa4FA3B+HSc8A=;
        b=WZsNs2YzCblTsIHmPJMmo5h+DgVz4A14x6UciLaGr5k1Lr4YwqIdWSN/OADc70fVpZ
         y+O4nKCRjx2B4cMOabAeaX+xOjSXv9xTfFRA0FJAD6zHfNoA/WoXV6CDvq+Dl9iu9+SG
         RxOo/DTP8yCF2lypYZWStTvPoAZ+kJ+xP2zi1fCRwx79b/5Xy0pK17nJ5Gy1aWJPk5gf
         JNcEqgxF9N2oogHo5xGW1ZNuiNoYtsPJtOfoD4Hk9UKkDzJxIFa4sQLPuN0tZU+2IY9R
         912r6KPaT9WoRBC9BeFJv4buYCfyJm9g4cT8mSNdBoAIsoKI+GvlOdi7EpXPNoo8GO8T
         gwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NZ10GndQaOo0tDkI5qNB1NC92cRZrJIa4FA3B+HSc8A=;
        b=BUMaE8nSJN+z0osf04QPIB/vWGoA1umqhgcODcqm5Qi75lxGVF1ehErVn1Qv+HlKWI
         bhehWD14RPvClGvFEiKe0a7vhuiDDL9213D9OI8yPUY/W4GtXyzq38oL8icwiAbs7JOZ
         eAry9DAsCBdsoN95ypYq0bgDSSiRcqtZ2YYpwz3L89qGcVnAoH6adPbNAjxcvUr4RCFw
         yvvIRTT0K9J38bmB/8XLK6F0L0e3Zw/4ei22A7/yx3Nfeg1TL744+h2vgEIOk8OqeXVi
         3cDcghWKiCHqVn7WPtun3IOVhLHwGphrVsfFKQ62iBZm1Y7wt7+GVR5jCL5bjTv6iYav
         kW+w==
X-Gm-Message-State: AOAM5303Ds54APu8NjBHkNZvatc8EwEGtFv+bVSXkqw+9VfYjOQWosdS
        830O0kn4DNF7Fu710JetKI4HtQ==
X-Google-Smtp-Source: ABdhPJzCEw/8zyKrr1RDpPs58g5pXw7O3LM9l/1SMj5WUBGKJpkMXp3No6TR2IjXJczNxiyKzXxKYQ==
X-Received: by 2002:a02:6646:: with SMTP id l6mr2060984jaf.51.1632366589928;
        Wed, 22 Sep 2021 20:09:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r3sm1952042ilc.56.2021.09.22.20.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 20:09:49 -0700 (PDT)
Date:   Wed, 22 Sep 2021 23:09:48 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     me@ttaylorr.com, git@vger.kernel.org, peff@peff.net,
        gitster@pobox.com, avarab@gmail.com
Subject: Re: [PATCH v2 1/8] midx: expose `write_midx_file_only()` publicly
Message-ID: <YUvv/HG3jzOwtwzZ@nand.local>
References: <03c1b2c4d3d9d10a6768684e9c4d1c1cc8019844.1631730270.git.me@ttaylorr.com>
 <20210922231423.2610917-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210922231423.2610917-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 22, 2021 at 04:14:23PM -0700, Jonathan Tan wrote:
> > @@ -1237,7 +1253,7 @@ static int write_midx_internal(const char *object_dir,
> >
> >  	QSORT(ctx.info, ctx.nr, pack_info_compare);
> >
> > -	if (packs_to_drop && packs_to_drop->nr) {
> > +	if (ctx.m && packs_to_drop && packs_to_drop->nr) {
> >  		int drop_index = 0;
> >  		int missing_drops = 0;
> >
>
> I couldn't figure out why this requires ctx.m now.

Me either; this must have been a stray change that got dragged along. I
dropped in -- thanks for pointing it out.

> > @@ -62,6 +63,10 @@ int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name)
> >  int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, int local);
> >
> >  int write_midx_file(const char *object_dir, const char *preferred_pack_name, unsigned flags);
> > +int write_midx_file_only(const char *object_dir,
> > +			 struct string_list *packs_to_include,
> > +			 const char *preferred_pack_name,
> > +			 unsigned flags);
>
> It took me a while to figure out that this function doesn't only write a
> MIDX file, but writes an MIDX file only for certain packs. Maybe worth
> adding a comment here (e.g. "Write an MIDX file only for the given
> packs").

Nitpicking a little, it does still write a (single) MIDX file, but that
MIDX only includes the packs listed in packs_to_include. I can add a
comment to that effect.

Thanks,
Taylor
