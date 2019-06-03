Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7065D1F462
	for <e@80x24.org>; Mon,  3 Jun 2019 22:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfFCWXl (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 18:23:41 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36583 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfFCWXl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 18:23:41 -0400
Received: by mail-pg1-f194.google.com with SMTP id a3so1679609pgb.3
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 15:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A6VivxIyEfJnqVKbUyttSRmR8ekQAXx/4GuBWCwj6UY=;
        b=mhe3Lntonz91DAg687YRA+QACvEiL2WF5JnQXGP2h9EBX4iaNtz4RwQFP1V9Is9wBm
         zwEXmqi4MzzQgjhRFNsrjXsApvwzk3LB/IgRbXckaX2QJ0Gklbj2FQ6ZTbiU2ekMZcip
         mOF35TlXofsqwyDV812yQG5VRugGYLx3YXkYT10LTVOl1nHbKvgpRoNMUCw4pYwozU2x
         3qfM2zjpea7dOtOXzec4hboW4g27pxpKP+xEAPzMpVK/ydoytIqMxxUXuEYAXucUdcqm
         kWMT856Je6rTPOVF1uaBWO6gZpn1YMOJmc3dpbIQ6iNNuudlfE0j8/36E+FLNJlPCPJD
         9BPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A6VivxIyEfJnqVKbUyttSRmR8ekQAXx/4GuBWCwj6UY=;
        b=mfF4XhjaX9b4zBa+9Zjqdqhbl4TJiUXgJrmqK977Wsq0cnj9cbhmShOaG98KiehzbX
         Yf2COuUn30cBoG8suhFYz0DKncysN+nCKOs3rXM5z+CCY81Onh2jEuDSLxnvwLeOiTGG
         wQ7btp9GAlvtWI272hifG61Ca94J/T3+SHjdSDdAatmhv41PPxi+2gRf4LLsMFeE5VdX
         a2dUGYXdONZqmCXQZb3hbRaOOJploLnUlEV9beFtDnsAu5UDwSegaYBEN0Z8bbX84mIO
         kilMfy+maFQN9fLbisLvz/Dh1uGdOsnfh7eRy0iees3vG0jZWRHl9k4WU0OwsbfmjxFs
         8w5A==
X-Gm-Message-State: APjAAAWUrKJKkT9q0lvCgyT/TDZ2oFoVCX2IgZkh6Q7Rt5trEmOK3vJ5
        GZR0KDvc7YCy01j6YrRatkE=
X-Google-Smtp-Source: APXvYqxcAlgx55Vr01qma55Uopnoj60Ylbtum7a0EWgN/cpL9ZnGD98JiB9QumcJDot2Emw11T8EgQ==
X-Received: by 2002:a62:61c2:: with SMTP id v185mr18759456pfb.0.1559600620160;
        Mon, 03 Jun 2019 15:23:40 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id b128sm9765552pfa.165.2019.06.03.15.23.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 03 Jun 2019 15:23:39 -0700 (PDT)
Date:   Mon, 3 Jun 2019 15:23:37 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] index-pack: prefetch missing REF_DELTA bases
Message-ID: <20190603222337.GA208159@google.com>
References: <cover.1557868134.git.jonathantanmy@google.com>
 <4fcaa4481b5fd2a76aa21263f997e00913db0e0f.1557868134.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fcaa4481b5fd2a76aa21263f997e00913db0e0f.1557868134.git.jonathantanmy@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan wrote:

> When fetching, the client sends "have" commit IDs indicating that the
> server does not need to send any object referenced by those commits,
> reducing network I/O. When the client is a partial clone, the client
> still sends "have"s in this way, even if it does not have every object
> referenced by a commit it sent as "have".
>
> If a server omits such an object, it is fine: the client could lazily
> fetch that object before this fetch, and it can still do so after.
>
> The issue is when the server sends a thin pack containing an object that
> is a REF_DELTA against such a missing object: index-pack fails to fix
> the thin pack. When support for lazily fetching missing objects was
> added in 8b4c0103a9 ("sha1_file: support lazily fetching missing
> objects", 2017-12-08), support in index-pack was turned off in the
> belief that it accesses the repo only to do hash collision checks.
> However, this is not true: it also needs to access the repo to resolve
> REF_DELTA bases.
[...]
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  builtin/index-pack.c     | 26 +++++++++++++++--
>  t/t5616-partial-clone.sh | 61 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 85 insertions(+), 2 deletions(-)

Thanks much.

This bugfix has been working well at $DAYJOB:
Tested-by: Jonathan Nieder <jrnieder@gmail.com>

Is it something that could be in 2.22.0 or 2.22.1?
