Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5929BC433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 07:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237181AbhLJHRx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 02:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbhLJHRw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 02:17:52 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F6BC061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 23:14:17 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id y12so26371071eda.12
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 23:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=sWvPH3+8X3J1uWSvCpkdeuVt/quQcacy+h6zvcSRoTE=;
        b=S90Erys6CNkPmq2PyqO1aI2Z7YbfkUaR0wCjdxTEo2+r89D8mKQeTfHmc0s6YDF6Nh
         bJBVVNsmtUNalGVr3zdxFobR2532xPpfAeN9Sgc6MnZXFjyoRD92jezrP/KJWD0/fLGt
         doBiuB+hgEv/UjhKpxNINvZ0XQblOvRJTBFZ/o0rA5V8PTvf8G0UTKHv7jf1/7GQ+Dti
         bcmsHMLK6XbAXszoI90Mi3XAJ/8NwoT3pExm3kgD6RcpELTpNPx4WA4Y2SK2xWTpng8y
         7pzu0rA9LpkzVtyVlxweChQ3roQta2jw90mvb9sLoF/xZy4sw5mvCXIhd6SuuLRJNJS4
         fxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=sWvPH3+8X3J1uWSvCpkdeuVt/quQcacy+h6zvcSRoTE=;
        b=pPw/Mnq/o2hz1jTzgZg9QEz8S7mMN+UdRpYvDwe06FUDkPO6HWzOwWlMDO9+Cf4fy8
         fiSiTCa7lMXXt1in9kFR9zUUSyQa5qc1YaL/nF7GGdJfH2iQtk5SNHGQPJMiC34Wgl2E
         fkrkYGExyXC23ECFCyDN/NFLf/ZoTkOhAP7r0GJjBbNoihkkTjYoVAdYhOI/qIzhju3S
         8lLSTwpTVpNYjP9SmTkV7MpvrKHPsts/DPJ6u7I7DSE2X06pftIMCcdHs7EIWCHpVH7D
         jK1HTdXnVPoRBtJfmFikiy7SPGq5c+YSag6y/mpMr2+q36/pylvXt/tUO6S8uHiZpoGS
         iFQQ==
X-Gm-Message-State: AOAM530DGIdfhw2Gxa3KHPdYOX7Q1gR5PcNd5hNxhdZXqrXuJYxIyR1e
        os0YJXUIWl/FbO75JzRsrVDguwENNq16+Q==
X-Google-Smtp-Source: ABdhPJxZknQs40WsEnSlkFlSAelmbRlCh6XYOvk5+A0CJ4WivcIkc0ftKhotpsaXC8i0+kERfIIeuQ==
X-Received: by 2002:a17:907:7805:: with SMTP id la5mr21670446ejc.188.1639120455912;
        Thu, 09 Dec 2021 23:14:15 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m16sm937720edd.61.2021.12.09.23.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 23:14:15 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mva6g-000CLj-1L;
        Fri, 10 Dec 2021 08:14:14 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?Tmd1eeG7hW4g?= =?utf-8?B?VGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 1/2] checkout: handling branch_info memory leak
Date:   Fri, 10 Dec 2021 08:13:23 +0100
References: <pull.1095.git.1639117329.gitgitgadget@gmail.com>
 <e9f6be692db40978b835e7298c1a1c664566ec84.1639117329.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <e9f6be692db40978b835e7298c1a1c664566ec84.1639117329.git.gitgitgadget@gmail.com>
Message-ID: <211210.865yrxdj95.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 10 2021, ZheNing Hu via GitGitGadget wrote:

> From: ZheNing Hu <adlternative@gmail.com>
>
> On the checkout code path, we dynamically allocate
> memory for `refname` and `path` in `struct branch_info`,
> but did not free their memory at the end. So introduce
> branch_info_clear() which can free branch_info memory.

This (partially) duplicates my 9081a421a6d (checkout: fix "branch info"
memory leaks, 2021-11-16) which is in "next" already.
