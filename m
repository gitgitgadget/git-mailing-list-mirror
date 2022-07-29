Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7B2C19F29
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 12:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236022AbiG2M2y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 08:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235972AbiG2M2v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 08:28:51 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BEFBE3D
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 05:28:50 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id b26so5846292wrc.2
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 05:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ji5bR1HZYHuEesrRLzUH0myHHYt73mi+kKbxx0xaJs8=;
        b=amsuNHwlnPwLh5wUv9CKJptVWlBCPf6fcXxtpkD8awN3NMLns1ZZzVH/zLLmABLns/
         s4NDhaYjmSBvYfCq39NtignKbk77R1iTC1XqZzNj3HhgIlb75T8QTW0tz6FoK48hXbZG
         i1Mk5npPudgX+OJz13zUGck1xV2Io2kahsPr1gilSuSEwEuHF7uFSUmppkNWvvcflLkS
         vNQDfxw5i60+zJRWYI3bYxiGLnTZ8x+wuF6Om6Jrb2CKYO8CgEombBsaXv1J3A0+LD/d
         hmnLvFH8yxhTrVeqJx5kEN2mP6FdZwhIRKWlIuWa6RCl7cv3jWL4t4EIEy+ItSG/IivZ
         hbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ji5bR1HZYHuEesrRLzUH0myHHYt73mi+kKbxx0xaJs8=;
        b=jVse1IIm5ANT0hegYKNmiyq0XQNMMVSlUpQlxw2Qfq/OnDO6LW/bGF5t2yQJUAgElx
         3xdN1XD6/FNYqPzRWCsJWVDdHr911kr8W5kw95oXpQr3sV8EBCOMSd+Q5MXVZv7OtHsK
         YTFgor274zZLVRkB11d5tkUexK38TZRIeg9HF7Fiul61yG/Nuzs01n1tZmEh7D6YBB1x
         r6QeuQ9kMxLccCmmiiU2v8sp5GOl9ohpZ7e1JBL2PTxC89gKeUYFBRIyPDJWI7OAUDAB
         Jf1AIs3ms0Zukqx8UdBelZ72UWaV3xECeEebvthzn+tBUOJvk1LoUnjJQwSvMyKbOJAU
         5Qsw==
X-Gm-Message-State: ACgBeo36/5FX3vkaknTpMBJeQiTjqPZH+qX2SNhB/2QCtmU9+M4Y24aJ
        nPOtu9og+5MOz3NM5QofkxXsG42dhVw=
X-Google-Smtp-Source: AA6agR6KQxzuQ2SEJaaaVljKnfVfcplWjlipe8U8EoDeMkfuwKYW6mdcz1J525GH3w/MwFhFVSV0dQ==
X-Received: by 2002:a5d:4dc8:0:b0:21e:660f:8dfe with SMTP id f8-20020a5d4dc8000000b0021e660f8dfemr2266163wru.468.1659097728244;
        Fri, 29 Jul 2022 05:28:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j17-20020a05600c301100b003a32438c518sm8074622wmh.6.2022.07.29.05.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 05:28:47 -0700 (PDT)
Message-Id: <b9203ea247776332e4b6f519aa27d541207adc2f.1659097724.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1308.git.1659097724.gitgitgadget@gmail.com>
References: <pull.1308.git.1659097724.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Jul 2022 12:28:44 +0000
Subject: [PATCH 2/2] t5351: avoid using `test_cmp` for binary data
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `test_cmp` function is meant to provide nicer output than `cmp` when
expected and actual output of Git commands disagree. The implicit
assumption is that the output is line-based and human readable.

However, aaf81223f48 (unpack-objects: use stream_loose_object() to
unpack large objects, 2022-06-11) introduced a call that compares the
contents of pack files, which are distinctly not line-based nor human
readable.

This causes problems because on Windows, we hand off to the Bash
function `mingw_test_cmp` that compares the lines while ignoring line
ending differences. And this Bash function spends an insane amount of
cycles trying to read in that binary pack file, so that it is almost
indistinguishable from an infinite loop.

For example, t5351 took 1486 seconds in the CI run at
https://github.com/git/git/runs/7398490747?check_suite_focus=true#step:5:171,
to complete. And yes, that is almost half an hour.

Since Git's tests already use `cmp` consistently when comparing pack
files, let's change this instance to use `cmp` instead of `test_cmp`,
too, and fix that performance problem.

Now t5351 takes all of 22 seconds.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5351-unpack-large-objects.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5351-unpack-large-objects.sh b/t/t5351-unpack-large-objects.sh
index dd7ebc40072..e936f91c3ba 100755
--- a/t/t5351-unpack-large-objects.sh
+++ b/t/t5351-unpack-large-objects.sh
@@ -93,7 +93,7 @@ test_expect_success 'do not unpack existing large objects' '
 
 	# The destination came up with the exact same pack...
 	DEST_PACK=$(echo dest.git/objects/pack/pack-*.pack) &&
-	test_cmp pack-$PACK.pack $DEST_PACK &&
+	cmp pack-$PACK.pack $DEST_PACK &&
 
 	# ...and wrote no loose objects
 	test_stdout_line_count = 0 find dest.git/objects -type f ! -name "pack-*"
-- 
gitgitgadget
