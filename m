Return-Path: <SRS0=wu5b=B6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673A7C433E1
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 17:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 384DF20885
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 17:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="AwBELude"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgHTRv0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Aug 2020 13:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgHTRvX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Aug 2020 13:51:23 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43520C061385
        for <git@vger.kernel.org>; Thu, 20 Aug 2020 10:51:23 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id x18so1584807pjq.1
        for <git@vger.kernel.org>; Thu, 20 Aug 2020 10:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=HH00SexG0J8IcmXs/ID7rNy8ETPZT4GR4nyyg0M7X+M=;
        b=AwBELudeggTZgCJLI+2ATkiO0iSEDhLdMmW89OLhlxRy4/Ieux+PtFHDRSbn80HVHy
         BuRtVNhZ9EiXqoTgvx134IsebZiQ2Rg2SwKezfYgKGlvPI7KcRuaZ/g40aiDq8AcZhPN
         CIDmvkghHsPd4UhJO3rn1LbwjWGQPrjaMXhq71uBv75Q1QJeb4h0heGTfrZhtuwSjnF8
         MvLu7CgtA4NbqJBdZ5P1a5qbEnrHgQUcvgFoP6ZCmGUD9c9wsypR0JiAO8UCzc5xw33O
         E4QCsK7FK5GX2t+lmuOno+foaMhxe8NiHOlJ+MhQDWVOtbemFpE73d5A8PKlxHq/c0CZ
         FnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=HH00SexG0J8IcmXs/ID7rNy8ETPZT4GR4nyyg0M7X+M=;
        b=MQSOP8kOLbCHln0Y3pa5FaP0963w96V7kWq+lA/3P1eTlCQG08x4PTOQfvhC5LZ4yq
         vBXT4Vky2MaTHt9vESAOItBnLsO2bVfejYwgJO6MRkgfP6qiJQTVGQovCcS6UElo0/p8
         bNSayrmjeSi8rZL8Q0MEe0xenuYYaIN6dTdXq0p0p53SE4xH4r1FGg0mmO5VUWME9xy+
         UVMI/U0k6FabGb7Jh1m7ZPI98y6V3X3F5ptPOXWQhGa8LvVevkq7qzf13jrPmUhSrbre
         vK9mLYqNYrhfGUZrXU+kP0AJ9Gv6kQfYUw3hGzv8MLuTSp+YMmROWVKd33QltGQy5Vnj
         69TA==
X-Gm-Message-State: AOAM533x/7BiSKmEKvanA1DMxcIWHPitW37ZsDlnV47Dkad+g5VPt9uo
        jcanfpNexSumWzAmwpx8CrHzV3u0cTQ+KvIEI3kXwCOfqgMsfqFu+ckyb3Hqv0hsgyD8UgC2al1
        0swdjPvFacnUkRep9JN2bPuFQf4hacQ1QsYA4MTpg7ag0jyEru8msj6f1Ku60HPqaeA2EzcJjiW
        gI
X-Google-Smtp-Source: ABdhPJzq4Kx4lwkqKAd7aD7v2F4Z5iq9UDq4IpZZqRJZPkV6TwSjcvbn4gIxeTbIS7BR1Biwk7LsusNlxOQxgh+2Gd7K
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:960f:: with SMTP id
 q15mr3183359pfg.79.1597945882449; Thu, 20 Aug 2020 10:51:22 -0700 (PDT)
Date:   Thu, 20 Aug 2020 10:51:16 -0700
Message-Id: <20200820175116.3889786-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH] fetch-pack: in partial clone, pass --promisor
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When fetching a pack from a promisor remote, the corresponding .promisor
file needs to be created. "fetch-pack" originally did this by passing
"--promisor" to "index-pack", but in 5374a290aa ("fetch-pack: write
fetched refs to .promisor", 2019-10-16), "fetch-pack" was taught to do
this itself instead, because it needed to store ref information in the
.promisor file.

This causes a problem with superprojects when transfer.fsckobjects is
set, because in the current implementation, it is "index-pack" that
calls fsck_finish() to check the objects; before 5374a290aa,
fsck_finish() would see that .gitmodules is a promisor object and
tolerate it being missing, but after, there is no .promisor file (at the
time of the invocation of fsck_finish() by "index-pack") to tell it that
.gitmodules is a promisor object, so it returns an error.

Therefore, teach "fetch-pack" to pass "--promisor" to index pack once
again. "fetch-pack" will subsequently overwrite this file with the ref
information.

An alternative is to instead move object checking to "fetch-pack", and
let "index-pack" only index the files. However, since "index-pack" has
to inflate objects in order to index them, it seems reasonable to also
let it check the objects (which also require inflated files).

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c             | 17 ++++++++++-------
 t/t5616-partial-clone.sh | 16 ++++++++++++++++
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 7f20eca4f8..d467edc24e 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -866,13 +866,16 @@ static int get_pack(struct fetch_pack_args *args,
 			 * have this responsibility.
 			 */
 			args->check_self_contained_and_connected = 0;
-		/*
-		 * If we're obtaining the filename of a lockfile, we'll use
-		 * that filename to write a .promisor file with more
-		 * information below. If not, we need index-pack to do it for
-		 * us.
-		 */
-		if (!(do_keep && pack_lockfiles) && args->from_promisor)
+
+		if (args->from_promisor)
+			/*
+			 * write_promisor_file() may be called afterwards but
+			 * we still need index-pack to know that this is a
+			 * promisor pack. For example, if transfer.fsckobjects
+			 * is true, index-pack needs to know that .gitmodules
+			 * is a promisor object (so that it won't complain if
+			 * it is missing).
+			 */
 			strvec_push(&cmd.args, "--promisor");
 	}
 	else {
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 8827c2ed18..5a01466db4 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -163,6 +163,22 @@ test_expect_success 'manual prefetch of missing objects' '
 	test_line_count = 0 observed.oids
 '
 
+test_expect_success 'partial clone with transfer.fsckobjects=1 works with submodules' '
+	test_create_repo submodule &&
+	test_commit -C submodule mycommit &&
+
+	test_create_repo src_with_sub &&
+	test_config -C src_with_sub uploadpack.allowfilter 1 &&
+	test_config -C src_with_sub uploadpack.allowanysha1inwant 1 &&
+
+	git -C src_with_sub submodule add "file://$(pwd)/submodule" mysub &&
+	git -C src_with_sub commit -m "commit with submodule" &&
+
+	git -c transfer.fsckobjects=1 \
+		clone --filter="blob:none" "file://$(pwd)/src_with_sub" dst &&
+	test_when_finished rm -rf dst
+'
+
 test_expect_success 'partial clone with transfer.fsckobjects=1 uses index-pack --fsck-objects' '
 	git init src &&
 	test_commit -C src x &&
-- 
2.28.0.297.g1956fa8f8d-goog

