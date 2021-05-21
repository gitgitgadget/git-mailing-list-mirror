Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E729C4707A
	for <git@archiver.kernel.org>; Fri, 21 May 2021 18:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DDC261244
	for <git@archiver.kernel.org>; Fri, 21 May 2021 18:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbhEUSzQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 14:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbhEUSzP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 14:55:15 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E931C061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 11:53:52 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id i8-20020a4aa1080000b0290201edd785e7so4794363ool.1
        for <git@vger.kernel.org>; Fri, 21 May 2021 11:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=S1RwHFd87F+jyiwpZOyLHElyrHMZUX3nSPRC8wfPqPw=;
        b=nXMwt0I6cBKVk8OuLUvcpVl5mMudJQ2bNa+snoYiWggOFP435cbNFExdzBC8MPlKf5
         U2VUVnPPvHbTf7gwCey02aMFHbPgVNRXWzQwaEQdWQsdOxTrPB8Cj2KDX3C+C1lW+Lka
         r+Nh/b2slaRL/BSI/sx0j+niCxC4wHQvlpIRMErAa7lNOV5U6NE6ffShc3uaAIACe3mR
         X22Xyk0rqCMtGfS2ZCKvDonKhdiPsypyMJFVNoSZiFDbQwOpN5N1iCO6nhDYyN1hOZIm
         moEvWIFmDrojr/HZ5x5qpKnvRZUokraodVDo0sc64t5pG++t2/2XoKwXjuXjGz8b0lPT
         V+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=S1RwHFd87F+jyiwpZOyLHElyrHMZUX3nSPRC8wfPqPw=;
        b=IGx7Xg9eeDkHmbAWpH65Ih0eXIDeuuoKsIZk+7WAFunJzikRs2LdP1+WHPvgXPmoW3
         3AuWPUnA5xkqyXHYMueWURmTnKbX74T/RIOhJPD0b29s17yrenfDf+Dihsg/F6rrDWX2
         tsehAOHOaW/ic78b9u1arxp77pXiPGIcH0NQ7ZoaAmFPLJdWxF0183vkMpGXON4gbzWo
         5Og+GBpqgRexAs55qliaUwrD8eyLm6e/5irjgpsDCFNEccW4U71raihk6K5nwqUCdJ1e
         MQ8RMKrN1/n9oaaDs3eGIwMjzXRYxUdFNHYzzpxsE8Tsi5+abyr4tuxvxnSDL3sQcpvQ
         w2iA==
X-Gm-Message-State: AOAM532lYXfNYQk6iGdEVZ+7SqXlGTJLG60zxTv5NSO8+bazrNua0F1U
        sSpUaet0qXI9Com5kgNezfNRuWs3iGxtFg==
X-Google-Smtp-Source: ABdhPJxmiDM+IiUMICYcjzgAAp3KM0i9mpZfYKlvPv/irvbs5/Gc8EKStCdIJv5crIhwTbhCZTqeVA==
X-Received: by 2002:a4a:abc8:: with SMTP id o8mr9373622oon.77.1621623231785;
        Fri, 21 May 2021 11:53:51 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id t22sm1516724otd.25.2021.05.21.11.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 11:53:51 -0700 (PDT)
Date:   Fri, 21 May 2021 13:53:49 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Message-ID: <60a801bdd1b4b_5580620828@natae.notmuch>
In-Reply-To: <68c60aff0c77c562aba5613ccbb9ab33ad8e0e08.1621451532.git.ps@pks.im>
References: <cover.1621451532.git.ps@pks.im>
 <68c60aff0c77c562aba5613ccbb9ab33ad8e0e08.1621451532.git.ps@pks.im>
Subject: RE: [PATCH 7/8] receive-pack: skip connectivity checks on delete-only
 commands
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt wrote:
> In the case where git-receive-pack(1) receives only commands which
> delete references, then per technical specification the client MUST NOT
> send a packfile. As a result, we know that no new objects have been
> received, which makes it a moot point to check whether all received
> objects are fully connected.

I don't know if this is related but yesterday I decided to delete a
bunch of refs from a forked repo in GitHub. I did it naively with a for
loop and so it was doing a bunch of `git push myrepo :ref`.

It was unbearably slow.

Sure, it was a stupid thing to do, but maybe it can help you do some
tests.

Cheers.

-- 
Felipe Contreras
