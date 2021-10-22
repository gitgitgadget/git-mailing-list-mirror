Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF075C433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 19:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8A38610D0
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 19:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbhJVTiw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 15:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbhJVTio (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 15:38:44 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264E9C061228
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 12:36:23 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id z11-20020a1c7e0b000000b0030db7b70b6bso4613025wmc.1
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 12:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DMNz6q+uy44BismMXZBUBj7Jv2og6z2NKA/VpUkJmrg=;
        b=cvyUSJvWNyv0RGBwjQ0ijJ9f9+h+clXPd5cX7heZMEzSFzwHeAUIvdaAVxz8sGi3RH
         Mlvx0b5IX7+NCjcCn2lh3eORwIAdHtMERu6FDnJICUwaIbdyXu73MPYfdpf6fofDVKh3
         3BU1Nyy5248oUxTUqMSpAUnhHtw62WNl5h2NJCJfXKZKzsmr9EiyZT8SohN1BFl6sdmH
         wZq5IgrmxkzGPqolktq3xx6PPmSfPwtAFIoqn2s4rkO4hTMw3kZG8P0DgrXBlkO7WCtM
         Pu1iMzWog8ZFkqiJS1ADKUwYht38ugKMgMDH6uvg4FSUMMD30+JmQteyCHps9Sph8FvD
         5o0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DMNz6q+uy44BismMXZBUBj7Jv2og6z2NKA/VpUkJmrg=;
        b=Lt+eMfj45pPJlPYKzxu9cSbd60XQTV5DRsMWRxucPvJr4QRMZNIxu16Lq+4exwZtnK
         sT85hkYMdHsRLK/h2nrQCvSy9sq8/R3+3IxC+HoD3C82RrT8RsIWPgHiBThpfhWSNyU6
         ok6hVQca+G9plOoOsWnDzb8/Qux60mz7/QpxmG0X6l8ArbVAvAX9pUm6v9/SefDCL7n3
         vS8qS4hDNOuIjeptULeJYUWj08Pbi73APGy5Vtxf/fysFBIW7hUi8oO/wjumg+wWVuHU
         Jbf1pxUVxR1G9VmGJ6bqv4YzwXkxIpUIpkur1HXL7ZowDuxJrCidjHQL8R4R3dqM8FsT
         4gpg==
X-Gm-Message-State: AOAM531OtN+Es6IkmHQ4AeBXeGirmAA9CMliL9ObwG9cuFb09sbaBd9+
        xT//rrZ9NxfcQauynqdgIMCOuBIAOAH8EA==
X-Google-Smtp-Source: ABdhPJxRZej+r3dWyaxKrtg1K/X2awWAkSMPwRJSYniqe7d7lve0wU036lPEQjkGoTFAxHomoRG6oQ==
X-Received: by 2002:a1c:f405:: with SMTP id z5mr1899177wma.72.1634931382315;
        Fri, 22 Oct 2021 12:36:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q7sm8871814wrs.73.2021.10.22.12.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 12:36:21 -0700 (PDT)
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
Subject: [PATCH v2 07/10] generate-cmdlist.sh: stop sorting category lines
Date:   Fri, 22 Oct 2021 21:36:11 +0200
Message-Id: <patch-v2-07.10-f2f37c2963b-20211022T193027Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1505.g075a284c562
In-Reply-To: <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com>
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
2.33.1.1505.g075a284c562

