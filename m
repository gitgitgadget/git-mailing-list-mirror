Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898B7C4332F
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 19:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C6D46112D
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 19:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbhJVTip (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 15:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbhJVTij (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 15:38:39 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EFFC061764
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 12:36:21 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 84-20020a1c0457000000b003232b0f78f8so4648859wme.0
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 12:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/48j55kY2mE+sSQaGXhY6fgK7v6zXJHolUpxAUWD5oM=;
        b=jvv0I2fvc3DoqOM4ZNw3QiA1eAXeB3kmLkbhAkQGNTDar8cI4Q9mbhN6t4HVytY49x
         Ge+NnqAqZ0EG7BD1fQuIU/9pSoSuajf5swBYoi10ZyuKyUhZ//SsIoWh9e61bvg+MD4a
         LOJqxlp/kPw69/W28cvhw4R6tApCeqxdDvpDDZBpwd3Z2iqb8mpT0xpRyOHNfqGm4TMq
         eGPVdZFJ5L7JHMrN3tvzsdPJ3UZ69cSz5k1wCjeJTgQhe78r8fnLqICkdwVF2dXpy7jY
         Z+HsLeO0PWbKoZte5Hh9VewWrXh+zq2C1spqyN2wqnoO+65ZbuCsILZAtph473LOH7vR
         8Vaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/48j55kY2mE+sSQaGXhY6fgK7v6zXJHolUpxAUWD5oM=;
        b=UA8vJ7BCTkVrfE0CUofa+FlKJtQvfNwb4hmM/6bgw4TeALcz90I/PraEcvw0cMO6OK
         ZsGrL2f+3GwK/LD9w0bsv7e5/hdA0go00cvhuafmx+nxA7NQNQNwiH1PdDYm+DVj+9dq
         T/QVdnhpYZ9uiGdPcCfRLoAUDKIJnc45TEN2YJHXE47Q5PuFjshRWQ/Z8xCtxxk4aJlO
         MdrmJlbeGZxvqE6KpRyGz+WNiLkOlB1KjfG09sRTPmxnKWJmBmd9B+nKI8/o5kfsAuoM
         nHFNsvr2nlDHV0T5q7jxH9xvatOBhebQZIXN4/E3LxIrHkrXBi4yN2/MIKCd8WO+SEix
         n6gg==
X-Gm-Message-State: AOAM532yviJiSeBNWxnpyxloHorljPrEyw1sJhI2LQg/QMMCDS1t4sFc
        u6dqwNJ+doiy0ISKf3CSzp0XskbnbH2nXQ==
X-Google-Smtp-Source: ABdhPJwhe89Q62X8UbIzd7riaqDdBk1GtIqErqZV3deZHI4nYaTeIZFwMoqJGlFUD3KTQ/c+KfXM/g==
X-Received: by 2002:a1c:ac86:: with SMTP id v128mr1797772wme.3.1634931380069;
        Fri, 22 Oct 2021 12:36:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q7sm8871814wrs.73.2021.10.22.12.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 12:36:19 -0700 (PDT)
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
Subject: [PATCH v2 04/10] generate-cmdlist.sh: don't call get_categories() from category_list()
Date:   Fri, 22 Oct 2021 21:36:08 +0200
Message-Id: <patch-v2-04.10-074685cf714-20211022T193027Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1505.g075a284c562
In-Reply-To: <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This isn't for optimization as the get_categories() is a purely shell
function, but rather for ease of readability, let's just inline these
two lines. We'll be changing this code some more in subsequent commits
to make this worth it.

Rename the get_categories() function to get_category_line(), since
that's what it's doing now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 generate-cmdlist.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 27367915611..16043e38476 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -9,7 +9,7 @@ command_list () {
 	eval "grep -ve '^#' $exclude_programs" <"$1"
 }
 
-get_categories () {
+get_category_line () {
 	tr ' ' '\012' |
 	LC_ALL=C sort -u
 }
@@ -17,7 +17,8 @@ get_categories () {
 category_list () {
 	command_list "$1" |
 	cut -c 40- |
-	get_categories |
+	tr ' ' '\012' |
+	LC_ALL=C sort -u |
 	grep -v '^$'
 }
 
@@ -66,7 +67,7 @@ print_command_list () {
 	while read cmd rest
 	do
 		printf "	{ \"$cmd\", $(get_synopsis $cmd), 0"
-		for cat in $(echo "$rest" | get_categories)
+		for cat in $(echo "$rest" | get_category_line)
 		do
 			printf " | CAT_$cat"
 		done
-- 
2.33.1.1505.g075a284c562

