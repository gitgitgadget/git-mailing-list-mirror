Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57915C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 04:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbiCAEmX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 23:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbiCAEmT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 23:42:19 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271D56E2BC
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 20:41:38 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id k130-20020a628488000000b004f362b45f28so9006444pfd.9
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 20:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=psWNFvxVHzRNwn7LAZ1WWs1LyNdO3zDnyzLnegifRc4=;
        b=HH4/Xbq9xpXIOhLTAVxcuha1fO59qEwSHoRz5dUCZAKynAUmWaO3+5nEK9+z1bKZdq
         AQDYmnT6sZmiphEq7gc/PjdIsa7V7cW2vLnuDJemDTfmWR4A/Ipw0OVd3/+zmE/iOXto
         dnogociS0ytgkyx8M4axh2B8JS7b5jsyDXVfLGeGJtMeb9NWWyzL4CI6slEwZcfQkk9W
         RM1+YUW+0FCKwbl2iKCF1OrdpXdpCTyRL550wsq4Nk3yvBnUHBC7HMkGNh7jv9Zaw6F6
         HJh59go+4/TVOTwWNnVL9ktRUOfm91QC7yvViQFdVZdybJV0ABFx3T5DtjL0YGr8a27c
         dPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=psWNFvxVHzRNwn7LAZ1WWs1LyNdO3zDnyzLnegifRc4=;
        b=HhFx3hbgqadYDYaR7yQYZSk5eB9VzMznJGuZ/TFglkZpO91b+5npAP/e9ukSqZS3cg
         vAI9COft56B9Xg40wV1v7LjCHGllru1NDHXcmXPw+4659QKPfYRDOJRjytaEd2FRIzlb
         POsrDsGLvi56oJGApKViGVIiv/hKGkixWOGpjS6BdDK4MovvMbp9vJBmwSGQb0SJIkwa
         2BrFRM53/RT2Ar/TT0lc9/R6Lnxrfjsbp3DmPw/3dphXskNy+YHh12jtD/bUmZrx1H7/
         BLm8tyE5iz5uCdJV1JALF90TWKVyStFJiXIm5+ZqXVsQqx997XZnEQmBrYwIIfFWJDp7
         mbFw==
X-Gm-Message-State: AOAM533quOOik3Xn1UVOCKsho9N0u3DCp0G/JsXtg5jgvPNtZGnXE+rN
        WEZQwm+U6NLNgYfuHAaARbLK7jgb5JtvGUQqTWTUKEteSe+AiHabgeAmuo/UVolZgl+v68aRndT
        MSqBnPitn+Z4OAhtaAWLQI1hR2e6pj+6vQIg9p9NKbXXRBSJQYPKtDnz5gdGzO60=
X-Google-Smtp-Source: ABdhPJw2WMvKqVDWmrMcoWXOgMdU0AANd+ZiIaL/Whl87f16mIDAEY3TAyLljXCxGqwQAUp1q+7SgNHAjujdsQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:ea02:b0:14f:fd0e:e433 with SMTP
 id s2-20020a170902ea0200b0014ffd0ee433mr24621306plg.24.1646109697606; Mon, 28
 Feb 2022 20:41:37 -0800 (PST)
Date:   Mon, 28 Feb 2022 20:41:20 -0800
In-Reply-To: <20220301044132.39474-1-chooglen@google.com>
Message-Id: <20220301044132.39474-2-chooglen@google.com>
Mime-Version: 1.0
References: <20220301000816.56177-1-chooglen@google.com> <20220301044132.39474-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v2 01/13] submodule tests: test for init and update failure output
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

Amend some submodule tests to test for the failure output of "git
submodule [update|init]". The lack of such tests hid a regression in
an earlier version of a subsequent commit.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Glen Choo <chooglen@google.com>
---
 t/t7406-submodule-update.sh    | 14 ++++++++++++--
 t/t7408-submodule-reference.sh | 14 +++++++++++++-
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 11cccbb333..7764c1c3cb 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -205,8 +205,18 @@ test_expect_success 'submodule update should fail due =
to local changes' '
 	 (cd submodule &&
 	  compare_head
 	 ) &&
-	 test_must_fail git submodule update submodule
-	)
+	 test_must_fail git submodule update submodule 2>../actual.raw
+	) &&
+	sed "s/^> //" >expect <<-\EOF &&
+	> error: Your local changes to the following files would be overwritten b=
y checkout:
+	> 	file
+	> Please commit your changes or stash them before you switch branches.
+	> Aborting
+	> fatal: Unable to checkout OID in submodule path '\''submodule'\''
+	EOF
+	sed -e "s/checkout $SQ[^$SQ]*$SQ/checkout OID/" <actual.raw >actual &&
+	test_cmp expect actual
+
 '
 test_expect_success 'submodule update should throw away changes with --for=
ce ' '
 	(cd super &&
diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.s=
h
index a3892f494b..c3a4545510 100755
--- a/t/t7408-submodule-reference.sh
+++ b/t/t7408-submodule-reference.sh
@@ -193,7 +193,19 @@ test_expect_success 'missing nested submodule alternat=
e fails clone and submodul
 		cd supersuper-clone &&
 		check_that_two_of_three_alternates_are_used &&
 		# update of the submodule fails
-		test_must_fail git submodule update --init --recursive
+		cat >expect <<-\EOF &&
+		fatal: submodule '\''sub'\'' cannot add alternate: path ... does not exi=
st
+		Failed to clone '\''sub'\''. Retry scheduled
+		fatal: submodule '\''sub-dissociate'\'' cannot add alternate: path ... d=
oes not exist
+		Failed to clone '\''sub-dissociate'\''. Retry scheduled
+		fatal: submodule '\''sub'\'' cannot add alternate: path ... does not exi=
st
+		Failed to clone '\''sub'\'' a second time, aborting
+		fatal: Failed to recurse into submodule path ...
+		EOF
+		test_must_fail git submodule update --init --recursive 2>err &&
+		grep -e fatal: -e ^Failed err >actual.raw &&
+		sed -e "s/path $SQ[^$SQ]*$SQ/path .../" <actual.raw >actual &&
+		test_cmp expect actual
 	)
 '
=20
--=20
2.33.GIT

