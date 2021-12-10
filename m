Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7683BC433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 15:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242741AbhLJPV4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 10:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242752AbhLJPVt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 10:21:49 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77B9C061746
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 07:18:13 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 137so7078149wma.1
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 07:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cVnWEd0GVO9mjLJ3Yu+vv33DBI83fSFBcOn2vfL69ZY=;
        b=Ug8JSuSLBZYcf+oXFDK6HzjQaf8ICoOcn7XSv6ke9pUB26OH/B0ooOHLEcu2YmW3CO
         +jg8FyYWAnhBGYJNj3WBdEgcnR0EOUzuwYKbGDQ1y78M0ZjunfP8cOoBTExnwo1rEEti
         BJGa1tjCTYm/c7x6JGrmw2i5xKcux6/MGOZGsHc7KEskiVzdvJ/PAWP7vn/nLhhgW9jS
         K5U3qwUeOmV7yUmXL0kDT0MXUya3qh+6qsMPlZcuH0JPGVfMN8rYP8xlbJPab9IKEJPs
         ilzegl8KqY2yXsodguNR//TE/knEofS/xjP0+G2FwgVa/KR19l5xI1J7HnRSF5YGONny
         TpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cVnWEd0GVO9mjLJ3Yu+vv33DBI83fSFBcOn2vfL69ZY=;
        b=KorNXYvmy4tS9IQ0fkvh51hrfMlHqpB6QlNpv6igEx8GYM9UNMyDjHczI4fxJi1ZGE
         bJeTefIYc+QJ9qziq7Tm8bgxjXUDCF6MrSNmC49zXx54NXvOvfQjga+uSxOWvOUSKpKH
         lY6Wsn0ido4286jwkmwSUy+SBoeWCitk3ls5jhv6NoAVYyuLmqxmwwmrOamp1mYqRiKI
         v1KpQwQXcBtvn39DVe4pl5Z1PbDM3LlHaAkVV+NzNQLMQy0tjOcoQ74OsGrR4vP/HXdu
         dWKpCxtFKeuudCdJEkLCk9OLIECRgV7jWaVnr5m1lAZgNXHe+JwExNJFKX6ACcnpmb5e
         793A==
X-Gm-Message-State: AOAM533VwHSYVP/la0Zfi/irn3jQNo4oCZp92Bf/1jKtbTB99BDL/sFQ
        KQq86iCjGfF0DYWv1ocfvL/1MaXcFRU=
X-Google-Smtp-Source: ABdhPJysug577KSBVF9cb8Ry+HUcah1bpUHRmBJd0kaYONcT59dFCjuGs/rMqmUA3SoHtu1d8dj3qQ==
X-Received: by 2002:a1c:8:: with SMTP id 8mr17019939wma.106.1639149492040;
        Fri, 10 Dec 2021 07:18:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v2sm2943921wmc.36.2021.12.10.07.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 07:18:11 -0800 (PST)
Message-Id: <a0e3dd335c98bb625fce6bbf9a7a7491e9be7760.1639149490.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1069.v2.git.1639149490.gitgitgadget@gmail.com>
References: <pull.1069.git.1638907336.gitgitgadget@gmail.com>
        <pull.1069.v2.git.1639149490.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Dec 2021 15:18:08 +0000
Subject: [PATCH v2 1/4] sparse-checkout: fix segfault on malformed patterns
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, newren@gmail.com, vdye@github.com,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Then core.sparseCheckoutCone is enabled, the sparse-checkout patterns are
used to populate two hashsets that accelerate pattern matching. If the user
modifies the sparse-checkout file outside of the 'sparse-checkout' builtin,
then strange patterns can happen, triggering some error checks.

One of these error checks is possible to hit when some special characters
exist in a line. A warning message is correctly written to stderr, but then
there is additional logic that attempts to remove the line from the hashset
and free the data. This leads to a segfault in the 'git sparse-checkout
list' command because it iterates over the contents of the hashset, which is
no invalid.

The fix here is to stop trying to remove from the hashset. Better to leave
bad data in the sparse-checkout matching logic (with a warning) than to
segfault. If we are in this state, then we are already traversing into
undefined behavior, so this change to keep the entry in the hashset is no
worse than removing it.

Add a test that triggers the segfault without the code change.

Reported-by: John Burnett <johnburnett@johnburnett.com>
Reviewed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 dir.c                              |  3 ---
 t/t1091-sparse-checkout-builtin.sh | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index 5aa6fbad0b7..0693c7cb3ee 100644
--- a/dir.c
+++ b/dir.c
@@ -819,9 +819,6 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
 		/* we already included this at the parent level */
 		warning(_("your sparse-checkout file may have issues: pattern '%s' is repeated"),
 			given->pattern);
-		hashmap_remove(&pl->parent_hashmap, &translated->ent, &data);
-		free(data);
-		free(translated);
 	}
 
 	return;
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 272ba1b566b..c72b8ee2e7b 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -708,4 +708,19 @@ test_expect_success 'cone mode clears ignored subdirectories' '
 	test_cmp expect out
 '
 
+test_expect_success 'malformed cone-mode patterns' '
+	git -C repo sparse-checkout init --cone &&
+	mkdir -p repo/foo/bar &&
+	touch repo/foo/bar/x repo/foo/y &&
+	cat >repo/.git/info/sparse-checkout <<-\EOF &&
+	/*
+	!/*/
+	/foo/
+	!/foo/*/
+	/foo/\*/
+	EOF
+	cat repo/.git/info/sparse-checkout &&
+	git -C repo sparse-checkout list
+'
+
 test_done
-- 
gitgitgadget

