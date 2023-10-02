Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A16BE784AB
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 16:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238535AbjJBQze (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Oct 2023 12:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238523AbjJBQzc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2023 12:55:32 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD64A9
        for <git@vger.kernel.org>; Mon,  2 Oct 2023 09:55:29 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-534659061afso13451919a12.3
        for <git@vger.kernel.org>; Mon, 02 Oct 2023 09:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696265728; x=1696870528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wdo8W5kCCEYMOK6uRqIb3nAKp5ZSd+chRwny8i1rB0=;
        b=M4cF84sPCjc9MuFITuCDOaKs+NAfr4S9sW71WGmolyJNy5dTqscBEQf/twnIVmWFxC
         NKyqovop9j8W9QQdS1bEehfPGHHKvhJ4jun4PZUgHAwYcAKcN0eC4wpyGV0db0YiXhsQ
         p+wQgAaCDbHKvxbvFDNFY9wlTaQcsIMB2pPNVw1/IsxHv9WOq3GTvZTNAAsV4D0fjv5v
         4RiFUHwRFVSERl9uESvWQG/shrmLfvhrw5mhtO5uejl4Axg7kg7yxJypvBWGvSqPrWfd
         ynB8v08tDr43G60oAJoynMdy/dMWbKVp+b1e46BGWu8HQ/Ub9LmUJUcvGrD9Kq6F+YSH
         4BRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696265728; x=1696870528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wdo8W5kCCEYMOK6uRqIb3nAKp5ZSd+chRwny8i1rB0=;
        b=lBayPHAW8J4ozXYiOgGxKWTTXoKSEDPOVhaN0bh7f6lcU4pAswRXNDcqcKyWqLVkw5
         qHwWfososExPOtwDhrczwXd65cEpiCHLfOnMk1o+Ss13xh3c1SgEKSrMiaYgxkB1UIRB
         30tr3ferRm8UwhrBkJHxli9mWvueH59UxgN6CTrI3EFTzYHxIbpAXJKtLw0lJ/SCR2zT
         ipjUjaT07yYRnKmiyWchtsNB7EKsfISxz12Y5zuT0VarVj24viS3IwryHTXhZoiIHRsi
         Fvqq2ZWRMcEEeNaWAeMujasAu21hcwcet9FlkmGVESBuDdAYcbyTmhRt3dZqOvPXIM9G
         FZjg==
X-Gm-Message-State: AOJu0YwyRSEhCxWBOcX+rrSykrwVmgLhnp1GkSTRcudSbFIJQbTiipni
        d+otXzyEoGN5TGPiJFA8yciIlVdkP19e7A==
X-Google-Smtp-Source: AGHT+IFxT0Ukskua9846kx8GlVsO9KzD4d7pb7vOUywk+kfVIqwqmqjqfvNCNwGL5z95criqkf2bjQ==
X-Received: by 2002:a05:6402:26c3:b0:531:11fa:eacf with SMTP id x3-20020a05640226c300b0053111faeacfmr12356294edd.2.1696265727643;
        Mon, 02 Oct 2023 09:55:27 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:c027:f1d4:d825:fbf4:9197:5c9f])
        by smtp.gmail.com with ESMTPSA id er15-20020a056402448f00b00533c844e337sm12762364edb.85.2023.10.02.09.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 09:55:27 -0700 (PDT)
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
Subject: [PATCH v8 1/9] pack-objects: allow `--filter` without `--stdout`
Date:   Mon,  2 Oct 2023 18:54:56 +0200
Message-ID: <20231002165504.1325153-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.305.g5bfd918c90
In-Reply-To: <20231002165504.1325153-1-christian.couder@gmail.com>
References: <20230925152517.803579-1-christian.couder@gmail.com>
 <20231002165504.1325153-1-christian.couder@gmail.com>
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
index 6eb9756836..89a8b5a976 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4402,12 +4402,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
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
2.42.0.305.g5bfd918c90

