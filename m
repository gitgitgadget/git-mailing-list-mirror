Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE3CC3DA78
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 10:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbjAQKg7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 05:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235749AbjAQKgb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 05:36:31 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC0E1F4B7
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 02:32:51 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so1183336wmq.0
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 02:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pby697VC3tNO4iP01+zFOV/73CUMRG2kLfiV0kkAMCk=;
        b=hMns8nmHtpOg3CfGVXxHWBUOejvgiQj6dhnR9GQ+1xtO8yjDBPPBeiDwXEcLAhJff+
         x2KZA4wFHzSWvAMXUKBwmJsjXZkVgoSLuhH2DJVWUYKqHqiD4ieSV3nMKdoZeXrCv0Ut
         +Hp8BQPs4oM44oM0v2fs/GtxU+V4VeBwG5j0IIX5PuvcaU29iPMfiMEsIVqotGh5pX9c
         36Xwh0Bz3JGKg4Za6QJjS/7IP3SwldzbkYsyJJAA1OxGkGCBYy5eNSDowne6RE7Eb2fc
         58ratWDgWlT9OgXYofhVn6YWR1v5+LsLbXfbhwfeRbAdyveTXdUGRwlzvQMO8RNFaO3h
         qq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pby697VC3tNO4iP01+zFOV/73CUMRG2kLfiV0kkAMCk=;
        b=a49E87r8OvEJb82D6BpoY+2LFhfDEjEltXL+dPkPqCYHvduNl1wh5EHTfnXIdfnHF9
         icTeEO+8cxxKS7sfBNfcKtows+vxUSVRvOvEfz0XgIdIaGPSKcT95hUohq/Lvmis/VW/
         H+No4DyDqCdo0wmRYTo7ESNBjrwyblZL3WRIcSGMt0lBnFd6KDlfbhw5gYesZb42RHrs
         rV/LUxhyrV3KcLfgMc9WIXboTu5DsnGu9LZEcgRJ5GVjIsW5Cm7p623uwpgnaT1uqm3j
         ZxIrbkIquDhNIgO4EGUVirQ2E3xqoz0/28ipu4nazk1OsACmU3ANFmaankMSdZZcCc6g
         yLEA==
X-Gm-Message-State: AFqh2koOa2MTcyofEzzJBK0KX15szg1CzUBrdc5NnjuDPTNovOuO26kK
        1c7Mjm6TbKLlzi5Ug50PMxWx8+Tcnio=
X-Google-Smtp-Source: AMrXdXtG49jGfu/+Yp82HCvG1NuvO+L7U+mHXfdV8CI4Sm+zT8LFsAjr8HzNA6L1YH1mnkHzZkkXGw==
X-Received: by 2002:a1c:7315:0:b0:3d3:5a4a:9101 with SMTP id d21-20020a1c7315000000b003d35a4a9101mr11267279wmb.23.1673951563131;
        Tue, 17 Jan 2023 02:32:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m5-20020a05600c3b0500b003c6b7f5567csm18057497wms.0.2023.01.17.02.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 02:32:42 -0800 (PST)
Message-Id: <pull.1465.git.1673951562.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Jan 2023 10:32:39 +0000
Subject: [PATCH 0/2] [RFC] push: allow delete one level ref
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This might be an odd request: allow git push to delete one level refs like
"ref/foo".

Some users on my side often push "refs/for/master" to the remote for code
review, but due to a user's typo, "refs/master" is pushed to the remote.

Pushing a one level ref like "refs/foo" should not have been successful, but
since my server side directly updated the ref during the proc-receive-hook
phase of git receive-pack, "refs/foo" was mistakenly left at on the server.

But for some reasons, users cannot delete this special branch through "git
push -d".

First, I executed git update-ref --stdin inside my proc-receive-hook to
delete the branch. As a result, update-ref reported an error: "cannot lock
ref 'refs/foo': reference already exists".

So I tried GIT_TRACKET_PACKET to debug and found that git push did not seem
to pass the correct ref old-oid, which is why update-ref reported an error.

"18:13:41.214872 pkt-line.c:80           packet: receive-pack< 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 refs/foo\0 report-status-v2 side-band-64k object-format=sha1 agent=git/2.39.0.227.g262c45b6a1"


Tracing it back, the check_ref() in the git push link didn't record the
old-oid for the remote "refs/foo".

At the same time, the server update() process will reject the one level ref
by default and return a "funny refname" error.

It is worth mentioning that since I deleted the branch, the error message
returned here is "refusing to create funny ref 'refs/foo' remotely", which
is also worth fixing.

So this patch series do:

v1.

 1. fix funny refname error message from "create" to "update".
 2. let server allow delete one level ref.
 3. let client pass correct one level ref old-oid.

ZheNing Hu (2):
  receive-pack: fix funny ref error messsage
  [RFC] push: allow delete one level ref

 builtin/receive-pack.c |  7 +++++--
 connect.c              |  2 +-
 t/t5516-fetch-push.sh  | 18 ++++++++++++++++++
 3 files changed, 24 insertions(+), 3 deletions(-)


base-commit: a38d39a4c50d1275833aba54c4dbdfce9e2e9ca1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1465%2Fadlternative%2Fzh%2Fdelete-one-level-ref-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1465/adlternative/zh/delete-one-level-ref-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1465
-- 
gitgitgadget
