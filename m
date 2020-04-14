Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802C7C2BB85
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 20:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 483E82076B
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 20:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aA6/LHcg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633019AbgDNUXC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2633040AbgDNUW5 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 16:22:57 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FCBC061A10
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 13:22:57 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id f52so1052287otf.8
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 13:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=OcCJF8+Peja53dDVepNpyjJmCxChRJ61lZhVQpjB1TI=;
        b=aA6/LHcgHCeoVt4FjZPf7sld/PJySI0z6m++surInZYbKlU2QdXvPIQl+aMUSD6+0S
         1IkR+Po85SPVcV3pHhXWWYOid7AB9HLQcMi0QSGF6l4L9Q+ASZ74m46kiLV+ZCi5jfR+
         4sczhuEbkHIB3FsIEmYlYGV4TjKcraT/DEkc/k0h3pHVuuY5KoJy05MIytV3m/9ZyWjK
         1FlFg7LN3E5n/37jbzTTSyEp970DBEnUSeuiK6RZNHcQw7TERwrt1hUaSSTWj8KIclHO
         UBADxOOrrP807VggMZ6NPu+N5CByQW/w6EqVAUG03qed4QQml1Q0nAxTwHtlR2/QkYGp
         N7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=OcCJF8+Peja53dDVepNpyjJmCxChRJ61lZhVQpjB1TI=;
        b=i4acS1t08TtEK+TpNkxZuakG7Byuj75w1T78iFV8rTwX6idWzEl1VWOUKS+qVlejox
         sr7Rp1ipIs7OvDOmAm3RwV72HwRrsTrFVZBLoiqosik/ftYuky41mRJUrtgKwneI5w6h
         jEfetnWROfqqCTi8LnAJ4eF36PqJsOg8pJ5ikYfctvwLSICPgNBOpC9C5+jwWCCjUhCA
         ZZIc3lkLqhPWWB3BHIr4HwQjKtSZve6ZFluKTSQs3R3Lq/cAsCEHKjPbLsOHwuYsp0ZS
         7sOQDAtR/dEfKJd23wPJTp+GocBry36kt2WM5eUbZ5AOpHLS3sZMXryXwsBV5Dyx5Ufc
         WZRw==
X-Gm-Message-State: AGi0PuZmM3OIoFSNIx95fMc9NRueSgqUziC7SQfeOakoXzS4EcAkBKvb
        nb008MIaMphs9HZfrWzreqewRfYlPf+96ZpwQ/6NbgfNhAc=
X-Google-Smtp-Source: APiQypIRiSTWZcRa34io8va7kG4dPyMplUNxt5J/5daHCBMlJjkEqGtC9gS0FIgmrpP7Rq1SoaLrKe5FR6UwtVaAyEc=
X-Received: by 2002:a9d:5e0d:: with SMTP id d13mr20479927oti.162.1586895775999;
 Tue, 14 Apr 2020 13:22:55 -0700 (PDT)
MIME-Version: 1.0
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 14 Apr 2020 13:22:45 -0700
Message-ID: <CABPp-BHGubUX5o9KsQaoh_UFjFh2PaMkkJhCao+5LGnFc0dQNg@mail.gmail.com>
Subject: Is fetch.writeCommitGraph (and thus features.experimental) meant to
 work in the presence of shallow clones?
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I was building a version of git for internal use, and thought I'd try
turning on features.experimental to get more testing of it.  The
following test error in the testsuite scared me, though:

t5537.9 (fetch --update-shallow):

...
+ git fetch --update-shallow ../shallow/.git refs/heads/*:refs/remotes/shallow/*
remote: Enumerating objects: 18, done.
remote: Counting objects: 100% (18/18), done.
remote: Compressing objects: 100% (6/6), done.
remote: Total 16 (delta 0), reused 6 (delta 0), pack-reused 0
Unpacking objects: 100% (16/16), 1.16 KiB | 1.17 MiB/s, done.
From ../shallow/
 * [new branch]      master     -> shallow/master
 * [new tag]         heavy-tag  -> heavy-tag
 * [new tag]         light-tag  -> light-tag
error: Could not read ac67d3021b4319951fb176469d7732e6914530c5
error: Could not read ac67d3021b4319951fb176469d7732e6914530c5
error: Could not read ac67d3021b4319951fb176469d7732e6914530c5
fatal: unable to parse commit ac67d3021b4319951fb176469d7732e6914530c5

Passing -c fetch.writeCommitGraph=false to the fetch command in that
test makes it pass.

There were also a couple other tests that failed with
features.experimental=true (in t5500), but those weren't scary -- they
were just checking exact want/have lines and features.experimental is
intended to change those.  This test from t5537 was the only one that
showed some unexpected fatal error.

Thanks,
Elijah
