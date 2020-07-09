Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D46C433E0
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 02:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EBF0206F6
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 02:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q/wDQ4fH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgGICXE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 22:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgGICXE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 22:23:04 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E733AC061A0B
        for <git@vger.kernel.org>; Wed,  8 Jul 2020 19:23:03 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id j9so682788pgm.8
        for <git@vger.kernel.org>; Wed, 08 Jul 2020 19:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NAiYMF+2o0wupSinEoh+H+ntIj5aNHCwlOB48p2z/to=;
        b=q/wDQ4fHA/fMj9010q78UyzZk3mICA0QhbE1JrBv7JRCFn9M74ak7uattPzFawG/mG
         m6DOzd06rDN4yR7RbC/NksJa1Q7F/QZVEAA8u1Ewv65ARUsv8Ci7O+U12iC4Y5MxCNxt
         fNJ5nFZNAGLwofSyCCOpcaci6KdQ1438iHzwXQscn+C9+x+A5/FZzHxJppi7w2B8IbYo
         ZIUhNRF+564i2t8IP9aNjYthhjKdRZqg0DyRmYsLd4pGEeaXnj9tHyPC443vu9RWaMmD
         CkHtmsOwsbqarziypeD0mXgDnOJF2/G4mRSGR5hZ27Xehjd0jXpFeksfgfwVJ/ndOIgF
         FQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NAiYMF+2o0wupSinEoh+H+ntIj5aNHCwlOB48p2z/to=;
        b=g5fv3NAtaIAGnbYtbvH6xSe2XuxHw4JE0rSQhSwUyLKinMBKg6Jj1NLKAj9ES8hwim
         0a+tsdZLBF3pIUhcbakTvCZnFvL0rCjMIGgHRhWJ1g7IeEx2i86jE2zjGh8R+5lUwlOb
         qQsW9e9qYJLzfTa9YJMLtKC1z6sA1uSAbbUDA9x2q+8W7PKKUP6WL/2b9zFNc1F9bgmD
         gWOU3dqCe2SUlH2QA4Eb0braMZMNwZ/KQyDz3hqK+CJeYeczudOxk1PKpYdc3fMg3aBc
         GAgDYh7RmVeIp9ja60ztvmySQE2YdJvOkeI4uVSo0lQ9y1Fj/2GAYRzhGU/keqYKBds2
         3t0A==
X-Gm-Message-State: AOAM532edtURYPRaXo6TWuPJj+kiEtJlcj8vKnUwNIa/Hy677HcmjDsG
        oFvMBZCycCTB6sEJW/oFXS1r2xW2u7LhtCrgWLeV
X-Google-Smtp-Source: ABdhPJwpF2p0dna2D106snwhR6GBz3nF+Vm/n6AkHKEPLtwqLNb/52vEACq5IAOvK6/1H/I4zJ8K1oyK663ymnZ9wWgJ
X-Received: by 2002:a17:90a:1fcb:: with SMTP id z11mr189200pjz.1.1594261382783;
 Wed, 08 Jul 2020 19:23:02 -0700 (PDT)
Date:   Wed,  8 Jul 2020 19:22:57 -0700
In-Reply-To: <e13d351e9ff19695b2ff638af01fdb4527fb7a6d.1594131695.git.gitgitgadget@gmail.com>
Message-Id: <20200709022257.36743-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <e13d351e9ff19695b2ff638af01fdb4527fb7a6d.1594131695.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: Re: [PATCH 04/21] gc: drop the_repository in log location
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, derrickstolee@github.com,
        dstolee@microsoft.com, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The report_last_gc_error() method use git_pathdup() which implicitly
> uses the_repository. Replace this with strbuf_repo_path() to get a
> path buffer we control that uses a given repository pointer.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

Regarding the first 4 patches, it would be great if there was a test
like the one in test_repository.c (together with a code coverage report,
perhaps) that verifies that all code paths do not use the_repository.

But set aside that test for now - I don't think gc.c fully supports
arbitrary repositories. In particular, when running a subprocess, it
inherits the environment from the current process. I see that future
patches try to resolve this by passing "-C", but that does not work if
environment variables like GIT_DIR are set (because the environment
variables override the "-C"). Perhaps we need a function that runs a
subprocess in a specific repository. I ran into the same problem when
attempting to make fetch-pack (which runs index-pack as a subprocess)
support arbitrary repositories, but I haven't looked deeply into
resolving this yet (and I haven't looked at that problem in a while).

Having said that, I'm fine with these patches being in the set - the
only negative is that perhaps a reader would be misled into thinking
that GC supports arbitrary repositories.
