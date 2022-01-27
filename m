Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395B0C433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 01:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbiA0Btz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 20:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiA0Bto (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 20:49:44 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EE8C06173B
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 17:49:43 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id r2-20020a1c2b02000000b0034f7b261169so929491wmr.2
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 17:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PsHc5miY2TT2agThBOzmhPdYa4k13ksMto/NIv8nLxg=;
        b=eZVik0za4/0N++gI+lhvX1nQDqhkWRs8jEVZXQuX9OiNTlCQJXjpNrgo/737PnShwN
         cet6DH53YT0NmkjlavTXObOne6fvl24C2InaENWaIlqxVSbXVasQ2hPUvMuMWbSqSOiJ
         6hG6ADkbdDVo4kRN7p2jSl28FVEDWQefM7JMfVt8duefkYTuQC7Eimw2wIiQYWG6QXIV
         mqgayYw/RvgUHHM4FtMiXwXjaNgQSeAtFb4J3+zyfxpAwrtfB7EsNBQEuiZVw+Svtv7t
         uFD/s6MhsybZBSFqV/4Nbo6O6NeTa/Y1v7jTmODs1xD6cEe7WiQ31n4V040VdN8F9YAu
         RVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PsHc5miY2TT2agThBOzmhPdYa4k13ksMto/NIv8nLxg=;
        b=nF1ITudSeuXu5uVttuHLy/XMtBpruntMndB+hhAiGYeff/hrRhIcNtoQIdAwYEJhzY
         0t7Kkzv5O49vaBZsNu9BQOVCBx4T9ek/i084Ma1kutdwtKhwLTapFUCFuqosgpR8fMcR
         vLrz1zkcFlqanlUVlHmYgw50o0EwY+05sUovrFTgSkgESvOunbnPoIl0k8yCN+PqiUzw
         4Qoj9wmmA+LN9W5q6yE7H5zNU0IXhEEXEwqpi01OoT8rPO4msm+7o3y1v8oUA9qm0B8h
         q6XDyWOBvNBjEzdp7zbSqg4Qr3kRKmOmjPIyvOF8UqYJfnXKCclTTcH0+p0MOBBzRMZV
         8gew==
X-Gm-Message-State: AOAM530Oad56P19M42EGgir+0Lj4/l5RIqzDBCvuH/7NEDe6eaNM+qet
        3QImpHSv4Mb5zYBaJ1pxZoJ4AWEhB14=
X-Google-Smtp-Source: ABdhPJx/cVxpK2B6AupWRr4uh1WDEcjyvaQeFtk8teYWOyYeBX++KclRy08amPPoXnj1Tq+FWcp1ew==
X-Received: by 2002:a7b:cbd2:: with SMTP id n18mr1180315wmi.189.1643248182242;
        Wed, 26 Jan 2022 17:49:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m6sm927342wrw.54.2022.01.26.17.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 17:49:41 -0800 (PST)
Message-Id: <0eec9b117dad5e3cfddf8a17ea74af9a4e23e102.1643248180.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1206.git.git.1643248180.gitgitgadget@gmail.com>
References: <pull.1206.git.git.1643248180.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 Jan 2022 01:49:39 +0000
Subject: [PATCH 1/2] pack-objects: allow --filter without --stdout
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

9535ce7 taught pack-objects to use filtering, but added a requirement of
the --stdout since a partial clone mechanism was not yet in place to
handle missing objects. Since then, changes like 9e27beaa and others
added support to dynamically fetch objects that were missing.

Remove the --stdout requirement so that in the next commit, repack can
pass --filter to pack-objects to omit certain objects from the packfile.

Based-on-patch-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: John Cai <johncai86@gmail.com>
---
 builtin/pack-objects.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ba2006f2212..2d1ecb18784 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4075,8 +4075,6 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		unpack_unreachable_expiration = 0;
 
 	if (filter_options.choice) {
-		if (!pack_to_stdout)
-			die(_("cannot use --filter without --stdout"));
 		if (stdin_packs)
 			die(_("cannot use --filter with --stdin-packs"));
 	}
-- 
gitgitgadget

