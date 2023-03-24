Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7E4C6FD1C
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 23:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjCXXYE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 19:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCXXYC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 19:24:02 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2196E1AC
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 16:24:02 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id k17so4141664ybm.11
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 16:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1679700241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mie8K8W0Np9wkz39hA2xJghOJHQqFbl1YxdyYamqqMk=;
        b=ZwobOQ92eBhdqWS5VeNRWc/v227VA05v3Gbxz6IH4IXThY3akBRQlILjHJwvLyOr+s
         PHJEjzlcmWSEVt771dNTqKAgA7pZEHsOkJvk/VZ2RWBZKUChlDv65xVVqdbJKvXL3BLV
         WK8VW/lMuZhyFh12KG14gwZNOmfdTmSyBXk/QsHxEytK1slxC09Ygnv+LzwCqG1kzqeM
         u/8hoKxCx4Y4hFzsC0GLtXhkNwS01YGTz7Uo9eDIKiGwWtV5wLC5gtRNLt9Ep898BP7R
         occGsHGn5bsq0+jfknjSuR88fN7adcAKq69Qvh6fJ7Umz5wQCcKFZX+fTL4NPH8W5z28
         wImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679700241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mie8K8W0Np9wkz39hA2xJghOJHQqFbl1YxdyYamqqMk=;
        b=Ytn4GC1HF3U1OeIf9RLSTFrT4OBm1JTAM3lta6zMqszd022kZX1ea9SlK3V9V+6FMq
         N4rraD8GTiedNpgPpEqBA5R98s8kCsxn8haoYC+/71m9+tzNiQC4XovO6dezWSQgeZIi
         BCSRdEHlAoRbRcZZiy7q2gr0Ov2UmBxajysY4w0jJ33S7JMNLY0QKRsWAkYdAvmLT7Nu
         qnHxkN9jVzzolzvAEUXq9f85RCsCIIeN9lwoNORcQBSf80U/c/uze4arxuzgNa85Tqqp
         TeH0YtGwsI41jI4rBAA/lxwXHd/laX+hPlvqyDXPXtbjOuvxbA/OKCWIfk7SsYuTMM8z
         RVzw==
X-Gm-Message-State: AAQBX9ezx1Yy+LhSCQM6RcZtqb41xhCn7QtWcIjNCOdyJnk8Bw/TzGYY
        mSfhMEINzol0vHMWZLXZlO4p4Q==
X-Google-Smtp-Source: AKy350ZRCsoJ8vuyXYXcmPEKHvN2vyvIXE7QybEqMAaJwreD49PesvBw2rNU6ToMqrDOFer5U59stg==
X-Received: by 2002:a25:5093:0:b0:b75:7c77:8a63 with SMTP id e141-20020a255093000000b00b757c778a63mr3274554ybb.29.1679700241260;
        Fri, 24 Mar 2023 16:24:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e60-20020a25a3c2000000b00b7767ca74a3sm742673ybi.64.2023.03.24.16.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 16:24:00 -0700 (PDT)
Date:   Fri, 24 Mar 2023 19:24:00 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 4/6] pack-bitmap.c: factor out manual `map_pos`
 manipulation
Message-ID: <ZB4xEO82vTp6yTfx@nand.local>
References: <cover.1679342296.git.me@ttaylorr.com>
 <0decf13869df6216914044a560d94968126836f4.1679342296.git.me@ttaylorr.com>
 <20230321175612.GF3119834@coredump.intra.peff.net>
 <61ae4ad5-4d4d-933c-a2cb-e7e2cd734401@github.com>
 <ZB4ujCTiRgAmZaQo@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZB4ujCTiRgAmZaQo@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2023 at 07:13:16PM -0400, Taylor Blau wrote:
> > Would it make sense to return an 'int' instead of the size_t of map_pos?
> > That way we could return in error if this is exceeded, and then all
> > callers can respond "oh wait, that move would exceed the file size, so
> > I should fail in my own way..."?
>
> Works for me. I think bitmap_index_seek_to() would probably return the
> error() itself, since I don't think it makes sense to require each
> caller to come up with the same "bitmap position exceeds size" thing.

Actually, I take that back. See my response lower in this thread:

    https://lore.kernel.org/git/ZB4w2gCo/qPCmWkz@nand.local/

Thanks,
Taylor
