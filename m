Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6767C07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 10:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D13A61CA8
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 10:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhGGKYs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 06:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbhGGKYm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 06:24:42 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB71DC061764
        for <git@vger.kernel.org>; Wed,  7 Jul 2021 03:22:01 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso2940605wmc.1
        for <git@vger.kernel.org>; Wed, 07 Jul 2021 03:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S/GVjTk3aqpXNzO8A5EMSTIT1hswSeFxGqqYdlv0vKQ=;
        b=FlLCbZi6usXceudnb87uIUBpb94+vwwWImHTDoqirbPBOKst5MyPABctnQJ02P2KWF
         dwEU+oRoALflF4XaovWmWoROkiliwxIAjgChbdgGMzlgfPeOXj0KdV3W1lhDnpwOSUKk
         M+NHzln4aL24nq2f8t3bpTzmolIaYqtsLIQz1kMS97M0CEdYLtzHUhEF05cfM7wWekfs
         4E22Y0+qGkX+ygOCc7R15eh3Qr1mHIOG4xObYBWSMPmx6+vVhPEJa0Td1pTqq+LnubxG
         dUJ49G40ajiQHQIlB1nuO+K69Dn4ov1q3ADLYtMPfo2Hn5V5u6qI5kJCdnoDtCPr8ZEM
         LveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S/GVjTk3aqpXNzO8A5EMSTIT1hswSeFxGqqYdlv0vKQ=;
        b=ajQibfIbqpxkUpSEB2CDtnT39VTInBY63pK0+GIl4vZu2celBEUHARlkGeRB20ndme
         IkAbeHneAASDsNfNqrxA2tOmpVA0bu7v75DxmHCg+CO4iAX2Smco4MEDPkcY8dE1n6EA
         Rer2R4SRQ/nn/Xf3ORRtWscy8dnp+4lUqGteoeZwrU04J/WoPbNkvpaGvKOyzLTzdklY
         2esAFF5R8jBrxd0rMKbU0Xa/PW6A05lOfTFOdhRqR0WpusDp3ogQaoPhhHxDbVcnUoBF
         Pw6/9coyv0rAWdpkuX8uwerQ4j7B4Ya2t9/6W+yPvD6BXOLccDhkhpGNzmGEm/geCm/L
         VRug==
X-Gm-Message-State: AOAM532Tl3BLu8Tfuyei3iFgEjrCPl755vuxtf0YJ+hDR8/57Xlv+qdP
        TLoFJiCf59opmlE3Ka5yKXVceYYghuK00g==
X-Google-Smtp-Source: ABdhPJzFYOTp1CnHhNJBf3rKTVcUCM1Cb1Wx7b64TAIqfeBn7LqdYpEkbzZZ95VucCAxqaD3iIGDpA==
X-Received: by 2002:a1c:38c7:: with SMTP id f190mr6056830wma.29.1625653320169;
        Wed, 07 Jul 2021 03:22:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y8sm19701187wrr.76.2021.07.07.03.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 03:21:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/5] test-lib-functions.sh: remove unused [de]packetize() functions
Date:   Wed,  7 Jul 2021 12:21:49 +0200
Message-Id: <patch-5.5-2d22b83971a-20210707T101549Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-0.5-00000000000-20210707T101549Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210707T101549Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the now-unused "packetize()" and "depacketize()" functions
added in 4414a150025 (t/lib-git-daemon: add network-protocol helpers,
2018-01-24). As discussed in the preceding commits we've now moved all
their users over to "test-tool pkt-line".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-functions.sh | 42 -----------------------------------------
 1 file changed, 42 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index f0448daa74b..13971aa4e34 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1453,48 +1453,6 @@ nongit () {
 	)
 } 7>&2 2>&4
 
-# convert function arguments or stdin (if not arguments given) to pktline
-# representation. If multiple arguments are given, they are separated by
-# whitespace and put in a single packet. Note that data containing NULs must be
-# given on stdin, and that empty input becomes an empty packet, not a flush
-# packet (for that you can just print 0000 yourself).
-packetize () {
-	if test $# -gt 0
-	then
-		packet="$*"
-		printf '%04x%s' "$((4 + ${#packet}))" "$packet"
-	else
-		perl -e '
-			my $packet = do { local $/; <STDIN> };
-			printf "%04x%s", 4 + length($packet), $packet;
-		'
-	fi
-}
-
-# Parse the input as a series of pktlines, writing the result to stdout.
-# Sideband markers are removed automatically, and the output is routed to
-# stderr if appropriate.
-#
-# NUL bytes are converted to "\\0" for ease of parsing with text tools.
-depacketize () {
-	perl -e '
-		while (read(STDIN, $len, 4) == 4) {
-			if ($len eq "0000") {
-				print "FLUSH\n";
-			} else {
-				read(STDIN, $buf, hex($len) - 4);
-				$buf =~ s/\0/\\0/g;
-				if ($buf =~ s/^[\x2\x3]//) {
-					print STDERR $buf;
-				} else {
-					$buf =~ s/^\x1//;
-					print $buf;
-				}
-			}
-		}
-	'
-}
-
 # Converts base-16 data into base-8. The output is given as a sequence of
 # escaped octals, suitable for consumption by 'printf'.
 hex2oct () {
-- 
2.32.0.636.g43e71d69cff

