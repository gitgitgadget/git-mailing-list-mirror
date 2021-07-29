Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF265C4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 19:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C92C60F12
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 19:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbhG2TJd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 15:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbhG2TJd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 15:09:33 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E828C061765
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 12:09:29 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id e21so8116541pla.5
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 12:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=AMe9/eMKd2B6NtOCLge642WR8bYD/3Dai4DUSMVVsGo=;
        b=vfP016uzhF7xViK1I3TmjeZ6bePXtMvwryepgrUi3Xv6y8ZH68BD51wMGD0McTuxHE
         r5jncJ5sTPxwLUlVaSc2ri28NmBiAfleGv2hAeQoxC+YfPfHcBsHnwfCYIjSjWTO7L9h
         /272o9pD73C5LZSINC4TYkej89KV6jti/OncEuAxz//++AirCE6qyh01Fv8Qa757iaZl
         NJZ7amULfMBPaFC/WbVr3QNGd1LSsm13ojWslaDgTiqRiOpxm1LngXdSHV8EJzVQV9G0
         ur2Y/4sED444NJ5tHGlfH/9ZDJ/NYkwptDIvs5RAfDQSLUwROSxsVA0lDQMoeiu7ADrz
         +KBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=AMe9/eMKd2B6NtOCLge642WR8bYD/3Dai4DUSMVVsGo=;
        b=RT+Z9jadP5HFeqlgzXw6FruBXAGbZFhdG5MmLvJcs3IZRA74Q5ejkwMDeeivXMcD5i
         m8GsH7xZohJww+X3oaeEcZ6xnkj2H9DML7rVaD7jzqhB9jzLVFi6yUTqBROYzr17K7Qv
         jVvBmPWX7MHtx2J6N4wflc4CVOV6q3e6o5LDXCsIT7M/lk5mY6gQDIiD3bFg+LYDrSbE
         4HsdELLEZMCMQ0EjGyu30D9QT+aCzIe0fw6FzBEu5uDJDBVmYqI8PVP1CgpMlLTLpxHy
         P4fdC2pog9TaILwVl0869NYWr9F0NJyIueVSIIDU0v5xS/d3oEQIaYnhn7W2WpbwWuZv
         UP1w==
X-Gm-Message-State: AOAM531hOTngOW1iPcwfT6Okktcy/UOHbNiI8XqyqTwJjB3Be0jqbf2g
        F1NA2w/1t+q3ww9kvH4SjjVVjg==
X-Google-Smtp-Source: ABdhPJytCvmtgFNYCqq5GR6b0FHTahGwjnMfaCSZbXob+5HmmXggXAarqZk7Xv3karxZd2TppXZ7AA==
X-Received: by 2002:a62:d404:0:b029:3a1:8a54:728 with SMTP id a4-20020a62d4040000b02903a18a540728mr6420992pfh.37.1627585768997;
        Thu, 29 Jul 2021 12:09:28 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:12b4:7532:e087:f8ab])
        by smtp.gmail.com with ESMTPSA id g12sm4284561pfv.167.2021.07.29.12.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 12:09:28 -0700 (PDT)
Date:   Thu, 29 Jul 2021 12:09:21 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitgitgadget@gmail.com,
        git@vger.kernel.org, hanwen@google.com,
        sandals@crustytoothpaste.net, rsbecker@nexbridge.com,
        bagasdotme@gmail.com, hji@dyntopia.com, avarab@gmail.com,
        felipe.contreras@gmail.com, sunshine@sunshineco.com,
        gwymor@tilde.club
Subject: Re: [PATCH v6 3/9] ssh signing: retrieve a default key from ssh-agent
Message-ID: <YQL84R7qNv8pnHro@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Jonathan Tan <jonathantanmy@google.com>, gitgitgadget@gmail.com,
        git@vger.kernel.org, hanwen@google.com,
        sandals@crustytoothpaste.net, rsbecker@nexbridge.com,
        bagasdotme@gmail.com, hji@dyntopia.com, avarab@gmail.com,
        felipe.contreras@gmail.com, sunshine@sunshineco.com,
        gwymor@tilde.club
References: <071e6173d8e418349d94fea97624e8cee9f1dde5.1627501009.git.gitgitgadget@gmail.com>
 <20210728224832.2717826-1-jonathantanmy@google.com>
 <f3e72ec9-3ed4-9955-a7bd-042fa6eb016c@gigacodes.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3e72ec9-3ed4-9955-a7bd-042fa6eb016c@gigacodes.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.07.29 10:59, Fabian Stelzer wrote:
> On 29.07.21 00:48, Jonathan Tan wrote:
> > > if user.signingkey is not set and a ssh signature is requested we call
> > > ssh-add -L and use the first key we get
> > 
> > [snip]
> > 
> > Could the commit message have a better explanation of why we need this?
> > (Also, I would think that the command being run needs to be configurable
> > instead of being just the first "ssh-add" in $PATH, and the parsing of
> > the output should be more rigorous. But this is moot if we don't need
> > this feature in the first place.)
> > 
> 
> How about:
> If user.signingkey ist not set and a ssh signature is requested we call
> ssh-add -L und use the first key we get. This enables us to activate commit
> signing globally for all users on a shared server when ssh-agent forwarding
> is already in use without the need to touch an individual users gitconfig.
> 
> Maybe a general gpg.ssh.signingKeyDefaultCommand that we call and use the
> first returned line as key would be useful and achieve the same goal without
> having this default for everyone.
> On the other hand i like having less configuration / good defaults for
> individual users. But I'm coming from a corporate environment, not an open
> source project.

Doesn't this run the risk of using the wrong key (and potentially
exposing someone's identity)? On my work machine, my corporate SSH key
is not actually the first key in my SSH agent.

Rather than making this behavior the default, could it instead be
enabled only if the signing key is set to "use-ssh-agent" or something
similar?
