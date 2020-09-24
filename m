Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC022C4346E
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 09:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 428D12388A
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 09:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8x36zCm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbgIXJTJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 05:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgIXJTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 05:19:09 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5C3C0613CE
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 02:19:08 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id j2so2623015eds.9
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 02:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A8BamR7+t1tJftwa8wF40acJAQ3HC8DcBe6dK22s/Tc=;
        b=W8x36zCmTTmHBL0c3+rW3C8QssCPAX/p0V69u/3oVBXYKvNKaJyV5xp0zCBxy3W8/Q
         0/0n3C+cENDkWjgZ8T728jjS/w16IwCD+rssnWwxGENKUzHguCY5vJFWnEe7ysRQhRlW
         2lsEavJWSzCPcJfqZMvYc7sJyxAM10G+F4oyH0H1tGYQOxwV9rcctz3nFO21YFiX4fGn
         hqhqumve0Bc3s1dee3QVEr4bw9TQsywSZAjnTwGL5iiNI3a+YWBH8BElI6sMa3WjFnuK
         mgcIcZiPXZnB+ep/XNLetSBVVPic3w7yDyU839riGHwAzOSfO3kEL7da4+hiXJGN77J2
         RgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A8BamR7+t1tJftwa8wF40acJAQ3HC8DcBe6dK22s/Tc=;
        b=sP0rI8fZ8hvl04UShup9bOxjX4qX8tIX7x5dpE9MPURlXcw7t8RG4JA+bugTgVNCi5
         y9YxUqTF7WGKgocquV2ZCnnrKrvTuM2nuH7WH0W5txH01PQVKvhwNviTplY/fSyCjfH6
         5dIS49YR9+tXbZHAVQddU1L4QnS+aSygtmcMIgw+5Imbx8zPXC7+8SVN1CGIB5JqNljr
         pGeMgJEFLXXqUolavpLzNGr1+ExCej/anHG+7Jriqd2YvX4FoMidAeqtRcr4NPH+xka3
         JeUz0m59c8WPxzTSS2jTons8n5QFS/2MniFrnDVhlnpbYQT4W3HYQZA3EvNoFOZXI6pW
         U74w==
X-Gm-Message-State: AOAM531q9s7v/ftn0PPELMieAxJUHt3nUz0iA71/XfiIDj4A6tIYjDid
        gg4pjGxOZLtiXIOT7BwgHT0=
X-Google-Smtp-Source: ABdhPJxJw7L2aFM1/Pl7J30+K9YvL7bZIt2V1uKJCUB9Bich4zkwD77yDPcR90fqkd97RXi26s0m3Q==
X-Received: by 2002:aa7:cf93:: with SMTP id z19mr3605653edx.187.1600939147431;
        Thu, 24 Sep 2020 02:19:07 -0700 (PDT)
Received: from szeder.dev (94-21-58-130.pool.digikabel.hu. [94.21.58.130])
        by smtp.gmail.com with ESMTPSA id o11sm1994589edw.80.2020.09.24.02.19.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Sep 2020 02:19:06 -0700 (PDT)
Date:   Thu, 24 Sep 2020 11:19:01 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] cmake: ignore generated files
Message-ID: <20200924091901.GA24954@szeder.dev>
References: <pull.735.git.1600375065498.gitgitgadget@gmail.com>
 <xmqqtuvwoyz5.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2009181510240.5061@tvgsbejvaqbjf.bet>
 <xmqqft7fnlxr.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2009201914330.5061@tvgsbejvaqbjf.bet>
 <xmqqr1qud9zl.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2009231502430.5061@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2009231502430.5061@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 23, 2020 at 03:08:26PM +0200, Johannes Schindelin wrote:
> In any case, `git clean -dfx` strikes me as a perfectly acceptable
> equivalent of `make clean` when no `make` is available, as is the case in
> Visual Studio's case.

Not at all: 'make (dist)clean' only removes build artifacts and leaves
untracked files intact, while 'git clean -dfx' removes untracked files
as well, so using the latter instead of the former might easily lead to
data loss.

