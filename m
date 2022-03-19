Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0A7C4332F
	for <git@archiver.kernel.org>; Sat, 19 Mar 2022 00:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241660AbiCSAZG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Mar 2022 20:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241650AbiCSAY5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Mar 2022 20:24:57 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9A2129267
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 17:23:38 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d7so13697038wrb.7
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 17:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UHVl/vWuoZRphuTTh4i7HXzHa1b5eD9eYBQYqJ0VkB0=;
        b=Dk5wUQiEvjN7iQY1aFpC8F+xZFtPy7Dhi20LXJ/lQBPA5RnaBZ5qia5jgLv2ZpZNwv
         wivLpC3FKj8woC3EiI9dTaoaQy3EZmaTxa/j3XP0AT2cmxOhdKhAMajQT5ecBYv48VFl
         v4I2mGzv5IlIPfx89MwzB+koTCtMvuxIt69K/jlsmkcGAdoc+t6oiSRHaxDj628RWjF6
         7loH6RDuqwv/Yz7cKXDvHnRMTaiLNE5pOLor+dylsNTcAHFVQSsa+EnncZGss7my2BoK
         mEFGCsVl88By9RO7F3Ha1w3AD5psT14cz3FPhzV3zKE3v7pEGlJCKr1CjHvmYSbpPKgI
         dCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UHVl/vWuoZRphuTTh4i7HXzHa1b5eD9eYBQYqJ0VkB0=;
        b=AR/IlTMSqsvVup1jZ/sSNqd8BOH2WfMIvLIpS+6MP/LGjgiqbkvCnSba+jr/Ee5E0W
         6k9fQiEecR0za+6ps6uMNvc3b6e/+k5ZrKIyOCu99cFTYMYz8FoPUaC6Tdj4JsgQ1xwR
         AKA+oEMtNLUXkKVnjc7mkE77GvTD/8ZxcsTo6tKWH3HmtqVTxtFfHM6WaTPHzEDizlKs
         2yDKVGkHIIqHRanPm6cd1NiMYvhaBcow5cENrbde3Lm4X9ENwQsfh7x/p0D3ctrAXs6L
         6qcun6vgd2fYpdcbLYvC0sygO1rhpEdWMeov9pRBYK1Ei2ZGNzO82xLABbbMl5ceJSFQ
         qTTA==
X-Gm-Message-State: AOAM533Lsprp9LCvNE0H3xclYf8q2iutOUWgO48RzfrQQfDR80ksPAJZ
        DruS+ByOOoIFV29CNmg2IHNHHnuJ9yBI0A==
X-Google-Smtp-Source: ABdhPJyptXi/ShXkCeazqRQobr+yU01xR24xgYI0MiYqRott+A1nH60uU8aYoOfoK/74lqrDMRroMQ==
X-Received: by 2002:a5d:47cb:0:b0:203:fa18:3657 with SMTP id o11-20020a5d47cb000000b00203fa183657mr3245558wrc.490.1647649416611;
        Fri, 18 Mar 2022 17:23:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u25-20020a05600c211900b00389d4bdb3d2sm14865519wml.36.2022.03.18.17.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 17:23:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v11 2/8] object-file.c: do fsync() and close() before post-write die()
Date:   Sat, 19 Mar 2022 01:23:19 +0100
Message-Id: <patch-v11-2.8-6acd8759772-20220319T001411Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1438.g8874c8eeb35
In-Reply-To: <cover-v11-0.8-00000000000-20220319T001411Z-avarab@gmail.com>
References: <cover-v10-0.6-00000000000-20220204T135538Z-avarab@gmail.com> <cover-v11-0.8-00000000000-20220319T001411Z-avarab@gmail.com>
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
 object-file.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/object-file.c b/object-file.c
index bdc5cbdd386..4c140eda6bf 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2001,12 +2001,21 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid),
 		    ret);
 	the_hash_algo->final_oid_fn(&parano_oid, &c);
+
+	/*
+	 * We already did a write_buffer() to the "fd", let's fsync()
+	 * and close().
+	 *
+	 * We might still die() on a subsequent sanity check, but
+	 * let's not add to that confusion by not flushing any
+	 * outstanding writes to disk first.
+	 */
+	close_loose_object(fd);
+
 	if (!oideq(oid, &parano_oid))
 		die(_("confused by unstable object source data for %s"),
 		    oid_to_hex(oid));
 
-	close_loose_object(fd);
-
 	if (mtime) {
 		struct utimbuf utb;
 		utb.actime = mtime;
-- 
2.35.1.1438.g8874c8eeb35

