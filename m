Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C825FEB64D8
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 19:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbjFNT0I (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 15:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjFNT0G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 15:26:06 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DAA213B
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 12:26:04 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f61d79b0f2so9569839e87.3
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 12:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686770762; x=1689362762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVT5qFgLsiqhkfE3Cc6h/3DFtc2WMznuyH276ymzcc0=;
        b=Boxy/Wko0rN4/r0neafpjjiiD83Zm8OJUV3/v8Kpuicwy5gS/7+gijqEQ05UsoT1dR
         G2jjtmD6aZhuRrbfmYfWJNjkUo3a8q5s4VhtebzKWgi2kFdMWCtvH4KiOpcdCSAgRD/4
         YYTwlxVV2/8UCah3y9VeB8p/RvbjT4WjpYCpKdFjql/G27jr+YwMCaMibfu8dQplYV4u
         EstDXta23cXPfJMWhpzjxKZTrbvRLtJ2WYoTgV3KygCHzW+Y+0hw/kY18a+U6AyAfppU
         kMm7gGxH+vkYJNxvlz7lltZhRZ/M2Yn7Rseg9JK7Ll5eXMErOyjwbjV7wd9vkZnT041t
         ZaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686770762; x=1689362762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iVT5qFgLsiqhkfE3Cc6h/3DFtc2WMznuyH276ymzcc0=;
        b=Ag2ISSXlg08zW/B3wSnrjVyPQMmBjpuOnSzwughR410IkEVP1xTB+dP/9hCDqC8AfW
         ukoDHRK7hWlFb9To5Ufzc61/8Z6wwEADm6QgYshSxPQFS03gTReSkG4mD5Am4H9rthWt
         s2n5jFD/qjEovgu/0i2t6HMKhaDKklA0eWUSpu6f3IjWRvRn/xOEuEdMTwciJjuI1efz
         LIkhdrziYz7wKxW3X9G2quO7lXClU74SVTEcyAjtoyV9j2PyZLso/iUO78uvC4xKu+Ye
         5cSJ9DAoOy83pcn5q9WRwWP6FdHXjcab1OV2a/JTqIS9y1hMvOBuTa6x7sDETDl0ricd
         6oIA==
X-Gm-Message-State: AC+VfDy0/MUyt6V3aF6MDNnHZ/aCX9d+KEvhtTnVzAjjfYNCQh38jmKt
        i+kc0b7CWq5NrT6fY78nPsthOFrFvPM=
X-Google-Smtp-Source: ACHHUZ6xhHhq63Y0ZE2TgGojmx2XGy7Cs7xdhmVSW3Yl5v5n0qZGVSjwIUpfSAKTnGHnoXC3MiorUg==
X-Received: by 2002:a19:f00a:0:b0:4f3:b883:fc4e with SMTP id p10-20020a19f00a000000b004f3b883fc4emr7458173lfc.43.1686770761742;
        Wed, 14 Jun 2023 12:26:01 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:e164:efe0:8fdb:6ba])
        by smtp.gmail.com with ESMTPSA id u26-20020a05600c00da00b003eddc6aa5fasm18370365wmm.39.2023.06.14.12.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 12:26:01 -0700 (PDT)
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
Subject: [PATCH 1/9] pack-objects: allow `--filter` without `--stdout`
Date:   Wed, 14 Jun 2023 21:25:33 +0200
Message-ID: <20230614192541.1599256-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.41.0.37.gae45d9845e
In-Reply-To: <20230614192541.1599256-1-christian.couder@gmail.com>
References: <20230614192541.1599256-1-christian.couder@gmail.com>
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
 Documentation/git-pack-objects.txt | 4 ++--
 builtin/pack-objects.c             | 8 ++------
 2 files changed, 4 insertions(+), 8 deletions(-)

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
index 9cfc8801f9..af007868c1 100644
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
-- 
2.41.0.37.gae45d9845e

