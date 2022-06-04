Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC4AC43334
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 10:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbiFDKKt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jun 2022 06:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbiFDKKj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jun 2022 06:10:39 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107951D320
        for <git@vger.kernel.org>; Sat,  4 Jun 2022 03:10:37 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id p10so13246566wrg.12
        for <git@vger.kernel.org>; Sat, 04 Jun 2022 03:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U/NPe8qv5DnYRgjCv2/cj4kXOW8DqeYHYmyE6KTUndE=;
        b=CcnA+vqTJA4oCYC2aoNi7vuoErKCE2BL6w7YXb1HHI3tfWArY8Z2Ciz41VXCR52+6Q
         W7OFfTsaWyAUkl0I6kGMh2f301RV8xsmgrNjXTariKuyew5tB12TgG93C1DfClb7abfr
         j0GE+++iYqD0FvkOt6bapo+aFH/+baS9Ed5BJE5/kAiQdZBkE9rsJxQRDoEW9UR0LJCs
         nLkvYB4OXzxhOVxOW6+gdco4FliYSbeMthgHe0xcL4YnGWW1YBOY14T0p1zpxh/M9rwv
         RjdLjW1lWShcSc+ASYo55yGo679VIAHz2JvOl4WDXzYw2vaQisMTp+B5ugGjPQkDctH1
         M2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U/NPe8qv5DnYRgjCv2/cj4kXOW8DqeYHYmyE6KTUndE=;
        b=xvJbA1kznXAtdXpzyyi6z842LPLOZTFSl74NrzATk9ECwOGtqxUwRbuK5M2M5Y44JY
         oQDycWtFzgTOwGfM95T9VeyfDP/QMPcUUDzCupM01fN4IuJXfW76RNqtvSRF3h/AcmCl
         /1op6wEheAmi7NH+x/+UJsqUBvFfNpQxXcuIBZhRo5qhiPyvCVzXvbPftlBNNN35Zscf
         PmbAgcrJGogWc3MrB1Mg/fBjn8rQw3nEbRpkG27oUbuyJ0rO0ovTBhrSHlpdXR8bbMqP
         Glx2/0eS8iBSFDlh3ntDaODA5R1M8wan4h7pfeMTOoiDfMq0YUwnJfmmvYXxxeit/J19
         bx4A==
X-Gm-Message-State: AOAM532nQvMdQbyLVNlbhEn+11uJ+AnQv18XX1PTZAp8kfVbOZa6KIUp
        9VTPkJKLEj2fkJvT0uxOoHu9qvXn/Inr+A==
X-Google-Smtp-Source: ABdhPJzxiQQ4QZZDDSzL3V9ZDh8PBs8TCb4c+7N82RbSgumvvETI6+cw0Vx08bzamzstMH6wCkxPug==
X-Received: by 2002:adf:fb46:0:b0:210:2316:dd02 with SMTP id c6-20020adffb46000000b002102316dd02mr12108008wrs.557.1654337435300;
        Sat, 04 Jun 2022 03:10:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i12-20020a05600c354c00b0039765a7add4sm15069631wmq.29.2022.06.04.03.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 03:10:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v13 2/7] object-file.c: do fsync() and close() before post-write die()
Date:   Sat,  4 Jun 2022 12:10:23 +0200
Message-Id: <patch-v13-2.7-b3568f0c5c0-20220604T095113Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1124.g52838f02905
In-Reply-To: <cover-v13-0.7-00000000000-20220604T095113Z-avarab@gmail.com>
References: <cover-v12-0.8-00000000000-20220329T135446Z-avarab@gmail.com> <cover-v13-0.7-00000000000-20220604T095113Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change write_loose_object() to do an fsync() and close() before the
oideq() sanity check at the end. This change re-joins code that was
split up by the die() sanity check added in 748af44c63e (sha1_file: be
paranoid when creating loose objects, 2010-02-21).

I don't think that this change matters in itself, if we called die()
it was possible that our data wouldn't fully make it to disk, but in
any case we were writing data that we'd consider corrupted. It's
possible that a subsequent "git fsck" will be less confused now.

The real reason to make this change is that in a subsequent commit
we'll split this code in write_loose_object() into a utility function,
all its callers will want the preceding sanity checks, but not the
"oideq" check. By moving the close_loose_object() earlier it'll be
easier to reason about the introduction of the utility function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/object-file.c b/object-file.c
index 79eb8339b60..e4a83012ba4 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2012,12 +2012,12 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid),
 		    ret);
 	the_hash_algo->final_oid_fn(&parano_oid, &c);
+	close_loose_object(fd, tmp_file.buf);
+
 	if (!oideq(oid, &parano_oid))
 		die(_("confused by unstable object source data for %s"),
 		    oid_to_hex(oid));
 
-	close_loose_object(fd, tmp_file.buf);
-
 	if (mtime) {
 		struct utimbuf utb;
 		utb.actime = mtime;
-- 
2.36.1.1124.g52838f02905

