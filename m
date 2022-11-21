Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00E3C433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 12:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiKUMQb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 07:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKUMQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 07:16:25 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AF41115
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 04:16:24 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id k2-20020a17090a4c8200b002187cce2f92so8948089pjh.2
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 04:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1iD9dQLYeyz6JxepjeArRY2L4DC1ICHSYsUv9dtvA6A=;
        b=eXF17UxO7Pvpa3tynO5sFu8VnXD+c8tkFOumkoMkrFtaFY2vI20DAT9/F8DS6y8JXE
         FI6pJakbGS1l4OpHBUg/qBHNfShbrHI9Kjve8nDK2RRNho8xShpGc5NWJ+42jVhg4YsX
         XvqW0eD7xDnj7MQtLv9TvUz4UlQOjOuSLUY9SPaSgPlC0LUHbo5F7OXkt8wbRaSf5LyN
         IW78aOmxYNrZ0dWJQHtTOH4VtwoCJiTd400Ntao1rAn0CLi/dLMVEc6L5bjSyp/hkYYv
         3D3py8jYRYhqfAg+9Dszog3Mf7eFpAheJYEOPuuf4E7IWoV/gCRRaHwiRKC9QZ9M5B9Q
         cIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1iD9dQLYeyz6JxepjeArRY2L4DC1ICHSYsUv9dtvA6A=;
        b=IA8J1Uul6rcsR56dHxjTIlH2ZqR/G9F5s6qdIQaFI4KFQtipT0oslsqRjQlj0Xm3GV
         jd7WrYXUWoCpH8UqX0ELHDvTCVy1Dlaq7bTU2qvttF8UPyqe+ivjk64gjX/cnmul6JeD
         yQItLlGgva8zqSr1GvGM6fv5nxaXEBLbR7Aw2ywFMiyLpi8WdGXbFVirZlAtmi8XG5z4
         gYTXFO7JDrY4kU9ox+dBd1yRZhY/dyyOBp9n2oL0cF5F+vDJLaCK+KxE0VDJY+zubO6R
         UkfrvkuCVjQbxy6Jsd5sY0uYGyVxAKa+34lDZO6ASlBK9hmhmKVllyV/g1WEuTO1QpEV
         qBdA==
X-Gm-Message-State: ANoB5pmfXI4Bhn+JYwcy14thnV93jgomcaxJK0XKKgDcMhEHYSoV7G5y
        JPRI/34plFCgHxdj8onUTJY=
X-Google-Smtp-Source: AA0mqf72oRIsdxx+ci9+LJDxz1aikT8+b/DBkNz40sQKmuapn2FkAVutjSYn5BXWIpbA21wEp+1xxw==
X-Received: by 2002:a17:902:ef44:b0:185:40ca:68b8 with SMTP id e4-20020a170902ef4400b0018540ca68b8mr160828plx.16.1669032984260;
        Mon, 21 Nov 2022 04:16:24 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.53])
        by smtp.gmail.com with ESMTPSA id n13-20020a170903110d00b00176b63535adsm9630098plh.260.2022.11.21.04.16.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Nov 2022 04:16:23 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH v4 0/4] pack-bitmap.c: avoid exposing absolute paths
Date:   Mon, 21 Nov 2022 20:16:11 +0800
Message-Id: <cover.1669032425.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.38.1.383.g9d5a491887b
In-Reply-To: <cover.1667470481.git.dyroneteng@gmail.com>
References: <cover.1667470481.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

Sorry for relying late, Taylor..

Diff since v3:

I picked Peff's two new constructive patches[1] which I think are meaningful.
Peff also mentioned whether to design a "GIT_TRACE2_BITMAP" ENV to help
debugging bitmap, and I think it's very interesting but maybe it's a bigger
scale on current patchset, so I prefer to do it in another series.

1. https://public-inbox.org/git/Y3K%2F%2FkO3fxD7Pl3%2F@coredump.intra.peff.net/

Thanks.

Jeff King (2):
  pack-bitmap.c: break out of the bitmap loop early if not tracing
  pack-bitmap.c: trace bitmap ignore logs when midx-bitmap is found

Teng Long (2):
  pack-bitmap.c: remove unnecessary "open_pack_index()" calls
  pack-bitmap.c: avoid exposing absolute paths

 pack-bitmap.c           | 39 ++++++++++++++++++++++++++-------------
 t/t5310-pack-bitmaps.sh |  5 +++--
 2 files changed, 29 insertions(+), 15 deletions(-)

Range-diff against v3:
-:  ---------- > 1:  aaeb021538 pack-bitmap.c: remove unnecessary "open_pack_index()" calls
1:  de941f58f9 ! 2:  9d5a491887 pack-bitmap.c: avoid exposing absolute paths
    @@ pack-bitmap.c: static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
      		get_midx_filename(&buf, midx->object_dir);
     -		/* ignore extra bitmap file; we can only handle one */
     -		warning(_("ignoring extra bitmap file: '%s'"), buf.buf);
    -+		/* ignore extra midx bitmap files; we can only handle one */
     +		trace2_data_string("bitmap", the_repository,
     +				   "ignoring extra midx bitmap file", buf.buf);
      		close(fd);
    @@ pack-bitmap.c: static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, st
      	if (bitmap_git->pack || bitmap_git->midx) {
     -		/* ignore extra bitmap file; we can only handle one */
     -		warning(_("ignoring extra bitmap file: '%s'"), packfile->pack_name);
    -+		/* ignore extra bitmap files; we can only handle one */
     +		trace2_data_string("bitmap", the_repository,
     +				   "ignoring extra bitmap file", packfile->pack_name);
      		close(fd);
    @@ t/t5310-pack-bitmaps.sh: test_bitmap_cases () {
      
     -			git rev-list --use-bitmap-index HEAD 2>err &&
     -			grep "ignoring extra bitmap file" err
    -+			GIT_TRACE2_PERF=$(pwd)/trace2.txt git rev-list --use-bitmap-index HEAD &&
    ++			GIT_TRACE2_EVENT=$(pwd)/trace2.txt git rev-list --use-bitmap-index HEAD &&
     +			grep "opened bitmap" trace2.txt &&
     +			grep "ignoring extra bitmap" trace2.txt
      		)
-:  ---------- > 3:  f6c5b45bdc pack-bitmap.c: break out of the bitmap loop early if not tracing
-:  ---------- > 4:  2acaa3f097 pack-bitmap.c: trace bitmap ignore logs when midx-bitmap is found
-- 
2.38.1.383.g9d5a491887b

