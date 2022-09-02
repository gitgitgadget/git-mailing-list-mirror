Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88732C38145
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 16:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236678AbiIBQ6I (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 12:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236822AbiIBQ5z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 12:57:55 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CF9F7B14
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 09:57:47 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id p8-20020a17090ad30800b001fdfc8c7567so7977184pju.1
        for <git@vger.kernel.org>; Fri, 02 Sep 2022 09:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=4YsopBmsZ4V6agtw5KA697nQW+EqWFGGK8N/IjYCWF8=;
        b=n4pJzhjDpL0CkluhPirP/7LkviGaNIzw6PaKzYBD8mbY3MqvYW/6oAy1OZjvwQJCd5
         80+zUV2BXuxiPGet1od5lBQiHth4DnSCizpk1t8OztfcOJaxW5LZtaTSGD/u3wCZ4PcM
         Syiu4Y+gNgkvD6WEH42/FzgfwGMrj3IE/LrfZWYyyCMiMzNCLFVKaJ9Wb2HhJsHQpbsz
         /7A9vPo9SuGgd/VkSp1K9LmfA77Ibom4lP3dOQaTi0t3+DLlnrWFBgQedrdpweDaid4C
         PfiiKnnGiqmZ+OuIZkk68jnrOijoznv7IrtAGUCGeTwJQFo7nNXz0PUEn8LNH21yDAiI
         t4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=4YsopBmsZ4V6agtw5KA697nQW+EqWFGGK8N/IjYCWF8=;
        b=QLGtD8WEw477GDJPlOfWA5RGqtbx6wqjmn5FdDrAzsLu2M7Dm5P9XplSkaLINYk6l0
         eSqGONjP9+XqtyEnt8S108oSMANBu+HtEEoG+BRdMPTiWLXKSwVeyNI3Se/Vn/DTO/AG
         Ve+fvD/mfi0g+eSDRWFHax0SzS32E2+/B/ajWduYskSKe9L9jXzgjAZ2AzES7uk3S2Zy
         G7PduA8/FYp3mmtuGUskf0KJuiLrlQ6ZgTdK52GCoVFRjVyFiBOG/HXs14l50zm9Cs8X
         prNLojTXNb7fhOSXVKIk82jPG5VixNDevE0S+MtTRvHhM8IwrSZXgE/2QxuDEjYYG7AE
         uuEw==
X-Gm-Message-State: ACgBeo0if7pTb5C50E9aEnUwHozapAwuKOJegmvTc7m6JagxGF5RmTe6
        wqXk9BxPNPpb8sj7AeYBUTg=
X-Google-Smtp-Source: AA6agR5vZiHp3L1xp8OprLoo8Xvfg3IIMdn8u5vs+SgYqS2AKC+xRLPlOz65a5123v09+idPFwbLtA==
X-Received: by 2002:a17:90b:1a91:b0:1ff:f703:ccad with SMTP id ng17-20020a17090b1a9100b001fff703ccadmr4327896pjb.154.1662137866013;
        Fri, 02 Sep 2022 09:57:46 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b0016d231e366fsm1878221plb.59.2022.09.02.09.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 09:57:45 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, shaoxuan.yuan02@gmail.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH] unpack-trees: fix sparse directory recursion check
References: <pull.1344.git.1662066153644.gitgitgadget@gmail.com>
        <8dea9ffe-d03b-f838-6cc5-db0de5024d9f@github.com>
Date:   Fri, 02 Sep 2022 09:57:44 -0700
In-Reply-To: <8dea9ffe-d03b-f838-6cc5-db0de5024d9f@github.com> (Derrick
        Stolee's message of "Fri, 2 Sep 2022 09:32:01 -0400")
Message-ID: <xmqqr10t90jb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> Could it also happen if we are going from a commit without that
> sparse directory and then to a commit with that sparse directory? I
> think that would be a more common case, but I was unable to
> manipulate the test repo in t1092 to trigger this bug in the existing
> test cases.
>
> This makes me think that this bug _is_ extremely rare, so we don't
> need to rush this into a 2.37.4 or anything. It would be good to
> bring it into 2.38.0-rc0, though.

When the "test" part of the patch is applied directly on top of the
vd/sparse-reset-checkout-fixes topic without its "fix" part, the
newly added test fails, and with the "fix" part applied, everything
goes peachy.  I think applying it on top of the topic as a fix to it
would be the most sensible.  Any motivated distro packager can grab
the topic and merge to their long-term maintenance track that way
more easily.

Thanks all.
