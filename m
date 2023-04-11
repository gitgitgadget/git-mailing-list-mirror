Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB25C7619A
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 20:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjDKUZf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 16:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDKUZe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 16:25:34 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D056499
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 13:25:32 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id h198so16075053ybg.12
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 13:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1681244732; x=1683836732;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m2BlQywypkiQqkWsnbgkyURLgTdCcNc1mZHHqqwAh78=;
        b=yiwnHkuX2yd3gZJ/l6/mhdtU662CWnqBvdRCmEaHN80+qF+/+KCcVN4MRwCwvuzsAK
         n0j3qzWEh2UkAbLanxLOzgW9MiW58Awd1beVd5+ArSpPMY7967hUrUyMV72TYpcEk6gc
         HNGo/Ew5NUrQmiNm9lA0b9ka3s7LT8krXp35Yl4dvlsyViEfix3/6/Wb5KOMbdNIJSC2
         KC0628MOxdQtcAbeQCBDuiQFj61XpxXwdRd9/mz5oyZJYPTKHZL+PEXPfj90zYEFgXiH
         Oa+quzzZrlc8isFkaIhCiwuDMR2cuhtiRcC+Zg8MlIO6s/pm05bdnfIR6N1x1lBiQUeX
         OgBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681244732; x=1683836732;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m2BlQywypkiQqkWsnbgkyURLgTdCcNc1mZHHqqwAh78=;
        b=6PmEa6cZw2eTiow83j2UbDa1f+sj1b+xmPJj4h80n2B5dZP7Dldzre+3JV8s++DFgt
         RkfFBXqWYdjBT2QRCc3VoaY2JWvjxQX6FogCNHPfe9ZBlTPAFm1PzMF1loSPDZtyQ30B
         N+aaKv8BnpP3G3ZdiZ7xWG9C0NZ5B8lwzlFxWOwncAtJvm9hbcj7oSGUqW9No8bax1d8
         XT50l3ZN6/0CHtteJ/leAiPZtDhmrBcnswyl6t3uFnvYzr4ShITDSxwrykFrZhAv3s6n
         eBOisu9MpwWGKKNNN9NkJ79lLX7s57QIBu0pBzPDkdFuxmBQz7ks1MNgyepfOpkh9Z9q
         pbcA==
X-Gm-Message-State: AAQBX9e/UO5FIoGB52aY438OVtOzUplpZ0mPIvzjWopHqP4VF5SiQcAh
        rpUl0op/3WkSUhFj2NCDcQ3/zw==
X-Google-Smtp-Source: AKy350btJq1dcxikfjFVQLQ2huwkQploRz/wODMPWoVGMpnf6SZ/qVkkFWAJdCZ7aZtZtXkO34cvWw==
X-Received: by 2002:a25:2484:0:b0:b72:1fae:defe with SMTP id k126-20020a252484000000b00b721faedefemr366708ybk.25.1681244731951;
        Tue, 11 Apr 2023 13:25:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m21-20020a25d415000000b00b8ee02b3b7dsm2031407ybf.35.2023.04.11.13.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 13:25:31 -0700 (PDT)
Date:   Tue, 11 Apr 2023 16:25:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonas Haag <jonas@lophus.org>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: Infinite loop + memory leak in annotate_refs_with_symref_info
Message-ID: <ZDXCKecwxo36fALm@nand.local>
References: <39035D34-8548-44B0-BBBB-5C36B3876C4A@lophus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39035D34-8548-44B0-BBBB-5C36B3876C4A@lophus.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonas,

On Tue, Apr 11, 2023 at 10:53:59PM +0300, Jonas Haag wrote:
> Hello!
>
> There is an infinite loop with an accompanying memory leak in
> annotate_refs_with_symref_info that was introduced in Git 2.28 (I
> think in commit 2c6a403: “connect: add function to parse multiple v1
> capability values”).

I'm not familiar with Klaus and don't have it installed, but a couple of
questions: were you able to reproduce this result with any other forges
or tools, and were you able to confirm that 2c6a403 is the culprit via a
bisection?

In case the answer to the latter question is "yes", I cc'd brian carlson
on this thread, since they are the original author of that patch.

> I believe the bug in Git is in connect.c, function
> parse_feature_value, in the updating of `*offset`: It doesn’t seem to
> take into account that `feature_list` has already been offset by
> `*offset`. I believe the update needs to use `*offset +=` instead of
> `*offset =`. When I make this change, the infinite loop seems to go
> away, and cloning via Klaus/Dulwich will fail with “invalid index-pack
> output”. Cloning from github.com works, although I’m not sure if
> that’s a relevant smoke test in this case.

I'm not sure I understand. Looking at the relevant bits in
connect.c::parse_feature_value(), it all seems correct to me, since the
beginning of `feature_list` is adjusted by the current value of
`*offset`.

> [1] https://github.com/jonashaag/klaus

Thanks,
Taylor
