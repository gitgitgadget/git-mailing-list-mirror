Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8EDC4332F
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 02:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiKJCfN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 21:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKJCfM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 21:35:12 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871701EAE7
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 18:35:11 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id z3so323058iof.3
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 18:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W1Knw6oCMe26s1z7/n2HA4A1UVjym7+IA5MFHHT3A/4=;
        b=2f4Qi5YQxv4hwH3/SOA+raj6dxUBgrqz1VwpA+dtEiSj7Nhx82vY6MMC8w6BbmlNaJ
         Z9zwsCrCmkajZT15o1/GQ5svsGzdu71ePUsoyYc/DRhSa+ISkK9HMP/V9w4u956RRorS
         GnChBLPWR37XZWRd1stSRd2qAeMCY8feRcmaDAzrBl5iVnUtUrUlwzI3Z0CxG7F8ESR1
         K6UVwViYBPKEJkOCRT0hD+Rr7SVpZVJJMotyD5XGYZIXl+Ga1X/CxOF5qc/V3iFMoLUd
         nXAlMEjbAdYQLmdF0VhKT72zOokU/pnQ64zUbNJUOU4pxIqQvSF/V+RSBsr3SQRkfN8c
         55CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1Knw6oCMe26s1z7/n2HA4A1UVjym7+IA5MFHHT3A/4=;
        b=X2cXYOWpobmERBFHuZRbHm7jfEQb9lAYDbwqjJnBR1HH6lzzD4MCrdvzb/wVxKOYOE
         pVq/fjIfJ40FIWrKwcjYCIBy3mXnedqoRyU9/2xmYbmQ94GygLGmLxMR/nppjSjCKMO/
         CQQH/2kRCSs1mHaeZslnd7u2Qyn/EBkHRZr5EzqueyLEKMlfingRz0BsPvyer5gyxjSL
         Fc9bbOxprLl4r6d1Z17DrK7PadOdazONalEPyPB4aK2+YTfw4MFsRYVW+CoAJvdkeIuZ
         vVxXdRel0sdMXMT1WW50Wcq0lhsDdZx1Ohp2CInpHMUCPwjl6K70Wc+dUS+FD4beJ/1p
         ykvA==
X-Gm-Message-State: ACrzQf03VAiWWSWRyWwEPwKd9CKvddSIbFsUpfmqqsE++xLVp9h4VGcu
        UWT5/6c+s93fU+inIoI0/X4okg==
X-Google-Smtp-Source: AMsMyM4Ut1GYjTc3AiUc3uLPxym5tBt30n5y8Q+nInFB+UI9MPbfQw5Nww5T+eWcoYZlgzD5eba8iA==
X-Received: by 2002:a05:6638:518:b0:375:9e02:b459 with SMTP id i24-20020a056638051800b003759e02b459mr2271202jar.30.1668047710899;
        Wed, 09 Nov 2022 18:35:10 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ay27-20020a5d9d9b000000b006cad30ad430sm6136201iob.23.2022.11.09.18.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 18:35:10 -0800 (PST)
Date:   Wed, 9 Nov 2022 21:35:09 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/3] a few config integer parsing fixes
Message-ID: <Y2xjXSAGmHILluuy@nand.local>
References: <pull.1389.git.1666359915.gitgitgadget@gmail.com>
 <pull.1389.v2.git.1668003388.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1389.v2.git.1668003388.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 09, 2022 at 02:16:25PM +0000, Phillip Wood via GitGitGadget wrote:
> This series fixes some issues I noticed when reading the integer parsing
> code in config.c
>
>  * git_parse_unsigned() does not reject negative values
>  * git_parse_[un]signed() accept a units specifier without any digits
>  * git_parse_signed() has in integer overflow when parsing MAXINT_MIN
>
> Thanks to everyone who commented on V1. I've updated patches 1 & 2 to
> include the tests suggested by peff and added tests for OPT_MAGNITUDE() as
> that uses the same code path.

Having read this round and the discussion on the original version, I
think that this is ready to start merging down.

That said, it would be nice to hear from some other reviewer(s) who
took a look or are interested in this area.

Thanks,
Taylor
