Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A89C4321E
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 00:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D725610CC
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 00:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbhJDAsQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 20:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbhJDAsO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 20:48:14 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D91C061788
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 17:46:25 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id z184-20020a1c7ec1000000b003065f0bc631so17895224wmc.0
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 17:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4DwdVw2flRapc0zfN8iyO3mwISs9NRQQ+06uIRm9J10=;
        b=boePLSCrrGuJnef0BTKDvVrO9EIzz+/sTW9Jzuo3tq4zqlUZxyYcL/zD/Ij5d54kcg
         j+/Hd6DbqVgcQgIgylHLMSluLe2CQXPLRQtev96hNHzxdgxrHWMqa/4PD8g++zX3v2pt
         ypBrd+TJxP/ONtClFhxVGgpnR/aIw2hG+rOu0SDvozGhZnAmESMywOrXsT2SAk0X2klv
         O8hZDsmP+AS6Mmv7Qm7XvCJTdZsOHdYSTTJUhzm1Z4k09UN6ZmyWRsEENuB0BNHurUbS
         VDhV567AO6a3z1+6m9J2HoUf3plSDzJL2zT4i351u2XMXM3bpWNH2jujQ4zHz0hGgt+b
         Q5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4DwdVw2flRapc0zfN8iyO3mwISs9NRQQ+06uIRm9J10=;
        b=f8v/PKva9rp2aL8D2ry5j3ReUc8cfRHcptuy16C+I6k9JGga/ohxulFE+P0udSgMWX
         2PuHaWGQcl3PRDfXR+lB0kTnaIkQO2e33QplzUb7t+U35rJlII/b76dpGi0pVmKJuhwz
         sJmiFchiOQc9UWwAJeAQrnVT/7vB9EudXKrljuqf1ObP3oBBio3H3a6Y0VVtE1gRRQo0
         TDerxUG+dcoBzzGYAoz6qMN/UH0KZLbk/AkC1KRMansO9HGr1Fsi51vg7lCyCoue14FM
         qM/nKPqWtmvzlqNtP4m8rIeQ/9xiji6ToNE5vc/LxRgKM6GrvzlG9SnSR+WuPppQLIpe
         HR8g==
X-Gm-Message-State: AOAM533ylY5WWJ14H74o7Wgc+Mu6GMSfSJdqedW+iRRemjsmwVOzQZo3
        /P7YwoMdg0Y8f7zO76ZReYHPx/4+R+hg+A==
X-Google-Smtp-Source: ABdhPJzVWSZYNKTQ38XatA7kj1/vBlyg2LUghU/b/t9PfGZ1xLtANWL8QRKGV2qNqpUp6HiV9dEJJw==
X-Received: by 2002:a1c:7d56:: with SMTP id y83mr10656992wmc.86.1633308383344;
        Sun, 03 Oct 2021 17:46:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q7sm13526773wrc.55.2021.10.03.17.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 17:46:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 09/10] merge.c: avoid duplicate unpack_trees_options_release() code
Date:   Mon,  4 Oct 2021 02:46:10 +0200
Message-Id: <patch-09.10-aa2bec76f6e-20211004T002226Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1404.g83021034c5d
In-Reply-To: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor code added in 1c41d2805e4 (unpack_trees_options: free
messages when done, 2018-05-21) to use a ret/goto pattern, rather than
duplicating the end cleanup in the function.

This control flow will be matched in subsequent commits by various
other similar code, which often needs to do more than just call
unpack_trees_options_release(). Let's change this to consistently use
the same pattern everywhere.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 merge.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/merge.c b/merge.c
index 2f618425aff..2e3714ccaa0 100644
--- a/merge.c
+++ b/merge.c
@@ -54,6 +54,7 @@ int checkout_fast_forward(struct repository *r,
 	struct tree_desc t[MAX_UNPACK_TREES];
 	int i, nr_trees = 0;
 	struct lock_file lock_file = LOCK_INIT;
+	int ret = 0;
 
 	refresh_index(r->index, REFRESH_QUIET, NULL, NULL, NULL);
 
@@ -95,12 +96,14 @@ int checkout_fast_forward(struct repository *r,
 
 	if (unpack_trees(nr_trees, t, &opts)) {
 		rollback_lock_file(&lock_file);
-		unpack_trees_options_release(&opts);
-		return -1;
+		ret = -1;
+		goto cleanup;
 	}
-	unpack_trees_options_release(&opts);
 
 	if (write_locked_index(r->index, &lock_file, COMMIT_LOCK))
-		return error(_("unable to write new index file"));
-	return 0;
+		ret = error(_("unable to write new index file"));
+
+cleanup:
+	unpack_trees_options_release(&opts);
+	return ret;
 }
-- 
2.33.0.1404.g83021034c5d

