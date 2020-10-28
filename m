Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CBCC55179
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 22:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FCBB2470E
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 22:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="puoEjGKo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbgJ1WFV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729998AbgJ1WFU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 18:05:20 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F36C0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 15:05:18 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id s15so1050718ejf.8
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 15:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=fyyzF9QO7362gnUst88q2O80dJLvRiNc26f3hS6gMSs=;
        b=puoEjGKoZ4OCX361WD1Z0btF4716iV2p/0KZC/wekcUDD5CXYAhAuWb6HffSQcYPDI
         WIl0ksUxPCPGwDYN50xPJidLTNbIqYET0Xzz519cxIT8aHEc8tLIUhptDWxtPRCvKQnf
         26yLcUBpPHA6vkmNNnd9rVBqU6gOrT/8+1x2wD6T5KgOPiya/30hNKE/eNNkDRhG6cAl
         PXI5yC0n9tOHCan6iL/DU8yKd8Vdldg6G0NPhJNrPUmAOxzg7srZHrEHb+V5LEtiNsIh
         9TT3H7lZSWDUuBcwDfuISxNbq7mdYQE28ztMaruFKmCt+iKciKs9EKi3hYr1xW6ZtFrY
         RuQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fyyzF9QO7362gnUst88q2O80dJLvRiNc26f3hS6gMSs=;
        b=kRmjJgTnQi7Kbbotw6GYo4aBGZNuO/NoYAAN9zJGXxwCcT9ZYNmw+n+xszE1orDIPY
         Q2ZVwLju0XPFbVrqqtbmYALkDFaQ7IWz9qE7cUusdt8OAQjjOeAazXqTm79J7PAxJ4JG
         3OlgcO5T+QccQxt1oixB29R4xsRrAv0QfTxQ+AxjaiunYUqtk1hCbG+QnZSCfljK7Sht
         obEHvHQV19r7JPkiOfCy8aE+GwY2KpJxsV3HvRM70sldp2+R+rlMVRjQ5kVgpSyYP0tP
         7CzpAXJ1FweNRCY12jk584bMqcJF+u4Pl8EaRKQbuiVeRGSnAqQogHRcjIEM8PReIElN
         XRag==
X-Gm-Message-State: AOAM533Pm43ZE79G2UIl4Clt+1MQrSo+w3Zb9lJb0B9Z8K+RKnAfzymj
        7dCQRU0J4aGTMP/Jd/q/hyOj+vWUggk=
X-Google-Smtp-Source: ABdhPJzgbZ0o8Oon8+DCpsGA76Pq0/4zH/mDflYFcubq9LZE6lG1iLW8SmPn509RmY0nsUtG3LYVLA==
X-Received: by 2002:a5d:640c:: with SMTP id z12mr8555909wru.31.1603889272072;
        Wed, 28 Oct 2020 05:47:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s202sm4309196wme.39.2020.10.28.05.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 05:47:51 -0700 (PDT)
Message-Id: <pull.774.git.1603889270.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 28 Oct 2020 12:47:44 +0000
Subject: [PATCH 0/6] blame: enable funcname blaming with userdiff driver
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Thomas Rast <tr@thomasrast.ch>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes a bug in git blame where any userdiff driver configured
via the attributes mechanism is ignored, which more often than not means
thatgit blame -L :<funcname> dies for paths that have a configured userdiff
driver. That's patch 6/6. 

Patches 1-5 are documentation improvements around the line-log
functionality.

Notes (I can't add in-patch commentaries using GitGitGadget (yet, I hope 1
[https://github.com/gitgitgadget/gitgitgadget/issues/173]), so I'm providing
what would have been an in-patch commentary on patch 6 below):

 * In patch 6, I considered fixing that bug in a different way by
   initializing sb.path inside blame.c::setup_scoreboard. This function
   already receives path as its second argument, so changing that would not
   impact the API. Probably Thomas thought that sb.path was already
   initialized in sb when he modified builtin/blame.c::prepare_blame_range 
   to also send sb.path to line-range.c::parse_range_arg in 13b8f68c1f (log
   -L: :pattern:file syntax to find by funcname, 2013-03-28). 
   
   Initializing the path in setup_scoreboard would mean we could also
   simplify the API of blame.c::setup_blame_bloom_data since it would not
   need to receive path separately and so its second argument could be
   removed. I went for the simpler alternative of just sending path to 
   parse_range_arg instead of sb.path since it felt simpler, but if we feel
   it would be better to actually initialize sb.path in setup_scoreboard,
   I'll gladly tweak that for v2.
   
   
 * The fact that this bug has been present ever since git blame learned -L
   :<funcname> makes me a little sad. I think that the fact that the diff 
   attribute (either with a builtin userdiff pattern or with 
   diff.*.xfuncname ) influences way more than just the hunk header, but
   also features like git log -L, git blame -L, and the different options
   that I mention in patch 4/6, is not well-known enough. I'm not saying the
   code or the doc is wrong, but I think it's a visibility issue. Maybe more
   blog posts about that would help.... I noticed that the "Git Attributes"
   chapter in the ProGit book 2
   [https://git-scm.com/book/en/v2/Customizing-Git-Git-Attributes] does not
   even mention the builtin userdiff patterns, so I'll probably do a PR
   there to mention it. Any other ideas for improving discoverability of
   this very cool feature ?

Philippe Blain (6):
  doc: log, gitk: move '-L' description to 'line-range-options.txt'
  doc: line-range: improve formatting
  blame-options.txt: also mention 'funcname' in '-L' description
  doc: add more pointers to gitattributes(5) for userdiff
  line-log: mention both modes in 'blame' and 'log' short help
  blame: enable funcname blaming with userdiff driver

 Documentation/blame-options.txt      |  9 +++++----
 Documentation/diff-options.txt       |  5 ++++-
 Documentation/git-grep.txt           |  6 ++++--
 Documentation/git-log.txt            | 16 ++--------------
 Documentation/gitk.txt               | 21 ++-------------------
 Documentation/line-range-format.txt  | 28 +++++++++++++++-------------
 Documentation/line-range-options.txt | 27 +++++++++++++++++++++++++++
 builtin/blame.c                      |  5 +++--
 builtin/log.c                        |  4 ++--
 t/annotate-tests.sh                  | 18 ++++++++++++++++++
 10 files changed, 82 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/line-range-options.txt


base-commit: 1d1c4a875900d69c7f0a31e44c3e370dc80ab1ce
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-774%2Fphil-blain%2Fblame-funcname-userdiff-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-774/phil-blain/blame-funcname-userdiff-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/774
-- 
gitgitgadget
