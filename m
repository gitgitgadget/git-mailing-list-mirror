Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC7CFA3741
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 01:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiKABQX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 21:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiKABQW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 21:16:22 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0FF167DD
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 18:16:21 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id o13so752431ilq.6
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 18:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wlFF3Kbvwamp9sOQYi62VGotgFnzjJ4qRFpldY0KXBM=;
        b=fM9Clev/WqvyNBaOWkIuZKO8lN3/xUEAv4h3Cj6GnLE90cB6Oehop7gwXGXosPhJNy
         tKWtLRbdo3TJ1mgaNHZ56h3cvTGPPv14tRTiS119p45ZcKbq6YYU9+XpG0JWSrCVKKEQ
         PEED5ZHDe4QSD0YK7M8fuRbrmcgQFfK/mK3jfEFmWTAkf8CtdZu/vClIWinNA9GgqeVp
         d4TDE6MIox42Ogln7xqdY1thdhJf2huyyfY2LbPV0xvn74liLeYfIduMf0eQ6cUKZZRe
         CZYQngtxWl7+op0j4nVFmrcSwyRADrtm1dgHoJReCZxDRLqEL6Q2QfXsrhHnT/v2Tt3I
         uIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlFF3Kbvwamp9sOQYi62VGotgFnzjJ4qRFpldY0KXBM=;
        b=w3eDOEDumIJkiFGBvgZTtNoS/A6pztSkNrt95tdinAKSLwlqTKoE9YyFAHG8Hs3aDp
         koka+wX4dcmyoSAc0cFdR00Y2suPRhdNXt2FMWr3I8G2aQN72UuSP7Gr/1Fmt5idQJiW
         02HqnzD/+AHUhGhki3M2aW/M5EbqqrhjxuFQqpphTYaWySEUc4mIYdtfkA+4fF/p3IVp
         03uwiQamPlspt4olpnfeA2RjRRTQBZYetM2pv0EnxFBGt4NT9L/0oOMcI/kY96A/B12d
         rK4Tk8ceNJBBTr+TxLHdW4MGc6LjdjqYcl/iX7rhG9eLjQJQsLK6RnDv+h2sfz0ii5Ze
         Ju1Q==
X-Gm-Message-State: ACrzQf1sq2Hj2ymMpRVoi6BHCewZqhFw7MedEDW0tnlDtkQJLDwrKyo2
        Au4U09dFQ3b3ezeAyggt0laT9e4MdBxhJ9E3
X-Google-Smtp-Source: AMsMyM7/y88SshWj1smyn8wZpQtWsxr/ugikWGLYuruo8i9hOey4RBFr/HaMyxr6rOH9tBMbPN4VgA==
X-Received: by 2002:a92:d444:0:b0:300:7d24:13e7 with SMTP id r4-20020a92d444000000b003007d2413e7mr9201231ilm.116.1667265380979;
        Mon, 31 Oct 2022 18:16:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u14-20020a6b490e000000b006c1819ffe60sm3344850iob.53.2022.10.31.18.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 18:16:20 -0700 (PDT)
Date:   Mon, 31 Oct 2022 21:16:19 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] connected: allow supplying different view of
 reachable objects
Message-ID: <Y2BzY0kqyt3doMXT@nand.local>
References: <cover.1666967670.git.ps@pks.im>
 <a32e3d6146dd41af36f525a744d6cc099b42d6fb.1666967670.git.ps@pks.im>
 <xmqqr0yrizqm.fsf@gitster.g>
 <Y1/JOGihHtMWv240@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1/JOGihHtMWv240@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 31, 2022 at 02:10:16PM +0100, Patrick Steinhardt wrote:
> I guess we should thus also pay attention to `is_deepening_fetch` here.
> As this means that `is_deepening_fetch` and `reachable_oids_fn` are
> mutually exclusive I'm inclined to go even further and `die()` if both
> are set at the same time. We only adapt git-receive-pack(1) anyway, so
> we should never run into this situation for now.

Yes, I agree.

Thanks,
Taylor
