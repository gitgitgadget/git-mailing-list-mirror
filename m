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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8ED6C433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6141E611F2
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbhDTMaM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 08:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbhDTMaL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 08:30:11 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29582C06138B
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:29:40 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id j12so19790947edy.3
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o9nVAOXxpP4/77DHBtfjBf6EoeRybIQt9qoUjdKtID8=;
        b=ncXvCFJhlI0r0N1miO61ooR5U+CBirxZYMwOXiunY8v/gy7iQ/ui/HbjZg0r83PfLV
         Fzc/SS338bVIqnkwzJ8sEXIaZaIsbhDHaRhhiuk3ZKr5LHUH0qX5n3B3xJXP78qHm7NB
         HqmY+fBDtRMhmbnQbYy9KYqDmQjy74Z+1MQL0VG7OK+EdnJH7Dr42fX+o8kfJ8I5N2qA
         e53Ri3m6nKyBTrdDuz3NNzt99Fq8CzEF0bcW4jmJWEhbIgL58kLBQB1KG08XITc5Hh57
         RrsybzhZZSRCnEZG8FZ6rpB2Sq/js/kHJmDt9KggLSgxqBUnZ/Uva7J6Aym82EBkk/i/
         z6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o9nVAOXxpP4/77DHBtfjBf6EoeRybIQt9qoUjdKtID8=;
        b=smI+FUUZwDfC9f9vWsl5Zlrr5VocrfT4Cqfjkp6VHAp0kMSU7cjN2jsAeze3hr70C0
         ICnGCZvuhXJwAtKan6y0pWMUBNhw+8acT88MesaeawNR3wqZxE8JR+hzSsfUjJJwP+He
         8id1HKqab5J/8H5QEVDCnd1Zg+bMPn863oeA0I1CNcc91SFxIbwSoz5zYMd3HALnuy98
         +zs4nCoJIpNWvmxPjt+Cfpi4RU7xyexCn3lggHbI9KU31kjexqbAgqRU8bJlClm2osgd
         LRrpncDeTY3ziSLBBqYEpg8vIMsLKMOIF5LTITMHq7NLIdKBtl/kru4XXysCmmozg21x
         Nl1g==
X-Gm-Message-State: AOAM530croPHiCnHjIQ6V7UaH4o70DAnQFPgzGHEg0H3mZQN8T3zI1Mj
        cBysZXR8zRbMmumz+Il1uUmjxzxgCVzEoA==
X-Google-Smtp-Source: ABdhPJw+yAGjxt8TZO7q9K7MTHFdVKU8HkYzh177N4PwCJtkGkgNHhMEiUSo+84GVC2aQZhY1u4R7A==
X-Received: by 2002:aa7:d9d7:: with SMTP id v23mr32498503eds.281.1618921778740;
        Tue, 20 Apr 2021 05:29:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f1sm10898031edz.60.2021.04.20.05.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 05:29:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/3] test-lib-functions: normalize test_path_is_missing() debugging
Date:   Tue, 20 Apr 2021 14:29:28 +0200
Message-Id: <patch-1.3-fd33f6d71f-20210420T122706Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.gf6bad1b9ba1
In-Reply-To: <cover-0.3-0000000000-20210420T122706Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com> <cover-0.3-0000000000-20210420T122706Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the test_path_is_missing() to be consistent with related
functions. Since 2caf20c52b7 (test-lib: user-friendly alternatives to
test [-d|-f|-e], 2010-08-10) we've been ls -ld-ing the bad path and
echo-ing $* if it exists. Let's just say that it exists instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-functions.sh | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index bd64a15c73..0232cc9f46 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -810,12 +810,7 @@ test_path_is_missing () {
 	test "$#" -ne 1 && BUG "1 param"
 	if test -e "$1"
 	then
-		echo "Path exists:"
-		ls -ld "$1"
-		if test $# -ge 1
-		then
-			echo "$*"
-		fi
+		echo "Path $1 exists!"
 		false
 	fi
 }
-- 
2.31.1.723.gf6bad1b9ba1

