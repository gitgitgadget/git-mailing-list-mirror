Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F4C9208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 22:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731239AbeHGAz3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 20:55:29 -0400
Received: from mail-ua0-f169.google.com ([209.85.217.169]:46678 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729712AbeHGAz3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 20:55:29 -0400
Received: by mail-ua0-f169.google.com with SMTP id u11-v6so13998024uan.13
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 15:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=IT48IT4LUO+AXngAusd9bVN56u9fqrBlSqOhN7L3FOs=;
        b=dqQ8CiTAa52xxa8QM6+BbcWTSlQbUy14Q2s3+sytqx08v4btvTHP5au5OpZNGlCrJ4
         XYY4e2SStCxkFFZGE+9DqdqXDb9qhSMXZpoE/GYHQMceFp0ISX3tQDNoseW5XWl2Offq
         zcru4e45Lt8ohmDFXIvB3ImDiQkhhVKYUPqPZ2GMjlmi7+YCS90STxRNwIjQnh4K5szt
         E9KLs0gWoEKNxiSosYqgvsbPjFLgyI7cMYOZLM8m+srSaQlbKrBTXURoHujewtL9MQwb
         upUhfkrWoQ4p12/KFuBpuRLniLpUUIVkN4zQ7jNAfLh4iKmYDsaMAtcanx5Mb8irhxFM
         W5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=IT48IT4LUO+AXngAusd9bVN56u9fqrBlSqOhN7L3FOs=;
        b=lUCqns9XLf0ydm/JhgFfTGFbxB55zasP14uQaYbBHlWnSRmPcAWkDtckwJ/CU36byl
         Xa947aNWIBPu+sMbbniJU9RbvAEhEBS1WrknC1JJeFkqa+OIEzbT+j4cxLPReKNKij+k
         f/WLAvFgIusbWoDQTW3XknrPjpWWRmJM4NloQ5SJBLrLtzrhSec5L1+fcGwn6boSgXNy
         MfK7z4Gjk+lOqM7sApNaddnN86b1jzuAA7i7utrLOCCb0hLqn8HvN8TIxUoI3jxZXarH
         jEqxSN/bEML6nIkurQoMkarzqkR2p5DPYVtkgqrdkM0elhXqC5T/RGNi1zOn3rZO5Buq
         vQYQ==
X-Gm-Message-State: AOUpUlEeo6LW4weUST5U7bBDG1nHfYZNxwe0mJfBBG0bUAJLq/A4FfxP
        xyWZ6eAWjEIIK1TlfvOSUH7jidXbEw9+CeVz4vvxhg1t
X-Google-Smtp-Source: AAOMgpe9TXt/8T63bISTnwSwtgWIYCJe/WdA9Sip+JRYbjXk2fXsrlGsxmntyXLlIyssfLK83ac+NTaPnQ3ZoCDBtM0=
X-Received: by 2002:ab0:1861:: with SMTP id j33-v6mr11861536uag.119.1533595453796;
 Mon, 06 Aug 2018 15:44:13 -0700 (PDT)
MIME-Version: 1.0
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 6 Aug 2018 15:44:02 -0700
Message-ID: <CABPp-BHxJyWsAQ3FkfdC-5Vqe3d7wWZm-hVYd0-afNY9dEgMeQ@mail.gmail.com>
Subject: Two RFC/WIP series for facilitating merge conflict resolution
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

Last week, Duy posted an interesting RFC patch for improving merge
conflict resolution by coloring the "CONFLICT' messages that are
output during a merge. I have two more ideas (complementary to his)
for improving merge conflict resolution experience.  My two ideas are
mostly independent of each other but with a couple important ties;
I'll shortly respond with a short RFC/WIP series for each.

Some notes applicable to both:
  - Each has a very long cover letter, due to trying to anticipate
questions/surprises and responding to each.  It may be simpler to skip
the cover letter (or just read the up-front summary) and see if the
patches make sense,
  - I am planning to imminently start looking into my merge-recursive
rewrite[1].  One possibility is just doing these changes as part of
the new strategy...thoughts?


Elijah

[1] See part E from
https://public-inbox.org/git/CABPp-BFQJZHfCJZ1qvhvVcMd-_sOfi0Fkm5PexEwzzN+Zw2akw@mail.gmail.com/;
also the two RFCs I'm about to post are part C from that email.
