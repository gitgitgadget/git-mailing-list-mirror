Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6123CC07E95
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 00:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4840E6136E
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 00:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237236AbhGNA5H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 20:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237223AbhGNA5D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 20:57:03 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0786DC0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 17:54:12 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v5so986481wrt.3
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 17:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NEDd+eUowNv2+u11H7bEKNYEV3vvVpWW0Rosx1GkS7A=;
        b=ZrSNeQlLUWVdJvhRpbxfaG+IJLz3k4WVsmeDfXz4dCNpZgK4N+ynV+/tCIANajJHvr
         s6EoTliOuHMEN7rwuGFU3YcNMnVC6xLWoWGSU2Ni9dRXpSFP0OKC6E3aYpMxVvuVCpXA
         OLDrDQQy8l+7j3TVSaF4w/I+1T/juh3b7XJDtwKy5VvuQl3zosJa9DmXZJlnqOFZrcF4
         u/IQKrWTz89kXaEP6d0jVQIf8ptcUOHfh7cr3KhIrK/UKUwMn+veyvH4LAsZpQNGhiRC
         E9LTVPDhFNpeTYwu1B6qGFRmD9iRKsVv7siiYoTzKR4KUwDORzSCgRwaeCgUnCJdBLs0
         jbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NEDd+eUowNv2+u11H7bEKNYEV3vvVpWW0Rosx1GkS7A=;
        b=PlxsmaJ6LdO/Hr8+xnM3bRhC6TCKIx9tzLG/WpFfhp2qZB6tgwxE06EN5+432MhSYF
         uCC97ku/jjWj4hk/RC3oQFmHyTefls7T8BCCFQzclZJC5qSmvY8q5vkUh1ia4ejhWBlb
         OaJociMXuvj8dSqPqrsTVTmO94mVO2KbPI2NYpF22JGE9QaKJhUo69ELh0uvUVrQjAkQ
         hmhRfghK3JK5Np0dyfBPSDWuXuNAqqJHOj80a9B4CarvJbrCtpaSRK724hDCm1Tp2pbE
         SaySU8q4ZFOJYgYZqIOsaIvjLCkD0jb/za4dDaLZEedXBHJSfI6EWcfnadqgOBjji8tH
         /9uQ==
X-Gm-Message-State: AOAM530+MG6R1haX7oUHVTrqfelOcU9Kveooqbjz4+WXkdMfICJG07vP
        qyWM2A3pbzDYPC7yn7tkKjaQpH0UWgi11F83
X-Google-Smtp-Source: ABdhPJz9O+3UXuWALxsiPKRNxZlIiKCOT7p5bxN+W5gszpdxHYNdQCuNfZsD8MtQpRRRLogGPwonbw==
X-Received: by 2002:adf:dcca:: with SMTP id x10mr9053811wrm.59.1626224050491;
        Tue, 13 Jul 2021 17:54:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g3sm463315wru.95.2021.07.13.17.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 17:54:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 5/5] test-lib-functions.sh: remove unused [de]packetize() functions
Date:   Wed, 14 Jul 2021 02:54:05 +0200
Message-Id: <patch-5.5-7ca83c5a55-20210714T005115Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.788.ge724008458
In-Reply-To: <cover-0.5-0000000000-20210714T005115Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210712T164208Z-avarab@gmail.com> <cover-0.5-0000000000-20210714T005115Z-avarab@gmail.com>
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
index b2810478a2..77e4434dcd 100644
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
2.32.0.788.ge724008458

