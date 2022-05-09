Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B24C433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 09:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiEIJtb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 05:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237788AbiEIJSH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 05:18:07 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0899620CA52
        for <git@vger.kernel.org>; Mon,  9 May 2022 02:14:12 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id c1-20020a17090a558100b001dca2694f23so12120884pji.3
        for <git@vger.kernel.org>; Mon, 09 May 2022 02:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QIlonvmBigUhfovEfMW19S2GNedCdOg2cd+DYfzR1OU=;
        b=jm4pzxh3MdMvtvtlAHcPJLlr9m+U1m/c3U/ywZG90JcfgPoN4ZTHKMPvNul5Fk/KE5
         z6i7/DpF3OR0BwSgMnA1iGlFVJlrGCfDmK+SW9rX4TZ3/wMIiYHAvF9PxQJl8oJEvXvq
         N7sgks4KWNoiFuZPOYcYWRdNFL4KjOUEracSqFzI4FwFSaQpwwuYoHhm6hJ3Vuub35dk
         +hGxw6Rd5Op9ejk0Vg8wAhcA2Gks1ex2EFs7SyXnle/WJf8UNM4UpfoKSbcJ3gyQxRWa
         uG+zBCPGUQMVERDEo84vrlM8kvbh/C9fHaurkkwSeQ4K55VAdf7FXxFura0kT+ZtzOmZ
         L6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QIlonvmBigUhfovEfMW19S2GNedCdOg2cd+DYfzR1OU=;
        b=ZSd5rhQL1Ke7Dsy3QnK/W3pjsrT76qCdRmv6nGj7wXxJyUHB7OUUWMYWxgurbv7BMT
         VE0AkpdT6Lw0jUWydFOnZpXGI6bivKYKwIEjCVg5zvR1RaKClBBy8vmD0uALKVNdnwaC
         VddJSLx1+QK+JCVMAdWtX/th4ByfzbWoGjpZinymjyLinvq+CjNtrGQ0IsdOH48keMEt
         ucsZd+wJqzjbGWWVORH1fcmWzFz4sNjRkGwCsM98JLJIlKKCTQv7o4Em3OQcOQfSmrD0
         sdx6SepqqmCb1KvWSl/GWIwPjh9ErHf/mCTgj5IFUciHeniP84m2rShwZdJImD46cr6b
         4Rrw==
X-Gm-Message-State: AOAM533h9QOJwYwwt2WiXHs1pAuXOEQFjS+fUbM512U1m4cTPHI+HZQM
        C/a32Aob2GgTCcApFN6HcGo=
X-Google-Smtp-Source: ABdhPJz2iL+QnWF5Kehb2wgmGFXOtJHgeu3mKKwwWoGmhf5reWA/77qfzW0FjyGGzvhqWgn0fuwS+A==
X-Received: by 2002:a17:90b:4a4a:b0:1dc:4731:31a4 with SMTP id lb10-20020a17090b4a4a00b001dc473131a4mr17309885pjb.19.1652087651592;
        Mon, 09 May 2022 02:14:11 -0700 (PDT)
Received: from localhost.localdomain ([2409:4061:2bc7:fe6a:cca3:78bd:7640:2c62])
        by smtp.gmail.com with ESMTPSA id n10-20020a170903110a00b0015e8d4eb1cesm6595673plh.24.2022.05.09.02.14.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 May 2022 02:14:10 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v3] builtin/remote.c: teach `-v` to list filters for promisor remotes
Date:   Mon,  9 May 2022 14:43:15 +0530
Message-Id: <20220509091315.13234-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <f15e2673-ddc3-27ff-d31c-7fa32af27ae7@gmail.com>
References: <f15e2673-ddc3-27ff-d31c-7fa32af27ae7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> wrote:

> I think the tests woud fit better in t5505-remote.sh, since the patch really
> adds a feature to the 'git remote' command. 

I think you're right. Thanks!

> I found it sligtly awkward to use the future tense here. Maybe just:
>
>     For promisor remotes, also show which filter
>     (`blob:none` etc.) that promisor remote use, wrapped in square brackets.
>
> And technically, it's not really the remote that "uses" the filter, 
> but more the local Git client. So maybe something like this would
> be more accurate and simpler:
>
>     For promisor remotes, also show which filter (`blob:none` etc.)
>     are configured, wrapped in square brackets.
>
> And even then "wrapped in square brackets" *could* be dropped, I 
> think.

Got it. Thanks for the suggestions about both the PR and the patch.
Will update it.

Thanks :)
