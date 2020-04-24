Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4421FC54FCB
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 00:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1979C2087E
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 00:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ah7bA4BY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgDXAtl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 20:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728450AbgDXAtk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 20:49:40 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DF1C09B044
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 17:49:40 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id x77so3951698pfc.0
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 17:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HvdcEA1HfgF2Al+adyTBiYOhrRyMeuv2LDzwrV6HeoM=;
        b=Ah7bA4BYcpPiZjd9LfRneztMjbs40Kpxth9CBgTVCFK9RJuiIfBraAuVxeKluNwwAw
         HuYcj0uUpzwza6v1dbJEqYvP63tajcY4qsRshcXq4nj4MFjHsoMHD3bv/HBPBrjN1IL1
         bYB82TqtopM00iAWRl2qF9Ji2+OFWmr3SqDGGX5dfp1tGG/QRpKKrME8LmB5YswVsQmg
         aTFQwULqhTQYl/F3v4/Yxbnkn78KUJnjWvVBgu/S7BpreK+dTEOPsE+OWhMonTmzVg6y
         ne2fnezYzMYM7fsOLKVDNoo5RlT2hLElFRhhp9lz7uOSio2OJR9JhGq6DMQFofO31Job
         b75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HvdcEA1HfgF2Al+adyTBiYOhrRyMeuv2LDzwrV6HeoM=;
        b=oHjhwvjZLeH4m6+ukfgRQaAxVBsQZMz+FW/Ws/UiAT6x8YM3GyJ/OJqgp8HaDrmxVO
         bvaodx35kNarMSpQPvQos9WErnw21FzcmNq6NsKjIJqp22R/YD6DapW/XhquaFodwsgK
         R4CoSY0o4JCmz/MJZryip0Xt94+/N5/4i4o9eg5sUYKZJy/PYh9FM0d+oBAJOB/Azk6L
         4CJi2d9+YzrxMwfjr3jZ4P1AMzJcajd3hLbTvUj2AdGgdrr542MfKeMfyA0wOH7UjW+G
         3SZrNBgE5rAJpUXk/tacVHs7OVuZ82L5/KZ8CyvB4ETCR7MpuTOcb98dUjF9jqVrRQuF
         BOxw==
X-Gm-Message-State: AGi0PuayL6kxjkQRL8fQXD5xGsYhhf/Od4DeZS8xBmDrpQmLWIWkrshC
        /OPDBXf0D/GMBJ+U4ZAdNLE=
X-Google-Smtp-Source: APiQypKLE66e0yaJwMGRZR4j9tKuoqbgR6xEB971cpMeAi/1uW84gO1IE0gwYABb2mfyOxr3+We9Fw==
X-Received: by 2002:a63:fd0c:: with SMTP id d12mr6283013pgh.41.1587689379455;
        Thu, 23 Apr 2020 17:49:39 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id d18sm3839417pfq.177.2020.04.23.17.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 17:49:38 -0700 (PDT)
Date:   Thu, 23 Apr 2020 17:49:37 -0700
From:   Carlo Marcelo Arenas =?iso-8859-1?Q?Bel=F3n?= <carenas@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ilya Tretyakov <it@it3xl.ru>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/3] credential: handle partial URLs in config
 settings again
Message-ID: <20200424004937.GD20669@Carlos-MBP>
References: <pull.615.git.1587588665.gitgitgadget@gmail.com>
 <pull.615.v2.git.1587685397.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.615.v2.git.1587685397.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reviewed-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>

for the whole series
