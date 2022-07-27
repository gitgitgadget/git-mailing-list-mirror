Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4920FC04A68
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 09:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiG0JU3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 05:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbiG0JUW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 05:20:22 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D353C5F7B
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 02:20:20 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id v17so1056515edc.1
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 02:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=mtGK+Kn9cBuEGRkWIkbH0OYe2narf3Q/bQTj2X+7JHo=;
        b=CwfVNt7r2N2J/uJh+Mx0xKqL/ri9GyJjBLAFClpUN6WcQhoCYgFTsTAtjiHnotZsNS
         LPHS29/4EGQLIn9x338klLaYJHlpuybwwiK4ZCVqfvmnlGXR9XxKrt+b86SNJN3g+6GB
         p4/xW+ZOjTC0PP1goi7tQpZgAT5vP3RWbcC6bAPRIM6crKitYx9wBZOgXlcnCUNZmfsJ
         2xPhXSOahybv5bmoDDfb6PKcJuaqCgZ9IWTRImBYXE+WoiiaYNU21ycc24k0E9+/ayRP
         KJVIi6TRDVW3ib/kyF4ILIhgPJeXf0yR9OlMMXwHAWwhSLx8snY4/RCFYQm/FAW+yUoN
         OWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=mtGK+Kn9cBuEGRkWIkbH0OYe2narf3Q/bQTj2X+7JHo=;
        b=4zhi9bCANrMpkIQnETBvM5SPb6FHp1ylabzqfzfsbe8T+oLrSscCyoTeROlUT722dN
         AEQrUOHLZh1ql4xMRLsuN38wW8ZNYEgaf09FEZqGPoiNtNmhk6qKXEJoGRY/+YlJvc53
         DAEGRODFzTjCLSHgSK/JOGKEeSQKUmPlo154p6+rgq7WGBbpxly2jOIKZVisW2ulmy+a
         CZfVf1orDR6J6T9DIxjtT0ITeDi32vh0hG4A3abzx2kEN8hs8F52+ea4lZxrNVZgBPr3
         0hdi4bxekfyd+a7WDuOhIJRqd4M7e3EDek1HLWWa/+8ZM/8rhPdo8JV5Ogl7sGFCa8Z6
         r48w==
X-Gm-Message-State: AJIora8TnPt0lOOPjGnm3ma3trewqhh2bpxlpOjXRyCTVHMDiEW+SSmC
        EGrlo5XmPkRgiK1dPNjd/eTiyhkdN+H6DA==
X-Google-Smtp-Source: AGRyM1tg/7xSVx82C/EIsoh+ohKZjgyZEEdX7Wg//dmh95xoriif8X84/fp2FH68IQ4PLWAUquVGOQ==
X-Received: by 2002:a05:6402:5516:b0:43a:42f9:24d6 with SMTP id fi22-20020a056402551600b0043a42f924d6mr10439013edb.204.1658913618046;
        Wed, 27 Jul 2022 02:20:18 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id gr19-20020a170906e2d300b0072b592ee073sm7484690ejb.147.2022.07.27.02.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 02:20:17 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oGdDE-006bMV-PC;
        Wed, 27 Jul 2022 11:20:16 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: Question: What's the best way to implement directory permission
 control in git?
Date:   Wed, 27 Jul 2022 11:17:44 +0200
References: <CAOLTT8QusNzdO1mHqQFPz84pznYSpFWJunroRGXQ7qk6sJjeYg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CAOLTT8QusNzdO1mHqQFPz84pznYSpFWJunroRGXQ7qk6sJjeYg@mail.gmail.com>
Message-ID: <220727.86mtculxnz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 27 2022, ZheNing Hu wrote:

> if there is a monorepo such as
> git@github.com:derrickstolee/sparse-checkout-example.git
>
> There are many files and directories:
>
> client/
>     android/
>     electron/
>     iOS/
> service/
>     common/
>     identity/
>     list/
>     photos/
> web/
>     browser/
>     editor/
>     friends/
> boostrap.sh
> LICENSE.md
> README.md
>
> Now we can use partial-clone + sparse-checkout to reduce
> the network overhead, and reduce disk storage space size, that's good.
>
> But I also need a ACL to control what directory or file people can fetch/push.
> e.g. I don't want a client fetch the code in "service" or "web".
>
> Now if the user client use "git log -p" or "git sparse-checkout add service"...
> or other git command, git which will  download them by
> "git fetch --filter=blob:none --stdin <oid>" automatically.
>
> This means that the git client and server interact with git objects
> (and don't care about path) we cannot simply ban someone download
> a "path" on the server side.
>
> What should I do? You may recommend me to use submodule,
> but due to its complexity, I don't really want to use it :-(

There isn't a way to do this in git.

It's theoretically possible, i.e. a client could be told that the SHA-1
of a directory is XYZ, and construct a commit object with a reference to
it.

But currently a *lot* of things in the client code assume that these
things will be available in one way or another.

The state-of-the-art in the "sparse" code may differ from the above, I
don't know.

Also note that there's a well-known edge case in the git protocol where
it's really incompatible with the notion of "secret" data, i.e. even if
you hide a ref you'll be able to "guess" it by seeing what delta(s) the
server will produce or accept etc.
