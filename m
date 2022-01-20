Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A51DC433F5
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 17:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbiATRty (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 12:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbiATRtx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 12:49:53 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714A3C061574
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 09:49:53 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id x1-20020a17090ab00100b001b380b8ed35so4503711pjq.7
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 09:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kBbByrNFRfyeFLe4U8KRGl9oHeldlad0vXOAejrxrTo=;
        b=OIJouwVsalDBlS7TQKacnG+NtsiD5BGvH5BDAA2cXcjWmW7Mp662C56rCSyCVApUpr
         X0S/3LtVVMtX52sdhBVS7AtvwPHdRCy1XY82UTRxy9w1sU7zGFejwvOiPZqxzm8sF66N
         LKyHLRBfEQZfxjF79YI2Vy61CLhyTOs1SZHRsPPjI7AFFdR5+hF3Q/+oiJ31Gswib1IT
         3F/IJE7SEtBr/Os0FriCos1PI4FZ22VfFi48c3k2/adN7z34uUReIhJ58DKwKQo3pBbk
         aYzZDYTBQCs+8EgwiRBuJiYbx7NTV658shMYZU3N40P7RnyOdNETZfdx3Vcw5fcqne9w
         bMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kBbByrNFRfyeFLe4U8KRGl9oHeldlad0vXOAejrxrTo=;
        b=fOxwOt7kJowdu1R64cqfl6gZWEWk7PFPIprJAcrSQByFYUAhcRsZA9C7Bqj5f/mFi2
         jsm6AItxQ5zUcLdvs2KTdwF1RnKwmOgDp+Lj8XzkZ3dS0/PX0p2LqTe8ebOKOtt20pm8
         eEdg88KTcGvcW5pJzq098ifHExgbScXSXhz6S2uT7tAUJ+3MBriu8BgrCzmyEhugH5N7
         vrWaOD8OS9usInK4E+Es3Z9+xWMzBBKO0i1Yze75LpgYIPsojdbaNjvkRbz8fdE1OtAC
         mtHKCMhqWJpvE5bvkR4dICv11GVLjsa1KLRsFG7iQdAALjmyynZKd5JpaP9q5dMy61bm
         Cvbw==
X-Gm-Message-State: AOAM531qQdfboGi7ZmhiO0nOFZ+3VmhHRp6ksfL6bdd7I9434rNEJQTU
        MyFWnfwD9Hi5zP9KCPyd13UiBm5Lk8FkQIljsCu8ZfrvJHIkPqqoA0r+QABNGPaDKKmbQUVeqtf
        DLPIRyWWVbQPQFl7MBuCHj7XqsdS+kFesw8LWV4LaXJIhylXvgIvfJPOgHvHxgYk=
X-Google-Smtp-Source: ABdhPJxYGt2Hkf3X1NN/bBDcmU1HOIx6sNEGrIBtkC7wXS6FNtP58+HROSZjasWRj+gRZgfpmQamb2nnv4Jo0g==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:9343:b0:148:a2e7:fb5f with SMTP
 id g3-20020a170902934300b00148a2e7fb5fmr78013plp.160.1642700992866; Thu, 20
 Jan 2022 09:49:52 -0800 (PST)
Date:   Thu, 20 Jan 2022 09:49:41 -0800
In-Reply-To: <20220120174942.94231-1-chooglen@google.com>
Message-Id: <20220120174942.94231-3-chooglen@google.com>
Mime-Version: 1.0
References: <20220119000056.58503-1-chooglen@google.com> <20220120174942.94231-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH v7 2/3] fetch: skip tasks related to fetching objects
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <worldhello.net@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cmd_fetch() does the following with the assumption that objects are
fetched:

* Run gc
* Write commit graphs (if enabled by fetch.writeCommitGraph=true)

However, neither of these tasks makes sense if objects are not fetched
e.g. `git fetch --negotiate-only` never fetches objects.

Speed up cmd_fetch() by bailing out early if we know for certain that
objects will not be fetched. cmd_fetch() can bail out early whenever
objects are not fetched, but for now this only considers
--negotiate-only.

The same optimization does not apply to `git fetch --dry-run` because
that actually fetches objects; the dry run refers to not updating refs.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/fetch.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 0a625cb137..7bbff5a029 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2152,6 +2152,17 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		strvec_clear(&options);
 	}
 
+	/*
+	 * Skip irrelevant tasks because we know objects were not
+	 * fetched.
+	 *
+	 * NEEDSWORK: as a future optimization, we can return early
+	 * whenever objects were not fetched e.g. if we already have all
+	 * of them.
+	 */
+	if (negotiate_only)
+		goto cleanup;
+
 	prepare_repo_settings(the_repository);
 	if (fetch_write_commit_graph > 0 ||
 	    (fetch_write_commit_graph < 0 &&
-- 
2.33.GIT

