Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C165DC64EC7
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 23:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjB1Xjd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Feb 2023 18:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjB1Xj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2023 18:39:26 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B3F1E9FA
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 15:39:21 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id n5so6837897pfv.11
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 15:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Syi9vijVL7Q/2pM2l3efi+7l0N2Gh0Ss7ILslH1zD2U=;
        b=K8Rftfv2b8TXOpJaeOKvhjVRttj0a3DOOUJcgct5BGYriQNx3f6zsY0AfQT6V30cfZ
         MV9hiqtvqwUS2zpRFwySdo5B4Y4x/OhmrAtYD6WOT70CgZsHkJ5nn7+ejzf+zlqTfZQX
         /iYTsIjhebRrVG/6yKRNATQoGLJ9Cd1FGhd8FPL+HFnW6kcbTud6/TAvMPW3KgR8LQFX
         /8uuvxRLwyBbnRGP1Q99S/2m3WQJqNkCYigmRSFNnS61i4kPX9PDctU7wAGRby/f0gWi
         AGI3esAn01xLp82bjXFkV5YUhC+0cdxRatLbDBVV6/FDXA0pUGE4zaOEnJ9jvQyVbJpa
         4U6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Syi9vijVL7Q/2pM2l3efi+7l0N2Gh0Ss7ILslH1zD2U=;
        b=D8nMvHFN1u1BgmzIxgaMYXjFMgnMaaSfVX9mOSIxXHbtC26cb8/au2stLxWWJe/D9r
         PXYgDSkbHFtVC0uMkeADREb0o4MXrMsWOa3G3FaKybnbWuBWxxTyovKE9+IKO/SAUc2B
         Un9I+QxxxnoMpd/7g+J8jYaY/neHW9+BzHFvEGlcGid+Ow+6rexQ62OIXPlPzKmRN3xL
         QfMEE1LtpLSRxOP5h5O4qyHqW/rz7pazyIyuIZvdu3wLDNvlt948hSHlML8tYrwecODC
         BWYIUwFcfkavnpPQoNaBo+A2JP9sDmbVA6n6TqhUlpg6HPKUKlbBAeQfey1qibQYCZ69
         ghkg==
X-Gm-Message-State: AO0yUKVBZfgsCdCN12nQKAH7ulb115ibG6V9Zq8BAbHPu/A4g/y3KNDA
        OIw6TtgpSCnuZSYWoH2yBhq180vAjDc=
X-Google-Smtp-Source: AK7set/tcLjAGY3MpZ8IM+2poUvHM/mTGUfydNhAN6KcKWLFZnl0fyRg+DQEhQAJfQsgXUTGJjxDVg==
X-Received: by 2002:a05:6a00:4c8f:b0:5a8:473e:2fdc with SMTP id eb15-20020a056a004c8f00b005a8473e2fdcmr13378833pfb.12.1677627560553;
        Tue, 28 Feb 2023 15:39:20 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id a17-20020aa780d1000000b00588e0d5124asm6523905pfn.160.2023.02.28.15.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 15:39:20 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 08/20] t5551: handle v2 protocol when checking curl trace
Date:   Tue, 28 Feb 2023 15:39:01 -0800
Message-Id: <20230228233913.684853-8-gitster@pobox.com>
X-Mailer: git-send-email 2.40.0-rc0-32-ga0f05f6840
In-Reply-To: <20230228233913.684853-1-gitster@pobox.com>
References: <20230228233913.684853-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

After cloning an http repository, we check the curl trace to make sure
the expected requests were made. But since the expected trace was never
updated to handle v2, it is only run when you ask the test suite to run
in v0 mode (which hardly anybody does).

Let's update it to handle both protocols. This isn't too hard since v2
just sends an extra header and an extra request. So we can just annotate
those extra lines and strip them out for v0 (and drop the annotations
for v2). I didn't bother handling v1 here, as it's not really of
practical interest (it would drop the extra v2 request, but still have
the "git-protocol" lines).

