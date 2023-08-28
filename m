Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718BCC83F18
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 23:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbjH1XZJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 19:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbjH1XY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 19:24:56 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4F1123
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 16:24:54 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5922380064bso44239817b3.2
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 16:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1693265093; x=1693869893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UCfHx8Zj8YJmOwJGE91wA3skXbo/jTWueOaleBX0P9w=;
        b=GQKyM09FB12/jcGFtw8M2cQ0Z3AzisSKa80IlJi9FvZR6ftRSKVUDE9Al85ltPBUj/
         rCnzXlLR88Uh5zwA2+/wgTuU8f9L7I+nsxNYlNl2kOKPtYdd8WxwYB5Q8ZM2AZB9L00c
         P7ulFPRK+qqSdbmlRSXX/11hvqeEb2jABgzkOGUcu1eCEPsov3bkVr72/KO7c80E3YgX
         CVnQWVBzYZQaMrrsvOGt6kv/rRo0JGG6LjnlBnlukBWUXyA7gLgpptiy5V/LaXNtn5Xv
         SR+OLhJ2QJyyEvas7WkD2g2aCjb3KT+ZlwzxNiZUbDJ9U5R4YOYph6kZIecSEe5LSDas
         ncMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693265093; x=1693869893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCfHx8Zj8YJmOwJGE91wA3skXbo/jTWueOaleBX0P9w=;
        b=FNWenZTwpWR3OAnfI0QqkRdSZVRcVsn9hHGNH63xianhb2IRA8ZxNsCRDZA/xN93M5
         +grFsTdcrGIpug0zsdMx9iTD4uo5ooJg0YPfGsemx5ZcdMqf+OpweTtjc1aYSmzb9tsV
         rL+oKfliJfcVkvvqFJNeFnC4uAckLja9KDpysuX4lS+i2QgRNYAIyJFG3DL2tgecoVvX
         PgKth2VkZfKaOsCET3aL5FTsM/fElHWpgZYsAnu79BzMJG0E7dWwyhsJtr4lqy7CSQRr
         8wDvqQkb5A/mkHhSe2MpDFVkxg7CzOpisTli1aAyUWAdTGr8XBz9EIRtmjxDwZoREeQZ
         Ck5Q==
X-Gm-Message-State: AOJu0YwXQ0CifWpdrMojUJGRlhbQPi3T98j3NLc6WgspVPfqCqLlAXIN
        bdopmyag24N9Qh11QBCRO5iPhw==
X-Google-Smtp-Source: AGHT+IGOUl8SYbcyhmhv2mCXn/HvNkJMua2jEmlxFm2BX/qYab7p2XRoX0Ung5GVyRb+VftM/tZnuA==
X-Received: by 2002:a0d:cb02:0:b0:589:f4ec:4d51 with SMTP id n2-20020a0dcb02000000b00589f4ec4d51mr26951676ywd.3.1693265093519;
        Mon, 28 Aug 2023 16:24:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r145-20020a0de897000000b00583b144fe51sm2453155ywe.118.2023.08.28.16.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 16:24:53 -0700 (PDT)
Date:   Mon, 28 Aug 2023 19:24:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 02/22] sequencer: mark repository argument as unused
Message-ID: <ZO0sxN/+RhvDi+62@nand.local>
References: <20230828214604.GA3830831@coredump.intra.peff.net>
 <20230828214717.GB3831137@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230828214717.GB3831137@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 28, 2023 at 05:47:17PM -0400, Jeff King wrote:
> Note that we could also drop this parameter entirely, as the function is
> always called directly, and not as a callback that has to conform to
> some external interface. But since we'd eventually want to use the
> repository parameter, let's leave it in place to avoid disrupting the
> callers twice.

Yeah, I think that this (and the discussion on the previous patch) are
hinting that we should consider dropping the repository argument more
broadly throughout the sequencer API, since we can often use
`opts->revs->repo` in its place.

But we can definitely leave that for another day ;-). In the meantime,
this patch LGTM.

Thanks,
Taylor
