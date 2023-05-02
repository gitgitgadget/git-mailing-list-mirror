Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A6AC77B78
	for <git@archiver.kernel.org>; Tue,  2 May 2023 20:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjEBU4F (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 16:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEBU4E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 16:56:04 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53F21734
        for <git@vger.kernel.org>; Tue,  2 May 2023 13:56:02 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-18f4a6d2822so117035fac.1
        for <git@vger.kernel.org>; Tue, 02 May 2023 13:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683060961; x=1685652961;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2/8GAoKMpeYglLOI/EXa5hPnQdjNVHuWNqieoy39wY=;
        b=V/+6fnisk3VZsU/lEwyz5ytDrnc/Z4F/lh7ntuEsVy5XARxngNMOPSGZiWE8/JjHUi
         EyBc+PdS77+CNyheIDyhJJpJEmlxTnM7IQYWaSrBUFV2HWJWnVJjQKAgh1cqHubhxHr6
         ixTd10zijvAcd4T2RrHnvZ9o9nT23JcNYXEhwQOK2tdh182CH1dbN0yF1pvFfktXJH26
         bBQNEqHS1rv/TvF/q6iglbpt5xNQlZGCkC9rk8hNccR29sMkwZ6nNJee7xOT5sRlWDpG
         /mQDKyW2a5qN/o8/SPiDnvijtBK/yQLos9iuuVf6CD1OsxuWZI6u6ATrP+eOVOs8SKk1
         G/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683060961; x=1685652961;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C2/8GAoKMpeYglLOI/EXa5hPnQdjNVHuWNqieoy39wY=;
        b=SskVlHmwVlwi+KNwAaePF8tQDtLfjysP6x1xOVkHk0hHb27NdHmr0uW83Dc7otYAVG
         C0SjOqze8QQ0uhZBsI9lv+zxpGttMc13eL0eMnAUi31afS7N1BDdJmXFWEXAhiot3J3B
         N2UGzaDRGDQFJAJ96aKijrquAdGpLAEP4Mt02COCOX+dWMCDLX3a98VU+WXn99PDu6mX
         01FOdSi45KXrTJbxvJX47VZAb8zcsALUgTFcC2vXYb4JzoFLgj73uM1e3B4szUX66AaC
         WTL9XYJC4seHrGPMUPgh/Vuf+PlL4Lb0Q5uhj16eEQGBru3/6dsr1sEVNzULcmkdoGQD
         EqrQ==
X-Gm-Message-State: AC+VfDwiFoJgN8yqVKoS5xKDg8T6q06r1gmaaDrAAVyjmzy64aA8IUE7
        CAmqpB80CHKWLGmCF/LAWSuoURXP26Q=
X-Google-Smtp-Source: ACHHUZ7O4EVrKWhWXRnlbLOpvdf+3L551kEKvarInGSxQgTkksxbcbd606mNxeDpUfC+sGaZbuZ7iQ==
X-Received: by 2002:a05:6870:e815:b0:180:9705:fc3b with SMTP id o21-20020a056870e81500b001809705fc3bmr10889599oan.11.1683060961007;
        Tue, 02 May 2023 13:56:01 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id f6-20020a9d5f06000000b006a1287ccce6sm12050098oti.31.2023.05.02.13.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 13:55:59 -0700 (PDT)
Date:   Tue, 02 May 2023 14:55:59 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>, Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Message-ID: <645178df26120_200ae294e1@chronos.notmuch>
In-Reply-To: <ZEpVSrz-uUcfN_3_@ncase>
References: <cover.1681906948.git.ps@pks.im>
 <301138da039451519c6e60d6126e7756a54d346f.1681906949.git.ps@pks.im>
 <kl6lzg6umne9.fsf@chooglen-macbookpro.roam.corp.google.com>
 <ZEpVSrz-uUcfN_3_@ncase>
Subject: Re: [PATCH 8/8] fetch: introduce machine-parseable "porcelain" output
 format
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt wrote:
> On Wed, Apr 26, 2023 at 12:52:46PM -0700, Glen Choo wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> > 
> > > The output format is quite simple:
> > >
> > > ```
> > > <flag> <old-object-id> <new-object-id> <local-reference>\n
> > > ```
> > 
> > This format doesn't show the remote name or url that was fetched. That
> > seems okay when fetching with a single remote, but it seems necessary
> > with "--all". Perhaps you were planning to add that in a later series?
> > If so, I think it's okay to call the "porcelain" format experimental,
> > and forbid porcelain + --all until then.
> 
> The reason is mostly that I didn't find an output format that I really
> liked here. We'd basically have to repeat the remote URL for every
> single reference: just repeating it once per remote doesn't fly because
> with `--parallel` the output could be intermingled. But doing that feels
> wasteful to me, so I bailed. I guess I'm also biased here because it
> just wouldn't be useful to myself.

Couldn't each URL be assigned an index and then just show `0` in the output? I
think it should be straightforward for a parser to figure out what `0` means
but if not, that's something that could be figured out once the use case
arrives (which very well could be never).

-- 
Felipe Contreras
