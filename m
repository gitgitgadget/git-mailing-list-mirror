Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CB7C433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 19:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FDDD610FF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 19:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbhJVTi4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 15:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbhJVTio (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 15:38:44 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF770C06122A
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 12:36:24 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e12so20786wra.4
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 12:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pF4GBms6PE4O5l10FOHXxaZ5qkF2CdBliJtOD1kcQNI=;
        b=aLLYO2bNJdp6huZ3A59F3N0rGKSo6LhJfok7DH4CWMCGzQTODBIioC84Z8hfpKs3Ka
         pQo/nO2IHExq2q3MuPPaoEwZgqTX2t6u9P3MTC5tGoaYkbGienho3OJlo5SuW3K34xQ0
         Nn6rfTGItIWEimO9NrkjcFJ3L8WnoUO7iQLNi224d6JH1JEq/+PiSDnhqbHdMAKjG763
         3ZhTyJgPebg4lxt4pOfTGACYelVhhtqmtIJoi1He/CXxyaLiAQHNOmBhmzJ19Lvo4Cgn
         xEPqwCnYNuil3CQ3swLQQvoeYdI9s+q9zfCW/PVd6suDCEIGqCKjCOXGStIghO7AE6RQ
         +89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pF4GBms6PE4O5l10FOHXxaZ5qkF2CdBliJtOD1kcQNI=;
        b=sES4e1RUY9/LTL6ePSU9adxf3ZjokGd4uTP/A+cCiAkKHhqNcOCCqnyCNgAoZ9DVRF
         3FwX2FtVQ+3vLGvKdjy/SJ9qE0u6Zah+vOwdA0QdtfpmojvfXIjOgSwAAgBjNYrcQZPC
         lP4Rt5sKNIMO3bH+XKQyMh4cYwGGUMJNOPw2cNYPN0gONlxHx6LGquek/eD61TmlDnyn
         KOrY7ViHKQssg8nKdmO14djqP3BVShR1RstjUb1mc4RAxgQnpUN7W5xaD5M2U7PATE1z
         wGrkGbMo951j5cti/Y52oYsdw5WW5pOlw5YCVXwxh63/fuW2hfkcb2jdpRm96JBHcDQN
         aTZg==
X-Gm-Message-State: AOAM5312zR1nJCJZOaKWydtgYqw8FncHKLfye+MZvdiF46eYB2GLP+D4
        RL0bqQs6DesyTO3IW2tRymjJ9XXDPYPRjg==
X-Google-Smtp-Source: ABdhPJyMvuCCnddL/aBviNrmZ9YTjLzZattzuZS9T+O+xGxmFe1aWtbQbqpVpQU9sMwubwXP5ZS3Mg==
X-Received: by 2002:a5d:6501:: with SMTP id x1mr2231842wru.77.1634931383162;
        Fri, 22 Oct 2021 12:36:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q7sm8871814wrs.73.2021.10.22.12.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 12:36:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 08/10] generate-cmdlist.sh: do not shell out to "sed"
Date:   Fri, 22 Oct 2021 21:36:12 +0200
Message-Id: <patch-v2-08.10-83318d6c0da-20211022T193027Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1505.g075a284c562
In-Reply-To: <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Replace the "sed" invocation in get_synopsis() with a pure-shell
version. This speeds up generate-cmdlist.sh significantly. Compared to
HEAD~ (old) and "master" we are, according to hyperfine(1):

  'sh generate-cmdlist.sh command-list.txt' ran
   12.69 ± 5.01 times faster than 'sh generate-cmdlist.sh.old command-list.txt'
   18.34 ± 3.03 times faster than 'sh generate-cmdlist.sh.master command-list.txt'

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 generate-cmdlist.sh | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index f50112c50f8..9b7d6aea629 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -17,16 +17,6 @@ category_list () {
 	LC_ALL=C sort -u
 }
 
-get_synopsis () {
-	sed -n '
-		/^NAME/,/'"$1"'/H
-		${
-			x
-			s/.*'"$1"' - \(.*\)/N_("\1")/
-			p
-		}' "Documentation/$1.txt"
-}
-
 define_categories () {
 	echo
 	echo "/* Command categories */"
@@ -61,7 +51,18 @@ print_command_list () {
 	command_list "$1" |
 	while read cmd rest
 	do
-		printf "	{ \"$cmd\", $(get_synopsis $cmd), 0"
+		synopsis=
+		while read line
+		do
+			case "$line" in
+			"$cmd - "*)
+				synopsis=${line#$cmd - }
+				break
+				;;
+			esac
+		done <"Documentation/$cmd.txt"
+
+		printf '\t{ "%s", N_("%s"), 0' "$cmd" "$synopsis"
 		printf " | CAT_%s" $rest
 		echo " },"
 	done
-- 
2.33.1.1505.g075a284c562

