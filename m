Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B829FC7619A
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 21:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjDLVQb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 17:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjDLVQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 17:16:29 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763F26E96
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 14:16:28 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id g3so14257016pja.2
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 14:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681334188; x=1683926188;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=0OGFtlbeVdhJgg5cpCl7ZZGXmILv83eL0vYf4jWQzs8=;
        b=rvQmmT1nGU4AS0f5o/SinJ2lY4Z6p1wtfzV2u2RI00GqGCmrPttENH92J82KlcyITO
         rq1iRjJGUi1u8YvJIWfoXressxxt5vgvw29HM4F1Nnvdodj//jOhCO4WRINVkgY3VrWL
         AsowaDEp/294Gan1mvNKXyAqz9eAzouK8D+v1PTJt4LAT26L+dGIHQFDgmYgEm7PYPmO
         B1+l45U3lV12Jmcv3ZDlZrSUCCW1BN9RWxBsLij6WOjoBjwA7wCvHR+AeGl9q20HNAcC
         Mvx5SiaWhXCEkrXWBYsTuv37M3dXzda+dxGezslOFI3/MA1+RRT7iHZNyrLTEt/doM2v
         OUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681334188; x=1683926188;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0OGFtlbeVdhJgg5cpCl7ZZGXmILv83eL0vYf4jWQzs8=;
        b=UKqn73eiiTZYk1/eiRda62dL8xHa41ynM1NvAFhaFEkz/5UpONo8npWJQZXfcCkeje
         tDJkirtDhU7T29DC9dzUul52G33ndJ9ujkhhgnOjscCQmODwnwLhNt+MYrb4cfcU/mXS
         65KpJtu8YsejDSwuq+58EDnFIEbmrDsg9Hr34WneCvNW9hzJzAq8F1OIaJuAmQx7IWol
         mzco1TG61xkMWa5M+uODaptqbyxHKX1/c0TiyRzTbjsY69GS+jNUkI98QPrMYfl/iIr1
         mMRNmhXnoV3vYC4saTqXlfJar/0qZwqaDEakaM4wjFwp4k0hET4wl8EtK72zk2m21vpq
         sSFg==
X-Gm-Message-State: AAQBX9cyvBR3WsXAgZZN5RlWpZYZJqYKrY8LhABgdc9nDex7jaVxfIAQ
        NWEOR7LbsQDlBgRdVxzCkBY=
X-Google-Smtp-Source: AKy350ap0EggyYiPzHtTM16SjFdteGrgOwh0bpTIVKshaQR7mwROE0lw2dbM9KedPmk0me0nJuZJNw==
X-Received: by 2002:a05:6a20:4e23:b0:d5:1863:fe5f with SMTP id gk35-20020a056a204e2300b000d51863fe5fmr4290100pzb.2.1681334187835;
        Wed, 12 Apr 2023 14:16:27 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id x25-20020a056a00271900b00636caef0714sm7145022pfv.144.2023.04.12.14.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 14:16:27 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     git@vger.kernel.org, adlternative@gmail.com,
        christian.couder@gmail.com
Subject: Re: [PATCH v3 2/4] doc: interpret-trailers: use input redirection
References: <cover.1680548208.git.code@khaugsbakk.name>
        <cover.1681326818.git.code@khaugsbakk.name>
        <12f7b10462184cbac884859e91d7b45e021041ee.1681326818.git.code@khaugsbakk.name>
Date:   Wed, 12 Apr 2023 14:16:27 -0700
Message-ID: <xmqqjzyg7qdw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kristoffer Haugsbakk <code@khaugsbakk.name> writes:

> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---

Perhaps explain why it is a good idea in the body of the message?

    Instead of "cat"ting a single file into a pipe, redirect from
    the file to the standard input of the command on the downstream
    side of the pipe.  This is more straight-forward, saves one
    extra process, and often makes the line shorter.

or something like that.
