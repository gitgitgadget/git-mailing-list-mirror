Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249C7C433E0
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 13:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1A5D64E77
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 13:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhBLNal (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 08:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhBLNah (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 08:30:37 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D59C0613D6
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 05:29:57 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id v15so7922013wrx.4
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 05:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9h7xeNRPI9ck2JxK+efLkwRc2ad96vYvqk4GmxajthI=;
        b=VmI6rySZBegkyq8F8NZp00u22Y4zqaxMqLKku05RwWHTyrsPyzKFruHBwIXjA8tTzT
         Tg64//GIRK27lzTlPU0Vg1MUSrdg1nQR6XalOkgwVXbCN/KnI0TVdTjGd8uAMgqurWz4
         N9wvCBTThRKM7EohSUYjjLPFjOfRGoe21mAoBc4ccHo8O8W2J9HUxDjnoOMNLDm6H+f4
         CILizxwozfL7EW8diR+B4YKqh2X/VoNDDdPQ+/EcJdwmnvLkzJdylT0BpPp49E5r942d
         uer59UKtKXD9vyStNKjySZrWUUVpqCozkTLb5W2R2V1uOyeB1/fRwuUsmExbAYZ4NCMD
         k9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9h7xeNRPI9ck2JxK+efLkwRc2ad96vYvqk4GmxajthI=;
        b=m/DuqDYjMNv4bHVIJKg5M2BlL+RZcQCNSexkLdAImyN8sSoDNoJGWwWfltAyDk+0UX
         aRJRWf1r1TBgwWCh4UlpYqIQPItP0Bn8ewLCzQpdX+sAJvHsp35wTXa+l/TcmCdI8WMd
         WqqOuCX1ueNxN0mi2xzmIM4a7bOGIFcrj+ihKGqp+7IvjhpPj2XlYBw6qmq4hosq4kpq
         Oo4BGuuRHSOURb8x0yIN1GVZlDQVqoGe0FzMzGDh0PYUHB68ete8ulTb48yMlttVwtBh
         g3liaEvtcGd8EKQMIzJ88adnIcPNaLfSY34mokJPQ3SB5O/ZScM84dYOcZPEryA81gvy
         wXXw==
X-Gm-Message-State: AOAM531lP3ORqlpMfkUwL0W2wW+dcolZp3HnUaL8x2Qd7deZ5j8TNIlp
        vUu+/at3C5FpIbI0hOhYtrEI4UCRtlU+ZQ==
X-Google-Smtp-Source: ABdhPJzmbS7iasBk3Ua2+T6WKrxUMPeCAnR1/qJjiTw1zsFx1dnLFWPtZrOE8Z+NpO2DiaxSoVP2YA==
X-Received: by 2002:adf:b611:: with SMTP id f17mr3415684wre.8.1613136595755;
        Fri, 12 Feb 2021 05:29:55 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 13sm14060682wmj.11.2021.02.12.05.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 05:29:55 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 01/11] test-lib: remove check_var_migration
Date:   Fri, 12 Feb 2021 14:29:32 +0100
Message-Id: <20210212132942.17325-2-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210209214159.22815-1-avarab@gmail.com>
References: <20210209214159.22815-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the check_var_migration() migration helper. This was added back
in [1], [2] and [3] to warn users to migrate from e.g. the
"GIT_FSMONITOR_TEST" name to "GIT_TEST_FSMONITOR".

I daresay that having been warning about this since late 2018 (or
v2.20.0) was sufficient time to give everyone interested a heads-up
about moving to the new names.

I don't see the need for going through the "do this later" codepath
anticipated in [1], let's just remove this instead.

1. 4cb54d0aa8e (fsmonitor: update GIT_TEST_FSMONITOR support,
   2018-09-18)
2. 1f357b045b5 (read-cache: update TEST_GIT_INDEX_VERSION support,
   2018-09-18)
3. 5765d97b71d (preload-index: update GIT_FORCE_PRELOAD_TEST support,
   2018-09-18)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib.sh | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 431adba0fb3..987a6c1936d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -453,36 +453,6 @@ export GIT_DEFAULT_HASH
 GIT_TRACE_BARE=1
 export GIT_TRACE_BARE
 
-check_var_migration () {
-	# the warnings and hints given from this helper depends
-	# on end-user settings, which will disrupt the self-test
-	# done on the test framework itself.
-	case "$GIT_TEST_FRAMEWORK_SELFTEST" in
-	t)	return ;;
-	esac
-
-	old_name=$1 new_name=$2
-	eval "old_isset=\${${old_name}:+isset}"
-	eval "new_isset=\${${new_name}:+isset}"
-
-	case "$old_isset,$new_isset" in
-	isset,)
-		echo >&2 "warning: $old_name is now $new_name"
-		echo >&2 "hint: set $new_name too during the transition period"
-		eval "$new_name=\$$old_name"
-		;;
-	isset,isset)
-		# do this later
-		# echo >&2 "warning: $old_name is now $new_name"
-		# echo >&2 "hint: remove $old_name"
-		;;
-	esac
-}
-
-check_var_migration GIT_FSMONITOR_TEST GIT_TEST_FSMONITOR
-check_var_migration TEST_GIT_INDEX_VERSION GIT_TEST_INDEX_VERSION
-check_var_migration GIT_FORCE_PRELOAD_TEST GIT_TEST_PRELOAD_INDEX
-
 # Use specific version of the index file format
 if test -n "${GIT_TEST_INDEX_VERSION:+isset}"
 then
-- 
2.30.0.284.gd98b1dd5eaa7

