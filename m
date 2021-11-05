Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2526C433FE
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 14:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9900604AC
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 14:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbhKEOLG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 10:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbhKEOK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 10:10:57 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A98C061205
        for <git@vger.kernel.org>; Fri,  5 Nov 2021 07:08:17 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r8so13899906wra.7
        for <git@vger.kernel.org>; Fri, 05 Nov 2021 07:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=65KYUpUFYjJ25P4xCIJWbT6a4er9IC/7zifMBUOeqAM=;
        b=BGOaoNhXPAke0ZLYQAwBm44tOI89f8XqAW1Y53FiDcBZ38w0q0481TLkeZ7vzk4Cnv
         EjCpi1vxbX6h7y4+qG11flRl+VMXfjouS+D2VhpLS41VZTjDP28612hEysCMyXOgEIFO
         zZZg6XPR+ro87ttNZ16vv6jiEGUixzCpl6j7pjYKqpiuW24LK6NoOHshPBK+m9WSA+F2
         XtegGrAJ8r9A7Gm2aeTX2kpolmJK4tF/5Jqf0uFWwrpuPx/AHtzcuYSu1Vvr0gTWw7KD
         isF5s6Br4atQIFPT2Xt8V5Bg5RfY29NS6RqyBRlCHtFB5cm64SvBliaE8mly249RK2yn
         PIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=65KYUpUFYjJ25P4xCIJWbT6a4er9IC/7zifMBUOeqAM=;
        b=qL+7LnvGK0iEOXPACm2rul1cJ6L6PNGqSaQgqUkBGqfPeRljt4+WKp4H5l23lW8gcZ
         6L7shjTsebuO6PwGdO/q3QLApl6nViRQzaSGTbu8nglYOlCLoOYJXV7rZTP0h0NbKpCB
         nVrrurDZFWTol7eXRtoa2P8ZS7VEQ6chNxJZksNHQ2RxjgfDL0Rvc7r9h3vZHnBOSzCz
         NlmkY0xvWw01kJ+rFG1MPxLpRS2eBpxLcRAbG9rJ1MYDIc6CfWbBclbeJbpj5JT62ueT
         AVbvV5/S9kYAOCQeJ43iPb2xQ7GTKluYxxJyUrLobvPZRKGYl6a1Paw3sklSlIvB0RGW
         G2ew==
X-Gm-Message-State: AOAM532HencUr12xMD8B9kSX5uWkFO7kgW5itXiUjErCiNbqjdWK/2rK
        iyFs9SLaq9vgIxk/GFDVCX+PDh1h+WtKTQ==
X-Google-Smtp-Source: ABdhPJzmlRjsf1a0AtSwThusdU+yacMuJl6HgR0Av3gpsiL5tQh8kL3U6SV6kZxg3dlDK23ejiHgpQ==
X-Received: by 2002:a5d:64c3:: with SMTP id f3mr29327829wri.321.1636121296110;
        Fri, 05 Nov 2021 07:08:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm7821556wrs.19.2021.11.05.07.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 07:08:15 -0700 (PDT)
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
Subject: [PATCH v3 07/10] generate-cmdlist.sh: stop sorting category lines
Date:   Fri,  5 Nov 2021 15:08:05 +0100
Message-Id: <patch-v3-07.10-d8cc7c246b8-20211105T135058Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <cover-v3-00.10-00000000000-20211105T135058Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com> <cover-v3-00.10-00000000000-20211105T135058Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a preceding commit we changed the print_command_list() loop to use
printf's auto-repeat feature. Let's now get rid of get_category_line()
entirely by not sorting the categories.

This will change the output of the generated code from e.g.:

    -       { "git-apply", N_("Apply a patch to files and/or to the index"), 0 | CAT_complete | CAT_plumbingmanipulators },

To:

    +       { "git-apply", N_("Apply a patch to files and/or to the index"), 0 | CAT_plumbingmanipulators | CAT_complete },

I.e. the categories are no longer sorted, but as they're OR'd together
it won't matter for the end result.

This speeds up the generate-cmdlist.sh a bit. Comparing HEAD~ (old)
and "master" to this code:

  'sh generate-cmdlist.sh command-list.txt' ran
    1.07 ± 0.33 times faster than 'sh generate-cmdlist.sh.old command-list.txt'
    1.15 ± 0.36 times faster than 'sh generate-cmdlist.sh.master command-list.txt'

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 generate-cmdlist.sh | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index a1ab2b1f077..f50112c50f8 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -9,11 +9,6 @@ command_list () {
 	eval "grep -ve '^#' $exclude_programs" <"$1"
 }
 
-get_category_line () {
-	tr ' ' '\012' |
-	LC_ALL=C sort -u
-}
-
 category_list () {
 	command_list "$1" |
 	cut -c 40- |
@@ -67,7 +62,7 @@ print_command_list () {
 	while read cmd rest
 	do
 		printf "	{ \"$cmd\", $(get_synopsis $cmd), 0"
-		printf " | CAT_%s" $(echo "$rest" | get_category_line)
+		printf " | CAT_%s" $rest
 		echo " },"
 	done
 	echo "};"
-- 
2.34.0.rc1.721.ga0c1db665bc

