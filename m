Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC19C433DF
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 19:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0321820658
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 19:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pueR+Zzo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732766AbgHQTtE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732760AbgHQTsf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 15:48:35 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EAFC061343
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 12:48:35 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id b136so10749736pga.0
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 12:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5uYLX8xz93aQRA5XC5qOfdVCPa4+OnabcgVJHR5jmvI=;
        b=pueR+ZzowclSrWcOQW9jdcvM2/ySlRSdPHMHMhGWH2VEYwuaILpQiOrBO7zoWlGhGy
         8p/V+p1oM5CE4R6Rt26ou70x++IXRAutjYihcppkbspsV7HNAvOPkIMwl5J/s9ny2hDe
         2l0Hp4/Sog2oIszBISWtmIMe5ECBH4rbDzuby9gbasuyW6HlgkiuM+HjZm7ePgTHFhXG
         CzyNjZxdkgJLjzduiicRuz4a01D2xOV4a7o+mPPW8iXbUVl22qDrF9BXMt/5lmuM6Fng
         b1nru7DQTibtbysHA4hI7QHhgM+WuMfWJj5PzBJozGoTTo7v3te2HBBkV28LFfNhUvTc
         s8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5uYLX8xz93aQRA5XC5qOfdVCPa4+OnabcgVJHR5jmvI=;
        b=tIcuNoVReV7QgSOh7+rwdaBtVHMHdPDVfK0IKGmLjBVQWkGgeLljs/bQJghFV7x8jG
         Lbra0HGcBNRwW6gk9ehiTi971xyHeUN/EUauU9AI9DB+Q6q/7AfCQD6YLtC1CYbqtDMR
         A2k46qps5CcnQ9hHycgUXojjFcgEqykLNNzWVGWWPbFmDIG0stKWVPqCYx8QG4A9AbLZ
         As/DBWEFqEwD86LKygTxWDAhB+ZYmEPTexKwqlu+UDvPrjhT2P2BHk/RoMSv4bibATTv
         MyfqMfJWMORfHcXGgRwrGtB0c6e/417gA/Nx8BhpRzF8Bvwhy3iYv4yhsAgJc99Sq2iR
         7M6g==
X-Gm-Message-State: AOAM5335OWrc4N/Z9KYHaxjv0EeuB6ML/sZoU9yKi2p7zAh+yr8ZgubG
        U8Px+fxr69bhH0Qx/QIJFRbB4kL7xKTIq27epoUxYAMZlRzplMljf31kAH+0HBkphd21INMVL49
        BDSsAhhZ3n/Xruiq/LcDdv5InzbwKVHHUKk/rhYSAdHiJu1Q8q0Pp2IqfXLnTjkD4dgMDdCPuU5
        Yq
X-Google-Smtp-Source: ABdhPJzmXnPx9D7ZjEg2qLbc3/G3aczXv3wTaeacc+LuPtGwbA2y7VcpDLndMxo556al6H+pNcmLh6VD0Yb+QKj5qs5z
X-Received: by 2002:a17:90a:bc96:: with SMTP id x22mr14515772pjr.164.1597693713775;
 Mon, 17 Aug 2020 12:48:33 -0700 (PDT)
Date:   Mon, 17 Aug 2020 12:48:20 -0700
In-Reply-To: <cover.1597693540.git.jonathantanmy@google.com>
Message-Id: <53270b3033967bec664a264a1770e47cb4c12348.1597693540.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200814193234.3072139-1-jonathantanmy@google.com> <cover.1597693540.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH v2 3/3] fetch-pack: make packfile URIs work with transfer.fsckobjects
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When fetching with packfile URIs and transfer.fsckobjects=1, use the
--fsck-objects instead of the --strict flag when invoking index-pack so
that links are not checked, only objects. This is because incomplete
links are expected. (A subsequent connectivity check will be done when
all the packs have been downloaded regardless of whether
transfer.fsckobjects is set.)

This is similar to 98a2ea46c2 ("fetch-pack: do not check links for
partial fetch", 2018-03-15), but for packfile URIs instead of partial
clones.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
The subject is longer than 50 characters but I couldn't find a way to
shorten it, especially since I think it's important to mention packfile
URIs and transfer.fsckobjects. Any suggestions appreciated.
---
 fetch-pack.c           |  2 +-
 t/t5702-protocol-v2.sh | 53 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 289121038e..0f1a84c061 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -896,7 +896,7 @@ static int get_pack(struct fetch_pack_args *args,
 	    : transfer_fsck_objects >= 0
 	    ? transfer_fsck_objects
 	    : 0) {
-		if (args->from_promisor)
+		if (args->from_promisor || !only_packfile)
 			/*
 			 * We cannot use --strict in index-pack because it
 			 * checks both broken objects and links, but we only
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 5a60fbe3ed..8c6c67b10d 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -883,6 +883,59 @@ test_expect_success 'fetching with valid packfile URI but invalid hash fails' '
 	test_i18ngrep "pack downloaded from.*does not match expected hash" err
 '
 
+test_expect_success 'packfile-uri with transfer.fsckobjects' '
+	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	rm -rf "$P" http_child log &&
+
+	git init "$P" &&
+	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
+
+	echo my-blob >"$P/my-blob" &&
+	git -C "$P" add my-blob &&
+	git -C "$P" commit -m x &&
+
+	configure_exclusion "$P" my-blob >h &&
+
+	sane_unset GIT_TEST_SIDEBAND_ALL &&
+	git -c protocol.version=2 -c transfer.fsckobjects=1 \
+		-c fetch.uriprotocols=http,https \
+		clone "$HTTPD_URL/smart/http_parent" http_child &&
+
+	# Ensure that there are exactly 4 files (2 .pack and 2 .idx).
+	ls http_child/.git/objects/pack/* >filelist &&
+	test_line_count = 4 filelist
+'
+
+test_expect_success 'packfile-uri with transfer.fsckobjects fails on bad object' '
+	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	rm -rf "$P" http_child log &&
+
+	git init "$P" &&
+	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
+
+	cat >bogus-commit <<EOF &&
+tree $EMPTY_TREE
+author Bugs Bunny 1234567890 +0000
+committer Bugs Bunny <bugs@bun.ni> 1234567890 +0000
+
+This commit object intentionally broken
+EOF
+	BOGUS=$(git -C "$P" hash-object -t commit -w --stdin <bogus-commit) &&
+	git -C "$P" branch bogus-branch "$BOGUS" &&
+
+	echo my-blob >"$P/my-blob" &&
+	git -C "$P" add my-blob &&
+	git -C "$P" commit -m x &&
+
+	configure_exclusion "$P" my-blob >h &&
+
+	sane_unset GIT_TEST_SIDEBAND_ALL &&
+	test_must_fail git -c protocol.version=2 -c transfer.fsckobjects=1 \
+		-c fetch.uriprotocols=http,https \
+		clone "$HTTPD_URL/smart/http_parent" http_child 2>error &&
+	test_i18ngrep "invalid author/committer line - missing email" error
+'
+
 # DO NOT add non-httpd-specific tests here, because the last part of this
 # test script is only executed when httpd is available and enabled.
 
-- 
2.28.0.220.ged08abb693-goog

