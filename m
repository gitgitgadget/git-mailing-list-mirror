Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633DCC7EE25
	for <git@archiver.kernel.org>; Thu, 18 May 2023 17:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjERRb0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 13:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjERRbY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 13:31:24 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DD3E40
        for <git@vger.kernel.org>; Thu, 18 May 2023 10:31:06 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ae74ab3089so3792785ad.0
        for <git@vger.kernel.org>; Thu, 18 May 2023 10:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1684431066; x=1687023066;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kz7yAmMeNF/y5ry1ytDr+rRHNkNGwFZol+AjgVOT8CE=;
        b=IiN5ipC8Q+OElRZx0RWCMw2MAK5QG/RZRRagxp1c8hZdtyjt5mSL9nkH9VaM7vDORQ
         MSv1QPWAErFDZRTLPaT+x5MO1OuD354NzzPeJtnybZDEVe8boYlIoigCtcx1XtqlHo2B
         3utI/WT6ZzHma+WmwkYq+V4hFS0XWXImT5mCRxVUsl/LrGRtnkbkMrsDuOaYHAGZw+oU
         UXaUuhXmsxpEGk28JWL2SEMpzSqNGVsGmDfO+Ii5HMnv6g7wyZkkeWObFFir7lS6kyNs
         2v8Kh8TdY+h/xhXW+Je+qR/OF9TT2M539/RYXhTTWk8IwPske+mY8VOdBXy3uSt8BU+w
         KmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684431066; x=1687023066;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kz7yAmMeNF/y5ry1ytDr+rRHNkNGwFZol+AjgVOT8CE=;
        b=N5B4FoxcJbJcO1ies30zo5QHTTLiAvhF6Jty53FgaEx29btaEytajclp5ezW4DOYTy
         jC5FFExatuFDOOqKwEdqBM0P+bNsprz1tMRC3np4lFQ+UvD+Vjzu9mTUk607LrGRZDpM
         dbU6KmYgTZQUSwxswZC3PwyujNGwqeEe3n/OaxN1OffGkFrSNfqPrfEp4ssDmPEgIy0b
         2/fGpmGiZ8fJ9WGrRRxOXBjqQpYYD8DZkttESVqYxirwgbgjhnoARaXb8oNZ5LiZZIkQ
         uggllUlW5A2Yn9ttLYBrl2biPHUUhG458W3M91R8rpZnhz9JtWycvqjqU4YPtzjSJo7w
         +5XA==
X-Gm-Message-State: AC+VfDxkXnhblKpKooQd2hWxseIqJsy1tasfMSwRLpPrZJru32V5RTAT
        e58B4NtDx0bxQ9Z9/Usht3f4jqye4szeclCIsEmtCObHSdbDixjm01BIQo8+N+XXGtfTUhMZToQ
        pl0QW9cq4QPQkDLeF975vHsjJlpkbHvvCcg2sSH8fBTtY9RSBZ6LgOhkv1EwH4FU=
X-Google-Smtp-Source: ACHHUZ4MPQvnxGkbYkv//U1Arw5q289dAXpuIxbk4EIZXkNtGTovcVKDmy41XkMufFOm48XLffgtEw==
X-Received: by 2002:a17:902:f549:b0:1ab:bfb:4b6e with SMTP id h9-20020a170902f54900b001ab0bfb4b6emr4413386plf.31.1684431065747;
        Thu, 18 May 2023 10:31:05 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id jh18-20020a170903329200b001ac741db80csm1738936plb.88.2023.05.18.10.31.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 10:31:05 -0700 (PDT)
Message-ID: <bc9ece45-2067-857e-6321-1a75cc5a5925@github.com>
Date:   Thu, 18 May 2023 10:31:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Content-Language: en-US
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>
From:   Victoria Dye <vdye@github.com>
Subject: [ANNOUNCE] Git Bundle Server for bundle URIs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

If you've been following the bundle URI feature development over the past
year ([1], [2], etc.) and are interested in how you might be able to use it,
I'm excited to share the Git Bundle Server [3]! The bundle server repository
contains a reference implementation for a management CLI to create & update
bundles with the 'creationToken' heuristic, as well as a web server for
serving those bundle lists & bundles. It can be configured to host multiple
repositories (each with a separate bundle list) from any forge, your local
filesystem, etc.

The project is in pretty early development, so if you do try it out I'd
greatly appreciate any feedback you can provide [4] to make the bundle
server as capable and easy-to-use as possible.

Thanks!
- Victoria

[1] https://lore.kernel.org/git/pull.1248.v3.git.1658757188.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/pull.1300.v3.git.1660050703.gitgitgadget@gmail.com/
[3] https://github.com/git-ecosystem/git-bundle-server
[4] https://github.com/git-ecosystem/git-bundle-server/issues
