Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EB0C433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 13:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356702AbiDUN3t (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 09:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384716AbiDUN3j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 09:29:39 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDC037A14
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 06:26:49 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id bg9so4632902pgb.9
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 06:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yurah2PuINuzxenJa28GG9ZQr8xWMhB8hAcHwgSszuU=;
        b=kFbrhby8GrLQgfB7Y5SvEM+VHRry8K8pQTgYaRHftXI6bqMNpIke/LwazxUitUkQEI
         3795OavjxqB/6yzR40aDEJWRmvdiqTIP50n7Br8jbJAfS+8Byd9SOKlgEIDNg2uGzIIl
         llZqdrtg1PcrA9pkbwpG2eu3h9U37Suw9Be4vsKREyz9x7Y0xmVdE/4zfXCoCsQ6L1Rj
         2+nRDbVU/GRPpTuvFMQaXc8cGyZcJB/C99fIlJZlvlRTKmMCOY8sws20CWrJRsSeX1FW
         c2l0x/yPYfR0LUo3LFy4PsRu6C+gxWeHh2sXLBtm5nWEntEla9kq9gsFe6aWhZvzPoud
         yf2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yurah2PuINuzxenJa28GG9ZQr8xWMhB8hAcHwgSszuU=;
        b=mRokkrMwhofdpJRJXqWe2ws69LVUWTxBm8YoccG92Q+z1OxuLQHBZoNkyfBRJASqnc
         N53HHYfDvT+Y/a5ttE1gSLxXAwjylpwWBusnQ1ejrXtY7fCqRjtYyRxlHnV1vxl9Whbo
         gWPHvzDJNOOZCw7X3e8o5G8wzh23YXOrZDufM7oD+XjGZ7qdLaWrj0wg3PcTmhPiEMLy
         +ZOZpsmw5lQYziGYi97QbGmaBemdBfz2ODoSwx+5JQEbtJXD8NgxOx4yUjt+aiN6CTsE
         KN9depySB/QbU6t/MGM55HfjJyc1Yp19y2f5H4vetqdqPwAdpoQfd61JQ+3rlyKCEVVr
         HEUg==
X-Gm-Message-State: AOAM533nGySKfX8C31MBd0o7P1rHjLm0psG3fIf61KVa8MxjSWtwbRp5
        Or4XET4UHxFzO9k1oyzTI99nx2ofQYxVdUL6
X-Google-Smtp-Source: ABdhPJyKuUX7e4K46DkvIu9W375ki/zS8NxnZ6BErBVtumJhCnS6+wNsPZcPt/SC+AADhppaSEiqcA==
X-Received: by 2002:a65:6e88:0:b0:39d:2647:f75d with SMTP id bm8-20020a656e88000000b0039d2647f75dmr24211054pgb.523.1650547609083;
        Thu, 21 Apr 2022 06:26:49 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.42])
        by smtp.gmail.com with ESMTPSA id bd42-20020a056a0027aa00b0050a6e0ccc54sm15463647pfb.186.2022.04.21.06.26.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Apr 2022 06:26:48 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        me@ttaylorr.com, tenglong.tl@alibaba-inc.com, gitster@pobox.com
Subject: [PATCH v2 0/5] trace2 output for bitmap decision path
Date:   Thu, 21 Apr 2022 21:26:35 +0800
Message-Id: <cover.1650547400.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.583.g30faa5f068
In-Reply-To: <cover.1648119652.git.dyroneteng@gmail.com>
References: <cover.1648119652.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for the late patch. Main diffs from v1:

1. Add a new commit to rename "idx_name" and this may clear up
some misconceptions about the naming

2. Add the warnings more detailed when opening bitmap and also
let the texts support translation.

3. using error() instead of silently returning -1 when opening
bitmap.

4. Continue looping when first MIDX bitmap is found.

Thanks.

Teng Long (5):
  pack-bitmap.c: continue looping when first MIDX bitmap is found
  pack-bitmap.c: rename "idx_name" to "bitmap_name"
  pack-bitmap.c: make warnings more detailed when opening bitmap
  bitmap: add trace2 outputs during open "bitmap" file
  pack-bitmap.c: using error() instead of silently returning -1

 pack-bitmap.c           | 73 ++++++++++++++++++++++++++++-------------
 repo-settings.c         |  1 +
 t/t5310-pack-bitmaps.sh |  3 +-
 3 files changed, 54 insertions(+), 23 deletions(-)

Range-diff against v1:
1:  3048b4dd29 ! 1:  1bfd2fb6ab pack-bitmap.c: use "ret" in "open_midx_bitmap()"
    @@ Metadata
     Author: Teng Long <dyroneteng@gmail.com>
     
      ## Commit message ##
    -    pack-bitmap.c: use "ret" in "open_midx_bitmap()"
    +    pack-bitmap.c: continue looping when first MIDX bitmap is found
     
    -    Let's use "ret" value for "return" statement in "open_midx_bitmap()"
    -    just as the same way as int "open_pack_bitmap()".
    +    In "open_midx_bitmap()", we do a loop with the MIDX(es) in repo, when
    +    the first one has been found, then will break out by a "return"
    +    directly.
     
    +    But actually, it's better to don't stop the loop until we have visited
    +    both the MIDX in our repository, as well as any alternates (along with
    +    _their_ alternates, recursively).
    +
    +    The discussion link of community:
    +
    +      https://public-inbox.org/git/YjzCTLLDCby+kJrZ@nand.local/
    +
    +    Helped-by: Taylor Blau <me@ttaylorr.com>
         Signed-off-by: Teng Long <dyroneteng@gmail.com>
     
      ## pack-bitmap.c ##
    @@ pack-bitmap.c: static int open_pack_bitmap(struct repository *r,
      	assert(!bitmap_git->map);
      
      	for (midx = get_multi_pack_index(r); midx; midx = midx->next) {
    --		if (!open_midx_bitmap_1(bitmap_git, midx))
    + 		if (!open_midx_bitmap_1(bitmap_git, midx))
     -			return 0;
    -+		if (!open_midx_bitmap_1(bitmap_git, midx)) {
     +			ret = 0;
    -+			break;
    -+		}
      	}
     -	return -1;
     +	return ret;
2:  70500b6343 < -:  ---------- pack-bitmap.c: add "break" statement in "open_pack_bitmap()"
3:  9912450fc1 < -:  ---------- bitmap: add trace outputs during open "bitmap" file
-:  ---------- > 2:  1fff3b3ca7 pack-bitmap.c: rename "idx_name" to "bitmap_name"
-:  ---------- > 3:  5a8f5afccf pack-bitmap.c: make warnings more detailed when opening bitmap
-:  ---------- > 4:  2016ef2e34 bitmap: add trace2 outputs during open "bitmap" file
-:  ---------- > 5:  1a169d7b5e pack-bitmap.c: using error() instead of silently returning -1
-- 
2.35.1.583.g30faa5f068

