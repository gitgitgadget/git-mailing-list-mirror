Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFA001F829
	for <e@80x24.org>; Wed,  3 May 2017 12:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751266AbdECMQv (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 08:16:51 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:33325 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750966AbdECMQt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 08:16:49 -0400
Received: by mail-io0-f169.google.com with SMTP id p24so4607887ioi.0
        for <git@vger.kernel.org>; Wed, 03 May 2017 05:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=BwoykM7Typ3G8YV0XM78VkFZxrlOjnxihTXN4/gcj+s=;
        b=NrGnPGnJ7I8YpoJY6ABdyzAECkRR3qgK3tIty4MDwY8si6PHcabpdNp5KtaaG7WrP8
         12RXqvpMEZGDVaiNgQ8vFkaAb8vCO+Mg3hnBqTpsi/vFwcShUIAX5CcVX7ezbkF9+zzx
         nPWbqBfvlLQGusuz0wgEEv4ndv0N/awSBTavmo2g/rlchXCTrTCvEzDJ83IRzhBfIYEi
         7M9044+71rI6bMtbQqmV+L7SmtDEJ8tfKjq4dGBeQc0NX3gfibIjiG93eACAYUaXXkNf
         DRotts2+EEn6hIkkIk9pJxom1w1z7bId5Xk8bNd1L9LASJ3TNwwRjdb5SOhSauaYIBc/
         Dn6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BwoykM7Typ3G8YV0XM78VkFZxrlOjnxihTXN4/gcj+s=;
        b=gI9ga9jwKNaZ6jr6Ni50sj47cToNqQn4YdnRPI1i0TEm0GckfigcqCy+WC3WDRx+lp
         6jmK9LilZR+4P/oz8QESI9aUS1KvR+a0UKBakKkYcQBm9K621o/zLJn72+RBnU3qdEWj
         uZgrc0b8a4bPkibqIswqT3w2G3MFcJoXGJ5fNmxjmYTS1GlCAjagM+eaAzAkAjTSTrwA
         U/AmO0c+X22tRof8x+ykzp307jiehmu9ovQ3ybLOqw+w6ZH/v12kOtm9k6CroqbWEhhD
         CVlNv/53Qp60/kSn2gOsy6cVIkgaU9xLTmB3IBhS/HOEFX0o5BF8j/W8anHpsKmJytTQ
         dvDw==
X-Gm-Message-State: AN3rC/4CvK/FTCmhIPeQyK3asnWMqcmbWo4gaGmkHptWu6f/vaQZkzGf
        RnZmYNA0kmuT+2rKdjMP6p6XBDfXqCRhI2w=
X-Received: by 10.107.203.1 with SMTP id b1mr37771157iog.29.1493813808347;
 Wed, 03 May 2017 05:16:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.30.67 with HTTP; Wed, 3 May 2017 05:16:47 -0700 (PDT)
From:   Sebastian Schuberth <sschuberth@gmail.com>
Date:   Wed, 3 May 2017 14:16:47 +0200
Message-ID: <CAHGBnuMUrNFv30d+pjheiCAikM89XshQTFuDXBzu+EcxNY_94w@mail.gmail.com>
Subject: Cloning a custom refspec does not work as expected
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm trying to clone a custom ref, avoiding the need to init && fetch
manually. From reading [1] which says:

"Set a configuration variable in the newly-created repository; this
takes effect immediately after the repository is initialized, but
before the remote history is fetched or any files checked out. [...]
This makes it safe, for example, to add additional fetch refspecs to
the origin remote."

I'd assume that this would work:

$ git clone -c remote.origin.fetch=+refs/changes/*:refs/remotes/origin/changes/*
https://gerrit.googlesource.com/git-repo

In fact, this *does* add the custom refs correct to .git/config, but
they are not fetched during the clone. I can manually fix that by
doing

$ cd git-repo
$ git fetch

afterwards, but the whole point is to avoid exactly that separate step.

Is this a code bug or documentation bug?

I'm using git version 2.12.2.windows.2.

[1] https://git-scm.com/docs/git-clone#git-clone---configltkeygtltvaluegt

-- 
Sebastian Schuberth
