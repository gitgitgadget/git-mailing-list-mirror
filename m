Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64997207B3
	for <e@80x24.org>; Fri,  5 May 2017 23:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751662AbdEEXqv (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 19:46:51 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33155 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751370AbdEEXqu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 19:46:50 -0400
Received: by mail-pf0-f172.google.com with SMTP id q20so9062513pfg.0
        for <git@vger.kernel.org>; Fri, 05 May 2017 16:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ojwieKzIFpytvUJ09MY58dQoiVPsGK0d8kzxQW6UXVs=;
        b=dc9140XfJgRymNRbX3OJtc3rMBKgImwM5ZhIcqUTgl5ELGa0c+M69MkFFD32c8oWvq
         yjsaplJpkNFYWzh+MnqNr3r18og+x2c660Jyw/K8BDhYY3Pa39s6dEnNNvUurB2mVZTp
         2tgOn6FKRqiAkKuS9jv7eZyv445ioQdn8/VxmnkHlkAEyB5H0FkBfpNNvhYaT1bfqY5H
         RcJ0AfNAOI3Yself72xzkGiQm0poLfcfa9zocbBZMVKXwoqvROLyy4hhgfe1t/h+p3kI
         MxSS3RiyriBOrjtp08OVDJeZajThXEd/e+iBNnfzIWQXyzSeXe1VzAZp/LFXyCtBzytC
         nQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ojwieKzIFpytvUJ09MY58dQoiVPsGK0d8kzxQW6UXVs=;
        b=HXgEZ8AQcC20fExOaVq+JeHVkUQMgOGx33J5F6OwcpBwI/nY1aHUdoq9kPiwnNlay+
         s/rnADCYebsO/85eUZxK6cuwypSGs0aAJ4AHbeT9UKfrr/Y69pcI8gckMqCatFiBGGe6
         mFdvJumBRLCjhiprzaTRvtw5oPkk352kMdZ/2mUBQr00tv2QoQ0Fn2nFfw8/k9jmOwqk
         /EtCuLCSLvJeftBdkyNuREF6iaumPB6EdNd2qYtU3tRgN4S9OlutpxX7kQ/vnPVaJl7o
         /i0fPyWuVJVwMtJDSG7fXcCJ54bvHKv+WJB/Z4mbTUyBIiJabuIJ9FhC6TR5qsWV3U5W
         l9LA==
X-Gm-Message-State: AN3rC/49LHAbW+o/10K53Y1zsPSvT/q5iPrq1JEX542WrKyDAMhGbpF+
        lg0dwRbzkIip056X
X-Received: by 10.99.123.81 with SMTP id k17mr6354297pgn.125.1494028009483;
        Fri, 05 May 2017 16:46:49 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id c77sm11096576pfe.37.2017.05.05.16.46.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 May 2017 16:46:48 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sbeller@google.com
Subject: [PATCH 0/3] Clarify interaction between signed pushes and push options
Date:   Fri,  5 May 2017 16:46:41 -0700
Message-Id: <cover.1494027001.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We noticed this when trying to use Git to make a signed push with push
options to a server using JGit (which rejects such pushes because the
Git client makes requests that are, strictly speaking, incompatible with
the documented protocol).

There have been several commits (see the commits linked in the commit
messages of the patches sent in reply to this e-mail) to support push
options (that are read by receive hooks) when using "git push", but the
interaction between push options and signed pushes are not very clear.
Here are some patches (containing both code and documentation) that
clarify this interaction.

I would appreciate a review of this - if we could make the protocol
clear, we could then update JGit to use the updated protocol and be no
longer incompatible with existing Git clients.

Jonathan Tan (3):
  docs: correct receive.advertisePushOptions default
  receive-pack: verify push options in cert
  protocol docs: explain receive-pack push options

 Documentation/config.txt                  |  5 ++--
 Documentation/git-receive-pack.txt        | 10 +++++++
 Documentation/technical/pack-protocol.txt | 32 ++++++++++++++++----
 builtin/receive-pack.c                    | 49 ++++++++++++++++++++++++++++---
 t/t5534-push-signed.sh                    | 15 ++++++++++
 5 files changed, 98 insertions(+), 13 deletions(-)

-- 
2.13.0.rc1.294.g07d810a77f-goog

