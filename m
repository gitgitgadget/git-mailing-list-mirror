Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43757C43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 11:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155FB21582
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 11:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gy5PVzPQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfLRL0I (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 06:26:08 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40854 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfLRL0I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 06:26:08 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so1871751wrn.7
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 03:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=au2HVdG34UXqJ67JVTDVUwy6iuN/ns4k110mWzroCBI=;
        b=gy5PVzPQwpeGacthFfSpupU9hL+etCVLp5Dw+MqjPkXNKq7vHfwbRkfGfIVlBA6xlT
         WjRbstXQyjaC4ef9h8GuQon1wkX3aGXKO7lzWgM0EjaEFKjqNtIu6aH/u3bhj2qttXp2
         TdKmodz9Fsgo2NFnCDmmzOIFYSEl7FzDdqocojil4F81XCl8k4Vvq6jYUthAlHSCA9z5
         SMrbVtzNhGQ7QBo+/zwnbAkj8sv5IjexLZ1bw9ibgXTDAEf0uW2CkiQzk3dmcgJ8mE9f
         8ZcNE4bgvGyV+P4C34kv20RHb2PyuJ2dL4Ux4QYzTutwapTpKzfNno6amSusqNzgqZGn
         RlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=au2HVdG34UXqJ67JVTDVUwy6iuN/ns4k110mWzroCBI=;
        b=PitvTcmzAMc4Jx6cccQOWE09F4Sotuf92h5xDjkBABuuTJAU53N2GcGTBwdKR6rmT6
         xQQcpy6pDRnH5LQqPCqVaUTZ+yEQPJqI4yd0PyRK4UzxJd8ICbvmJwrIE/i6w5+YmJl6
         oRtFuV3YIGMuXDNy9hGDWISZw+vky9sdV+5nE+eyprNU5PF8Wz9JnHesksEn5x0xyp3B
         NuFNeb+23Tkts/6DCx4z32zMFXTnpqhzgcXuHj7SSEDm486KamxoHlaa+0FNTLvZ61NX
         t/NVX+vBjIpDuA8i5YrzHfyn9Oy2Gq5zrs1+FfhNqCQ5KEGiqvfCOwN8c2XK4cxFpfpS
         TSfg==
X-Gm-Message-State: APjAAAW//A0SWNvHdLiLByUQdo6YL/7fsiAFChsvImP4nWxx9FrMJw4f
        qJW0+q75MoUuTUBl7/ICHK4KMTRP
X-Google-Smtp-Source: APXvYqzT37SXwJPsU7OCRP8Ormr7aJA8e9w62bemV0dz1KCfyOLQLd3oMiKqPu9kBxkfGlLnrDmq9Q==
X-Received: by 2002:a05:6000:1052:: with SMTP id c18mr2258310wrx.268.1576668366406;
        Wed, 18 Dec 2019 03:26:06 -0800 (PST)
Received: from localhost.localdomain ([2a04:cec0:116b:f417:15eb:66f2:c98d:a463])
        by smtp.gmail.com with ESMTPSA id f127sm1204647wma.4.2019.12.18.03.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 03:26:05 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v4 00/12] Rewrite packfile reuse code
Date:   Wed, 18 Dec 2019 12:25:35 +0100
Message-Id: <20191218112547.4974-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.24.1.498.g561400140f
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series is rewriting the code that tries to reuse existing
packfiles.

The code in this patch series was written by GitHub, and Peff nicely
provided it in the following discussion:

https://public-inbox.org/git/3E56B0FD-EBE8-4057-A93A-16EBB09FBCE0@jramsay.com.au/

The first versions of this patch series were also discussed:

v3: https://public-inbox.org/git/20191115141541.11149-1-chriscool@tuxfamily.org/
V2: https://public-inbox.org/git/20191019103531.23274-1-chriscool@tuxfamily.org/
V1: https://public-inbox.org/git/20190913130226.7449-1-chriscool@tuxfamily.org/

Thanks to the reviewers!

According to Peff this new code is a lot smarter than what it
replaces. It allows "holes" in the chunks of packfile to be reused,
and skips over them. It rewrites OFS_DELTA offsets as it goes to
account for the holes. So it's basically a linear walk over the
packfile, but with the important distinction that we don't add those
objects to the object_entry array, which makes them very lightweight
(especially in memory use, but they also aren't considered bases for
finding new deltas, etc). It seems like a good compromise between the
cost to serve a clone and the quality of the resulting packfile.

This series has been rebased onto current master ad05a3d8e5 (The fifth
batch, 2019-12-10).

Other changes since the previous patch series have all been suggested
by Peff. Thanks to him! They are the following:

  - Add note in commit message of patch 3/12.

  - Move previous patch 4/9 to patch 12/12 at the end of the series to
    avoid test failures.

  - Add new patches 5/12 and 6/12.

  - Improve commit message and documentation of pack.allowPackReuse in
    patch 8/12.

  - Improve commit message of patch 10/12.

  - Extract patch 11/12 from patch 10/12.

Jeff King (12):
  builtin/pack-objects: report reused packfile objects
  packfile: expose get_delta_base()
  ewah/bitmap: introduce bitmap_word_alloc()
  pack-bitmap: introduce bitmap_walk_contains()
  pack-bitmap: uninteresting oid can be outside bitmapped packfile
  pack-bitmap: simplify bitmap_has_oid_in_uninteresting()
  csum-file: introduce hashfile_total()
  pack-objects: introduce pack.allowPackReuse
  builtin/pack-objects: introduce obj_is_packed()
  pack-objects: improve partial packfile reuse
  pack-objects: add checks for duplicate objects
  pack-bitmap: don't rely on bitmap_git->reuse_objects

 Documentation/config/pack.txt |   7 +
 builtin/pack-objects.c        | 243 +++++++++++++++++++++++++++-------
 csum-file.h                   |   9 ++
 ewah/bitmap.c                 |  13 +-
 ewah/ewok.h                   |   1 +
 pack-bitmap.c                 | 192 ++++++++++++++++++---------
 pack-bitmap.h                 |   6 +-
 packfile.c                    |  10 +-
 packfile.h                    |   3 +
 9 files changed, 362 insertions(+), 122 deletions(-)

-- 
2.24.1.498.g561400140f

