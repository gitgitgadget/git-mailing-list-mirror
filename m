Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAA2C4332D
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 00:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C3D2072D
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 00:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBSGRbiq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbgCTAjZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 20:39:25 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46407 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCTAjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 20:39:25 -0400
Received: by mail-pl1-f195.google.com with SMTP id r3so1772778pls.13
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 17:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iFUIdNhYliGCehlReKvFU9tUpu+1DsX6YtxX1QdRgD0=;
        b=iBSGRbiqF8fkJuAUXDExS1XfzqE8LEhMpmfbLxkPVwmQdsL5+QAROB+4Lo4E0NzaSl
         VIalA2k58fBDNWBnQgJK7aN4AyTlPoXXmQihqWlmgR8BfPZxDKULF0ON0lHiKErstmbE
         RiJ8e4I3gGMh3d0Oo40Mim87lB8O8HkkAYzOraWZWGKFl5PrlP5rSPI9mp3iFN/Z2YsE
         OqQC6DrlSsfPMZzyYeplOpOoXuz2ClHY5B6A3QpKPKB6x0BBXlYhA7UWtpm5Gku5mCeS
         2d+y7p0oxaj+jLB0AI+Tds29dKa8S+YvVgsVyZ/LPunOJ8cmuNWh0QrIdCVgQFRiKrxD
         LG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iFUIdNhYliGCehlReKvFU9tUpu+1DsX6YtxX1QdRgD0=;
        b=ASiSd3YBeeucJgAzuswq33GSTFJSMpIfXKGfseSjUC5y0haHR6cVppFVDk+Xv9sEZg
         oVzkDWYKOPZNtWYyUd6yt2fVSPeC/d8SWsYYjW8LEV9VRIw8zIE+o4Ywcdb3LGSsybWd
         wr8SoJBWaANq4LKa3x6ENHnWAhX4WeKxm7xYr+GuMVvaLmnKdPIktXTdsNRPY9+veEaq
         dEwP42N+cl0I6y+/1klGjO0TgqgS0r4tqw7iduWrZRQ8cAuIbC/DbIbZRsZmf0Y7f7Q1
         vhiHvnIrBLbL29HO+f8oO79EFBmMOfaRclVyNcQLfHKq/7hapLcJyKpDfDlhRU0Wo11G
         Ex3w==
X-Gm-Message-State: ANhLgQ23sgqYaFWz2g+OncmKRr8LjVqLzJ9R4BbAkJFZZUFtryqMsC3P
        UAk1sqvYy2JWGRVkBgSEupWHigbo
X-Google-Smtp-Source: ADFU+vsqZolv/BNSg+ySQ+lsTlCuEhlao0fwiTtZlJmCs2O8S1GqKnYssSlTn+0cJdKiDI/IpO6mUQ==
X-Received: by 2002:a17:902:fe83:: with SMTP id x3mr6204243plm.310.1584664764316;
        Thu, 19 Mar 2020 17:39:24 -0700 (PDT)
Received: from localhost ([2402:800:6375:576b:56ff:d97c:a505:3e0c])
        by smtp.gmail.com with ESMTPSA id i2sm2890378pjs.21.2020.03.19.17.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 17:39:23 -0700 (PDT)
Date:   Fri, 20 Mar 2020 07:39:21 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/6] t5003: skip conversion test if unzip -a is
 unavailable
Message-ID: <20200320003921.GB1858@danh.dev>
References: <cover.1584625896.git.congdanhqx@gmail.com>
 <27c7813c0fe81455b675611b9e11fee6ee2a79e9.1584625896.git.congdanhqx@gmail.com>
 <20200319160310.GD3513282@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200319160310.GD3513282@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-03-19 12:03:10-0400, Jeff King <peff@peff.net> wrote:
> On Thu, Mar 19, 2020 at 09:00:04PM +0700, Đoàn Trần Công Danh wrote:
> 
> > Alpine Linux's default unzip(1) doesn't support `-a`.
> > 
> > Skip those tests on that platform.
> 
> Makes sense. One minor nit:
> 
> > +test_lazy_prereq UNZIP_CONVERT '
> > +	(
> > +		mkdir unzip-convert &&
> > +		cd unzip-convert &&
> > +		"$GIT_UNZIP" -a "$TEST_DIRECTORY"/t5003/infozip-symlinks.zip
> > +	)
> > +'
> 
> Lazy prereqs are already evaluated in a throw-away directory, so you can
> drop the subshell and mkdir/cd.

I was trying to keep it consistent with UNZIP_SYMLINKS above it.
Maybe, it's worth to clean it, too.

-- 
Danh
