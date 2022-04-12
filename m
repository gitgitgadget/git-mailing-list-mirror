Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF6CC433EF
	for <git@archiver.kernel.org>; Tue, 12 Apr 2022 19:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349368AbiDLTUH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Apr 2022 15:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240129AbiDLTUG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Apr 2022 15:20:06 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9B036B7C
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 12:17:47 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id p189so12533814wmp.3
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 12:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+zzQlCN88BdoKrMe//mDz2BhoxVYmEAIxUFuEcjApQs=;
        b=ev3TQhKNWkJwaSKmHG+TaQ0DfIMix9mXpX4QcQ0QfyCfNg2IU0Fz7upCClSXwMlLUe
         bdsfQbJmZl1CuFAH0aPSZ16j5umbRnClBaYI/B/vBdXr69R99WgxrzI1lNA9mZQFA1lj
         EwOED0PhyGAA1PoBE//aJG7+4ls+dlSNx6DU+tAyjY4UNaKZNj5qnY19tzBLX4cy/akU
         nmbkWmeXXOmC5nbab5ugd1JKbksYtLWna7AlrFCzg+ZX/70onjDvhsuPVhREytNepqrr
         p1iU26whzRCkbBwzYPco4kjKmOkLGawfMzjBjYBh5OzQEuC9xcw0b9USkmbb1b6hhahn
         cWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+zzQlCN88BdoKrMe//mDz2BhoxVYmEAIxUFuEcjApQs=;
        b=l54AejwdmUvxpKWWA5TVc27cTaMNH0btL7KHgciq0QsSO2MeSatjgY6UGr6+AbOJIm
         PBtajle1aFT58ZYtxCmUaz54WkeKZjSFpakQZThXhNlxwOo1S3/wpUIKd9EE0586WGO4
         WzBQTMkN3NMUI00yGEq9EIbi1x5bWdm1ReK0PHrJz1X05UttCrZqespZdp3IsnN+1prN
         OqsCS9+gI8uNA4cktwg8oDlrhBtuj/aAja+ZnrdES6Pw/WwpvFVRy3w03FI1UpfzoXDk
         cZ3Ooxf241xDLc2QxMNMFQs0/AcktzDeoqyY131YKrlQIo6jBf+zlBEmYu6yiB2dMmVZ
         vkLg==
X-Gm-Message-State: AOAM530aBfRKneeeKO1swRWaSJjaVFNJ8zrNpMpGonZEzHc4gMFEDL2b
        CTCtkP3AZutAM7BhCuAU3Ow=
X-Google-Smtp-Source: ABdhPJzSXJOCULkuuJvDkKwjvSaF3JXDMxJbxgaHiM5oQAcwKx1Ejdzf1aKIZDIewwcwE1DLpKtdUw==
X-Received: by 2002:a05:600c:c8:b0:38e:cff5:4cf6 with SMTP id u8-20020a05600c00c800b0038ecff54cf6mr2401952wmm.162.1649791066035;
        Tue, 12 Apr 2022 12:17:46 -0700 (PDT)
Received: from localhost.localdomain (123.79.195.77.rev.sfr.net. [77.195.79.123])
        by smtp.gmail.com with ESMTPSA id az30-20020a05600c601e00b0038ebd950caesm289223wmb.30.2022.04.12.12.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 12:17:44 -0700 (PDT)
From:   Jonathan <git.jonathan.bressat@gmail.com>
X-Google-Original-From: Jonathan <Jonathan.bressat@etu.univ-lyon1.fr>
To:     cogoni.guillaume@gmail.com
Cc:     Matthieu.Moy@univ-lyon1.fr, git.jonathan.bressat@gmail.com,
        git@vger.kernel.org, guillaume.cogoni@gmail.com,
        Jonathan <Jonathan.bressat@etu.univ-lyon1.fr>
Subject: [PATCH 0/1] Be nicer to the user on tracked/untracked merge conflicts
Date:   Tue, 12 Apr 2022 21:15:55 +0200
Message-Id: <20220412191556.21135-1-Jonathan.bressat@etu.univ-lyon1.fr>
X-Mailer: git-send-email 2.35.1.7.gc8609858e0.dirty
In-Reply-To: <CAA0Qn1sBF=PAduCQCXbYkeu4cphw7O+AnvwFNMWijuKYskaT8g@mail.gmail.com>
References: <CAA0Qn1sBF=PAduCQCXbYkeu4cphw7O+AnvwFNMWijuKYskaT8g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When doing a merge while there is untracked files with the same name
as merged files, git refuses to proceed. This patch make git overwrite
files if their content are the same.

We added a statement to check_ok_to_remove() (unpack-trees.c) 
with ie_modified() (read-cache.c) to test if the untracked file 
has the same content as the merged one. It seems to work well 
with all three o->result, o->dst_index and o->src_index,
We are not sure of what is the usage of those three, did we used it
properly?

Our tests need some improvement, for example using test_commit,
and testing more possibilities, it's not a real patch, just 
to comfirm if we are on the right track.

The next idea is when it's a fastforward, attempt to merge the
untracked file and the upstream version (like if the file had
just been committed, but without introducing an extra commit).

you can see this idea here: 
https://git.wiki.kernel.org/index.php/SmallProjectsIdeas#Be_nicer_to_the_user_on_tracked.2Funtracked_merge_conflicts

Questions:
The old behaviour was here for technical reasons?
The new behavior that we introduce here become the default one?
If the old behavior was important for some people or for some reasons,
we can set a global variable to switch between the old and the new one.
And if we define a global variable, should we print a warning to let 
users know that there is a new behavior when a merge is called and that
he can switch between the old and new one.
For some reason, test_commit make the merge not working like if it's the
old behaviour of merge, I dont understand why ?

Jonathan (1):
  Merge with untracked file that are the same without failure and test

 t/t7615-merge-untracked.sh | 79 ++++++++++++++++++++++++++++++++++++++
 unpack-trees.c             |  4 ++
 2 files changed, 83 insertions(+)
 create mode 100755 t/t7615-merge-untracked.sh

-- 
2.35.1.7.gc8609858e0.dirty

