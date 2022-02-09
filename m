Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A03EC43219
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 02:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344359AbiBIClO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 21:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244497AbiBICKL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 21:10:11 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8BCC0613CC
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 18:10:10 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id v12so1504700wrv.2
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 18:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PsHc5miY2TT2agThBOzmhPdYa4k13ksMto/NIv8nLxg=;
        b=O9V3xITzPHt5HK8bBHTIMTaWMcmPP4hwt4j4XYwW8CWxw71CnKAwk/4JHSBXw/jQmU
         xjfZLIu2Sy24PgFyWsVvb65gH0jVQ2RPJ4+AuOZG4iq8vDSWpPEZwED06Ro9nPQj8UNI
         r0F2gu7j9DVtaWjTNbpBnxGu/997JoXW3MyJjQZ7wZbmPl/fXjZr2X2qAC9KD4df6HHk
         VFKesxpx8RBYH3YcJBO66TfdsV5bl32rndqoLBmU9AwtJZf2P/hW7yFx8/Aur9vDDVpi
         leHxda4mJ7TXpZIyizNl9PfwxlWYjU5k/3JhmLuktS8O1gPc9LW1Nk9m4g2m1xHqUUIw
         6mWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PsHc5miY2TT2agThBOzmhPdYa4k13ksMto/NIv8nLxg=;
        b=vxuSl1SFpgxSV9STyB17hmEpg7TFVnixvgBe4wm2mhzwhSyaZO5k3xVBrJttVrXcb6
         yVIpJ/r8JHBH4Q4fb11KONT6y/UlwNDGcEsqP6/mG7O73tatCcXj3fut5xq86EWEdREQ
         I+z9bDQEg/yGzcCeHX2WyaKK1IK3DdZkQFy5pde9WkROAHfqQgPsXfudY0ioIN6AeUd9
         A2czuFtwSb81cdAE6pIAhwjXhOTO7xVuyW+eUgKQFi7HgQmrlxuQWv7QwGbSWzwwh9RE
         XzUH/oVTBGsCrXu00RoSUlRaZpxrQjj+nXCm5NvpyXUCyvtsKdQ5BeMrRnSYEmoG3swC
         GjgQ==
X-Gm-Message-State: AOAM530Xv3Ytd+lAShx/M/neNlPXDWN9HnXvbKRtXI97ZbDXBMy8WOXU
        QShjHbZd5jEJyy/rknCZKKte+1RWhkM=
X-Google-Smtp-Source: ABdhPJxerubYoo+DsgQPFBJUkOq/Q516jNDzMLvpyv42z21aW6upt3csnJOsyhyTyLeY/rVKpOoB/g==
X-Received: by 2002:a5d:64e5:: with SMTP id g5mr170378wri.541.1644372608781;
        Tue, 08 Feb 2022 18:10:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id az16sm3483046wmb.15.2022.02.08.18.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 18:10:08 -0800 (PST)
Message-Id: <f43b76ca650b626751880db373982d30f5d8e15d.1644372606.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1206.v2.git.git.1644372606.gitgitgadget@gmail.com>
References: <pull.1206.git.git.1643248180.gitgitgadget@gmail.com>
        <pull.1206.v2.git.git.1644372606.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Feb 2022 02:10:03 +0000
Subject: [PATCH v2 1/4] pack-objects: allow --filter without --stdout
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
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

