Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD0EC4332B
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 22:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE3020724
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 22:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edFADMMA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgCTWXe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 18:23:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35893 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgCTWXe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 18:23:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id g62so8067687wme.1
        for <git@vger.kernel.org>; Fri, 20 Mar 2020 15:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PYDo3qD3nBNywOeRgLINg8qhUp/pXUSTB9aMPBULqgo=;
        b=edFADMMAZ+OAu+ammsjI824ZRsIVZIwTZD7YTqwQYq3/5D/LJI4nYUPOXLW/YB1BU2
         Jrn98HEfGmKyWrEUXJH7bDqi2RpuQdt+lNNx6JgaLdnnBPIU4EWGuV4w/Zl7Cca8rY8t
         sgjyQrpjJYI95CDktAIT5KulQ6xv/uKc1BymbzjjP0rfctJ0bZ06uim/iHj0o7eXKOSO
         LssEBnoSEIVB2mkVv7uMo9ES4CTo/c3bndnIP/0J1ilRP6LzdLr8dc8LYun1fh4+dki3
         clU0Rak6A8dPzIgFyPHqvSoBP6iJ6lSpVl822ayWMLGVG3zJMua9ojZcBik9u9rY+sbG
         w12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PYDo3qD3nBNywOeRgLINg8qhUp/pXUSTB9aMPBULqgo=;
        b=KlsH/AvCEdYa4qYBOv23HdSjxJK5ULu1ZmXFaoMlIrMic+6pHLI1+S9joV38eVBP2h
         4LTmvzvfx0YI7wXyQAvybCxd+cKMPoKxuvU9OO9FK3u/rb9IQu83JpdPdxMOz/4hZucG
         IYOTGKygVcrNeJRwxNIebN9p7nSAk9jJfTnCMRy5/U5++nNH2FlgXNMAx+Ly0SVCJT/t
         UV1/ODVPVhSQiezbNpvOPpwwHhQNvtH3q6cNTgZiCSC2tm5qQEj4yl0I9Wt5V7qB0F6p
         XrWfJWxaJaK0d2Ibmf5/rQEychsL0FCna30c64EHn0vLz8euttzwquIP/khtOhKAWaZa
         sycA==
X-Gm-Message-State: ANhLgQ2dyusnXREJ2aS7JQ4HvBZxkTihsNv3HernL4JaMVy4G/hiwb+J
        6Yd2C/K4KteHVySRK/RedkU=
X-Google-Smtp-Source: ADFU+vsSwwxE2rAMv2c7W7m/nXtfLcYMp8okqR8oi8ojBjy8oQZrvmjrfzknBHzyWJxkIMN4RxGsjA==
X-Received: by 2002:a7b:cb42:: with SMTP id v2mr13048175wmj.170.1584743011547;
        Fri, 20 Mar 2020 15:23:31 -0700 (PDT)
Received: from doriath (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id a16sm9430273wmm.20.2020.03.20.15.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 15:23:30 -0700 (PDT)
Date:   Fri, 20 Mar 2020 23:23:28 +0100
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] doc: --recurse-submodules only apply to active
 submodules
Message-ID: <20200320222328.lynvrgqc35pvxxnl@doriath>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Fri, 20 Mar 2020 23:19:39 +0100
References: <20200228103558.1684937-1-damien.olivier.robert+git@gmail.com>
 <20200303170740.1879432-1-damien.olivier.robert+git@gmail.com>
 <20200303170740.1879432-6-damien.olivier.robert+git@gmail.com>
 <EA460350-CF54-4B91-B1F0-6C4692A14B88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <EA460350-CF54-4B91-B1F0-6C4692A14B88@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From Philippe Blain, Thu 05 Mar 2020 at 23:17:54 (-0500) :
> In the commit title: s/apply/applies

Oups, missed this one.

> Initialized, active and populated, as far as I understand, are three different concepts.
[...]

> From what I understand of the code, git-fetch really recurses into *populated* submodules,
> and does not consult the submodule.active or submodule.<name>.active config settings.
> If you look at builtin/fetch.c::cmd_fetch, and the functions it calls, but is_submodule_active is not in the call chain.
> I tested that setting submodule.<name>.active to false and calling 
> 
>     git fetch --recurse-submodules=yes
> 
> still fetches in the submodule(s). So this should stay as "populated".

Thanks for the thorough review! I had tested that `git-pull` was only
updating the worktree of active submodules, but missed that it was still
fetching non active submodules.

In light of this I think this is even more important to mention which
command affects which submodules in the doc.

> That's only partly correct: I tested setting submodule.<name>.active to false and doing
> 
>     git pull --recurse-submodules
> 
> This does fetches the submodule but does not update its working tree, due to the call to 
> is_submodule_active in prepare_to_clone_next_submodule in builtin/submodule--helper.c

I still left 'active submodule' here in order to not render the formulation
too heavy. Since it is implicit that `pull` goes through fetch, I hope it
is clear that the fetching still involves all populated submodules.

-- 
Damien Robert
http://www.normalesup.org/~robert/pro
