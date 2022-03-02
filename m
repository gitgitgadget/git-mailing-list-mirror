Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B93C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 21:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242160AbiCBVeY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 16:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235450AbiCBVeX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 16:34:23 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3DF41989
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 13:33:38 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id 195so3594181iou.0
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 13:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oeRL6IVwzAPip4CdPbT2F1PpL+LUl5DGLm7KxRhJyes=;
        b=O97PPQoBrRtYFqT5fRHPp1tXCm2+AF8IkoZawgA+yQ42sZFsud0OV5sSDhLSpKJYxn
         kZTshGvgW7i4HDCLUMz82cc1sOVPaCxdegbPrIi3Fb2XQDWru6qAV2VHBMfEnTqL0oDg
         aGKd9TuYf+j91O/JesffrLuCl3V4mRdzhaFMjmLK3iHCbhSzYKxI+kiGBU2DI8tFuvP/
         QfAmfMU8jF6NKB8jrCzpFh29ZfdecMKedPvSigCCOPwnPhfv2SIDgqLafluR9codJpQ/
         rfjtgfggmARDgwKYvHxKB82Xt/wn9fL2Nbnbg3nfy/vQLj9NgaUadQzjyoO9R/o82cEt
         oq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oeRL6IVwzAPip4CdPbT2F1PpL+LUl5DGLm7KxRhJyes=;
        b=5zA0kN9vig0hzVcmqwo5fMU9c3oC7s4dVaJYN9a/2+vUA2jNOmro9MsGCCPAafTm9l
         IidbqAXTLBinjikEVAtom55fNwZD/LLVU7pl7cTFtHRkGkTqAvmJiY3X6JGLKiGhUQOf
         YK9I6NElOTPxSM6ZKPKlcC74uyuJxb67jDWC0WFYKAfwlTZT7bTUdYnU2RRyIwogdOmc
         EevGRFrXtxfBHp9lPsbxJeKlcd/m6pNTwmeplbDoJaJ3RR9oi963dNa6lz/vKZpzkUQ2
         nrfRVqpDwFOtiZEeIzf2vEo9L9KYi+APO/5w8afu6dspc3v/vWJ51oGw8TId2+GEJi6O
         UM1A==
X-Gm-Message-State: AOAM530iOY7qRYYBGz2T9dYnAe89QS8umVSUCe8US4lzW0ZuiPcz/dDn
        QwQAWLTZv6zhbNE2uShkyi1VSQ==
X-Google-Smtp-Source: ABdhPJwP9iqPw2aRY4Rkyi0fgJYxHlHRMondQr2wG2oPYVqLSj3fuxLXuPziRv0NugxJ0uqnpS3LUA==
X-Received: by 2002:a02:b68c:0:b0:30e:3e32:b041 with SMTP id i12-20020a02b68c000000b0030e3e32b041mr27338417jam.27.1646256818104;
        Wed, 02 Mar 2022 13:33:38 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k15-20020a92c24f000000b002c2e03c5925sm145328ilo.8.2022.03.02.13.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 13:33:37 -0800 (PST)
Date:   Wed, 2 Mar 2022 16:33:37 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, tytso@mit.edu, gitster@pobox.com,
        larsxschneider@gmail.com
Subject: Re: [PATCH v2 02/17] pack-mtimes: support reading .mtimes files
Message-ID: <Yh/isYFFmmOdpNa7@nand.local>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646182671.git.me@ttaylorr.com>
 <101b34660c0c5028ba591d052dc587bb8918ccb2.1646182671.git.me@ttaylorr.com>
 <66eeada0-f2b4-6849-bf14-029bb6c6083d@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <66eeada0-f2b4-6849-bf14-029bb6c6083d@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 02, 2022 at 03:22:18PM -0500, Derrick Stolee wrote:
> > +	ret = load_pack_mtimes_file(mtimes_name,
> > +				    p->num_objects,
> > +				    &p->mtimes_map,
> > +				    &p->mtimes_size);
> > +	if (ret)
> > +		goto cleanup;
>
> This looked odd to me, so I supposed that you had some code
> that would be inserted between this 'goto cleanup' and the
> 'cleanup:' label, but I did not find such an insertion in
> the remaining patchs. This 'if' can be deleted.

Thanks for spotting. My gut was that there must be something in the
range-diff between this and the previous round, but there isn't. So this
code has always been there.

It likely comes from load_pack_revindex_from_disk(), which assigns the
`revindex_data` member of `struct packed_git` after calling
load_revindex_from_disk(), but only if it returned zero.

We don't have to assign mtimes_data here (since it doesn't exist, and)
because all of our reads into mtimes_map are offset by 3 to adjust for
the width of the header.

Anyway, we don't need this if statement here, so I'll drop it.

Thanks,
Taylor
