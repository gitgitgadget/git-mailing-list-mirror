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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54DAC4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E7C360FE3
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbhFURBk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 13:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbhFURBF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 13:01:05 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCB3C01CB35
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:31:50 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 5-20020a9d01050000b02903c700c45721so18319474otu.6
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0f6epyr4KO0mEH5zHAbRif/I3pJbDcSmRqktmC+xq7I=;
        b=ui5F+kBfNW//ZbfhsuxUiodjAIaSJmwT0LWaVupUqoEco+UaObmH+zb3cdLsMxOOXc
         4y6nVy02VLFZ6TSHveXdEk7o0vdaGfQDutTteoSoVAYW1NSlVGlLVTYMniQ8Op9YUCoD
         SJ7WlMiePkfdU5PrvT/wfOE70C/lR2j8v77cNJOHLlU54mlP/BhuQIUNytwg1NCIIdwF
         C7M6Pu0l89IOWKUPG11i+Fi3z5zegfC6+EszVDHX23K0pgMllh6FckeD3a3vnPdSuF2I
         B96NG/dKiu0FyHNFYd3tDxoiR1PD5PnxcWWeF4LioR4TCiv4tvxAOmIS+haLkZw4lMaA
         EV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0f6epyr4KO0mEH5zHAbRif/I3pJbDcSmRqktmC+xq7I=;
        b=Skwxj3GmgyM7YQeNg3kn/4s0e13AfHhGjjdPN2DUePLwisQec7LOkGcytRLax8bMEg
         vuLmJDMLtFxWEgBs1/t5W4tx70jNrzybBlioZX179iSWzAs8TQD51OOFUkyBJ8egkYSD
         pWaROFV/jjisrZrb+GA1tEuP7W2HIsScSV128KivxdvbfIMGMXh1u7R90t2dQMKwjVcy
         rehrGa+9dxwLfdCXE7q2d2wFbxwy1Yk1kHLPrI68tiwAqyAyjdXJq1xPqlhISN3fHvZH
         YCFcD4ICqw5TG7SxQBc7KyHse6VDs5nH9n7EydXhZMzgz1ajDLxaEW21OfCd8dqTe41D
         rDWg==
X-Gm-Message-State: AOAM530KY5ppIxekkpG8k6cQY9sp29usWfcYzAdy5/ysK5r365operMe
        FQ6nwq7vh/a3hoQU7Lm5xDejMNH1qcAfDA==
X-Google-Smtp-Source: ABdhPJy8D6QDsCxbH1UZpDNcRhm5x4FkWPSWPIUaArjcn7UccAE9AEbK5e/slcV4AtEIXciJrHXneA==
X-Received: by 2002:a05:6830:1281:: with SMTP id z1mr3935691otp.55.1624293109651;
        Mon, 21 Jun 2021 09:31:49 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id r2sm4054597otd.54.2021.06.21.09.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 09:31:49 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 14/23] doc-diff: drop --cut-footer switch
Date:   Mon, 21 Jun 2021 11:31:01 -0500
Message-Id: <20210621163110.1074145-15-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621163110.1074145-1-felipe.contreras@gmail.com>
References: <20210621163110.1074145-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Martin Ågren <martin.agren@gmail.com>

Now that our doc-diff convinces Asciidoctor to insert the exact same
formatted dummy date as AsciiDoc, we can drop the --cut-footer switch.
It has been useful to ignore this difference between the two tools, but
it's effectively a no-op now. Similar to when we repurposed this from
--cut-header-footer in 83b0b8953e ("doc-diff: replace
--cut-header-footer with --cut-footer", 2019-09-16), just drop it
without worrying about any kind of backwards compatibility or user-base.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/doc-diff | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/Documentation/doc-diff b/Documentation/doc-diff
index c11b90a6ef..6b6bb444ac 100755
--- a/Documentation/doc-diff
+++ b/Documentation/doc-diff
@@ -21,7 +21,6 @@ asciidoc		use asciidoc with both commits
 to-asciidoc		use asciidoc with the 'to'-commit
 to-asciidoctor		use asciidoctor with the 'to'-commit
 asciidoctor		use asciidoctor with both commits
-cut-footer		cut away footer
 "
 SUBDIRECTORY_OK=1
 . "$(git --exec-path)/git-sh-setup"
@@ -31,7 +30,6 @@ force=
 clean=
 from_program=
 to_program=
-cut_footer=
 while test $# -gt 0
 do
 	case "$1" in
@@ -55,8 +53,6 @@ do
 	--asciidoc)
 		from_program=-asciidoc
 		to_program=-asciidoc ;;
-	--cut-footer)
-		cut_footer=-cut-footer ;;
 	--)
 		shift; break ;;
 	*)
@@ -118,8 +114,8 @@ construct_makemanflags () {
 from_makemanflags=$(construct_makemanflags "$from_program") &&
 to_makemanflags=$(construct_makemanflags "$to_program") &&
 
-from_dir=$from_oid$from_program$cut_footer &&
-to_dir=$to_oid$to_program$cut_footer &&
+from_dir=$from_oid$from_program &&
+to_dir=$to_oid$to_program &&
 
 # generate_render_makefile <srcdir> <dstdir>
 generate_render_makefile () {
@@ -168,16 +164,6 @@ render_tree () {
 			"$tmp/rendered/$dname+" |
 		make -j$parallel -f - &&
 		mv "$tmp/rendered/$dname+" "$tmp/rendered/$dname"
-
-		if test "$cut_footer" = "-cut-footer"
-		then
-			for f in $(find "$tmp/rendered/$dname" -type f)
-			do
-				head -n -2 "$f" | sed -e '${/^$/d}' >"$f+" &&
-				mv "$f+" "$f" ||
-				return 1
-			done
-		fi
 	fi
 }
 
-- 
2.32.0

