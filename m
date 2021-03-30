Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56051C433E0
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 20:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27FB4619CF
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 20:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhC3U3S (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 16:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbhC3U26 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 16:28:58 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44A2C061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 13:28:57 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x7so17486760wrw.10
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 13:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jff6Mmi2y7vtareAW65LlC4YS5aXpVuGaVQWfpxgIyU=;
        b=ihL+k9sUOpjI9YD6EjRVd7LBP2yC947raGPIYWKXHACfn14D+bt+QSLn7amE+x/nxW
         Qqpj57qEU3NZwHPWd0Ig3UDOYxsJ64jXoMCpEfurEnRdhFMboCdZrZxxhg0oxGpDTPXi
         xHTVN1BnLQheYGDfCBv0sUzifBU3SAZG3qXGhuORQ0FdeEscRY/sA/e2U5aG7EaNtiK1
         ABjBdcyHeR4OI2CsMrUW70MKFfxKVxXfw7CgF5H9V1wpvG/bMwJYgUWTvi0+aLRf5kfZ
         6FAeStbgOVOlpQvr4VFo8HQkh6DHPjtaV5ApGOMzxis45/xSEqj7xNX5hDBGlbujeGmS
         LP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jff6Mmi2y7vtareAW65LlC4YS5aXpVuGaVQWfpxgIyU=;
        b=BOtsfzL6Eh9yGW5F0abjte9wwQmH7kxFX8T4pGSfTJwqxyaNNqdqVp8odBcBm1xwU7
         U5msf37DqdZt81thUJ6kJOMUpWXqrH1WsmrO3Vts4W4sPFa3TcchW9Al29m7+ReFAUku
         2tDXw6WmI2cgUVuKnP9iNkaZNl5qH0Bgt9anq8pvetKrOXQiM1FuSFpq8OEbImerMa0R
         i06ozGHMYeozvwyz4Ehx9EH1+aJ36PZnOBu/QFC4/6/9HjIyYqAwL1Fff71XBJ3hs2am
         +tlw+OrZRd4akGlK0h/H9Ku1B9dV6mWSibNoNlbCpgdWrXyMVh9T8I+wYiQawXVCfKu3
         ZB3w==
X-Gm-Message-State: AOAM530vCT38PUzz+OQ3Kk6oSQM6TjMml8XJeYUdz5hZs5QPv9bE0WlL
        OYhliW7SonYfX0EkbzCAgBL6oPXCGOYZY7mSZsI=
X-Google-Smtp-Source: ABdhPJxeWz5o5psB5ld5g9zcQhZYtTGi7J7Ns975z5thvQBg4uvX7RZk/nbR6R8PIIh/qC18NauSJA==
X-Received: by 2002:a5d:6b89:: with SMTP id n9mr35395958wrx.236.1617136135904;
        Tue, 30 Mar 2021 13:28:55 -0700 (PDT)
Received: from localhost.localdomain ([2a02:85f:2a0a:9300:1d6d:c581:cf0b:2ca7])
        by smtp.googlemail.com with ESMTPSA id i26sm117306wmb.18.2021.03.30.13.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 13:28:55 -0700 (PDT)
From:   stdedos@gmail.com
X-Google-Original-From: stdedos+git@gmail.com
To:     git@vger.kernel.org
Cc:     stdedos+git@gmail.com, sandals@crustytoothpaste.net
Subject: Branches, upstreams, rebases and logistics
Date:   Tue, 30 Mar 2021 23:28:52 +0300
Message-Id: <20210330202852.9673-1-stdedos+git@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was reading this thread:
https://lore.kernel.org/git/YFP+KuUn99vftBIC@camp.crustytoothpaste.net/

and, in specific:
> ..., many fixup and squash commits and near constant rebases.

which speaks to me somewhat heavily.

As this could be a discussion forum, I'd like to see
how other people are dealing with / have done for these:

I clone a repository, I do changes on top of a branch,
I push for review, ... and the cycle continues until merging.

It is trivial, when native `git push/pull` is used to push/pull
to/from one remote which I have access, as `pull --rebase` works
magically in keeping the local state up-to-date.

It also works with the repos that you do not have direct access to
push natively on the branch nowhere, as you can keep using the
`pull --rebase` to sync, and "push" with some other method
(`refs/for`, `git-send-email`, or others which I don't know).

However, with the Github way of working, that means:
I have two remotes, (origin and upstream), on which, I develop and
push on the `origin`, but I am really tracking/rebasing on/from `upstream`.

I cannot `--track` upstream, as plain `git push` won't work, and
for pull, I have to separately `git fetch --all`, `git rebase upstream/<branch>`

- OR -

I have a branch, which depends on top of another branch (not yet merged upstream).

o - origin/master
 \
  o---o---o---o
  |            \
  fix/local     o--o - (fix/depends-on-local)

For brevity, I am setting "git branch --set-upstream-to=fix/local",
which helps, when rebasing fix/local on top of origin/master, to rebase
fix/depends-on-local on top of fix/local.

However, as noted above, a branch cannot be pushed upstream easily and
have a different upstream set at the same time.

I know my logic/understanding is lacking somewhere;
I am looking forward to enlightenment :-D
