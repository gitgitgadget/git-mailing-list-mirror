Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F43C43461
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 00:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C47B3206D4
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 00:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="mXvVgRBR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbgIQAxB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 20:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgIQAw7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 20:52:59 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B63C06178A
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 17:45:24 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id n133so492245qkn.11
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 17:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=aMa+ajhZdMzEcXQHJEs22+S1V+C8tYEUVGM8vCIGpBU=;
        b=mXvVgRBRjKDGizt3+i6glj16VZVSIbhUkI3D5uwxCGfNfiIh7SBp40WQ6rX1hxe29p
         H3JxurK12aavzYhhdx2K+xgMV5ILcQeeAJgeoTueZxIHMI3u06OSZuZDRcWCCNu6sJhb
         1atqO8G6xS4HujHUIyEV+Od34euwRQGSQg+3fQdbySXVUzr9EmbvQSqerLdJPgb/AibD
         s/5RKoN39rJ7mAnl4vUzhNdm4zRy+GqdaiZHPCSWAxcMnpkB+WNZ5eh8pNCwDgL8XZih
         gQwOgGcz9LNW4K3PcPQTVsWodFLvBpjtUa3vUqQ2tfwunnUInhA4eExeUZENrWYq3NB8
         gfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=aMa+ajhZdMzEcXQHJEs22+S1V+C8tYEUVGM8vCIGpBU=;
        b=NQ3c5x/ShA5bM1LgjlzGtU/vONQ+3csbSR9zOZNKdu3fRcjWcpsJ+PDz/TnAQzrCGb
         a+gxcJKn8UxtxG2gIKt4Vqrtqa3D5uCdRjwpbmV86HI36CPT2Ls8JK/YZoP+hKgmbSUK
         YVMY9kkotPH+Fg5GL1Sc8EwT7fdwbg+oWZzcPGqgB99Hp8sga5k6Do3/nUSKD0ou7tDb
         hY+5PcwnH/20CfMO7Tzlsdyqvgjr1bccKQLzq/O4Pp8PV8zVyTZzWxi9RJI0Ew5Oo7VB
         XbCie3vp37mIVi5iQO0bGn0A49fs69qaOSHfKq6h/dJDFX4vqI/E10uJdFYnrSK08yfm
         FrWQ==
X-Gm-Message-State: AOAM531TQr3q1j0H0W9TUA/BWY0liLT0o/GGdjLU2m33VAuM31gkhMJS
        CETIJ3UX7+QutNbR9CGaarFHiQ==
X-Google-Smtp-Source: ABdhPJxQf0v5jghky2O2MEW1YCoD9Y8zqK+ODUrgEo/nzgiExV/bvDVQtrX/PsKEFjU9zXMPd3PbRQ==
X-Received: by 2002:a05:620a:55d:: with SMTP id o29mr26278070qko.12.1600303522657;
        Wed, 16 Sep 2020 17:45:22 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:e86e:6adf:7537:ae24])
        by smtp.gmail.com with ESMTPSA id f33sm20090340qtb.45.2020.09.16.17.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 17:45:21 -0700 (PDT)
Date:   Wed, 16 Sep 2020 20:45:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, dstolee@microsoft.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: Re: [PATCH v2 00/13] more miscellaneous Bloom filter improvements,
 redux
Message-ID: <20200917004518.GA6478@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzh5ptj5k.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 16, 2020 at 04:07:51PM -0700, Junio C Hamano wrote:
> Yup, lets merge it down soonish.

It's me, the bearer of bad news. I noticed an uninitialized read when
running the tests with SANITIZE=address,undefined. I *think* the fix is
as simple as a single replacement, but let me double check before you
merge this.

Sorry this topic has been such a disaster. Assuming the fix is isolated
to a single patch, do you want a new version of that patch, or the whole
series?

> Thanks.

Thanks,
Taylor
