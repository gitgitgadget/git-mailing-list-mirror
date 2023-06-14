Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD717EB64DA
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 01:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241824AbjFNB7S (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jun 2023 21:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241941AbjFNB7P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2023 21:59:15 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77A7E79
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 18:59:12 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f7e4953107so26205e9.1
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 18:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686707951; x=1689299951;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gb+Ee5GOU16nElW1ush+FcYw4081XhnzfIOKuVUyOiQ=;
        b=w2WBZz2gUI+ZA04buyNciHJpWUg8aMq39n8q1BL4IxCtBLtsufCboXhXgeZVhjUgJ3
         9OY72tTQzt05P0bUaUJy2H1J14NgVYyW3fHGywq2ShZmijTE6BYMGLVKaIZZN/9NWHzm
         Ge1k4V8Wj088eOVL1SQ97N9HUjbPAg2vVdMGWpDpceyjOfGwEV3RIFES6H65y/di0O58
         WXez+lRyZBBlMw7/cg091hfJ8GwuaO74r7cx9u2OBN35b+PJqVJH86EszqcC/9i/6Vqm
         HyH2KbWClSlds+6gzi4aQV38TVime/QoOog2fqMNP5QacHztG2X+h2mdqQd4MoN6C5co
         FJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686707951; x=1689299951;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gb+Ee5GOU16nElW1ush+FcYw4081XhnzfIOKuVUyOiQ=;
        b=PCSsAA2JEADqWk4ZIi0qf3bROZtYqNI1bMChZ+hLDhN7aEz2HOBwcYj8vaat24Yg68
         sLiB1lLl8JwY4h2R66UQ3hS6GqZChpu1dDjxO7gjclp73FyxoXlqjRIIG4NuMbLw9gda
         ijY8AlBFCsFvBx/2uDhdNYj3UvBaKMrMRQzvjvHx/+kDt7nqe+2D+nILAQKRPiR/JVeu
         Q1Iue6cnfjzNND6UpaWmypBmfcZL36sd6rwA8WSDVyVz4CvMeLPLEWnmcym7YTkVLu7H
         N9fLSZDjrAceq2sbnSErLXvh9KJqRKAUKbqI8zqsoo91hpZSsTKxzvZuWCXyHxP/gsbX
         oXNw==
X-Gm-Message-State: AC+VfDzD6Px8xZUYs7VBcYfTB24kY2zohF/j1NIyYrKTjO1gkRTTbmRl
        gDDTQmjGnH21uEv0/LCvyLeD2MTPuiOhuxcxRmtY8Q==
X-Google-Smtp-Source: ACHHUZ6jCsqoysbGTfVTfVFC+yUrER+CSIJ8q5O6I8EBrJLXuhLotW0fwOy7kkxSElvgj/N/1uELxxOf6ZUuUiHgdEE=
X-Received: by 2002:a05:600c:3b9c:b0:3f1:73b8:b5fe with SMTP id
 n28-20020a05600c3b9c00b003f173b8b5femr32686wms.3.1686707950989; Tue, 13 Jun
 2023 18:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230606170711.912972-1-calvinwan@google.com> <20230606171002.914075-5-calvinwan@google.com>
 <25d47081-2096-bb8a-dca3-bd5ea931c879@ramsayjones.plus.com>
 <CAFySSZBZVn=7gBB19_uNxeUwS9Y8Q6ZZiCT=AwfuBy4+d34piw@mail.gmail.com>
 <xmqq8rco9zkl.fsf@gitster.g> <CAFySSZBf51JFAY5fYRsYvk2RkZ8rDmoQOHKrCte4ERkBeoiJWA@mail.gmail.com>
 <xmqqy1kn2c1p.fsf@gitster.g>
In-Reply-To: <xmqqy1kn2c1p.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Tue, 13 Jun 2023 18:58:59 -0700
Message-ID: <CAFySSZArxayE6VF-T1WpkcFpBwauJAE7PB7ionWpBwOURfrKOA@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] common.h: move non-compat specific macros and functions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
        phillip.wood123@gmail.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> "Without having to" is an unfair restrition, given that you do not
> have to create common.h and move things around in the first place
> ;-)

that's a good point...part of this change was motivated by having a
more natural location to move the general ALLOC functions in alloc.h.
Thought I would clean up git-compat-util.h along the way, but I can
throw this patch on the back burner until there's more of a need for
it (maybe just having a separate section in git-compat-util.h for
common functions/macros also works).
