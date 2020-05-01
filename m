Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C74C47254
	for <git@archiver.kernel.org>; Fri,  1 May 2020 22:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2320C208D6
	for <git@archiver.kernel.org>; Fri,  1 May 2020 22:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Uzf2ogCV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgEAWvP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 18:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726045AbgEAWvO (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 1 May 2020 18:51:14 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBE2C061A0C
        for <git@vger.kernel.org>; Fri,  1 May 2020 15:51:14 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id a21so568300pls.4
        for <git@vger.kernel.org>; Fri, 01 May 2020 15:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BLcgwsjVkv1k1EAfJpo9n6+2T/T6LPtsi/GdWvpnPMU=;
        b=Uzf2ogCVaw6PvfdnCBwugdpS1h80r4gvEGFYNGQ+7q2z/uqqfzMl9m0VU9Yxxe2LBu
         iuMkaGfESETWsuF6UuUMigN4hhRaYe8pDXY/rGpU0/CDXV6TCfgWHr6BZwoBPQEEQV+P
         eNHV+yTlia37B1Kyym2/N4g46dos6MgWk+w6cnOTna1lXZA5vuWFk8YFl10p1qdH38Rz
         nAu1CJyI4jeMxDKUJZvyrNsWR0b7jGqoGQ+x/CRQeAOu/0vDzn7axcZ0DulhmuKUpIrX
         nkYxcn+uCl7PlB5pEJcfLwpuVeLnwm+bT/fxlmX+FaSCU63HNlFGlPDVAoeGI0Td0JGu
         pauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BLcgwsjVkv1k1EAfJpo9n6+2T/T6LPtsi/GdWvpnPMU=;
        b=XiTqLrJ91kfaRWMv3g4aX38KsNVdLmUHPeyXv2RbTmJXI0T8XhoVkxPhtRMv3m46Qd
         HXgk2os8hX+HizLZaXzJat2KziVrAp7/HwsY8tjyKHppdeXmMHVq65y2jajZgafSz1LJ
         wSw43LcXVzpY+rF7XlgH0oeab4IaPupEbLNnXCQ3ov1Bp6stNZwTWtcSV6RXQ0OPC/fB
         AcQZVvL7+Iw15tfTtEC+/Fn/WgsgnLlDNcH8MfNnuPZW6j2BdcFqetKFbN7soXYZ2/tb
         bo+9hCKw2JKLCi6BJN7NnBDrEIvu/vALr9NSTH7o78Rvjy+un+AxEiYbs32rnQB5W3eI
         EmnA==
X-Gm-Message-State: AGi0PubtnLoPOPl7XC8tFhY7/dIZ1MBWpfePn9xnLUwZvZWcFgYaoNE2
        2E2I+d/YaIKjaYNM4vHh4XbdiA==
X-Google-Smtp-Source: APiQypLXfl8Hzxlzwxd2GukYm1O2JQ+hf5QoH7OdYa1Hr1C44Bgk1QwzqORzWe7fk/SPMOnJ9rmMQw==
X-Received: by 2002:a17:90a:e013:: with SMTP id u19mr2271346pjy.16.1588373474089;
        Fri, 01 May 2020 15:51:14 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id t80sm3184329pfc.23.2020.05.01.15.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 15:51:13 -0700 (PDT)
Date:   Fri, 1 May 2020 16:51:11 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        garimasigit@gmail.com, szeder.dev@gmail.com, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 01/12] bloom: fix whitespace around tab length
Message-ID: <20200501225111.GI41612@syl.local>
References: <pull.622.git.1588347029.gitgitgadget@gmail.com>
 <89625b0efae43c8cb0d444a843d389d6cb9f6772.1588347029.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <89625b0efae43c8cb0d444a843d389d6cb9f6772.1588347029.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 01, 2020 at 03:30:18PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Fix alignment issues that were likely introduced due to an editor
> using tab lengths of 4 instead of 8.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---

All looks good, thanks.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
