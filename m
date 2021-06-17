Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6D6C48BE5
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 805E4613CA
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbhFQKz6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbhFQKzx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:55:53 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCC0C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:53:44 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n23so3142219wms.2
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QJmx2dtKJhz5xJ/KMDdnCv2VD0UIKcQn4RnB/rSWwyo=;
        b=VyYZV4MKOoSxToJZkZdcvUehJzekpx1tOHJ4qmtIiLDkMjQldqqhSAqizdLvtIHTBY
         4R/dGeMQomRCVG40D6VhmA+1jVxIytsabAE33ndBTOlJXANs0SEWowx8g2wm8ct/MII2
         H+cg4psXO+SZBFUnsktO4kCLUatpuk6TdmgsExFkQYXdEIi8wl7Eg1NGM0sJhLfmB5Tj
         5Cy5j5tVO7xOAUiyZaDq33rQm7mINe7jKmYDK6Az9KqfMK/ZMtzJAlhBnyR2y/aXsxuu
         Y+J9Jxm8rP8t37Zc+42Oq8DVWU9LVkxRhjG+4zpb+1rteWWea+BD6aBhkgNhp2Do/K7i
         X9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QJmx2dtKJhz5xJ/KMDdnCv2VD0UIKcQn4RnB/rSWwyo=;
        b=psml7d4kx4YIasBCcXGS+c/OxrbvoCpO1i8N4+zIyfFaosHjCqOmWQ3sCPhlsvo1Wo
         fXM63wsADoLxwli+rFfa+sAOS0BzV8kde+e6kFdfCg4nkglFb9/QSn2WDrFbZTSIHJC+
         bUJyoDLPFM9c3NG+8dsOHYACHd/POFY6bAKXeZkZb1LXHnvLA+MClCyAwjeonHuVtcbG
         hFubPF+D4W93QBdOtyeXS/CGQvuhluep1fg60tZlUpTtir00Rbd8SBpWwCfHjklRz5qH
         T7pAsjC3qYt/HHS3l/WiP9EyFK4WHZlf5KSrHPfI1FcHLsNUjvivyIbIWclWyyTjMT5+
         3v8w==
X-Gm-Message-State: AOAM530XDyr4jlVsh7rL7ml9/zt5FsanWTRp8EnDQjR3kYLvlXpxj0vz
        HbPgj8TDcgVd68uSTEw0oMOWxGjiJnOq7w==
X-Google-Smtp-Source: ABdhPJy4bJ2xLyyxmt76gRja/gitw/PYMb/jYe/hfzkzO9YVkOprp6vT/k40RYgh1XLSAz+NUFGfyQ==
X-Received: by 2002:a05:600c:218c:: with SMTP id e12mr4372888wme.92.1623927223128;
        Thu, 17 Jun 2021 03:53:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 61sm5409586wrp.4.2021.06.17.03.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:53:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael J Gruber <git@grubix.eu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/4] show-branch: don't <COLOR></RESET> for space characters
Date:   Thu, 17 Jun 2021 12:53:37 +0200
Message-Id: <patch-3.4-937e728f7f-20210617T105245Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.571.gdba276db2c
In-Reply-To: <cover-0.4-0000000000-20210617T105245Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20210614T171626Z-avarab@gmail.com> <cover-0.4-0000000000-20210617T105245Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the colored output introduced in ab07ba2a24 (show-branch: color
the commit status signs, 2009-04-22) to not color and reset each
individual space character we use for padding. The intent is to color
just the "!", "+" etc. characters.

This makes the output easier to test, so let's do that now. The test
would be much more verbose without a color/reset for each space
character. Since the coloring cycles through colors we previously had
a "rainbow of space characters".

In theory this breaks things for anyone who's relying on the exact
colored output of show-branch, in practice I'd think anyone parsing it
isn't actively turning on the colored output.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/show-branch.c  |  9 ++++++---
 t/t3202-show-branch.sh | 30 ++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index d6d2dabeca..d77ce7aeb3 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -939,9 +939,12 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 					mark = '*';
 				else
 					mark = '+';
-				printf("%s%c%s",
-				       get_color_code(i),
-				       mark, get_color_reset_code());
+				if (mark == ' ')
+					putchar(mark);
+				else
+					printf("%s%c%s",
+					       get_color_code(i),
+					       mark, get_color_reset_code());
 			}
 			putchar(' ');
 		}
diff --git a/t/t3202-show-branch.sh b/t/t3202-show-branch.sh
index 7b06048905..54025f0337 100755
--- a/t/t3202-show-branch.sh
+++ b/t/t3202-show-branch.sh
@@ -55,4 +55,34 @@ test_expect_success 'show-branch with showbranch.default' '
 	test_cmp expect actual
 '
 
+test_expect_success 'show-branch --color output' '
+	sed "s/^> //" >expect <<-\EOF &&
+	> <RED>!<RESET> [branch1] branch1
+	>  <GREEN>!<RESET> [branch2] branch2
+	>   <YELLOW>!<RESET> [branch3] branch3
+	>    <BLUE>!<RESET> [branch4] branch4
+	>     <MAGENTA>!<RESET> [branch5] branch5
+	>      <CYAN>!<RESET> [branch6] branch6
+	>       <BOLD;RED>!<RESET> [branch7] branch7
+	>        <BOLD;GREEN>!<RESET> [branch8] branch8
+	>         <BOLD;YELLOW>!<RESET> [branch9] branch9
+	>          <BOLD;BLUE>*<RESET> [branch10] branch10
+	> ----------
+	>          <BOLD;BLUE>*<RESET> [branch10] branch10
+	>         <BOLD;YELLOW>+<RESET>  [branch9] branch9
+	>        <BOLD;GREEN>+<RESET>   [branch8] branch8
+	>       <BOLD;RED>+<RESET>    [branch7] branch7
+	>      <CYAN>+<RESET>     [branch6] branch6
+	>     <MAGENTA>+<RESET>      [branch5] branch5
+	>    <BLUE>+<RESET>       [branch4] branch4
+	>   <YELLOW>+<RESET>        [branch3] branch3
+	>  <GREEN>+<RESET>         [branch2] branch2
+	> <RED>+<RESET>          [branch1] branch1
+	> <RED>+<RESET><GREEN>+<RESET><YELLOW>+<RESET><BLUE>+<RESET><MAGENTA>+<RESET><CYAN>+<RESET><BOLD;RED>+<RESET><BOLD;GREEN>+<RESET><BOLD;YELLOW>+<RESET><BOLD;BLUE>*<RESET> [branch10^] initial
+	EOF
+	git show-branch --color=always $(cat branches.sorted) >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.32.0.571.gdba276db2c

