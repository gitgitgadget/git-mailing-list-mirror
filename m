Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F772C433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 23:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 060952068E
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 23:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u0BAHZQi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgFOXPu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 19:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgFOXPt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 19:15:49 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285A7C08C5C2
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 16:15:49 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id l17so17492696qki.9
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 16:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=8r16dI0iGv9FcRaSmEGLp9LaW8FQ+9v7GLDCKH6mpR4=;
        b=u0BAHZQi8h/wo0lz6ThwKsdtNlfaVBiyFb9zWmucxzofrI3EIHbK8lYBchsBv0dnyb
         lKLVI2qUhdr+gemyrMRJM4CokPw0HhJUW3Nt77eYrCMsbCv+CYiY048yxWpuhGe9A4JS
         A9HD86NKGVBWmt8iGPdn0SfoMlwu2tvanykCVYb7H4bSInDk876bTm+wAC2h2vBckq3I
         L6fYiSU5Alt8VMKYV/G7V0mc3+7pC49JvnZFMwwPd4ndLqydLc/w7wqjbIQAkCF14vsI
         f9HpeSDJ+9OFOFukVkukUdANzAsDc8QSPColF0Q7iDZ8YI9yTC28VX26Rt97WvHkwdh2
         PqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8r16dI0iGv9FcRaSmEGLp9LaW8FQ+9v7GLDCKH6mpR4=;
        b=ilNIkj6r8kvXwy2PBNsS7hsFZJ/xB1vBetVjf9v8APOAXzpLEbfiluwHcMi5ca0kdN
         NDP1lwhLEjF9l8sgmdGdAJkRkVIrYhUM4b6MjXL4qBlMnbhHtoU9JEKGmB5AbhbesPXS
         oWEMDxPW/SHkBi3jASZpWcvhXUAB2v0CtRrpPK2urmenJzOgJyFwDlN15k3OCwPqqwKn
         tgCRM7zEmhGuB5WXplpuFIa8+u20pZb4EGMudR2Q3hBeknvDtDsdUkVF69W5/fkqH41P
         4CGMzBz0EI5YMXMVNJZiCtxpl3yHZJBttbyOPibLsFX1qZf/+n+C+3k2IeaWVZs3GdcS
         kuyw==
X-Gm-Message-State: AOAM532lqfWLEsKXdxSFKzC4UjkKWi+9at/N6zbss6ksBXKFInILqa1W
        2S2Nx3QHAXYlXrxjKowtrg+ldxzCVbM=
X-Google-Smtp-Source: ABdhPJwUTh2N7My6Cfytg/Rh4+U5QO8s2pZM9UeieCkutuSGCt+fWM9ljv21ZPsRbfo8303RR9cuFA==
X-Received: by 2002:a37:45cc:: with SMTP id s195mr16822703qka.433.1592262947929;
        Mon, 15 Jun 2020 16:15:47 -0700 (PDT)
Received: from [10.0.10.179] ([170.79.184.212])
        by smtp.gmail.com with ESMTPSA id k2sm12351223qkh.42.2020.06.15.16.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 16:15:47 -0700 (PDT)
To:     simon@bocoup.com
Cc:     git@vger.kernel.org
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
From:   =?UTF-8?Q?S=c3=a9rgio_Augusto_Vianna?= <sergio.a.vianna@gmail.com>
Message-ID: <126c85da-cca5-a0e7-39bb-982fe63ffbdb@gmail.com>
Date:   Mon, 15 Jun 2020 20:15:45 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By the way, I just found out about this issue:

https://github.com/git-for-windows/git/issues/2674

76 upvotes against 490 downvotes and that's because it was shut down. If 
that's anything to go by, this proposal is WILDLY unpopular. Unless 
anyone has any other metric, going through with it seems that will 
disregard what the actual users want by a great, great margin and be 
just what I said earlier: an authoritarian display of power.

