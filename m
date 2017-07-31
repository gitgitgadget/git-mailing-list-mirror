Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D50741F991
	for <e@80x24.org>; Mon, 31 Jul 2017 21:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751634AbdGaVDC (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 17:03:02 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:33721 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751607AbdGaVC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 17:02:59 -0400
Received: by mail-pg0-f52.google.com with SMTP id c14so50432308pgn.0
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 14:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=W5Ly/LkXUXlgyWjrui3DzIr5YKZD/EjfiWsxV8P9OoI=;
        b=fqykTFcXlbScc8uI0sdLlD3qNJQ32cmBRJESqnMGklFkzeR1y9jACEj52n8qrLllr+
         3ybIDeezJ5pMyyNGSJ3GcbuDLQ9NDAnkPT9HBfXJXtFBl3vHhazCM8w/QFQ/GLsRGoZD
         C67Ib8YEoqnq+7F285/xP+Vwrv3mfbzfJs2zzPJOaoF1tjuig7KzMlrRlgQ/KxvbTukb
         gcLtB6VoW8Ka0ktdmfbt/xcNEjpO2Fgx8dJ9ism29O9G+w1NyzR103fY22AhPj7zuicP
         9+bD4d4uoXH7lqyi6Vlf5QCj2fw1v5/PQ/2zdHsnLzwllysVb5DnxVOtX/cHRXtr8uVx
         NLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=W5Ly/LkXUXlgyWjrui3DzIr5YKZD/EjfiWsxV8P9OoI=;
        b=LP3sBolF1YJwR/ioz7Mm70oe9nYBf+f6wvA+l6hjYN6pZg1jGeFcAGKh2bQCt4fQ2x
         jRY0+S0AgiKZj0l5DR71Im2U7WiV4RuCZtUiPp1FOzQ782dRKUv0QoPP5qmkvtBoYhMs
         y+yyuDPyzC5xPzbZVe/8gNOwqu058+WwPqUCcyvyfiS8LXtDhrJndGdLBot1Mhx1Af/I
         lRLotGGUAyjIbQnBBOOEpayuFNESCGtSDN8xWlt5yEI/m2CbDPOUWsoiBmS00o5wbQZi
         r4k7tQ8VH5O8ev/nNWfGc7/OC4EAPxiUCQ5FdI1pS5kb2Bd/X0btBkk6Io3x5yGwVGWm
         gAqw==
X-Gm-Message-State: AIVw1110ZdbJ9Uaih4lP9YGNu6RQ1wdJdz4nDAaJIvIjxGxLAY7J0SDD
        a6gWtnP1P9fuzFFGmiSiEw==
X-Received: by 10.99.126.86 with SMTP id o22mr16845638pgn.367.1501534978254;
        Mon, 31 Jul 2017 14:02:58 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id k185sm53231673pgc.31.2017.07.31.14.02.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Jul 2017 14:02:56 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peartben@gmail.com, christian.couder@gmail.com
Subject: [PATCH v2 2/5] fsck: support refs pointing to lazy objects
Date:   Mon, 31 Jul 2017 14:02:44 -0700
Message-Id: <089edcd78c7ed6f3d0a6b0cdd107a20f1f9b583e.1501532294.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.rc1.383.gd1ce394fe2-goog
In-Reply-To: <cover.1501532294.git.jonathantanmy@google.com>
References: <cover.1501532294.git.jonathantanmy@google.com>
In-Reply-To: <cover.1501532294.git.jonathantanmy@google.com>
References: <cover.1501111615.git.jonathantanmy@google.com> <cover.1501532294.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach fsck to not treat refs with missing targets as an error when
extensions.lazyobject is set.

For the purposes of warning about no default refs, such refs are still
treated as legitimate refs.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fsck.c         |  8 ++++++++
 t/t0410-lazy-object.sh | 20 ++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index b7e245654..38ed630d8 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -438,6 +438,14 @@ static int fsck_handle_ref(const char *refname, const struct object_id *oid,
 
 	obj = parse_object(oid);
 	if (!obj) {
+		if (repository_format_lazy_object) {
+			/*
+			 * Increment default_refs anyway, because this is a
+			 * valid ref.
+			 */
+			default_refs++;
+			return 0;
+		}
 		error("%s: invalid sha1 pointer %s", refname, oid_to_hex(oid));
 		errors_found |= ERROR_REACHABLE;
 		/* We'll continue with the rest despite the error.. */
diff --git a/t/t0410-lazy-object.sh b/t/t0410-lazy-object.sh
index 36442531f..00e1b4a88 100755
--- a/t/t0410-lazy-object.sh
+++ b/t/t0410-lazy-object.sh
@@ -29,4 +29,24 @@ test_expect_success '...but succeeds if lazyobject is set' '
 	git -C repo fsck
 '
 
+test_expect_success 'fsck fails on lazy object pointed to by ref' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo 1 &&
+
+	A=$(git -C repo commit-tree -m a HEAD^{tree}) &&
+
+	# Reference $A only from ref, and delete it
+	git -C repo branch mybranch "$A" &&
+	delete_object repo "$A" &&
+
+	test_must_fail git -C repo fsck
+'
+
+test_expect_success '...but succeeds if lazyobject is set' '
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.lazyobject "arbitrary string" &&
+	git -C repo fsck
+'
+
 test_done
-- 
2.14.0.rc1.383.gd1ce394fe2-goog

