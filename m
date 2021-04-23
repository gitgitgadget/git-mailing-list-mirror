Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7234EC433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 20:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57018613C1
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 20:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243988AbhDWUlV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 16:41:21 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:33566 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243932AbhDWUlU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 16:41:20 -0400
Received: by mail-ed1-f41.google.com with SMTP id cq11so15187808edb.0
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 13:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aTqObfOhrLbWTFX0Q1ScrfypeNrvfCTFlLn7tMaomf8=;
        b=ParMkcs5SbhI2KCx+P+rLRQ22LWnjeIuQxUi9loDpSubOlNscQWyrTcYyRMLD8FZ/H
         hm3NxOWI+9I6ehG5VpjYqStzF3L8rhY9q2xddjC7I2YwGYBVkRY8u4lSlPdtRHfuBmvh
         oMzCaLicX/UPoGzAbhH10VkuTZys6eWuojCeCRJARGZsIkubpC3lZKK0OONRO1k9Mxhw
         Y7SCaSv4AdpS8Oh2TrrRwiq6lyjbOW/Nm+HNnTmOLg/dKsASmCS/RULD3w1H7iBwyPC4
         /IMEERHF3mwn+Q/3nGGvqqX43M8ziO06IMGgj58N0vQLYmDeXwFbAYiTAu3lJxI8vRTZ
         pIEw==
X-Gm-Message-State: AOAM532jT5w4lertVy2bjj3rqSoixwOIRzPdz+psR/soWbBqREvkoUsN
        Q0TximA760N+BH7qo7eC/zsP27sxyonhdvm0kTI=
X-Google-Smtp-Source: ABdhPJyaxAYnVdosb27ykguEm1gnVBg5BDdnSgFyWIljOvn3uNidT9w0zVMLgLqNjGb7oEpkBR2mVHI8qqvwydgQVJ4=
X-Received: by 2002:a05:6402:488:: with SMTP id k8mr6548448edv.233.1619210442669;
 Fri, 23 Apr 2021 13:40:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210423194230.1388945-1-lukeshu@lukeshu.com> <20210423194230.1388945-19-lukeshu@lukeshu.com>
In-Reply-To: <20210423194230.1388945-19-lukeshu@lukeshu.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 23 Apr 2021 16:40:31 -0400
Message-ID: <CAPig+cTb-h=Qb9asvh+MVH2s5uj7szP_QOPpcm1bqdE6DK9V7g@mail.gmail.com>
Subject: Re: [PATCH 18/30] subtree: use $* instead of $@ as appropriate
To:     Luke Shumaker <lukeshu@lukeshu.com>
Cc:     Git List <git@vger.kernel.org>,
        Avery Pennarun <apenwarr@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Danny Lin <danny0838@gmail.com>,
        "David A . Greene" <greened@obbligato.org>,
        David Aguilar <davvid@gmail.com>,
        Jakub Suder <jakub.suder@gmail.com>,
        James Denholm <nod.helm@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Roger L Strain <roger.strain@swri.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        Luke Shumaker <lukeshu@datawire.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 23, 2021 at 3:43 PM Luke Shumaker <lukeshu@lukeshu.com> wrote:
> $* is for when you want to smash things together, whitespace-separated;
> $@ is for when you want them to be separate strings.  There are a couple
> of places in subtree that erroneously use $@ when smashing args together
> in to an error message.

Can we be explicit and say "$@" in the commit message rather than bare
$@ since the unquoted form is not magical and acts exactly like $*.

Also: s/in to/into/

Nit: I have some trouble following what the commit message is actually
trying to say with "smash things" and "separate strings". It might be
simpler to say merely that use of "$@" in these particular instances
is overkill and possibly misleading to readers not familiar with the
finer details of $* vs. "$@".

The patch itself makes sense.
