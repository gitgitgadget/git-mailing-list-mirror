Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7A3CA0EC1
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 21:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349345AbjIKVdO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241334AbjIKPGw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 11:06:52 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E2ECCC
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 08:06:47 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99bed101b70so573119866b.3
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 08:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694444805; x=1695049605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIbqABvFJ4BjPGhX530W52Jkw3q0B29e0jMoQ1IP7Vc=;
        b=hY5o5AZsKrbyPUxpXGiQd9U3JeLSujSq0eyl0RxNCzUHdwSF3WK7GHq0vHSMsDK66v
         v7LHJBfkamK20XYtdg3sWHQpWSNuSIFQAjUOF0D7xe6BSvmv0GUhIn7d8vxjTKAl0f7G
         I8IIBCBLKiqy1IiDBAiAD3pZx9Vcjzf6Qp90zSFe7WNeysfWXDSt9CBzzsCYYe2jDDRT
         veTzCxsThC8WtJBHVnlg5RU4SJpT1LKZ1LLOw76/W5szg8glWKd7vSB35JZFoXkG7qAI
         S54DQn073tH15hzBqrubQmaAFyn0QuLBZ/zdfrEB8MQFELL1iNllrB2PzvYnuu0G4DGF
         YMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694444805; x=1695049605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIbqABvFJ4BjPGhX530W52Jkw3q0B29e0jMoQ1IP7Vc=;
        b=ei9DSDspaKZ6sfgIq4JIgMN9knfUAF79wwzBnqOB4ysz1bHQ7lGelnsBzzyUbLuEaj
         zAuztbT75QVBLLfUA7BU5JAgILmL5C5ejAxdOMOBxSWMK9OE4ENE3ifVVj4bLeNuoozn
         4RRhEa5nEjKtDaw6bMo6vyVxiNqFYZPomBO6cCbJQUtLDdCOsf/ZME52WSNzIvArj2n5
         t9l9muH3E+UpGT4X1t55kjUHjIxjh3iFXFN8nDYX1cX9cwDZPTK3TR9qHSXVoa+KegJM
         sVi+AyMBVjxY2i+UqXR+4w2mVVobMY10y3iNAJvhAhGI8B+mYYxf4jdmXYUfvmWbZcu6
         X1kw==
X-Gm-Message-State: AOJu0YwPbB8bLXlYpUWnLLvx1Uw+xgqbMlqFEuxyL7exgGJaw50O/BLQ
        F7gYgVrcsAg6zx+iVVXbD0yVB/I9iw4=
X-Google-Smtp-Source: AGHT+IHFicCugQdEcuzIT+3t407aJnv9C0HQdglByGwIM0b+hRfRPsDLPt1Uam9u+AoPsIoHRSWwWQ==
X-Received: by 2002:a17:907:75ce:b0:9a2:200:b694 with SMTP id jl14-20020a17090775ce00b009a20200b694mr7519641ejc.11.1694444804999;
        Mon, 11 Sep 2023 08:06:44 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:1085:31e2:f2be:e47a:b382:4542])
        by smtp.gmail.com with ESMTPSA id f5-20020a170906138500b0099cb1a2cab0sm5485617ejc.28.2023.09.11.08.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 08:06:44 -0700 (PDT)
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
Subject: [PATCH v6 1/9] pack-objects: allow `--filter` without `--stdout`
Date:   Mon, 11 Sep 2023 17:06:10 +0200
Message-ID: <20230911150618.129737-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.167.gd6ff314189
In-Reply-To: <20230911150618.129737-1-christian.couder@gmail.com>
References: <20230812000011.1227371-1-christian.couder@gmail.com>
 <20230911150618.129737-1-christian.couder@gmail.com>
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
index dea7eacb0f..e32404c6aa 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -296,8 +296,8 @@ So does `git bundle` (see linkgit:git-bundle[1]) when it creates a bundle.
 	nevertheless.
 
 --filter=<filter-spec>::
-	Requires `--stdout`.  Omits certain objects (usually blobs) from
-	the resulting packfile.  See linkgit:git-rev-list[1] for valid
+	Omits certain objects (usually blobs) from the resulting
+	packfile.  See linkgit:git-rev-list[1] for valid
 	`<filter-spec>` forms.
 
 --no-filter::
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 72241bdca4..e3e1d11640 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4399,12 +4399,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
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
2.42.0.167.gd6ff314189

