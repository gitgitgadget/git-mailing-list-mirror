Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE153C74A5B
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 22:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjC2WE4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 18:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjC2WEw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 18:04:52 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1359ED3
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 15:04:52 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id m16so936419ybk.0
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 15:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1680127491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C/rFaUxzU9TFhRLbg5kjaVQGU00b4QfbTtyv6AiSaA8=;
        b=5py+cHndGOtNLXRWfoFZvojXPBXUOLgyUS5vxttf3mhjm89mQscAPXHj/lQliC+6a8
         NlftXwrjpIVxzA1Jdke1HUXfM8jk4qSs0MCAq5Hp68s9AmoRlSCflF2EfF/9XWlAM83I
         xIjRuh0SlPKASZ8ReAv9gzuFWdkkwD56+awRcmpAewZrSIUUw0so2YyW7Llktn60BQ2z
         sLM46wyRV4y11ZNMK/iwfZUMjBrcOxeAfNtzMzDQXYt1t7Mqk9JPlRY0HruLB34EoThP
         jr1RUuNgpuZMbTMNO1jXRQW5Q1cIjJAnY+sQR4utWs9wm6lnGBKIVU5ZYqv2WHyzT96K
         g6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680127491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/rFaUxzU9TFhRLbg5kjaVQGU00b4QfbTtyv6AiSaA8=;
        b=2VqQ9QHU3bm02lg92l4fuK7t8fn8ZUMbypxJc1ZBZnQLtW74T6InR2QHOhIg1gXD6Z
         uu54ls7M0YG4wiYnV0YdXI9AcBYEgBt6MzVw4Q70dQoddVwueFqiyUTi42zuHSrKPMgv
         rtw3sU9rse5jaLAJO1OTHTepiXzcmsBaBJNFsyiTyLh566VKhZ4h2HoI7BxFJTVKdEBD
         nkK7JYKZtkgGN3/xGunW8Hq/JQ16LWo8rvMe631ndONpiVag1MuApPGSOyuwIe71Xar2
         SECqa4dPbbkbkEJbYwSmGSyGeDYiI+2k3zAP5Nh0xxyQPeDm2T4+bysQnVrQsnEXcSWJ
         eZEw==
X-Gm-Message-State: AAQBX9dPnA39qT/HJWDNnkelSwAMaQO+yBtCPk9ZPDp3kAqU4MGPn9Ze
        /TxJ5hkWeUswJaOQD9inXF836w==
X-Google-Smtp-Source: AKy350bVspFEycz+n+GNHXCVQbvGBml7MXtx7uQF0isId6EybwSTkuYTJYcrx0DU/mdzOT9U8FxLmg==
X-Received: by 2002:a25:200b:0:b0:b72:947f:6d2f with SMTP id g11-20020a25200b000000b00b72947f6d2fmr16858063ybg.64.1680127491111;
        Wed, 29 Mar 2023 15:04:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u12-20020a25ab0c000000b00b7767ca746csm3738773ybi.9.2023.03.29.15.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 15:04:50 -0700 (PDT)
Date:   Wed, 29 Mar 2023 18:04:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 00/17] cocci: remove "the_repository" wrapper macros
Message-ID: <ZCS2ATJLvffFk8uL@nand.local>
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
 <cover-v2-00.17-00000000000-20230328T110946Z-avarab@gmail.com>
 <xmqq355n9y9m.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq355n9y9m.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 29, 2023 at 12:02:29PM -0700, Junio C Hamano wrote:
> Are people happy with the result?  I think the previous round was
> both read carefully on the central piece of the series, with some
> spot checks to mechanical parts, and with the above clarification
> the series is ready to be merged down to 'next'.

I didn't review v1, so take this email with a grain of salt, but I am
happy with the current round and would be happy to see it go to 'next'.

Thanks,
Taylor
