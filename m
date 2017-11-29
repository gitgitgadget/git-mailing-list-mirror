Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9078820A40
	for <e@80x24.org>; Wed, 29 Nov 2017 18:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751396AbdK2ScM (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 13:32:12 -0500
Received: from mail-it0-f42.google.com ([209.85.214.42]:33171 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751267AbdK2ScK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 13:32:10 -0500
Received: by mail-it0-f42.google.com with SMTP id o130so27097099itg.0
        for <git@vger.kernel.org>; Wed, 29 Nov 2017 10:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GN0M1kzYn6ur1hjuKJlRoaFgU9Y5JXEw0rcWxAH2hMw=;
        b=wS1+zB56+4VfJTwYOms6aPIFx0tLpRAeBLX7IIdOJ+EKa+ZLlUNIBzONKHzGqAoHuz
         PkX/Fst02RgnUBnSzAH5VuJH8LoKWHUIqqiT4IBs5ST2TArWMDeNfsjPRomZelOiMQUJ
         Le9FplhmgufGmrW/b4xwL+1XCF4cDcJZkedObgFsahKbEHDthz97DCm5dENExElzNcuR
         KG/fXaDeS9Q5mBHv/yW24Oo5eSYozLiHxYrka8YBHrydo54ptmFdR2rtugMixfifzWg9
         BMzjvcRzHjmiblnHyoB0ga3pG56BkLjA3VzICeM8Q7P2dbMKDg6jWvQfySSVkT90v6mX
         cVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GN0M1kzYn6ur1hjuKJlRoaFgU9Y5JXEw0rcWxAH2hMw=;
        b=bRJNLXP3c1qlv/VkGY8PKHnVZ1xUahR5AjlviC96uvSiRtgK34IEvk7vM1tF/OoJ8I
         OYedTtkHUmU1HzUSke2KhEbj1eCSqpBcm1Cox5riLHUCqyYtsZ6cLjox+GpgU1puemGW
         HpYWjAZhbkoYdYGjOrv2dOU7hu88XEHDA18EBMxuB3ei+SGdTz2LIs4VPduU9KvU9Y2U
         yZxTVEeXgFZMySSj3NsHOWykehFJ87T0TdVWTN0pwdy07et+MBf9xAijbNzjiV3B4cAw
         h5LiF+z0Pe9yD5iUdk3lsaDwimEJhIv4niqGkqRG0I2XYsLnbF0Dv98X93XFNR7ZfUNu
         2iOg==
X-Gm-Message-State: AJaThX7xFzsucEEYbUFVqMfTTs8c5jQr+btNWCJU/yelgQ3pqlflzPbb
        sXMB99NQ5zsrAz8mel0l18a3EtvTTFU=
X-Google-Smtp-Source: AGs4zMYCYfXv5b+TkIcnfZTZokK/bt73BmWI6rDguw1kMhDm1uUJ5JrfiBG6H3PyOkb3+wnDrnapfg==
X-Received: by 10.36.189.205 with SMTP id x196mr8590903ite.152.1511980329496;
        Wed, 29 Nov 2017 10:32:09 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([100.96.218.44])
        by smtp.gmail.com with ESMTPSA id b77sm1008043ioj.42.2017.11.29.10.32.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Nov 2017 10:32:08 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, newren@gmail.com
Subject: [PATCH on en/rename-progress] diffcore-rename: make diff-tree -l0 mean -l<large>
Date:   Wed, 29 Nov 2017 10:32:00 -0800
Message-Id: <20171129183200.178183-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.15.0.173.g9268cf4a2.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the documentation of diff-tree, it is stated that the -l option
"prevents rename/copy detection from running if the number of
rename/copy targets exceeds the specified number". The documentation
does not mention any special handling for the number 0, but the
implementation before commit b520abf ("sequencer: warn when internal
merge may be suboptimal due to renameLimit", 2017-11-14) treated 0 as a
special value indicating that the rename limit is to be a very large
number instead.

The commit b520abf changed that behavior, treating 0 as 0. Revert this
behavior to what it was previously. This allows existing scripts and
tools that use "-l0" to continue working. The alternative (to allow
"-l0") is probably much less useful, since users can just refrain from
specifying -M and/or -C to have the same effect.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Note that this patch is built on en/rename-progress.

We noticed this through an automated test for an internal tool - the
tool uses git diff-tree with -l0, and no longer produces the same
results as before.
---
 diffcore-rename.c      |  2 ++
 t/t4001-diff-rename.sh | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 9ca0eaec7..245e999fe 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -392,6 +392,8 @@ static int too_many_rename_candidates(int num_create,
 	 *
 	 *    num_create * num_src > rename_limit * rename_limit
 	 */
+	if (rename_limit <= 0)
+		rename_limit = 32767;
 	if ((num_create <= rename_limit || num_src <= rename_limit) &&
 	    ((uint64_t)num_create * (uint64_t)num_src
 	     <= (uint64_t)rename_limit * (uint64_t)rename_limit))
diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index 0d1fa45d2..eadf4f624 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -230,4 +230,19 @@ test_expect_success 'rename pretty print common prefix and suffix overlap' '
 	test_i18ngrep " d/f/{ => f}/e " output
 '
 
+test_expect_success 'diff-tree -l0 defaults to a big rename limit, not zero' '
+	test_write_lines line1 line2 line3 >myfile &&
+	git add myfile &&
+	git commit -m x &&
+
+	test_write_lines line1 line2 line4 >myotherfile &&
+	git rm myfile &&
+	git add myotherfile &&
+	git commit -m x &&
+
+	git diff-tree -M -l0 HEAD HEAD^ >actual &&
+	# Verify that a rename from myotherfile to myfile was detected
+	grep "myotherfile.*myfile" actual
+'
+
 test_done
-- 
2.15.0.173.g9268cf4a2.dirty

