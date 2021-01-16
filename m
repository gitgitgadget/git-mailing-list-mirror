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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FA0C433E9
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 17:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4252B20732
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 17:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbhAPRGN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 12:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbhAPQbE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 11:31:04 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F17C06134A
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 07:36:05 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id 6so4931447wri.3
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 07:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q4bQogwsI9bRYCSjZJ+4/WLU6cJS2PZu/ileYKDTFTk=;
        b=LaUhpiWXiVo2ldjC+loOLdiNFfp1A4xPW/8MDIXUR5VSStN5jX0GoJCnhCioeqz+un
         eIuLbI3+FvbmiS1+HnfUCwpzY8cvnsZeFPNggG0SNKzAHebyQCPy8Ge0xohC+VFQv5DS
         lRlh1k2ULySnUI4VHE3VV1RSErXOm7/SdSJouOjtBWicmDH1MXjIdSee8QwE85zaN+dC
         m6SshJOVo8xPe3KO1Y135I/ft8WSD9PoN/slQzKUZkQsnsXpyJx/Zx46ThtRdqan6WWm
         yUMMAsk1MPmDOnKf+lcMidng9X6qMH2Lrq7sFp8cuB+eMVselhhfO6OSWohANXjTqd/p
         cdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q4bQogwsI9bRYCSjZJ+4/WLU6cJS2PZu/ileYKDTFTk=;
        b=LgPRoktw8uCWNbmcgp5juvi4iRAbhzqFPhXFSlj0UW4805mE1Xe9Tk4Y0VjIJmhr/Q
         afvw/ceKsjKMHKHE+8GnIiWl90doaNyrwNk33HhMPuGw0gjOVLBGbzAnET3o8xQpteAT
         ktZ7OOTVGD6a3epTXgL1kgHYRL2iXBUuv9t5tr49QQhBvX1C3/TIoMdTAB0oOEvA0xdf
         BDNugyYYPz+tIgi2690MLHY8UA2GrByX8pIAdtOAVdYQuOtUQcYmOD8s1PCTNBPZgzQL
         MKk4FKpQZs2TJbShE5bsRZyNGdoO31+eJzZcZWh+MmsTs9JDSPt6RjE0fgK1GUqIC4Oa
         0o8Q==
X-Gm-Message-State: AOAM531BJoHTeH1AntrAeSEULjChmhWTyv5zbS0Dstytz2MFFeISDwmY
        /eIOEysedCY9H0q0Wei7ETftnt/637OUGA==
X-Google-Smtp-Source: ABdhPJxUJfNcm93J2U14QLPLsbHe0o6Hae0tVUsKGFCw/pLnZxizDV8ZPyL0gvhaquFdrMUFzttusw==
X-Received: by 2002:a05:6000:186f:: with SMTP id d15mr15810986wri.237.1610811363806;
        Sat, 16 Jan 2021 07:36:03 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s13sm20008855wra.53.2021.01.16.07.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 07:36:02 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 04/11] git svn mergeinfo tests: modernize redirection & quoting style
Date:   Sat, 16 Jan 2021 16:35:47 +0100
Message-Id: <20210116153554.12604-5-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210114233515.31298-1-avarab@gmail.com>
References: <20210114233515.31298-1-avarab@gmail.com>
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

