Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F264CC433E0
	for <git@archiver.kernel.org>; Fri, 15 May 2020 21:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3CE12073E
	for <git@archiver.kernel.org>; Fri, 15 May 2020 21:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSeUYLwv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgEOVCu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 17:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgEOVCu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 17:02:50 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B03C061A0C
        for <git@vger.kernel.org>; Fri, 15 May 2020 14:02:50 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id f189so4102786qkd.5
        for <git@vger.kernel.org>; Fri, 15 May 2020 14:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/3NflI7OutC5NSwgk/HuwVMHSv/4uqiPhjg7sUcg4nY=;
        b=dSeUYLwvgxefTGCwqibjqYBaIpvm+u2yAQ5PEQOg84WebQRQxMCklZcsgqCw0yn30V
         1JH9Jot8NHAzvJUFWT73vpuQE+7P3AFzzUWMGgGy9lwkzRj9U1qDXtX3xBJwVV96hSvV
         LUXrr77w76Y8XojOIqG1vUKSeJokrueUHAxQlB0SQ3AF/X/J6i2Js/rAOeX+zCJdXsz9
         OEQHVQZgsLQZHwD23ulzp+XWnb9rbqisXLjbOpcFQYda8QAcF6edheBkqUwnFI7cTYe8
         wHlLTB5fuSKJwVzLvDTgx4tGr0MCOEgEnfmXKnAA1PW5/ntkxMDY9bmmCd7KwdjRk4WA
         ndDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/3NflI7OutC5NSwgk/HuwVMHSv/4uqiPhjg7sUcg4nY=;
        b=nNhW8qrLv2SQNqyKp4n44tsylrf/gr7yKofNhmIcdvQ6OIUoCYLPRQmQEd11MiNv+y
         K9C+fXdTctJXrmMsvGbkl9EdbCph6c7zS4elU0RTqdIbohIyN32zmxb/Vn3ie83/RSqU
         LoL1mz++noS8vB6KlfKAV+va+sw3QBpNPMus0BikDIewK+6Z0Zx4e303woitjImZFooF
         Bes7qewGTwK2pc3BnvPyhyWF2165UxhDf8iwgYxmKub4z91GYq4dsYTvjRuJNkoN/Qj2
         LvDIMBNp6043blxV3SCieI88GkGFJxwl0iTtnkpUlVKKxQncfsT90s9X4azuuDLl2da7
         44Rw==
X-Gm-Message-State: AOAM533KrY8KC5wVwUTOBWpzGU44+77yis/WGuia2ZVKkSyPHrZTrokP
        FiwyYJ9d9xdS7vZIWO300Zk4as6q
X-Google-Smtp-Source: ABdhPJxBhEU5cnuFdz6+qlgOstDR+IVPGHyh0EynASX8xsV+n2e/myqOcTY6xmrNLAK7ynNIeS8ISw==
X-Received: by 2002:a05:620a:6b7:: with SMTP id i23mr5306842qkh.156.1589576569296;
        Fri, 15 May 2020 14:02:49 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id m21sm2415223qkh.50.2020.05.15.14.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 14:02:48 -0700 (PDT)
Date:   Fri, 15 May 2020 17:02:45 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Force Charlie <charlieio@outlook.com>
Subject: Re: [PATCH 6/6] remote-curl: ensure last packet is a flush
Message-ID: <20200515210245.GA3278654@generichostname>
References: <cover.1589393036.git.liu.denton@gmail.com>
 <7a689da2bb820f70d9e668d656b088af2297d456.1589393036.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a689da2bb820f70d9e668d656b088af2297d456.1589393036.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 13, 2020 at 02:04:58PM -0400, Denton Liu wrote:
> This is not a complete solution to the problem, however. It is possible
> that a flush packet could be sent in the middle of a message and the
> connection could die immediately after. Then, remote-curl would not
> error out and fetch-pack would still be in the middle of a transaction
> and they would enter deadlock. A complete solution would involve
> reframing the stateless-connect protocol, possibly by introducing
> another control packet ("0002"?) as a stateless request separator
> packet which is always sent at the end of post_rpc().
> 
> Although this is not a complete solution, it is better than nothing and
> it resolves the reported issue for now.

I managed to get the implementation of the control packet working. As a
result, I will be dropping this patch in the next reroll and replacing
it with the more complete solution. For anyone reviewing, feel free to
skip this patch.
