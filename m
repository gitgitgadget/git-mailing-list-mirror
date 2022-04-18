Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D40CC433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 16:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346341AbiDRQd0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 12:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346299AbiDRQc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 12:32:29 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E276131225
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:41 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u3so19155478wrg.3
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yyg3GFEwJVP8bA0WNPhJcv1At5QuC4jKYcw9ijBqIj0=;
        b=PDxXqtnBccvRiHqm8D0NAr72oR3Auz6FUqGGb5wRifRVW8z1xebUYHQ2gvoHUWu9iz
         hoKH83lqtuBNQk1qD+vZuUB3VX4OLVhdG5MSx+K1cwWu3ZmTHdtECAEPa6lSWNil2FCx
         OQzuz2s/Fe013XWIhhmjTiNhJUYbNqrqngndZNl00zejPYraQdrJuo1p6Izeb1cDiX14
         35ULc/TA49xjBkLv1/z1C7EisLfgabXRfjTz8aNhIbe4jhdNoAGdJ7WFG9XMuvH870p2
         w9XfB5QNtJuelFF4XxxhL4ld1+ENzqJUicPr8NV2HKJd8QDvr/2FkGd7QvWKU/KC9eIQ
         yzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yyg3GFEwJVP8bA0WNPhJcv1At5QuC4jKYcw9ijBqIj0=;
        b=QDYrUSqnMq18Qb7vOvwQJT6NxfmyuqgIPTgKETwnBdOqeuqMmjUbcFuzyLtLjy0q25
         ikm++luVU24gsUpHsDit0nL/kbbi9VxVB7sAkc8V9kCaYdddmBS/icM+4RaKTKZwlAlx
         JxncqrVxuEAou95VKAXuNenlHBfMY3QE6rFeeLlNEguX7vcHlut32UCtoyPiJMoA1xNc
         mPTC7AqNXyfIRsACSa0bmk6GWcenrzmqBhtzS5ooQLI6rvIxgW4P5FMVYn2hz6z9cPSZ
         jS63jHVAJnUiNHddD2DmYVIduAmLpEIOj8smtzmTdMEiVwE+1j+pNGu5e0rbyADIybx7
         X6YQ==
X-Gm-Message-State: AOAM531yVoVUbTAojHAosZXeQ8Ja/voBenSY1J4jaeHctDyuIJaP5Bcz
        NAsY+cmhig2pibylKj1Fzeea0nPGy0MZ3g==
X-Google-Smtp-Source: ABdhPJwCJB5fG73gunieCrtagItuc3uAcVR7gRn1yoEUjIQVeRQmOuRIIW0wjd7HoRW4qJWaeRmjcA==
X-Received: by 2002:a05:6000:1848:b0:20a:8d85:ab7b with SMTP id c8-20020a056000184800b0020a8d85ab7bmr6763970wri.491.1650299380247;
        Mon, 18 Apr 2022 09:29:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b0038e6c62f527sm15701311wmp.14.2022.04.18.09.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:29:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 29/31] CI: don't use "set -x" in "ci/lib.sh" output
Date:   Mon, 18 Apr 2022 18:29:06 +0200
Message-Id: <patch-v4-29.31-1bdcf1399d9-20220418T132809Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
References: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com> <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the "set -x" from the "ci/lib.sh" output. Before preceding
commits the logic in that file was much more complex, and likely to
fail in some scenarios.

Now we only task "ci/lib.sh" with setting various variables for
subsequent steps in our jobs, so we can start emitting more tailored
debugging output, which makes what it's doing easier to read.

This change also changes the output of the "ci/print-test-failures.sh"
script, since it's the only other user of "ci/lib-ci-type.sh". In that
case it's also helpful to know what "$CI_TYPE" we're using, as that
script doesn't "set -x" and will act differently depending on the
$CI_TYPE.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/lib.sh | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 1a7200451e4..ab7546800e0 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-set -ex
+set -e
 
 # Helper libraries
 . ${0%/*}/lib-ci-type.sh
@@ -18,15 +18,26 @@ then
 	exit 1
 fi
 
+# Show our configuration
+echo "CONFIG: CI_TYPE=$CI_TYPE" >&2
+echo "CONFIG: jobname=$jobname" >&2
+echo "CONFIG: runs_on_pool=$runs_on_pool" >&2
+echo "CONFIG: GITHUB_ENV=$GITHUB_ENV" >&2
+if test -n "$GITHUB_ENV"
+then
+	echo "CONFIG: GITHUB_ENV=$GITHUB_ENV" >&2
+fi
+
 # Helper functions
 setenv () {
+	local skip=
 	while test $# != 0
 	do
 		case "$1" in
 		--build | --test)
 			if test "$1" != "$mode"
 			then
-				return 0
+				skip=t
 			fi
 
 			;;
@@ -45,10 +56,18 @@ setenv () {
 	val=$2
 	shift 2
 
+	if test -n "$skip"
+	then
+		echo "SKIP '$key=$val'" >&2
+		return 0
+	fi
+
 	if test -n "$GITHUB_ENV"
 	then
 		echo "$key=$val" >>"$GITHUB_ENV"
 	fi
+
+	echo "SET: '$key=$val'" >&2
 }
 
 # Clear variables that may come from the outside world.
-- 
2.36.0.rc2.898.gdf6bbac50ff

