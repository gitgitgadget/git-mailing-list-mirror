Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFD6C433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 14:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241809AbiBQOT3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 09:19:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241113AbiBQOT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 09:19:27 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084CB2AB503
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 06:19:12 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id o10so4860208qkg.0
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 06:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e6LvYijpKcQDCeCYnFp/Vg9SolFBXc9pbi089zci9Qg=;
        b=FAbhACan5GSmOOha1I2J5CNssDVuMbdmyqrrIZSos7TQh/RhVYPCkHRAbsaiCPOg29
         yMxmDUqMAchwBz/zEwzfR6YZ8yLnVdyjS848x6EX4vkOLoB+zh97N4wiJVZBmbcZ7o0f
         CT/iChqiT3PP0zQZDy/vjT9FYXJDNZHxaFAkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e6LvYijpKcQDCeCYnFp/Vg9SolFBXc9pbi089zci9Qg=;
        b=LYEMyO1MxG+W0ayn209tl/U0pxLoU8s2MoDC+kMHj1P+oPGHjXsnuS9fb3zvflBY+v
         zp8h6Kgu6OOTDhE4uLQJu+sBQbGUxarkO0/418AfbUyD+eXVlqW27MC1DUqMjYZNaIEO
         3gFY1dJC/KA1tcAGwvEu5y+DUoDnyXiTg4YXvy+bou6NyAb0c/eIpr9qgZaz1ObzrdTh
         3D5KA6PN2EUKFND2sKxzgH0xfuPscDGqIwEzV48YCyeoMIR0uqlY0h/ZTiTFgy+E4knl
         vSlI+FoHIIiBUcZH9RHvX6aZyL7XfifdVVfAMBHuwefj11HIrCaLRkw6wl+lUL/PPPYs
         1cBg==
X-Gm-Message-State: AOAM533PzbHvTUlPJHk8bo/eZH9GwveWetH3Z34ntWTmJkhxyDC0qx7p
        fvfiHF8lAfefH0Zm47O5EgbhB05twofydQ==
X-Google-Smtp-Source: ABdhPJyeEl6aFNK5F9DkUBPlOelQzaAyGNPszx0NJxtoActdq71b0bLElusbEziB7qjDpLC0F1UZWg==
X-Received: by 2002:a05:620a:1914:b0:4d8:34b0:bfa6 with SMTP id bj20-20020a05620a191400b004d834b0bfa6mr1592829qkb.397.1645107551909;
        Thu, 17 Feb 2022 06:19:11 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-127.dsl.bell.ca. [216.209.220.127])
        by smtp.gmail.com with ESMTPSA id d17sm20897037qkn.84.2022.02.17.06.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 06:19:11 -0800 (PST)
Date:   Thu, 17 Feb 2022 09:19:10 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: Supporting --depth when cloning from a bundle
Message-ID: <20220217141910.oaa6i4lvnotrbecq@meerkat.local>
References: <20220216220710.td4vp6mile5m6hjn@meerkat.local>
 <xmqqzgmqbfq7.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzgmqbfq7.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 16, 2022 at 02:37:20PM -0800, Junio C Hamano wrote:
> The "depth" is used to negitiate what objects to include in the
> packfile that is transmit from the other side.  That would not
> fundamentally work on bundles, because a bundle is pregenerated and
> there is nobody on the other side for you to negotiate with to
> affect what objects are included in the packfile which is contained
> in the bundle file.

Junio:

Sorry for the potentially stupid follow-up question. I know that git makes a
distinction when cloning locally between a direct path and a file:// URL (e.g.
it's only possible to do a shallow clone from a local repository when using
the file:// scheme). When that happens, doesn't that same negotiation happen
locally (perhaps in a simulated way)? If that so, then theoretically the same
approach could be taken with the bundle file?

(I'm not actually that interested in that feature, to be honest -- I'd much
rather see further work on git-native CDN offload of packfiles, so we stop
using kludges like bundle files for this purpose.)

-K
