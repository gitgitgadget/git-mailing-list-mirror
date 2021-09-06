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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24351C433EF
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 07:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0582960F9E
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 07:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239935AbhIFHGj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 03:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbhIFHGc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 03:06:32 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288D8C061575
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 00:05:28 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x6so8176860wrv.13
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 00:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YxGNs6njqVhfS4Amc5fe+UiGnzxP3sZoRpqPL7CNulg=;
        b=TYPZe/L0grcShUe+rshB/nziqhbedHTNsPq1vGn+rRbPE5+WP9i1EV2kC2Oo4woKX2
         l4CwyYP1TT49tDhm2hRHFMraeiJGYmsoapBpNFBjv/6dO2WBNDDiukDx1B5CPY5CRAjv
         h1YsmeS4PqOGIajs9IpDnVWP1MAh6WcXUJDPgp0FcG+M+FSNn6kEejGjNsh/u6fqmCRC
         2Xqporvc4TMISu0gd5E6hXlWnBfz2eCdu8b78i1nTywdITEISHNNVihZ0TjkVe8Qn4TB
         XxqZDGlc74V7EdKaHB88mIELAnrg+mfY/H8Xg3nd/4fUsDiR0lja3MMLe47XPAY73GZY
         GJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YxGNs6njqVhfS4Amc5fe+UiGnzxP3sZoRpqPL7CNulg=;
        b=VVRFs9UlBt5tULsSMAqpo0yp/3nfI2lWOrWPGtlz9Wg3N9fav51EL2lyVYg3opHl8A
         kKYDOxZ90s02q7gxWB/ILj+GollJoNlNi3ZWHfLy9+CSFQ4uR3mCFYBa/NAOanINuILz
         L1+TPHnXZxQmgeIZRBsSnJOCE9C42tAu+rsxozOhSrqEJMIyiCYQBgT+JsXAVwrXxCCb
         VwdvIaOz+w+X1IBopRNrISCQcXRtwGQ/aFOkmztL/Bgd5lAjjmx1CUd9WPwcNaQBBt5P
         u/NED/wt2OoDoamIBta9ueQvxPV8ln4WAmPtJS5lpKGfFSADwS6u2vurPGvWxy6KOzaQ
         YRuw==
X-Gm-Message-State: AOAM5311eOjc0lqhKMnqz0oENu2wkR4t21eHV649S+F4CDF/k54N2n0t
        PIC+WinTi5vu2aMRgzmbwuwsI7al5CSQNA==
X-Google-Smtp-Source: ABdhPJxzxhDq/LfMAnjt5pC+q65qp1H/Nd9VR34tasPTfDfhC9yQdgJqm5F5HDFw2aT+/6H/bcfT+Q==
X-Received: by 2002:adf:db07:: with SMTP id s7mr12006653wri.106.1630911926574;
        Mon, 06 Sep 2021 00:05:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f17sm8076684wrt.63.2021.09.06.00.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 00:05:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>, Prathamesh Chavan <pc44800@gmail.com>,
        Peter Baumann <peter.baumann@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 7/7] test-lib: remove unused $_x40 and $_z40 variables
Date:   Mon,  6 Sep 2021 09:05:18 +0200
Message-Id: <patch-v2-7.7-479e94f22f4-20210906T070201Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.821.gfd4106eadbd
In-Reply-To: <cover-v2-0.7-00000000000-20210906T070201Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com> <cover-v2-0.7-00000000000-20210906T070201Z-avarab@gmail.com>
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
index abcfbed6d61..044a9231ae6 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -534,7 +534,7 @@ SQ=\'
 # when case-folding filenames
 u200c=$(printf '\342\200\214')
 
-export _x05 _x35 _x40 _z40 LF u200c EMPTY_TREE EMPTY_BLOB ZERO_OID OID_REGEX
+export _x05 _x35 LF u200c EMPTY_TREE EMPTY_BLOB ZERO_OID OID_REGEX
 
 # Each test should start with something like this, after copyright notices:
 #
@@ -1422,10 +1422,9 @@ then
 fi
 
 # Convenience
-# A regexp to match 5, 35 and 40 hexdigits
+# A regexp to match 5 and 35 hexdigits
 _x05='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x35="$_x05$_x05$_x05$_x05$_x05$_x05$_x05"
-_x40="$_x35$_x05"
 
 test_oid_init
 
@@ -1434,7 +1433,6 @@ OID_REGEX=$(echo $ZERO_OID | sed -e 's/0/[0-9a-f]/g')
 OIDPATH_REGEX=$(test_oid_to_path $ZERO_OID | sed -e 's/0/[0-9a-f]/g')
 EMPTY_TREE=$(test_oid empty_tree)
 EMPTY_BLOB=$(test_oid empty_blob)
-_z40=$ZERO_OID
 
 # Provide an implementation of the 'yes' utility; the upper bound
 # limit is there to help Windows that cannot stop this loop from
-- 
2.33.0.821.gfd4106eadbd

