Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9E4C433FE
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 13:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 189CD611C7
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 13:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351538AbhI3NjU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 09:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351492AbhI3NjM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 09:39:12 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944E4C06176C
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 06:37:29 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id g19-20020a1c9d13000000b003075062d4daso4394947wme.0
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 06:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lgUL95zxjbeepJQB91L6BSlwNdgnBquzLCEeIVCAxvw=;
        b=Nw30LktL3S/5pjTnr7LVZX7xwWqRiVN84COiaB4nVj1MmN7rYw2cUSmzCh22wFwvad
         OJJNb1hesPXpzhHcff3F5A1gnf3p243xmeoSycE7j0xuW6uwp99iOmWUk32SAofL5Aus
         vtIy7Lz2d/IzkupFFL3Y0EL/JmhKYEBX/bpKzncjwnjqAQodcRYQX5P4uN153f8AHCq0
         ek7AbpgPop332Ce/G/53yl9yPxCXxtIxMfu7h7ayjvGC063KSkkT5bwVgYzxiy07SRfy
         Ey/CpB00bkO1+t/y2DfCE21oB8IRFmgsiQ+ZdjTBZs9OWwqRPEdIZutDhVy1oYvmygtC
         QfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lgUL95zxjbeepJQB91L6BSlwNdgnBquzLCEeIVCAxvw=;
        b=19EY3kCpauG8xJ4Ddl+yTqhJRfSencQ692OQRIpu8syXbHhnpgYERNQfHQijoW6M3B
         6nWee78YRpp0ZuSpMOjr+SnRFwxsj8UoquOR0g+yHo2bxggyaGVuot6Y3lR45n8cJALv
         Mc6dynqUe5B34JUzXKsXqSJsvmZoS2duAZsTVJ/luM8/eBTXjW1Q6DfETv758wJ6tlGi
         hq1RvjRnk3a6RY/AmTFLZVbRi3hn4aLMBT9lNxrzHQ03dEag1AtZ/Fh29krw4uDtrJrS
         frlfs6iWZXvfEkGT3C2i8NsM2FiU2veSM7nlv1aKG7cpKpOm3KjxYLBrSdroVq5RqIzZ
         oiTw==
X-Gm-Message-State: AOAM532jcuUseO8jxJq7hFsTXKCbepovpkfp3AqKHVHCs/7E9wwMt8mH
        uVsqhjFyGwSxJeARI38c44fLPkcax/SypqxW
X-Google-Smtp-Source: ABdhPJzVR9p5vblyUmwHh3lO+dJN3wCCwqUwh6WcU0iY9RNOKLNtQKgYP35KJj9PxtqoxXC6zBdHlA==
X-Received: by 2002:a1c:7f11:: with SMTP id a17mr15972508wmd.166.1633009047971;
        Thu, 30 Sep 2021 06:37:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o11sm4654713wmh.11.2021.09.30.06.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 06:37:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 02/17] fsck tests: refactor one test to use a sub-repo
Date:   Thu, 30 Sep 2021 15:37:07 +0200
Message-Id: <patch-v9-02.17-af7086623fe-20210930T133300Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1374.g05459a61530
In-Reply-To: <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com>
References: <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com> <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com>
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

We can instead use the pattern of creating a named sub-repository,
then we don't have to worry about cleaning up after ourselves, nobody
will care what state the broken "hash-mismatch" repository is after
this test runs.

See [1] for related discussion on various "modern" test patterns that
can be used to avoid verbosity and increase reliability.

1. https://lore.kernel.org/git/87y27veeyj.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1450-fsck.sh | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 969bfbbdd8f..f8edd15abf8 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -48,24 +48,25 @@ remove_object () {
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
+test_expect_success 'object with hash mismatch' '
+	git init --bare hash-mismatch &&
+	(
+		cd hash-mismatch &&
 
-	test_must_fail git fsck 2>out &&
-	test_i18ngrep "$sha.*corrupt" out
+		oid=$(echo blob | git hash-object -w --stdin) &&
+		old=$(test_oid_to_path "$oid") &&
+		new=$(dirname $old)/$(test_oid ff_2) &&
+		oid="$(dirname $new)$(basename $new)" &&
+
+		mv objects/$old objects/$new &&
+		git update-index --add --cacheinfo 100644 $oid foo &&
+		tree=$(git write-tree) &&
+		cmt=$(echo bogus | git commit-tree $tree) &&
+		git update-ref refs/heads/bogus $cmt &&
+
+		test_must_fail git fsck 2>out &&
+		grep "$oid.*corrupt" out
+	)
 '
 
 test_expect_success 'branch pointing to non-commit' '
-- 
2.33.0.1374.g05459a61530

