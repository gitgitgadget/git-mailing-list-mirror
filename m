Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09C401F404
	for <e@80x24.org>; Fri, 10 Aug 2018 18:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbeHJUfO (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 16:35:14 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:34376 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbeHJUfO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 16:35:14 -0400
Received: by mail-oi0-f52.google.com with SMTP id 13-v6so17300105ois.1
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 11:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=myitcv.io; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=Sh+gPD7QpdPJiq2X4p/s1xuVcCUvv0pB0Yv4jttLUas=;
        b=KaIf5eB8glkuFPHlV9qgMfhJfofBmbwMVy4XDdggh7NaaYj/kKBuLH1B8wxpQJhWKF
         68RAOIN8bnI5I6gOPaivBTA9AGfLEtUMafl0OTpQCBp9hRVWK7NBvJNryaK/yj8b6Dbo
         RA3hwSxi2Y5DfIvGXAc9pd1GBgbgvs6qWqPu5dhTV+DEB+XMdfgVybR58KnsE1gIKWJP
         XVim0brmscxfGgeO2/UxC775x4AK5A3dF9uuR7zb+hZMYinFblkT/1DAfvtvkacHb2TZ
         wpg66WmS5vBslLMPTcuMF1IaSXV1L8nkw6O6KJV1gZ4vIJFO1FX2LuvTHi8DoQBaf0pc
         6Wbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Sh+gPD7QpdPJiq2X4p/s1xuVcCUvv0pB0Yv4jttLUas=;
        b=tTT5iazAiK2/6arqhyH9D1KFxxPr1Pfcpga+A+7Gm1Wd+cu36ucfNKcznOmxbG+JSL
         yefAxrkDanDoSQL0qRaY3FFLceK03fDnl2rrwGDTzwTDF8TUp+N/bq1AiP/s8P+PjniF
         dKKpkRlHq45YcvbpFA4UoeA3JfDiV6U0WoQLB+AHHnDVZ3pkx2WiCp5LRyvmdqSf65E6
         /66E7f+7LsHCWsMBZx7K3yK+9SleUaaeKCoaoNVQqOeJOY/IDqYvCgIumPM5+fPyLcjm
         JtdtDIS+DoL5yz/wxYAZNUHAt2QY/MUJtyJbA90Fnyo2LEw+cLKlJy4n9GADscWfsP3+
         MnUg==
X-Gm-Message-State: AOUpUlFW7i3JJsIz7mVWFK8jW0Cj4MNS7EpYepdiSTSxF2EOdWwMd4wI
        3tvsguK7NHHB3Ds9B2uKVP1Z/pbDF/brizR86WYY3gc7pXs=
X-Google-Smtp-Source: AA+uWPz2FHhiPhkvxJwmnpk5YfHw6EOSd4ilhiyPZ9khY6PezgtsCPKqOY2BQvWQKzNn5eTqVvI7mbsYEjZnATdN6d4=
X-Received: by 2002:aca:5f56:: with SMTP id t83-v6mr8158827oib.115.1533924259209;
 Fri, 10 Aug 2018 11:04:19 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Jolly <paul@myitcv.io>
Date:   Fri, 10 Aug 2018 19:04:08 +0100
Message-ID: <CACoUkn5wXY7924hftXhCXh_N_htWoiaGEV5f7ZEM4-PE57_1oA@mail.gmail.com>
Subject: Change in behaviour in git fetch between 2.18.0 and 2.18.0.547.g1d89318c48
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I've tried to skim through the archive, but I couldn't find anything
that describes what I'm seeing. Apologies if that's because I missed
something/used the wrong search terms, or this is an intentional
change in behaviour.

Using 2.18.0.547.g1d89318c48, git fetch behaves differently to 2.18.0.

The scenario in which I'm seeing a difference in behaviour is when
there are (by virtue of the state of my local git repo and the origin,
remote) pending objects, branch updates etc to fetch from the remote.

To compare, here is the output of git fetch -v using 2.18.0:

POST git-upload-pack (948 bytes)
remote: Counting objects: 8961, done
remote: Finding sources: 100% (9/9)
remote: Total 9 (delta 0), reused 6 (delta 0)
Unpacking objects: 100% (9/9), done.
From https://go.googlesource.com/go
 = [up-to-date]            dev.boringcrypto        -> origin/dev.boringcrypto
 = [up-to-date]            dev.boringcrypto.go1.10 ->
origin/dev.boringcrypto.go1.10
 = [up-to-date]            dev.boringcrypto.go1.8  ->
origin/dev.boringcrypto.go1.8
 = [up-to-date]            dev.boringcrypto.go1.9  ->
origin/dev.boringcrypto.go1.9
 = [up-to-date]            dev.cc                  -> origin/dev.cc
 = [up-to-date]            dev.debug               -> origin/dev.debug
 = [up-to-date]            dev.garbage             -> origin/dev.garbage
 = [up-to-date]            dev.gcfe                -> origin/dev.gcfe
 = [up-to-date]            dev.inline              -> origin/dev.inline
 = [up-to-date]            dev.power64             -> origin/dev.power64
 = [up-to-date]            dev.ssa                 -> origin/dev.ssa
 = [up-to-date]            dev.tls                 -> origin/dev.tls
 = [up-to-date]            dev.typealias           -> origin/dev.typealias
   479da24aac..dce644d95b  master                  -> origin/master
 = [up-to-date]            release-branch.go1      -> origin/release-branch.go1
 = [up-to-date]            release-branch.go1.1    ->
origin/release-branch.go1.1
 = [up-to-date]            release-branch.go1.10   ->
origin/release-branch.go1.10
 = [up-to-date]            release-branch.go1.2    ->
origin/release-branch.go1.2
 = [up-to-date]            release-branch.go1.3    ->
origin/release-branch.go1.3
 = [up-to-date]            release-branch.go1.4    ->
origin/release-branch.go1.4
 = [up-to-date]            release-branch.go1.5    ->
origin/release-branch.go1.5
 = [up-to-date]            release-branch.go1.6    ->
origin/release-branch.go1.6
 = [up-to-date]            release-branch.go1.7    ->
origin/release-branch.go1.7
 = [up-to-date]            release-branch.go1.8    ->
origin/release-branch.go1.8
 = [up-to-date]            release-branch.go1.9    ->
origin/release-branch.go1.9
 = [up-to-date]            release-branch.r57      -> origin/release-branch.r57
 = [up-to-date]            release-branch.r58      -> origin/release-branch.r58
 = [up-to-date]            release-branch.r59      -> origin/release-branch.r59
 = [up-to-date]            release-branch.r60      -> origin/release-branch.r60

Notice the update to origin/master.

Here is the output of git fetch -v using 2.18.0.547.g1d89318c48:

POST git-upload-pack (964 bytes)
remote: Counting objects: 8961, done
remote: Finding sources: 100% (9/9)
remote: Total 9 (delta 0), reused 6 (delta 0)
Unpacking objects: 100% (9/9), done.
From https://go.googlesource.com/go
 = [up-to-date]            dev.boringcrypto        -> origin/dev.boringcrypto
 = [up-to-date]            dev.boringcrypto.go1.10 ->
origin/dev.boringcrypto.go1.10
 = [up-to-date]            dev.boringcrypto.go1.8  ->
origin/dev.boringcrypto.go1.8
 = [up-to-date]            dev.boringcrypto.go1.9  ->
origin/dev.boringcrypto.go1.9
 = [up-to-date]            dev.cc                  -> origin/dev.cc
 = [up-to-date]            dev.debug               -> origin/dev.debug
 = [up-to-date]            dev.garbage             -> origin/dev.garbage
 = [up-to-date]            dev.gcfe                -> origin/dev.gcfe
 = [up-to-date]            dev.inline              -> origin/dev.inline
 = [up-to-date]            dev.power64             -> origin/dev.power64
 = [up-to-date]            dev.ssa                 -> origin/dev.ssa
 = [up-to-date]            dev.tls                 -> origin/dev.tls
 = [up-to-date]            dev.typealias           -> origin/dev.typealias
 = [up-to-date]            release-branch.go1      -> origin/release-branch.go1
 = [up-to-date]            release-branch.go1.1    ->
origin/release-branch.go1.1
 = [up-to-date]            release-branch.go1.10   ->
origin/release-branch.go1.10
 = [up-to-date]            release-branch.go1.2    ->
origin/release-branch.go1.2
 = [up-to-date]            release-branch.go1.3    ->
origin/release-branch.go1.3
 = [up-to-date]            release-branch.go1.4    ->
origin/release-branch.go1.4
 = [up-to-date]            release-branch.go1.5    ->
origin/release-branch.go1.5
 = [up-to-date]            release-branch.go1.6    ->
origin/release-branch.go1.6
 = [up-to-date]            release-branch.go1.7    ->
origin/release-branch.go1.7
 = [up-to-date]            release-branch.go1.8    ->
origin/release-branch.go1.8
 = [up-to-date]            release-branch.go1.9    ->
origin/release-branch.go1.9
 = [up-to-date]            release-branch.r57      -> origin/release-branch.r57
 = [up-to-date]            release-branch.r58      -> origin/release-branch.r58
 = [up-to-date]            release-branch.r59      -> origin/release-branch.r59
 = [up-to-date]            release-branch.r60      -> origin/release-branch.r60

Indeed only if I repeat git fetch with 2.18.0.547.g1d89318c48 do I see
the update to origin/master:

From https://go.googlesource.com/go
 = [up-to-date]            dev.boringcrypto        -> origin/dev.boringcrypto
 = [up-to-date]            dev.boringcrypto.go1.10 ->
origin/dev.boringcrypto.go1.10
 = [up-to-date]            dev.boringcrypto.go1.8  ->
origin/dev.boringcrypto.go1.8
 = [up-to-date]            dev.boringcrypto.go1.9  ->
origin/dev.boringcrypto.go1.9
 = [up-to-date]            dev.cc                  -> origin/dev.cc
 = [up-to-date]            dev.debug               -> origin/dev.debug
 = [up-to-date]            dev.garbage             -> origin/dev.garbage
 = [up-to-date]            dev.gcfe                -> origin/dev.gcfe
 = [up-to-date]            dev.inline              -> origin/dev.inline
 = [up-to-date]            dev.power64             -> origin/dev.power64
 = [up-to-date]            dev.ssa                 -> origin/dev.ssa
 = [up-to-date]            dev.tls                 -> origin/dev.tls
 = [up-to-date]            dev.typealias           -> origin/dev.typealias
   479da24aac..dce644d95b  master                  -> origin/master
 = [up-to-date]            release-branch.go1      -> origin/release-branch.go1
 = [up-to-date]            release-branch.go1.1    ->
origin/release-branch.go1.1
 = [up-to-date]            release-branch.go1.10   ->
origin/release-branch.go1.10
 = [up-to-date]            release-branch.go1.2    ->
origin/release-branch.go1.2
 = [up-to-date]            release-branch.go1.3    ->
origin/release-branch.go1.3
 = [up-to-date]            release-branch.go1.4    ->
origin/release-branch.go1.4
 = [up-to-date]            release-branch.go1.5    ->
origin/release-branch.go1.5
 = [up-to-date]            release-branch.go1.6    ->
origin/release-branch.go1.6
 = [up-to-date]            release-branch.go1.7    ->
origin/release-branch.go1.7
 = [up-to-date]            release-branch.go1.8    ->
origin/release-branch.go1.8
 = [up-to-date]            release-branch.go1.9    ->
origin/release-branch.go1.9
 = [up-to-date]            release-branch.r57      -> origin/release-branch.r57
 = [up-to-date]            release-branch.r58      -> origin/release-branch.r58
 = [up-to-date]            release-branch.r59      -> origin/release-branch.r59
 = [up-to-date]            release-branch.r60      -> origin/release-branch.r60

Can someone help explain what's going on here?

Thanks,


Paul
