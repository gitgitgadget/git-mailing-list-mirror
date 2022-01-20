Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129D5C433EF
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 22:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378030AbiATWNR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 17:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378018AbiATWNR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 17:13:17 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BE6C061574
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 14:13:16 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id i82so8691704ioa.8
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 14:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nVUfttKhXVfNmgQa3OP1T+Xwpvwgyz3Dmkkv/etGGXA=;
        b=JppXPB4E1yvIlI1pKm0R8y+C/69XAc3nqqzgOAhb4k6tHZOC9tcdwGyBqyk2gFe2Gt
         L2w/kWjlWcdm2FCPyWCJanUrCoiclcMU1B8npTYtlYD375JVjuC6a8Ne8Z7PcvvEWPlJ
         ouJHYOMhiUnsZ8mytKAO+/q2BgShYM7VhfXVBne+2tNOU0Rf5nZWcXspuSXqnB9V/0st
         9RASa0Jb0Z6+RurAsyzBr4//U/AfIwjuWTT21yQl+34FD7Xs1C8HNqC/jXIirFyAye7T
         KK8ZqLDkkV0XaZmPT03/khrVo6ioAKOiwu7ELJVGhFKux3S4f8emnxc+VSIMrhkQs5IR
         3jQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nVUfttKhXVfNmgQa3OP1T+Xwpvwgyz3Dmkkv/etGGXA=;
        b=0gYdYR00OQw8yYV1GrjXogSD/a5eYkQlOqZmpdecQpPl02kYbJWElsspEi0ZmbCGQB
         bVavUIdveNf+IRZ081ALF7UQ1JH7ax+1XpjQv1yQPCIxDHV3INjNzTu5NxPnvaSiC8XG
         5nw7itKmpiInYKVnS1RLtdZp7JW9MgY3lizcTLMW4Oev1Tp8ahh6rv+qUqJ97i5dPyXJ
         CnpQJWfZA0NCl0Mi6ySvIYsKJErs9A7F6vf0yTbIf84ljechzj7tSKLDQsr9P9OSSo+C
         /x/ygWOJTsVUJ4b+b0wA5LrDFtrMRKjzNEq+vMGm3Vh25upCKAuPT2FlZN/4V/dsaCdl
         JNvw==
X-Gm-Message-State: AOAM533YCx7a5P12xuIbkQOIa9t57TPEwMylqvthG/ppTOsaHVP3D6zl
        1O8PwnMe+3uYfKhGn6b9JT1Bkw==
X-Google-Smtp-Source: ABdhPJwsOFttMMwP40jN6pHF+Xz84MfLfinZ/6t9aUTxcEyDHkbdNp6Q6zfSNYZSJMbaXydU9+QFiA==
X-Received: by 2002:a05:6638:f16:: with SMTP id h22mr398545jas.279.1642716796216;
        Thu, 20 Jan 2022 14:13:16 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h3sm2060078ild.11.2022.01.20.14.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 14:13:15 -0800 (PST)
Date:   Thu, 20 Jan 2022 17:13:15 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com
Subject: Re: [PATCH v3 2/9] midx.c: make changing the preferred pack safe
Message-ID: <Yenee7bmEEiR2gkj@nand.local>
References: <7d20c13f8b48d2aef45c2c8c40efb6ecdb865aa8.1641320129.git.me@ttaylorr.com>
 <20220120180843.3103044-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220120180843.3103044-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 20, 2022 at 10:08:43AM -0800, Jonathan Tan wrote:
> I think the main issue is the first confounding factor you listed above:
> even if we didn't have the other confounding factor, that issue alone is
> enough to motivate the entire patch set. Likewise, as Junio said [1], I
> don't think we need to switch to rename() if we make the checksum
> different, so the fix is one-fold, not two-fold. For what it's worth, I
> switched back to finalize_object_file() and ran the tests, and they all
> pass.

Yeah, I agree with both of you and would rather use
finalize_object_file() here and be consistent with other callers that
modify $GIT_DIR/objects.

It is safe to do, since the .rev file's name will necessarily be
different if the MIDX's object order changes.

> [1] https://lore.kernel.org/git/xmqqtue54iop.fsf@gitster.g/

Thanks,
Taylor
