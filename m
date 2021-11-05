Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4EFC433EF
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 14:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6448E604AC
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 14:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbhKEOLB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 10:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbhKEOKz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 10:10:55 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B85C061714
        for <git@vger.kernel.org>; Fri,  5 Nov 2021 07:08:15 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id c4so13921321wrd.9
        for <git@vger.kernel.org>; Fri, 05 Nov 2021 07:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K6rv0kwxCCM/MMprY/zXovepVm+aWwlohdmHOvwgx14=;
        b=Axu69HVZdXNGWOSIhdvEgK6/gXSyc5fGpSFTeZ1t02UlBq+i70TeWq0J26CplA/BtL
         OEaLhGxLJGi0y96rKBnYTGTzTNkcKl+4QT0YEPIf0Ty7iDXyEiTRbuasKJdgsGcq0ybf
         w918rnPzXpXBGRSlzfCHRZ3ypufyVLwQ87c1E88/8tBcCfb1hqJUma5M9ni+As3j/kU9
         vB7cDyqq2If9fDKEna/92206+bbN5CY66wBthBDVGBQYWMa+Sz9h+4V2ChPVW/leoE0F
         kFZ8EYIvDaKwLpKNvtl0Q7MLrb0AvUk2uR3YRUJE9cjNQBdx0SX1ZqpJHlG3l8urkqJ7
         HB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K6rv0kwxCCM/MMprY/zXovepVm+aWwlohdmHOvwgx14=;
        b=upm3ySl9D/rGgPh2aQGY0AnjSIf8iejpPkpKf2GwlwKSKPp7fzV2W+Yr2kD3LS8jAX
         MKpGwjnJAUzmRtfaJrZnPvS6erv8Cgg2yQifE7G+hYJKFOvxe+lYlW3+TwbcWSrTKuYB
         mjsTnZUcUmbwcsCWAwQ9zbb993dJ96406woArhlepl/y6H0f11BXS0bcvxmN8e7B2xe5
         cXv8ISmdknX2zg6Kif3TQcP5ZXgrwdIRc+aqGSDObPGjKjpkHQBdhbGcnxrW//icZOym
         Kh2n+j7aaortF1o98k5aNNk8SwsUooO+I6Qe0Y4ADL5X/TZkxqeCyN1hfCNpWHpfm+d3
         QSEg==
X-Gm-Message-State: AOAM533Sc1tju96zoIyYyxkg7t0JfEJGvIhgXRRwQXQi+oD0nCmYlz7J
        UCoQKj9NtkpQ2OGX/IOWL5MvMwn/FeyBKw==
X-Google-Smtp-Source: ABdhPJzBBoFhai2rnYMlBCBo6TcJJYKIwTKtU0ILEnO2C//4CmceaM3r5B8fpNk0xoD0ogj0dqQoKQ==
X-Received: by 2002:a5d:6d49:: with SMTP id k9mr69821270wri.352.1636121293955;
        Fri, 05 Nov 2021 07:08:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm7821556wrs.19.2021.11.05.07.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 07:08:13 -0700 (PDT)
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
Subject: [PATCH v3 04/10] generate-cmdlist.sh: don't call get_categories() from category_list()
Date:   Fri,  5 Nov 2021 15:08:02 +0100
Message-Id: <patch-v3-04.10-6ad17ab56c2-20211105T135058Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <cover-v3-00.10-00000000000-20211105T135058Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com> <cover-v3-00.10-00000000000-20211105T135058Z-avarab@gmail.com>
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
2.34.0.rc1.721.ga0c1db665bc

