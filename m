Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77657C77B75
	for <git@archiver.kernel.org>; Mon,  8 May 2023 22:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbjEHWTv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 18:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234258AbjEHWTt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 18:19:49 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E731B4EE4
        for <git@vger.kernel.org>; Mon,  8 May 2023 15:19:48 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-643fdfb437aso11900189b3a.0
        for <git@vger.kernel.org>; Mon, 08 May 2023 15:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683584388; x=1686176388;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IAdDb4h6EdL/6T/t5tOXRfOzt7IhhYKgyAlchCvTlnA=;
        b=Dw1TeygWX4gXvULiU4trlIgnAb40AnsLdPKUpQN6jo9XvxdTPsBmy64ekK+sfejw+H
         S1tN29cfIFie7gc4q4mPEjp79XXLpvx9m4wlilkP89WLhjbDSQ6mJ0Ay4Qo4tpaFn1en
         bF5mBD33Sx6ljzaHNkvdKuKzwTKDIsXeEqEpBTYjDbaEDpkm1muJjSav+1JxQ3LJFhob
         +g3aLNjTmjxJ1Rcl9uoKQrjvucNht/vlZJh5CWpn9O4X6Y8pehzvsigJvZYXyvG9A/GP
         1Ey60aO4W2UsXwO/yHG15SprCI8AKgIC7I8UEQaDOGzkSwOX8uAWa0HRJJXa3PF9eo5w
         C5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683584388; x=1686176388;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IAdDb4h6EdL/6T/t5tOXRfOzt7IhhYKgyAlchCvTlnA=;
        b=I7WUvTqPXnW8JfFYSRVMh8ZGvX7R+t6WIqm0ds5BdlVXb9EPfv7UaaPh82RUDmXNQ4
         WQ7lulscx/8H9TDfAhfFKh0x64UiDcYmIRE2NsMjV1C8lsl3NGJcc983cg8Fl9PmRb9l
         I1oCbCmsywE3OPEmcXJUqGOQNCar/GYBoK5mK5+HAhxaxAHL82ywIlH4LczorzTBOjsW
         sj/WMzuho2n99AUhPk6+7dj6I4aAwQx0WNJFPN9UnHV0X3lZnhffVCC67F9WYujs4sjl
         v9bvEqYsZm1iujAzaqfEMsPiBEAetC/9gbRpyVWrY9BB3J1p2iQu5NGWgK5YZkxjZgo/
         t+Pw==
X-Gm-Message-State: AC+VfDz+pxNBfnlIQl+nE60SR0vIiyaLVSoSPc/kU/YVlEbiCIFPtke4
        CzZvTx7vx7uH/bKMU62MEvmieqJ3aP0NUg==
X-Google-Smtp-Source: ACHHUZ5WnNvMri8PfgXSdEWePEvXkXZ1GZ16+ZISBqIj4tbTnL3wwr+24mHL8hX4zX1tj35NDO6h5ozcQ5VXtQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:2d4:b0:643:50d9:d90c with SMTP
 id b20-20020a056a0002d400b0064350d9d90cmr3197990pft.2.1683584388451; Mon, 08
 May 2023 15:19:48 -0700 (PDT)
Date:   Mon, 08 May 2023 15:19:40 -0700
In-Reply-To: <ZE/03oSVAmSFLh7c@google.com>
Mime-Version: 1.0
References: <cb72bca46c6ff2a8cf3196408fb53411f7f91892.1682631601.git.steadmon@google.com>
 <xmqqttx1gcmr.fsf@gitster.g> <ZEv8AcxQW7B2H8uJ@google.com>
 <xmqq354jda8g.fsf@gitster.g> <ZE/03oSVAmSFLh7c@google.com>
Message-ID: <kl6lo7mu1n5v.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH] setup: trace bare repository setups
From:   Glen Choo <chooglen@google.com>
To:     Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> Ah, sorry for misunderstanding. I've restored the test along with a
> test_unconfig line for V3; however, doesn't this just turn into a "change
> detector" test whose only purpose will be to fail if/when we change the
> default value for this config option? 

Maybe a difference in opinion: "change detection" sounds like
non-essential changes to program behavior can cause a test to fail, but
default value handling seems quite essential to me. Not to mention that
default value handling is easy to break, so IMO guarding against
accidental regressions is pretty useful.

As for practical churn, I don't expect that we'll intentionally change
this default often.
