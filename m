Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B96CC64EC7
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 06:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbjBUGBi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 01:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjBUGBh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 01:01:37 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60AE23301
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 22:01:35 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id co23-20020a17090afe9700b002341fadc370so3627374pjb.1
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 22:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ouys6+zsHtWQejzbx/I2L4sPaq4lrTjLQs3tUHk0eK0=;
        b=C+e+jmJxCb2jrTdvoUGiZCSMzw+B25YP686Fzacd9Or8cSUpXv/FJDRSnTubAWkK8k
         DAjYNSJth7ZSgNKttQrI0FV0EqztUlz0Kb+0ICsS8jxezamyPenYt5SbuDjb2jRegsIW
         UDKwkG7nBrdaPBhIAJEfnEGtGQxZZyxjUnTms+d5IbGfGq773yvuJ1hYqNmmSbXE0Esw
         kRG8v1rxFYHZZpGWiBdmkzhfdS1hBbROnva0OLIw+1LzfnaSLbYc7O5T4CPCvUkXlze7
         ILXwv1Sp/R+jHE9GhFtY8ku/xKehREh7vADgFtaCuJDaAFofPO8otgdfxCHNypfXy+kl
         UWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ouys6+zsHtWQejzbx/I2L4sPaq4lrTjLQs3tUHk0eK0=;
        b=XM2EfSbGmadjMo2c6kAXxyPywSfH25tWPpSOSwQXsX2T96rGzRrdH5cKrplt3BDbUu
         zEsRapGLhQ2v00iQbaF23BpTZNcf6ZvBXw6j6VGcNY4KewBXd9JXeGFsvB3tAIv3QpU1
         W4xE7EHSE0d45Oato4s0mZp8Cqn+esz6aHoA19KFCWuuCouuHpynsG5/oVsx5eh8QRwQ
         sFsW2W/Stx5jiqLijyyk8ujPLk2ywpgXGWQYbwV5WypBLvwLVb/+E+Sl9roTOZmRa3BY
         aD535uukAaw4KiFBhnEfHURUtMyU6+WiVyeg7DxLSwQbMjc30BDVunlQORuYRVtGQlVg
         B+gg==
X-Gm-Message-State: AO0yUKVpYURBEg80/CO+fvRVZ6pLBWVPxDtkAL9ZfRSS6+C0oF7qSiRG
        OQ9E0M71RnBbOcB1fgMUj4Gx1i3B4Ws=
X-Google-Smtp-Source: AK7set/P46XH1fjqKAHpIVmF7Ga2f0yL6cUZBublXWBGUTcd4AFRmkJ/FdBI2EDKsgtB1JyfgSz2Ag==
X-Received: by 2002:a17:90b:3ec4:b0:234:721e:51e5 with SMTP id rm4-20020a17090b3ec400b00234721e51e5mr5601809pjb.10.1676959295021;
        Mon, 20 Feb 2023 22:01:35 -0800 (PST)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id mv14-20020a17090b198e00b002308e6e645bsm993905pjb.49.2023.02.20.22.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 22:01:34 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v2 1/4] rebase: document the --no-rebase-merges option
Date:   Mon, 20 Feb 2023 22:58:02 -0700
Message-Id: <20230221055805.210951-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 Documentation/git-rebase.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 9a295bcee4..c98784a0d2 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -529,13 +529,15 @@ See also INCOMPATIBLE OPTIONS below.
 
 -r::
 --rebase-merges[=(rebase-cousins|no-rebase-cousins)]::
+--no-rebase-merges::
 	By default, a rebase will simply drop merge commits from the todo
 	list, and put the rebased commits into a single, linear branch.
 	With `--rebase-merges`, the rebase will instead try to preserve
 	the branching structure within the commits that are to be rebased,
 	by recreating the merge commits. Any resolved merge conflicts or
 	manual amendments in these merge commits will have to be
-	resolved/re-applied manually.
+	resolved/re-applied manually. `--no-rebase-merges` can be used to
+	countermand a previous `--rebase-merges`.
 +
 By default, or when `no-rebase-cousins` was specified, commits which do not
 have `<upstream>` as direct ancestor will keep their original branch point,
-- 
2.39.2

