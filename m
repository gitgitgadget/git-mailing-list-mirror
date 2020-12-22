Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E908C433DB
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 03:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 433EB22CB1
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 03:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgLVD7D (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 22:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgLVD7C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 22:59:02 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43273C0613D6
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 19:58:22 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id y23so848915wmi.1
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 19:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BVYTgofx2vWv0hLPfqdADHe6fqD8GxjFNi7DELpOj00=;
        b=JUXHg51/ZMsE2zoV5yNcZrf5CwY3ALUPQpEpyr8WgVYC0A1vCHLR51pTLROhRwj6OR
         WWsCekA57+x3EyB0c3mSjKmcBLaiQCz6JR3b+IB0mM5U2rlIxhoRDZ0iknmbOnIjzOPj
         +Bf5kQwSJEQo8LIM/6BI6Ll4mPL1kZHTDh5QLurB/VO31ptI0wUB/x+KFw4vd1CgrDKb
         X+EaYD+PG1HHuhomagAHA2ppepj6YIsrl1RPxbrXzhZWR6eXgYIEkin3wxs3OYu37ypl
         e8FLOC+bxhjLlsIQk9BHdA6Wtf2OAHzpywvTNbfp9lbp3yCqT64L6JmAJZnjZ7e9Om/G
         kGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BVYTgofx2vWv0hLPfqdADHe6fqD8GxjFNi7DELpOj00=;
        b=SfVQuClpQtnbGIX4Hme7E6KzYnNAPNHwzPUa/Cbu2/inCev87QfQKl8UuqbUot6aou
         EWiWh61+0cw3ynJayuocP8Pko2Jn5rNk/rfCYmsanPp9wbEsBdYZV87L0YphWH5SsnWx
         /aUZaP5IaesVd/xZmfzw3IEtlyrB29nO7WuhrNUbiTfNH6cxj47lbeYosN7YYs5yYi04
         y4Y5lSW+C1PUDFXTaiWOeadF0Jm2UCQj29I6h44cMePsO+ROjdSVZu0h5r1aHYlZDLX/
         nZiRy0l4zZduJVyTzeJ7VCnVOe+cWXi+7FbDj6xLrH5wrJ7OizSfztELdDF6tPhuPInU
         JNrg==
X-Gm-Message-State: AOAM530/iWWVihoqdkbPd+CP8IFJeZe9H4Wfkk30mxZTXhCyYEbuDG08
        z7AyATnmN4w95tG8z060h6ODbbtrx2U=
X-Google-Smtp-Source: ABdhPJzuEwU6KhB7QPMbFhK8pUr4PXnIIrwovsuYFsQrQviuxV4HD8YO98TF2IHTGpVZv4fN7j1pVQ==
X-Received: by 2002:a05:600c:25c2:: with SMTP id 2mr20188861wml.170.1608609500373;
        Mon, 21 Dec 2020 19:58:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q1sm28148075wrj.8.2020.12.21.19.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 19:58:19 -0800 (PST)
Message-Id: <48c79dc3d84f55dec4cd2199cc4152e146bee0ba.1608609498.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.820.v5.git.1608609498.gitgitgadget@gmail.com>
References: <pull.820.v4.git.1608599513.gitgitgadget@gmail.com>
        <pull.820.v5.git.1608609498.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Dec 2020 03:58:16 +0000
Subject: [PATCH v5 1/2] negative-refspec: fix segfault on : refspec
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nipunn Koorapati <nipunn@dropbox.com>

The logic added to check for negative pathspec match by c0192df630
(refspec: add support for negative refspecs, 2020-09-30) looks at
refspec->src assuming it is never NULL, however when
remote.origin.push is set to ":", then refspec->src is NULL,
causing a segfault within strcmp.

Tell git to handle matching refspec by adding the needle to the
set of positively matched refspecs, since matching ":" refspecs
match anything as src.

Add test for matching refspec pushes fetch-negative-refspec
both individually and in combination with a negative refspec.

Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
 remote.c                          | 10 ++++--
 t/t5582-fetch-negative-refspec.sh | 51 +++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index 8be67f0892b..4f1a4099f1a 100644
--- a/remote.c
+++ b/remote.c
@@ -751,9 +751,13 @@ static int query_matches_negative_refspec(struct refspec *rs, struct refspec_ite
 
 			if (match_name_with_pattern(key, needle, value, &expn_name))
 				string_list_append_nodup(&reversed, expn_name);
-		} else {
-			if (!strcmp(needle, refspec->src))
-				string_list_append(&reversed, refspec->src);
+		} else if (refspec->matching) {
+			/* For the special matching refspec, any query should match */
+			string_list_append(&reversed, needle);
+		} else if (!refspec->src) {
+			BUG("refspec->src should not be null here");
+		} else if (!strcmp(needle, refspec->src)) {
+			string_list_append(&reversed, refspec->src);
 		}
 	}
 
diff --git a/t/t5582-fetch-negative-refspec.sh b/t/t5582-fetch-negative-refspec.sh
index 8c61e28fec8..2f3b064d0e7 100755
--- a/t/t5582-fetch-negative-refspec.sh
+++ b/t/t5582-fetch-negative-refspec.sh
@@ -186,4 +186,55 @@ test_expect_success "fetch --prune with negative refspec" '
 	)
 '
 
+test_expect_success "push with matching : and negative refspec" '
+	# Manually handle cleanup, since test_config is not
+	# prepared to take arbitrary options like --add
+	test_when_finished "test_unconfig -C two remote.one.push" &&
+
+	# For convenience, we use "master" to refer to the name of
+	# the branch created by default in the following.
+	#
+	# Repositories two and one have branches other than "master"
+	# but they have no overlap---"master" is the only one that
+	# is shared between them.  And the master branch at two is
+	# behind the master branch at one by one commit.
+	git -C two config --add remote.one.push : &&
+
+	# A matching push tries to update master, fails due to non-ff
+	test_must_fail git -C two push one &&
+
+	# "master" may actually not be "master"---find it out.
+	current=$(git symbolic-ref HEAD) &&
+
+	# If master is in negative refspec, then the command will not attempt
+	# to push and succeed.
+	git -C two config --add remote.one.push "^$current" &&
+
+	# With "master" excluded, this push is a no-op.  Nothing gets
+	# pushed and it succeeds.
+	git -C two push -v one
+'
+
+test_expect_success "push with matching +: and negative refspec" '
+	test_when_finished "test_unconfig -C two remote.one.push" &&
+
+	# The same set-up as above, whose side-effect was a no-op.
+	git -C two config --add remote.one.push +: &&
+
+	# The push refuses to update the "master" branch that is checked
+	# out in the "one" repository, even when it is forced with +:
+	test_must_fail git -C two push one &&
+
+	# "master" may actually not be "master"---find it out.
+	current=$(git symbolic-ref HEAD) &&
+
+	# If master is in negative refspec, then the command will not attempt
+	# to push and succeed
+	git -C two config --add remote.one.push "^$current" &&
+
+	# With "master" excluded, this push is a no-op.  Nothing gets
+	# pushed and it succeeds.
+	git -C two push -v one
+'
+
 test_done
-- 
gitgitgadget

