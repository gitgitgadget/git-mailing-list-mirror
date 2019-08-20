Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E5001F461
	for <e@80x24.org>; Tue, 20 Aug 2019 20:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbfHTUx0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 16:53:26 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:33374 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbfHTUxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 16:53:25 -0400
Received: by mail-qt1-f201.google.com with SMTP id z15so218715qts.0
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 13:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=AYtnHM6W2Rk6lU/MdbzF/1x2IMgUtZDcFaNtgasDMf0=;
        b=R812Ry4M75Sl5pDxbOhNhjqgf2BwX6pacQU8ZQU2wCBHOX4SdgG5LSGNFtrRqUTYr+
         D8CK2AORDtXPRnBKq4ZGrj7mBq/J6pXAMfhgOuxPcKD1eBTgriYwe8A6TW+NIbbKb4zG
         EUykNLG6ykMZr4eZftVPSsUnJwcySZTaYBrywT2y0bPrFwzwoRLSqdhFBxj52yTfGexQ
         Ecp2BiyAKpu6xRlOL/O4PIG1NeVhKI0i7Fj8XbA2eNRhIM2TlptJ+rJoo+VccYPlmzll
         JUQNP37gUzt2DLtCRs1sNdfCg1sGoHGmvw3DFH2RnURJF2iUmUfMJRimqtBwY9sXizHh
         RFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=AYtnHM6W2Rk6lU/MdbzF/1x2IMgUtZDcFaNtgasDMf0=;
        b=kveeulWhkA4xtwr3ZGD0xt8GiYCGH0y4Zz7sqDhSK0+tN9ShHbfRhHhDakqORaHaIy
         UgFDxfhjJiGqbLMyqIFiHtIBPm7e28jCBmPRcXpWY7+NyYGi/whMP/QDbyeFoLnNg71D
         9mndw6QfhRbgbySMJT0M0PA1t0/Ys7hPkJH8Kqeb/xTpPKrBYjlIOev5lPpytay1m11k
         BunL9Ud3F8DiI390u9RnR7H5kky/4+fd5loWcpYvaoNRoTLI6GfbX3SexBSpEQD2DN2S
         +JEkQXH4qoUE+uupg3CYCDHbq1p4fr+JsPMYguy3zxTekqAI9tecxivA5H5+Nnvtwifb
         aJ+w==
X-Gm-Message-State: APjAAAU0bKcvnPV3srT9qqenCfZGhtEb0ZN5lYVQIOn9kmu1HlTYH+y8
        UOFELVtgt1XTOTIY3cNxT0AJVn5AlW4by6ZRshM8BOG88MPGkYsLOrA921YdVAg3LEHi7irFgRU
        baSjXBdffNvYm7sP0dtJEzZcSR2ijn++Br6TgqjtHSsesn8PZuzjLZIhXiMtd+9/SLBfonAAICz
        zZ
X-Google-Smtp-Source: APXvYqzTZ1ramfmrs2fk7S6oqwksZMMQPqLSZtE01Z1VzxBt8POcJ+CGgTfI36gcHRi8fSM/Z6gkO56AwYJg7b4oX1bv
X-Received: by 2002:a37:c15:: with SMTP id 21mr26169312qkm.425.1566334404978;
 Tue, 20 Aug 2019 13:53:24 -0700 (PDT)
Date:   Tue, 20 Aug 2019 13:53:20 -0700
Message-Id: <20190820205320.139006-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH] diff: skip GITLINK when lazy fetching missing objs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 7fbbcb21b1 ("diff: batch fetching of missing blobs", 2019-04-08),
diff was taught to batch the fetching of missing objects when operating
on a partial clone, but was not taught to refrain from fetching
GITLINKs. Teach diff to check if an object is a GITLINK before including
it in the set to be fetched.

(As stated in the commit message of that commit, unpack-trees was also
taught a similar thing prior, but unpack-trees correctly checks for
GITLINK before including objects in the set to be fetched.)
---
One of my colleagues noticed this when switching branches in a
superproject with a dirty working tree (hence triggering the diff
mechanism). The test I included in this commit tests a simpler use case,
but I've verified that this solves my colleague's case too.
---
 diff.c                        |  1 +
 t/t4067-diff-partial-clone.sh | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/diff.c b/diff.c
index efe42b341a..e28b463f57 100644
--- a/diff.c
+++ b/diff.c
@@ -6512,6 +6512,7 @@ static void add_if_missing(struct repository *r,
 			   const struct diff_filespec *filespec)
 {
 	if (filespec && filespec->oid_valid &&
+	    !S_ISGITLINK(filespec->mode) &&
 	    oid_object_info_extended(r, &filespec->oid, NULL,
 				     OBJECT_INFO_FOR_PREFETCH))
 		oid_array_append(to_fetch, &filespec->oid);
diff --git a/t/t4067-diff-partial-clone.sh b/t/t4067-diff-partial-clone.sh
index 90c8fb2901..4831ad35e6 100755
--- a/t/t4067-diff-partial-clone.sh
+++ b/t/t4067-diff-partial-clone.sh
@@ -75,6 +75,37 @@ test_expect_success 'diff skips same-OID blobs' '
 	! grep "want $(cat hash-b)" trace
 '
 
+test_expect_success 'when fetching missing objects, diff skips GITLINKs' '
+	test_when_finished "rm -rf sub server client trace" &&
+
+	test_create_repo sub &&
+	test_commit -C sub first &&
+
+	test_create_repo server &&
+	echo a >server/a &&
+	git -C server add a &&
+	git -C server submodule add "file://$(pwd)/sub" &&
+	git -C server commit -m x &&
+
+	test_commit -C server/sub second &&
+	echo another-a >server/a &&
+	git -C server add a sub &&
+	git -C server commit -m x &&
+
+	test_config -C server uploadpack.allowfilter 1 &&
+	test_config -C server uploadpack.allowanysha1inwant 1 &&
+	git clone --bare --filter=blob:limit=0 "file://$(pwd)/server" client &&
+
+	echo a | git hash-object --stdin >hash-old-a &&
+	echo another-a | git hash-object --stdin >hash-new-a &&
+
+	# Ensure that a and another-a are fetched, and check (by successful
+	# execution of the diff) that no invalid OIDs are sent.
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client diff HEAD^ HEAD &&
+	grep "want $(cat hash-old-a)" trace &&
+	grep "want $(cat hash-new-a)" trace
+'
+
 test_expect_success 'diff with rename detection batches blobs' '
 	test_when_finished "rm -rf server client trace" &&
 
-- 
2.23.0.rc1.153.gdeed80330f-goog

