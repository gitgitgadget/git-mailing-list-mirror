Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A28C3DA78
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 17:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbjAQRLq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 12:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbjAQRLd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 12:11:33 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2392A34569
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 09:11:30 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id m21so45998164edc.3
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 09:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HgRUV8vc+1/isXemg17KC16Xl/Kcpdk3WdYy0RAdlM=;
        b=GV+SDmHhYqPN/bkBwFvzLjlpdvh2ef+ReOq4GiqA+bHF+uzylWSwq7BhR9npBAjcOb
         1rISyy4KKtHaq1s4jmtjscLoPbvQsqFFBHY3REQDWw2yhi/kOga9Y1lo2knDi6HmUoB/
         mmXVaftE3vLjTy6gZyUUln06K9/1ScNHFeUVRMnQq6RpwAPcVsQm3YzFeGGhSvgTI1qW
         E0lh0MW1O4FGs78DZzopGTUHb+fLYiHayEX9v8IFS3b4tZLLY6kQX6F1vmmwt5o1UeY8
         8m+TYVuypwZw5FvAwRLzARwYbaLWhYyF5qHvt4428ftH1MAhyQrjiRYxIhrc4keuazsD
         w6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5HgRUV8vc+1/isXemg17KC16Xl/Kcpdk3WdYy0RAdlM=;
        b=yEzZHCHnNYKdgSvpkg5W67MCHRr+HeFumv3WeoT65QplkSVQIhyC+45NfM0dedk7QP
         PwzIEPG0ewJUUAWYYAh8Bljj5JXA5cGK2pHHcc3ty3KnpU8hYv3mvJhRfAd6lNYwh2s9
         iKCpNB4wEx51yfm4C1C3uV+v8ZQWCpCByR4aTMOcvYjUtFcqG9hkrY3zOWPuIhn6kCQs
         T+QRD5MOlH+PazUIST5EtIxfD93jYC7YEOSUd49qo1d8SRXi/hmyEd47QC+MRWaDzdca
         YyQwI6fbVKdzyD3KNJDQnXOoeg90tIk8z08dKsTCOjx6p90RWwA3jg2R90OpE/UABn3/
         Zd+Q==
X-Gm-Message-State: AFqh2kqY6BcpzjG32VVt8XFT64vaWUS3QiINMjNxHLVh94vYjJihQRjl
        yBy9agdHhzioHpUUkAzMMmhuDi+NaJ+oAA==
X-Google-Smtp-Source: AMrXdXuwCOYbHAGwTKVGfOnMz2EeHih6qBSPuS+/gxIvG5pdIf9el0y7f4Qb018VcK4bj0oquYfXOg==
X-Received: by 2002:aa7:cd8f:0:b0:499:4130:fae with SMTP id x15-20020aa7cd8f000000b0049941300faemr3240171edv.10.1673975488482;
        Tue, 17 Jan 2023 09:11:28 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m2-20020a509302000000b0046892e493dcsm13191268eda.26.2023.01.17.09.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 09:11:27 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 02/19] bundle.c: don't leak the "args" in the "struct child_process"
Date:   Tue, 17 Jan 2023 18:11:07 +0100
Message-Id: <patch-v4-02.19-9993786ba0d-20230117T151202Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
References: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com> <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a leak that's been here since 7366096de9d (bundle API: change
"flags" to be "extra_index_pack_args", 2021-09-05), if can't verify
the bundle we didn't call child_process_clear() to clear the "args".

But rather than doing that let's verify the bundle before we start
preparing the process we're going to spawn, if we get an error we
don't need to push anything to the "args".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 bundle.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/bundle.c b/bundle.c
index 4ef7256aa11..9ebb10a8f72 100644
--- a/bundle.c
+++ b/bundle.c
@@ -627,6 +627,10 @@ int unbundle(struct repository *r, struct bundle_header *header,
 	     enum verify_bundle_flags flags)
 {
 	struct child_process ip = CHILD_PROCESS_INIT;
+
+	if (verify_bundle(r, header, flags))
+		return -1;
+
 	strvec_pushl(&ip.args, "index-pack", "--fix-thin", "--stdin", NULL);
 
 	/* If there is a filter, then we need to create the promisor pack. */
@@ -638,8 +642,6 @@ int unbundle(struct repository *r, struct bundle_header *header,
 		strvec_clear(extra_index_pack_args);
 	}
 
-	if (verify_bundle(r, header, flags))
-		return -1;
 	ip.in = bundle_fd;
 	ip.no_stdout = 1;
 	ip.git_cmd = 1;
-- 
2.39.0.1225.g30a3d88132d

