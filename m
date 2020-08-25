Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12994C433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 19:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E75FB2071E
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 19:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian-com.20150623.gappssmtp.com header.i=@atlassian-com.20150623.gappssmtp.com header.b="KwYKHTPi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgHYTQx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 15:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgHYTQw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 15:16:52 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0397C061574
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 12:16:51 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id q14so11414238ilm.2
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 12:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=83sR149wZfdQ5tuf6I+eZSgSM/Fexto60UQvdNOSOgA=;
        b=KwYKHTPifOTm1SO0UGL34PbP/yMuxuJdrOFMD5K9OG8GHWSF6WuTPsKZkATOagQPLR
         ZnmYKANInXkG4Rw1Fbtd1bueUWOog5V97OEjrh0IyWe9njfzm8gRj9p7m0cefD+9f0oX
         WRpBDYRpg0ZM1LoW1GzySfNS3eUnHLuILqwr7t2vAPbA3Gn/W1r8AZ0xG3Huuymc7bWC
         dWFBYMXHW6RrtlGVle4PAXDnp+6CrnTQgIGU3Q+AYFnsI2O60GlOEk8O03F9/plpfJfV
         sACKSy6z+FjP51Wi2JR026eypPlOOtFx9+ErVn1s/PUsV+cEGvGHpDMzD//+a6dhO91y
         dwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=83sR149wZfdQ5tuf6I+eZSgSM/Fexto60UQvdNOSOgA=;
        b=O5b9UnK6rzcXNrFJAqUr5bxyX+QuprxFfd2Jp5RLqAHu1J1mKmb3qfrwVjhVEZtxzB
         vYBu2ts9cmurU1GlM5/SBxOji7PoFkCwkdszTVPQ42ZeJAyZjhL1D32gWd3OD08jHxZn
         bF0iKjGOUQZztTZKMFvOdNeJ8mVFd02zSNgbgMgaHHcllqJ/P4BzVH6qzYo3zXNZUk4Y
         dVXPE32mJj3Y8eyXxKGjZp3MXB739+ZzerB9orRCN5awBvrkY8hFfnRd77LvuoiM/hYR
         8cTUn7nr13XTzy89vkQhQYxNQJiTq3HCsQSqiTuPTnSPTgxpJYRGdHSescBoG+TldeQ2
         /T/w==
X-Gm-Message-State: AOAM532wtOIvdLpU4MRjW4WFI/Gmp5pjQVdi3Ua2iiVFnfuoEjaFRoBS
        imU3NrKp9z+QWGqAw8i6EVs+xHUa0EkJzpYgmMOojPNRd6c=
X-Google-Smtp-Source: ABdhPJza8YkHs13kd23toQwHnEIgG6F0xQl+EPOgAOtioGSS7qzicAAP1waoa0iD8RIWP2jBaq4Sr1IFR31qku1ypJ4=
X-Received: by 2002:a92:79ca:: with SMTP id u193mr9669525ilc.185.1598383009169;
 Tue, 25 Aug 2020 12:16:49 -0700 (PDT)
MIME-Version: 1.0
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 25 Aug 2020 12:16:38 -0700
Message-ID: <CAGyf7-G_ciVpgvvOiH1Fq9kNuWunCpM1fhv3ao_RMXBB0K=HMA@mail.gmail.com>
Subject: Mismatched HEAD default behavior from git log
To:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When git log is run without revs, it defaults to HEAD. That's
well-documented. However, when paired with --ignore-missing, there's a
behavior mismatch if all the provided revs are nonexistent.

If you provide the revs on the command line, like "git log
--ignore-missing nonexistent --" (the trailing -- is just to help git
log know "nonexistent" isn't intended to be a path), you get no output
and no error (exit code is 0).

If you provide the revs via stdin, like "echo 'nonexistent' | git log
--ignore-missing --stdin --", you get every commit reachable from
HEAD.

It appears the way --stdin processes input discards nonexistent
commits before the machinery that decides whether you provided any
revs or not runs, and so if every --stdin rev is discarded then you
get the default HEAD. If you provide them via the command line,
though, then it seems like they're discarded later and you don't get a
default.

I'm not sure whether this is intentional or not (certainly I don't see
it anywhere in the git log documentation for --ignore-missing or
--stdin), but it results in a behavior mismatch that's impossible to
reconcile without requiring extra git processes. I can't always
provide HEAD since, if multiple revs are supplied, if any revs exist
then HEAD would not be included regardless of whether the revs were
supplied via the command line or --stdin.

I've confirmed this behavior as far back as Git 1.8.0 all the way up
to 2.28.0, so it's by no means new. I can't recall seeing it come up
on the list before, but that doesn't mean it hasn't. Is this a bug, or
a feature?

Best regards,
Bryan Turner
