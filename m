Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3DDC001B0
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 08:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjGXI7l (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 04:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjGXI7k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 04:59:40 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A7D131
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 01:59:38 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99313a34b2dso604429766b.1
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 01:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690189176; x=1690793976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNnA5sq63goWK4I7oOX1pcAAlYWE4QpX14QVrUxDLFU=;
        b=IjscgxCFw5dhgpl8ZgGTI5sDrAbbAWU+I1E+TLJnaHPU0ei9Serh+pq/fWzuUYkLcP
         qcppxlUqmTmx/YD6zdYcNY/J6ezR00Ne6+9eLV8ug79Sce+HDc/OOwuqfh5fVaNy4TBh
         1r8+pbAOwMIiikAziOFf+pQLitiLecv41rqw9LFsT/ozCobLTF0wO/NdxJ06J1+hPtYo
         oThku+9df1AxEdp4nobv0QEYd87W2PwqFC3XCQF0TyCkY8ykxeQpWJB9qqwJLbz8tQD/
         RxRCAXAVsxTZMRYVVVNjBqXulCewnFHJE2ioqmfjLpSX0uaMUNl5nZlA8pyLX+Mqu/ej
         XQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690189176; x=1690793976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNnA5sq63goWK4I7oOX1pcAAlYWE4QpX14QVrUxDLFU=;
        b=J2nwEgSp04nCZNUJuXH0SFWwE3P1NE5u3Heat6t7BwY90dFoCa5bv1Kugji47VO5Y8
         ws9vyYnkUFaR3iSwUiAGqkQ960IXJ+pehMPizrVuhGbpDt07zlvle0UmSjwrqT5UhVcn
         8FnmZoOchn8GYWEsCXPRlBVf6n0ktz6zZ/7k6N+Ti319h8en4+hPXjSu8busGM0pVj1D
         rdKUIfSz550szs3/HqQue0dB4dmQ9vAtXmXRKvB9GxD4FbWcfUcDbzWJtZiEfQwT1UHu
         vBea9CanplSEtwwJZxQDjDR2DqKy6mg2uCUcSt0Ghp8pm/dn4Fto+KzZ123AI4f7Y1s4
         ifAg==
X-Gm-Message-State: ABy/qLZ5TYQ6UrOUwcwl3qOWDtOZ39dmBiG2wgF63C0uw07a0y+gBR36
        rPD2xu9GsFHrFJtiJ1yQfLEQ5IYVx3w=
X-Google-Smtp-Source: APBJJlHICxi+1EsFc2dBC1J0U3emIQu2VXdquCH+/6zZD/FNDHWb/rHIBmyR5AwVebEeamHZsoErtA==
X-Received: by 2002:a17:906:8a73:b0:994:47a5:a377 with SMTP id hy19-20020a1709068a7300b0099447a5a377mr9084752ejc.24.1690189175846;
        Mon, 24 Jul 2023 01:59:35 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:11c4:4096:3d09:3950:f280:5ec1])
        by smtp.gmail.com with ESMTPSA id rv7-20020a17090710c700b00993a9a951fasm6506665ejb.11.2023.07.24.01.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 01:59:34 -0700 (PDT)
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
Subject: [PATCH v3 1/8] pack-objects: allow `--filter` without `--stdout`
Date:   Mon, 24 Jul 2023 10:59:02 +0200
Message-ID: <20230724085909.3831831-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.41.0.384.ged66511823
In-Reply-To: <20230724085909.3831831-1-christian.couder@gmail.com>
References: <20230705060812.2865188-1-christian.couder@gmail.com>
 <20230724085909.3831831-1-christian.couder@gmail.com>
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
index 06b33d49e9..7fca27ffbe 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4387,12 +4387,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
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
2.41.0.384.ged66511823

