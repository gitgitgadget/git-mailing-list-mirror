Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C020C4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 04:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 098D8613DA
	for <git@archiver.kernel.org>; Fri, 28 May 2021 04:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhE1EZl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 00:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbhE1EZF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 00:25:05 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A2AC061760
        for <git@vger.kernel.org>; Thu, 27 May 2021 21:21:00 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id i13so3275841edb.9
        for <git@vger.kernel.org>; Thu, 27 May 2021 21:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=moria.us; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=D3qozb95P6g+Mjg8VeuMLA4sw1IG4/qVqcqvdeNOVq4=;
        b=mraT3w6PSUgW72liL2ZV71jqFQr5LhvXhwbZfsGKHQ506wtJf52BWGi77hfoS/ThS0
         qvxyV8k1Nf4OfTmXRjW1k6CqXdPiHPygrIMRRTU4BDdIoQbHTkjWlkY9clbkvh9/LLA1
         amioRqrgsor62J00MKF2Fa6tfW8WyM/yYnVpMpi63OTXN2EJbslW3OUEDdLlUpHe+1bu
         LZTZLYpYppt5OxYNnC95KpqkEgYaSrP1/6glufPUoENrcese0KAMe1la80esUF6KMXTK
         he3Rx+7ZgOJvM3K8CYJ4/WXT8gXWQXElLWYVf/hMpYcXuLhIXSuXlWMsARFzCT0KziBV
         iUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=D3qozb95P6g+Mjg8VeuMLA4sw1IG4/qVqcqvdeNOVq4=;
        b=r5sjhhtG/rxqeILjLfXdxKp+c25/gDJN7ggEWvEw2z4CGCHjQlBxIfsEgaOiSEY36+
         b9CGpAbLSb8/2S3NV0sh2EIH++sFw4dc6RRZ2F5T0uVP7BG+WPL41shnEBlQ6+RRRx5i
         v712wVo2Qgjlhry2b5cTw0RD1U2n6AJgO7yJUGYTlaGATVSYBC3ghAyfZ8HC781OWzlE
         e0IYbPYiExqXk1giraAvoxmrOWZ5rgOu6hzNvm5jQKrcLsxWgzFhdvIFxBp+JXRwePd7
         3u+ehwKRRXgEJ3WKo3ZdLHfwA+5fn6tigEBB0DribeL8969xtOEdgKKM3dxXijTXMeSi
         NqDw==
X-Gm-Message-State: AOAM5304G2ByuB8/a876O9I6LvjyNFfC6bFYC2NX5CRpQGVCW+i6Fk1W
        gQaS/pIEZWrc0Fxj43VaJ7bYwlH5hQhRcib1IpIAy3/Bjz7hNdwk
X-Google-Smtp-Source: ABdhPJxbf7pttSWahZKvjlukxMqmcO53OvWZY310tOAhaZP9BES8UGxycjAWJtLHiUCM5p6Jl5TtRc2nZmZNwosSa4g=
X-Received: by 2002:a05:6402:2706:: with SMTP id y6mr7947972edd.355.1622175658338;
 Thu, 27 May 2021 21:20:58 -0700 (PDT)
MIME-Version: 1.0
From:   Dietrich Epp <depp@moria.us>
Date:   Fri, 28 May 2021 00:20:47 -0400
Message-ID: <CAKGua8U25GF=mC+vRARRY99ZgaHoUOA7vppmOUdWoeB=bf3NAA@mail.gmail.com>
Subject: git rm --pathspec-from-file does not work in subdirectories
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

How to reproduce: cd into a subdirectory and use git rm
--pathspec-from-file. For example, in Git's repo, at the top level:

$ git rm --pathspec-from-file=/dev/null
fatal: No pathspec was given. Which files should I remove?
$ cd compat
$ git rm --pathspec-from-file=/dev/null
fatal: --pathspec-from-file is incompatible with pathspec arguments

However, git add works as expected.

Tested on commit 5afd72a96f0a3f65a832fd1448d9de1c534aaa69 (master)
