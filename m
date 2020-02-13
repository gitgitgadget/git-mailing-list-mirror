Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EFEC2BA83
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 11:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B82217F4
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 11:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qH+/C6Cd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbgBMLja (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 06:39:30 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53747 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729544AbgBMLja (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 06:39:30 -0500
Received: by mail-wm1-f65.google.com with SMTP id s10so5845656wmh.3
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 03:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ac7d9ixWHgAQmOEL9MGGcpYeBMdXabZXFsJAd/rA56w=;
        b=qH+/C6CdVc039TAmyFdf6PJRtEAnMp4r16nEQxMVE4QLDW5BqmwKceYZJ34IcplIY1
         gRG2y9yl2p2t7jBLcefS2oi6H85YMWwgvvaFggKgaNlCKey5H6xx+o/cIjsmWfirzkz7
         skUTymahTR/R+DWda9h32qhg4CfRgY7i7mwFTOHpY2R/aVMiq5Np+GimoZXz3jKWUo/r
         MFv7pCRiJ+k/GnOzWNt8IVexqYuhUD2KxcwWMNprdPe91YWDkwBxg5XUnfTkSDQ65ylY
         DlEMab6B4IqWc0AVB3ZQYymczXc+BGeeFHuSzbrziXUIZY1y9LAqz7aUODt08TLzY7tk
         k1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ac7d9ixWHgAQmOEL9MGGcpYeBMdXabZXFsJAd/rA56w=;
        b=rWnPlGsCYnRAH2JmOMRSEFLirsSxlXW1is1jL3HeDpZIdtIEKWQ0VgAkh/ScNISgnU
         lNAMq4U/80pLh6yxsQAvsuam0pSJXU/qe8qQ0UnK9NgoTx1jo+1oVD8ZxE+uuvKrFn8n
         q4exjijzjNnPlVo4C+2IzAl8E/n3xGzr5WFDLaFTRgD/1cObBcj5VTucvOvHlECM5XUE
         9+Xi0Z+2VNV/2ajCzbrE62diHMI6XHjYX78VgXIYryIN6zax9kkbmoJeKWkyaJFfvIav
         LuaJtrtfNqmYhNTOtvlf4FiNCf7JMbSPrTbshy11uqXiVj+A6xKoqlX1obrYbA2PJwWT
         KozA==
X-Gm-Message-State: APjAAAU1cnlDPAImrysLgXcgZ9k2TmKOq+/SrfzWP2iPqSew/kHI7m7z
        ZmGl2EyRp4t/btH0+xcZDiGqXT9b
X-Google-Smtp-Source: APXvYqyvi6BJeeUhpBf5njdT1Kl6vmTyfMW0N13jw973UIuZxdBF0G1jzGPTsuaGCD4hyqpGLw0yEg==
X-Received: by 2002:a7b:cd14:: with SMTP id f20mr5329919wmj.43.1581593968044;
        Thu, 13 Feb 2020 03:39:28 -0800 (PST)
Received: from szeder.dev (x4dbd7231.dyn.telefonica.de. [77.189.114.49])
        by smtp.gmail.com with ESMTPSA id z19sm2484149wmi.43.2020.02.13.03.39.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Feb 2020 03:39:27 -0800 (PST)
Date:   Thu, 13 Feb 2020 12:39:25 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com, martin.agren@gmail.com
Subject: Re: [PATCH v3 3/3] builtin/commit-graph.c: support '--input=none'
Message-ID: <20200213113925.GJ2868@szeder.dev>
References: <cover.1580430057.git.me@ttaylorr.com>
 <cover.1581486293.git.me@ttaylorr.com>
 <4e85c6f7e40e7d6a8d93574645d65971b7cfa4f8.1581486293.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4e85c6f7e40e7d6a8d93574645d65971b7cfa4f8.1581486293.git.me@ttaylorr.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 11, 2020 at 09:47:57PM -0800, Taylor Blau wrote:
> In the previous commit, we introduced '--split=<no-merge|merge-all>',

Nit: the previous commit introduced '--input=<source>'.

> and alluded to the fact that '--split=merge-all' would be useful for
> callers who wish to always trigger a merge of an incremental chain.
