Return-Path: <SRS0=LMRs=AT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A770AC433DF
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 21:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ADA820772
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 21:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="DEDbZwwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgGHVWO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 17:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgGHVWO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 17:22:14 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C2DC061A0B
        for <git@vger.kernel.org>; Wed,  8 Jul 2020 14:22:13 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id m8so3524qvk.7
        for <git@vger.kernel.org>; Wed, 08 Jul 2020 14:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iRaCaTaF5F3LFzCphLeraLq98lYvplJvVHu+TnEp7AU=;
        b=DEDbZwwgbT4ICagH+7caD23vpOMstBnThXVNVSztucqzYb4BxlmxOkN26vzbVRY/a6
         bosXah4ldnpj0HU7CTdAdcZyJzBAv12R/UkZjAkDnx44VBV/Wc9zI9nUMRHTzMIuUYWa
         8/R7POIFCL/kg8rf4CM9nLI6AaYm1rVL/Dr8Ksn77K4LOurMAaCDE40oJhxSFSsJgQTT
         RDzBqH7fqmeWo5bHhGQr+yV4Lh4uJMwVsL5CK+1ST2s/kGvBHGogcTFniKdoM9WmzmIQ
         ZYT2hPZ533AS1W1A/kuFe+tiGeNf3rEozkuERgmUdcvpA/Bo4FCtTcq/do5N2TjrKnnc
         GLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iRaCaTaF5F3LFzCphLeraLq98lYvplJvVHu+TnEp7AU=;
        b=A43EPuqQmvuneBjoUzfsaKmLt7zb1N8ALKmHoxpp01Gg5OD+z0SeUKamy20Y8D4QGv
         +kMrp+X1kSew8sKmUNqWt7bIWzyt8agXG+55dLMYlqMbZBWIoDCabD7+ajeNss6YHkgc
         1MxsBjJAclQB2RWNaCp1XndsPp38D7/Yrmj0MaPp52wExhkpIE4Mrbs6xgdqkA/UCZHW
         R7CM8+xFL7l/ENYlhSCpEPLTikk3nVYfLsjMsZ2v7NVxnEXxDSi0O+eGM6LixI8iaLEc
         +74DM29X59rT5+tUnPa3Ba50AkxSrWdc6PW8gZzVCgH5X/wdJH3eg6RT4s5yE0klUoEg
         jhbw==
X-Gm-Message-State: AOAM5312NjfDncygqUtK/v7II6ZOn8bAAIZ193FwabBhydaSc3kilfsI
        crjGcoZUwuMOvGABXvNIPOS15g==
X-Google-Smtp-Source: ABdhPJwxpjD90pe6S3/YdflorLwcBg0rbWAX9dEBgAD3gnLM2j5FvqpI+oMR5/7T2j0XjQ79zV4Osg==
X-Received: by 2002:ad4:45a2:: with SMTP id y2mr30945578qvu.187.1594243333023;
        Wed, 08 Jul 2020 14:22:13 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:6410:18ef:f702:66bb])
        by smtp.gmail.com with ESMTPSA id g41sm1050518qtb.37.2020.07.08.14.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 14:22:12 -0700 (PDT)
Date:   Wed, 8 Jul 2020 17:22:10 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, jayconrod@google.com,
        jonathantanmy@google.com
Subject: Re: [PATCH] commit.c: don't persist substituted parents when
 unshallowing
Message-ID: <20200708212210.GA17015@syl.lan>
References: <82939831ad88f7750b1d024b2031f688ecdf6755.1594132839.git.me@ttaylorr.com>
 <20200708054112.GA118756@google.com>
 <xmqqk0zd20cf.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk0zd20cf.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 08, 2020 at 01:55:28PM -0700, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
> > A fairly straightforward test that demonstrates the bug being fixed and
> > only relies on what was set up in the initial 'setup' test (4 commits).
> > Thanks for tying that loose end.
> >
> > With or without commit message tweaks along the lines described above,
> > Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> >
> > Thanks for your thoughtful work, as always.
>
> Thanks for a nicely written review.  It would be very nice if we can
> see a reroll before I have to tag -rc0.

Of course! I just sent one here[1]. Sorry for the last-minute addition
to -rc0, and thanks for fast-tracking it down.

> Thanks.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/1f769bbbb4f1b4ad67d29ee7b3e5282446e4cc0f.1594242582.git.me@ttaylorr.com/
