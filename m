Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E2DEB64DD
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 06:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjGEGIl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 02:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjGEGIh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 02:08:37 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F6D10C3
        for <git@vger.kernel.org>; Tue,  4 Jul 2023 23:08:35 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbca8935bfso50124345e9.3
        for <git@vger.kernel.org>; Tue, 04 Jul 2023 23:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688537313; x=1691129313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1pPBDeU9PFJ+cpOuqfIS73mPIlEz/tCTAD1Q12GMpw=;
        b=GCjOBCrNRPy6lTOIOXHvuU4oymV2T3GWFLqIjHrrWWpiv4HBMaGOXLXLh8pf/Gtk/C
         nmivvi9IDAtiaYhRGcxpy5+uYIcshQJd5cdOJ4rl8SaP7CDhX1Mu5gzyWqZYMT6J87sc
         gdxir64/CV8vHziUzf+rborLrh+9mYPR3KIuFEHt7AoG6jerJ+tLiSEYIUkFkSfVFYhL
         tLj3+sV76nIAvSelruiNzjVzn+xLCSW8quyAFsYVoxTa+hNz/B7GDfSIBwskw+waj60L
         HG5nOwe+jTdOz5MmDrZR+vZEK/Fx3JNcjeNkDDppmimD73KX5uvQFWO1d1MYMgM5Vsg/
         Zlpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688537313; x=1691129313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i1pPBDeU9PFJ+cpOuqfIS73mPIlEz/tCTAD1Q12GMpw=;
        b=U91L1npzHIuULiZ2PQoDOXQUR7fX2pQFSEINva/BKpZ3JgbdpvDonpw4+x0qeaR7Sm
         jbOBRsInOmQ0kSQM1WNioPX6lFjgV6GPq0+yC5Z55Ix+MeNF5XIhnSWvKjIvdoH8Iv37
         y2khmaiKPOT66Q/HCfb7PG56/M3KA3OdPRUlmCWpXpAnMmqIpvQfhwlxMzbWD46ChY0u
         yrfrHnQ82adQ2MCRzIy0XWdEZOGZ+qoTNlAtPZfN3jzlwQkyRXOyF+LGx0ukpDSDBOpj
         JIsB41Upt9Exvtjk0pknteok5wOvu/7JSuGP/FrCYTW1ktUxMvo/dpgWtfvrK+wX68xe
         EIng==
X-Gm-Message-State: AC+VfDw7wgNOrxxXm49+waPAH3BlPLX4NqbJfx2MPMBnVFUqwweCPZt5
        m/fQpn79uHU0RJWc9o4UiZn/jP+OWg8=
X-Google-Smtp-Source: ACHHUZ4mGm21H4tyuhsczuLB9pDMogiPIWvicKv2ygkPXfZOTbTLv1B25T/YLsT4URK+GtcO9tFxmg==
X-Received: by 2002:a05:600c:2253:b0:3fb:a5b3:4f02 with SMTP id a19-20020a05600c225300b003fba5b34f02mr12104909wmm.36.1688537313055;
        Tue, 04 Jul 2023 23:08:33 -0700 (PDT)
Received: from christian-Precision-5550.lan ([2001:861:3f04:7ca0:f6a2:3135:7895:378b])
        by smtp.gmail.com with ESMTPSA id k15-20020a7bc40f000000b003fbaf9abf2fsm1087762wmi.23.2023.07.04.23.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 23:08:32 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 1/8] pack-objects: allow `--filter` without `--stdout`
Date:   Wed,  5 Jul 2023 08:08:05 +0200
Message-ID: <20230705060812.2865188-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.41.0.244.g8cb3faa74c
In-Reply-To: <20230705060812.2865188-1-christian.couder@gmail.com>
References: <20230614192541.1599256-1-christian.couder@gmail.com>
 <20230705060812.2865188-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

9535ce7337 (pack-objects: add list-objects filtering, 2017-11-21)
taught `git pack-objects` to use `--filter`, but required the use of
`--stdout` since a partial clone mechanism was not yet in place to
handle missing objects. Since then, changes like 9e27beaa23
(promisor-remote: implement promisor_remote_get_direct(), 2019-06-25)
and others added support to dynamically fetch objects that were missing.

Even without a promisor remote, filtering out objects can also be useful
if we can put the filtered out objects in a separate pack, and in this
case it also makes sense for pack-objects to write the packfile directly
to an actual file rather than on stdout.

Remove the `--stdout` requirement when using `--filter`, so that in a
follow-up commit, repack can pass `--filter` to pack-objects to omit
certain objects from the resulting packfile.

Signed-off-by: John Cai <johncai86@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-pack-objects.txt     | 4 ++--
 builtin/pack-objects.c                 | 8 ++------
 t/t5317-pack-objects-filter-objects.sh | 8 ++++++++
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index a9995a932c..583270a85f 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -298,8 +298,8 @@ So does `git bundle` (see linkgit:git-bundle[1]) when it creates a bundle.
 	nevertheless.
 
 --filter=<filter-spec>::
-	Requires `--stdout`.  Omits certain objects (usually blobs) from
-	the resulting packfile.  See linkgit:git-rev-list[1] for valid
+	Omits certain objects (usually blobs) from the resulting
+	packfile.  See linkgit:git-rev-list[1] for valid
 	`<filter-spec>` forms.
 
 --no-filter::
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 3c4db66478..614721684a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4388,12 +4388,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
 		unpack_unreachable_expiration = 0;
 
-	if (filter_options.choice) {
-		if (!pack_to_stdout)
-			die(_("cannot use --filter without --stdout"));
-		if (stdin_packs)
-			die(_("cannot use --filter with --stdin-packs"));
-	}
+	if (stdin_packs && filter_options.choice)
+		die(_("cannot use --filter with --stdin-packs"));
 
 	if (stdin_packs && use_internal_rev_list)
 		die(_("cannot use internal rev list with --stdin-packs"));
diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
index b26d476c64..2ff3eef9a3 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -53,6 +53,14 @@ test_expect_success 'verify blob:none packfile has no blobs' '
 	! grep blob verify_result
 '
 
+test_expect_success 'verify blob:none packfile without --stdout' '
+	git -C r1 pack-objects --revs --filter=blob:none mypackname >packhash <<-EOF &&
+	HEAD
+	EOF
+	git -C r1 verify-pack -v "mypackname-$(cat packhash).pack" >verify_result &&
+	! grep blob verify_result
+'
+
 test_expect_success 'verify normal and blob:none packfiles have same commits/trees' '
 	git -C r1 verify-pack -v ../all.pack >verify_result &&
 	grep -E "commit|tree" verify_result |
-- 
2.41.0.244.g8cb3faa74c

