Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8CDC11D10
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 17:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B48208E4
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 17:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q2xovEjX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgBTRUF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 12:20:05 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38190 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbgBTRUE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 12:20:04 -0500
Received: by mail-pg1-f196.google.com with SMTP id d6so2263313pgn.5
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 09:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BebCYY0fF+cLgoUzyUdjPiqFzI0NwpVTBaFGIO0OZFI=;
        b=q2xovEjXD9RYoU1RLMazqacB7aSd97Clw4OxSdlxwdnxniRh/JtZLKizZ+vJMnRZvH
         LQBG1DzVBdIJ7LuVbnOhhSoyFNA2hoO0W+e3IAYUyglTvHIKYQ7sYxLSzgfOKmLxdEA6
         rsCyOjW+f7Le/+CZt06cTxpJ7U6U/571l8w4dfnVzaxN1MaI2NVyQGwWCZ+rGSbCsenW
         UJy4f0tK4RukqSf8YCgqW2Egkh5wxCe7wWgONEKqNEHLo7k8FHVJcQavs+sxph5Jnfkx
         UqfcmFWceiZn4lDZMb9BsqpBMXlcwia6/TX/jdXbtkCYT9ZwH81fnpynbyUZxJ9OyocU
         Abbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BebCYY0fF+cLgoUzyUdjPiqFzI0NwpVTBaFGIO0OZFI=;
        b=nprSZPSuaqu6Y7Vy5oK/30JSfTpvUbVMImEjZcdoJQOewx0ys1W7t/VdAxzK3wPLFj
         l09GzLXgiDP69+sA83FU6NAJimnQ1AoxDOrpdWCSCXkKzcrwMrLelg1WXGZOl6AQtVcz
         Rd7LU1ck0edtM92Pb0Wx5Eptl/86m9I6hQaW1cjMKG/BNU6OIH2gI7ErhYNWB2NjizFV
         AuHTOULMyLO6Q/M86et240HWvU2gg4StQi0dfYkGXKFNmhNEeKdXiQ0RE26pCKaS/hwO
         sAE1yzVjmCEmgrfxHcpM6KkS2flOb7ZEJ3UPpjCYVHV2xCgMiYoSMlatDI+3JCxj3sMW
         eazg==
X-Gm-Message-State: APjAAAV4Ngs3RsKJn/87Tn9+uMWHiwMsmgicoP13P69I2ALhGDJw7I4d
        U8n6KmWMeu4mbP6Oh0O+grs7zaQL
X-Google-Smtp-Source: APXvYqyD59vRTGlb12UVAWmYbSm1SplVeb05vZGMWOV1fEyPo8qwe5O0tSZKjeOtVlxeehKNQ95ylw==
X-Received: by 2002:a63:ee12:: with SMTP id e18mr6492678pgi.33.1582219202757;
        Thu, 20 Feb 2020 09:20:02 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id y18sm197320pfe.19.2020.02.20.09.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 09:20:02 -0800 (PST)
Date:   Thu, 20 Feb 2020 09:20:00 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v4 4/5] Add reftable library
Message-ID: <20200220172000.GA61093@google.com>
References: <pull.539.v3.git.1580848060.gitgitgadget@gmail.com>
 <pull.539.v4.git.1581029756.gitgitgadget@gmail.com>
 <02d2ca8b878a67a3334b222725645dd035b4289c.1581029756.git.gitgitgadget@gmail.com>
 <20200207001612.GF6573@camp.crustytoothpaste.net>
 <CAFQ2z_P+sdd5+46Ov_CO8ae4j_3aA4ahdVR5D_K1qKSQ-q+OcQ@mail.gmail.com>
 <20200211000520.GA6454@camp.crustytoothpaste.net>
 <CAFQ2z_N1sYh1TBzKue5y0039xQ+F6BBEUcFYCXS_OKjoxJ7v_g@mail.gmail.com>
 <xmqqwo8tw0ec.fsf@gitster-ct.c.googlers.com>
 <CAFQ2z_OF=P6YYuFkB5=4w0-nX+g59bagZGvcUBg_kSh-gOdAbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFQ2z_OF=P6YYuFkB5=4w0-nX+g59bagZGvcUBg_kSh-gOdAbQ@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys wrote:

> The ground truth for the format is the spec. The spec is part of the
> JGit repository, so it seems reasonable for it to be reviewed there.
> Do you want to move it somewhere else?

Let's stick a copy in Documentation/technical.  I can send a patch to
Git to do that today, and we can update the doc in JGit to point to
Git's version as the canonical one.

Thanks,
Jonathan
