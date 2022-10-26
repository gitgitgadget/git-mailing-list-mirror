Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E61FA3743
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 19:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbiJZTng (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 15:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbiJZTnS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 15:43:18 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4D9D0CE6
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 12:42:57 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id 63so4842578iov.8
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 12:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wbGm6RAH4FsWMRpOHNerygcbAmYkTto/K2LkgKqfzVM=;
        b=rWT63hKkf6HEprg4rMyt3W+cAklJnQiBc752NCcTkXHb6D/8nePtnc0Eh0R8D8RaS1
         hoBGY+uZIyvG2mIIQZKJhyYNvaqyBRnRen09mV6K7Ga2MlepmvgpvVn4pKMFFOZtQWcb
         ysgUMfalg0WSJwAZGg24miCdyR6+TSt/ABeC81boDrhcm5owyvWr96/xBLf7mG/6AGNo
         dFEbXhYxwcAZJyfg+6O8u6FxHo3GQfObC30la2/oyhq40QaXCLw0XzHn37iXI/rlTT1s
         kt/0ZaTpiXlwfjIdguCLpeW41+UN3rVGh6kpYIKXLxwfmmbr4T16bRZRGKFsk0gvPZqc
         EqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbGm6RAH4FsWMRpOHNerygcbAmYkTto/K2LkgKqfzVM=;
        b=AmKMk13MW8BkW+LiBTnFF53GQU2+vPEoPaWpf9tAkb4X5cgB0UHac9g/eorFbFC9W2
         e5uZNQbfTBwVNgyfng1jYHmxzFbvVuISYYYAQf4HaWXkjsrWkRsQOR9ulHnL4QkWyGFu
         +VdKtewjud0/v/sMLapjPnVnjx1Y0kRrEE75kzR+LUr+mEry1LTKYO+gZllpXMn5WGAu
         wrsBu3apBRhPezWgP9rCUWgXYAUN2Bx/VjqRPNzt8M7/8DTL+ShN0La1SC4MvJDuO/FU
         dA2O4H2xAhkRoRNwIZSbJzU4IaargpqQtUYf7gta7Zj+N5T+esSC8g3dw8vPycQPZ7Vb
         6BdQ==
X-Gm-Message-State: ACrzQf0YVZ53e4Zy4HNW9ffwK7VLHCZzWizZ73dqohUVqKKRX9+pzlyr
        5oKP06pITnsl+IEbyOGcmEqNYYIwyiMqCazx
X-Google-Smtp-Source: AMsMyM40QZT38K769dfpS9lf//YRPo3TQ35c5iwfoty7dBPIadHOvzAoUCfGhsJEDQ6oXXrw14AznA==
X-Received: by 2002:a05:6638:168d:b0:364:d5c:d482 with SMTP id f13-20020a056638168d00b003640d5cd482mr28612652jat.180.1666813376752;
        Wed, 26 Oct 2022 12:42:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f3-20020a056602088300b006bb7764890dsm2750286ioz.45.2022.10.26.12.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:42:56 -0700 (PDT)
Date:   Wed, 26 Oct 2022 15:42:55 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: tb/midx-cleanup-fix (was: Re: What's cooking in git.git (Oct 2022,
 #07; Wed, 26))
Message-ID: <Y1mNv6kqHlNMh23m@nand.local>
References: <xmqqwn8mh1di.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwn8mh1di.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 26, 2022 at 11:43:21AM -0700, Junio C Hamano wrote:
> * tb/midx-cleanup-fix (2022-10-25) 1 commit
>  - midx.c: clear auxiliary MIDX files first
>
>  The order in which multi-pack-index and its associated files are
>  dropped has been tweaked to make it safer for concurrent users.
>
>  Under discussion, but leaning to negative..
>  cf. <143a588a-c98b-733b-2b23-34a87ca89431@github.com>
>  source: <bf36093cd6d7ac83b16241b0199b3a8c904e6774.1666722316.git.me@ttaylorr.com>

Yeah, let's drop this one.

Thanks,
Taylor
