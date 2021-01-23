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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B25FC433DB
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 13:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42D4722CAF
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 13:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbhAWNCn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 08:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbhAWNC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 08:02:29 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A572C061793
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 05:01:10 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id m2so6589413wmm.1
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 05:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q4bQogwsI9bRYCSjZJ+4/WLU6cJS2PZu/ileYKDTFTk=;
        b=MH8Bt4sZ2mYrM1a3dVQ9aRceBrXz/jQgZbiiBxJFc5z28gVLSPO1wGmfrVfolEzDlx
         b/6lFXvdwNleU8hWfgoEWtzMfudroZk6/Pk5o5Ik5Tf6itwhX1k+WQxWJnsNHKoDiyoE
         rlhEcsZYrqrWaTu1UncPuohBcIWQ9DhMpCdDwx+4sXDml0sUCojusQlxqOmPY0qaqVTk
         AY7TP6pC36Vh6KJVkH+ur+2IOB4nWWEa1N+sZYF7jwdnWeog5s6RBwij8rSvojkdQatm
         6NjFoqqA4kpJUZqjE/GGMnvJLXQR8bc/8OFcc0bq2uERbL3nW3RblqCaXeRXsXxPMIbl
         aXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q4bQogwsI9bRYCSjZJ+4/WLU6cJS2PZu/ileYKDTFTk=;
        b=VamFKb/dwXUy+fhVwIjgNG87wZvnZwqfUZUtn7hqJwkiAhnDQLB6ORZkuzFrjVEXDY
         pnSNC4PsrGJAmpp/teQNqIZ9AQxLUoOrh9A6ACa3BefPimuzj9l/4v3quZCveAslpCNu
         RfHi6xfb4ViCsTupqE7/PjEilPw4Gki1+YT6q2m6JLkteQneX58CZ3Y61dNfVcwhp7Ah
         U+6vhrf+fgTQeWpteWQSKj2c4i3EyRCWFBSmd9FHn2jXx1oFJaL4vXbDjYyqcmcicRho
         cLhkWxK3VL2ypEkdLyieFRNnVg3G5Ctrfd0zbOSNHK7dv5PxtCzvY0laGao1uqTmrGzo
         vC1g==
X-Gm-Message-State: AOAM5323XIVX/CW3om1t2H59K0hrGfa+5utiOa2+kpZFfvD9Oe+0Le4x
        A1EwQyJTG93kJ8RQc6fMoMZwXyUFwdlM1Q==
X-Google-Smtp-Source: ABdhPJwY3PT3nEhxEgx5ivjyiZyWvKXREeIFsJlAiOO/TGsTzGX36rAeHtfatQ8Rzs/rWYkHbfpR7w==
X-Received: by 2002:a7b:c355:: with SMTP id l21mr67868wmj.61.1611406868749;
        Sat, 23 Jan 2021 05:01:08 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c7sm16750319wro.16.2021.01.23.05.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 05:01:07 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 05/10] git svn mergeinfo tests: modernize redirection & quoting style
Date:   Sat, 23 Jan 2021 14:00:41 +0100
Message-Id: <20210123130046.21975-6-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <87sg6s6lrs.fsf@evledraar.gmail.com>
References: <87sg6s6lrs.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use "<file" instead of "< file", and don't put the closing quote for
strings on an indented line. This makes a follow-up refactoring commit
easier to read.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t9151-svn-mergeinfo.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t9151-svn-mergeinfo.sh b/t/t9151-svn-mergeinfo.sh
index 4f6c06ecb2..59c5847c5f 100755
--- a/t/t9151-svn-mergeinfo.sh
+++ b/t/t9151-svn-mergeinfo.sh
@@ -9,37 +9,37 @@ test_description='git-svn svn mergeinfo properties'
 
 test_expect_success 'load svn dump' "
 	svnadmin load -q '$rawsvnrepo' \
-	  < '$TEST_DIRECTORY/t9151/svn-mergeinfo.dump' &&
+	  <'$TEST_DIRECTORY/t9151/svn-mergeinfo.dump' &&
 	git svn init --minimize-url -R svnmerge \
 	  --rewrite-root=http://svn.example.org \
 	  -T trunk -b branches '$svnrepo' &&
 	git svn fetch --all
-	"
+"
 
 test_expect_success 'all svn merges became git merge commits' '
 	unmarked=$(git rev-list --parents --all --grep=Merge |
 		grep -v " .* " | cut -f1 -d" ") &&
 	[ -z "$unmarked" ]
-	'
+'
 
 test_expect_success 'cherry picks did not become git merge commits' '
 	bad_cherries=$(git rev-list --parents --all --grep=Cherry |
 		grep " .* " | cut -f1 -d" ") &&
 	[ -z "$bad_cherries" ]
-	'
+'
 
 test_expect_success 'svn non-merge merge commits did not become git merge commits' '
 	bad_non_merges=$(git rev-list --parents --all --grep=non-merge |
 		grep " .* " | cut -f1 -d" ") &&
 	[ -z "$bad_non_merges" ]
-	'
+'
 
 test_expect_success 'commit made to merged branch is reachable from the merge' '
 	before_commit=$(git rev-list --all --grep="trunk commit before merging trunk to b2") &&
 	merge_commit=$(git rev-list --all --grep="Merge trunk to b2") &&
 	not_reachable=$(git rev-list -1 $before_commit --not $merge_commit) &&
 	[ -z "$not_reachable" ]
-	'
+'
 
 test_expect_success 'merging two branches in one commit is detected correctly' '
 	f1_commit=$(git rev-list --all --grep="make f1 branch from trunk") &&
@@ -47,11 +47,11 @@ test_expect_success 'merging two branches in one commit is detected correctly' '
 	merge_commit=$(git rev-list --all --grep="Merge f1 and f2 to trunk") &&
 	not_reachable=$(git rev-list -1 $f1_commit $f2_commit --not $merge_commit) &&
 	[ -z "$not_reachable" ]
-	'
+'
 
 test_expect_failure 'everything got merged in the end' '
 	unmerged=$(git rev-list --all --not master) &&
 	[ -z "$unmerged" ]
-	'
+'
 
 test_done
-- 
2.29.2.222.g5d2a92d10f8

