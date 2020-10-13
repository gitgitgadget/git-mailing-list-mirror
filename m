Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34FBC433DF
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 05:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3F5821582
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 05:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h2AGFytm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732426AbgJMF3U (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 01:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732419AbgJMF3T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 01:29:19 -0400
Received: from mail-il1-x149.google.com (mail-il1-x149.google.com [IPv6:2607:f8b0:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35CFC0613D0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 22:29:19 -0700 (PDT)
Received: by mail-il1-x149.google.com with SMTP id d16so14109851ila.23
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 22:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=kyAUqNF26ooIcAtbHH/JhIveFaDIAYfiROTHpbFCRNw=;
        b=h2AGFytmdpPj68C7pp5K+mfYZic53EGWLx5NoM1CUB0CjteCKEUFho6QFivax+eu6U
         /NFgOJuG4LhSG4xR40E8JaocrjiMm+wb3fdoPDckviodOeDq48bcIgnw7QrselDsxVOx
         Kz4kSy5Z56r0TQvfmPM7XBZtTz1pSTrYsLG8jbd1mzcExpqHlYNasSvmpvixYbJKGPKr
         /dtEI19W56su8Nflfg3m83QdWWWTNpMRYXEWj9ykqbdQGFAebcTe8LORbLM0eQUoHgAk
         IhVkx60XTQiyHwffpe2sPNN+OlbeM1yzNEmDfnwuF9aHRbbX+24PZnNK6NDmO2jmNllZ
         9aAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kyAUqNF26ooIcAtbHH/JhIveFaDIAYfiROTHpbFCRNw=;
        b=NiLIPdVVnCK2Vx3CfAx44AYbgSaxc3ujII7XalLa0hsa7om15x5k4Whxx93+O8OlLJ
         EbspFcwzH7RwNOZZ3cB6ngQ+97Hmb3QOc9cK7Xdf9OZENxNBGtP+TqbAqDKKiJvhk/g4
         BZdePrt79ncprrLMLLglqdpflw+8Lqs9+cRaJhHXjQv/IsmpXtrdVHIdkSNRqEUbgh1h
         El89x8psSzjn6z7xTzTUdSou+0rVF+JR07KDmEGQnWo8spAmDQhPJC/5x5alX36jD8so
         h+9t6N/7wT6d21L66D59tpkahSKjL+tpV2KufijkAQdR69uUopDy8FIoNT24hFFTUVd2
         ZHLg==
X-Gm-Message-State: AOAM531t5gluOIrb/vY+J1PUrwgBBlOGHU3yaMN8gVoHNW26b98aQ/u3
        Dr4wGuXiTro+MiWjDZ4hbNYhe4lYEOjnjZo6lIkx7uazvb0z6mn3fkOKYyJp2f5OF2rcxhqjOT9
        P4vb0k3CETen5SFTSFhXX3cpJV4G0zX7SfXKHz2yN4zPTKMRgD065hcdPTgsX
X-Google-Smtp-Source: ABdhPJwzLN4rTToHBWFr/QB/QPJHEimnks/OqzWQYVAIfe618EgHcSQp6kuO9Uhnt9Jh4d/HUcCWEKvcKcGC
Sender: "shengfa via sendgmr" <shengfa@lins.c.googlers.com>
X-Received: from lins.c.googlers.com ([fda3:e722:ac3:10:2b:ff92:c0a8:cb])
 (user=shengfa job=sendgmr) by 2002:a6b:c94f:: with SMTP id
 z76mr18260616iof.88.1602566958823; Mon, 12 Oct 2020 22:29:18 -0700 (PDT)
Date:   Tue, 13 Oct 2020 05:28:51 +0000
In-Reply-To: <20201013052851.373029-1-shengfa@google.com>
Message-Id: <20201013052851.373029-3-shengfa@google.com>
Mime-Version: 1.0
References: <CAEOYnAQYMrNAe9s1V-0DVLdL-B_KpHMDP5e=yRnbCkMWdrvFHQ@mail.gmail.com>
 <20201013052851.373029-1-shengfa@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [WIP v2 2/2] Demonstrate failing and passing tests
From:   Shengfa Lin <shengfa@google.com>
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, gitster@pobox.com,
        jrnieder@gmail.com, nathaniel@google.com, rsbecker@nexbridge.com,
        santiago@nyu.edu, shengfa@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

date=@... and GIT_AUTHOR_DATE=@... tests are failing
while unsetting GIT_AUTHOR_DATE passes

Signed-off-by: Shengfa Lin <shengfa@google.com>
---
 t/t7514-commit-patch.sh | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/t/t7514-commit-patch.sh b/t/t7514-commit-patch.sh
index 3ba1ff4f81..b87d29f020 100755
--- a/t/t7514-commit-patch.sh
+++ b/t/t7514-commit-patch.sh
@@ -31,13 +31,32 @@ test_expect_success 'edit hunk "commit --dry-run -p -m message"' '
 	test -r editor_was_started
 '
 
-test_expect_success 'commit date shows timezone offset -0000 when no-record-time-zone is specified' '
-        echo test >>file &&
+test_expect_success 'commit with --date shows timezone offset -0000 when no-record-time-zone is specified' '
+        echo test1 >>file &&
         git add file &&
-        TZ=UTC-09 git commit --date=@1600000000 -m "test" --no-record-time-zone &&
+        TZ=UTC-09 git commit --date=@1600000000 -m "test1" --no-record-time-zone &&
         git show -s --format='%aI' >output &&
         echo 2020-09-13T12:26:40-00:00 >expect &&
         test_cmp output expect
 '
 
+test_expect_success 'commit with GIT_AUTHOR_DATE shows timezone offset -0000 when no-record-time-zone is specified' '
+        echo test2 >>file &&
+        git add file &&
+        export GIT_AUTHOR_DATE=@1600000000 TZ=UTC-09 &&
+        git commit -m "test2" --no-record-time-zone &&
+        git show -s --format='%aI' >output &&
+        echo 2020-09-13T12:26:40-00:00 >expect &&
+        test_cmp output expect
+'
+
+test_expect_success 'commit with unset GIT_AUTHOR_DATE shows timezone offset -0000 when no-record-time-zone is specified' '
+        echo test2 >>file &&
+        git add file &&
+        unset GIT_AUTHOR_DATE &&
+        TZ=UTC-09 git commit -m "test2" --no-record-time-zone &&
+        git show -s --format='%aI' >output &&
+        grep "\-00:00" output
+'
+
 test_done
-- 
2.28.0.1011.ga647a8990f-goog

