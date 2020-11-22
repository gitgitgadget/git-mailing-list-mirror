Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02145C5519F
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 23:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A670C20771
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 23:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vYyPdUGe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbgKVXXa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Nov 2020 18:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgKVXXa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Nov 2020 18:23:30 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0802C0613CF
        for <git@vger.kernel.org>; Sun, 22 Nov 2020 15:23:29 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id p8so16904918wrx.5
        for <git@vger.kernel.org>; Sun, 22 Nov 2020 15:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=RHE5dPuIA0a+X2qj41vwONYQHxfi99b+2wuNEvoqdu0=;
        b=vYyPdUGejyh2rwPUXVD/Dmu3ADJglTaFsn2zIJkyemsK7wzl3Toz4/0ukf9F0Ue3z+
         LvE6IUm8RPdYKXv7+unz6DSp5tM7ikHZFIWt8mgROeCq4Icdv2XQ+Cw6r7/PxCFIl+C+
         gh54by5nT4LxbsyTAMO68Gb5PJ3Dv39TM4a396Sst+/IQ83atHenxzt6+yiJo6gLiSSr
         BRhWcRyQG0T0PGNR+tYgq8v8oS2OieQpsM6U1xyKgZriuOdbXV1piKh1WAmp2oQ9E4Ip
         7K9ws1sso5BB2FdS9ivCds6GexaJJiKYhUEgKuxluvCXbIA8uoQIQCx0v1EqiKz1o1YL
         eKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RHE5dPuIA0a+X2qj41vwONYQHxfi99b+2wuNEvoqdu0=;
        b=R9xFBTYJhaDORNkaEw+g85KQRH6ZmscMgNK/mD23+ZdfR51gl4RzuU+zzN3pRv9UtD
         Yuwyjnj8NrBq8xYFSaZBEFlmLcgfnexNo6U7kv0BEI20p1jzQY3EanKKgkWUCfg+6R5t
         6ofnX/4uYak2c3MKuT6pJjRCAye6otGl9CXeGm3+cB5qHtkVsMM19QmuK4o0LY4n4QzR
         uGhMY4h6vKVkuBypB35/64BBVorWzO7Q3b5wSnWn6U/wgDGApJR65336f/P850WNptXy
         ei8+DuCsjwYqvZjzaIaudUVmgAVzyEWlJz9xYShsDrvSIKfAtF99A9P94Y2S1udpYH6X
         uybA==
X-Gm-Message-State: AOAM530FBP7bgQ8MEjEkZddtzAqPOvywRqrVNnxzIxpBYT4RJrrAiffp
        xmC+jxnHNnqDTjmRU9e02mCIgQCXFxo=
X-Google-Smtp-Source: ABdhPJwrn1VBohr75Ied0MRWud4h8Jf0KrFX4URl75WwXGs8FwOJ6lJFkPpxiVpl5X3e8Lo6izUzYA==
X-Received: by 2002:a5d:510d:: with SMTP id s13mr3003582wrt.380.1606087408208;
        Sun, 22 Nov 2020 15:23:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f19sm12912868wml.21.2020.11.22.15.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 15:23:27 -0800 (PST)
Message-Id: <pull.921.git.git.1606087406.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 22 Nov 2020 23:23:23 +0000
Subject: [PATCH 0/3] Add helpful advice about init.defaultBranch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is our designated intention
[https://sfconservancy.org/news/2020/jun/23/gitbranchname/] to "to explore
changing the name of the first branch created automatically for new
repositories away from ‘master’". Further, we promised that we "will
minimize disruption for Git's users and will include appropriate deprecation
periods".

To that end, introduce a message giving advice to users running git init 
that the fall-back for init.defaultBranch is subject to change, and how to
configure it.

The beauty of this patch series, if I may say so, is that it does not commit
us to any concrete plan, but opens the door for all options regarding the
default branch name.

Johannes Schindelin (3):
  init: document `init.defaultBranch` better
  get_default_branch_name(): prepare for showing some advice
  init: provide useful advice about init.defaultBranch

 Documentation/git-init.txt    | 11 +++++++----
 builtin/clone.c               |  2 +-
 builtin/init-db.c             |  8 +++++---
 refs.c                        | 19 +++++++++++++++----
 refs.h                        |  4 ++--
 remote.c                      |  5 +++--
 t/t0001-init.sh               |  9 ++++++++-
 t/t1510-repo-setup.sh         |  2 +-
 t/t7414-submodule-mistakes.sh |  2 +-
 t/test-lib-functions.sh       |  3 ++-
 10 files changed, 45 insertions(+), 20 deletions(-)


base-commit: faefdd61ec7c7f6f3c8c9907891465ac9a2a1475
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-921%2Fdscho%2Finit.defaultBranch-advice-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-921/dscho/init.defaultBranch-advice-v1
Pull-Request: https://github.com/git/git/pull/921
-- 
gitgitgadget
