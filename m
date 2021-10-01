Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7E3C433FE
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5234E6138F
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352910AbhJAJSq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 05:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352901AbhJAJSp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 05:18:45 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1089EC061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 02:17:01 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d6so14331693wrc.11
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 02:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mXLUjmlGKkd8yLNd8CNYUOG8cze97uHEPi0FyUyzwFA=;
        b=JvgGH8Zb+DcGs+62YDDfl2ebYVTuoQVXrC9NYYw28N7NFWXpyolPiwYev6Idlo4Voe
         a6hn641/YPiMh/cWBCzrbv5GJZk9ZYS4fFoVc8n3wNOe0JeiBdsVDnj0u9ZktgDVFLpH
         IEV+YqDxGNaNQTaWguuQbEJj4aUJSOGiwyzBQhCJ9BNRg/PZkpYO4+DjG76YrCrSfyV1
         wUaAG293tF7H2OfQ9jmquh1sbmBQuMVUcNkWKuyz/3GyHuuVSFkDyhqEK32KJ1NPFO9s
         W3ZbyBSxGLkEidTu/VAlcc3AZi1pDvnq8gAhRtvj5ezdMnyWXKncYm2586nqYTjnog2T
         CKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mXLUjmlGKkd8yLNd8CNYUOG8cze97uHEPi0FyUyzwFA=;
        b=1oXF8Si/tgc5pHJwIQZgqwMqBQzdnmQyI/cHTzJe2exv6u7YeCYMroZ70qAS6WaXU+
         OQ48D22hJsIpOisuFBvx9KBIzOqwnVU+sI0WxtX4RI280+J0Jc0VflLXOduKOmCnXnRB
         dSeRQpliFjMywc2oOG0OciMMTIT3kyc2+NzzikUra/QoTufanJ5MiVLv3vbu8DWDoQD9
         w7oDV1SDV2c7C3ILEJ7MoqN5hw2Gz7Z/TbZi9KmUDgEm5BrAn0XqF+gL2UrR6Gu4cwMR
         eZ8eZ6q9kR1/u9LtAx3GrmuVHuob0S5qQNEO5UYi6L5nfmxVeWdYTQsspjIf+GCgO8tq
         BavQ==
X-Gm-Message-State: AOAM533kLjwl7vP/2kd5BQMy2FDf67tPAwFDtkNhnL89RTIJjbyKK9XG
        A55f/Gxl1fi2UFcpBQ0nJ0XsbiXfU5chmg==
X-Google-Smtp-Source: ABdhPJzM166/sYySX2ilfXpCBio9r1T8M9Aob7G2EO6d25NLyHwMjIqEvxD3i3GIj7anpUOhHPhZ9A==
X-Received: by 2002:a5d:64ee:: with SMTP id g14mr10875836wri.80.1633079819325;
        Fri, 01 Oct 2021 02:16:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j4sm5301346wrt.67.2021.10.01.02.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 02:16:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v10 02/17] fsck tests: refactor one test to use a sub-repo
Date:   Fri,  1 Oct 2021 11:16:38 +0200
Message-Id: <patch-v10-02.17-32a2f9cc0c9-20211001T091051Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1375.g5eed55aa1b5
In-Reply-To: <cover-v10-00.17-00000000000-20211001T091051Z-avarab@gmail.com>
References: <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com> <cover-v10-00.17-00000000000-20211001T091051Z-avarab@gmail.com>
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
index beb233e91b1..b73bc2a2ec3 100755
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
2.33.0.1375.g5eed55aa1b5

