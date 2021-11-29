Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF7DC433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbhK2Wyh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235561AbhK2Wxs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:53:48 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3863AC043AE3
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 12:51:45 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id y13so77314865edd.13
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 12:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=cT6MCw4ua+3NMtlmsBt7ZazwQiDIr9Pn9B3Mk4oe894=;
        b=WaalYrmHYigxKICmf+c7UEx1ddgZGLKZm9UQwrLn5XfLIwvMqz6w9Ekfs5chbsM6Fh
         WuNROtViki7UeB9AGOi5fu+pwq58IbqLnaaW0AQrzyNkBQJtXEmazCuVJ/YxgTwgUzMn
         JpmR5TlbnsVmhSgFXuSDrM3PJUnOmZDCfo/WttaooNJRYHl5RtHkZtfAB2e5iRuVALSW
         3++Sx5yHe98f+rZcEyTuILRSm0BdrIHbcfkD6QMZ89iYomiRqcIjCYxKVdN7NF4Nu2os
         rM0xVhvYyeUXT0tsDEEAri3pt3hunWNErsb5tRA5EaVoSjcWPpvhXtoLfls6NSYr3v5W
         IQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=cT6MCw4ua+3NMtlmsBt7ZazwQiDIr9Pn9B3Mk4oe894=;
        b=SbnS7anyFiPcEbqXNdsiYl+w5LiK2RBz/x5LnU1CHzVNvn+21dbGkhWxeqdyprCmKL
         9OQsMxPjZ/xa04HwluLcxnpwo/1I+QULfy5klkxBNvK5fkxh+7UEqlQZ8KX5/83jY/7T
         dBRNZMJy9tVL3/gU9c3rBE2gd60qc126SfAfzCaiifd7V48gyET52xEQimPKVkLqUQ2G
         pRtL4ZLsW4wlTETYLaqarlt/YvR2A3MI1Xjg7PyS1Yejpc+eCySYCNS5Dkn0LsvSdi9s
         Lk9UpZTk3kE7zccorc1EemDXbQm/Vgg5NkqghSWeFW6q+NqMoMFwceVLh2bjUQyyTE1o
         PwTg==
X-Gm-Message-State: AOAM530KSmeUrrsMulGnihbRwUUWy+yTB9faN1zXSf1EM6w0HY9vVydM
        UUGIsEx3frGnvks3BFZiOghSimETkViC0w==
X-Google-Smtp-Source: ABdhPJyHJDgTQW7u7VUtwRbqjN/cDjKITBtJDz//0GbQ7JLPMoU5t0Z0aBBuFllp+biM1OrAK8urzQ==
X-Received: by 2002:a50:955c:: with SMTP id v28mr75888740eda.293.1638219103477;
        Mon, 29 Nov 2021 12:51:43 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g12sm9656116edj.45.2021.11.29.12.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 12:51:43 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mrnck-000rdE-KI;
        Mon, 29 Nov 2021 21:51:42 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com, peff@peff.net,
        gitster@pobox.com
Subject: Re: [PATCH v3 2/2] config: include file if remote URL matches a glob
Date:   Mon, 29 Nov 2021 21:50:11 +0100
References: <211123.86pmqrwtf2.gmgdl@evledraar.gmail.com>
 <20211129183348.384067-1-jonathantanmy@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211129183348.384067-1-jonathantanmy@google.com>
Message-ID: <211129.86zgpmelcx.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 29 2021, Jonathan Tan wrote:

>> On Mon, Nov 15 2021, Jonathan Tan wrote:
>> 
>> > +`hasremoteurl`::
>> > +	The data that follows the keyword `hasremoteurl:` is taken to
>> 
>> Both here..
>> 
>> > +		die(_("remote URLs cannot be configured in file directly or indirectly included by includeIf.hasremoteurl"));
>> 
>> ..and here...
>> 
>> > +		if (skip_prefix_mem(cond, cond_len, "hasremoteurl:", &url,
>> 
>> ...but not here (C code)..
>> 
>> > +	 * For internal use. Include all includeif.hasremoteurl paths without
>> 
>> ..but here..
>> 
>> > +test_expect_success 'includeIf.hasremoteurl' '
>> 
>> ..and also here etc., let's consistently camelCase config keys whenever
>> we're not using them for lookups in the C
>> code.
>> 
>> I.e. "includeIf.hasRemoteUrl" (possibly "includeIf.hasRemoteURL"?). It
>> makes them a lot easier to read, and makes the end-user documentation &
>> messaging more consistent.
>
> The middle part is not case-insensitive, though - I tried changing it in
> the test and the test now fails. (Unless you mean that we should also
> change the code to make it case-insensitive - but I would think that
> it's better for the URL to be case-sensitive, and by extension, the
> "hasremoteurl:" part connected to it.)

Ah, I forgot about that edge case. sorry. And sent [1] without having
seen this as a reminder on v4. Makes sense.

(I seem to be getting really slow delivery from kernel.org to GMail
these days, sometimes I can see things on lore.kernel.org hours or half
a day before it pops up in my mail...)

1. https://lore.kernel.org/git/211129.864k7ug02c.gmgdl@evledraar.gmail.com/
