Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BD3C433F5
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 18:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CBF561212
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 18:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhJTSmX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 14:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbhJTSmW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 14:42:22 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDC8C061749
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 11:40:07 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m22so311175wrb.0
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 11:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=20vmWMe51PejznLwjOmf0gpSyzewLrJ4KUREjYfruwA=;
        b=cWwUrYWQrDq6+tEL/R28soOc3PvRx4E66DUuTEnOxM5qAdkdbAfAj0aCMYTh6xOyzN
         TN928iKcV7hSKeTsjds4eHriZEEgJ6/qGKJxc+oTTgMvt4nU+y3HlIeEG+Pw7IU6j5oe
         YtR5aO/uTpXjhSKHmnIIGE+nZuAR7aIHy9kxN6UgSH2EIVQAKN57K25pZDrKTdJ5D3ic
         34I4AvLzpMkzdIEFt8BAjhEevlnErOWaxE/KXpZ9waJLwNt0U3t/186JyMW/esDpOA41
         Ngv4lB0oGipxWSKcI6u7TUoB4cI9keg2d9xYCTjdvwJro1qXKK1hOYG6L5f3hBCr5edB
         z/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=20vmWMe51PejznLwjOmf0gpSyzewLrJ4KUREjYfruwA=;
        b=UtEhI9HFKwAKOaKnilk8hEOD5DPsesMSunTUDVBr/OprB7toXy5pncafdjHpNJZnmy
         m6pxJfbUB7Acrgx32ROzDzMut85CkMv+9sHviJpdGjr1wywf9ZYF0ANf4M0S8T6NjOCL
         FYls7prS5err9Ai/fyPwfXzzZn9Ma2MocDQPG6x6UyKuoi9AhJ4uar/ZfxuMmKmOr14r
         2LikRZg5f1ZyVLQ4qrpfIU9mBsBEDRsNbJk87sBb7QG+S2zYaPs9ASHtH6eVfemB6m3m
         cimEG46GEqGpfMLQ8ZKqvKOQbODp1bgejJwJDuM3J5ksfCFvWU7Z6F940HgqVr52s/ut
         slyQ==
X-Gm-Message-State: AOAM533ORcbHzHAxHcj9ZDhYisqb/Vxs0nJ7V03Aq8gkd8h5aYGidIzk
        Ls7wsizHLlsxMTM1iboVA4oT2OTCnJdlfA==
X-Google-Smtp-Source: ABdhPJyrVRUAcFo3kbOPQpKmNKfPjSszIDAqZQCh4e2aY8u0c6Sd3eaI3eNYqSr/fit2oYsjUG23XQ==
X-Received: by 2002:adf:bb09:: with SMTP id r9mr1167379wrg.238.1634755205720;
        Wed, 20 Oct 2021 11:40:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d8sm2813835wrv.80.2021.10.20.11.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 11:40:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/8] generate-cmdlist.sh: don't call get_categories() from category_list()
Date:   Wed, 20 Oct 2021 20:39:55 +0200
Message-Id: <patch-4.8-074685cf714-20211020T183533Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
References: <YNqBtrXzUlJiuc7y@coredump.intra.peff.net> <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
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
2.33.1.1338.g20da966911a