There's a similar tweak needed at the end. Since we check the
"accept-encoding" value loosely, we grep for it rather than finding it
in the verbatim trace. This grep insists that there are exactly 2
matches, but of course in v2 with the extra request there are 3. We
could tweak the number, but it's simpler still to just check that we saw
at least one match. The verbatim check already confirmed how many
instances of the header we have; we're really just checking here that
"gzip" is in the value (it's possible, of course, that the headers could
have different values, but that seems like an unlikely bug).

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5551-http-fetch-smart.sh | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 4191174584..9d99cefb92 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -33,12 +33,13 @@ test_expect_success 'create http-accessible bare repository' '
 setup_askpass_helper
 
 test_expect_success 'clone http repository' '
-	cat >exp <<-EOF &&
+	cat >exp.raw <<-EOF &&
 	> GET /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1
 	> accept: */*
 	> accept-encoding: ENCODINGS
 	> accept-language: ko-KR, *;q=0.9
 	> pragma: no-cache
+	{V2} > git-protocol: version=2
 	< $HTTP_PROTO 200 OK
 	< pragma: no-cache
 	< cache-control: no-cache, max-age=0, must-revalidate
@@ -48,13 +49,32 @@ test_expect_success 'clone http repository' '
 	> content-type: application/x-git-upload-pack-request
 	> accept: application/x-git-upload-pack-result
 	> accept-language: ko-KR, *;q=0.9
+	{V2} > git-protocol: version=2
 	> content-length: xxx
 	< HTTP/1.1 200 OK
 	< pragma: no-cache
 	< cache-control: no-cache, max-age=0, must-revalidate
 	< content-type: application/x-git-upload-pack-result
+	{V2} > POST /smart/repo.git/git-upload-pack HTTP/1.1
+	{V2} > accept-encoding: ENCODINGS
+	{V2} > content-type: application/x-git-upload-pack-request
+	{V2} > accept: application/x-git-upload-pack-result
+	{V2} > accept-language: ko-KR, *;q=0.9
+	{V2} > git-protocol: version=2
+	{V2} > content-length: xxx
+	{V2} < HTTP/1.1 200 OK
+	{V2} < pragma: no-cache
+	{V2} < cache-control: no-cache, max-age=0, must-revalidate
+	{V2} < content-type: application/x-git-upload-pack-result
 	EOF
 
+	if test "$GIT_TEST_PROTOCOL_VERSION" = 0
+	then
+		sed "/^{V2}/d" <exp.raw >exp
+	else
+		sed "s/^{V2} //" <exp.raw >exp
+	fi &&
+
 	GIT_TRACE_CURL=true LANGUAGE="ko_KR.UTF-8" \
 		git clone --quiet $HTTPD_URL/smart/repo.git clone 2>err &&
 	test_cmp file clone/file &&
@@ -107,17 +127,11 @@ test_expect_success 'clone http repository' '
 		/^< transfer-encoding: /d
 	" >actual &&
 
-	# NEEDSWORK: If the overspecification of the expected result is reduced, we
-	# might be able to run this test in all protocol versions.
-	if test "$GIT_TEST_PROTOCOL_VERSION" = 0
-	then
-		sed -e "s/^> accept-encoding: .*/> accept-encoding: ENCODINGS/" \
-				actual >actual.smudged &&
-		test_cmp exp actual.smudged &&
+	sed -e "s/^> accept-encoding: .*/> accept-encoding: ENCODINGS/" \
+			actual >actual.smudged &&
+	test_cmp exp actual.smudged &&
 
-		grep "accept-encoding:.*gzip" actual >actual.gzip &&
-		test_line_count = 2 actual.gzip
-	fi
+	grep "accept-encoding:.*gzip" actual >actual.gzip
 '
 
 test_expect_success 'fetch changes via http' '
-- 
2.40.0-rc0-32-ga0f05f6840

