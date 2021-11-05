Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DF8C433EF
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 14:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9E846120A
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 14:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbhKEOLH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 10:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbhKEOK6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 10:10:58 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9D1C06120D
        for <git@vger.kernel.org>; Fri,  5 Nov 2021 07:08:18 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id z200so7169430wmc.1
        for <git@vger.kernel.org>; Fri, 05 Nov 2021 07:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X1RyICBBO/RV1R6X3wSfVjR+RdYOF/gaJiA/n8V6cBA=;
        b=Pep0kGMD3g9rTtACjmoPpzRGVHzB5SlqKj2wyOrtHN0ty+71J7pBKkMZOQGcnIdetm
         dsTMKttoLnc8hQD0dcSSQfFi9QnMACinIbjaGWI/FNMCbTqcn5D8wijsb/ySodrhcUQU
         X6WoKOb9Ja76n/UrWIgFBRjyc1Mz3JI8GOUUgr5X0gM6AQmgbZ5nhan8tweI08H6IMCo
         oUqRugYKPKaYvgRw0IGeloE/Er1gDWTSztpjFWat11FxBZexZvXC13GDrjvaV5Xo3rL5
         Kdd3wTTZ+fQ+xns0lL2/q4+zQAzfKbZW+3BegturrXsrJbanSQRb4JlXFQCTaNEyqm1t
         f2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X1RyICBBO/RV1R6X3wSfVjR+RdYOF/gaJiA/n8V6cBA=;
        b=R5l1k+6HJmrsIMc1souB6gvL6E5kpUUZ/ZQWlxjjGWqSsjiIkHH2HvG0+f0vqZQaky
         LBEg+Pnd1KHzY1If56Q01Q6Oht0/hjNSODerRVGHmOImQn37Jkbc1eEVV93QRzWNL7ma
         pv0eQVz3aAIZzmhIhAIrWWTpEWR1aXCxvDz3kxFZKNUQIKJ0C6XUzXMWWlEj99cjvqf5
         dsWRHe4CMKhyfJUImDwXkyHaHrJFSPIVabKJT4K5O2OQAjHhdySOf+/19ZejERXX6vTZ
         7XtnnGsM4WDIXBmc/x4yUqyxY5BOwrYacuYiDQ+CiX1y7JaDTuLKSoP3kLAj68LM6qeU
         I7Pw==
X-Gm-Message-State: AOAM532Gbhrlsr4atmFlbd7DpnhUyX0iI4nNTNtuQWd5/Ka2BjGC7f1f
        pNZjrOk6HIyuyyh34kNqA/ZWbfe48Ppjmg==
X-Google-Smtp-Source: ABdhPJxMsIIhjo8NeMw/0qZTnf9TNDXjmh9M3U/U7MSd9G7oIsfjcxta4tj5s/KsKAi86F1ZENw2gg==
X-Received: by 2002:a1c:9842:: with SMTP id a63mr30993346wme.102.1636121296898;
        Fri, 05 Nov 2021 07:08:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm7821556wrs.19.2021.11.05.07.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 07:08:16 -0700 (PDT)
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
Subject: [PATCH v3 08/10] generate-cmdlist.sh: do not shell out to "sed"
Date:   Fri,  5 Nov 2021 15:08:06 +0100
Message-Id: <patch-v3-08.10-aeeecc575fb-20211105T135058Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <cover-v3-00.10-00000000000-20211105T135058Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com> <cover-v3-00.10-00000000000-20211105T135058Z-avarab@gmail.com>
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
2.34.0.rc1.721.ga0c1db665bc

