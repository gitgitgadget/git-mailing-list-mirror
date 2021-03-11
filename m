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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03597C43381
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 00:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE77D64FAD
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 00:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhCKAPf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 19:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhCKAPU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 19:15:20 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97597C061574
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 16:15:19 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id f12so25315917wrx.8
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 16:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1e9RpDaluqA+agSD3Hfp15odiSKNdb9TzcQSQpYJXx0=;
        b=vKjlCvSfqrzLa5vlOVR+dcMx6dDknveWkRKMLrtUbhopGUn9h8/nFQ+Orj6Z3lyY4z
         G478DQHZ73uF+d/RET9zu1pxD4kaW1I8yOeUfjZ2LSs7wNH6VV7IFzzAW/pBce52OYXR
         T0XGyExi//r+JHxngYjhr35fbrKrK9GfQsTcPa1XjPLcmHztygDJImgDafshzMdIO9c8
         AT8ue8Nr6tN8XMAFj20ti8aNkDjJlyLhyta8uJjNLPq8GsQ/XXOGSDKSEjFIVY1ubksN
         z9uMVyVWbNs8k339R0ebABTyy/caITR5BmUk91qAuCRqiCrq4+qQRFsi9Xii39s9eNcz
         mISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1e9RpDaluqA+agSD3Hfp15odiSKNdb9TzcQSQpYJXx0=;
        b=pHsy3OfcohxBQmHR7e4PaeyqfpTsuAF72LR1htLQ1lJVyIOxGqFXsnPOkaZ6Ff+amd
         xMQW+FlG4gws8hNGpAsUMUfdVKPoVyt+AgUFlTJnf3ZH28wsEOxQ6KL10OvNYLJ0cL+u
         NOULCIj5Fp3vwQVmZ4faeaqknjMChXreSv++I+AKFDU4u9zGygRxHq8/S7E0ra0EFKBk
         5Nt8ehXcrRlLyy44DK4wrJZxVIgNqk2L9IvOm5t8dhfSDCFtMwZpzsOGZbf8GKyGdh8N
         wn3BnjRZt6KfMUnGVL+0nzcDvdQi4AHpoZFDPM9Xfhna4aaFAIPkAoXb8elikQlU88Yl
         H+wQ==
X-Gm-Message-State: AOAM533SnFsP5iA9Rg+HHIYVWjOBNR8EJfYCiH2ao/8LJRXb9GqDJ9Vg
        h2p/Gb4YbE/Kx6TiDt7Sc6zMZE+tEgg=
X-Google-Smtp-Source: ABdhPJw5J3sMMDjusweXYWqzJaSk+/Cjmy2C3hmEvFkAr/lMPr+8WW743uIOA7ea0tjrfd31rB6ICA==
X-Received: by 2002:a5d:6c69:: with SMTP id r9mr5815628wrz.11.1615421718113;
        Wed, 10 Mar 2021 16:15:18 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s84sm1026447wme.11.2021.03.10.16.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 16:15:17 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/4] test-lib: remove unused $_x40 and $_z40 variables
Date:   Thu, 11 Mar 2021 01:14:45 +0100
Message-Id: <20210311001447.28254-3-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc1.213.gbfdb770ff55
In-Reply-To: <YEj82fOf+F4xJC8S@coredump.intra.peff.net>
References: <YEj82fOf+F4xJC8S@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These two have fallen out of use with the SHA-256 migration.

The last use of $_x40 was removed in fc7e73d7ef (t4013: improve
diff-post-processor logic, 2020-08-21) and

The last use of $_z40 was removed in 7a868c51c2 (t5562: use $ZERO_OID,
2019-12-21), but it was then needlessly refactored to be hash-agnostic
in 192b517589 (t: use hash-specific lookup tables to define test
constants, 2020-02-22). We can just remove it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index d3f6af6a65..5f2ad2fd81 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -511,7 +511,7 @@ SQ=\'
 # when case-folding filenames
 u200c=$(printf '\342\200\214')
 
-export _x05 _x35 _x40 _z40 LF u200c EMPTY_TREE EMPTY_BLOB ZERO_OID OID_REGEX
+export _x05 _x35 LF u200c EMPTY_TREE EMPTY_BLOB ZERO_OID OID_REGEX
 
 # Each test should start with something like this, after copyright notices:
 #
@@ -1381,10 +1381,9 @@ then
 fi
 
 # Convenience
-# A regexp to match 5, 35 and 40 hexdigits
+# A regexp to match 5 and 35 hexdigits
 _x05='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x35="$_x05$_x05$_x05$_x05$_x05$_x05$_x05"
-_x40="$_x35$_x05"
 
 test_oid_init
 
@@ -1393,7 +1392,6 @@ OID_REGEX=$(echo $ZERO_OID | sed -e 's/0/[0-9a-f]/g')
 OIDPATH_REGEX=$(test_oid_to_path $ZERO_OID | sed -e 's/0/[0-9a-f]/g')
 EMPTY_TREE=$(test_oid empty_tree)
 EMPTY_BLOB=$(test_oid empty_blob)
-_z40=$ZERO_OID
 
 # Provide an implementation of the 'yes' utility; the upper bound
 # limit is there to help Windows that cannot stop this loop from
-- 
2.31.0.rc1.213.gbfdb770ff55

