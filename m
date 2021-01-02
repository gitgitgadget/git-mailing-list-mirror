Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBCBC433DB
	for <git@archiver.kernel.org>; Sat,  2 Jan 2021 19:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77AC0207AA
	for <git@archiver.kernel.org>; Sat,  2 Jan 2021 19:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbhABTMu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Jan 2021 14:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbhABTMs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jan 2021 14:12:48 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FC0C061573
        for <git@vger.kernel.org>; Sat,  2 Jan 2021 11:12:08 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id q205so27425747oig.13
        for <git@vger.kernel.org>; Sat, 02 Jan 2021 11:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=gQ42t399/O3sQ7M7+IgpK4jVEsA+ZFEI5Dz+aK9mo8c=;
        b=cErE5mwC6jMy+4CVgNO1CaYSikhFr8d6ciOJtpnJVJjrxUNTha8/bMidrNjEsjNXFu
         HNVC2+guD3d/DiHlzaqN23NaAKY33WzqAjh8gPfFWjfNXzCZPrSTgHq++9yCKT+GS7Q0
         xIA4/xUMTJnGxQGpDi3d6gbghhYOLAI+JnMlOg469E1K0/gHFQJH+gcj0YmbVWZaOIxB
         R15eSsolsZkJBP3EsQuczKV9lXXDJ1ktY+naxjx+/PY9gSkFRWpk4LhNEHImdl/A+j7E
         4WjbMz0EzKUEZ3QDtecAW5Z1oIEXw/EJWTavgHJQUTt0s0r3DrhQ0JDoJcmhUBbYLv6S
         Bfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=gQ42t399/O3sQ7M7+IgpK4jVEsA+ZFEI5Dz+aK9mo8c=;
        b=DFcKBgJEHSrZ7rtJOoXisWBRjEIs6k+hifM2R7eDKTmo36tFkdLuMwbPwzjqMEM6Mw
         4CrbAXxJTnKSTlmuD6ngY2BHndSQn6j5pMxfs4bUEiuvk3A1/M0v/hIgeM6WDOJcTWMy
         TCwGgssnp2yHGbGOTuIyRvgbscm/bWtnqxVWMd27dq3tYFvF3/DyzLOHVJqv5/EX/atm
         /pfXAaobgC51hx3g80kJ9m0goo1fEZMRIs2Q7pqovvHllUJYJ49CZp8KBdQigpNnzTPr
         m8AIjq/m/nqYS5EQt+0jOtgMvEWcB55n5axiwOzO9dVg1M7Z0rDtzRRTYIUhZos+QVHc
         LMng==
X-Gm-Message-State: AOAM531Icqx4mUft2Ae8XrWMyBr6PBaO0BfbXjfnVI5/SsKo2jRe+Kwf
        TJdpo3k1685juOQiLYz+p/Y=
X-Google-Smtp-Source: ABdhPJxBm6t4wjqIT+gWoAcPCnJZYFun1ADkhaR7OEo7ujv+tD9AimpbewgoeySo6nEge8m0jXm8xQ==
X-Received: by 2002:aca:5792:: with SMTP id l140mr13866339oib.175.1609614726213;
        Sat, 02 Jan 2021 11:12:06 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id h26sm13471063ots.9.2021.01.02.11.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jan 2021 11:12:05 -0800 (PST)
Date:   Sat, 02 Jan 2021 13:12:04 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Yaroslav Nikitenko <metst13@gmail.com>, git@vger.kernel.org
Message-ID: <5ff0c58422038_90dc208ea@natae.notmuch>
In-Reply-To: <CA+RLzGCtp2T=8DG74geBs67X5vUvhwRP4FMZ6MJv+E+Pj=YbWw@mail.gmail.com>
References: <CA+RLzGCtp2T=8DG74geBs67X5vUvhwRP4FMZ6MJv+E+Pj=YbWw@mail.gmail.com>
Subject: RE: git-dir requires work-tree; documentation improvements for
 working directory
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yaroslav Nikitenko wrote:
> I use git to manage my dotfiles with this command:
> 
>     git --git-dir=/home/yaroslav/.cfg/ --work-tree=/home/yaroslav

I do precisely the same thing.

> When reading documentation, I noticed two issues.
> 
> 1) The command doesn't work without --work-tree (even from the top
> level directory, which is my home directory).
> 
>     [~]$ git --git-dir=/home/yaroslav/.cfg/ status
>     fatal: this operation must be run in a work tree

That's weird. It works fine here (although I don't see why I would want
that).

If you remove all your configuration does it still fail?

> 2) In the man documentation for git > git-dir it's written
> "It can be an absolute path or relative path to current working directory."
> I think this can be confused with work-tree. I suggest removing the
> word 'working' (and probably add an article 'the' before the
> 'current', but I'm not a native speaker).

Yes, the article is missing, as for the rest I have no opinion.

> I don't subscribe to the mailing list but hope that I'll receive the replies.

Don't worry. The git mailing list doesn't munge the Reply-To header, so
any decent MUA will keep you in Cc.

Cheers.

-- 
Felipe Contreras
