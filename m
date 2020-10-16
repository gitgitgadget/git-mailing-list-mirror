Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAD0C433DF
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 23:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16A6320874
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 23:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIg3yvAa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407447AbgJPXIE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 19:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407396AbgJPXIE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 19:08:04 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5D9C061755
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 16:08:04 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id b23so2297602pgb.3
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 16:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2/9PBQjQ9QljlVKtrL82C6g7dkwkQRlE3kpJYwa5CI8=;
        b=UIg3yvAaUAH2J4TCeebaOnwiiWrOeHp31zABjBQo3WDsy8CPF1+PLqjSgk7/Pgr8yh
         yjXIbPptvG6rycHlHdee0k21VQvemoYXRKM9w2wsJIO0ANJx100/IBWQ75oOaqZ+QKeJ
         j/8mM00FXZ91bq1klHCq41inEo0cjphaKS/R77XHJ2GhNG4grO1Krhn5M0aMrpE3RP1x
         jIPnTOURQgNYraUd7QN4xeEToYFEPHbLnYxfb//VYlorFviFovjA6S+S3rs1MrSljALv
         VTG60Blr0HUgYYHoaOZrTGOhO1iXGQvVDtyNd4FYmOTs52f5o9rkoDb/n8g7Mb0YIApf
         6i/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2/9PBQjQ9QljlVKtrL82C6g7dkwkQRlE3kpJYwa5CI8=;
        b=b90D8+wovE/Q8PJJ9fgl75uln2Ftuq6izO0RdKHqkAX5JR6v+OkXc3ZE2aDXb0Wxtm
         BxQ3BRR7rtHHn8cgCMMHh2MnDLJCQKCbCUPCkO4nCvD3AEIkW18dJMVsJ/vaSQPbwbOd
         s0gBIXDjihbJ6oM8kvHU1jNMgIiet1sdnpTO95bDT/iYBzjmuGXYTf/NSxPpLaScBB72
         RxIvOuJxyoFrkjLg+ke8n5r501g1XHAhqPZZVWR8g8ofnd+9BE4YgASRWJ4Vre6jCGeh
         YdzC9phCFJuyQWcAIQeBpvkB+IhXa58s5TCCF1sY5Kw9tJwBRhG5a5Rn7KMYu08WYS3T
         ijPg==
X-Gm-Message-State: AOAM532L+n//LErv25AYEQ5KsTpBt+vuQBhRBQ9lhup8a/PdYlpggQBM
        fBlQzZxgf79vL0ZaTtAr0CVxfjYPES8=
X-Google-Smtp-Source: ABdhPJxjL7z/YL5J5lvuLKdo5ogoJzApIYCraZ/x53dVHkK+V0xaVT2H6k8WUix8iN3MQOvNNp/UoA==
X-Received: by 2002:a62:77c4:0:b029:155:6332:e1bd with SMTP id s187-20020a6277c40000b02901556332e1bdmr5913750pfc.35.1602889683742;
        Fri, 16 Oct 2020 16:08:03 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id b6sm4100732pjq.42.2020.10.16.16.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 16:08:03 -0700 (PDT)
Date:   Fri, 16 Oct 2020 16:08:01 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Joey S <jgsal@protonmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        wireshark-dev@wireshark.org
Subject: Re: [Outreachy] Introduction
Message-ID: <20201016230801.GA945741@google.com>
References: <HiG3ctHji8hdGWXWEwWgeoa6eDDHkUbhfa0x0xYr9EHWD7FqXqZsQt3fHMZ4Vle0jo2QPCW8rjRviw_aGKqxUIFtvX2igp1aUnx9p6YCL0Y=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HiG3ctHji8hdGWXWEwWgeoa6eDDHkUbhfa0x0xYr9EHWD7FqXqZsQt3fHMZ4Vle0jo2QPCW8rjRviw_aGKqxUIFtvX2igp1aUnx9p6YCL0Y=@protonmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Joey,

Joey S wrote:

> Hi everyone,
>
> I'm Joey Salazar, an Outreachy 2020 applicant certified in CCNA and
> Linux+, with some experience in C for both private and open source
> repositories (BIND at gitlab.isc.org/Joey), community code reviews,
> and automated tests in bash. I'd like to contribute to the "Add Git
> protocol support to Wireshark" project and improve my skills, yet
> remain open to a different project if that'd be preferable.

Welcome!

> I have installed and built git, followed
> git.github.io/General-Microproject-Information and checked the
> sample email thread [1], as well as the tutorial
> git-scm.com/docs/MyFirstContribution and created the psuh command
> files here [2].
>
> After following the git.github.io/Outreachy-21-Microprojects page
> I'd like to work on the 'Use test_path_is_* functions in test
> scripts', and given that Charvi Mendiratta might be working on tests
> t7101,t7102 and t7201 as per this ml thread [3], I'd like to check
> with the group if working on tests t7006 and t7300 would be ok.

I'd recommend just doing a single file.  t7006 is a good one.

> In parallel, I'm following
> gitlab.com/wireshark/wireshark/-/wikis/Development as suggested
> through the #git-devel IRC channel

Yes, building wireshark and making your first modification to it would
be a good next step.

One possible first modification would be to teach
epan/dissectors/packet-git.c about sideband.  See "Packfile Data" in
git's Documentation/technical/pack-protocol.txt for how sideband
works.

Alternatively you can run wireshark and see if anything you see
bothers you and make a first contribution that improves on that. :)

Happy developing.

Thanks,
Jonathan

> [1] public-inbox.org/git/1386590745-4412-1-git-send-email-t.gummerer@gmail.com/T/#u
> [2] github.com/j-sal/git/tree/psuh
> [3] public-inbox.org/git/CAP8UFD1m2zXUm1PXmJKW2MxA9XZVUOkBFA62jLP7jx6_DCYZGw@mail.gmail.com
> [4] git-scm.com/book/en/v2/Git-Internals-Transfer-Protocols
[5] https://www.wireshark.org/lists/wireshark-dev/202010/msg00042.html
