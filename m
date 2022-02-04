Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78555C433EF
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 14:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358924AbiBDOH3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 09:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359014AbiBDOHY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 09:07:24 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82F6C061714
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 06:07:23 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id s10so8982641wra.5
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 06:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SgzoX+bXor91Zo/4RRLrzDNrx1KccQ0F/Edp0Tsr3yA=;
        b=hChoM1Hug0xgd9zHOhWxY7u2gAuWZuiCE8rXtll7WFRmraCX+fxqXe04iGwOorXi4y
         BRM5R+LUbQAcfHycHxNt84cEkjsYzlMaiW5JJf//LCGvdY0rZ2eBjCwYp48JGcAxAYtI
         5nP0M4OT0lbM/2H2+LfV4/tA7NK+kJo9tMOm2Cju6ChF6AcMMMJwQj+OTi71WBtgNCyI
         G+tlY0/YR0uX4drzUCIqdSmWxMNoXQbuHvu8jQTRijKr/Qjv3oe/IiKrAAiUOz0eJGq1
         vjsEwgivoswvH/d53Mh6COk2U9Ki5IvVK5VCD5DZyRbgHE+4sE4rawaGuEdjkKFLSoGY
         piJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SgzoX+bXor91Zo/4RRLrzDNrx1KccQ0F/Edp0Tsr3yA=;
        b=PUJO8RCaveQLt2Hc2kI3RCN5bHVtQcu3nPIcmhT3JBxdggXBwuJ+eqJazNGMzhwzFR
         uiMV8mkKvHMSUomyW/zl4cHpdcZq5rWW6qyiBNYF8YajDZ5YIQIJLrjGtUgDw/7cmE9r
         L8/e5fEw0pMxYLMQRJb2uz16xNvzCRmyM56NtpwNBK03bbEjgjG5CGol/RvEncufcF0c
         5Wz8t9gIMBBWv3X0RqYvrwL/zWN7NLC21IH1/pyRmd3B0LffAy8ZL2Xu3u4jtwhiuqkc
         /sgePcMqFRSoJQmQtConxjdw/emi6PJ45VS4hbI3jdpN05oEIWU9KQpzlCywaP5ro2UY
         s7hA==
X-Gm-Message-State: AOAM533F1ZK4BUBQ9W6Ba9HjjcG3vBPmKaYz/mJAc1owk5aejhfgA3EJ
        EeAVi4lqQZ5Qrxflo4ZK/U2PR0uMmIzM3A==
X-Google-Smtp-Source: ABdhPJzc0ykR4DUtHMeSNfRUA8rqeyxJe4bAFfA9xxDQBDq/jNqhgyS+udmQOYrKte1clHqRmMaXOQ==
X-Received: by 2002:a05:6000:168e:: with SMTP id y14mr2592014wrd.51.1643983642160;
        Fri, 04 Feb 2022 06:07:22 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u19sm618722wmm.0.2022.02.04.06.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 06:07:21 -0800 (PST)
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
Subject: [PATCH v10 2/6] object-file.c: do fsync() and close() before post-write die()
Date:   Fri,  4 Feb 2022 15:07:08 +0100
Message-Id: <patch-v10-2.6-48bf9090058-20220204T135538Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.940.ge7a5b4b05f2
In-Reply-To: <cover-v10-0.6-00000000000-20220204T135538Z-avarab@gmail.com>
References: <20220120112114.47618-1-chiyutianyi@gmail.com> <cover-v10-0.6-00000000000-20220204T135538Z-avarab@gmail.com>
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
index 5c9525479c2..edebdc91221 100644
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
2.35.1.940.ge7a5b4b05f2

