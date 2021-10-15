Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE24C433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 09:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1C44610E8
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 09:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237323AbhJOJ1S (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 05:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237320AbhJOJ1S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 05:27:18 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B472C061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 02:25:12 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id x4so6029069pln.5
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 02:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=tA5LNhKzCFQDcVprt2IW8PD/XPFRSA28PBQDze7bPkc=;
        b=aySmLeqpbjdlusjnWO466/yFLAcFPIuHQ0Bf8gSQazmqZtqw20kpfx7jvwBoufqjaU
         sP4lBNhIWHs0PjnMCHudzjou5LmUeUrflEMKBT3NfHG7LMjugqQXun1LSSWJmTeQJs/M
         Nmx0iD5YuIA4sheloj0CsJ5CXzdfgGtFwXHJVr4YH+bd84NP/cSc3iLz2t2uMaSkgti7
         P0vNrRLYN0yYWCIxGp7RUJrC2AomKL6i+4Qy23I5lY4q8xqwlPIUHcOJJvIIB9Ud2TbU
         Gol5Njy44tv6fdS18AarctTgsKb5zSQjla2ac7k+DWdzpv4CU9w8QNAEUJSgtpNPBeXS
         1EPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=tA5LNhKzCFQDcVprt2IW8PD/XPFRSA28PBQDze7bPkc=;
        b=4RZX/kL19xLrwdAW6fdaqYN2oHHJ/Nkbbq0UEReQQ28pGQcDidGkid/Y1rD9M+crLr
         I+ihvlohps85DC0qXqH4eoXoy0hvOEMwPIfnsqKDU6Dc01+w005NBuSSHmu8DZyco871
         r/fC+mpv68HCLlkWJxjjFGrpaPI258C8cT9Pe74M4xtWUrCrL7g+JpChzBnyDGYNy/x5
         8izAyoKrHWb7MV9L9x+B5ZVRcJJ4aZeey0Iy4VuAwecX3gStqQXKY0wMrP2EU5MgDmy0
         1+YaQbAfVGzIrPba7aVF/oAC/ZM4g/r45g4NM+qHpAhsZ/OWAEKi0ZE5z5PJYVxEWRM6
         hD1A==
X-Gm-Message-State: AOAM5316P7nfepB6Mpm7a3/Pdlk8NpYyi5wJbOoierOC1OXCOim+0AD/
        8bhVLID71vbPrCh1h5SNUSxvv2zgJtc=
X-Google-Smtp-Source: ABdhPJyQMGPKxmAuvQ2qB3G82YF5OHtIDJEjaSBvy7u9vULMU+bvhSPXy2Yd8eb13P/ZXSfrQzhLaQ==
X-Received: by 2002:a17:90a:190:: with SMTP id 16mr12549982pjc.152.1634289911289;
        Fri, 15 Oct 2021 02:25:11 -0700 (PDT)
Received: from atharva-on-air ([119.82.121.105])
        by smtp.gmail.com with ESMTPSA id v13sm4285314pgt.7.2021.10.15.02.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 02:25:10 -0700 (PDT)
References: <20210907115932.36068-1-raykar.ath@gmail.com>
 <kl6la6jb1dk3.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: mu4e 1.6.3; emacs 27.2
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 00/13] submodule: convert the rest of 'update' to C
Date:   Fri, 15 Oct 2021 14:43:20 +0530
In-reply-to: <kl6la6jb1dk3.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <m2o87q8wt2.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Glen Choo <chooglen@google.com> writes:

>> This series builds upon the previous conversion work on 'submodule update' and
>> moves out all of that shell logic in 'git-submodule.sh' into
>> 'builtin/submodule--helper.c'.
>
> Hey Atharva! I'm working on a series that will teach "git branch" how to
> handle "--recurse-submodules". I plan to do this in-process because I
> think this will take less overall effort than using child processes, and
> to make it happen, I'm planning to add a helper function like
> "for_each_submodule()", which would call a C callback function on each
> submodule.
>
> This is conceptually similar to "git submodule foreach" and
> for_each_listed_submodule() (though not exactly equivalent), so I'm
> reaching out to you in case this work is already on your radar. If so,
> and if it is coming soon, it might be easier to for me to base my work
> off yours instead of duplicating our efforts :)

Thanks for reaching out. I don't have anything like this on my radar, so
feel free to go ahead with your plan :)
