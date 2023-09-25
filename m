Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE9ACE7A81
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 15:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjIYPZr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 11:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbjIYPZq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 11:25:46 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D332DFF
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 08:25:39 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9b29186e20aso153823566b.2
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 08:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695655538; x=1696260338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R366ku2qccvwBlT+dCJDnDBr7SOQgvE8pTvURdasjYs=;
        b=E3yt2cDx0QVbaBrmD6mWxKSoPF9uXHHwpq0OxUpwxpXi8lFQ5aCJNlX6hb3yw8h11L
         SiDndiLzegsPB7DIAcQsVx9POQtaX3Mtup7dAAurC7V1pZl+O8jDtSs2QTHtpKoIzFkk
         8lI5L/P6QDgsciwIim1wMmaptX4xBEJYxoTpYUzKww7OKE8dX7UohUKHzJvxeKGo7dCw
         CS8/mY3j+bwyZu2yj9HoDRvpE6k6rfTgeIFT2NOoHjSCnOL9JPqV/n6imttc6e0f4ZtY
         EJokDAsx+9VzA9sg/7y3mJLCRapafsL1VHpFe769X0RIXd8jF7bRK+/a9jhSsx26mMpQ
         deIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695655538; x=1696260338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R366ku2qccvwBlT+dCJDnDBr7SOQgvE8pTvURdasjYs=;
        b=aLYSqoYQqxKh/xBifuXGtL6JWS4IDLurl2d+e/rjrZrcQfmRiA07PjZjgHUYNGOoNj
         tZIA5rDhiMA9LDV5+s2LPnjJ1dVNP5k9rtmusS3jV3B28N+FFKHtKDFXI4J/6bvboTUA
         NCUJ/SrXz6dZC+K7HTNn67w+w6tr6HMctMAOztdLSvREHKZnadDk2nvVpANChs39DL8S
         1P8Al8d8oeLdZwAagTQgkZqSxTHtFELOisnNQcBfDzR7km6qfSeIts3NwuRO6hxPGDrt
         +0OMTNulOvDzjM8rj1ZurYnVZOva5WIS5zijD9UyqOmmvttsOpwoGT97scamOh5gM4D4
         Bfqg==
X-Gm-Message-State: AOJu0YwhlYrsijFsPxdBwRtnH0mZB1eIqApe8pXw9fbg7eIz0fq+n5+c
        vPpOAW/+uO7rN2AcqOjOv4WYezCEL8SiqA==
X-Google-Smtp-Source: AGHT+IEqmcv0+BO+OsydnRy7mpJugz1CzqnxESYnXayFM1Uygg2LGblIvm6JA02GOKRDFKH0J43qHQ==
X-Received: by 2002:a17:906:225b:b0:9a1:b144:30f0 with SMTP id 27-20020a170906225b00b009a1b14430f0mr6563294ejr.53.1695655537624;
        Mon, 25 Sep 2023 08:25:37 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:105a:e25e:7421:a01e:ee4a:ba03])
        by smtp.gmail.com with ESMTPSA id f1-20020a17090624c100b009ae3e6c342asm6432045ejb.111.2023.09.25.08.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 08:25:36 -0700 (PDT)
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
Subject: [PATCH v7 1/9] pack-objects: allow `--filter` without `--stdout`
Date:   Mon, 25 Sep 2023 17:25:09 +0200
Message-ID: <20230925152517.803579-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.279.g57b2ba444c
In-Reply-To: <20230925152517.803579-1-christian.couder@gmail.com>
References: <20230911150618.129737-1-christian.couder@gmail.com>
 <20230925152517.803579-1-christian.couder@gmail.com>
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
2.42.0.279.g57b2ba444c

