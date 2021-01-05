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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66FCC433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92CC822D6F
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730905AbhAETot (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 14:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730881AbhAETos (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 14:44:48 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15D2C06179E
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 11:43:34 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id t16so358641wra.3
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 11:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g7RJmA0lqTKzFD6S5AZu66MR563n9lmpCQKVwSCDQQM=;
        b=RTdEUgXM/E4SB35PfUiV2REa80irTk5v2cj/8ARfdk2zFJGq1RwtW2iwImcT63mTK6
         yQUyQlYic89E3ie7AIiYPV1hhrmUzhTuXskU/7udEc9V3Nc8euF/scx/RwbCJEEsOSx8
         Q958TzJL43vCGk71Qme30H3bbxTfa/kNEvzh4RQRAKI/MzYUrtuNnJbriOvpb1FfsZSD
         0xd6pFDyO6HyShAGCKVBBEk58cwN9SMwW2JPCC6wn+TfalIR/4Tjb8JMmRzxpqqdYzEx
         8TCZHy2zDaEa4BfssPlG4OnwwOSh7OkUMluqLeexRSTH75ly1YaDiOid/UCsGT2sWGdC
         t/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g7RJmA0lqTKzFD6S5AZu66MR563n9lmpCQKVwSCDQQM=;
        b=VkWQL3TPLZacawOoyxjnkpX3Hyuzr6Ll+1IYJOoI+5P49mwsoUlqaPSBeqBIYyb/H5
         FPmC0ihsmNpRmlm07Udb3yGIuk+bnZjg4nDtroBw+UI7cJLkK/LZK1B7YjXzQAfrxYhM
         eriO2GoB6pzAHJYtfwPCYiPev8uycI6TEP3rIrwAJqA8yDGNG+5bqKrHpr34feKqH8mF
         DXibZE8vjE5MYhU8gW9UR0AMmQg+nmIhNDqE6Zqeo5yMxPcZ5rqOwfOnx4N7GO4/sgCA
         3EfCiMS5GtQamquzQY5bHWKkkbcUJSxXuNcUQcy9TmXsJT4rWysPn2y18k8VnjtVo7nn
         /QJA==
X-Gm-Message-State: AOAM532X1f1ZnKMurqr0QHAsGo2xBPduEan2G/hlmRs/eN38OYh0hF2j
        S+whhjVogmJQ697uF5yCTtG1UUV+HvHzNQ==
X-Google-Smtp-Source: ABdhPJx2fBMRUzkmWiC7iPe7AIUlBQZ6gp+Nig8wjN2Dzhvc0GUT0pnFgV9kKcwMjbqDD8cYf92lJg==
X-Received: by 2002:a5d:4101:: with SMTP id l1mr1113160wrp.196.1609875813251;
        Tue, 05 Jan 2021 11:43:33 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s6sm151113wro.79.2021.01.05.11.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 11:43:32 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 06/23] mktag tests: remove needless SHA-1 hardcoding
Date:   Tue,  5 Jan 2021 20:42:35 +0100
Message-Id: <20210105194252.627-7-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201223013606.7972-1-avarab@gmail.com>
References: <20201223013606.7972-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the tests amended in acb49d1cc8b (t3800: make hash-size
independent, 2019-08-18) even more to make them independent of either
SHA-1 or SHA-256.

Some of these tests were failing for the wrong reasons. The first one
being modified here would fail because the line starts with "xxxxxx"
instead of "object", the rest of the line doesn't matter.

Let's just put a valid hash on the rest of the line anyway to narrow
the test down for just the s/object/xxxxxx/ case.

The second one being modified here would fail under
GIT_TEST_DEFAULT_HASH=sha256 because <some sha-1 length garbage> is an
invalid SHA-256, but we should really be testing <some sha-256 length
garbage> when under SHA-256.

This doesn't really matter since we should be able to trust other
parts of the code to validate things in the 0-9a-f range, but let's
keep it for good measure.

There's a later test which tests an invalid SHA which looks like a
valid one, to stress the "We refuse to tag something we can't
verify[...]" logic in mktag.c.

But here we're testing for a SHA-length string which contains
characters outside of the /[0-9a-f]/i set.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3800-mktag.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index dd21a1247a2..e1a2892f58b 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -41,7 +41,7 @@ check_verify_failure 'Tag object length check' \
 #  2. object line label check
 
 cat >tag.sig <<EOF
-xxxxxx 139e9b33986b1c2670fff52c5067603117b3e895
+xxxxxx $head
 type tag
 tag mytag
 tagger . <> 0 +0000
@@ -51,10 +51,10 @@ EOF
 check_verify_failure '"object" line label check' '^error: char0: .*"object "$'
 
 ############################################################
-#  3. object line SHA1 check
+#  3. object line hash check
 
 cat >tag.sig <<EOF
-object zz9e9b33986b1c2670fff52c5067603117b3e895
+object $(echo $head | tr 0-9a-f z)
 type tag
 tag mytag
 tagger . <> 0 +0000
-- 
2.29.2.222.g5d2a92d10f8

