Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70CCC433E3
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 19:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C7992087D
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 19:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="revGDt0g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgHXTRE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 15:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgHXTQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 15:16:58 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71589C061574
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 12:16:58 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id l13so11759425ybf.5
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 12:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=HH00SexG0J8IcmXs/ID7rNy8ETPZT4GR4nyyg0M7X+M=;
        b=revGDt0g6y9vfgAkQfuAt4rXkljhixqXc0julS13wxJOsRENiuDgAwsLmNc72KZxZL
         7LB45lHt87V94ccESB73av22HGwTjinUw+sFXoqemGGqLekWtIWZprnE8Us3sE05ryzY
         wAdqfXbF9e3AuDp6Gf8FK5dR1RAdxzza+mu7qjz9bcUyAJ3I7QjUltOBj/KxlUVW2PuG
         fMXWmWcQFlVAAu6VqamPgR2fyiEEpscRn2jc53DS2gU2FBD/gUGb9f10RUAv3VqhVPG7
         LqkeNPhBDGG46KxaMuJHdC07PjKkmAxvfA+Yorw7hm5F38ybALsxmlljGVbkm12Z6NEG
         KKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HH00SexG0J8IcmXs/ID7rNy8ETPZT4GR4nyyg0M7X+M=;
        b=IKL8VU6hSqD+KLB1uVz59nqdHupzpyOz1cPKD02Eancz1kxzR0MVTq3aSvpifttrvs
         dh+pZ4wtxVeUf2kf7stDqqrlLFt9DGoPDkzKLR8u1N2Z7ClTJa/eB+lUN/pbiID87VFZ
         sR9UYu0CiIMnPcZ5yofBhzrJcXiefCzEvPabmlZ9AFAqwoBUDb8GeGHvaV6ZF8KkKxPL
         eyWzWiSqJCv87ISM/l1f5wDbk7NxJdDPoOQa0mMIj/WdSYFpWkclRT3t8DpkqUFCGIrt
         7ExRuceXFCRXoEBxUxVir5Hn6SY9xmxOE/fHBTD6i2ysnI8XdQHdV0kGhOaE1Xwu8BJ2
         uftQ==
X-Gm-Message-State: AOAM531FtphPBU+cpntrVf+ptnvkVxAkdsmEgsjFW2Fmtqm/n+En0sbL
        p5ZQPF9wuSe6vYmXFnRaZN8CrpZVq6crchAwakh4GoeL0AnhAuWgcooaVZCvLVgCsgwDnPHDVCn
        uMkFhCxPlruLLJzH5tI54QPQ82Z8b9fHvBXcwgF7lrpCCMw65ZN0ovHY1CPryKJAW7gQ8rJaQCg
        mk
X-Google-Smtp-Source: ABdhPJwx91LdEcxmNXGJycAHjqTLyChuN4UvRBt4QaGua15q6R2Zc9N5/N9raDWzIxkV5xdDZzrZQ1MWWYET5s2k1V6v
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a25:5305:: with SMTP id
 h5mr8728287ybb.433.1598296617624; Mon, 24 Aug 2020 12:16:57 -0700 (PDT)
Date:   Mon, 24 Aug 2020 12:16:32 -0700
In-Reply-To: <cover.1598296530.git.jonathantanmy@google.com>
Message-Id: <20200824191656.3870231-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1598296530.git.jonathantanmy@google.com>
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

