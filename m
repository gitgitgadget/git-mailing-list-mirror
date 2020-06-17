Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E71C433DF
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 08:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6B3720679
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 08:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8j6R+kU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgFQIHt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 04:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgFQIHr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 04:07:47 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A2EC061573
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 01:07:46 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 10so725519pfx.8
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 01:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=TgiBY4QiIPCjh1kd2oGVKQS+/L6gkgeVS87iD15q4A4=;
        b=B8j6R+kUsaR9VCnmFC+ng4gh48P1SyQMqOLEumJhcwQ6+9mOtJbBAd4lg5LYPoFDtn
         RFWZEZmyuR7b+KAaMsqM/HgpQAwGdPNRwUriyjMQ01GNcjX+NNItfNOatjDTWBPfN73d
         AGSM9pzdni+u6Rjd/DlqjxLo7mGWTC3Zot2VaRzIr6Nm+MrdLIByhE3utSf6yVIGjhKD
         eumwwDW3OLoWFcEr3Wu9YLlQjIst2HSBrIJz0iwCOw8gmz6uUSNvfhG4zkoLeKN8qL94
         6IckB/DOuOwOFCRUp59JRbRHbNy2pFHQsWKUYEyzkJiz+g1KUAXf2pVpm2TBqWThs4yd
         /YWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=TgiBY4QiIPCjh1kd2oGVKQS+/L6gkgeVS87iD15q4A4=;
        b=nKVAXZ/cfek7my84GG6GmB3fWyaCZTGKnidttiTD0LGiBk7O7Y4h+g4O4VoNEiqooi
         ho0Uw/TyJrJBYS/Q5n6OINxbyclqkXL/U+RsAOXmvfzVa2SjmIGShtDR63G9GzC0G4/P
         RqyiKOmrMB306EPHrAR3qCSvUNTtu0hn1Quz7064VGBfgWG8Pgq1sNnkuaWWOZUVMla+
         ml5CVPkCJuNUuJ0T6gfIgPkR7kavSt5pxJONFkClyRNzuEVIJxMRsuKOTd/3tx2+ylKV
         5QVJG5bloCai6+sORcWG9LGtEDalNZBjn/yvCekXscmzlslZx70R9OeULfS9owkfffte
         o6Sg==
X-Gm-Message-State: AOAM530dByGLIuyipRq0Rwebwf1R1n4XT7KwNbK0GZnGUKjFm3frkyyO
        5IrL1XXn3z7cJoKBKVtU9W93sJm37Y4=
X-Google-Smtp-Source: ABdhPJwUERhyrGplr5IVwoWQE0Pz0COHmV5OC05iRo00g+V3csEA3j1/MsW//UFW1u5VnBGGleeG7w==
X-Received: by 2002:aa7:8813:: with SMTP id c19mr6020393pfo.220.1592381266165;
        Wed, 17 Jun 2020 01:07:46 -0700 (PDT)
Received: from konoha ([103.37.201.177])
        by smtp.gmail.com with ESMTPSA id q22sm19705577pfg.192.2020.06.17.01.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 01:07:44 -0700 (PDT)
Date:   Wed, 17 Jun 2020 13:37:40 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2020, #02; Wed, 10)
Message-ID: <20200617080740.GA11006@konoha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7dweebnl.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Junio!

> * ss/submodule-set-branch-in-c (2020-06-02) 1 commit
>  - submodule: port subcommand 'set-branch' from shell to C

> Rewrite of parts of the scripted "git submodule" Porcelain command
> continues; this time it is "git submodule set-branch" subcommand's
> turn.

> Almost there.
> cf. <1b851e49-3bb1-3b59-7f24-b903c5514391@gmail.com>

I think we are done with the porting of 'set_branch'
https://lore.kernel.org/git/20200602163523.7131-1-shouryashukla.oo@gmail.com/

Could you move it to 'next' please?

Thanks,
Shourya Shukla
