Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5F3C19F28
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiHBPda (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiHBPd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:33:28 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33345BF59
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:33:26 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id v131-20020a1cac89000000b003a4bb3f786bso3318024wme.0
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ugpEikPjvL95tgi4iR7wTizy0HWMDoQcGYhbDCCgy5U=;
        b=qjay525FGEmNHrF7QbbgDBLeQtbSNvKkP6zn530VRX2ag3oANYUCDT7hU23gKnsXX9
         GIkSaAIv+Z3I4xpmzcO/5No0B9UpT676quxF4uxPwGTiJsIL0+VdsllT/08NcRe0tQh3
         udJgGTYcHLqgaD6f8/u1h2KD8U3Fv8XlYF7DnFx2PMJ5VRmaM9bl7NBtNxl/Y0i1Azdl
         5cp29psfH23zr8+Iut5lQRb3NogljpAL8iZ9ZKo8v3GkmCfiqUWCTExGeiqHSzNoKMkE
         gy0BzCe0BnrMLKt/9fFYFPBE3/defyP56GNyVcILGFcbt6KJcE7sCpJuRg/yakiY9Qkb
         IdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ugpEikPjvL95tgi4iR7wTizy0HWMDoQcGYhbDCCgy5U=;
        b=Nh9s7P5vHb7KbT/eF1gNoloXuI9go6bszrlN9s339Al09E5BX+2Fc6QC/29t3//QQK
         kcxTy+mQj2lEvSMm9iUTNJYlpQyk/pjjbIP2ZrwX/y8EeBSNQC9pOvRkcT5p2KH3VJ30
         QKudCvdaBfOc/hpNnf7DPShugAWwDMav9PSc6dYnfAHd5CJMf7qYFwmxcRHqhoPunoyF
         3fBJtziSS0RiZ4O60sdLZfH6KqyqBBnVhaHuiaJKDpez+BY66IhKrKn7YugwTiUHcmPG
         Q9+wloNcxmNKkG5isKjQZbxCL5GWM2ICqQ4y4UcTJvdnFW5n3mMxaY2RjSrR8JaWWA5N
         OgkQ==
X-Gm-Message-State: ACgBeo1WgCL2cSeSyhlw6Ci0tlOz2j2XVDhIdJIOVMy/PmOyFHGhdae2
        8VLxB22EAExV2phsrZkOXjEcPrwDd2g52Q==
X-Google-Smtp-Source: AA6agR4oxMllA0OMJ30d3vtI1/9BwRnevo10xIqlUXRu5cbVFfaWIEvjAskf6uhiNH373sLMafS9Ag==
X-Received: by 2002:a05:600c:1ca8:b0:3a3:19c9:5448 with SMTP id k40-20020a05600c1ca800b003a319c95448mr48976wms.40.1659454404349;
        Tue, 02 Aug 2022 08:33:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y7-20020adffa47000000b0021e9396b135sm15332531wrr.37.2022.08.02.08.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:33:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/6] test-fast-rebase helper: use release_revisions() (again)
Date:   Tue,  2 Aug 2022 17:33:12 +0200
Message-Id: <patch-v3-2.6-a04fade9d9d-20220802T152925Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v3-0.6-00000000000-20220802T152925Z-avarab@gmail.com>
References: <cover-v2-0.6-00000000000-20220729T082919Z-avarab@gmail.com> <cover-v3-0.6-00000000000-20220802T152925Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a bug in 0139c58ab95 (revisions API users: add "goto cleanup" for
release_revisions(), 2022-04-13), in that commit a release_revisions()
call was added to this function, but it never did anything due to this
TODO memset() added in fe1a21d5267 (fast-rebase: demonstrate
merge-ort's API via new test-tool command, 2020-10-29).

Simply removing the memset() will fix the "cmdline" which can be seen
when running t5520-pull.sh.

This sort of thing could be detected automatically with a rule similar
to the unused.cocci merged in 7fa60d2a5b6 (Merge branch
'ab/cocci-unused' into next, 2022-07-11). The following rule on top
would catch the case being fixed here:

	@@
	type T;
	identifier I;
	identifier REL1 =~ "^[a-z_]*_(release|reset|clear|free)$";
	identifier REL2 =~ "^(release|clear|free)_[a-z_]*$";
	@@

	- memset(\( I \| &I \), 0, ...);
	  ... when != \( I \| &I \)
	(
	  \( REL1 \| REL2 \)( \( I \| &I \), ...);
	|
	  \( REL1 \| REL2 \)( \( &I \| I \) );
	)
	  ... when != \( I \| &I \)

That rule should arguably use only &I, not I (as we might be passed a
pointer). The distinction would matter if anyone cared about the
side-effects of a memset() followed by release() of a pointer to a
variable passed into the function.

As such a pattern would be at best very confusing, and most likely
point to buggy code as in this case, the above rule is probably fine
as-is.

But as this rule only found one such bug in the entire codebase let's
not add it to contrib/coccinelle/unused.cocci for now, we can always
dig it up in the future if it's deemed useful.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-fast-rebase.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/t/helper/test-fast-rebase.c b/t/helper/test-fast-rebase.c
index 4e5553e2024..45665ec19a5 100644
--- a/t/helper/test-fast-rebase.c
+++ b/t/helper/test-fast-rebase.c
@@ -184,8 +184,6 @@ int cmd__fast_rebase(int argc, const char **argv)
 		last_picked_commit = commit;
 		last_commit = create_commit(result.tree, commit, last_commit);
 	}
-	/* TODO: There should be some kind of rev_info_free(&revs) call... */
-	memset(&revs, 0, sizeof(revs));
 
 	merge_switch_to_result(&merge_opt, head_tree, &result, 1, !result.clean);
 
-- 
2.37.1.1233.ge8b09efaedc

