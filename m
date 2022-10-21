Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F11C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 03:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiJUDOR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 23:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJUDOQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 23:14:16 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E171C13C1FA
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 20:14:14 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id y17so972330ilq.8
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 20:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhQZCyHYgWs6sKsA3o+G/79DCEhUrr5zzdcVndlv1HE=;
        b=LivKO9m+e8Kd/Z9qvfFggbLNNNHGs59Qt6ZdpeKkvJxZIU+Hvpg5ufaE1dB0wVzP9g
         CixT36ud6/MDd/I0HZVjXGb8sWE+kkh3d9hQXqQ+8y4uN1OpAldXRmrbfwSeeQNGPvVo
         vR4GWpHUiIUykWlJRQWYfd2rMOxsngKLnDH9MjMkMqoDU8xGCjp6GorYN8gXL43PlVK0
         pQ/4OvP2jWK3MM0xR9WWWThxY2AU0i926Q0U288+FD3lTrotMQLX16oI1EXjDc7nF38W
         va35dPdLvHcRIUiEVQxz8iAyovmcZtHiVE8BqgkbGXz23vxEn+pPuTgo/+L3zIaYrBSj
         nBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhQZCyHYgWs6sKsA3o+G/79DCEhUrr5zzdcVndlv1HE=;
        b=i5AlLo823Q8efIkf/gr3QuWO0DItPWidPYmY6qPDby1Kcx4QBn0ulI/heAp7iBDW/y
         mH84kkyClZT7CohLen5nU6w/gn2Tn4enaHvxK6aR/t7j0c0p+7ycMxFfP4JMHY7//vUa
         e2wS62L8H8G9dKBWe5PPFVJAd5seU+yjiSqmhqo1klo4TTA0c6DvD9mU8UFDMevD1MEA
         m8EvGx+yEnOLlFsirdvcxrv71wraoi1SrqFOwx1OnRXGvNez6NGJ6OqJ9AyEIxP12gba
         Nhf/5QVCyVPQi5eY/hxWXczCQR/4+aIDlBdKRw77A//xDbQ2VJ5qLwl8ld/7lz5ukWxV
         p7/w==
X-Gm-Message-State: ACrzQf1BSJEsqoimucRszBEvMPhU8vb/PI79hTgVj6P3ZJTZvCZLfpNO
        y2+gabM7mzSjYoAdvMRmZssOyw==
X-Google-Smtp-Source: AMsMyM5TSES/y1SV6GMAH2gEUiWVOhbKjJL/tpadStTtMTZzYI1tZrHMzwEUpbbUYIaj2Dd2f5y4Gw==
X-Received: by 2002:a05:6e02:b4d:b0:2fa:6084:db2e with SMTP id f13-20020a056e020b4d00b002fa6084db2emr13132498ilu.95.1666322054284;
        Thu, 20 Oct 2022 20:14:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a3-20020a923303000000b002f947700951sm3617568ilf.82.2022.10.20.20.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 20:14:13 -0700 (PDT)
Date:   Thu, 20 Oct 2022 23:14:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, vdye@github.com, derrickstolee@github.com
Subject: Re: [PATCH] repack: don't remove .keep packs with
 `--pack-kept-objects`
Message-ID: <Y1IOhH2jAwHHrLY+@nand.local>
References: <6a012cd625c1d197ede91c85299cbfb37adf356b.1666059872.git.me@ttaylorr.com>
 <Y05NwIfY/906b2Vd@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y05NwIfY/906b2Vd@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 18, 2022 at 02:54:56AM -0400, Jeff King wrote:
> So the patch looks good to me as-is (and sorry for the verbose review;
> we've just had enough tricky corner cases in this repack code that I
> wanted to make sure I understood all the implications).

Yeah, I agree that this is probably premature optimization, but in
practice it doesn't hurt much. Copying it was definitely intentional,
and I share your general unease about changing it in this patch.

Thanks,
Taylor
