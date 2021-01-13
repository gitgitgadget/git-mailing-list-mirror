Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PLING_QUERY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A62DC433DB
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 18:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6B38233EA
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 18:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbhAMS2o (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 13:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728311AbhAMS2o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 13:28:44 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28C4C061575
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 10:28:03 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id 2so1765679qtt.10
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 10:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q1uSYFCFQlXmks76b5V1ric5hdxp7eUienkF7k7AkMs=;
        b=TcPFYA+UNPFTem5bEhvnv5wfjsGZcvBSPYShJaVX22sQoRzX1m+QmQ07Cm0E2eoQaG
         SEFEabHhyyyz0pkCG6jsVV5tx/Zw0seZSjN53gxGYyB8bGoEP14gRP5o1hz7NoQQ7Wtx
         OnoO3eGTlZxUoSuWeGqfn6fipA49YvhNoNUGSk2/81ou51SQ6v/Uycv7q3tzjeHr/Xji
         fq4e1u11tRn3s8H7TBdgzvN+ev9Qnm10grn7V1u6gfkXXZUazPdsffgdJweDHx1EHeCl
         3JseHyoiOExSASR2W/BwFb+bUw+DG2Rs6+3mEPfQWlQq6XoUo9CIaSZIAhcvQcKCTf3y
         tI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q1uSYFCFQlXmks76b5V1ric5hdxp7eUienkF7k7AkMs=;
        b=dD+V56JtdLZ5PXiYVfGTigMA8foW2DWsIEzUb9F766vi8Fvm6T6ghfl1LDOUH5EnS9
         fntGxrRiKZItDNwdPmNagdge17PaZZP2H3UcjuT8c32Z6HXl4R1mPcxrfFEyLEXdlQMR
         9ft/MifAc0t57HOcv69h/j8CIZNq7EtfyRorJasS+zGB6gBP+HdomQ10MiGdJ3SF4UN3
         we/6ZXj9Qg6ylxPCH8SaN1uGFt6TR7QmdACHcmdfQZVNSBVd/VDwmdRx3lsljb4Jec3j
         QGGJvzk5gf/S/MGXosU0yYed+bPsMKr1HpmIH3Ih4ouy27MqF8cugLGViLiZIAMhIfBe
         hkTw==
X-Gm-Message-State: AOAM531FqL85CUwkkSstawXUC/0YizcPhYNVcC+fHLB5lk9zt6B+NxYk
        /UkWwy4BWpnEeFam9JhLO3vxWA==
X-Google-Smtp-Source: ABdhPJwNKO9BVzZWxgaXBNrGY9CozeiIRBmLM27L7WPgF2iATxmN4bCyQhvJq1voSQtCNy64/Y+Hcg==
X-Received: by 2002:ac8:bc8:: with SMTP id p8mr3445787qti.135.1610562483180;
        Wed, 13 Jan 2021 10:28:03 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:b172:2e4c:efe4:db53])
        by smtp.gmail.com with ESMTPSA id p15sm1555379qke.11.2021.01.13.10.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 10:28:02 -0800 (PST)
Date:   Wed, 13 Jan 2021 13:27:59 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Charvi Mendiratta <charvi077@gmail.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: How to implement the "amend!" commit ?
Message-ID: <X/87r7+dcYzzcus+@nand.local>
References: <CAPSFM5c2iqBn8_Dih2id7q6RRp0q=vfCSVUHDE5AOXZ8z3Ko9w@mail.gmail.com>
 <CAPSFM5f+cm87N5TO3V+rJvWyrcazybNb_Zu_bJZ+sBH4N4iyow@mail.gmail.com>
 <X/864HdPtf1km0xZ@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X/864HdPtf1km0xZ@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 13, 2021 at 01:24:32PM -0500, Taylor Blau wrote:
> I think that this trio is a good path forward, but...
> `--fixup` behaving as it always has, which is good. Then it makes
> `--fixup=amend:<commit>` insert a 'fixup -C', and `--fixup=reword:<...>`
> insert a 'fixup -c'.

Oops. Ignore everything after the 'but...' until the next '...' below.

Thanks,
Taylor
