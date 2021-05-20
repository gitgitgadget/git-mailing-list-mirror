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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7340C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6AB061261
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbhETM1D (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 08:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbhETM0p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 08:26:45 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2D9C0438D8
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:23:17 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id k14so21204504eji.2
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=An/x+D4iuFeJXmT+0NRANkZQJPSij8xl4RgnQ1Uq8EM=;
        b=tANi5UOSstt/rjLm7/hFWyVKvyMu75l64ELMwLEenNsfA9KMRNqqfFO4RhEY2Rp0O8
         IKcEyRsqj9/XRlSKe4Nrr3F9zRWoURen6//LRNdWTLzPv97DWWOmIxDNHjdo9puvQp0l
         vTXC1N3oO456Siri2aTWk/0nN+u9Pe+tUndCVF8nnUICNlnO2yBdsYb1dYll6gyXzL4V
         zg6hRfbyYW1Jnrsldp1SxFijqsANHO98TLxnquLwBPB25o2pAamXIRbxh1l4Lui+M4fz
         QkpBYb4oL/u+hxLArVoZzpZtf/661YFOjiWqeWufbXwRbjw6Z6hZGmt20u1jprVRGz7W
         EZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=An/x+D4iuFeJXmT+0NRANkZQJPSij8xl4RgnQ1Uq8EM=;
        b=bwl5PB9oTPZpRvmOwylnmhmnLjD2d9BNuT+e1Fm0Gzvv5PCKFZaFdeuunDe6YYBKWR
         rVHFdUMSc09Re2JC/2IGT0GjKa2IIjCkPSVOo1bP1s+8dZXTzwc2tKb/e5WMMfxIsD5A
         AikZRO7gjFAoZ/sR0ln/eXgElzIiq56xjlmj993CukA1+Xc4ykChSpDMUAFYXqzbdexB
         OWKay1JrwBo6EykZzN/EmIfF7CqXc/JX9PIuCm+4bLRTZI/imQxZoJIlmyB65aoOYO6U
         GnmuhU5M37d7eTSpi63muNtWuDnpWlfrlIG9Keri5O9qrID1giBLPUCMKFBLpYYYnT7B
         FMcg==
X-Gm-Message-State: AOAM533i1esOySWxov5bTzxL2kno+NU9cIWzEr6S8ClQ4v0xllFW55s+
        2Rxb9o6CRFgPDU9hNRPyZ799ZSBaYafNgw==
X-Google-Smtp-Source: ABdhPJyapfuq7dl14+dldvmHqsvf4wy3vQBim3dZGLezuu1nn4O2fN3RvnE5d+fMRO7UPr8/h4bPlw==
X-Received: by 2002:a17:906:1cc3:: with SMTP id i3mr4323004ejh.87.1621509795512;
        Thu, 20 May 2021 04:23:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jy21sm1243273ejc.13.2021.05.20.04.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 04:23:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 01/17] fsck tests: refactor one test to use a sub-repo
Date:   Thu, 20 May 2021 13:22:55 +0200
Message-Id: <patch-01.17-aa38b2bf9e-20210520T111610Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.406.g73369325f8d
In-Reply-To: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com> <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor one of the fsck tests to use a throwaway repository. It's a
pervasive pattern in t1450-fsck.sh to spend a lot of effort on the
teardown of a tests so we're not leaving corrupt content for the next
test.

We should instead simply use something like this test_create_repo
pattern. It's both less verbose, and makes things easier to debug as a
failing test can have their state left behind under -d without
damaging the state for other tests.

But let's punt on that general refactoring and just change this one
test, I'm going to change it further in subsequent commits.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1450-fsck.sh | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 5071ac63a5..1563b35f88 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -48,24 +48,22 @@ remove_object () {
 	rm "$(sha1_file "$1")"
 }
 
-test_expect_success 'object with bad sha1' '
-	sha=$(echo blob | git hash-object -w --stdin) &&
-	old=$(test_oid_to_path "$sha") &&
-	new=$(dirname $old)/$(test_oid ff_2) &&
-	sha="$(dirname $new)$(basename $new)" &&
-	mv .git/objects/$old .git/objects/$new &&
-	test_when_finished "remove_object $sha" &&
-	git update-index --add --cacheinfo 100644 $sha foo &&
-	test_when_finished "git read-tree -u --reset HEAD" &&
-	tree=$(git write-tree) &&
-	test_when_finished "remove_object $tree" &&
-	cmt=$(echo bogus | git commit-tree $tree) &&
-	test_when_finished "remove_object $cmt" &&
-	git update-ref refs/heads/bogus $cmt &&
-	test_when_finished "git update-ref -d refs/heads/bogus" &&
-
-	test_must_fail git fsck 2>out &&
-	test_i18ngrep "$sha.*corrupt" out
+test_expect_success 'object with hash mismatch' '
+	test_create_repo hash-mismatch &&
+	(
+		cd hash-mismatch &&
+		oid=$(echo blob | git hash-object -w --stdin) &&
+		old=$(test_oid_to_path "$oid") &&
+		new=$(dirname $old)/$(test_oid ff_2) &&
+		oid="$(dirname $new)$(basename $new)" &&
+		mv .git/objects/$old .git/objects/$new &&
+		git update-index --add --cacheinfo 100644 $oid foo &&
+		tree=$(git write-tree) &&
+		cmt=$(echo bogus | git commit-tree $tree) &&
+		git update-ref refs/heads/bogus $cmt &&
+		test_must_fail git fsck 2>out &&
+		test_i18ngrep "$oid.*corrupt" out
+	)
 '
 
 test_expect_success 'branch pointing to non-commit' '
-- 
2.32.0.rc0.406.g73369325f8d

