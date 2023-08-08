Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62051C04A6A
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 19:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjHHTvb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 15:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbjHHTvH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 15:51:07 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82121FCC
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 09:58:03 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fe4ad22eb0so40237925e9.3
        for <git@vger.kernel.org>; Tue, 08 Aug 2023 09:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691513882; x=1692118682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1hS4z0JQ635nP20XNEGT8R2zz7AB5cmfUHv3f/pBtQ=;
        b=gVQsEVeDM9kfSQ6NSThvWSGsIC3b0jE8Rrw2kPBF5/UZvz8sGqiLwTfdGjT5Lv4J1k
         ok/bKB0tTcuLa/H5lo8qP43gZlmkc0yY887p6pw3zocJwpMqYHGoHcdOl3D+T7nblj2n
         hTTPCUZZ+7NwBJgEsUQNWArYvTpwh1PizIjwFlgj0o81Yt1xhsdAaInWnLdnelWfbxwR
         LYbtVKbH4lGDX873yyOWkOrLxXc6TcX71TJw1RnOy3z6Ay7yHy87iWzFUWGjWBX0qmkt
         Iwl5Z5zNHzCpvk3mIM74Bs3O6QiQ62RMdYbws5IF314VI8W8GfNH8UFSd5Megt2WJYg2
         jlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691513882; x=1692118682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1hS4z0JQ635nP20XNEGT8R2zz7AB5cmfUHv3f/pBtQ=;
        b=cWoG3W4RwwEvaRD4iSo3dne4kFNyHJm0QcMzhgQ8aAI436x1wZ25ShvvlA3IzPGuiz
         GWp9gWTbxyRyy9LWN6etazypFDbnTH3yapqBJtQnBVsHuXZpEib1EZlP8oSm595DIHkg
         ul3Uvb02YcRgAvZR9aroWi6RValz1TaS64z8xj79TMKwayLcAb/Vwy6jMvSftkquOEK4
         6gXlXRKsdZ9mB9thd61xk6SqzFSEaFVdmk3L6UcsxhwptuNvpN94i8dv/vGBILE6wytF
         7vQKgYqzoABDl57+OCWpmTVqV5Jnj/bcyu70Ac/9ZS7HGsOZcuVgJQAaiVd5GcwV/qqW
         hFqw==
X-Gm-Message-State: AOJu0Yz/IRiKJFsVObqXvNyNn10XvmssNiGE7regvCR+Eq0StcbYvkxj
        BRgpPEcT1mr/z/Zk4O7SoEEQznBTy4g=
X-Google-Smtp-Source: AGHT+IGkuEpt8tt4+vFjsJie0oFai51n2NFUX2VLbxq/fXonyfIZW1btFBXVXk3H8Zi3diDI6xRCKA==
X-Received: by 2002:adf:ff8c:0:b0:317:df3e:13d with SMTP id j12-20020adfff8c000000b00317df3e013dmr5307799wrr.38.1691483189326;
        Tue, 08 Aug 2023 01:26:29 -0700 (PDT)
Received: from christian-Precision-5550.lan ([2001:861:2420:9770:9200:db98:c1c8:97d0])
        by smtp.gmail.com with ESMTPSA id d17-20020a5d6dd1000000b003140fff4f75sm12845707wrz.17.2023.08.08.01.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 01:26:28 -0700 (PDT)
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
Subject: [PATCH v4 1/8] pack-objects: allow `--filter` without `--stdout`
Date:   Tue,  8 Aug 2023 10:26:01 +0200
Message-ID: <20230808082608.582319-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.rc0.8.g76fac86b0e
In-Reply-To: <20230808082608.582319-1-christian.couder@gmail.com>
References: <20230724085909.3831831-1-christian.couder@gmail.com>
 <20230808082608.582319-1-christian.couder@gmail.com>
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
index d2a162d528..000ebec7ab 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4400,12 +4400,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
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
2.42.0.rc0.8.g76fac86b0e

