Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF78C4332F
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 23:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiKIXN2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 18:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiKIXNZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 18:13:25 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BDB1124
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 15:13:24 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id 63so41988iov.8
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 15:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fqlAdA60v3q1elTfWTua5olGgLs4mpMsIMRxEhN59s4=;
        b=vPRPGt/6+gd9X9YlGYxoQozXR0zdkSqZ8Yzg70KAM6qL051T3FpMGy42oqi0L6QpaJ
         lIS1GO+/84aAtz5LjC/HV7o3Zjsu39ClYFdW4mOGxj5OG4Vl/B7c0ul9VEop0TQDaXX3
         O2mo20MAFfS7LYtdeMm2/X6BpzcAfDpnvRbCIC31KiCJB7t4eBdPOVp9OoEnQ/lBEeH0
         EtEB5uXDTmGug36fBfdCcAsybI55jFasrblQXX5GxtmRtQvNtwS+xDVAFus1YGdcGz9G
         J7yXHLGO11wGkpp2hJKmdjo7SMgtj9DZPD+MJ561O498DWb/6vKAzKQ2Ake/VKlrunZM
         Fk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqlAdA60v3q1elTfWTua5olGgLs4mpMsIMRxEhN59s4=;
        b=7SqhzozvBxDRctEbpltM9uEzoIAXPekA7AI5aXMz9jRCjVAIY9WJkChczFys6ZNDN8
         dG+v1X2NHHA820n39ZMUitrJ46ErcBqRfpF7Uq3CgIOsAFS+bUyhlyYcEVVUiLrU8B4q
         bgln6MTOX4tf8pti12RaDyzWlJSNYcSqAnMS7PB5k2Yc8H3gpEXuDOGGr33s7GInspMd
         GrQS/1QcfXe4nGlz469F/+BxKuEsktsbxSSfFhA1HF7S4V5mO/n4P/FVtsIG6bnrfml6
         5Z3L3xEf+zb3FDFpTPk2WCPwVMd3SzBBW5TE+13QjspbOGkWf+CnZjkF7C96l8PXRWQM
         Xwqg==
X-Gm-Message-State: ACrzQf0ZcWSPu2BIlsoQow/iBxPcXFpYhHnmm/nzjd1zAKtAz0nAGXSj
        /CLGmn465qMZV+jBPXHPr4g51VABMUl61A==
X-Google-Smtp-Source: AMsMyM57dKNatBwzzpSRIheqt8/hKtquggDBjnMDt/BQI3CHJ4kmxGRAphcrnEUQ3RWlJQfGKstomQ==
X-Received: by 2002:a05:6638:25d0:b0:375:2d83:f95a with SMTP id u16-20020a05663825d000b003752d83f95amr36273775jat.270.1668035603683;
        Wed, 09 Nov 2022 15:13:23 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q14-20020a02a30e000000b003753c068a41sm5070472jai.115.2022.11.09.15.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 15:13:23 -0800 (PST)
Date:   Wed, 9 Nov 2022 18:13:22 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] Change git-send-email's sendemail-validate hook to use
 header information
Message-ID: <Y2w0EjE5iuiUCEby@nand.local>
References: <20221109182254.71967-1-michael.strawbridge@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221109182254.71967-1-michael.strawbridge@amd.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael,

On Wed, Nov 09, 2022 at 06:23:06PM +0000, Strawbridge, Michael wrote:
> Since commit-msg and pre-commit git hooks already expose commit
> contents, switch sendemail-validate to use the header information
> of the email that git-send-email intends to send.
>
> Cc: Luben Tuikov <luben.tuikov@amd.com>
> Cc: brian m. carlson <sandals@crustytoothpaste.net>

Without having looked at the patch below, would you mind re-submitting
it with your Signed-off-by? Please see Documentation/SubmittingPatches
for more.


Thanks,
Taylor
