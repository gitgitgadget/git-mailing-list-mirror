Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89EEC433F5
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 02:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbiBRCti (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 21:49:38 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbiBRCth (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 21:49:37 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAD23FDAE
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 18:49:22 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id k13-20020a65434d000000b00342d8eb46b4so3960015pgq.23
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 18:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=hxBzXoExqempkiHIEZ5FGjftmMKXhwL2kyUkRdaSw8E=;
        b=er9KxPUCVWTASPfZVvYr6lqoWfZK0JeWbFlxJ44/pjxfS1T4O3p1BL+CyM/JXgAQZw
         Ejb+R1894WBjzcmcQM1YXSEr0WQtphaTtujVij80jAyQ8Xtk8P2i/2HboGdQL4P9lz+Y
         S/+pBB2iJ1DqbcqohiaerMy6S16DVBIG066Bp2QA+vtnQalZYqXEAlfs2igJeinNj5YB
         FmLRKY2ynYV7yEUAXUseuVUxUJHXh8koDO1csWxEive+KmGiypMYwaIFsQdXEK1Fmlp2
         VbKElfOMa2wGFN0smreXS9FGKy4HhuAMg/SfIYla1DjE+/U8famrsE1yfOYWetzpOXS1
         CP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=hxBzXoExqempkiHIEZ5FGjftmMKXhwL2kyUkRdaSw8E=;
        b=dOl1pArJEEtvKAQyrS/REl6tsP8RhZec4SBL7bLazwvb3lc9MSjdN1R2nJElt1lpC7
         Kj4TKXdF6sW7x5MHU5p7o92oAdsofJBYjirW2FwOGv+Ekr0eVqndWQ6RqW8oV6BfUkIf
         ekHXchLXc8ptM56cTRO8oDt6XqeE0v4HtQ+pdGYrtVXq7yIMRcyLLqHcC7XEOLg4uS1F
         /OsEn3LS0GpdAeXGZQQrSgFla/BajGByzxMFnHTmJ12heg1bkUdLMLwCYokOrW7He0J5
         KN8eiz3bIIHh9LtwrOC8bwwpvyYIjGaRvpiSVmiWYEscJn8yrR41GhYX0cOHKYdXu1yA
         DxiA==
X-Gm-Message-State: AOAM532EPxnXvxzjxXXhcm6zX0JtNsE84FsXlCty0gP/NYZROcADYZO2
        M0lf7v6UwdQLMXsesC+Y0LC3+MOtMMt8+g==
X-Google-Smtp-Source: ABdhPJwo3lMcjDVdXspsdwORBmtb5NlT7QnC5Ffqwa8cC4DQT+chEDJB6/c8dzeXz/7YAFCA9u5RTgk4XV9xgA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:aa7:85c2:0:b0:4cb:b95a:887f with SMTP id
 z2-20020aa785c2000000b004cbb95a887fmr5701298pfn.74.1645152561429; Thu, 17 Feb
 2022 18:49:21 -0800 (PST)
Date:   Fri, 18 Feb 2022 10:49:18 +0800
In-Reply-To: <xmqqley93rkw.fsf@gitster.g>
Message-Id: <kl6lv8xc51ox.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <xmqqley93rkw.fsf@gitster.g>
Subject: gc/recursive-fetch-with-unused-submodules (was Re: What's cooking in
 git.git (Feb 2022, #05; Thu, 17))
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> * gc/recursive-fetch-with-unused-submodules (2022-02-10) 8 commits
>  - submodule: fix bug and remove add_submodule_odb()
>  - fetch: fetch unpopulated, changed submodules
>  - submodule: extract get_fetch_task()
>  - t5526: use grep to assert on fetches
>  - t5526: introduce test helper to assert on fetches
>  - submodule: make static functions read submodules from commits
>  - submodule: store new submodule commits oid_array in a struct
>  - submodule: inline submodule_commits() into caller
>
>  When "git fetch --recurse-submodules" grabbed submodule commits
>  that would be needed to recursively check out newly fetched commits
>  in the superproject, it only paid attention to submodules that are
>  in the current checkout of the superproject.  We now do so for all
>  submodules that have been run "git submodule init" on.
>
>  Will merge to 'next'?
>  source: <20220210044152.78352-1-chooglen@google.com>

I'm working on another version that should hopefully address some
reviewer feedback on v2. I'd prefer to hold off until that version is
reviewed :)
