Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D232C43334
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 22:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354669AbiFUWet (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 18:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354458AbiFUWeo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 18:34:44 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3769F28707
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:34:35 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id m39-20020a05600c3b2700b0039c511ebbacso10016177wms.3
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3dhW6IuVN4st0XhvSoYU+v/1c1DdOSoK4mZEceAMIdc=;
        b=Y5w2AbrwwRGqQRxijSx/wZ0O4pdc0bSJi9GrWqfCG1DjZf/bqQ9mJetfu27agOeOt/
         VWxivJE6IavZpy0rDmFe450rwG0m3QDVStVOY6Lp9RpstOJCrW1WS0FR3vhzQbMkusX6
         85XiDRDSfGDKlxvwu6gFLv7EOtJK6HSkeq2VoouOO1FI2N+M26FZVIggroC342zAfBa8
         BpK5WgFC/eSsHjsqTJu54m4IHA8SIMIHSIzoMXBNbETeK3QQzsrMit/AvRAdHD39WH6J
         GEv5lR0za2ZA+vRLX1Ml4AWm4AgZWQWdUSd6e0Kjiu7xPIGF36BXiZdDgBfRmSmmcMv1
         4a7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3dhW6IuVN4st0XhvSoYU+v/1c1DdOSoK4mZEceAMIdc=;
        b=4JawP+GDEYB22esngJNYYS8zd1lEZVeiIh1G3mvn2hSJAYXgPvm9shHnmoJl6r/i0l
         +XxWCiS7f+F+gf2Sfooic4+YXER8XmBqGEocQg18bP4zB5FFf9hBl5s0kJenilWvewDI
         Tg8mfoNzU9jOkKtFCSlxyriedcIzBLe8FsPr3p8cp7u57CqdBrg7OtjccjfZG6uPR0y/
         xNU3N6rkiYhbNWoyIH4cp1StQrrap3D/F1T+rnmK1WUw8VMKC89Y2AlJVPkvL4ANhOdU
         MlSWJ+ISrwtI2140DUlTdIEE2LFrD9WPB1UNTc+TL8TSbZmmQddX/mRT+x8yTEIl9Uuj
         qyyw==
X-Gm-Message-State: AJIora8yiYweHC6qG4c4qfXtfnP4iDOP0SzVmWzF8O6cv5BuWgCIvO9n
        cqgozsbGtf2Sxj3ZmlZzn5LotTaW/4OzvA==
X-Google-Smtp-Source: AGRyM1sx8zfaa+5jG3QoTEoMpsrDInezzsB684/eytawt9RvqxmVI6kBhW3cdgpIQbVWL2gUuWKW6w==
X-Received: by 2002:a05:600c:35d2:b0:397:84c9:6fe8 with SMTP id r18-20020a05600c35d200b0039784c96fe8mr403444wmq.206.1655850873486;
        Tue, 21 Jun 2022 15:34:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y5-20020a7bcd85000000b0039c7c4a542csm19000299wmj.47.2022.06.21.15.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 15:34:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        rsbecker@nexbridge.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/10] fetch tests: remove shelling out for previously "lazy" variables
Date:   Wed, 22 Jun 2022 00:34:20 +0200
Message-Id: <patch-08.10-a0d645b7146-20220621T222854Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-00.10-00000000000-20220621T222854Z-avarab@gmail.com>
References: <xmqqa6a5g0m3.fsf@gitster.g> <cover-00.10-00000000000-20220621T222854Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend the variable assignments added in e1790f9245f (fetch tests:
fetch <url> <spec> as well as fetch [<remote>], 2018-02-09). As of the
last commit this test was slower as we'd do this on every run, but it
was easier to see what was going on.

But let's instead set this on the basis of $TRASH_DIRECTORY, which is
a lot more obvious than the roundabout way of getting the
configuration from the repo that we created earlier with:

    git clone . one

Subsequent commits will make use of the new "$refspec_heads" for other
purposes, so let's declare it as a variable, and use it instead of
"$remote_fetch".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5510-fetch.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 7cfef0082c0..54c7c86e5ca 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -837,6 +837,8 @@ test_configured_prune_type () {
 		shift
 	done &&
 
+	local refspec_heads='+refs/heads/*:refs/remotes/origin/*' &&
+
 	local fetch_prune="$1" &&
 	local remote_origin_prune="$2" &&
 	local fetch_prune_tags="$3" &&
@@ -846,9 +848,8 @@ test_configured_prune_type () {
 	shift 6 &&
 	local cmdline="$@" &&
 
-	remote_url="file://$(git -C one config remote.origin.url)" &&
-	remote_fetch="$(git -C one config remote.origin.fetch)" &&
-	cmdline_setup="\"$remote_url\" \"$remote_fetch\"" &&
+	local remote_url="file://$TRASH_DIRECTORY/." &&
+	local cmdline_setup="\"$remote_url\" \"$refspec_heads\""
 
 	if test "$mode" = 'link'
 	then
-- 
2.36.1.1239.gfba91521d90

