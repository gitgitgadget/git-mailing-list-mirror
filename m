Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8793C678D4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 10:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjCFKZc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 05:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjCFKZQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 05:25:16 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4DE2055F
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 02:25:15 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id x1so6049231uav.9
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 02:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678098314;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y1hjsqaug0dvUOiASym4Kjtb2rZ6MUHZsf3NidcfGrw=;
        b=YOX0Ahtx1sQ3zLBQQ7o+RSB1Ie9u0eha3NNJNheuumNFLt1EGjMs8TkDq2YLjHY7pC
         wzjphSOu3saI6mmPwAsH/11u6a+f7NnacLfQyyCyrKYmvLoZaKgXHnVXkGffDIw0Qw9k
         ddtwjMkwZVfVIkNkP+v3u1pxNNIsv5VFkC5oLrw6KJb4TFUV7h8d0kPwboNy3rbh3/wf
         ekFEvQYnTEg1yofpM8g6A/hfz+QEmMOUDywNzIym+jCzvEkyuxMSRGsOlhEFpjXjOlRv
         V4i7tcwsrrT5Sr3lMPVIjvjTXVJsnjP9PnkNXAs5D6A2TQQhg7w7y/WIbzPHFuCzU5bL
         NwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678098314;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y1hjsqaug0dvUOiASym4Kjtb2rZ6MUHZsf3NidcfGrw=;
        b=gsdU8dJiv3rrDhZNaTZRC73HRm+Evq8BbXf5ZXDe5cGmpGeSzgBz/Ayc3TbGLct6jj
         h/k85nEXmMxJwQB+w+ZKxWeS1zswi6qYy2NAI4NVpqrfmpHFNGXYl6/FFaqVFw/JzPZV
         TrfmV5BsXlbUE4gpp8n9fAwF7vaQirf6h38xNqhj+1drHxA5XG+L4H2D8TL6oPqWjAlj
         4cT9khHc3VQ7j1Ih7AunMQKFO9Xmk4vgG8lTAI8m3xGkEiaW61jprb4UtAGpeOdW5dBP
         dz/IUEfiJa5WkH5yT7SefpCCyaA6GIQkftSGgwf2WyR+66vpkW1LitcwXddxlMI70e3S
         pGpQ==
X-Gm-Message-State: AO0yUKVufxnTxvKgU4po6BFD+1zBM1008+A4iCSRpLx/zZLqWBH/I1I+
        YfwfPCVfj8Kf2WH/5xj5k4MyNLsSaEmOQMaXjDdD/w9Gx7z8kQ==
X-Google-Smtp-Source: AK7set8QK72pJRyobg9e5puhlY2eqMQo65eHG9LTzfd0LLStFKrNTC8dcBFpe0MofrKwpz3Ynl4cvLi+ECTmGjer7pA=
X-Received: by 2002:a1f:4a81:0:b0:410:4a2c:1e9a with SMTP id
 x123-20020a1f4a81000000b004104a2c1e9amr5860205vka.1.1678098314655; Mon, 06
 Mar 2023 02:25:14 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Matthias_G=C3=B6rgens?= <matthias.goergens@gmail.com>
Date:   Mon, 6 Mar 2023 18:25:01 +0800
Message-ID: <CA+X7ob8DWGmoVTxSVvrFN68V=pcaZripfP=s+LpWvXN-6L7W7Q@mail.gmail.com>
Subject: git archive has confusing error messages
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Here's something I noticed back in 2012 or so, and stumbled upon again recently.

Start eg at the root of git's own repository:

$ cd xdiff/
$ git archive --format=tar HEAD .. | tar t
fatal: ..: '..' is outside repository at '/Users/matthias/prog/git'

In the best case, I would have hoped to get an archive of the whole
repository here.  At a minimum, I would hope for an error message that
was less confusing: the directory I was referring to is very much
inside the repository.

For comparison, `git -C .. archive --format=tar HEAD | tar t` has the
behaviour that I would expect in this scenario: a tarball of the whole
repository.

(I don't know enough about git to produce a patch to fix this at this
point, but I can try looking into fixing this.)

Thanks,
Matthias.
