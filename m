Return-Path: <SRS0=tECa=DD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1644C2D0A8
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 05:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ABD620809
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 05:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vXgSyA8q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgIZFlm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 01:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgIZFlm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 01:41:42 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083DCC0613CE
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 22:41:42 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f1so382332plo.13
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 22:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PCzICHbFO0biGuC7l+0ebV5vWZYbNRi4E4EIecm3hDA=;
        b=vXgSyA8qfGqHfvI6vM7kgGEARxRAWtr2EWAEaXQPLchA4O5hEF8dJQRwLm9ly3BDKE
         oFQhapQd604HAmIG5PwJqI4bUcFW/5/y1vS+jWsWvsUyFQukgTo7pC3r5Bw+cq56v5dh
         vobjRTy6de3mX0FY3Uhn9mCPFPTCUpXgZV9B9IO93c65jrBR+5q8TKezts1wVkqKHmJO
         FiLMz3WcW9rAaBJXLvDHDRfSfpBSeaaeqTlPFukPHGB2JXxgcy/ygBL5K3fAqxVmEUQr
         5kjNtFJy2rESkE+pSGiIu87+0CyCNRH99nFv4yIWLx6jXhcCkxoje4z9ef0wMLo8pJpR
         yoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PCzICHbFO0biGuC7l+0ebV5vWZYbNRi4E4EIecm3hDA=;
        b=LEyjh8PoszTRJ3bj+Ag2LCIKSiriHzJ0qYqSRrbLC7x9i1AX/IMWnOyJ63kaJ8WxVV
         Df0k80QyuHKN51CF5fDTx7roHrS+oU7/E3q4tnc5xpWjZ9i6ksycnK3YiWU0lJSA83xE
         KqdkTefteTBzxEOI6TQ2X6yNbepiCURA3hkGs0CmaKkj2bvBt7BIaibiGETqaWxFZema
         Xn97ekPnH56/NHVQcj5nCUaB2MoeotN7KLYTvFmvOh8Eekkz+HR7Bhg5AuvU6ky+ahas
         XO4HObU8dVLkEak+jDlg8zVAZS79P1VLBOSYh6uRJFM17G/qFCFooZx/DzbtCZX+EuNX
         9NYg==
X-Gm-Message-State: AOAM533j1iNv6ylzbl5rUDnWu8JQWiYZgE+HKRic4c3A4UqPX7EoR6y6
        TgOJYRkLy/MAw62qoo92gU4=
X-Google-Smtp-Source: ABdhPJw+D7+BMXbEvXlDERkia44RWMSWmNbmfj/OL/l1dgJaCKwCFgkcdK1ltRWfdMmyK2rvWhfa6g==
X-Received: by 2002:a17:90b:3355:: with SMTP id lm21mr894874pjb.125.1601098901569;
        Fri, 25 Sep 2020 22:41:41 -0700 (PDT)
Received: from generichostname ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id j4sm3560854pfj.143.2020.09.25.22.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 22:41:40 -0700 (PDT)
Date:   Fri, 25 Sep 2020 22:41:39 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] pull: don't warn if pull.ff has been set
Message-ID: <20200926054139.GA230339@generichostname>
References: <20200925035023.8771-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925035023.8771-1-alexhenrie24@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex, thanks for doing this.

On Thu, Sep 24, 2020 at 09:50:23PM -0600, Alex Henrie wrote:
> A user who understands enough to set pull.ff does not need additional
> instructions.
> 
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>

Reviewed-by: Denton Liu <liu.denton@gmail.com>
