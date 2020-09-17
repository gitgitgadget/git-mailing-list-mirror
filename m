Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C58C43461
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 11:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03BE1208DB
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 11:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tHM/3YxW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgIQL3g (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 07:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgIQL3F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 07:29:05 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1228CC061788;
        Thu, 17 Sep 2020 04:28:54 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id b79so1666035wmb.4;
        Thu, 17 Sep 2020 04:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tzAc/TZ3oJwpBno6ItVxAZugyjGkmQQNpTTtTZujr28=;
        b=tHM/3YxWbFNOLlldFUFfFi+gSFT1m0J200u6OG/saxzZ+xz/UcOxOyubnuxrAgx6nd
         snEB5hB6lgIwklsEi0fu8vv9vINMwpS5ehG0e4vgre6i0QhOAWnGMr0ACu7V7ESLAPPY
         TCh6SbjVjd3OYtNvYqhXYzEFZSMS41zAe7i0EFahWXvNcJzObM9GYgDD4pyRA/w8sCHc
         HqIAjC9LyzF0hux/tzppZUr7hpyYCPPlms8xfUuv/U3u+/ewIQLbHHaF8jTf1BVU/Atd
         llRIaoox784fsDUn8WQpmT9lYYXBy/ZUfxl3eNe70Da/6kqY6T/b8yS37fw42D8GiLwK
         c0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tzAc/TZ3oJwpBno6ItVxAZugyjGkmQQNpTTtTZujr28=;
        b=FXmr/1AHRmiQmFicVvmlYQpZY09Kd6JCky7nQwmFZIXpikizEs+28gsXKIfNoafmGj
         1Kdp93XZ1I8Chs5sThZTMJprGy9UjvVzjZhaSdmF9ay1iqlOFjZR/wYFOLcAuoHBHWG3
         RLrd1j/68lq2PEwDoxdb0qYG2ihMFFr80TSNNMtRSargggxOvdG7mOPlL3hm8lK+6J34
         CxkeILrTnD+g0YobX91RVuORDRYaH7kYMHyNkDR8afVQoI1sH42IWd889Zf3MxoXaBhx
         vZeUhGp2ApMAjIgxTPEUIT+i5QelNWWUxXXNs3q5yGiBaTf9mGV6zzlYtYzJ+7YoMq5j
         x/tA==
X-Gm-Message-State: AOAM530b8MdUZ7kCUwIJuLRjup6anR4nHjC2Dp3DvQ0uIU1yni/PMOCx
        48J5+MyAzmG6p4VcC5aSypTPmeKcrN6aUw==
X-Google-Smtp-Source: ABdhPJx6NUTB4Pzaaubhd3MzQe93qr29LMm6Z0uWSfqnBq8cKuKUFYANWGRCzZu4uFlXvoI9ikN4mA==
X-Received: by 2002:a1c:f214:: with SMTP id s20mr9346267wmc.84.1600342132440;
        Thu, 17 Sep 2020 04:28:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t16sm38781127wrm.57.2020.09.17.04.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 04:28:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     tytso@mit.edu, Junio C Hamano <gitster@pobox.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 2/2] core.fsyncObjectFiles: make the docs less flippant
Date:   Thu, 17 Sep 2020 13:28:30 +0200
Message-Id: <20200917112830.26606-3-avarab@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <87sgbghdbp.fsf@evledraar.gmail.com>
References: <87sgbghdbp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As amusing as Linus's original prose[1] is here it doesn't really explain
in any detail to the uninitiated why you would or wouldn't enable
this, and the counter-intuitive reason for why git wouldn't fsync your
precious data.

So elaborate (a lot) on why this may or may not be needed. This is my
best-effort attempt to summarize the various points raised in the last
ML[2] discussion about this.

1.  aafe9fbaf4 ("Add config option to enable 'fsync()' of object
    files", 2008-06-18)
2. https://lore.kernel.org/git/20180117184828.31816-1-hch@lst.de/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/core.txt | 42 ++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 74619a9c03..5b47670c16 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -548,12 +548,42 @@ core.whitespace::
   errors. The default tab width is 8. Allowed values are 1 to 63.
 
 core.fsyncObjectFiles::
-	This boolean will enable 'fsync()' when writing object files.
-+
-This is a total waste of time and effort on a filesystem that orders
-data writes properly, but can be useful for filesystems that do not use
-journalling (traditional UNIX filesystems) or that only journal metadata
-and not file contents (OS X's HFS+, or Linux ext3 with "data=writeback").
+	This boolean will enable 'fsync()' when writing loose object
+	files. Both the file itself and its containng directory will
+	be fsynced.
++
+When git writes data any required object writes will precede the
+corresponding reference update(s). For example, a
+linkgit:git-receive-pack[1] accepting a push might write a pack or
+loose objects (depending on settings such as `transfer.unpackLimit`).
++
+Therefore on a journaled file system which ensures that data is
+flushed to disk in chronological order an fsync shouldn't be
+needed. The loose objects might be lost with a crash, but so will the
+ref update that would have referenced them. Git's own state in such a
+crash will remain consistent.
++
+This option exists because that assumption doesn't hold on filesystems
+where the data ordering is not preserved, such as on ext3 and ext4
+with "data=writeback". On such a filesystem the `rename()` that drops
+the new reference in place might be preserved, but the contents or
+directory entry for the loose object(s) might not have been synced to
+disk.
++
+Enabling this option might slow git down by a lot in some
+cases. E.g. in the case of a naïve bulk import tool which might create
+a million loose objects before a final ref update and `gc`. In other
+more common cases such as on a server being pushed to with default
+`transfer.unpackLimit` settings the difference might not be noticable.
++
+However, that's highly filesystem-dependent, on some filesystems
+simply calling fsync() might force an unrelated bulk background write
+to be serialized to disk. Such edge cases are the reason this option
+is off by default. That default setting might change in future
+versions.
++
+In older versions of git only the descriptor for the file itself was
+fsynced, not its directory entry.
 
 core.preloadIndex::
 	Enable parallel index preload for operations like 'git diff'
-- 
2.28.0.297.g1956fa8f8d

