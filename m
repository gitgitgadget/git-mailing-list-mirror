Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6E6C47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 17:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72FA0610C7
	for <git@archiver.kernel.org>; Thu, 27 May 2021 17:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbhE0RsL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 13:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhE0RsL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 13:48:11 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08677C061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 10:46:36 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso961018otu.10
        for <git@vger.kernel.org>; Thu, 27 May 2021 10:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=sDo+f4XOIM7zvMpYHWphzbewOlwwW67Z4bOw8Hl2lmA=;
        b=qwZRn3HK7KTWhfqAqTFPP+3wt38DUJOQ3K1qLvP0fqgY3tlsF9N2whgiNC+juPE24W
         tvmmYEBQfVTjLAUw00BL4ZMpyXpP6PUWHsGKzWpALJtQoPa+nbWE+oovcRjirJ7JiRs9
         +Ec/AS/z9gfL/Q9dVmoWSo60T/bqWbw4a3i0Mr4Tq7Ax7+zTBU1JNqZJYHlhDdO+xBDN
         OqGViEmqq4OLQ/XIFkcBFFRgqH8JbCNBPicsIXL9vg9hyX0tO6bvQMIZRdPrKplis2gK
         TfGRfxU5TxUlLxWOCkjSGOBB762XqLB9i5rDw9RwEHuYUTXrgew2layzomWzOxSIAjXV
         IpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=sDo+f4XOIM7zvMpYHWphzbewOlwwW67Z4bOw8Hl2lmA=;
        b=BsCehBxahVWhGy2hUY4UBujbOpg5axOyeMyTCrCDpSWSUr/02xjJY4qT8kvMK3QCfG
         cXof/EoSqNAOebhEK2VxcvUHLOJS1HNV8atoeOudFVLrYh+fLKV2367FU88xSPodJay7
         26QdmOhxuahkkIuvnC/hWMmVVu8KV4cDnN4eR/QzRRMqINu3joNLj+Kr0f57mTjoHo6Z
         7Tjo3/QfraIiG7+J/sLeMuU0OSwQDJ5vvyQOqTaMgBn5OFb330jccY+aD+744vwFw7M8
         FoTeQ447k3ZtWrM6E2cz9OTENk6TCly0nXCrpKJ0oU4leB3T/N7IbKcwKjKTiFwYWOwd
         YKCw==
X-Gm-Message-State: AOAM5338mWZNz0m3/jvkNFHyjElGSk2D0yYdqLTajYvcg6PbHv3YQgyj
        kxVLo9Wwnj1XPqI2iiVkKjk=
X-Google-Smtp-Source: ABdhPJz9B1iXlKfizgvypUtqduIJYF6IRVSqkFByWGhjDZh9zBA3e3OIlTxK8tVCe2laMmnPLQcSTg==
X-Received: by 2002:a05:6830:1042:: with SMTP id b2mr3747110otp.120.1622137595436;
        Thu, 27 May 2021 10:46:35 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id l128sm604813oif.16.2021.05.27.10.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 10:46:34 -0700 (PDT)
Date:   Thu, 27 May 2021 12:46:23 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Message-ID: <60afdaef95fa9_2653020894@natae.notmuch>
In-Reply-To: <87lf80l1m6.fsf@evledraar.gmail.com>
References: <20210311021037.3001235-1-emilyshaffer@google.com>
 <20210527000856.695702-1-emilyshaffer@google.com>
 <87lf80l1m6.fsf@evledraar.gmail.com>
Subject: Re: [PATCH v9 00/37] propose config-based hooks
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> If it were instead:
> =

>  1. Add "git hook run", only supports "old/legacy" .git/hooks/ hooks
>  2. Go through N existing hook callers and migrate them to "git hook ru=
n"

Yes please. It would make the series much easier to review, and also to
understand what the point of it is.

-- =

Felipe Contreras=
