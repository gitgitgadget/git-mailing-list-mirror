Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4E0C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 21:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A040060FF2
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 21:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhGTVQA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 17:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbhGTVP7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 17:15:59 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBD7C061574
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 14:56:37 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id x9-20020a6541490000b0290222fe6234d6so18678705pgp.14
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 14:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Y6yhEp/WPsBDxkQHmgBuhm3pl/2Vm1PSS+jBQ8JRKxo=;
        b=sXwpKJVAnJPjP/ay6dBg8kp++GJA4glsTh3Xk/62hzaVpZHGu6P+wFIQaDHDmOnuEc
         JF4QGAES6/zgT2GJF3IwMZyh6Sdo18R+JeRszt7WhV+sw6LU7mdhgRIQCjCYA9S3pcun
         WGMRx2BhIwEQsEbvT40R2KauP1QcPQ8h3aswwDKRGK9ytAbp0U4W6TQc9c1j2K/etBTq
         2b4f7xNyOrt0kuShHswVjjPscic1tHRy1sKBwrrcKbx1zH5jSXJXAR+ErZ9PiR0Rl6zJ
         WPSykqSZuaFzoBZB5iVvOUPUjlChTtCWW9czmcbINkrc6x1TGYe9oSsGGLc8amMAvmlO
         JtQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Y6yhEp/WPsBDxkQHmgBuhm3pl/2Vm1PSS+jBQ8JRKxo=;
        b=sJuMLLx6d8bU0AWJGDN/vDKGo/u8HqfnUbyRl34SnNIHOYI31qTxCUlpuLIAevUdAW
         Ol9Zh65I6VDW8+HWZZxVONLe3fbyI/6KKwrzuUeuDEhNk6Qye/3kykSBRZBqw4FjMlYc
         9F7LzTWjru4e0kEmixv19w3DWdsoZNg3IOhT8OhxnlriPmvCIksPswKLk/D0Oqz258wo
         K8Ayqmo18yld0YgEEc8jr6urHTcL82fI0ubCzWnjHP6u2VVs5XBYNA4se899JI1+jnv4
         kPhzjLeAl4LEGVfeMLV1F+h1jDEemJ8V3BMmAQF1TjWj9BG4LIzKibTEDBPR5EgP+UZ7
         xiVg==
X-Gm-Message-State: AOAM530xbhlA6GoaX4O0jRh4XcbUT/cUhx96wQbv5Wg87GZYAf/7ObIb
        y9w23jgwaq+k0/WnGnrUcndVFlDKK3uyuveWdhM/
X-Google-Smtp-Source: ABdhPJztIe1fUnnJ5zngfM8HbOfWgndXJMmmN9u+mM8qafJEshfHwWyQmgJqITFiL2B66CovzjDM4aRoN4iyaq3A6iru
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a63:5963:: with SMTP id
 j35mr32403973pgm.341.1626818196650; Tue, 20 Jul 2021 14:56:36 -0700 (PDT)
Date:   Tue, 20 Jul 2021 14:56:34 -0700
In-Reply-To: <CABURp0q=t+4KM8ET57gZavHCAJSZQoVTmPS=n9rdapDczepdsg@mail.gmail.com>
Message-Id: <20210720215634.3598035-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CABURp0q=t+4KM8ET57gZavHCAJSZQoVTmPS=n9rdapDczepdsg@mail.gmail.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: Re: [RFC PATCH v2 2/2] hook: remote-suggested hooks
From:   Jonathan Tan <jonathantanmy@google.com>
To:     phil.hord@gmail.com
Cc:     jonathantanmy@google.com, gitster@pobox.com, git@vger.kernel.org,
        iankaz@google.com, sandals@crustytoothpaste.net, avarab@gmail.com,
        emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Tue, Jul 20, 2021 at 2:17 PM Jonathan Tan <jonathantanmy@google.com> wrote:
> >
> > Overall, thanks for taking a look. If you have time, I would also
> > appreciate comments on the overall idea of this series (the concept of
> > remote-suggested hooks in general, the way that the user finds out about
> > them, and how the user can make use of them).
> 
> I'm curious what happens if we have multiple remotes.  Do we only take
> suggestions from `origin`?  If not, what happens when there are
> conflicting suggestions from different remotes?

In this patch set, we only take suggestions from "origin". Right now my
idea is to store the name of the ref that we should track (e.g.
"refs/remotes/origin/suggested-refs") and only use that ref for hook
suggestions, so we would only take suggestions from one remote. But the
purpose of this RFC is to discuss questions like this, so feel free to
let us know if you have additional use cases.
